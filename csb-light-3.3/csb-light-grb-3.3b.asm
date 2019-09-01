	.file	"csb-light-grb-3.3b.c"
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
 ;  183 "csb-light-grb-3.3b.c" 1
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
	ldi r16,0
	ldi r18,0
	ldi r20,0
	rjmp .L96
.L80:
	ldi r23,lo8(-56)
	mov r12,r23
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,0
	rjmp .L98
.L81:
	ldi r22,lo8(-56)
	mov r12,r22
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,0
	rjmp .L100
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
.L100:
	ldi r22,lo8(-1)
	rjmp .L99
.L85:
	ldi r20,lo8(-56)
	mov r12,r20
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
	ldi r22,0
.L99:
	ldi r24,0
	rjmp .L97
.L86:
	ldi r19,lo8(-56)
	mov r12,r19
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
	rjmp .L96
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
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
.L98:
	ldi r22,lo8(-1)
	rjmp .L95
.L88:
	ldi r25,lo8(-56)
	mov r12,r25
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,lo8(-1)
	ldi r20,0
	ldi r22,lo8(7)
	rjmp .L95
.L89:
	ldi r24,lo8(-56)
	mov r12,r24
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,lo8(25)
	ldi r20,lo8(7)
.L96:
	ldi r22,0
.L95:
	ldi r24,lo8(-1)
.L97:
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
.L104:
	movw r18,r28
	ldi r20,0
	mov r22,r17
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L101
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L101
	subi r17,lo8(-(1))
	cpi r17,lo8(21)
	brne .L104
	ldi r17,lo8(19)
.L105:
	movw r18,r28
	ldi r20,0
	ldi r22,lo8(20)
	mov r24,r17
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L101
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L101
	subi r17,1
	brcc .L105
	ldi r17,lo8(1)
.L106:
	movw r18,r28
	mov r20,r17
	ldi r22,lo8(20)
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L101
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L101
	subi r17,lo8(-(1))
	cpi r17,lo8(21)
	brne .L106
	ldi r17,lo8(19)
.L107:
	movw r18,r28
	ldi r20,lo8(20)
	mov r22,r17
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L101
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L101
	subi r17,1
	brcc .L107
	ldi r17,lo8(1)
.L108:
	movw r18,r28
	ldi r20,lo8(20)
	ldi r22,0
	mov r24,r17
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L101
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L101
	subi r17,lo8(-(1))
	cpi r17,lo8(21)
	brne .L108
	ldi r17,lo8(19)
.L109:
	movw r18,r28
	mov r20,r17
	ldi r22,0
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L101
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L101
	subi r17,1
	brcc .L109
.L101:
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
.L133:
	ldi r18,lo8(5)
	ldi r19,0
	mov r20,r29
	mov r22,r17
	mov r24,r16
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L132
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L134
	subi r28,lo8(-(-1))
	add r16,r13
	add r17,r14
	add r29,r15
	cpse r28,__zero_reg__
	rjmp .L133
	rjmp .L132
.L134:
	ldi r24,lo8(1)
.L132:
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
.L143:
	ldi r18,lo8(2)
	ldi r19,0
	mov r20,r28
	mov r22,r28
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L139
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L139
	subi r28,lo8(-(-1))
	brne .L143
.L144:
	ldi r18,lo8(2)
	ldi r19,0
	ldi r20,0
	mov r22,r28
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L139
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L139
	subi r28,lo8(-(1))
	cpi r28,lo8(20)
	brne .L144
.L145:
	ldi r18,lo8(2)
	ldi r19,0
	ldi r20,0
	ldi r22,lo8(20)
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L139
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L139
	subi r28,lo8(-(-1))
	brne .L145
.L146:
	ldi r18,lo8(2)
	ldi r19,0
	mov r20,r28
	ldi r22,lo8(20)
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L139
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L139
	subi r28,lo8(-(1))
	cpi r28,lo8(20)
	brne .L146
.L147:
	ldi r18,lo8(2)
	ldi r19,0
	ldi r20,lo8(20)
	mov r22,r28
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L139
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L139
	subi r28,lo8(-(-1))
	brne .L147
	ldi r28,lo8(20)
.L148:
	ldi r18,lo8(2)
	ldi r19,0
	mov r20,r28
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L139
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L139
	subi r28,lo8(-(-1))
	brne .L148
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
/* epilogue start */
	pop r28
	rjmp l_make_light
.L139:
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
	breq .L186
	brsh .L173
	cpi r24,lo8(1)
	breq .L174
	cpi r24,lo8(2)
	brne .L171
	ldi r20,0
	ldi r22,lo8(1)
	rjmp .L212
.L173:
	cpi r24,lo8(4)
	breq .L176
	cpi r24,lo8(5)
	breq .L177
	rjmp .L171
