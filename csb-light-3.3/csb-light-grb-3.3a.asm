	.file	"csb-light-grb-3.3a.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	go_sleep
	.type	go_sleep, @function
go_sleep:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,0x35
	andi r24,lo8(-25)
	ori r24,lo8(16)
	out 0x35,r24
	in r24,0x35
	ori r24,lo8(32)
	out 0x35,r24
/* #APP */
 ;  120 "csb-light-grb-3.3a.c" 1
	sei
 ;  0 "" 2
 ;  121 "csb-light-grb-3.3a.c" 1
	sleep
	
 ;  0 "" 2
/* #NOAPP */
	in r24,0x35
	andi r24,lo8(-33)
	out 0x35,r24
	ret
	.size	go_sleep, .-go_sleep
.global	check_all
	.type	check_all, @function
check_all:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,mode
	cpi r24,lo8(10)
	brlo .L3
	ldi r24,lo8(3)
	sts mode,r24
.L3:
	lds r24,serie
	cpi r24,lo8(12)
	brlo .L4
	ldi r24,lo8(7)
	sts serie,r24
	rjmp .L4
.L7:
	ld r24,Z
	cpi r24,lo8(10)
	brlo .L5
	st Z,r25
.L5:
	ld r24,X
	cpi r24,lo8(12)
	brlo .L6
	st X,r25
.L6:
	adiw r30,1
	adiw r26,1
	cp r30,r18
	cpc r31,r19
	brne .L7
	lds r24,counter
	cpi r24,lo8(16)
	brlo .L8
	sts counter,__zero_reg__
	ldi r24,0
	rjmp .L9
.L8:
	lds r25,pointer
	cp r25,r24
	brlo .L10
.L9:
	sts pointer,r24
.L10:
	lds r24,fav_on
	cpi r24,lo8(2)
	brlo .L11
	sts fav_on,__zero_reg__
.L11:
	lds r24,power
	cpi r24,lo8(2)
	brlo .L2
	ldi r24,lo8(1)
	sts power,r24
	ret
.L4:
	ldi r30,lo8(modes)
	ldi r31,hi8(modes)
	ldi r26,lo8(series)
	ldi r27,hi8(series)
	ldi r18,lo8(modes+15)
	ldi r19,hi8(modes+15)
	ldi r25,lo8(1)
	rjmp .L7
.L2:
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
.global	__vector_2
	.type	__vector_2, @function
__vector_2:
	push r1
	push r0
	in r0,__SREG__
	push r0
	clr __zero_reg__
	push r18
	push r19
	push r20
	push r21
	push r22
	push r23
	push r24
	push r25
	push r26
	push r27
	push r30
	push r31
/* prologue: Signal */
/* frame size = 0 */
/* stack size = 15 */
.L__stack_usage = 15
/* #APP */
 ;  102 "csb-light-grb-3.3a.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	ldi r24,lo8(1)
	sts power,r24
	rcall check_all
	rcall init_io
	sbic 0x16,4
	rjmp .L18
.L20:
	in r24,0x16
	ldi r30,lo8(1249)
	ldi r31,hi8(1249)
1:	sbiw r30,1
	brne 1b
	rjmp .
	nop
	sbrs r24,4
	rjmp .L20
.L18:
	ldi r24,lo8(1249)
	ldi r25,hi8(1249)
1:	sbiw r24,1
	brne 1b
	rjmp .
	nop
/* epilogue start */
	pop r31
	pop r30
	pop r27
	pop r26
	pop r25
	pop r24
	pop r23
	pop r22
	pop r21
	pop r20
	pop r19
	pop r18
	pop r0
	out __SREG__,r0
	pop r0
	pop r1
	reti
	.size	__vector_2, .-__vector_2
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
	brlo .L23
	ldi r24,lo8(12)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L36
	sts pointer,__zero_reg__
	sts counter,__zero_reg__
	sts fav_on,__zero_reg__
	rcall check_all
	rcall store_data
	sts stat,__zero_reg__
	ldi r24,lo8(1)
	ret
