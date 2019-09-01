// t45	attiny45	76800 prog
// board	MMCU		programm_after_make
//38400

// подразумевается, что помимо функции "избранного" тут будет возможность менять скорость режимов
// вроде, даже работает

#include <avr/io.h>
#include <avr/eeprom.h>
//#include <avr/eeprom.h>
// Hardware ===========================================================
// LEDs ---------------------------------------------------------------
#define LED_PORT	PORTB
#define LED_DDR		DDRB

#define LED_1		1
#define	LED_2		0
#define	LED_3		2

// Buttons ------------------------------------------------------------
#define BUTTON_PIN	PINB
#define BUTTON_1		4
#define BUTTON_2		3

// Logic ==============================================================
// values for PWM -----------------------------------------------------
#define ALL_STEPS	20				
#define LIGHT_1		(ALL_STEPS-0)
#define LIGHT_2		(ALL_STEPS-0)
#define LIGHT_3		(ALL_STEPS-0)
#define HALF_LIGHT	5

// modes
#define MODE_NUM	9
#define S_NUM		7
#define BLACK		0	//position of black color (needs to make strobs)

unsigned char mode;
unsigned char serie;

unsigned char stat;
//unsigned char halt;

//buttons
#define PRESSED			1
#define NOT_PRESSED		0

#define INC_DELAY	14
#define S_DELAY		700
#define W_FAV_DELAY	3000
#define T_FAV_DELAY	10000
#define CLEAR_DELAY 18000
#define HALT_DELAY  18000
unsigned char process_button( unsigned int hold, unsigned char state, unsigned char but_n );
unsigned char check_button();

// actions ============================================================
unsigned char make_light( unsigned char r, unsigned char g, unsigned char b );
unsigned char l_make_light( unsigned char r, unsigned char g, unsigned char b, unsigned char tt );
unsigned char make_color( unsigned char c ); // (simple colors)

unsigned char long_color( unsigned int time, unsigned int c ); // (simple colors)
unsigned char make_strob( unsigned int time1, unsigned int time2, unsigned char color );


EEMEM unsigned char	e_mode;
EEMEM unsigned char	e_serie;

// fav utils
#define FAV_MAX  15
#define DEFAULT_SPEED	31
#define DEFAULT_SPEED_STEP	3

unsigned char modes[FAV_MAX+1];
unsigned char series[FAV_MAX+1];
unsigned char counter;
unsigned char pointer;
unsigned char fav_on;

EEMEM unsigned char	fm[FAV_MAX+1];
EEMEM unsigned char	sm[FAV_MAX+1];
EEMEM unsigned char e_counter;
EEMEM unsigned char e_pointer;
EEMEM unsigned char e_fav_on;

// multispeed utils
EEMEM unsigned char speedm[FAV_MAX+1];
unsigned char speed[FAV_MAX+1];

//--------- main part -------------------------------------------------------------------------
void make_serie(unsigned char s, unsigned char m, unsigned char spd );

void check_all(){
	if (mode>MODE_NUM){
		mode=1;
	}
	
	if (serie>S_NUM){
		serie=1;
	}
	
	if (serie<0){
		serie=1;
	}	
	
	unsigned char i;
	for (i=0; i<FAV_MAX; i++){
		if (modes[i]>MODE_NUM) modes[i]=1;
		if (series[i]>S_NUM) series[i]=1;
		if (speed[i]==0) speed[i]=1 ;
	}
	
	if (counter>FAV_MAX) counter=0;
	if (pointer>=counter) pointer=counter;
	
	if (fav_on>1) fav_on=0;
	
}

void read_data(){
	mode = eeprom_read_byte(&e_mode);//Чтение
	serie = eeprom_read_byte(&e_serie);//Чтение
	
	eeprom_read_block(modes, fm, FAV_MAX+1);	// избранное
	eeprom_read_block(series, sm, FAV_MAX+1);
	
	eeprom_read_block(speed, speedm, FAV_MAX+1);	// скорость
	
	pointer = eeprom_read_byte(&e_pointer);//Чтение		
	counter = eeprom_read_byte(&e_counter);//Чтение		
	fav_on = eeprom_read_byte(&e_fav_on);//Чтение		
	
	
}

