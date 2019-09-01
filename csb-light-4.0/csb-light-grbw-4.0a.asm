	.file	"csb-light-grbw-4.0a.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	__vector_2
	.type	__vector_2, @function
__vector_2:
	push r1
	push r0
	in r0,__SREG__
	push r0
	clr __zero_reg__
	push r24
/* prologue: Signal */
/* frame size = 0 */
/* stack size = 4 */
.L__stack_usage = 4
	lds r24,power
	cpse r24,__zero_reg__
	rjmp .L1
	ldi r24,lo8(2)
	sts power,r24
.L1:
/* epilogue start */
	pop r24
	pop r0
	out __SREG__,r0
	pop r0
	pop r1
	reti
	.size	__vector_2, .-__vector_2
.global	check_all
	.type	check_all, @function
check_all:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,mode
	cpi r24,lo8(10)
	brlo .L5
	ldi r24,lo8(1)
	sts mode,r24
.L5:
	lds r24,serie
	cpi r24,lo8(12)
	brlo .L6
	ldi r24,lo8(1)
	sts serie,r24
.L6:
	lds r24,brightness
	cpi r24,lo8(3)
	brlo .L7
	sts brightness,__zero_reg__
.L7:
	lds r24,wmode
	cpi r24,lo8(4)
	brlo .L8
	sts wmode,__zero_reg__
.L8:
	ldi r30,lo8(modes)
	ldi r31,hi8(modes)
	ldi r26,lo8(series)
	ldi r27,hi8(series)
	ldi r24,lo8(1)
.L11:
	ld r25,Z
	cpi r25,lo8(10)
	brlo .L9
	st Z,r24
.L9:
	ld r25,X
	cpi r25,lo8(12)
	brlo .L10
	st X,r24
.L10:
	adiw r30,1
	adiw r26,1
	ldi r25,hi8(modes+15)
	cpi r30,lo8(modes+15)
	cpc r31,r25
	brne .L11
	lds r24,counter
	cpi r24,lo8(16)
	brlo .L12
	sts counter,__zero_reg__
.L12:
	lds r24,counter
	lds r25,pointer
	cp r25,r24
	brlo .L13
	sts pointer,r24
.L13:
	lds r24,fav_on
	cpi r24,lo8(2)
	brlo .L14
	sts fav_on,__zero_reg__
.L14:
	ldi r24,lo8(10)
	sts power,r24
	ret
	.size	check_all, .-check_all
.global	read_data
	.type	read_data, @function
read_data:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(e_mode)
	ldi r25,hi8(e_mode)
	rcall eeprom_read_byte
	sts mode,r24
	ldi r24,lo8(e_serie)
	ldi r25,hi8(e_serie)
	rcall eeprom_read_byte
	sts serie,r24
	ldi r20,lo8(15)
	ldi r21,0
	ldi r22,lo8(fm)
	ldi r23,hi8(fm)
	ldi r24,lo8(modes)
	ldi r25,hi8(modes)
	rcall eeprom_read_block
	ldi r20,lo8(15)
	ldi r21,0
	ldi r22,lo8(sm)
	ldi r23,hi8(sm)
	ldi r24,lo8(series)
	ldi r25,hi8(series)
	rcall eeprom_read_block
	ldi r24,lo8(e_pointer)
	ldi r25,hi8(e_pointer)
	rcall eeprom_read_byte
	sts pointer,r24
	ldi r24,lo8(e_counter)
	ldi r25,hi8(e_counter)
	rcall eeprom_read_byte
	sts counter,r24
	ldi r24,lo8(e_fav_on)
	ldi r25,hi8(e_fav_on)
	rcall eeprom_read_byte
	sts fav_on,r24
	ldi r24,lo8(e_power)
	ldi r25,hi8(e_power)
	rcall eeprom_read_byte
	sts power,r24
	ldi r24,lo8(e_brightness)
	ldi r25,hi8(e_brightness)
	rcall eeprom_read_byte
	sts brightness,r24
	ldi r24,lo8(e_wmode)
	ldi r25,hi8(e_wmode)
	rcall eeprom_read_byte
	sts wmode,r24
	rjmp check_all
	.size	read_data, .-read_data
.global	store_data
	.type	store_data, @function
store_data:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r22,mode
	ldi r24,lo8(e_mode)
	ldi r25,hi8(e_mode)
	rcall eeprom_write_byte
	lds r22,serie
	ldi r24,lo8(e_serie)
	ldi r25,hi8(e_serie)
	rcall eeprom_write_byte
	ldi r20,lo8(15)
	ldi r21,0
	ldi r22,lo8(fm)
	ldi r23,hi8(fm)
	ldi r24,lo8(modes)
	ldi r25,hi8(modes)
	rcall eeprom_write_block
	ldi r20,lo8(15)
	ldi r21,0
	ldi r22,lo8(sm)
	ldi r23,hi8(sm)
	ldi r24,lo8(series)
	ldi r25,hi8(series)
	rcall eeprom_write_block
	lds r22,pointer
	ldi r24,lo8(e_pointer)
	ldi r25,hi8(e_pointer)
	rcall eeprom_write_byte
	lds r22,counter
	ldi r24,lo8(e_counter)
	ldi r25,hi8(e_counter)
	rcall eeprom_write_byte
	lds r22,fav_on
	ldi r24,lo8(e_fav_on)
	ldi r25,hi8(e_fav_on)
	rcall eeprom_write_byte
	lds r22,power
	ldi r24,lo8(e_power)
	ldi r25,hi8(e_power)
	rcall eeprom_write_byte
	lds r22,brightness
	ldi r24,lo8(e_brightness)
	ldi r25,hi8(e_brightness)
	rcall eeprom_write_byte
	lds r22,wmode
	ldi r24,lo8(e_wmode)
	ldi r25,hi8(e_wmode)
	rjmp eeprom_write_byte
	.size	store_data, .-store_data