.L23:
	cpi r24,17
	ldi r18,39
	cpc r25,r18
	brlo .L25
	ldi r24,lo8(11)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L37
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L26
	ldi r24,lo8(1)
	sts fav_on,r24
	sts pointer,r24
	rjmp .L27
.L26:
	sts fav_on,__zero_reg__
.L27:
	rcall check_all
	rcall store_data
	sts stat,__zero_reg__
	ldi r24,lo8(1)
	ret
.L25:
	cpi r24,89
	ldi r18,27
	cpc r25,r18
	brlo .L28
	ldi r24,lo8(14)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L38
	sts power,__zero_reg__
	rcall store_data
	sts stat,__zero_reg__
	ldi r24,lo8(1)
	ret
.L28:
	cpi r24,-95
	ldi r18,15
	cpc r25,r18
	brlo .L29
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L39
	lds r25,counter
	cpi r25,lo8(15)
	brlo .+2
	rjmp .L24
	ldi r18,lo8(10)
	sts stat,r18
	or r22,r23
	breq .+2
	rjmp .L24
	subi r25,lo8(-(1))
	sts counter,r25
	mov r24,r25
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
	rcall check_all
	rcall store_data
	sts stat,__zero_reg__
	ldi r24,lo8(1)
	ret
.L29:
	cpi r24,-23
	ldi r18,3
	cpc r25,r18
	brlo .L30
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L40
	ldi r25,lo8(13)
	sts stat,r25
	or r22,r23
	breq .+2
	rjmp .L24
	lds r24,serie
	subi r24,lo8(-(1))
	cpi r24,lo8(12)
	brsh .L31
	sts serie,r24
	rjmp .L32
.L31:
	ldi r24,lo8(1)
	sts serie,r24
.L32:
	ldi r24,lo8(1)
	sts mode,r24
	rcall store_data
	sts stat,__zero_reg__
	ldi r24,lo8(1)
	ret
.L30:
	sbiw r24,51
	brlo .L41
	or r22,r23
	brne .L42
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L33
	lds r24,mode
	subi r24,lo8(-(1))
	cpi r24,lo8(10)
	brsh .L34
	sts mode,r24
	rjmp .L35
.L34:
	ldi r24,lo8(1)
	sts mode,r24
	rjmp .L35
.L33:
	lds r24,pointer
	subi r24,lo8(-(1))
	sts pointer,r24
	lds r25,counter
	cp r25,r24
	brsh .L35
	ldi r24,lo8(1)
	sts pointer,r24
.L35:
	rcall check_all
	rcall store_data
	ldi r24,lo8(1)
	ret
.L36:
	ldi r24,0
	ret
.L37:
	ldi r24,0
	ret
.L38:
	ldi r24,0
	ret
.L39:
	ldi r24,0
	ret
.L40:
	ldi r24,0
	ret
.L41:
	ldi r24,0
	ret
.L42:
	ldi r24,0
.L24:
	ret
	.size	process_button, .-process_button
.global	check_button
	.type	check_button, @function
check_button:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,0x16
	sts button_state.1793,__zero_reg__
	sbrc r24,4
	rjmp .L44
	ldi r24,lo8(1)
	sts button_state.1793,r24
	lds r24,hold.1792
	lds r25,hold.1792+1
	adiw r24,1
	sts hold.1792+1,r25
	sts hold.1792,r24
	lds r22,last_button_state.1794
	cpi r22,lo8(1)
	brne .L49
.L47:
	ldi r23,0
	lds r24,hold.1792
	lds r25,hold.1792+1
	rcall process_button
	rjmp .L45
.L49:
	ldi r24,0
.L45:
	lds r25,button_state.1793
	cpse r25,__zero_reg__
	rjmp .L46
