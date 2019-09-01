// t13	attiny13	38400 prog
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
#define MODE_NUM	11
#define S_NUM		1
#define BLACK		0	//position of black color (needs to make strobs)

unsigned char mode;

//buttons
#define PRESSED			1
#define NOT_PRESSED		0

#define INC_DELAY	20
#define S_DELAY		700
#define HALT_DELAY  4000
unsigned char process_button( unsigned int hold, unsigned int state );
unsigned char check_button();

// actions ============================================================
unsigned char make_light( unsigned char r, unsigned char g);
unsigned char l_make_light( unsigned char r, unsigned char g );
unsigned char make_color( unsigned char c ); // (7 simple colors)

unsigned char long_color( unsigned long int time, unsigned char c ); // (7 simple colors)
unsigned char make_strob( unsigned char time1, unsigned char time2, unsigned char color );


EEMEM unsigned char	e_mode;

unsigned char stp=0;

int main(void)
{
	mode = eeprom_read_byte(&e_mode);//Чтение
	
	if (mode>MODE_NUM){
		mode=1;
	}
	

	LED_DDR = (1<<LED_1) | (1<<LED_2) | (1<<LED_3) | (0<<BUTTON_1) | (0<<BUTTON_2);	
	LED_PORT = (1<<LED_1) | (1<<LED_2) | (1<<LED_3) | (1<<BUTTON_1) | (1<<BUTTON_2);	
	
	unsigned char i;
	
	while(1){
		//check_mode();
		stp=0;

		switch (mode){
			case 1:		// blue
				long_color(50, 1);
			break;
			
			case 2:		// Белый горит постоянно + синий плавно мигает ( загорается- тухнет)
				
				for (i=1; i<=ALL_STEPS; i++){
					if ( l_make_light( i, ALL_STEPS)==1 || stp==1)  {stp=1; break;};		 	
				}		
				for (i=1; i<=ALL_STEPS; i++){
					if ( l_make_light( ALL_STEPS-i, ALL_STEPS)==1 || stp==1)  {stp=1; break;};			 	
				}				
			break;
		//}
		//if (mode==3){ // Поочередное плавное мигание белого и синего. Т.е то синий светит то белый 
			case 3:
				for (i=0; i<=ALL_STEPS; i++){
					if ( l_make_light(i, ALL_STEPS-i)==1 || stp==1) {stp=1; break;}			 	// red >> yellow
				}
				for (i=1; i<=ALL_STEPS; i++){
					if ( l_make_light(ALL_STEPS-i, i)==1 || stp==1) { stp=1; break;}; 	// yellow >> green
				}
		}
		
		switch (mode){ //4. Белый + синий 
			case 4:
				long_color( 50, 2);
			break;
			
			case 5:	// Белый
				long_color( 50, 3);
			break;
			
			case 6:	// Синий светит постоянно, белый плавно загорается/затухает
				for (i=1; i<=ALL_STEPS; i++){
					if ( l_make_light(ALL_STEPS, i)==1 || stp==1)  {stp=1; break;};		 	
				}		
				for (i=1; i<=ALL_STEPS; i++){
					if ( l_make_light(ALL_STEPS, ALL_STEPS-i)==1 || stp==1)  {stp=1; break;};			 	
				}	
		}
		
		switch (mode){
			case 7:	// Белый светит, синий стробоскоп ( но не оч быстрый, просто вспыхивает)
				long_color( 100, 2);
				long_color( 2500, 3);
			break;
			
			case 8:	// Cиний светит постоянно , белый стробоскоп
				long_color( 100, 2);
				long_color( 2500, 1);
			break;
			
			case 9:	//Резкая смена белого на синий и обратно. Несколько секунд только синий , несколько секунд только белый , несколько секунд оба цвета. 
				long_color( 15500, 2);
				long_color( 15500, 3);
				long_color( 15500, 1);
		}
		switch (mode){
			case 10:	// 10. Оба цвета одновременно светят, тухнет один и загорается снова, немного светят одновременно , тухнет второй и снова появляется. Снова светят одновременно ( затухаете плавное).
				long_color( 5500, 2);
				for (i=1; i<=ALL_STEPS; i++){
					if ( l_make_light( ALL_STEPS-i, ALL_STEPS)==1 || stp==1)  {stp=1; break;};		 //	 один гаснет	
				}		
				for (i=1; i<=ALL_STEPS; i++){
					if ( l_make_light( i, ALL_STEPS)==1 || stp==1)  {stp=1; break;};			 	// и появляется
				}		
				long_color( 5500, 2);
				for (i=1; i<=ALL_STEPS; i++){
					if ( l_make_light(ALL_STEPS, ALL_STEPS-i)==1 || stp==1)  {stp=1; break;};		 	
				}		
				for (i=1; i<=ALL_STEPS; i++){
					if ( l_make_light(ALL_STEPS, i)==1 || stp==1)  {stp=1; break;};			 	
				}					
			break;
			
			case 11:	// 11. Плавное затухаете и снова свечение одновременно 2х цветов .
				for (i=1; i<=ALL_STEPS; i++){
					if ( l_make_light( i, i)==1 || stp==1)  {stp=1; break;};		 	
				}		
				for (i=1; i<=ALL_STEPS; i++){
					if ( l_make_light( ALL_STEPS-i, ALL_STEPS-i)==1 || stp==1)  {stp=1; break;};			 	
				}		
			break;
		}	
	}
}

unsigned char make_light( unsigned char r, unsigned char g ){
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
			
		LED_PORT=p;
	}
	
	return check_button();
}

unsigned char l_make_light( unsigned char r, unsigned char g ){
	unsigned int i;
	for(i=0; i<500; i++){
		if ( make_light(r, g) == 1) return 1;
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
	stp=res;
	return res;
}

unsigned char make_color( unsigned char c ){
		switch (c){
		case 1: 
			return make_light( LIGHT_1, 0 );	//red
			break;
		case 2:
			return make_light( LIGHT_1, LIGHT_1 );	//orange
			break;
		case 3:
			return make_light( 0, LIGHT_1 );	//yellow
			break;
		case 0:
			return make_light( 0, 0 );
		default:
			return make_light( 0, 0 );
		}
		
	return 0;
}

unsigned char long_color( unsigned long int time, unsigned char c ){
	unsigned int i;
	for (i=0; i<time; i++){
		if ( make_color(c) == 1 || stp==1) return 1;
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

/*
1. Только синий светит постоянно
2. Белый горит постоянно + синий плавно мигает ( загорается- тухнет)
3. Поочередное плавное мигание белого и синего. Т.е то синий светит то белый 
4. Белый горит постоянно, синий горит постоянно 
5. Светит только белый
6. Синий светит постоянно, белый плавно загорается/затухает
7. Белый светит, синий стробоскоп ( но не оч быстрый, просто вспыхивает)
8. Синий светит постоянно , белый стробоскоп
9. Резкая смена белого на синий и обратно. Несколько секунд только синий , несколько секунд только белый , несколько секунд оба цвета. 
10. Оба цвета одновременно светят, тухнет один и загорается снова, немного светят одновременно , тухнет второй и снова появляется. Снова светят одновременно ( затухаете плавное).
11. Плавное затухаете и снова свечение одновременно 2х цветов .

Если можно - демо режим, смена всех режимов по очереди с разницей секунд 10-15. Как на моем костюме сейчас.

Пока такие придумал ))
* */