.global	init_io
	.type	init_io, @function
init_io:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(15)
	out 0x17,r24
	ldi r24,lo8(31)
	out 0x18,r24
	ret
	.size	init_io, .-init_io
.global	wake
	.type	wake, @function
wake:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	rcall init_io
	out 0x3b,__zero_reg__
	out 0x15,__zero_reg__
/* #APP */
 ;  218 "csb-light-grbw-4.0a.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	ldi r18,lo8(799999)
	ldi r24,hi8(799999)
	ldi r25,hlo8(799999)
1:	subi r18,1
	sbci r24,0
	sbci r25,0
	brne 1b
	rjmp .
	nop
	in r24,0x16
	sbrc r24,4
	rjmp .L20
	ldi r25,lo8(10)
	sts power,r25
	ldi r25,lo8(27)
	out 0x18,r25
.L21:
	sbrc r24,4
	rjmp .L24
	in r24,0x16
	rjmp .L21
.L24:
	ldi r18,lo8(79999)
	ldi r24,hi8(79999)
	ldi r25,hlo8(79999)
1:	subi r18,1
	sbci r24,0
	sbci r25,0
	brne 1b
	rjmp .
	nop
	ldi r24,lo8(1)
	ret
.L20:
	ldi r24,lo8(3)
	sts power,r24
	ldi r24,lo8(20)
	out 0x18,r24
	ldi r24,0
	ret
	.size	wake, .-wake
.global	process_button
	.type	process_button, @function
process_button:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,57
	ldi r18,74
	cpc r25,r18
	brlo .L26
	ldi r24,lo8(12)
	sts stat,r24
	or r22,r23
	breq .L27
.L30:
	ldi r24,0
	ret
.L27:
	sts pointer,__zero_reg__
	sts counter,__zero_reg__
	rjmp .L31
.L26:
	cpi r24,-127
	ldi r18,62
	cpc r25,r18
	brlo .L29
	ldi r24,lo8(11)
	sts stat,r24
	or r22,r23
	brne .L30
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L31
	ldi r24,lo8(1)
	sts fav_on,r24
	sts pointer,r24
	rjmp .L52
.L31:
	sts fav_on,__zero_reg__
	rjmp .L52
.L29:
	cpi r24,-31
	ldi r18,46
	cpc r25,r18
	brlo .L33
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L30
	lds r24,counter
	cpi r24,lo8(15)
	brsh .L30
	ldi r25,lo8(10)
	sts stat,r25
	or r22,r23
	brne .L30
	subi r24,lo8(-(1))
	sts counter,r24
	ldi r25,0
	movw r30,r24
	subi r30,lo8(-(modes))
	sbci r31,hi8(-(modes))
	lds r18,mode
	st Z,r18
	movw r30,r24
	subi r30,lo8(-(series))
	sbci r31,hi8(-(series))
	lds r18,serie
	st Z,r18
.L52:
	rcall check_all
	rjmp .L51
.L33:
	cpi r24,41
	ldi r18,35
	cpc r25,r18
	brlo .L34
	ldi r24,lo8(17)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L30
	lds r24,wmode
	subi r24,lo8(-(1))
	cpi r24,lo8(4)
	brsh .L35
	sts wmode,r24
	rjmp .L51
.L35:
	sts wmode,__zero_reg__
	rjmp .L51
.L34:
	cpi r24,113
	ldi r18,23
	cpc r25,r18
	brlo .L37
	ldi r24,lo8(16)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L30
	lds r24,brightness
	subi r24,lo8(-(1))
	cpi r24,lo8(3)
	brsh .L38
	sts brightness,r24
	rjmp .L51
.L38:
	sts brightness,__zero_reg__
	rjmp .L51
.L37:
	cpi r24,-71
	ldi r18,11
	cpc r25,r18
	brlo .L40
	ldi r24,lo8(14)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L30
	ldi r24,lo8(3)
	sts power,r24
	rjmp .L51
.L40:
	cpi r24,-23
	ldi r18,3
	cpc r25,r18
	brlo .L41
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L30
	ldi r24,lo8(13)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L30
	lds r24,serie
	subi r24,lo8(-(1))
	cpi r24,lo8(12)
	brlo .L48
	ldi r24,lo8(1)
.L48:
	sts serie,r24
	ldi r24,lo8(1)
	sts mode,r24
.L51:
	rcall store_data
	sts stat,__zero_reg__
	rjmp .L50
.L41:
	cpi r24,101
	cpc r25,__zero_reg__
	brsh .+2
	rjmp .L30
	or r22,r23
	breq .+2
	rjmp .L30
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L44
	lds r24,mode
	subi r24,lo8(-(1))
	cpi r24,lo8(10)
	brlo .L49
	ldi r24,lo8(1)