.L48:
	lds r18,last_button_state.1794
	cpse r18,__zero_reg__
	rjmp .L46
	sts hold.1792+1,__zero_reg__
	sts hold.1792,__zero_reg__
.L46:
	sts last_button_state.1794,r25
	ret
.L44:
	lds r22,last_button_state.1794
	tst r22
	breq .L47
	lds r25,button_state.1793
	ldi r24,0
	rjmp .L48
	.size	check_button, .-check_button
.global	make_light
	.type	make_light, @function
make_light:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r25,0
.L55:
	cp r25,r24
	brsh .L56
	ldi r18,lo8(34)
	rjmp .L52
.L56:
	ldi r18,lo8(32)
.L52:
	cp r25,r22
	brsh .L53
	ori r18,lo8(1)
.L53:
	cp r25,r20
	brsh .L54
	ori r18,lo8(4)
.L54:
	out 0x18,r18
	subi r25,lo8(-(1))
	cpi r25,lo8(20)
	brne .L55
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
	cp r18,__zero_reg__
	cpc r19,__zero_reg__
	breq .L61
	movw r16,r18
	mov r13,r20
	mov r14,r22
	mov r15,r24
	ldi r28,0
	ldi r29,0
.L60:
	mov r20,r13
	mov r22,r14
	mov r24,r15
	rcall make_light
	cpi r24,lo8(1)
	breq .L59
	adiw r28,1
	cp r28,r16
	cpc r29,r17
	brne .L60
	ldi r24,0
	rjmp .L59
.L61:
	ldi r24,0
.L59:
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
.L65:
	mov r20,r28
	and r20,r15
	or r20,r14
	mov r22,r28
	and r22,r17
	or r22,r16
	movw r18,r12
	mov r24,r28
	and r24,r29
	or r24,r11
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L64
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L67
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L65
	ldi r28,lo8(20)
.L66:
	mov r20,r28
	and r20,r15
	or r20,r14
	mov r22,r28
	and r22,r17
	or r22,r16
	movw r18,r12
	mov r24,r28
	and r24,r29
	or r24,r11
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L64
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L68
	subi r28,lo8(-(-1))
	brne .L66
	rjmp .L64
.L67:
	ldi r24,lo8(1)
	rjmp .L64
.L68:
	ldi r24,lo8(1)
.L64:
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
	breq .L73
	cpi r24,lo8(3)
	breq .L74
	cpi r24,lo8(1)
	brne .L85
	mov __tmp_reg__,r31
	ldi r31,lo8(-56)
	mov r12,r31
	mov r13,__zero_reg__
	mov r31,__tmp_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(-1)
	rcall basic_pulse
	rjmp .L76
.L73:
	mov __tmp_reg__,r31
	ldi r31,lo8(-56)
	mov r12,r31
	mov r13,__zero_reg__
	mov r31,__tmp_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,0
	ldi r22,lo8(-1)
	ldi r24,lo8(-1)
	rcall basic_pulse
	rjmp .L76
.L74:
	mov __tmp_reg__,r31
	ldi r31,lo8(-56)
	mov r12,r31
	mov r13,__zero_reg__
	mov r31,__tmp_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,0
	ldi r22,lo8(-1)
	ldi r24,0
	rcall basic_pulse
	rjmp .L76
.L85:
	cpi r24,lo8(5)
	breq .L78
	cpi r24,lo8(6)
	breq .L79
	cpi r24,lo8(4)
	brne .L86
	mov __tmp_reg__,r31
	ldi r31,lo8(-56)
	mov r12,r31
	mov r13,__zero_reg__
	mov r31,__tmp_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
	ldi r22,lo8(-1)
	ldi r24,0
	rcall basic_pulse
	rjmp .L76
.L78:
	mov __tmp_reg__,r31
	ldi r31,lo8(-56)
	mov r12,r31
	mov r13,__zero_reg__
	mov r31,__tmp_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
	ldi r22,0
	ldi r24,0
	rcall basic_pulse
	rjmp .L76
