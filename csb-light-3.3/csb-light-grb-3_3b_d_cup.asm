	.file	"csb-light-grb-3_3b_d_cup.c"
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
	ldi r24,lo8(3)
	sts mode,r24
.L5:
	lds r24,serie
	cpi r24,lo8(12)
	brlo .L6
	ldi r24,lo8(7)
	sts serie,r24
.L6:
	ldi r30,lo8(modes)
	ldi r31,hi8(modes)
	ldi r26,lo8(series)
	ldi r27,hi8(series)
	ldi r24,lo8(1)
.L9:
	ld r25,Z
	cpi r25,lo8(10)
	brlo .L7
	st Z,r24
.L7:
	ld r25,X
	cpi r25,lo8(12)
	brlo .L8
	st X,r24
.L8:
	adiw r30,1
	adiw r26,1
	ldi r25,hi8(modes+15)
	cpi r30,lo8(modes+15)
	cpc r31,r25
	brne .L9
	lds r24,counter
	cpi r24,lo8(16)
	brlo .L10
	sts counter,__zero_reg__
.L10:
	lds r24,counter
	lds r25,pointer
	cp r25,r24
	brlo .L11
	sts pointer,r24
.L11:
	lds r24,fav_on
	cpi r24,lo8(2)
	brlo .L12
	sts fav_on,__zero_reg__
.L12:
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
	rjmp eeprom_write_byte
	.size	store_data, .-store_data
.global	init_io
	.type	init_io, @function
init_io:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(7)
	out 0x17,r24
	ldi r24,lo8(23)
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
 ;  183 "csb-light-grb-3_3b_d_cup.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	ldi r18,lo8(99999)
	ldi r24,hi8(99999)
	ldi r25,hlo8(99999)
1:	subi r18,1
	sbci r24,0
	sbci r25,0
	brne 1b
	rjmp .
	nop
	in r24,0x16
	sbrc r24,4
	rjmp .L18
	ldi r25,lo8(10)
	sts power,r25
	ldi r25,lo8(19)
	out 0x18,r25
.L19:
	sbrc r24,4
	rjmp .L22
	in r24,0x16
	rjmp .L19
.L22:
	ldi r24,lo8(12499)
	ldi r25,hi8(12499)
1:	sbiw r24,1
	brne 1b
	rjmp .
	nop
	ldi r24,lo8(1)
	ret
.L18:
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
	cpi r24,81
	ldi r18,70
	cpc r25,r18
	brlo .L24
	ldi r24,lo8(12)
	sts stat,r24
	or r22,r23
	breq .L25
.L28:
	ldi r24,0
	ret
.L25:
	sts pointer,__zero_reg__
	sts counter,__zero_reg__
	rjmp .L29
.L24:
	cpi r24,17
	ldi r18,39
	cpc r25,r18
	brlo .L27
	ldi r24,lo8(11)
	sts stat,r24
	or r22,r23
	brne .L28
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L29
	ldi r24,lo8(1)
	sts fav_on,r24
	sts pointer,r24
	rjmp .L44
.L29:
	sts fav_on,__zero_reg__
	rjmp .L44
.L27:
	cpi r24,89
	ldi r18,27
	cpc r25,r18
	brlo .L31
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L28
	lds r24,counter
	cpi r24,lo8(15)
	brsh .L28
	ldi r25,lo8(10)
	sts stat,r25
	or r22,r23
	brne .L28
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
.L44:
	rcall check_all
	rjmp .L43
.L31:
	cpi r24,-71
	ldi r18,11
	cpc r25,r18
	brlo .L32
	ldi r24,lo8(14)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L28
	ldi r24,lo8(3)
	sts power,r24
	rjmp .L43
.L32:
	cpi r24,-23
	ldi r18,3
	cpc r25,r18
	brlo .L33
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L28
	ldi r24,lo8(13)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L28
	lds r24,serie
	subi r24,lo8(-(1))
	cpi r24,lo8(12)
	brlo .L40
	ldi r24,lo8(1)