.L49:
	sts mode,r24
	rjmp .L46
.L44:
	lds r24,pointer
	subi r24,lo8(-(1))
	sts pointer,r24
	lds r25,counter
	cp r25,r24
	brsh .L46
	ldi r24,lo8(1)
	sts pointer,r24
.L46:
	rcall check_all
	rcall store_data
.L50:
	ldi r24,lo8(1)
	ret
	.size	process_button, .-process_button
.global	check_button
	.type	check_button, @function
check_button:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbis 0x16,4
	rjmp .L54
	sts button_state,__zero_reg__
	rjmp .L55
.L54:
	ldi r24,lo8(1)
	sts button_state,r24
.L55:
	lds r22,button_state
	cpi r22,lo8(1)
	brne .L56
	lds r24,hold.1933
	lds r25,hold.1933+1
	adiw r24,1
	sts hold.1933+1,r25
	sts hold.1933,r24
.L56:
	lds r24,last_button_state.1934
	cpse r22,r24
	rjmp .L59
	ldi r23,0
	lds r24,hold.1933
	lds r25,hold.1933+1
	rcall process_button
	rjmp .L57
.L59:
	ldi r24,0
.L57:
	lds r25,button_state
	cpse r25,__zero_reg__
	rjmp .L58
	lds r18,last_button_state.1934
	cpse r18,__zero_reg__
	rjmp .L58
	sts hold.1933+1,__zero_reg__
	sts hold.1933,__zero_reg__
.L58:
	sts last_button_state.1934,r25
	ret
	.size	check_button, .-check_button
.global	make_light
	.type	make_light, @function
make_light:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r25,wmode
	cpi r25,lo8(1)
	breq .L67
	brlo .L66
	cpi r25,lo8(2)
	breq .L64
	cpi r25,lo8(3)
	breq .L65
	rjmp .L61
.L64:
	mov r18,r22
	ldi r19,0
	add r18,r24
	adc r19,__zero_reg__
	add r18,r20
	adc r19,__zero_reg__
	or r18,r19
	breq .L66
.L67:
	ldi r25,lo8(-116)
	sts w,r25
	rjmp .L61
.L65:
	mov r18,r22
	ldi r19,0
	add r18,r24
	adc r19,__zero_reg__
	add r18,r20
	adc r19,__zero_reg__
	or r18,r19
	breq .L67
.L66:
	sts w,__zero_reg__
.L61:
	lds r19,w
	lds r25,button_state
	cpse r25,__zero_reg__
	rjmp .L68
	lds r25,brightness
	cpi r25,lo8(1)
	brne .L69
	lsr r24
	lsr r24
	lsr r22
	lsr r22
	lsr r20
	lsr r20
	lsr r19
	lsr r19
	rjmp .L68
.L69:
	cpi r25,lo8(2)
	brne .L68
	swap r24
	andi r24,lo8(15)
	swap r22
	andi r22,lo8(15)
	swap r20
	andi r20,lo8(15)
	swap r19
	andi r19,lo8(15)
.L68:
	ldi r18,0
.L74:
	cp r18,r24
	brsh .L75
	ldi r25,lo8(34)
	rjmp .L70
.L75:
	ldi r25,lo8(32)
.L70:
	cp r18,r22
	brsh .L71
	ori r25,lo8(1)
.L71:
	cp r18,r20
	brsh .L72
	ori r25,lo8(4)
.L72:
	cp r18,r19
	brsh .L73
	ori r25,lo8(8)
.L73:
	out 0x18,r25
	subi r18,lo8(-(1))
	cpi r18,lo8(-116)
	brne .L74
	rjmp check_button
	.size	make_light, .-make_light
.global	make_light_color
	.type	make_light_color, @function
make_light_color:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(2)
	breq .L85
	cpi r24,lo8(3)
	breq .L86
	cpi r24,lo8(1)
	brne .L96
	ldi r20,0
	rjmp .L103
.L85:
	ldi r20,0
	rjmp .L102
.L86:
	ldi r20,0
	rjmp .L101
.L96:
	cpi r24,lo8(5)
	breq .L89
	cpi r24,lo8(6)
	breq .L90
	cpi r24,lo8(4)
	brne .L97
	ldi r20,0
	rjmp .L105
.L89:
	ldi r20,lo8(1)
.L105:
	ldi r22,lo8(1)
	rjmp .L104
.L90:
	ldi r20,lo8(1)
.L103:
	ldi r22,0
.L104:
	ldi r24,0
	rjmp .L99
.L97:
	cpi r24,lo8(8)
	breq .L94
	cpi r24,lo8(9)
	breq .L94
	cpi r24,lo8(7)
	brne .L98
	ldi r20,lo8(1)
.L102:
	ldi r22,0
	rjmp .L100
.L94:
	ldi r20,lo8(1)
.L101:
	ldi r22,lo8(1)
.L100:
	ldi r24,lo8(1)
.L99:
	rjmp make_light
.L98:
	ldi r24,0
	ret
	.size	make_light_color, .-make_light_color
.global	l_make_light
	.type	l_make_light, @function
