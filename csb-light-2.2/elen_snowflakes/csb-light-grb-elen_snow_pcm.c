// t13	attiny13	38400 prog
// board	MMCU		programm_after_make

#define F_CPU 1000000

#include <avr/io.h>
#include <avr/eeprom.h>
#include <avr/sleep.h>
#include <util/delay.h>
#include <avr/interrupt.h>

// Hardware ===========================================================
// LEDs ---------------------------------------------------------------
#define LED_PORT	PORTB
#define LED_DDR		DDRB

#define LED_1		1
#define	LED_2		0
#define	LED_3		2

// Buttons ------------------------------------------------------------
#define BUTTON_PIN	PINB
#define MODE_BUTTON		4
#define BUTTON_2		4

// Logic ==============================================================
// values for PWM -----------------------------------------------------
#define ALL_STEPS	20				
#define LIGHT_1		(ALL_STEPS-0)
#define LIGHT_2		(ALL_STEPS-0)
#define LIGHT_3		(ALL_STEPS-0)
#define HALF_LIGHT	5

// modes
#define MODE_NUM	6
#define S_NUM		2
#define BLACK		0	//position of black color (needs to make strobs)

unsigned char mode;
unsigned char serie;
//unsigned char halt;

//buttons
#define PRESSED			1
#define NOT_PRESSED		0

#define INC_DELAY	20
#define S_DELAY		700
#define HALT_DELAY  4000

// PCM ================================================================
unsigned char power;
#define ACTIVE	10
#define IDLE	0
#define AWAKEN	2
#define TO_SLEEP	IDLE

inline void _set_active(){ power=ACTIVE; }
inline void _set_idle(){ power=IDLE; }

#define _interrupts_on() { GIMSK=1<<5; PCMSK=1<<4; sei(); }
#define _interrupts_off() { GIMSK=0; PCMSK=0; cli(); }

ISR(PCINT0_vect){
	if (power==IDLE){
		power=AWAKEN;
	}
}

// actions ============================================================
unsigned char process_button( unsigned int hold, unsigned int state );
unsigned char check_button();

unsigned char make_light( unsigned char r, unsigned char g, unsigned char b );
unsigned char l_make_light( unsigned char r, unsigned char g, unsigned char b );
unsigned char make_color( unsigned char c ); // (7 simple colors)

unsigned char long_color( unsigned char time, unsigned char c ); // (7 simple colors)
unsigned char make_strob( unsigned char time1, unsigned char time2, unsigned char color );


EEMEM unsigned char	e_mode;
EEMEM unsigned char	e_serie;

void make_serie(){
	unsigned char i;
	if ( serie==1 ){
		make_color(mode);
	} else if ( serie==2 ){
		switch (mode){
			case 1:
				for (i=1; i<=6; i++){
					long_color(240, i);
					//long_color(180, i);
				}
			break;
			
			case 2:
				for (i=1; i<=6; i++){
					make_strob(60, 60, i);
				}		
				break;
				
			case 3:	// blue - aqua
				for (i=1; i<=ALL_STEPS; i++){
					if (l_make_light(0, i, ALL_STEPS)==1) return;
				}	
				for (i=1; i<=ALL_STEPS; i++){
					if (l_make_light(0, ALL_STEPS-i, ALL_STEPS)==1) return;
				}												
				break;
		}
		
		switch (mode){
			case 4:	//blue - violet
				for (i=1; i<=ALL_STEPS; i++){
					if (l_make_light( i, 0, ALL_STEPS)==1) return;
				}	
				for (i=1; i<=ALL_STEPS; i++){
					if (l_make_light( ALL_STEPS-i, 0, ALL_STEPS)==1) return;
				}	
				break;
			
			case 5:	// violet white
				for (i=1; i<=ALL_STEPS; i++){
					if (l_make_light(ALL_STEPS, i, ALL_STEPS)==1) return;
				}	
				for (i=1; i<=ALL_STEPS; i++){
					if (l_make_light(ALL_STEPS, ALL_STEPS-i, ALL_STEPS)==1) return;
				}		
				break;
				
			case 6: // blue -- aqua -- white -- violet --
				for (i=1; i<=ALL_STEPS; i++){
					if (l_make_light(0, i, ALL_STEPS)==1) return;
				}	
				for (i=1; i<=ALL_STEPS; i++){
					if (l_make_light(i, ALL_STEPS, ALL_STEPS)==1) return;
				}			
				
				for (i=1; i<=ALL_STEPS; i++){
					if (l_make_light(ALL_STEPS, ALL_STEPS-i, ALL_STEPS)==1) return;
				}								
				for (i=1; i<=ALL_STEPS; i++){
					if (l_make_light(ALL_STEPS-i, 0, ALL_STEPS)==1) return;
				}
				break;
		}		
	} 
}