.L40:
	sts serie,r24
	ldi r24,lo8(1)
	sts mode,r24
.L43:
	rcall store_data
	sts stat,__zero_reg__
	rjmp .L42
.L33:
	sbiw r24,51
	brsh .+2
	rjmp .L28
	or r22,r23
	breq .+2
	rjmp .L28
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L36
	lds r24,mode
	subi r24,lo8(-(1))
	cpi r24,lo8(10)
	brlo .L41
	ldi r24,lo8(1)
.L41:
	sts mode,r24
	rjmp .L38
.L36:
	lds r24,pointer
	subi r24,lo8(-(1))
	sts pointer,r24
	lds r25,counter
	cp r25,r24
	brsh .L38
	ldi r24,lo8(1)
	sts pointer,r24
.L38:
	rcall check_all
	rcall store_data
.L42:
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
	rjmp .L46
	sts button_state.1919,__zero_reg__
	rjmp .L47
.L46:
	ldi r24,lo8(1)
	sts button_state.1919,r24
.L47:
	lds r22,button_state.1919
	cpi r22,lo8(1)
	brne .L48
	lds r24,hold.1918
	lds r25,hold.1918+1
	adiw r24,1
	sts hold.1918+1,r25
	sts hold.1918,r24
.L48:
	lds r24,last_button_state.1920
	cpse r22,r24
	rjmp .L51
	ldi r23,0
	lds r24,hold.1918
	lds r25,hold.1918+1
	rcall process_button
	rjmp .L49
.L51:
	ldi r24,0
.L49:
	lds r25,button_state.1919
	cpse r25,__zero_reg__
	rjmp .L50
	lds r18,last_button_state.1920
	cpse r18,__zero_reg__
	rjmp .L50
	sts hold.1918+1,__zero_reg__
	sts hold.1918,__zero_reg__
.L50:
	sts last_button_state.1920,r25
	ret
	.size	check_button, .-check_button
.global	make_light
	.type	make_light, @function
make_light:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r25,0
.L56:
	cp r25,r24
	brsh .L57
	ldi r18,lo8(34)
	rjmp .L53
.L57:
	ldi r18,lo8(32)
.L53:
	cp r25,r22
	brsh .L54
	ori r18,lo8(1)
.L54:
	cp r25,r20
	brsh .L55
	ori r18,lo8(4)
.L55:
	out 0x18,r18
	subi r25,lo8(-(1))
	cpi r25,lo8(20)
	brne .L56
	rjmp check_button
	.size	make_light, .-make_light
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
.L60:
	cp r28,r16
	cpc r29,r17
	breq .L66
	mov r20,r13
	mov r22,r14
	mov r24,r15
	rcall make_light
	cpi r24,lo8(1)
	breq .L61
	adiw r28,1
	rjmp .L60
.L66:
	ldi r24,0
.L61:
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
.L71:
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
	brne .L68
.L70:
	ldi r24,lo8(1)
	rjmp .L69
.L68:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L70
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L71
	ldi r28,lo8(20)
.L72:
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
	breq .L70
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L70
	subi r28,lo8(-(-1))
	brne .L72
.L69:
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
	breq .L80
	cpi r24,lo8(3)
	breq .L81
	cpi r24,lo8(1)
	brne .L92
	ldi r30,lo8(-56)
	mov r12,r30
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	rjmp .L99
.L80:
	ldi r23,lo8(-56)
	mov r12,r23
	mov r13,__zero_reg__
	clr r14
	dec r14
.L99:
	ldi r16,0
	rjmp .L96
.L81:
	ldi r22,lo8(-56)
	mov r12,r22
	mov r13,__zero_reg__
	clr r14
	dec r14
	ldi r16,0
	ldi r18,0
	rjmp .L102
.L92:
	cpi r24,lo8(5)
	breq .L85
	cpi r24,lo8(6)
	breq .L86
	cpi r24,lo8(4)
	brne .L93
	ldi r21,lo8(-56)
	mov r12,r21
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
	rjmp .L101