l_make_light:
	push r13
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 7 */
.L__stack_usage = 7
	mov r15,r24
	mov r14,r22
	mov r13,r20
	movw r16,r18
	ldi r28,0
	ldi r29,0
.L107:
	cp r28,r16
	cpc r29,r17
	breq .L113
	mov r20,r13
	mov r22,r14
	mov r24,r15
	rcall make_light
	cpi r24,lo8(1)
	breq .L108
	adiw r28,1
	rjmp .L107
.L113:
	ldi r24,0
.L108:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	ret
	.size	l_make_light, .-l_make_light
.global	basic_pulse
	.type	basic_pulse, @function
basic_pulse:
	push r11
	push r12
	push r13
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 9 */
.L__stack_usage = 9
	mov r29,r24
	mov r17,r22
	mov r15,r20
	mov r11,r18
	ldi r28,lo8(1)
.L118:
	mov r20,r15
	and r20,r28
	or r20,r14
	mov r22,r17
	and r22,r28
	or r22,r16
	movw r18,r12
	mov r24,r29
	and r24,r28
	or r24,r11
	rcall l_make_light
	cpi r24,lo8(1)
	brne .L115
.L117:
	ldi r24,lo8(1)
	rjmp .L116
.L115:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L117
	subi r28,lo8(-(1))
	cpi r28,lo8(-115)
	brne .L118
	ldi r28,lo8(-116)
.L119:
	mov r20,r15
	and r20,r28
	or r20,r14
	mov r22,r17
	and r22,r28
	or r22,r16
	movw r18,r12
	mov r24,r29
	and r24,r28
	or r24,r11
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L117
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L117
	subi r28,lo8(-(-1))
	brne .L119
.L116:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	ret
	.size	basic_pulse, .-basic_pulse
.global	make_pulse
	.type	make_pulse, @function
make_pulse:
	push r12
	push r13
	push r14
	push r16
/* prologue: function */
/* frame size = 0 */
/* stack size = 4 */
.L__stack_usage = 4
	cpi r24,lo8(2)
	breq .L127
	cpi r24,lo8(3)
	breq .L128
	cpi r24,lo8(1)
	brne .L139
	ldi r30,lo8(30)
	mov r12,r30
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,0
	rjmp .L143
.L127:
	ldi r23,lo8(30)
	mov r12,r23
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,0
	rjmp .L145
.L128:
	ldi r22,lo8(30)
	mov r12,r22
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,0
	rjmp .L147
.L139:
	cpi r24,lo8(5)
	breq .L132
	cpi r24,lo8(6)
	breq .L133
	cpi r24,lo8(4)
	brne .L140
	ldi r21,lo8(30)
	mov r12,r21
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
.L147:
	ldi r22,lo8(-1)
	rjmp .L146
.L132:
	ldi r20,lo8(30)
	mov r12,r20
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
	ldi r22,0
.L146:
	ldi r24,0
	rjmp .L144
.L133:
	ldi r19,lo8(30)
	mov r12,r19
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
	rjmp .L143
.L140:
	cpi r24,lo8(8)
	breq .L135
	cpi r24,lo8(9)
	breq .L136
	cpi r24,lo8(7)
	brne .L141
	ldi r18,lo8(30)
	mov r12,r18
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
.L145:
	ldi r22,lo8(-1)
	rjmp .L142
.L135:
	ldi r25,lo8(30)
	mov r12,r25
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,lo8(-1)
	ldi r20,0
	ldi r22,lo8(63)
	rjmp .L142
.L136:
	ldi r24,lo8(30)
	mov r12,r24
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,lo8(25)
	ldi r20,lo8(63)
.L143:
	ldi r22,0
.L142:
	ldi r24,lo8(-1)
.L144:
	rcall basic_pulse
	rjmp .L130
.L141:
	ldi r24,0
.L130:
/* epilogue start */
	pop r16
	pop r14
	pop r13
	pop r12
	ret
	.size	make_pulse, .-make_pulse
.global	make_grad
	.type	make_grad, @function
make_grad:
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 3 */
.L__stack_usage = 3
	movw r28,r24
	ldi r17,0
.L151:
	movw r18,r28
	ldi r20,0
	mov r22,r17
	ldi r24,lo8(-116)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L148
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L148
	subi r17,lo8(-(1))
	cpi r17,lo8(-115)
	brne .L151
	ldi r17,lo8(-117)
.L152:
	movw r18,r28
	ldi r20,0
	ldi r22,lo8(-116)
	mov r24,r17
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L148
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L148
	subi r17,1
	brcc .L152
	ldi r17,lo8(1)
.L153:
	movw r18,r28
	mov r20,r17
	ldi r22,lo8(-116)
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L148
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L148
	subi r17,lo8(-(1))
	cpi r17,lo8(-115)
	brne .L153
	ldi r17,lo8(-117)
.L154:
	movw r18,r28
	ldi r20,lo8(-116)
	mov r22,r17
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L148
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L148
	subi r17,1
	brcc .L154
	ldi r17,lo8(1)
.L155:
	movw r18,r28
	ldi r20,lo8(-116)
	ldi r22,0
	mov r24,r17
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L148
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L148
	subi r17,lo8(-(1))
	cpi r17,lo8(-115)
	brne .L155
	ldi r17,lo8(-117)
