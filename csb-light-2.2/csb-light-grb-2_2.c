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
#define MODE_NUM	9
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

int main(void)
{
	mode = eeprom_read_byte(&e_mode);//Чтение
	serie = eeprom_read_byte(&e_serie);//Чтение
	
	if (mode>MODE_NUM){
		mode=1;
	}
	
	if (serie>S_NUM){
		serie=1;
	}
	
	LED_DDR = (1<<LED_1) | (1<<LED_2) | (1<<LED_3) | (0<<BUTTON_1) | (0<<BUTTON_2);	
	LED_PORT = (1<<LED_1) | (1<<LED_2) | (1<<LED_3) | (1<<BUTTON_1) | (1<<BUTTON_2);	
	
	unsigned char i;
	while(1){
		//check_mode();
		
		if ( serie==1 ){
			make_color(mode);
		} else if ( serie==2 ){
			switch (mode){
				case 1:
					for (i=1; i<=7; i++){
						long_color(240, i);
						//long_color(180, i);
					}
				break;
				
				case 2:
					for (i=1; i<=7; i++){
						make_strob(60, 60, i);
					}					
				break;
			}
			if (mode==3){
			//	case 3:
			unsigned char stp=0;
					for (i=0; i<=ALL_STEPS; i++){
						if ( l_make_light(ALL_STEPS,i,0)==1 || stp==1) {stp=1; break;}			 	// red >> yellow
					}
					for (i=1; i<=ALL_STEPS; i++){
						if ( l_make_light(ALL_STEPS-i, ALL_STEPS,0)==1 || stp==1) { stp=1; break;}; 	// yellow >> green
					}
					for (i=1; i<=ALL_STEPS; i++){
						if ( l_make_light(0, ALL_STEPS, i)==1 || stp==1) {stp=1; break;};			// green >> blue
					}
					for (i=1; i<=ALL_STEPS; i++){
						if ( l_make_light(0, ALL_STEPS-i, ALL_STEPS)==1 || stp==1) {stp=1; break;};  // blue >> dark blue
					}
					for (i=1; i<=ALL_STEPS; i++){	
						if ( l_make_light(i,0,ALL_STEPS)==1 || stp==1) {stp=1; break;};				// dark blue >> violet
					}
					for (i=1; i<=ALL_STEPS; i++){				
						if ( l_make_light(ALL_STEPS,0,ALL_STEPS-i)==1 || stp==1) {break;};			// violet >> red
					}
			}
			
			switch (mode){
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
			
			switch (mode){
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
	
	if ( hold > S_DELAY ){	// next serie
		if ( state == NOT_PRESSED ){
			if (serie==1){
				serie=2;
			} else {
				serie=1;
			}				
			mode=1;
			
			eeprom_write_byte(&e_mode,   mode);//Запись
			eeprom_write_byte(&e_serie,   serie);//Запись
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
Режимы:
I группа:
1.1 красный
1.2 оранжевый
1.3 желтый
1.4 зеленый
1.5 голубой
1.6 синий
1.7 фиолетовый
1.8 розовый
1.9 белый

II группа
2.1 - последовательная смена цветов от 1.1 до 1.7
2.2 - смена с пропусками (цветные стробы)
2.3 - плавная смена цветов (градиенты/переливания)
2.4 - стробоскоп Синий-Желтый 
2.5 - стробоскоп Красная-Зеленая
2.6 - стробоскоп Фиолетовый-Желтый
2.7 - стробоскоп Белый                     (высокая скорость)
2.8 - стробоскоп белый-красный-белый-синий (высокая скорость)
2.9 - стробоскоп белый-зеленый-белый-синий (высокая скорость)

Управление:
2 кнопки
короткое нажатие:
1-я кнопка: короткое нажатие - следующий режим (переключение в одну сторону), длинное нажатие - смена группы.
2-я кнопка: короткое нажатие - предыдущий режим (переключение в другую сторону), длинное нажатие - смена группы.
долгое нажатие любой кнопки - выключение


*/