.L79:
	mov __tmp_reg__,r31
	ldi r31,lo8(-56)
	mov r12,r31
	mov r13,__zero_reg__
	mov r31,__tmp_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
	ldi r22,0
	ldi r24,lo8(-1)
	rcall basic_pulse
	rjmp .L76
.L86:
	cpi r24,lo8(8)
	breq .L81
	cpi r24,lo8(9)
	breq .L82
	cpi r24,lo8(7)
	brne .L87
	mov __tmp_reg__,r31
	ldi r31,lo8(-56)
	mov r12,r31
	mov r13,__zero_reg__
	mov r31,__tmp_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
	ldi r22,lo8(-1)
	ldi r24,lo8(-1)
	rcall basic_pulse
	rjmp .L76
.L81:
	mov __tmp_reg__,r31
	ldi r31,lo8(-56)
	mov r12,r31
	mov r13,__zero_reg__
	mov r31,__tmp_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,lo8(-1)
	ldi r20,0
	ldi r22,lo8(7)
	ldi r24,lo8(-1)
	rcall basic_pulse
	rjmp .L76
.L82:
	mov __tmp_reg__,r31
	ldi r31,lo8(-56)
	mov r12,r31
	mov r13,__zero_reg__
	mov r31,__tmp_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,lo8(25)
	ldi r20,lo8(7)
	ldi r22,0
	ldi r24,lo8(-1)
	rcall basic_pulse
	rjmp .L76
.L87:
	ldi r24,0
.L76:
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
	push r16
	push r17
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 3 */
.L__stack_usage = 3
	movw r16,r24
	ldi r28,0
.L90:
	movw r18,r16
	ldi r20,0
	mov r22,r28
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L88
	lds r25,stat
	cpse r25,__zero_reg__
	rjmp .L88
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L90
	ldi r28,lo8(19)
.L91:
	movw r18,r16
	ldi r20,0
	ldi r22,lo8(20)
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L88
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L88
	subi r28,1
	brcc .L91
	ldi r28,lo8(1)
.L92:
	movw r18,r16
	mov r20,r28
	ldi r22,lo8(20)
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L88
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L88
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L92
	ldi r28,lo8(19)
.L93:
	movw r18,r16
	ldi r20,lo8(20)
	mov r22,r28
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L88
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L88
	subi r28,1
	brcc .L93
	ldi r28,lo8(1)
.L94:
	movw r18,r16
	ldi r20,lo8(20)
	ldi r22,0
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L88
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L88
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L94
	ldi r28,lo8(19)
.L95:
	movw r18,r16
	mov r20,r28
	ldi r22,0
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L88
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L88
	subi r28,1
	brcc .L95
.L88:
/* epilogue start */
	pop r28
	pop r17
	pop r16
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
	ldi r16,0
	ldi r17,0
	ldi r29,0
	ldi r28,lo8(20)
.L104:
	ldi r18,lo8(5)
	ldi r19,0
	mov r20,r16
	mov r22,r17
	mov r24,r29
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L105
	lds r25,stat
	cpse r25,__zero_reg__
	rjmp .L106
	subi r28,lo8(-(-1))
	add r29,r13
	add r17,r14
	add r16,r15
	cpse r28,__zero_reg__
	rjmp .L104
	rjmp .L103
.L105:
	mov r28,r24
	rjmp .L103
.L106:
	ldi r28,lo8(1)
.L103:
	mov r24,r28
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
.L110:
	ldi r18,lo8(2)
	ldi r19,0
	mov r20,r28
	mov r22,r28
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L108
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L108
	subi r28,lo8(-(-1))
	brne .L110
.L111:
	ldi r18,lo8(2)
	ldi r19,0
	ldi r20,0
	mov r22,r28
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L108
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L108
	subi r28,lo8(-(1))
	cpi r28,lo8(20)
	brne .L111