.L156:
	movw r18,r28
	mov r20,r17
	ldi r22,0
	ldi r24,lo8(-116)
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L148
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L148
	subi r17,1
	brcc .L156
.L148:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	ret
	.size	make_grad, .-make_grad
.global	make_saw
	.type	make_saw, @function
make_saw:
	push r13
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 7 */
.L__stack_usage = 7
	mov r13,r24
	mov r14,r22
	mov r15,r20
	ldi r29,0
	ldi r17,0
	ldi r16,0
	ldi r28,lo8(-116)
.L180:
	ldi r18,lo8(5)
	ldi r19,0
	mov r20,r29
	mov r22,r17
	mov r24,r16
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L179
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L181
	subi r28,lo8(-(-1))
	add r16,r13
	add r17,r14
	add r29,r15
	cpse r28,__zero_reg__
	rjmp .L180
	rjmp .L179
.L181:
	ldi r24,lo8(1)
.L179:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	ret
	.size	make_saw, .-make_saw
.global	make_saw_rainbow
	.type	make_saw_rainbow, @function
make_saw_rainbow:
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	ldi r28,lo8(-116)
.L190:
	ldi r18,lo8(2)
	ldi r19,0
	mov r20,r28
	mov r22,r28
	ldi r24,lo8(-116)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L186
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L186
	subi r28,lo8(-(-1))
	brne .L190
.L191:
	ldi r18,lo8(2)
	ldi r19,0
	ldi r20,0
	mov r22,r28
	ldi r24,lo8(-116)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L186
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L186
	subi r28,lo8(-(1))
	cpi r28,lo8(-116)
	brne .L191
.L192:
	ldi r18,lo8(2)
	ldi r19,0
	ldi r20,0
	ldi r22,lo8(-116)
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L186
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L186
	subi r28,lo8(-(-1))
	brne .L192
.L193:
	ldi r18,lo8(2)
	ldi r19,0
	mov r20,r28
	ldi r22,lo8(-116)
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L186
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L186
	subi r28,lo8(-(1))
	cpi r28,lo8(-116)
	brne .L193
.L194:
	ldi r18,lo8(2)
	ldi r19,0
	ldi r20,lo8(-116)
	mov r22,r28
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L186
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L186
	subi r28,lo8(-(-1))
	brne .L194
	ldi r28,lo8(-116)
.L195:
	ldi r18,lo8(2)
	ldi r19,0
	mov r20,r28
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L186
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L186
	subi r28,lo8(-(-1))
	brne .L195
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
/* epilogue start */
	pop r28
	rjmp l_make_light
.L186:
/* epilogue start */
	pop r28
	ret
	.size	make_saw_rainbow, .-make_saw_rainbow
.global	make_mix_2
	.type	make_mix_2, @function
make_mix_2:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(3)
	breq .L233
	brsh .L220
	cpi r24,lo8(1)
	breq .L221
	cpi r24,lo8(2)
	brne .L218
	ldi r20,0
	ldi r22,lo8(1)
	rjmp .L259
.L220:
	cpi r24,lo8(4)
	breq .L223
	cpi r24,lo8(5)
	breq .L224
	rjmp .L218
.L221:
	ldi r20,0
	rjmp .L261
.L230:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
.L257:
	rcall make_saw
	cpi r24,lo8(1)
	brne .+2
	rjmp .L217
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L217
.L233:
	ldi r20,lo8(1)
	ldi r22,0
.L259:
	ldi r24,0
.L258:
	rjmp make_saw
.L223:
	ldi r20,lo8(1)
	ldi r22,lo8(1)
.L260:
	ldi r24,lo8(1)
	rjmp .L258
.L224:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	brne .+2
	rjmp .L217
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L217
	ldi r20,0
	ldi r22,lo8(1)
	rjmp .L258
.L218:
	cpi r24,lo8(7)
	breq .L228
	brsh .L229
	cpi r24,lo8(6)
	breq .L230
	ret
.L229:
	cpi r24,lo8(8)
	breq .L231
	cpi r24,lo8(9)
	breq .L232
	ret
.L228:
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,0
	rjmp .L257
.L231:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L217
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L217
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L217
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L217
	ldi r20,0
	ldi r22,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L217
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L217
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L217
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L217
	ldi r20,lo8(1)
	ldi r22,0
	rcall make_saw
	cpi r24,lo8(1)
	breq .L217
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L217
	ldi r20,lo8(1)
.L261:
	ldi r22,0
	rjmp .L260
.L232:
	rjmp make_saw_rainbow
.L217:
	ret
	.size	make_mix_2, .-make_mix_2
.global	make_color
	.type	make_color, @function
make_color:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(1)
	breq .L264
	brlo .L265
	cpi r24,lo8(2)
	breq .L266
	cpi r24,lo8(3)
	brne .L303
	ldi r20,0
	rjmp .L296
.L265:
	ldi r20,0
	rjmp .L294
.L264:
	ldi r20,0
	rjmp .L299
.L266:
	ldi r20,0
	rjmp .L300
.L303:
	cpi r24,lo8(5)
	breq .L269
	cpi r24,lo8(6)
	breq .L270
	cpi r24,lo8(4)
	brne .L288
	ldi r20,0
	ldi r22,lo8(-116)
	rjmp .L291