void init_io(){
	LED_DDR = (1<<LED_1) | (1<<LED_2) | (1<<LED_3) | (0<<MODE_BUTTON);	
	LED_PORT = (1<<LED_1) | (1<<LED_2) | (1<<LED_3) | (1<<MODE_BUTTON);	
}

int main(void){
	_set_active();
	// interrupts
	_interrupts_off();
		
	mode = eeprom_read_byte(&e_mode);//Чтение
	serie = eeprom_read_byte(&e_serie);//Чтение
	
	if (mode>MODE_NUM){
		mode=1;
	}
	
	if (serie>S_NUM){
		serie=1;
	}
	
	init_io();

	
	while(1){
		//check_mode();
		if ( power==AWAKEN ){
			init_io();
			_interrupts_off();
			power=ACTIVE;
			unsigned char	st=BUTTON_PIN;
			unsigned char	i;
			for (i=0; i<10; i++){
				st=BUTTON_PIN;
				_delay_ms(20);			
				if ( (st &  (1<<MODE_BUTTON))  != (0<<MODE_BUTTON) ){
					power=TO_SLEEP;
					break;
				}
			}
			
			while ( ( (st &  (1<<MODE_BUTTON))  == (0<<MODE_BUTTON) ) ) 
				st=BUTTON_PIN;
				_delay_ms(150);
		} else if ( power==TO_SLEEP ){
			DDRB=0;
			PORTB=(1<<MODE_BUTTON);
			//go_sleep();
			set_sleep_mode(SLEEP_MODE_PWR_DOWN);
			sleep_enable();
			_interrupts_on();
			power=IDLE;
			sleep_cpu();
			sleep_disable();
		} else {
			make_serie();
		}
	}
}

unsigned char make_light( unsigned char r, unsigned char g, unsigned char b ){
	unsigned char i;
	unsigned char p;

	for(i=0; i<ALL_STEPS; i++){
		p=(1<<MODE_BUTTON) + (1<<BUTTON_2);
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
	for(i=0; i<250; i++){
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
	
	if ( ( (st &  (1<<MODE_BUTTON))  == (0<<MODE_BUTTON) ) ) {
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
			return make_light( LIGHT_1, 5, 5 );	//pink
			break;
		case 2:
			return make_light( 0, HALF_LIGHT, LIGHT_3 );	//blue
			break;
		case 4:
			return make_light( 0, 0, LIGHT_3 );	//dark blue
			break;	
		}
		
		switch (c){
		case 3:
			return make_light( LIGHT_1, 0, LIGHT_3 );	//violet
			break;
		case 6:
			return make_light( 0, LIGHT_2, LIGHT_3 );	// a kind of blue?
			break;
		case 5:
			return make_light( LIGHT_1, LIGHT_2, LIGHT_3 );	//white
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


unsigned char process_button( unsigned int hold, unsigned int state){
	
	if ( hold > HALT_DELAY ){ // software HALT
	//	stat=14;
		if ( state == NOT_PRESSED ){
			_set_idle();
	//		store_data();	//Запись
	//		stat=0;
			return 1;
		}
	}  else if ( hold > INC_DELAY ){	// next mode
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
 * Привет) меня заказчица опять озадачила вопросом. 
 * Она хочет контроллеры с режимом переливающимся, 
 * но ей важно, чтобы там были только новогодние цвета. 
 * Сейчас поясню какие она подразумевает:
Розовый, голубой, белый, синий, бирюзовый. Можно из них переливы сделать? 
* */