.L174:
	ldi r20,0
	rjmp .L214
.L183:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
.L210:
	rcall make_saw
	cpi r24,lo8(1)
	brne .+2
	rjmp .L170
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L170
.L186:
	ldi r20,lo8(1)
	ldi r22,0
.L212:
	ldi r24,0
.L211:
	rjmp make_saw
.L176:
	ldi r20,lo8(1)
	ldi r22,lo8(1)
.L213:
	ldi r24,lo8(1)
	rjmp .L211
.L177:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	brne .+2
	rjmp .L170
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L170
	ldi r20,0
	ldi r22,lo8(1)
	rjmp .L211
.L171:
	cpi r24,lo8(7)
	breq .L181
	brsh .L182
	cpi r24,lo8(6)
	breq .L183
	ret
.L182:
	cpi r24,lo8(8)
	breq .L184
	cpi r24,lo8(9)
	breq .L185
	ret
.L181:
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,0
	rjmp .L210
.L184:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L170
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L170
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L170
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L170
	ldi r20,0
	ldi r22,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L170
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L170
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L170
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L170
	ldi r20,lo8(1)
	ldi r22,0
	rcall make_saw
	cpi r24,lo8(1)
	breq .L170
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L170
	ldi r20,lo8(1)
.L214:
	ldi r22,0
	rjmp .L213
.L185:
	rjmp make_saw_rainbow
.L170:
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
	breq .L217
	cpi r24,lo8(3)
	breq .L218
	cpi r24,lo8(1)
	brne .L228
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	rjmp .L235
.L217:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	rjmp .L234
.L218:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	rjmp .L233
.L228:
	cpi r24,lo8(5)
	breq .L221
	cpi r24,lo8(6)
	breq .L222
	cpi r24,lo8(4)
	brne .L229
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	rjmp .L237
.L221:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(1)
.L237:
	ldi r22,lo8(1)
	rjmp .L236
.L222:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(1)
.L235:
	ldi r22,0
.L236:
	ldi r24,0
	rjmp .L231
.L229:
	cpi r24,lo8(8)
	breq .L225
	cpi r24,lo8(9)
	breq .L226
	cpi r24,lo8(7)
	brne .L230
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(1)
.L234:
	ldi r22,0
	rjmp .L232
.L225:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
.L226:
	ldi r20,lo8(1)
.L233:
	ldi r22,lo8(1)
.L232:
	ldi r24,lo8(1)
.L231:
	rjmp make_light
.L230:
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
	breq .L240
	cpi r24,lo8(3)
	breq .L241
	cpi r24,lo8(1)
	brne .L261
	ldi r20,0
	rjmp .L273
.L240:
	ldi r20,0
.L269:
	ldi r22,lo8(5)
.L266:
	ldi r24,lo8(20)
	rjmp .L265
.L241:
	ldi r20,0
	rjmp .L274
.L261:
	cpi r24,lo8(5)
	breq .L244
	cpi r24,lo8(6)
	breq .L245
	cpi r24,lo8(4)
	brne .L262
	ldi r20,0
	ldi r22,lo8(20)
	rjmp .L267
.L244:
	ldi r20,lo8(20)
	ldi r22,lo8(5)
	rjmp .L267
.L245:
	ldi r20,lo8(20)
	rjmp .L268
.L262:
	cpi r24,lo8(8)
	breq .L248
	cpi r24,lo8(9)
	breq .L249
	cpi r24,lo8(7)
	brne .L263
	ldi r20,lo8(20)
.L273:
	ldi r22,0
	rjmp .L266
.L248:
	ldi r20,lo8(5)
	rjmp .L269
.L249:
	ldi r20,lo8(20)
.L274:
	ldi r22,lo8(20)
	rjmp .L266
.L263:
	cpi r24,lo8(12)
	breq .L252
	brsh .L253
	cpi r24,lo8(10)
	breq .L254
	cpi r24,lo8(11)
	brne .L251
	ldi r20,0
	ldi r22,0
	rjmp .L270
.L253:
	cpi r24,lo8(13)
	breq .L256
	cpi r24,lo8(14)
	breq .L272
	rjmp .L251
.L254:
	ldi r20,0
	ldi r22,lo8(3)
	rjmp .L267
.L252:
	ldi r20,lo8(3)
	rjmp .L271
.L256:
	ldi r20,lo8(3)
.L268:
	ldi r22,0
.L267:
	ldi r24,0
	rjmp .L265
.L251:
	cpi r24,lo8(15)
	brne .L264
.L272:
	ldi r20,0
.L271:
	ldi r22,lo8(3)
.L270:
	ldi r24,lo8(3)
	rjmp .L265
.L264:
	cpse r24,__zero_reg__
	rjmp .L260
	ldi r20,0
	ldi r22,0
