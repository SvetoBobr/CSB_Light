// t45	attiny45	76800 prog
// board	MMCU		programm_after_make
//38400

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
#define MODE_NUM	12
#define S_NUM		2
#define BLACK		0	//position of black color (needs to make strobs)

unsigned char mode;
//unsigned char halt;

//buttons
#define PRESSED			1
#define NOT_PRESSED		0

#define INC_DELAY	20
#define S_DELAY		700
#define HALT_DELAY  4000
unsigned char process_button( unsigned int hold, unsigned int state );
unsigned char check_button();

// actions ============================================================
unsigned char make_light( unsigned char r, unsigned char g, unsigned char b );
unsigned char l_make_light( unsigned char r, unsigned char g, unsigned char b, unsigned int t );
unsigned char l_make_flashing_light( unsigned char r, unsigned char g, unsigned char b, unsigned int t );
unsigned char make_color( unsigned char c ); // (7 simple colors)

unsigned char long_color( unsigned char time, unsigned char c ); // (7 simple colors)
unsigned char make_strob( unsigned char time1, unsigned char time2, unsigned char color );


EEMEM unsigned char	e_mode;

#define SUPER_TIME_1	639
#define SUPER_TIME_2	491
#define SUPER_TIME_2_1	35
#define SUPER_TIME_3	9

void supermode_1(){	// gradient
	unsigned char i;

	for (i=0; i<=ALL_STEPS; i++){
		if ( l_make_light(ALL_STEPS,i,0, SUPER_TIME_1)==1 ) return;			 	// red >> yellow
	}
	for (i=1; i<=ALL_STEPS; i++){
		if ( l_make_light(ALL_STEPS-i, ALL_STEPS,0, SUPER_TIME_1)==1 ) return; 	// yellow >> green
	}
	for (i=1; i<=ALL_STEPS; i++){
		if ( l_make_light(0, ALL_STEPS, i, SUPER_TIME_1)==1 ) return;			// green >> blue
	}
	for (i=1; i<=ALL_STEPS; i++){
		if ( l_make_light(0, ALL_STEPS-i, ALL_STEPS, SUPER_TIME_1)==1 ) return;  // blue >> dark blue
	}
	for (i=1; i<=ALL_STEPS; i++){	
		if ( l_make_light(i,0,ALL_STEPS, SUPER_TIME_1)==1 ) return;				// dark blue >> violet
	}
	for (i=1; i<=ALL_STEPS; i++){				
		if ( l_make_light(ALL_STEPS,0,ALL_STEPS-i, SUPER_TIME_1)==1 ) return;			// violet >> red
	}
}

void supermode_2(){
	unsigned char i;
	for (i=0; i<=ALL_STEPS; i++){
		if ( l_make_light(ALL_STEPS,i,0, SUPER_TIME_2)==1 ) return;			 	// red >> yellow
	}
	l_make_flashing_light(ALL_STEPS,ALL_STEPS,0, SUPER_TIME_2_1);
	
	for (i=1; i<=ALL_STEPS; i++){
		if ( l_make_light(0, ALL_STEPS,0, SUPER_TIME_2)==1 ) return; 	// yellow >> green
	}
	l_make_flashing_light(ALL_STEPS,i,0, SUPER_TIME_2_1);
	
	for (i=1; i<=ALL_STEPS; i++){
		if ( l_make_light(0, ALL_STEPS, i, SUPER_TIME_2)==1 ) return;			// green >> blue
	}
	l_make_flashing_light(ALL_STEPS,0,ALL_STEPS, SUPER_TIME_2_1);
	
	for (i=1; i<=ALL_STEPS; i++){
		if ( l_make_light(0, ALL_STEPS-i, ALL_STEPS, SUPER_TIME_2)==1 ) return;  // blue >> dark blue
	}
	l_make_flashing_light(0,0,ALL_STEPS, SUPER_TIME_2_1);
	
	for (i=1; i<=ALL_STEPS; i++){	
		if ( l_make_light(i,0,ALL_STEPS, SUPER_TIME_2)==1 ) return;				// dark blue >> violet
	}
	l_make_flashing_light(ALL_STEPS,0,ALL_STEPS, SUPER_TIME_2_1);
	
	for (i=1; i<=ALL_STEPS; i++){				
		if ( l_make_light(ALL_STEPS,0,ALL_STEPS-i, SUPER_TIME_2)==1 ) return;			// violet >> red
	}
	l_make_flashing_light(ALL_STEPS,0,0, SUPER_TIME_2_1);
	
}