.L85:
	ldi r20,lo8(-56)
	mov r12,r20
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,lo8(25)
	ldi r18,lo8(7)
	ldi r20,lo8(-1)
	ldi r22,0
	rjmp .L100
.L86:
	ldi r19,lo8(-56)
	mov r12,r19
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
	rjmp .L97
.L93:
	cpi r24,lo8(8)
	breq .L88
	cpi r24,lo8(9)
	breq .L89
	cpi r24,lo8(7)
	brne .L94
	ldi r18,lo8(-56)
	mov r12,r18
	mov r13,__zero_reg__
	clr r14
	dec r14
	ldi r16,0
	ldi r18,lo8(7)
.L102:
	ldi r20,0
.L101:
	ldi r22,lo8(-1)
.L100:
	ldi r24,0
	rjmp .L98
.L88:
	ldi r25,lo8(-56)
	mov r12,r25
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,lo8(-1)
	ldi r20,lo8(-1)
	ldi r22,lo8(-1)
	rjmp .L95
.L89:
	ldi r24,lo8(-56)
	mov r12,r24
	mov r13,__zero_reg__
	clr r14
	dec r14
	ldi r16,lo8(7)
.L96:
	ldi r18,0
	ldi r20,0
.L97:
	ldi r22,0
.L95:
	ldi r24,lo8(-1)
.L98:
	rcall basic_pulse
	rjmp .L83
.L94:
	ldi r24,0
.L83:
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
.L106:
	movw r18,r28
	ldi r20,0
	mov r22,r17
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L103
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L103
	subi r17,lo8(-(1))
	cpi r17,lo8(21)
	brne .L106
	ldi r17,lo8(19)
.L107:
	movw r18,r28
	ldi r20,0
	ldi r22,lo8(20)
	mov r24,r17
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L103
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L103
	subi r17,1
	brcc .L107
	ldi r17,lo8(1)
.L108:
	movw r18,r28
	mov r20,r17
	ldi r22,lo8(20)
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L103
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L103
	subi r17,lo8(-(1))
	cpi r17,lo8(21)
	brne .L108
	ldi r17,lo8(19)
.L109:
	movw r18,r28
	ldi r20,lo8(20)
	mov r22,r17
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L103
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L103
	subi r17,1
	brcc .L109
	ldi r17,lo8(1)
.L110:
	movw r18,r28
	ldi r20,lo8(20)
	ldi r22,0
	mov r24,r17
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L103
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L103
	subi r17,lo8(-(1))
	cpi r17,lo8(21)
	brne .L110
	ldi r17,lo8(19)
.L111:
	movw r18,r28
	mov r20,r17
	ldi r22,0
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L103
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L103
	subi r17,1
	brcc .L111
.L103:
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
	ldi r28,lo8(20)
.L135:
	ldi r18,lo8(5)
	ldi r19,0
	mov r20,r29
	mov r22,r17
	mov r24,r16
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L134
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L136
	subi r28,lo8(-(-1))
	add r16,r13
	add r17,r14
	add r29,r15
	cpse r28,__zero_reg__
	rjmp .L135
	rjmp .L134
.L136:
	ldi r24,lo8(1)
.L134:
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
	ldi r28,lo8(20)
.L145:
	ldi r18,lo8(2)
	ldi r19,0
	mov r20,r28
	mov r22,r28
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L141
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L141
	subi r28,lo8(-(-1))
	brne .L145
.L146:
	ldi r18,lo8(2)
	ldi r19,0
	ldi r20,0
	mov r22,r28
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L141
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L141
	subi r28,lo8(-(1))
	cpi r28,lo8(20)
	brne .L146
.L147:
	ldi r18,lo8(2)
	ldi r19,0
	ldi r20,0
	ldi r22,lo8(20)
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L141
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L141
	subi r28,lo8(-(-1))
	brne .L147