.L265:
	rjmp make_light
.L260:
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
.L276:
	cp r28,r16
	cpc r29,r17
	breq .L282
	mov r24,r15
	rcall make_color
	cpi r24,lo8(1)
	breq .L277
	adiw r28,1
	rjmp .L276
.L282:
	ldi r24,0
.L277:
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
.L285:
	movw r22,r28
	movw r24,r16
	rcall long_color
	cpi r24,lo8(1)
	breq .L283
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L283
	adiw r28,1
	cpi r28,10
	cpc r29,__zero_reg__
	brne .L285
.L283:
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
	breq .L292
	brsh .L293
	cpi r24,lo8(1)
	breq .L294
	cpi r24,lo8(2)
	brne .L291
	ldi r24,lo8(50)
	ldi r25,0
	rjmp .L309
.L293:
	cpi r24,lo8(4)
	breq .L296
	cpi r24,lo8(5)
	brne .L291
	ldi r24,lo8(-36)
	ldi r25,lo8(5)
	rjmp .L309
.L294:
	ldi r24,lo8(10)
	ldi r25,0
	rjmp .L309
.L292:
	ldi r24,lo8(-106)
	ldi r25,0
.L309:
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad
.L296:
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
	rjmp .L309
.L291:
	cpi r24,lo8(7)
	breq .L299
	brsh .L300
	cpi r24,lo8(6)
	brne .L290
	ldi r24,lo8(100)
	ldi r25,0
	rjmp .L310
.L300:
	cpi r24,lo8(8)
	breq .L302
	cpi r24,lo8(9)
	brne .L290
	ldi r28,lo8(1)
	ldi r29,0
	rjmp .L304
.L299:
	ldi r24,lo8(-112)
	ldi r25,lo8(1)
	rjmp .L310
.L302:
	ldi r24,lo8(-80)
	ldi r25,lo8(4)
.L310:
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad_2
.L311:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L290
	adiw r28,1
	cpi r28,9
	cpc r29,__zero_reg__
	breq .L290
.L304:
	movw r22,r28
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .L311
.L290:
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
	breq .L314
	brsh .L315
	cpi r24,lo8(1)
	breq .L316
	cpi r24,lo8(2)
	breq .L317
	rjmp .L313
.L315:
	cpi r24,lo8(4)
	breq .L318
	cpi r24,lo8(5)
	brne .+2
	rjmp .L319
	rjmp .L313
.L316:
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L312
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L312
	ldi r22,lo8(4)
	ldi r23,0
	rjmp .L387
.L317:
	ldi r22,lo8(4)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L312
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L312
	ldi r22,lo8(6)
	ldi r23,0
.L387:
	ldi r24,lo8(60)
	ldi r25,0
	rjmp .L385
.L314:
	ldi r22,lo8(6)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L312
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L312
	ldi r22,lo8(1)
	ldi r23,0
	rjmp .L387
.L318:
	ldi r22,lo8(2)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L312
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L312
	ldi r22,lo8(5)
	ldi r23,0
	rjmp .L387
.L319:
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L312
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L312
	ldi r22,lo8(2)
	ldi r23,0
	rjmp .L387
.L313:
	cpi r24,lo8(7)
	breq .L323
	brsh .L324
	cpi r24,lo8(6)
	breq .L325
	ret
.L324:
	cpi r24,lo8(8)
	brne .+2
	rjmp .L326
	cpi r24,lo8(9)
	brne .+2
	rjmp .L327
	ret
.L325:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L312
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L312
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L312
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L312
	ldi r22,lo8(4)
	ldi r23,0
	rjmp .L381
.L323:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L312
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L312
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L312
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L312
	ldi r22,lo8(6)
	ldi r23,0
.L381:
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L312
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L312
	ldi r22,lo8(1)
	ldi r23,0
	rjmp .L386
.L326:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L312
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L312
	ldi r22,lo8(9)
	ldi r23,0
	rjmp .L384
.L327:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L312
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L312
	ldi r22,lo8(4)
	ldi r23,0
.L384:
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L312
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L312
	ldi r22,lo8(6)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L312
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L312
	ldi r22,lo8(4)
	ldi r23,0
.L386:
	ldi r24,lo8(45)
	ldi r25,0
.L385:
	rjmp long_color
.L312:
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
	brne .L389
.L391:
	ldi r24,lo8(1)
	rjmp .L390
.L389:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L391
	ldi r22,0
	ldi r23,0
	movw r24,r28
	rcall long_color
	cpi r24,lo8(1)
	breq .L391
	ldi r24,lo8(1)
	lds r25,stat
	cpse r25,__zero_reg__
	rjmp .L390
	ldi r24,0