void supermode_3(){	// flashing gradient
	unsigned char i;

	for (i=0; i<=ALL_STEPS; i++){
		if ( l_make_flashing_light(ALL_STEPS,i,0, SUPER_TIME_3)==1 ) return;			 	// red >> yellow
		//if ( l_make_light(0,0,0, SUPER_TIME_3)==1 ) return;	
	}
	for (i=1; i<=ALL_STEPS; i++){
		if ( l_make_flashing_light(ALL_STEPS-i, ALL_STEPS,0, SUPER_TIME_3)==1 ) return; 	// yellow >> green
		//if ( l_make_light(0,0,0, SUPER_TIME_3)==1 ) return;	
	}
	for (i=1; i<=ALL_STEPS; i++){
		if ( l_make_flashing_light(0, ALL_STEPS, i, SUPER_TIME_3)==1 ) return;			// green >> blue
		//if ( l_make_light(0,0,0, SUPER_TIME_3)==1 ) return;	
	}
	for (i=1; i<=ALL_STEPS; i++){
		if ( l_make_flashing_light(0, ALL_STEPS-i, ALL_STEPS, SUPER_TIME_3)==1 ) return;  // blue >> dark blue
		//if ( l_make_light(0,0,0, SUPER_TIME_3)==1 ) return;	
	}
	for (i=1; i<=ALL_STEPS; i++){	
		if ( l_make_flashing_light(i,0,ALL_STEPS, SUPER_TIME_3)==1 ) return;				// dark blue >> violet
		//if ( l_make_light(0,0,0, SUPER_TIME_3)==1 ) return;	
	}
	for (i=1; i<=ALL_STEPS; i++){				
		if ( l_make_flashing_light(ALL_STEPS,0,ALL_STEPS-i, SUPER_TIME_3)==1 ) return;			// violet >> red
		//if ( l_make_light(0,0,0, SUPER_TIME_3)==1 ) return;	
	}}	

int main(void)
{
	mode = eeprom_read_byte(&e_mode);//Чтение
	
	if (mode>MODE_NUM){
		mode=1;
	}

	LED_DDR = (1<<LED_1) | (1<<LED_2) | (1<<LED_3) | (0<<BUTTON_1) | (0<<BUTTON_2);	
	LED_PORT = (1<<LED_1) | (1<<LED_2) | (1<<LED_3) | (1<<BUTTON_1) | (1<<BUTTON_2);	
	
	while(1){
		//check_mode();
		
		if ( mode<=9 ){
			make_color(mode);
		} else {
			switch (mode){
				case 10:
					supermode_1();
				break;
				
				case 11:
					supermode_2();			
				break;
				
				case 12:
					supermode_3();				
				break;
			}
			
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

unsigned char l_make_light( unsigned char r, unsigned char g, unsigned char b, unsigned int t ){
	unsigned int i;
	for(i=0; i<t; i++){
		if ( make_light(r, g, b) == 1) return 1;
	}
	return 0;
}

unsigned char l_make_flashing_light( unsigned char r, unsigned char g, unsigned char b, unsigned int t ){
	unsigned int i, j;
	for (j=0; j<t; j++){
		for(i=0; i<29; i++){
			if ( make_light(r, g, b) == 1) return 1;
		}
		for(i=0; i<29; i++){
			if ( make_light(0, 0, 0) == 1) return 1;
		}	
	}
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
		
		if (c==0){
			return make_light( 0, 0, 0 );
		}
		
	return 0;
}



unsigned char process_button( unsigned int hold, unsigned int state){
if ( hold > INC_DELAY ){	// next mode
		if ( state == NOT_PRESSED ){
			if (++mode>MODE_NUM) { 
				mode=1; 
			}
			eeprom_write_byte(&e_mode,   mode);//Запись
			return 1;
		}
	}
	
	return 0;
}