.L148:
	ldi r18,lo8(2)
	ldi r19,0
	mov r20,r28
	ldi r22,lo8(20)
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L141
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L141
	subi r28,lo8(-(1))
	cpi r28,lo8(20)
	brne .L148
.L149:
	ldi r18,lo8(2)
	ldi r19,0
	ldi r20,lo8(20)
	mov r22,r28
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L141
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L141
	subi r28,lo8(-(-1))
	brne .L149
	ldi r28,lo8(20)
.L150:
	ldi r18,lo8(2)
	ldi r19,0
	mov r20,r28
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L141
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L141
	subi r28,lo8(-(-1))
	brne .L150
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
/* epilogue start */
	pop r28
	rjmp l_make_light
.L141:
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
	breq .L188
	brsh .L175
	cpi r24,lo8(1)
	breq .L176
	cpi r24,lo8(2)
	brne .L173
	ldi r20,0
	rjmp .L202
.L175:
	cpi r24,lo8(4)
	breq .L178
	cpi r24,lo8(5)
	brne .L173
	ldi r20,lo8(1)
	rjmp .L200
.L176:
	ldi r20,0
	rjmp .L204
.L185:
	ldi r20,0
.L200:
	ldi r22,0
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L172
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L172
.L188:
	ldi r20,lo8(1)
.L202:
	ldi r22,lo8(1)
	ldi r24,0
.L201:
	rjmp make_saw
.L173:
	cpi r24,lo8(7)
	breq .L183
	brlo .L205
	cpi r24,lo8(8)
	brne .L206
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L172
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L172
.L178:
	ldi r20,lo8(1)
	ldi r22,lo8(1)
.L203:
	ldi r24,lo8(1)
	rjmp .L201
.L205:
	cpi r24,lo8(6)
	breq .L185
	ret
.L206:
	cpi r24,lo8(9)
	breq .L187
	ret
.L183:
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L172
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L172
	ldi r20,lo8(1)
.L204:
	ldi r22,0
	rjmp .L203
.L187:
	rjmp make_saw_rainbow
.L172:
	ret
	.size	make_mix_2, .-make_mix_2
.global	make_light_color
	.type	make_light_color, @function
make_light_color:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(2)
	breq .L209
	cpi r24,lo8(3)
	breq .L210
	cpi r24,lo8(1)
	brne .L220
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	rjmp .L227
.L209:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	rjmp .L226
.L210:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	rjmp .L225
.L220:
	cpi r24,lo8(5)
	breq .L213
	cpi r24,lo8(6)
	breq .L214
	cpi r24,lo8(4)
	brne .L221
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	rjmp .L229
.L213:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(1)
.L229:
	ldi r22,lo8(1)
	rjmp .L228
.L214:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(1)
.L227:
	ldi r22,0
.L228:
	ldi r24,0
	rjmp .L223
.L221:
	cpi r24,lo8(8)
	breq .L217
	cpi r24,lo8(9)
	breq .L218
	cpi r24,lo8(7)
	brne .L222
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(1)
.L226:
	ldi r22,0
	rjmp .L224
.L217:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
.L218:
	ldi r20,lo8(1)
.L225:
	ldi r22,lo8(1)
.L224:
	ldi r24,lo8(1)
.L223:
	rjmp make_light
.L222:
	ldi r24,0
	ret
	.size	make_light_color, .-make_light_color
.global	make_color
	.type	make_color, @function
make_color:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(2)
	breq .L232
	cpi r24,lo8(3)
	breq .L233
	cpi r24,lo8(1)
	brne .L253
	ldi r20,0
	rjmp .L264
.L232:
	ldi r20,0
	ldi r22,lo8(5)
.L258:
	ldi r24,lo8(20)
	rjmp .L257
.L233:
	ldi r20,0
	rjmp .L265
.L253:
	cpi r24,lo8(5)
	breq .L236
	cpi r24,lo8(6)
	breq .L237
	cpi r24,lo8(4)
	brne .L254
	ldi r20,0
	rjmp .L266
.L236:
	ldi r20,lo8(20)