.L269:
	ldi r20,lo8(-116)
	ldi r22,lo8(50)
	rjmp .L291
.L270:
	ldi r20,lo8(-116)
	rjmp .L294
.L288:
	cpi r24,lo8(8)
	breq .L273
	cpi r24,lo8(9)
	breq .L274
	cpi r24,lo8(7)
	brne .L289
	ldi r20,lo8(-116)
.L299:
	ldi r22,0
	rjmp .L295
.L273:
	ldi r20,lo8(50)
.L300:
	ldi r22,lo8(50)
	rjmp .L295
.L274:
	ldi r20,lo8(-116)
.L296:
	ldi r22,lo8(-116)
.L295:
	ldi r24,lo8(-116)
	rjmp .L292
.L289:
	cpi r24,lo8(12)
	breq .L301
	brsh .L278
	cpi r24,lo8(10)
	breq .L279
	cpi r24,lo8(11)
	brne .L276
	ldi r20,0
	rjmp .L298
.L278:
	cpi r24,lo8(13)
	breq .L281
	cpi r24,lo8(14)
	brne .L276
	ldi r20,0
	rjmp .L302
.L279:
	ldi r20,0
	rjmp .L293
.L281:
	ldi r20,lo8(10)
.L294:
	ldi r22,0
	rjmp .L291
.L276:
	cpi r24,lo8(16)
	breq .L284
	cpi r24,lo8(17)
	breq .L285
	cpi r24,lo8(15)
	brne .L290
.L301:
	ldi r20,lo8(10)
.L302:
	ldi r22,lo8(10)
	rjmp .L297
.L284:
	ldi r20,lo8(10)
.L298:
	ldi r22,0
.L297:
	ldi r24,lo8(10)
	rjmp .L292
.L285:
	ldi r20,lo8(10)
.L293:
	ldi r22,lo8(10)
.L291:
	ldi r24,0
.L292:
	rjmp make_light
.L290:
	ldi r24,0
	ret
	.size	make_color, .-make_color
.global	long_color
	.type	long_color, @function
long_color:
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 5 */
.L__stack_usage = 5
	movw r16,r24
	mov r15,r22
	ldi r28,0
	ldi r29,0
.L305:
	cp r28,r16
	cpc r29,r17
	breq .L311
	mov r24,r15
	rcall make_color
	cpi r24,lo8(1)
	breq .L306
	adiw r28,1
	rjmp .L305
.L311:
	ldi r24,0
.L306:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	ret
	.size	long_color, .-long_color
.global	make_grad_2
	.type	make_grad_2, @function
make_grad_2:
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 4 */
.L__stack_usage = 4
	movw r16,r24
	ldi r28,lo8(1)
	ldi r29,0
.L314:
	movw r22,r28
	movw r24,r16
	rcall long_color
	cpi r24,lo8(1)
	breq .L312
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L312
	adiw r28,1
	cpi r28,10
	cpc r29,__zero_reg__
	brne .L314
.L312:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	ret
	.size	make_grad_2, .-make_grad_2
.global	grad_serie
	.type	grad_serie, @function
grad_serie:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	cpi r24,lo8(3)
	breq .L321
	brsh .L322
	cpi r24,lo8(1)
	breq .L323
	cpi r24,lo8(2)
	brne .L320
	ldi r24,lo8(10)
	ldi r25,0
	rjmp .L338
.L322:
	cpi r24,lo8(4)
	breq .L325
	cpi r24,lo8(5)
	brne .L320
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
	rjmp .L338
.L323:
	ldi r24,lo8(2)
	ldi r25,0
	rjmp .L338
.L321:
	ldi r24,lo8(50)
	ldi r25,0
.L338:
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad
.L325:
	ldi r24,lo8(100)
	ldi r25,0
	rjmp .L338
.L320:
	cpi r24,lo8(7)
	breq .L328
	brsh .L329
	cpi r24,lo8(6)
	brne .L319
	ldi r24,lo8(100)
	ldi r25,0
	rjmp .L339
.L329:
	cpi r24,lo8(8)
	breq .L331
	cpi r24,lo8(9)
	brne .L319
	ldi r28,lo8(1)
	ldi r29,0
	rjmp .L333
.L328:
	ldi r24,lo8(-112)
	ldi r25,lo8(1)
	rjmp .L339
.L331:
	ldi r24,lo8(-80)
	ldi r25,lo8(4)
.L339:
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad_2
.L340:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L319
	adiw r28,1
	cpi r28,9
	cpc r29,__zero_reg__
	breq .L319
.L333:
	movw r22,r28
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .L340
.L319:
/* epilogue start */
	pop r29
	pop r28
	ret
	.size	grad_serie, .-grad_serie
.global	make_mix
	.type	make_mix, @function
make_mix:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(3)
	breq .L343
	brsh .L344
	cpi r24,lo8(1)
	breq .L345
	cpi r24,lo8(2)
	breq .L346
	rjmp .L342
.L344:
	cpi r24,lo8(4)
	breq .L347
	cpi r24,lo8(5)
	brne .+2
	rjmp .L348
	rjmp .L342
.L345:
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L341
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L341
	ldi r22,lo8(4)
	ldi r23,0
	rjmp .L416
