// t13	attiny13	38400 prog
// board	MMCU		programm_after_make

// more constant colors
// no strobs -- more grads
// more deep PWM

// -U lfuse:w:0x7a:m -U hfuse:w:0xff:m
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
#define ALL_STEPS	160				
#define FULL_LIGHT		(ALL_STEPS-0)
#define HALF_LIGHT	70
#define HALF_HALF_LIGHT	30

// modes
#define MODE_NUM	5
#define S_NUM		1
#define BLACK		0	//position of black color (needs to make strobs)

unsigned char mode;
unsigned char serie;
//unsigned char halt;

//buttons
#define PRESSED			1
#define NOT_PRESSED		0

#define INC_DELAY	80
#define S_DELAY		700
#define HALT_DELAY  4000
unsigned char process_button( unsigned int hold, unsigned int state );
unsigned char check_button();

// actions ============================================================
unsigned char make_light( unsigned char r, unsigned char g, unsigned char b );
unsigned char l_make_light( unsigned char r, unsigned char g, unsigned char b, unsigned char slowness );
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
	
	//unsigned char i;
	while(1){
		//check_mode();
		make_color(mode);
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

unsigned char l_make_light( unsigned char r, unsigned char g, unsigned char b, unsigned char slowness){
	unsigned char i;
	for(i=0; i<slowness; i++){
		if ( make_light(r, g, b) == 1) return 1;
	}
	return 0;
}

unsigned char make_rainbow(unsigned char slowness){
	unsigned char i;
			for (i=0; i<=ALL_STEPS; i++){
				if ( l_make_light(ALL_STEPS,i,0, slowness)==1) {return 1;}			 	// red >> yellow
			}
			for (i=1; i<=ALL_STEPS; i++){
				if ( l_make_light(ALL_STEPS-i, ALL_STEPS,0, slowness)==1) { return 1;}; 	// yellow >> green
			}
			for (i=1; i<=ALL_STEPS; i++){
				if ( l_make_light(0, ALL_STEPS, i, slowness)==1) {return 1;};			// green >> blue
			}
			for (i=1; i<=ALL_STEPS; i++){
				if ( l_make_light(0, ALL_STEPS-i, ALL_STEPS, slowness)==1) {return 1;};  // blue >> dark blue
			}
			for (i=1; i<=ALL_STEPS; i++){	
				if ( l_make_light(i,0,ALL_STEPS, slowness)==1) {return 1;};				// dark blue >> violet
			}
			for (i=1; i<=ALL_STEPS; i++){				
				if ( l_make_light(ALL_STEPS,0,ALL_STEPS-i, slowness)==1) {return 1;};			// violet >> red
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
		if (c==0){
			return make_light( 0, 0, 0 );
		}
		
	switch (c){
		case 1: 
			return make_light( 0, 0, FULL_LIGHT );	//
		case 2:
			return make_light( FULL_LIGHT, 0, 0 );	//
		case 3:
			return make_light( 0, FULL_LIGHT, 0 );	//
		case 4:	
			if (long_color(50, 1)==1) return 1;
			if (long_color(50, 0)==1) return 1;
			if (long_color(50, 2)==1) return 1;
			if (long_color(50, 0)==1) return 1;
			if (long_color(50, 3)==1) return 1;
			if (long_color(50, 0)==1) return 1;

			return 0;
		case 5:
			return make_rainbow(50);	
		}		
	return make_light( 0, 0, 0 );
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