.L266:
	ldi r22,lo8(20)
	rjmp .L259
.L237:
	ldi r20,lo8(20)
	rjmp .L260
.L254:
	cpi r24,lo8(8)
	breq .L240
	cpi r24,lo8(9)
	breq .L241
	cpi r24,lo8(7)
	brne .L255
	ldi r20,lo8(20)
.L264:
	ldi r22,0
	rjmp .L258
.L240:
	ldi r20,lo8(5)
	rjmp .L266
.L241:
	ldi r20,lo8(20)
.L265:
	ldi r22,lo8(20)
	rjmp .L258
.L255:
	cpi r24,lo8(12)
	breq .L244
	brsh .L245
	cpi r24,lo8(10)
	breq .L246
	cpi r24,lo8(11)
	brne .L243
	ldi r20,0
	ldi r22,0
	rjmp .L261
.L245:
	cpi r24,lo8(13)
	breq .L248
	cpi r24,lo8(14)
	breq .L263
	rjmp .L243
.L246:
	ldi r20,0
	ldi r22,lo8(3)
	rjmp .L259
.L244:
	ldi r20,lo8(3)
	rjmp .L262
.L248:
	ldi r20,lo8(3)
.L260:
	ldi r22,0
.L259:
	ldi r24,0
	rjmp .L257
.L243:
	cpi r24,lo8(15)
	brne .L256
.L263:
	ldi r20,0
.L262:
	ldi r22,lo8(3)
.L261:
	ldi r24,lo8(3)
	rjmp .L257
.L256:
	cpse r24,__zero_reg__
	rjmp .L252
	ldi r20,0
	ldi r22,0
.L257:
	rjmp make_light
.L252:
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
.L268:
	cp r28,r16
	cpc r29,r17
	breq .L274
	mov r24,r15
	rcall make_color
	cpi r24,lo8(1)
	breq .L269
	adiw r28,1
	rjmp .L268
.L274:
	ldi r24,0
.L269:
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
.L277:
	movw r22,r28
	movw r24,r16
	rcall long_color
	cpi r24,lo8(1)
	breq .L275
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L275
	adiw r28,1
	cpi r28,10
	cpc r29,__zero_reg__
	brne .L277
.L275:
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
	breq .L284
	brsh .L285
	cpi r24,lo8(1)
	breq .L286
	cpi r24,lo8(2)
	brne .L283
	ldi r24,lo8(50)
	ldi r25,0
	rjmp .L301
.L285:
	cpi r24,lo8(4)
	breq .L288
	cpi r24,lo8(5)
	brne .L283
	ldi r24,lo8(-36)
	ldi r25,lo8(5)
	rjmp .L301
.L286:
	ldi r24,lo8(10)
	ldi r25,0
	rjmp .L301
.L284:
	ldi r24,lo8(-106)
	ldi r25,0
.L301:
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad
.L288:
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
	rjmp .L301
.L283:
	cpi r24,lo8(7)
	breq .L291
	brsh .L292
	cpi r24,lo8(6)
	brne .L282
	ldi r24,lo8(100)
	ldi r25,0
	rjmp .L302
.L292:
	cpi r24,lo8(8)
	breq .L294
	cpi r24,lo8(9)
	brne .L282
	ldi r28,lo8(1)
	ldi r29,0
	rjmp .L296
.L291:
	ldi r24,lo8(-112)
	ldi r25,lo8(1)
	rjmp .L302
.L294:
	ldi r24,lo8(-80)
	ldi r25,lo8(4)
.L302:
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad_2
.L303:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L282
	adiw r28,1
	cpi r28,9
	cpc r29,__zero_reg__
	breq .L282
.L296:
	movw r22,r28
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .L303
.L282:
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
	breq .L306
	brsh .L307
	cpi r24,lo8(1)
	breq .L308
	cpi r24,lo8(2)
	breq .L309
	rjmp .L305