.L112:
	ldi r18,lo8(2)
	ldi r19,0
	ldi r20,0
	ldi r22,lo8(20)
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L108
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L108
	subi r28,lo8(-(-1))
	brne .L112
.L113:
	ldi r18,lo8(2)
	ldi r19,0
	mov r20,r28
	ldi r22,lo8(20)
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L108
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L108
	subi r28,lo8(-(1))
	cpi r28,lo8(20)
	brne .L113
.L114:
	ldi r18,lo8(2)
	ldi r19,0
	ldi r20,lo8(20)
	mov r22,r28
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L108
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L108
	subi r28,lo8(-(-1))
	brne .L114
	ldi r28,lo8(20)
.L115:
	ldi r18,lo8(2)
	ldi r19,0
	mov r20,r28
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L108
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L108
	subi r28,lo8(-(-1))
	brne .L115
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
/* epilogue start */
	pop r28
	rjmp l_make_light
.L108:
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
	breq .L124
	brsh .L125
	cpi r24,lo8(1)
	breq .L126
	cpi r24,lo8(2)
	breq .L127
	rjmp .L123
.L125:
	cpi r24,lo8(4)
	breq .L128
	cpi r24,lo8(5)
	breq .L129
	rjmp .L123
.L126:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rjmp make_saw
.L127:
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,0
	rjmp make_saw
.L124:
	ldi r20,lo8(1)
	ldi r22,0
	ldi r24,0
	rjmp make_saw
.L128:
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	rjmp make_saw
.L129:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	brne .+2
	rjmp .L122
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L122
	ldi r20,0
	ldi r22,lo8(1)
	rjmp make_saw
.L123:
	cpi r24,lo8(7)
	breq .L131
	brsh .L132
	cpi r24,lo8(6)
	breq .L133
	ret
.L132:
	cpi r24,lo8(8)
	breq .L134
	cpi r24,lo8(9)
	brne .+2
	rjmp .L135
	ret
.L133:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	brne .+2
	rjmp .L122
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L122
	ldi r20,lo8(1)
	ldi r22,0
	rjmp make_saw
.L131:
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,0
	rcall make_saw
	cpi r24,lo8(1)
	breq .L122
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L122
	ldi r20,lo8(1)
	ldi r22,0
	rjmp make_saw
.L134:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L122
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L122
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L122
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L122
	ldi r20,0
	ldi r22,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L122
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L122
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L122
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L122
	ldi r20,lo8(1)
	ldi r22,0
	rcall make_saw
	cpi r24,lo8(1)
	breq .L122
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L122
	ldi r20,lo8(1)
	ldi r22,0
	ldi r24,lo8(1)
	rjmp make_saw
.L135:
	rjmp make_saw_rainbow
.L122:
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
	breq .L138
	cpi r24,lo8(3)
	breq .L139
	cpi r24,lo8(1)
	brne .L149
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rjmp make_light
.L138:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rjmp make_light
.L139:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	rjmp make_light
.L149:
	cpi r24,lo8(5)
	breq .L142
	cpi r24,lo8(6)
	breq .L143
	cpi r24,lo8(4)
	brne .L150
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,0
	rjmp make_light
.L142:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	ldi r24,0
	rjmp make_light
.L143:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(1)
	ldi r22,0
	ldi r24,0
	rjmp make_light
.L150:
	cpi r24,lo8(8)
	breq .L146
	cpi r24,lo8(9)
	breq .L147
	cpi r24,lo8(7)
	brne .L151
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(1)
	ldi r22,0
	ldi r24,lo8(1)
	rjmp make_light
.L146:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	rjmp make_light
.L147:
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	rjmp make_light
.L151:
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
	breq .L154
	cpi r24,lo8(3)
	breq .L155
	cpi r24,lo8(1)
	brne .L173
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(20)
	rjmp make_light