void store_data(){
	eeprom_write_byte(&e_mode,   mode);//Запись
	eeprom_write_byte(&e_serie,   serie);//Запись
	 
	eeprom_write_block(modes, fm, FAV_MAX+1);	// избранное
	eeprom_write_block(series, sm, FAV_MAX+1);
	
	eeprom_write_block(speed, speedm, FAV_MAX+1);	// скорость
	
	eeprom_write_byte(&e_pointer,  pointer);//Запись	
	eeprom_write_byte(&e_counter,  counter);//Запись	
	eeprom_write_byte(&e_fav_on,   fav_on);//Чтение	
}

int main(){
	read_data();
	check_all();
	
	LED_DDR = (1<<LED_1) | (1<<LED_2) | (1<<LED_3) | (0<<BUTTON_1) | (0<<BUTTON_2);	
	LED_PORT = (1<<LED_1) | (1<<LED_2) | (1<<LED_3) | (1<<BUTTON_1) | (1<<BUTTON_2);	
	
	stat=0;
	//fav_on=0;
	
	while(1){
		//check_mode();
		if (stat==0) {
			if (fav_on==0){
				make_serie(serie, mode, DEFAULT_SPEED);
			} else {
				if (counter>0){
					make_serie( series[pointer], modes[pointer], speed[pointer]);	// there should be reading from fav
				} else {
					make_color(0);
				}
			}
		} else if (stat==10) {	// add to fav
			make_color(10);
		} else if (stat==11) {	// toggle to/from fav
			make_color(11);
		} else if (stat==12) {	// clear favourite
			make_color(12);
		} else if (stat==13) {	// clear favourite
			make_color(13);
		} else if (stat==14) {	// clear favourite
			make_strob(50,100,1);
		} else{	
			make_color(0);
			stat=0;
		} 
		
	}
}


unsigned char process_button( unsigned int hold, unsigned char state, unsigned char but_n){
	if (but_n==1){
		if ( hold > CLEAR_DELAY ){	// //clear favorite
			stat=12;
			if ( state == NOT_PRESSED ){
				pointer=0;
				counter=0;
				fav_on=0;
		
				check_all();
				store_data();	//Запись
				stat=0;
				return 1;
			}
		}  else if ( hold > T_FAV_DELAY ){	// // toggle to/from favorite
			stat=11;
			if ( state == NOT_PRESSED ){
				// toggle to/from favorite
				if (fav_on==0){
					fav_on=1;
					pointer=1;
				} else {
					fav_on=0;
				}	
				
				check_all();
				store_data();	//Запись
				stat=0;
				return 1;
			}		
		}  else if ( hold > W_FAV_DELAY ){	// //	write mode to favorite
			if (fav_on==0 && counter<FAV_MAX){
				stat=10;
				if ( state == NOT_PRESSED ){	//	write mode to favorite
					if (counter<FAV_MAX) {
						counter++;
						modes[counter]=mode;
						series[counter]=serie;
						speed[counter]=DEFAULT_SPEED;	// set speed to default
					} 
					
					check_all();
					store_data();	//Запись
					stat=0;
					return 1;
				}		
			} 
		}  else if ( hold > S_DELAY ){	// next serie
			if (fav_on==0){
				stat=13;
				if (fav_on==0){
					if ( state == NOT_PRESSED && fav_on==0 ){
						if (++serie>S_NUM){
							serie=1;
						} 			
						mode=1;
						store_data();	//Запись
						stat=0;
						return 1;
					}	
				}
			}	
		}  else if ( hold > INC_DELAY ){	// next mode
			if ( state == NOT_PRESSED ){
				if ( fav_on==0 ) {
					if (++mode>MODE_NUM) { 
						mode=1; 
					}
				} else {
					if (++pointer>counter) { 
						pointer=1; 
					}
				}
				
				check_all();
				store_data();	//Запись
				return 1;
			}
		}
	} else if (but_n==2 && fav_on==1){
		if ( hold > W_FAV_DELAY ){	// //	set speed to default
			stat=10;
			if ( state == NOT_PRESSED ){
				speed[pointer]=DEFAULT_SPEED;	// set speed to default
				
				check_all();
				store_data();	//Запись
				stat=0;
				return 1;
			}
		}  else if ( hold > S_DELAY ){	// next serie
			if ( state == NOT_PRESSED ){
				speed[pointer]-=DEFAULT_SPEED_STEP;
				check_all();
				store_data();	//Запись
				stat=0;
				return 1;
			}
		}  else if ( hold > INC_DELAY ){	// next mode
			if ( state == NOT_PRESSED ){
				speed[pointer]+=DEFAULT_SPEED_STEP;
				
				check_all();
				store_data();	//Запись
				stat=0;
				return 1;
			}
		}
	}
	
	return 0;
}