.L307:
	cpi r24,lo8(4)
	breq .L310
	cpi r24,lo8(5)
	brne .L305
	ldi r22,lo8(1)
	ldi r23,0
	rjmp .L374
.L308:
	ldi r22,lo8(5)
	ldi r23,0
	rjmp .L373
.L309:
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L304
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L304
	ldi r22,lo8(5)
	ldi r23,0
.L377:
	ldi r24,lo8(60)
	ldi r25,0
	rjmp .L375
.L306:
	ldi r22,lo8(3)
	ldi r23,0
.L373:
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L304
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L304
	ldi r22,lo8(7)
	ldi r23,0
	rjmp .L377
.L310:
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L304
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L304
	ldi r22,lo8(2)
	ldi r23,0
	rjmp .L377
.L305:
	cpi r24,lo8(7)
	breq .L316
	brsh .L317
	cpi r24,lo8(6)
	breq .L318
	ret
.L317:
	cpi r24,lo8(8)
	brne .+2
	rjmp .L319
	cpi r24,lo8(9)
	brne .+2
	rjmp .L320
	ret
.L318:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L304
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L304
	ldi r22,lo8(4)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L304
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L304
	ldi r22,lo8(8)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L304
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L304
	ldi r22,lo8(5)
	ldi r23,0
	rjmp .L376
.L316:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L304
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L304
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L304
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L304
	ldi r22,lo8(6)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L304
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L304
	ldi r22,lo8(1)
	ldi r23,0
	rjmp .L376
.L319:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L304
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L304
	ldi r22,lo8(9)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L304
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L304
	ldi r22,lo8(6)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L304
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L304
	ldi r22,lo8(4)
	ldi r23,0
.L376:
	ldi r24,lo8(45)
	ldi r25,0
.L375:
	rjmp long_color
.L320:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L304
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L304
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L304
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L304
	ldi r22,0
	ldi r23,0
.L374:
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L304
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L304
	ldi r22,lo8(9)
	ldi r23,0
	rjmp .L377
.L304:
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
	brne .L379
.L381:
	ldi r24,lo8(1)
	rjmp .L380
.L379:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L381
	ldi r22,0
	ldi r23,0
	movw r24,r28
	rcall long_color
	cpi r24,lo8(1)
	breq .L381
	ldi r24,lo8(1)
	lds r25,stat
	cpse r25,__zero_reg__
	rjmp .L380
	ldi r24,0
.L380:
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
	breq .L388
	brsh .L389
	cpi r24,lo8(1)
	breq .L390
	cpi r24,lo8(2)
	breq .L391
	rjmp .L387
.L389:
	cpi r24,lo8(4)
	breq .L392
	cpi r24,lo8(5)
	breq .L393
	rjmp .L387
.L390:
	ldi r20,lo8(5)
	rjmp .L448
.L391:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L386
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L386
	ldi r20,lo8(5)
	rjmp .L451
.L388:
	ldi r20,lo8(3)
.L448:
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L386
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L386
	ldi r20,lo8(7)
	rjmp .L451
.L392:
	ldi r20,lo8(2)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L386
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L386
	ldi r20,lo8(1)
	rjmp .L451
.L393:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L386
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L386
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L386
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L386
	ldi r20,lo8(6)
	rjmp .L451
.L387:
	cpi r24,lo8(7)
	breq .L398
	brsh .L399
	cpi r24,lo8(6)
	breq .L400
	ret
.L399:
	cpi r24,lo8(8)
	brne .+2
	rjmp .L450
	cpi r24,lo8(9)
	breq .L402
	ret
.L400:
	ldi r20,lo8(1)
	rjmp .L449
.L398:
	ldi r20,lo8(4)
.L449:
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L386
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L386
	ldi r20,lo8(9)
.L451:
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L402:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L386
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L386
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L386
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L386
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L386
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L386
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L386
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L386
.L450:
	ldi r20,lo8(6)
	rjmp .L449