.L346:
	ldi r22,lo8(4)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L341
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L341
	ldi r22,lo8(6)
	ldi r23,0
.L416:
	ldi r24,lo8(60)
	ldi r25,0
	rjmp .L414
.L343:
	ldi r22,lo8(6)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L341
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L341
	ldi r22,lo8(1)
	ldi r23,0
	rjmp .L416
.L347:
	ldi r22,lo8(2)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L341
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L341
	ldi r22,lo8(5)
	ldi r23,0
	rjmp .L416
.L348:
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L341
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L341
	ldi r22,lo8(2)
	ldi r23,0
	rjmp .L416
.L342:
	cpi r24,lo8(7)
	breq .L352
	brsh .L353
	cpi r24,lo8(6)
	breq .L354
	ret
.L353:
	cpi r24,lo8(8)
	brne .+2
	rjmp .L355
	cpi r24,lo8(9)
	brne .+2
	rjmp .L356
	ret
.L354:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L341
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L341
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L341
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L341
	ldi r22,lo8(4)
	ldi r23,0
	rjmp .L410
.L352:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L341
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L341
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L341
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L341
	ldi r22,lo8(6)
	ldi r23,0
.L410:
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L341
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L341
	ldi r22,lo8(1)
	ldi r23,0
	rjmp .L415
.L355:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L341
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L341
	ldi r22,lo8(9)
	ldi r23,0
	rjmp .L413
.L356:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L341
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L341
	ldi r22,lo8(4)
	ldi r23,0
.L413:
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L341
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L341
	ldi r22,lo8(6)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L341
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L341
	ldi r22,lo8(4)
	ldi r23,0
.L415:
	ldi r24,lo8(45)
	ldi r25,0
.L414:
	rjmp long_color
.L341:
	ret
	.size	make_mix, .-make_mix
.global	make_strob
	.type	make_strob, @function
make_strob:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r22
	mov r22,r20
	ldi r23,0
	rcall long_color
	cpi r24,lo8(1)
	brne .L418
.L420:
	ldi r24,lo8(1)
	rjmp .L419
.L418:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L420
	ldi r22,0
	ldi r23,0
	movw r24,r28
	rcall long_color
	cpi r24,lo8(1)
	breq .L420
	ldi r24,lo8(1)
	lds r25,stat
	cpse r25,__zero_reg__
	rjmp .L419
	ldi r24,0
.L419:
/* epilogue start */
	pop r29
	pop r28
	ret
	.size	make_strob, .-make_strob
.global	make_complex_strob
	.type	make_complex_strob, @function
make_complex_strob:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(3)
	breq .L427
	brsh .L428
	cpi r24,lo8(1)
	breq .L429
	cpi r24,lo8(2)
	brne .+2
	rjmp .L487
	rjmp .L426
.L428:
	cpi r24,lo8(4)
	breq .L431
	cpi r24,lo8(5)
	breq .L432
	rjmp .L426
.L429:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L425
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L425
	ldi r20,lo8(4)
	rjmp .L490
.L427:
	ldi r20,lo8(6)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L425
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L425
	ldi r20,lo8(1)
	rjmp .L490
.L431:
	ldi r20,lo8(2)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L425
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L425
	ldi r20,lo8(5)
	rjmp .L490
.L432:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L425
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L425
.L487:
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L425
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L425
	ldi r20,lo8(6)
	rjmp .L490
.L426:
	cpi r24,lo8(7)
	breq .L437
	brsh .L438
	cpi r24,lo8(6)
	breq .L439
	ret
.L438:
	cpi r24,lo8(8)
	brne .+2
	rjmp .L489
	cpi r24,lo8(9)
	breq .L441
	ret
.L439:
	ldi r20,lo8(1)
	rjmp .L488
.L437:
	ldi r20,lo8(4)
.L488:
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L425
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L425
	ldi r20,lo8(9)
.L490:
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L441:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L425
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L425
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L425
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L425
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L425
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L425
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L425
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L425
.L489:
	ldi r20,lo8(6)
	rjmp .L488
.L425:
	ret
	.size	make_complex_strob, .-make_complex_strob
.global	make_serie
	.type	make_serie, @function
make_serie:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	mov r25,r24
	mov r24,r22
	cpi r25,lo8(3)
	breq .L493
	brsh .L494
	cpi r25,lo8(1)
	breq .L495
	cpi r25,lo8(2)
	brne .L492
	mov r20,r22
	ldi r22,lo8(20)
	ldi r23,0
	ldi r24,lo8(20)
	ldi r25,0
	rjmp .L507
.L494:
	cpi r25,lo8(4)
	breq .L497
	cpi r25,lo8(5)
	brne .L492
	mov r20,r22
	ldi r22,lo8(-12)
	ldi r23,lo8(1)
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
	rjmp .L507
.L495:
	rjmp make_color
.L493:
	mov r20,r22
	ldi r22,lo8(50)
	ldi r23,0
	ldi r24,lo8(50)
	ldi r25,0
.L507:
	rjmp make_strob
.L497:
	mov r20,r22
	ldi r22,lo8(100)
	ldi r23,0
	ldi r24,lo8(100)
	ldi r25,0
	rjmp .L507