#define PULSW_SPEED	1
unsigned char basic_pulse( unsigned char r, unsigned char g, unsigned char b, unsigned char rr, unsigned char gg, unsigned char bb,  unsigned int tt){
	unsigned char  i;
	for (i=1; i<=ALL_STEPS; i++){
		if ( l_make_light( (i&r)|rr, (i&g)|gg, (i&b)|bb , tt)==1 || stat!=0)  return 1;			 	// red >> yellow
	}
	for (i=ALL_STEPS; i>0; i--){
		if ( l_make_light( (i&r)|rr, (i&g)|gg, (i&b)|bb , tt)==1 || stat!=0)  return 1;			 	// red >> yellow
	}	
	return 0;
}



unsigned char make_pulse( unsigned char c, unsigned char spd){
	switch (c){
		case 1: 
			return basic_pulse( 255, 0, 0, 0,0,0, spd );	//red
			break;
		case 2:
			return basic_pulse( 255, 255, 0,0,0,0, spd );	//yellow
			break;
		case 3:
			return basic_pulse( 0, 255, 0,0,0,0, spd );	//green
			break;
		}
		
		switch (c){
		case 4:
			return basic_pulse( 0, 255, 255,0,0,0, spd );	//
			break;
		case 5:
			return basic_pulse( 0, 0, 255,0,0,0, spd );	//blue
			break;
		case 6:
			return basic_pulse( 255, 0, 255,0,0,0, spd );	//dark blue
			break;	
		}
		
		switch (c){
		case 7:
			return basic_pulse( 255, 255, 255,0,0,0, spd );	//violet
			break;
		case 8:
			return basic_pulse( 255, 7, 0, 255,0,0, spd );	//pink
			break;
		case 9:
			return basic_pulse( 255, 0, 7, 25,0,0, spd );	//white
			break;
		}
	return 0;
}

void make_grad( unsigned int tt ){
	unsigned int i;
	for (i=0; i<=ALL_STEPS; i++){
		if ( l_make_light(ALL_STEPS,i,0, tt )==1 ||stat!=0)  return;			 	// red >> yellow
	}
	for (i=1; i<=ALL_STEPS; i++){
		if ( l_make_light(ALL_STEPS-i, ALL_STEPS,0, tt )==1 || stat!=0) return; 	// yellow >> green
	}
	for (i=1; i<=ALL_STEPS; i++){
		if ( l_make_light(0, ALL_STEPS, i, tt )==1 || stat!=0) return;			// green >> blue
	}
	for (i=1; i<=ALL_STEPS; i++){
		if ( l_make_light(0, ALL_STEPS-i, ALL_STEPS, tt )==1 || stat!=0) return;  // blue >> dark blue
	}
	for (i=1; i<=ALL_STEPS; i++){	
		if ( l_make_light(i,0,ALL_STEPS, tt )==1 || stat!=0) return;				// dark blue >> violet
	}
	for (i=1; i<=ALL_STEPS; i++){				
		if ( l_make_light(ALL_STEPS,0,ALL_STEPS-i, tt )==1 || stat!=0) return;			// violet >> red
	}
	return;
}

void make_grad_2( unsigned int tt ){
	unsigned int i;
	for (i=1; i<10; i++){
		if ( long_color( tt, i )==1 ||stat!=0)  return;			 	// red >> yellow
	}
	return;
}

void grad_serie( unsigned char m, unsigned char spd ){
	unsigned int i;
	switch (m){
		case 1: 
			make_grad(1*spd );	//
			return;
		case 2:
			make_grad( 5*spd );	//
			return;
		case 3:
			make_grad( 15*spd );	//
			return;
		case 4:
			make_grad( 50*spd );	//
			return;
		case 5:
			make_grad( 150*spd );	//
			return;
	}
		
	switch (m){
		case 6:
			make_grad_2( 10*spd );	//dark blue
			return;
		case 7:
			make_grad_2( 40*spd );	//violet
			return;
		case 8:
			make_grad_2( 120*spd );	//pink
			return;
		case 9:
			for (i=1; i<9; i++){
				if ( long_color( 5*spd, i )==1 ||stat!=0)  return;			 	// red >> yellow
			}
			return;
	}
	return;
}