.L386:
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
	breq .L454
	brsh .L455
	cpi r25,lo8(1)
	breq .L456
	cpi r25,lo8(2)
	brne .L453
	mov r20,r22
	ldi r22,lo8(20)
	ldi r23,0
	ldi r24,lo8(20)
	ldi r25,0
	rjmp .L468
.L455:
	cpi r25,lo8(4)
	breq .L458
	cpi r25,lo8(5)
	brne .L453
	mov r20,r22
	ldi r22,lo8(-12)
	ldi r23,lo8(1)
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
	rjmp .L468
.L456:
	rjmp make_color
.L454:
	mov r20,r22
	ldi r22,lo8(50)
	ldi r23,0
	ldi r24,lo8(50)
	ldi r25,0
.L468:
	rjmp make_strob
.L458:
	mov r20,r22
	ldi r22,lo8(100)
	ldi r23,0
	ldi r24,lo8(100)
	ldi r25,0
	rjmp .L468
.L453:
	cpi r25,lo8(8)
	breq .L461
	brsh .L462
	cpi r25,lo8(6)
	breq .L463
	cpi r25,lo8(7)
	breq .L464
	ret
.L462:
	cpi r25,lo8(10)
	breq .L465
	brlo .L466
	cpi r25,lo8(11)
	breq .L467
	ret
.L463:
	rjmp make_pulse
.L464:
	rjmp grad_serie
.L461:
	rjmp make_complex_strob
.L466:
	rjmp make_mix
.L465:
	rjmp make_mix_2
.L467:
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
 ;  212 "csb-light-grb-3_3b_d_cup.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	sts stat,__zero_reg__
	ldi r28,lo8(16)
	ldi r29,lo8(32)
.L470:
	lds r24,power
	cpi r24,lo8(2)
	brne .L471
	rcall init_io
	out 0x3b,__zero_reg__
	out 0x15,__zero_reg__
/* #APP */
 ;  220 "csb-light-grb-3_3b_d_cup.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	ldi r24,lo8(10)
	sts power,r24
.L473:
	in r24,0x16
	sbrs r24,4
	rjmp .L473
	ldi r24,lo8(12499)
	ldi r25,hi8(12499)
1:	sbiw r24,1
	brne 1b
	rjmp .
	nop
	rjmp .L470
.L471:
	cpi r24,lo8(3)
	brne .L475
	out 0x17,__zero_reg__
	out 0x18,r28
	in r24,0x35
	andi r24,lo8(-25)
	ori r24,lo8(16)
	out 0x35,r24
	in r24,0x35
	ori r24,lo8(32)
	out 0x35,r24
	out 0x3b,r29
	out 0x15,r28
/* #APP */
 ;  245 "csb-light-grb-3_3b_d_cup.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
	sts power,__zero_reg__
/* #APP */
 ;  247 "csb-light-grb-3_3b_d_cup.c" 1
	sleep
	
 ;  0 "" 2
/* #NOAPP */
	in r24,0x35
	andi r24,lo8(-33)
	out 0x35,r24
	rjmp .L470
.L475:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L476
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L477
	lds r22,mode
	lds r24,serie
	rjmp .L488
.L477:
	lds r24,counter
	tst r24
	breq .L478
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
.L488:
	rcall make_serie
	rjmp .L470
.L476:
	cpi r24,lo8(10)
	breq .L487
	cpi r24,lo8(11)
	breq .L487
	cpi r24,lo8(12)
	breq .L487
	cpi r24,lo8(13)
	breq .L487
	cpi r24,lo8(14)
	breq .L487
	cpi r24,lo8(15)
	breq .L487
.L478:
	ldi r24,0
.L487:
	rcall make_color
	rjmp .L470
	.size	main, .-main
	.local	last_button_state.1920
	.comm	last_button_state.1920,1,1
	.local	hold.1918
	.comm	hold.1918,2,1
	.local	button_state.1919
	.comm	button_state.1919,1,1
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
	.comm	stat,1,1
	.comm	serie,1,1
	.comm	mode,1,1
	.ident	"GCC: (GNU) 5.4.0"
.global __do_clear_bss