.L154:
	ldi r20,0
	ldi r22,lo8(5)
	ldi r24,lo8(20)
	rjmp make_light
.L155:
	ldi r20,0
	ldi r22,lo8(20)
	ldi r24,lo8(20)
	rjmp make_light
.L173:
	cpi r24,lo8(5)
	breq .L158
	cpi r24,lo8(6)
	breq .L159
	cpi r24,lo8(4)
	brne .L174
	ldi r20,0
	ldi r22,lo8(20)
	ldi r24,0
	rjmp make_light
.L158:
	ldi r20,lo8(20)
	ldi r22,lo8(5)
	ldi r24,0
	rjmp make_light
.L159:
	ldi r20,lo8(20)
	ldi r22,0
	ldi r24,0
	rjmp make_light
.L174:
	cpi r24,lo8(8)
	breq .L162
	cpi r24,lo8(9)
	breq .L163
	cpi r24,lo8(7)
	brne .L175
	ldi r20,lo8(20)
	ldi r22,0
	ldi r24,lo8(20)
	rjmp make_light
.L162:
	ldi r20,lo8(5)
	ldi r22,lo8(5)
	ldi r24,lo8(20)
	rjmp make_light
.L163:
	ldi r20,lo8(20)
	ldi r22,lo8(20)
	ldi r24,lo8(20)
	rjmp make_light
.L175:
	cpi r24,lo8(12)
	breq .L166
	brsh .L167
	cpi r24,lo8(10)
	breq .L168
	cpi r24,lo8(11)
	breq .L169
	rjmp .L165
.L167:
	cpi r24,lo8(13)
	breq .L170
	cpi r24,lo8(14)
	breq .L171
	rjmp .L165
.L168:
	ldi r20,0
	ldi r22,lo8(3)
	ldi r24,0
	rjmp make_light
.L169:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(3)
	rjmp make_light
.L166:
	ldi r20,lo8(3)
	ldi r22,lo8(3)
	ldi r24,lo8(3)
	rjmp make_light
.L170:
	ldi r20,lo8(3)
	ldi r22,0
	ldi r24,0
	rjmp make_light
.L171:
	ldi r20,0
	ldi r22,lo8(3)
	ldi r24,lo8(3)
	rjmp make_light
.L165:
	cpse r24,__zero_reg__
	rjmp .L172
	ldi r20,0
	ldi r22,0
	rjmp make_light
.L172:
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
	sbiw r24,0
	breq .L179
	mov r15,r22
	movw r16,r24
	ldi r28,0
	ldi r29,0
.L178:
	mov r24,r15
	rcall make_color
	cpi r24,lo8(1)
	breq .L177
	adiw r28,1
	cp r28,r16
	cpc r29,r17
	brne .L178
	ldi r24,0
	rjmp .L177
.L179:
	ldi r24,0
.L177:
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
.L183:
	movw r22,r28
	movw r24,r16
	rcall long_color
	cpi r24,lo8(1)
	breq .L181
	lds r25,stat
	cpse r25,__zero_reg__
	rjmp .L181
	adiw r28,1
	cpi r28,10
	cpc r29,__zero_reg__
	brne .L183
.L181:
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
	breq .L187
	brsh .L188
	cpi r24,lo8(1)
	breq .L189
	cpi r24,lo8(2)
	breq .L190
	rjmp .L186
.L188:
	cpi r24,lo8(4)
	breq .L191
	cpi r24,lo8(5)
	breq .L192
	rjmp .L186
.L189:
	ldi r24,lo8(10)
	ldi r25,0
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad
.L190:
	ldi r24,lo8(50)
	ldi r25,0
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad
.L187:
	ldi r24,lo8(-106)
	ldi r25,0
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad
.L191:
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad
.L192:
	ldi r24,lo8(-36)
	ldi r25,lo8(5)
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad
.L186:
	cpi r24,lo8(7)
	breq .L194
	brsh .L195
	cpi r24,lo8(6)
	breq .L196
	rjmp .L185