void make_complex_strob(unsigned char m, unsigned char spd){
	switch (m){
		case 1: 
			if ( make_strob(spd,spd, 1)==1 || stat!=0 ) return;	//
			if ( make_strob(spd,spd, 4)==1 || stat!=0 ) return;	//
			return;
		case 2:
			if ( make_strob(spd,spd, 4)==1 || stat!=0 ) return;	//
			if ( make_strob(spd,spd, 6)==1 || stat!=0 ) return;	//
			return;
		case 3:
			if ( make_strob(spd,spd, 6)==1 || stat!=0 ) return;	//
			if ( make_strob(spd,spd, 1)==1 || stat!=0 ) return;	//
			return;
		case 4:
			if ( make_strob(spd,spd, 2)==1 || stat!=0 ) return;	//
			if ( make_strob(spd,spd, 5)==1 || stat!=0 ) return;	//
			return;
		case 5:
			if ( make_strob(spd,spd, 1)==1 || stat!=0 ) return;	//
			if ( make_strob(spd,spd, 4)==1 || stat!=0 ) return;	//
			if ( make_strob(spd,spd, 6)==1 || stat!=0 ) return;	//
			return;
	}
		
	switch (m){
		case 6:
			if ( make_strob(spd,spd, 1)==1 || stat!=0 ) return;	//
			if ( make_strob(spd,spd, 9)==1 || stat!=0 ) return;	//
			return;
		case 7:
			if ( make_strob(spd,spd, 4)==1 || stat!=0 ) return;	//
			if ( make_strob(spd,spd, 9)==1 || stat!=0 ) return;	//
			return;
		case 8:
			if ( make_strob(spd,spd, 6)==1 || stat!=0 ) return;	//
			if ( make_strob(spd,spd, 9)==1 || stat!=0 ) return;	//
			return;
		case 9:
			if ( make_strob(spd,spd, 1)==1 || stat!=0 ) return;	//
			if ( make_strob(spd,spd, 9)==1 || stat!=0 ) return;	//
			if ( make_strob(spd,spd, 4)==1 || stat!=0 ) return;	//
			if ( make_strob(spd,spd, 9)==1 || stat!=0 ) return;	//
			if ( make_strob(spd,spd, 6)==1 || stat!=0 ) return;	//
			if ( make_strob(spd,spd, 9)==1 || stat!=0 ) return;	//
			return;
	}	
	return;
}

void make_mix( unsigned char m, unsigned char spd ){
	switch (m){
		case 1: 
			if ( long_color(spd, 1)==1 || stat!=0 ) return;	//
			if ( long_color(spd, 4)==1 || stat!=0 ) return;	//
			return;
		case 2:
			if ( long_color(spd, 4)==1 || stat!=0 ) return;	//
			if ( long_color(spd, 6)==1 || stat!=0 ) return;	//
			return;
		case 3:
			if ( long_color(spd, 6)==1 || stat!=0 ) return;	//
			if ( long_color(spd, 1)==1 || stat!=0 ) return;	//
			return;
		case 4:
			if ( long_color(spd, 2)==1 || stat!=0 ) return;	//
			if ( long_color(spd, 5)==1 || stat!=0 ) return;	//
			return;
		case 5:
			if ( long_color(spd, 1)==1 || stat!=0 ) return;	//
			if ( long_color(spd, 2)==1 || stat!=0 ) return;	//
			return;
	}
		
	switch (m){
		case 6:
			if ( long_color(spd, 0)==1 || stat!=0 ) return;	//
			if ( long_color(spd, 1)==1 || stat!=0 ) return;	//
			if ( long_color(spd, 4)==1 || stat!=0 ) return;	//
			if ( long_color(spd, 1)==1 || stat!=0 ) return;	//
			return;
		case 7:
			if ( long_color(spd, 0)==1 || stat!=0 ) return;	//
			if ( long_color(spd, 1)==1 || stat!=0 ) return;	//
			if ( long_color(spd, 6)==1 || stat!=0 ) return;	//
			if ( long_color(spd, 1)==1 || stat!=0 ) return;	//
			return;
		case 8:
			if ( long_color(spd, 0)==1 || stat!=0 ) return;	//
			if ( long_color(spd, 9)==1 || stat!=0 ) return;	//
			if ( long_color(spd, 6)==1 || stat!=0 ) return;	//
			if ( long_color(spd, 4)==1 || stat!=0 ) return;	//
			return;
		case 9:
			if ( long_color(spd, 0)==1 || stat!=0 ) return;	//
			if ( long_color(spd, 4)==1 || stat!=0 ) return;	//
			if ( long_color(spd, 6)==1 || stat!=0 ) return;	//
			if ( long_color(spd, 4)==1 || stat!=0 ) return;	//
			return;
	}		
	return;
}