.L390:
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
	breq .L398
	brsh .L399
	cpi r24,lo8(1)
	breq .L400
	cpi r24,lo8(2)
	brne .+2
	rjmp .L458
	rjmp .L397
.L399:
	cpi r24,lo8(4)
	breq .L402
	cpi r24,lo8(5)
	breq .L403
	rjmp .L397
.L400:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L396
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L396
	ldi r20,lo8(4)
	rjmp .L461
.L398:
	ldi r20,lo8(6)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L396
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L396
	ldi r20,lo8(1)
	rjmp .L461
.L402:
	ldi r20,lo8(2)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L396
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L396
	ldi r20,lo8(5)
	rjmp .L461
.L403:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L396
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L396
.L458:
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L396
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L396
	ldi r20,lo8(6)
	rjmp .L461
.L397:
	cpi r24,lo8(7)
	breq .L408
	brsh .L409
	cpi r24,lo8(6)
	breq .L410
	ret
.L409:
	cpi r24,lo8(8)
	brne .+2
	rjmp .L460
	cpi r24,lo8(9)
	breq .L412
	ret
.L410:
	ldi r20,lo8(1)
	rjmp .L459
.L408:
	ldi r20,lo8(4)
.L459:
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L396
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L396
	ldi r20,lo8(9)
.L461:
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L412:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L396
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L396
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L396
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L396
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L396
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L396
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L396
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L396
.L460:
	ldi r20,lo8(6)
	rjmp .L459
.L396:
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
	breq .L464
	brsh .L465
	cpi r25,lo8(1)
	breq .L466
	cpi r25,lo8(2)
	brne .L463
	mov r20,r22
	ldi r22,lo8(20)
	ldi r23,0
	ldi r24,lo8(20)
	ldi r25,0
	rjmp .L478
.L465:
	cpi r25,lo8(4)
	breq .L468
	cpi r25,lo8(5)
	brne .L463
	mov r20,r22
	ldi r22,lo8(-12)
	ldi r23,lo8(1)
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
	rjmp .L478
.L466:
	rjmp make_color
.L464:
	mov r20,r22
	ldi r22,lo8(50)
	ldi r23,0
	ldi r24,lo8(50)
	ldi r25,0
.L478:
	rjmp make_strob
.L468:
	mov r20,r22
	ldi r22,lo8(100)
	ldi r23,0
	ldi r24,lo8(100)
	ldi r25,0
	rjmp .L478
.L463:
	cpi r25,lo8(8)
	breq .L471
	brsh .L472
	cpi r25,lo8(6)
	breq .L473
	cpi r25,lo8(7)
	breq .L474
	ret
.L472:
	cpi r25,lo8(10)
	breq .L475
	brlo .L476
	cpi r25,lo8(11)
	breq .L477
	ret
.L473:
	rjmp make_pulse
.L474:
	rjmp grad_serie
.L471:
	rjmp make_complex_strob
.L476:
	rjmp make_mix
.L475:
	rjmp make_mix_2
.L477:
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
 ;  212 "csb-light-grb-3.3b.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	sts stat,__zero_reg__
	ldi r28,lo8(16)
	ldi r29,lo8(32)
.L480:
	lds r24,power
	cpi r24,lo8(2)
	brne .L481
	rcall init_io
	out 0x3b,__zero_reg__
	out 0x15,__zero_reg__
/* #APP */
 ;  220 "csb-light-grb-3.3b.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	ldi r24,lo8(10)
	sts power,r24
.L483:
	in r24,0x16
	sbrs r24,4
	rjmp .L483
	ldi r24,lo8(12499)
	ldi r25,hi8(12499)
1:	sbiw r24,1
	brne 1b
	rjmp .
	nop
	rjmp .L480
.L481:
	cpi r24,lo8(3)
	brne .L485
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
 ;  245 "csb-light-grb-3.3b.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
	sts power,__zero_reg__
/* #APP */
 ;  247 "csb-light-grb-3.3b.c" 1
	sleep
	
 ;  0 "" 2
/* #NOAPP */
	in r24,0x35
	andi r24,lo8(-33)
	out 0x35,r24
	rjmp .L480
.L485:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L486
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L487
	lds r22,mode
	lds r24,serie
	rjmp .L498
.L487:
	lds r24,counter
	tst r24
	breq .L488
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
.L498:
	rcall make_serie
	rjmp .L480
.L486:
	cpi r24,lo8(10)
	breq .L497
	cpi r24,lo8(11)
	breq .L497
	cpi r24,lo8(12)
	breq .L497
	cpi r24,lo8(13)
	breq .L497
	cpi r24,lo8(14)
	breq .L497
	cpi r24,lo8(15)
	breq .L497
.L488:
	ldi r24,0
.L497:
	rcall make_color
	rjmp .L480
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