.L492:
	cpi r25,lo8(8)
	breq .L500
	brsh .L501
	cpi r25,lo8(6)
	breq .L502
	cpi r25,lo8(7)
	breq .L503
	ret
.L501:
	cpi r25,lo8(10)
	breq .L504
	brlo .L505
	cpi r25,lo8(11)
	breq .L506
	ret
.L502:
	rjmp make_pulse
.L503:
	rjmp grad_serie
.L500:
	rjmp make_complex_strob
.L505:
	rjmp make_mix
.L504:
	rjmp make_mix_2
.L506:
	rjmp make_light_color
	.size	make_serie, .-make_serie
	.section	.text.startup,"ax",@progbits
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	rcall read_data
	rcall init_io
	out 0x3b,__zero_reg__
	out 0x15,__zero_reg__
/* #APP */
 ;  247 "csb-light-grbw-4.0a.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	sts stat,__zero_reg__
	ldi r28,lo8(32)
.L509:
	lds r24,power
	cpi r24,lo8(2)
	brne .L510
	rcall init_io
	out 0x3b,__zero_reg__
	out 0x15,__zero_reg__
/* #APP */
 ;  255 "csb-light-grbw-4.0a.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	ldi r24,lo8(10)
	sts power,r24
.L512:
	in r24,0x16
	sbrs r24,4
	rjmp .L512
	ldi r18,lo8(79999)
	ldi r24,hi8(79999)
	ldi r25,hlo8(79999)
1:	subi r18,1
	sbci r24,0
	sbci r25,0
	brne 1b
	rjmp .
	nop
	rjmp .L509
.L510:
	cpi r24,lo8(3)
	brne .L514
	out 0x17,__zero_reg__
	ldi r25,lo8(16)
	out 0x18,r25
	in r24,0x35
	andi r24,lo8(-25)
	ori r24,lo8(16)
	out 0x35,r24
	in r24,0x35
	ori r24,lo8(32)
	out 0x35,r24
	out 0x3b,r28
	out 0x15,r25
/* #APP */
 ;  280 "csb-light-grbw-4.0a.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
	sts power,__zero_reg__
/* #APP */
 ;  282 "csb-light-grbw-4.0a.c" 1
	sleep
	
 ;  0 "" 2
/* #NOAPP */
	in r24,0x35
	andi r24,lo8(-33)
	out 0x35,r24
	rjmp .L509
.L514:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L515
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L516
	lds r22,mode
	lds r24,serie
	rjmp .L529
.L516:
	lds r24,counter
	tst r24
	breq .L517
	lds r24,pointer
	ldi r25,0
	movw r30,r24
	subi r30,lo8(-(modes))
	sbci r31,hi8(-(modes))
	movw r26,r24
	subi r26,lo8(-(series))
	sbci r27,hi8(-(series))
	ld r22,Z
	ld r24,X
.L529:
	rcall make_serie
	rjmp .L509
.L515:
	cpi r24,lo8(10)
	breq .L528
	cpi r24,lo8(11)
	breq .L528
	cpi r24,lo8(12)
	breq .L528
	cpi r24,lo8(13)
	breq .L528
	cpi r24,lo8(14)
	breq .L528
	cpi r24,lo8(15)
	breq .L528
	cpi r24,lo8(16)
	breq .L528
	cpi r24,lo8(17)
	breq .L528
.L517:
	ldi r24,0
.L528:
	rcall make_color
	rjmp .L509
	.size	main, .-main
	.local	last_button_state.1934
	.comm	last_button_state.1934,1,1
	.local	hold.1933
	.comm	hold.1933,2,1
.global	e_power
	.section	.eeprom,"aw",@progbits
	.type	e_power, @object
	.size	e_power, 1
e_power:
	.zero	1
	.comm	power,1,1
.global	e_fav_on
	.type	e_fav_on, @object
	.size	e_fav_on, 1
e_fav_on:
	.zero	1
.global	e_pointer
	.type	e_pointer, @object
	.size	e_pointer, 1
e_pointer:
	.zero	1
.global	e_counter
	.type	e_counter, @object
	.size	e_counter, 1
e_counter:
	.zero	1
.global	sm
	.type	sm, @object
	.size	sm, 16
sm:
	.zero	16
.global	fm
	.type	fm, @object
	.size	fm, 16
fm:
	.zero	16
	.comm	fav_on,1,1
	.comm	pointer,1,1
	.comm	counter,1,1
	.comm	series,16,1
	.comm	modes,16,1
.global	e_brightness
	.type	e_brightness, @object
	.size	e_brightness, 1
e_brightness:
	.zero	1
.global	e_wmode
	.type	e_wmode, @object
	.size	e_wmode, 1
e_wmode:
	.zero	1
.global	e_serie
	.type	e_serie, @object
	.size	e_serie, 1
e_serie:
	.zero	1
.global	e_mode
	.type	e_mode, @object
	.size	e_mode, 1
e_mode:
	.zero	1
.global	button_state
	.section .bss
	.type	button_state, @object
	.size	button_state, 1
button_state:
	.zero	1
	.comm	stat,1,1
	.comm	wmode,1,1
	.comm	w,1,1
	.comm	serie,1,1
	.comm	mode,1,1
	.comm	brightness,1,1
	.ident	"GCC: (GNU) 5.4.0"
.global __do_clear_bss