unsigned char make_saw( unsigned char r, unsigned char g, unsigned char b, unsigned char spd){
	unsigned char i;
	for(i=0; i<ALL_STEPS; i++){
		if ( l_make_light(r*i, g*i, b*i, spd) == 1 || stat!=0 ) return 1;
	}
	return 0;
}

void make_saw_rainbow(){
	unsigned char i;
	for(i=0; i<ALL_STEPS; i++){
		if ( l_make_light( ALL_STEPS, ALL_STEPS-i, ALL_STEPS-i, 2 ) == 1 || stat!=0 ) return;	// white to red
	}
	for(i=0; i<ALL_STEPS; i++){
		if ( l_make_light( ALL_STEPS, i, 0, 2 ) == 1 || stat!=0 ) return;	// red to yellow
	}	
	for(i=0; i<ALL_STEPS; i++){
		if ( l_make_light( ALL_STEPS-i, ALL_STEPS, 0, 2 ) == 1 || stat!=0 ) return ;	// yellow to green
	}	
	for(i=0; i<ALL_STEPS; i++){
		if ( l_make_light( 0, ALL_STEPS, i, 2 ) == 1 || stat!=0 ) return ;	// green to green-blue
	}	
	for(i=0; i<ALL_STEPS; i++){
		if ( l_make_light( 0, ALL_STEPS-i, ALL_STEPS, 2 ) == 1 || stat!=0 ) return ;	// green-blue to blue
	}
	for(i=0; i<ALL_STEPS; i++){
		if ( l_make_light( 0, 0, ALL_STEPS-i, 2 ) == 1 || stat!=0 ) return ;	// blue to dark
	}
	l_make_light(0,0,0,10);
}

void make_mix_2( unsigned char m, unsigned char spd ){
	switch (m){
		case 1: 
			if ( make_saw(1, 0, 0, spd)==1 || stat!=0 ) return;	//
			return;
		case 2:
			if ( make_saw(0, 1, 0, spd)==1 || stat!=0 ) return;	//
			return;
		case 3:
			if ( make_saw(0, 0, 1, spd)==1 || stat!=0 ) return;	//
			return;
		case 4:
			if ( make_saw(1, 1, 1, spd)==1 || stat!=0 ) return;	//
			return;
		case 5:
			if ( make_saw(1, 0, 0, spd)==1 || stat!=0 ) return;	//
			if ( make_saw(0, 1, 0, spd)==1 || stat!=0 ) return;	//
			return;
	}
		
	switch (m){
		case 6:
			if ( make_saw(1, 0, 0, spd)==1 || stat!=0 ) return;	//
			if ( make_saw(0, 0, 1, spd)==1 || stat!=0 ) return;	//
			return;
		case 7:
			return make_grad( 100*spd );
		case 8:

			return make_grad_2( spd );	//
		case 9:
			make_saw_rainbow();
			return;
	}		
}

unsigned char make_light_color( unsigned char c ){
		switch (c){
		case 1: 
			l_make_light(0,0,0,10);
			return make_light( 0, 0, 0 );	//red
		case 2:
			l_make_light(0,0,0,10);
			return make_light( 1, 0, 0 );	//orange
		case 3:
			l_make_light(0,0,0,10);
			return make_light( 1, 1, 0 );	//yellow
		}
		
		switch (c){
		case 4:
			l_make_light(0,0,0,10);
			return make_light( 0, 1, 0 );	//green
		case 5:
			l_make_light(0,0,0,10);
			return make_light( 0, 1, 1 );	//blue
		case 6:
			l_make_light(0,0,0,10);
			return make_light( 0, 0, 1 );	//dark blue
		}
		
		switch (c){
		case 7:
			l_make_light(0,0,0,10);
			return make_light( 1, 0, 1 );	//violet
		case 8:
			l_make_light(0,0,0,10);
			return make_light( 1, 1, 1 );	//pink
		case 9:
			return make_light( 1, 1, 1 );	//white
		}
	return 0;
}

