// t45	attiny45	38400 prog
// board	MMCU		programm_after_make

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
#define BUTTON_2		4

// Logic ==============================================================
// values for PWM -----------------------------------------------------
#define ALL_STEPS	20				
#define LIGHT_1		(ALL_STEPS-0)
#define LIGHT_2		(ALL_STEPS-0)
#define LIGHT_3		(ALL_STEPS-0)
#define HALF_LIGHT	5

// modes
#define MODE_NUM	9
#define S_NUM		2
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
unsigned char process_button( unsigned int hold, unsigned int state );
unsigned char check_button();

// actions ============================================================
unsigned char make_light( unsigned char r, unsigned char g, unsigned char b );
unsigned char l_make_light( unsigned char r, unsigned char g, unsigned char b );
unsigned char make_color( unsigned char c ); // (7 simple colors)

unsigned char long_color( unsigned char time, unsigned char c ); // (7 simple colors)
unsigned char make_strob( unsigned char time1, unsigned char time2, unsigned char color );


EEMEM unsigned char	e_mode;
EEMEM unsigned char	e_serie;


// fav utils
#define FAV_MAX  15

unsigned char modes[FAV_MAX];
unsigned char series[FAV_MAX];
unsigned char counter;
unsigned char pointer;
unsigned char fav_on;

EEMEM unsigned char	fm[FAV_MAX];
EEMEM unsigned char	sm[FAV_MAX];
EEMEM unsigned char e_counter;
EEMEM unsigned char e_pointer;
EEMEM unsigned char e_fav_on;

void make_serie(unsigned char s, unsigned char m );

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
		if (modes[i]>MODE_NUM) modes[i]=i+1;
		if (series[i]>S_NUM) series[i]=1;
	}
	
	if (counter>=FAV_MAX) counter=0;
	if (pointer>=counter) pointer=counter;
	
	if (fav_on>1) fav_on=0;
	
}

void read_data(){
	mode = eeprom_read_byte(&e_mode);//Чтение
	serie = eeprom_read_byte(&e_serie);//Чтение
	
	eeprom_read_block(modes, fm, FAV_MAX);
	eeprom_read_block(series, sm, FAV_MAX);
	
	pointer = eeprom_read_byte(&e_pointer);//Чтение		
	counter = eeprom_read_byte(&e_counter);//Чтение		
	fav_on = eeprom_read_byte(&e_fav_on);//Чтение		
	
	check_all();
}

void store_data(){
	eeprom_write_byte(&e_mode,   mode);//Запись
	eeprom_write_byte(&e_serie,   serie);//Запись
	
	 
	eeprom_write_block(modes, fm, FAV_MAX);
	eeprom_write_block(series, sm, FAV_MAX);
	
	eeprom_write_byte(&e_pointer,  pointer);//Запись	
	eeprom_write_byte(&e_counter,  counter);//Запись	
	eeprom_write_byte(&e_fav_on,   fav_on);//Чтение	
}