.L195:
	cpi r24,lo8(8)
	breq .L197
	cpi r24,lo8(9)
	breq .L199
	rjmp .L185
.L196:
	ldi r24,lo8(100)
	ldi r25,0
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad_2
.L194:
	ldi r24,lo8(-112)
	ldi r25,lo8(1)
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad_2
.L197:
	ldi r24,lo8(-80)
	ldi r25,lo8(4)
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad_2
.L199:
	ldi r28,lo8(1)
	ldi r29,0
.L198:
	movw r22,r28
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L185
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L185
	adiw r28,1
	cpi r28,9
	cpc r29,__zero_reg__
	brne .L198
.L185:
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
	breq .L203
	brsh .L204
	cpi r24,lo8(1)
	breq .L205
	cpi r24,lo8(2)
	breq .L206
	rjmp .L202
.L204:
	cpi r24,lo8(4)
	breq .L207
	cpi r24,lo8(5)
	brne .+2
	rjmp .L208
	rjmp .L202
.L205:
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L201
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L201
	ldi r22,lo8(4)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rjmp long_color
.L206:
	ldi r22,lo8(4)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L201
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L201
	ldi r22,lo8(6)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rjmp long_color
.L203:
	ldi r22,lo8(6)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L201
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L201
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rjmp long_color
.L207:
	ldi r22,lo8(2)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L201
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L201
	ldi r22,lo8(5)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rjmp long_color
.L208:
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L201
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L201
	ldi r22,lo8(2)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rjmp long_color
.L202:
	cpi r24,lo8(7)
	breq .L210
	brsh .L211
	cpi r24,lo8(6)
	breq .L212
	ret
.L211:
	cpi r24,lo8(8)
	brne .+2
	rjmp .L213
	cpi r24,lo8(9)
	brne .+2
	rjmp .L214
	ret
.L212:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L201
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L201
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L201
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L201
	ldi r22,lo8(4)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L201
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L201
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp long_color
.L210:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L201
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L201
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L201
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L201
	ldi r22,lo8(6)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L201
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L201
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp long_color
.L213:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L201
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L201
	ldi r22,lo8(9)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L201
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L201
	ldi r22,lo8(6)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L201
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L201
	ldi r22,lo8(4)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp long_color
.L214:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L201
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L201
	ldi r22,lo8(4)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L201
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L201
	ldi r22,lo8(6)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L201
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L201
	ldi r22,lo8(4)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp long_color
.L201:
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
	breq .L216
	lds r25,stat
	cpse r25,__zero_reg__
	rjmp .L218
	ldi r22,0
	ldi r23,0
	movw r24,r28
	rcall long_color
	cpi r24,lo8(1)
	breq .L216
	ldi r24,lo8(1)
	lds r25,stat
	cpse r25,__zero_reg__
	rjmp .L216
	ldi r24,0
	rjmp .L216
.L218:
	ldi r24,lo8(1)
.L216:
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
	breq .L221
	brsh .L222
	cpi r24,lo8(1)
	breq .L223
	cpi r24,lo8(2)
	breq .L224
	rjmp .L220
.L222:
	cpi r24,lo8(4)
	brne .+2
	rjmp .L225
	cpi r24,lo8(5)
	brne .+2
	rjmp .L226
	rjmp .L220
.L223:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L219
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L219
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L224:
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L219
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L219
	ldi r20,lo8(6)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L221:
	ldi r20,lo8(6)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L219
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L219
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L225:
	ldi r20,lo8(2)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L219
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L219
	ldi r20,lo8(5)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L226:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L219
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L219
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L219
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L219
	ldi r20,lo8(6)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L220:
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
.L230:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L219
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L219
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L228:
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L219
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L219
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L231:
	ldi r20,lo8(6)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L219
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L219
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L232:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L219
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L219
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L219
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L219
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L219
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L219
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L219
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L219
	ldi r20,lo8(6)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L219
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L219
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L219:
	ret
	.size	make_complex_strob, .-make_complex_strob