void make_serie(unsigned char s, unsigned char m, unsigned char spd ){
	switch (s){
		case 1:
			make_color(m);
			return;
		case 2:
			make_strob(spd, spd, m);
			return;
		case 3:
			make_pulse(m, spd);
			return;
		case 4:
			make_complex_strob(m, spd);
			return;
		case 5:
			make_mix(m, spd);
			return;
		case 6:
			make_mix_2(m, spd);
			return;	
		case 7:
			make_light_color(m);
			return;	
		default:
			make_color(0);
			check_all();
			return;
	}
		
}


unsigned char make_light( unsigned char r, unsigned char g, unsigned char b ){
	unsigned char i;
	unsigned char p;

	for(i=0; i<ALL_STEPS; i++){
		p=(1<<BUTTON_1) + (1<<BUTTON_2);
		if (i<r){
			p = p | (1<<LED_1);
		}
		if (i<g){
			p = p | (1<<LED_2);
		}
		if (i<b){
			p = p | (1<<LED_3);
		}				
		LED_PORT=p;
	}
	
	return check_button();
}

unsigned char l_make_light( unsigned char r, unsigned char g, unsigned char b, unsigned char tt ){
	unsigned int i, ttt;
	ttt=tt*10;
	
	make_light( r, g, b );
	for(i=0; i<ttt; i++){
		if ( make_light( r, g, b ) == 1) return 1;
	}
	return 0;
}

unsigned char make_strob( unsigned int time1, unsigned int time2, unsigned char color ){
	if ( long_color( time1, color)==1 || stat!=0 ) return 1 ;
	if ( long_color( time2, 0    )==1 || stat!=0 ) return 1 ;

	return 0;
}


unsigned char check_button(){
	
	static unsigned int hold=0;
	static unsigned char button_state=NOT_PRESSED;
	static unsigned char last_button_state=NOT_PRESSED;
	
	unsigned char	st=BUTTON_PIN;
	unsigned char res=0;
	
	button_state=NOT_PRESSED;
	static unsigned char but_n=0;
	
	if ( ( (st &  (1<<BUTTON_1))  == (0<<BUTTON_1) ) ) {
		button_state = PRESSED;
		but_n=1;
	}
	
	if ( ( (st &  (1<<BUTTON_2)) == (0<<BUTTON_2) ) ){
		button_state = PRESSED;
		but_n=2;
	}
	
	
	if ( button_state == PRESSED ){
		hold++;
	}
	
	if ( last_button_state == button_state ){
		res = process_button( hold, button_state, but_n );
		/*if (res==1) {
			hold=0;
			but_n=0;
		}*/
	}
	
	if ( button_state == NOT_PRESSED &&  last_button_state == NOT_PRESSED ){
		hold=0;
		but_n=0;
	}
	
	last_button_state=button_state;
	return res;
	
}
//---*********-----

unsigned char make_color( unsigned char c ){
		switch (c){
		case 1: 
			return make_light( LIGHT_1, 0, 0 );	//red
		case 2:
			return make_light( LIGHT_1, HALF_LIGHT, 0 );	//orange
		case 3:
			return make_light( LIGHT_1, LIGHT_2, 0 );	//yellow
		}
		
		switch (c){
		case 4:
			return make_light( 0, LIGHT_2, 0 );	//green
		case 5:
			return make_light( 0, HALF_LIGHT, LIGHT_3 );	//blue
		case 6:
			return make_light( 0, 0, LIGHT_3 );	//dark blue
		}
		
		switch (c){
		case 7:
			return make_light( LIGHT_1, 0, LIGHT_3 );	//violet
		case 8:
			return make_light( LIGHT_1, 5, 5 );	//pink
		case 9:
			return make_light( LIGHT_1, LIGHT_2, LIGHT_3 );	//white
		}
		
		switch (c){
		case 10:
			return make_light( 0, 3, 0 );	//
		case 11:
			return make_light( 3, 0, 0 );	//
		case 12:
			return make_light( 3, 3, 3 );	//
		case 13:
			return make_light( 0, 0, 3 );	//	
		}
		
		if (c==0){
			return make_light( 0, 0, 0 );
		}
		
	return 0;
}

unsigned char long_color( unsigned int time, unsigned int c ){
	unsigned int i;
	for (i=0; i<time; i++){
		if ( make_color(c) == 1) return 1;
	}
	return 0;
}