int main(void){
	read_data();

	LED_DDR = (1<<LED_1) | (1<<LED_2) | (1<<LED_3) | (0<<BUTTON_1) | (0<<BUTTON_2);	
	LED_PORT = (1<<LED_1) | (1<<LED_2) | (1<<LED_3) | (1<<BUTTON_1) | (1<<BUTTON_2);	
	
	stat=0;
	//fav_on=0;
	
	while(1){
		//check_mode();
		if (stat==0) {
			if (fav_on==0){
				make_serie(serie, mode);
			} else {
				if (counter>0){
					make_serie( series[pointer], modes[pointer]);	// there should be reading from fav
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
		} else {	
			make_color(0);
		} 
		
	}
}


unsigned char process_button( unsigned int hold, unsigned int state){
	
	
	
	if ( hold > CLEAR_DELAY ){	// // toggle to/from favorite
		stat=12;
		pointer=0;
		counter=0;
		fav_on=0;

		check_all();
		store_data();	//Запись
		stat=0;
		return 1;
	}  else if ( hold > T_FAV_DELAY ){	// // toggle to/from favorite
		stat=11;
		if ( state == NOT_PRESSED ){
			// toggle to/from favorite
			if (fav_on==0){
				fav_on=1;
				pointer=0;
			} else {
				fav_on=0;
			}	
			
			check_all();
			store_data();	//Запись
			stat=0;
			return 1;
		}		
	}  else if ( hold > W_FAV_DELAY ){	// //	write mode to favorite
		if (fav_on==0){
			stat=10;
			if ( state == NOT_PRESSED ){	//	write mode to favorite
				if (counter<FAV_MAX+1) {
					counter++;
					modes[counter]=mode;
					series[counter]=serie;
				}
				
				check_all();
				store_data();	//Запись
				stat=0;
				return 1;
			}		
		}
	}  else if ( hold > S_DELAY ){	// next serie
		if (fav_on==0){
			if ( state == NOT_PRESSED && fav_on==0 ){
				if (serie==1){
					serie=2;
				} else {
					serie=1;
				}				
				mode=1;
				
				store_data();	//Запись
				return 1;
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
					pointer=0; 
				}
			}
			
			check_all();
			store_data();	//Запись
			return 1;
		}
	}
	
	return 0;
}


void make_serie(unsigned char s, unsigned char m ){
	unsigned char i;
	if ( s==1 ){
			make_color(m);
		} else if ( serie==2 ){
			switch (m){
				case 1:
					for (i=1; i<=7; i++){
						long_color(240, i);
					}
				break;
				
				case 2:
					for (i=1; i<=7; i++){
						make_strob(60, 60, i);
					}					
				break;
			}
			
			if (m==3){
				//	case 3:
				for (i=0; i<=ALL_STEPS; i++){
					if ( l_make_light(ALL_STEPS,i,0)==1 ||stat!=0)  return;			 	// red >> yellow
				}
				for (i=1; i<=ALL_STEPS; i++){
					if ( l_make_light(ALL_STEPS-i, ALL_STEPS,0)==1 || stat!=0) return; 	// yellow >> green
				}
				for (i=1; i<=ALL_STEPS; i++){
					if ( l_make_light(0, ALL_STEPS, i)==1 || stat!=0) return;			// green >> blue
				}
				for (i=1; i<=ALL_STEPS; i++){
					if ( l_make_light(0, ALL_STEPS-i, ALL_STEPS)==1 || stat!=0) return;  // blue >> dark blue
				}
				for (i=1; i<=ALL_STEPS; i++){	
					if ( l_make_light(i,0,ALL_STEPS)==1 || stat!=0) return;				// dark blue >> violet
				}
				for (i=1; i<=ALL_STEPS; i++){				
					if ( l_make_light(ALL_STEPS,0,ALL_STEPS-i)==1 || stat!=0) return;			// violet >> red
				}
			}
			
			switch (m){
				case 4:
					make_strob(60, 60, 6);
					make_strob(60, 60, 3);
				break;
				
				case 5:
					make_strob(60, 60, 1);
					make_strob(60, 60, 4);
				break;
				
				case 6:
					make_strob(60, 60, 2);
					make_strob(60, 60, 7);
			}
			
			switch (m){
				case 7:
					make_strob(30, 30, 9);
				break;
				
				case 8:
					make_strob(30, 30, 9);
					make_strob(30, 30, 1);
					make_strob(30, 30, 9);
					make_strob(30, 30, 6);
				break;
				
				case 9:
					make_strob(30, 30, 9);
					make_strob(30, 30, 4);
					make_strob(30, 30, 9);
					make_strob(30, 30, 6);
			}
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

unsigned char l_make_light( unsigned char r, unsigned char g, unsigned char b ){
	unsigned char i;
	for(i=0; i<150; i++){
		if ( make_light(r, g, b) == 1) return 1;
	}
	return 0;
}

unsigned char make_strob( unsigned char time1, unsigned char time2, unsigned char color ){
	long_color( time1, color);
	long_color( time2, 0);

	return 0;
}

unsigned char check_button(){
	
	static unsigned int hold=0;
	static unsigned char button_state=NOT_PRESSED;
	static unsigned char last_button_state=NOT_PRESSED;
	
	unsigned char	st=BUTTON_PIN;
	unsigned char res=0;
	
	button_state=NOT_PRESSED;
	
	if ( ( (st &  (1<<BUTTON_1))  == (0<<BUTTON_1) ) ) {
		button_state = PRESSED;
	}
	
	if ( button_state == PRESSED ){
		hold++;
	}
	
	if ( last_button_state == button_state ){
		res = process_button( hold, button_state );
	}
	
	if ( button_state == NOT_PRESSED &&  last_button_state == NOT_PRESSED ){
		hold=0;
	}
	
	last_button_state=button_state;
	return res;
}

unsigned char make_color( unsigned char c ){
		switch (c){
		case 1: 
			return make_light( LIGHT_1, 0, 0 );	//red
			break;
		case 2:
			return make_light( LIGHT_1, HALF_LIGHT, 0 );	//orange
			break;
		case 3:
			return make_light( LIGHT_1, LIGHT_2, 0 );	//yellow
			break;
		}
		
		switch (c){
		case 4:
			return make_light( 0, LIGHT_2, 0 );	//green
			break;
		case 5:
			return make_light( 0, HALF_LIGHT, LIGHT_3 );	//blue
			break;
		case 6:
			return make_light( 0, 0, LIGHT_3 );	//dark blue
			break;	
		}
		
		switch (c){
		case 7:
			return make_light( LIGHT_1, 0, LIGHT_3 );	//violet
			break;
		case 8:
			return make_light( LIGHT_1, 5, 5 );	//pink
			break;
		case 9:
			return make_light( LIGHT_1, LIGHT_2, LIGHT_3 );	//white
			break;
		}
		
		switch (c){
		case 10:
			return make_light( 3, 0, 0 );	//
			break;
		case 11:
			return make_light( 0, 3, 0 );	//
			break;
		case 12:
			return make_light( 3, 3, 3 );	//
			break;
		}
		
		if (c==0){
			return make_light( 0, 0, 0 );
		}
		
	return 0;
}

unsigned char long_color( unsigned char time, unsigned char c ){
	unsigned int i;
	for (i=0; i<time; i++){
		if ( make_color(c) == 1) return 1;
	}
	return 0;
}