.global	make_serie
	.type	make_serie, @function
make_serie:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(3)
	breq .L235
	brsh .L236
	cpi r24,lo8(1)
	breq .L237
	cpi r24,lo8(2)
	breq .L238
	rjmp .L234
.L236:
	cpi r24,lo8(4)
	breq .L239
	cpi r24,lo8(5)
	breq .L240
	rjmp .L234
.L237:
	mov r24,r22
	rjmp make_color
.L238:
	mov r20,r22
	ldi r22,lo8(20)
	ldi r23,0
	ldi r24,lo8(20)
	ldi r25,0
	rjmp make_strob
.L235:
	mov r20,r22
	ldi r22,lo8(50)
	ldi r23,0
	ldi r24,lo8(50)
	ldi r25,0
	rjmp make_strob
.L239:
	mov r20,r22
	ldi r22,lo8(100)
	ldi r23,0
	ldi r24,lo8(100)
	ldi r25,0
	rjmp make_strob
.L240:
	mov r20,r22
	ldi r22,lo8(-12)
	ldi r23,lo8(1)
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
	rjmp make_strob
.L234:
	cpi r24,lo8(8)
	breq .L242
	brsh .L243
	cpi r24,lo8(6)
	breq .L244
	cpi r24,lo8(7)
	breq .L245
	ret
.L243:
	cpi r24,lo8(10)
	breq .L246
	brlo .L247
	cpi r24,lo8(11)
	breq .L248
	ret
.L244:
	mov r24,r22
	rjmp make_pulse
.L245:
	mov r24,r22
	rjmp grad_serie
.L242:
	mov r24,r22
	rjmp make_complex_strob
.L247:
	mov r24,r22
	rjmp make_mix
.L246:
	mov r24,r22
	rjmp make_mix_2
.L248:
	mov r24,r22
	rjmp make_light_color
	.size	make_serie, .-make_serie
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	rcall read_data
	rcall init_io
	ldi r24,lo8(32)
	out 0x3b,r24
	ldi r24,lo8(16)
	out 0x15,r24
/* #APP */
 ;  196 "csb-light-grb-3.3a.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	sts stat,__zero_reg__
.L250:
	lds r24,power
	cpse r24,__zero_reg__
	rjmp .L251
	out 0x17,__zero_reg__
	out 0x18,__zero_reg__
	rcall go_sleep
	rjmp .L250
.L251:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L253
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L254
	lds r22,mode
	lds r24,serie
	rcall make_serie
	rjmp .L250
.L254:
	lds r24,counter
	tst r24
	breq .L255
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
	rcall make_serie
	rjmp .L250
.L255:
	ldi r24,0
	rcall make_color
	rjmp .L250
.L253:
	cpi r24,lo8(10)
	brne .L256
	rcall make_color
	rjmp .L250
.L256:
	cpi r24,lo8(11)
	brne .L257
	rcall make_color
	rjmp .L250
.L257:
	cpi r24,lo8(12)
	brne .L258
	rcall make_color
	rjmp .L250
.L258:
	cpi r24,lo8(13)
	brne .L259
	rcall make_color
	rjmp .L250
.L259:
	cpi r24,lo8(14)
	brne .L260
	rcall make_color
	rjmp .L250
.L260:
	ldi r24,0
	rcall make_color
	rjmp .L250
	.size	main, .-main
	.local	last_button_state.1794
	.comm	last_button_state.1794,1,1
	.local	hold.1792
	.comm	hold.1792,2,1
	.local	button_state.1793
	.comm	button_state.1793,1,1
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
	.ident	"GCC: (GNU) 4.9.2"
.global __do_clear_bss
