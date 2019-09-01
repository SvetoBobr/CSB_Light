	.file	"csb-light-grb-3.4b.c"
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
	brlo .L4
	ldi r24,lo8(3)
	sts mode,r24
.L4:
	lds r24,serie
	cpi r24,lo8(12)
	brlo .L5
	ldi r24,lo8(7)
	sts serie,r24
.L5:
	lds r24,brightness
	cpi r24,lo8(4)
	brlo .L6
	sts brightness,__zero_reg__
	rjmp .L6
.L9:
	ld r24,Z
	cpi r24,lo8(10)
	brlo .L7
	st Z,r25
.L7:
	ld r24,X
	cpi r24,lo8(12)
	brlo .L8
	st X,r25
.L8:
	adiw r30,1
	adiw r26,1
	cp r30,r18
	cpc r31,r19
	brne .L9
	lds r24,counter
	cpi r24,lo8(16)
	brlo .L10
	sts counter,__zero_reg__
	ldi r24,0
	rjmp .L11
.L10:
	lds r25,pointer
	cp r25,r24
	brlo .L12
.L11:
	sts pointer,r24
.L12:
	lds r24,fav_on
	cpi r24,lo8(2)
	brlo .L13
	sts fav_on,__zero_reg__
.L13:
	ldi r24,lo8(10)
	sts power,r24
	ret
.L6:
	ldi r30,lo8(modes)
	ldi r31,hi8(modes)
	ldi r26,lo8(series)
	ldi r27,hi8(series)
	ldi r18,lo8(modes+15)
	ldi r19,hi8(modes+15)
	ldi r25,lo8(1)
	rjmp .L9
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
	ldi r24,lo8(e_brightness)
	ldi r25,hi8(e_brightness)
	rcall eeprom_read_byte
	sts brightness,r24
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
	lds r22,e_brightness
	ldi r24,lo8(e_brightness)
	ldi r25,hi8(e_brightness)
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
 ;  205 "csb-light-grb-3.4b.c" 1
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
	sbic 0x16,4
	rjmp .L20
	ldi r24,lo8(10)
	sts power,r24
	ldi r24,lo8(19)
	out 0x18,r24
.L21:
	sbis 0x16,4
	rjmp .L21
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
	cpi r24,81
	ldi r18,70
	cpc r25,r18
	brlo .L25
	ldi r24,lo8(12)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L41
	sts pointer,__zero_reg__
	sts counter,__zero_reg__
	sts fav_on,__zero_reg__
	rcall check_all
	rcall store_data
	sts stat,__zero_reg__
	ldi r24,lo8(1)
	ret
.L25:
	cpi r24,-55
	ldi r18,50
	cpc r25,r18
	brlo .L27
	ldi r24,lo8(11)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L42
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L28
	ldi r24,lo8(1)
	sts fav_on,r24
	sts pointer,r24
	rjmp .L29
.L28:
	sts fav_on,__zero_reg__
.L29:
	rcall check_all
	rcall store_data
	sts stat,__zero_reg__
	ldi r24,lo8(1)
	ret
.L27:
	cpi r24,89
	ldi r18,27
	cpc r25,r18
	brlo .L30
	ldi r24,lo8(16)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L43
	lds r24,brightness
	subi r24,lo8(-(1))
	cpi r24,lo8(4)
	brsh .L31
	sts brightness,r24
	rjmp .L32
.L31:
	sts brightness,__zero_reg__
.L32:
	rcall store_data
	sts stat,__zero_reg__
	ldi r24,lo8(1)
	ret
.L30:
	cpi r24,17
	ldi r18,39
	cpc r25,r18
	brlo .L33
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L44
	lds r25,counter
	cpi r25,lo8(15)
	brlo .+2
	rjmp .L26
	ldi r18,lo8(10)
	sts stat,r18
	or r22,r23
	breq .+2
	rjmp .L26
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
.L33:
	cpi r24,-71
	ldi r18,11
	cpc r25,r18
	brlo .L34
	ldi r24,lo8(14)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L45
	ldi r24,lo8(3)
	sts power,r24
	rcall store_data
	sts stat,__zero_reg__
	ldi r24,lo8(1)
	ret
.L34:
	cpi r24,-23
	ldi r18,3
	cpc r25,r18
	brlo .L35
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L46
	ldi r25,lo8(13)
	sts stat,r25
	or r22,r23
	breq .+2
	rjmp .L26
	lds r24,serie
	subi r24,lo8(-(1))
	cpi r24,lo8(12)
	brsh .L36
	sts serie,r24
	rjmp .L37
.L36:
	ldi r24,lo8(1)
	sts serie,r24
.L37:
	ldi r24,lo8(1)
	sts mode,r24
	rcall store_data
	sts stat,__zero_reg__
	ldi r24,lo8(1)
	ret
.L35:
	cpi r24,101
	cpc r25,__zero_reg__
	brlo .L47
	or r22,r23
	brne .L48
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L38
	lds r24,mode
	subi r24,lo8(-(1))
	cpi r24,lo8(10)
	brsh .L39
	sts mode,r24
	rjmp .L40
.L39:
	ldi r24,lo8(1)
	sts mode,r24
	rjmp .L40
.L38:
	lds r24,pointer
	subi r24,lo8(-(1))
	sts pointer,r24
	lds r25,counter
	cp r25,r24
	brsh .L40
	ldi r24,lo8(1)
	sts pointer,r24
.L40:
	rcall check_all
	rcall store_data
	ldi r24,lo8(1)
	ret
.L41:
	ldi r24,0
	ret
.L42:
	ldi r24,0
	ret
.L43:
	ldi r24,0
	ret
.L44:
	ldi r24,0
	ret
.L45:
	ldi r24,0
	ret
.L46:
	ldi r24,0
	ret
.L47:
	ldi r24,0
	ret
.L48:
	ldi r24,0
.L26:
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
	sts button_state.1838,__zero_reg__
	sbrc r24,4
	rjmp .L50
	ldi r24,lo8(1)
	sts button_state.1838,r24
	lds r24,hold.1837
	lds r25,hold.1837+1
	adiw r24,1
	sts hold.1837+1,r25
	sts hold.1837,r24
	lds r22,last_button_state.1839
	cpi r22,lo8(1)
	brne .L55
.L53:
	ldi r23,0
	lds r24,hold.1837
	lds r25,hold.1837+1
	rcall process_button
	rjmp .L51
.L55:
	ldi r24,0
.L51:
	lds r25,button_state.1838
	cpse r25,__zero_reg__
	rjmp .L52
.L54:
	lds r18,last_button_state.1839
	cpse r18,__zero_reg__
	rjmp .L52
	sts hold.1837+1,__zero_reg__
	sts hold.1837,__zero_reg__
.L52:
	sts last_button_state.1839,r25
	ret
.L50:
	lds r22,last_button_state.1839
	tst r22
	breq .L53
	lds r25,button_state.1838
	ldi r24,0
	rjmp .L54
	.size	check_button, .-check_button
.global	make_light
	.type	make_light, @function
make_light:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r25,0
.L61:
	cp r25,r24
	brsh .L64
	ldi r18,lo8(34)
	rjmp .L58
.L64:
	ldi r18,lo8(32)
.L58:
	cp r25,r22
	brsh .L59
	ori r18,lo8(1)
.L59:
	cp r25,r20
	brsh .L60
	ori r18,lo8(4)
.L60:
	out 0x18,r18
	subi r25,lo8(-(1))
	cpi r25,lo8(90)
	brne .L61
	lds r24,delay.1816
	subi r24,lo8(-(1))
	cpi r24,lo8(2)
	brlo .L67
	sts delay.1816,__zero_reg__
	rjmp check_button
.L67:
	sts delay.1816,r24
	ldi r24,0
	ret
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
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_delay))
	sbci r31,hi8(-(light_delay))
	ld r22,Z
	ldi r23,0
	movw r24,r18
	rcall __mulhi3
	or r24,r25
	breq .L71
	movw r28,r18
	mov r13,r20
	ldi r16,0
	ldi r17,0
.L70:
	mov r20,r13
	mov r22,r14
	mov r24,r15
	rcall make_light
	cpi r24,lo8(1)
	breq .L69
	subi r16,-1
	sbci r17,-1
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_delay))
	sbci r31,hi8(-(light_delay))
	ld r25,Z
	mov r22,r25
	ldi r23,0
	movw r24,r28
	rcall __mulhi3
	cp r16,r24
	cpc r17,r25
	brlo .L70
	ldi r24,0
	rjmp .L69
.L71:
	ldi r24,0
.L69:
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
	push r10
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
/* stack size = 10 */
.L__stack_usage = 10
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r25,Z
	tst r25
	breq .L77
	mov r11,r18
	mov r15,r20
	mov r17,r22
	mov r29,r24
	ldi r28,lo8(1)
.L75:
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
	breq .L74
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L78
	subi r28,lo8(-(1))
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r10,Z
	cp r10,r28
	brsh .L75
	tst r10
	breq .L74
.L80:
	mov r20,r10
	and r20,r15
	or r20,r14
	mov r22,r10
	and r22,r17
	or r22,r16
	movw r18,r12
	mov r24,r10
	and r24,r29
	or r24,r11
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L74
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L79
	dec r10
	cpse r10,__zero_reg__
	rjmp .L80
	rjmp .L74
.L77:
	ldi r24,0
	rjmp .L74
.L78:
	ldi r24,lo8(1)
	rjmp .L74
.L79:
	ldi r24,lo8(1)
.L74:
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
	pop r10
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
	breq .L85
	cpi r24,lo8(3)
	breq .L86
	cpi r24,lo8(1)
	brne .L97
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
	rjmp .L88
.L85:
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
	rjmp .L88
.L86:
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
	rjmp .L88
.L97:
	cpi r24,lo8(5)
	breq .L90
	cpi r24,lo8(6)
	breq .L91
	cpi r24,lo8(4)
	brne .L98
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
	rjmp .L88
.L90:
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
	rjmp .L88
.L91:
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
	rjmp .L88
.L98:
	cpi r24,lo8(8)
	breq .L93
	cpi r24,lo8(9)
	breq .L94
	cpi r24,lo8(7)
	brne .L99
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
	rjmp .L88
.L93:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(half_light))
	sbci r31,hi8(-(half_light))
	mov __tmp_reg__,r31
	ldi r31,lo8(-56)
	mov r12,r31
	mov r13,__zero_reg__
	mov r31,__tmp_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,lo8(-1)
	ldi r20,0
	ld r22,Z
	ldi r24,lo8(-1)
	rcall basic_pulse
	rjmp .L88
.L94:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(half_light))
	sbci r31,hi8(-(half_light))
	mov __tmp_reg__,r31
	ldi r31,lo8(-56)
	mov r12,r31
	mov r13,__zero_reg__
	mov r31,__tmp_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,lo8(-1)
	ld r20,Z
	ldi r22,0
	ldi r24,lo8(-1)
	rcall basic_pulse
	rjmp .L88
.L99:
	ldi r24,0
.L88:
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
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 4 */
.L__stack_usage = 4
	movw r16,r24
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r24,Z
	ldi r28,0
	ldi r29,0
.L102:
	movw r18,r16
	ldi r20,0
	mov r22,r28
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L100
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L100
	adiw r28,1
	lds r25,brightness
	mov r30,r25
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r24,Z
	mov r18,r24
	ldi r19,0
	cp r18,r28
	cpc r19,r29
	brsh .L102
	tst r24
	breq .L103
	ldi r28,lo8(1)
	ldi r29,0
.L104:
	movw r18,r16
	ldi r20,0
	mov r22,r24
	sub r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L100
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L100
	adiw r28,1
	lds r25,brightness
	mov r30,r25
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r24,Z
	mov r18,r24
	ldi r19,0
	cp r18,r28
	cpc r19,r29
	brsh .L104
	mov r22,r24
	tst r24
	breq .L105
	ldi r28,lo8(1)
	ldi r29,0
.L106:
	movw r18,r16
	mov r20,r28
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L100
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L100
	adiw r28,1
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r22,Z
	mov r24,r22
	ldi r25,0
	cp r24,r28
	cpc r25,r29
	brsh .L106
.L103:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r20,Z
	tst r20
	brne .+2
	rjmp .L100
	ldi r28,lo8(1)
	ldi r29,0
.L107:
	mov r22,r20
	sub r22,r28
	movw r18,r16
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L100
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L100
	adiw r28,1
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r20,Z
	mov r24,r20
	ldi r25,0
	cp r24,r28
	cpc r25,r29
	brsh .L107
.L105:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r20,Z
	tst r20
	breq .L100
	ldi r28,lo8(1)
	ldi r29,0
.L108:
	movw r18,r16
	ldi r22,0
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L100
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L100
	adiw r28,1
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r20,Z
	mov r24,r20
	ldi r25,0
	cp r24,r28
	cpc r25,r29
	brsh .L108
	mov r24,r20
	tst r20
	breq .L100
	ldi r28,lo8(1)
	ldi r29,0
.L109:
	mov r20,r24
	sub r20,r28
	movw r18,r16
	ldi r22,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L100
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L100
	adiw r28,1
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r24,Z
	mov r18,r24
	ldi r19,0
	cp r18,r28
	cpc r19,r29
	brsh .L109
.L100:
/* epilogue start */
	pop r29
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
	mov r15,r24
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r24,Z
	tst r24
	breq .L117
	mov r13,r20
	mov r14,r22
	ldi r17,0
	ldi r29,0
	ldi r28,0
	ldi r16,0
.L118:
	ldi r18,lo8(5)
	ldi r19,0
	mov r20,r17
	mov r22,r29
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L117
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L119
	subi r16,lo8(-(1))
	add r28,r15
	add r29,r14
	add r17,r13
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r25,Z
	cp r16,r25
	brlo .L118
	rjmp .L117
.L119:
	ldi r24,lo8(1)
.L117:
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
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r24,Z
	tst r24
	brne .+2
	rjmp .L122
	ldi r28,0
.L124:
	mov r22,r24
	sub r22,r28
	ldi r18,lo8(2)
	ldi r19,0
	mov r20,r22
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L121
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L121
	subi r28,lo8(-(1))
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r24,Z
	cp r28,r24
	brlo .L124
	rjmp .L122
.L125:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ldi r18,lo8(2)
	ldi r19,0
	ldi r20,0
	mov r22,r28
	ld r24,Z
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L121
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L121
	subi r28,lo8(-(1))
	cpi r28,lo8(90)
	brne .L125
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r24,Z
	tst r24
	brne .+2
	rjmp .L126
	ldi r28,0
.L127:
	ldi r18,lo8(2)
	ldi r19,0
	ldi r20,0
	mov r22,r24
	sub r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L121
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L121
	subi r28,lo8(-(1))
	lds r25,brightness
	mov r30,r25
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r24,Z
	cp r28,r24
	brlo .L127
	mov r22,r24
	tst r24
	breq .L128
	ldi r28,0
.L129:
	ldi r18,lo8(2)
	ldi r19,0
	mov r20,r28
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L121
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L121
	subi r28,lo8(-(1))
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r22,Z
	cp r28,r22
	brlo .L129
	mov r20,r22
	tst r22
	breq .L126
	ldi r28,0
.L130:
	mov r22,r20
	sub r22,r28
	ldi r18,lo8(2)
	ldi r19,0
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L121
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L121
	subi r28,lo8(-(1))
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r20,Z
	cp r28,r20
	brlo .L130
.L128:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r20,Z
	tst r20
	breq .L126
	ldi r28,0
.L131:
	sub r20,r28
	ldi r18,lo8(2)
	ldi r19,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L121
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L121
	subi r28,lo8(-(1))
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r20,Z
	cp r28,r20
	brlo .L131
.L126:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
/* epilogue start */
	pop r28
	rjmp l_make_light
.L122:
	ldi r28,0
	rjmp .L125
.L121:
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
	breq .L140
	brsh .L141
	cpi r24,lo8(1)
	breq .L142
	cpi r24,lo8(2)
	breq .L143
	rjmp .L139
.L141:
	cpi r24,lo8(4)
	breq .L144
	cpi r24,lo8(5)
	breq .L145
	rjmp .L139
.L142:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rjmp make_saw
.L143:
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,0
	rjmp make_saw
.L140:
	ldi r20,lo8(1)
	ldi r22,0
	ldi r24,0
	rjmp make_saw
.L144:
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	rjmp make_saw
.L145:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	brne .+2
	rjmp .L138
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L138
	ldi r20,0
	ldi r22,lo8(1)
	rjmp make_saw
.L139:
	cpi r24,lo8(7)
	breq .L147
	brsh .L148
	cpi r24,lo8(6)
	breq .L149
	ret
.L148:
	cpi r24,lo8(8)
	breq .L150
	cpi r24,lo8(9)
	brne .+2
	rjmp .L151
	ret
.L149:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	brne .+2
	rjmp .L138
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L138
	ldi r20,lo8(1)
	ldi r22,0
	rjmp make_saw
.L147:
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,0
	rcall make_saw
	cpi r24,lo8(1)
	breq .L138
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L138
	ldi r20,lo8(1)
	ldi r22,0
	rjmp make_saw
.L150:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L138
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L138
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L138
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L138
	ldi r20,0
	ldi r22,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L138
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L138
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L138
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L138
	ldi r20,lo8(1)
	ldi r22,0
	rcall make_saw
	cpi r24,lo8(1)
	breq .L138
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L138
	ldi r20,lo8(1)
	ldi r22,0
	ldi r24,lo8(1)
	rjmp make_saw
.L151:
	rjmp make_saw_rainbow
.L138:
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
	breq .L154
	cpi r24,lo8(3)
	breq .L155
	cpi r24,lo8(1)
	brne .L165
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
.L154:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(3)
	rjmp make_light
.L155:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	ldi r22,lo8(3)
	ldi r24,lo8(3)
	rjmp make_light
.L165:
	cpi r24,lo8(5)
	breq .L158
	cpi r24,lo8(6)
	breq .L159
	cpi r24,lo8(4)
	brne .L166
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	ldi r22,lo8(3)
	ldi r24,0
	rjmp make_light
.L158:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(3)
	ldi r22,lo8(3)
	ldi r24,0
	rjmp make_light
.L159:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(3)
	ldi r22,0
	ldi r24,0
	rjmp make_light
.L166:
	cpi r24,lo8(8)
	breq .L162
	cpi r24,lo8(9)
	breq .L163
	cpi r24,lo8(7)
	brne .L167
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(3)
	ldi r22,0
	ldi r24,lo8(3)
	rjmp make_light
.L162:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	ldi r24,lo8(3)
	rjmp make_light
.L163:
	ldi r20,lo8(3)
	ldi r22,lo8(3)
	ldi r24,lo8(3)
	rjmp make_light
.L167:
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
	breq .L170
	cpi r24,lo8(3)
	breq .L171
	cpi r24,lo8(1)
	brne .L192
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ldi r20,0
	ldi r22,0
	ld r24,Z
	rjmp make_light
.L170:
	lds r24,brightness
	ldi r25,0
	movw r30,r24
	subi r30,lo8(-(half_light))
	sbci r31,hi8(-(half_light))
	movw r26,r24
	subi r26,lo8(-(light_r))
	sbci r27,hi8(-(light_r))
	ldi r20,0
	ld r22,Z
	ld r24,X
	rjmp make_light
.L171:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r24,Z
	ldi r20,0
	mov r22,r24
	rjmp make_light
.L192:
	cpi r24,lo8(5)
	breq .L174
	cpi r24,lo8(6)
	breq .L175
	cpi r24,lo8(4)
	brne .L193
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ldi r20,0
	ld r22,Z
	ldi r24,0
	rjmp make_light
.L174:
	lds r24,brightness
	ldi r25,0
	movw r30,r24
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	movw r26,r24
	subi r26,lo8(-(half_light))
	sbci r27,hi8(-(half_light))
	ld r20,Z
	ld r22,X
	ldi r24,0
	rjmp make_light
.L175:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r20,Z
	ldi r22,0
	ldi r24,0
	rjmp make_light
.L193:
	cpi r24,lo8(8)
	breq .L178
	cpi r24,lo8(9)
	breq .L179
	cpi r24,lo8(7)
	brne .L194
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r24,Z
	mov r20,r24
	ldi r22,0
	rjmp make_light
.L178:
	lds r24,brightness
	ldi r25,0
	movw r30,r24
	subi r30,lo8(-(half_light))
	sbci r31,hi8(-(half_light))
	ld r22,Z
	movw r30,r24
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	mov r20,r22
	ld r24,Z
	rjmp make_light
.L179:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r24,Z
	mov r20,r24
	mov r22,r24
	rjmp make_light
.L194:
	cpi r24,lo8(12)
	breq .L182
	brsh .L183
	cpi r24,lo8(10)
	breq .L184
	cpi r24,lo8(11)
	breq .L185
	rjmp .L181
.L183:
	cpi r24,lo8(13)
	breq .L186
	cpi r24,lo8(14)
	breq .L187
	rjmp .L181
.L184:
	ldi r20,0
	ldi r22,lo8(3)
	ldi r24,0
	rjmp make_light
.L185:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(3)
	rjmp make_light
.L182:
	ldi r20,lo8(3)
	ldi r22,lo8(3)
	ldi r24,lo8(3)
	rjmp make_light
.L186:
	ldi r20,lo8(3)
	ldi r22,0
	ldi r24,0
	rjmp make_light
.L187:
	ldi r20,0
	ldi r22,lo8(3)
	ldi r24,lo8(3)
	rjmp make_light
.L181:
	cpi r24,lo8(15)
	breq .L189
	cpi r24,lo8(16)
	breq .L190
	rjmp .L195
.L189:
	ldi r20,0
	ldi r22,lo8(3)
	ldi r24,lo8(3)
	rjmp make_light
.L190:
	ldi r20,lo8(3)
	ldi r22,0
	ldi r24,lo8(3)
	rjmp make_light
.L195:
	cpse r24,__zero_reg__
	rjmp .L191
	ldi r20,0
	ldi r22,0
	rjmp make_light
.L191:
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
	movw r28,r24
	mov r15,r22
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_delay))
	sbci r31,hi8(-(light_delay))
	ld r24,Z
	ldi r25,0
	movw r22,r28
	rcall __mulhi3
	or r24,r25
	breq .L199
	ldi r16,0
	ldi r17,0
.L198:
	mov r24,r15
	rcall make_color
	cpi r24,lo8(1)
	breq .L197
	subi r16,-1
	sbci r17,-1
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_delay))
	sbci r31,hi8(-(light_delay))
	ld r22,Z
	ldi r23,0
	movw r24,r28
	rcall __mulhi3
	cp r16,r24
	cpc r17,r25
	brlo .L198
	ldi r24,0
	rjmp .L197
.L199:
	ldi r24,0
.L197:
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
.L203:
	movw r22,r28
	movw r24,r16
	rcall long_color
	cpi r24,lo8(1)
	breq .L201
	lds r25,stat
	cpse r25,__zero_reg__
	rjmp .L201
	adiw r28,1
	cpi r28,10
	cpc r29,__zero_reg__
	brne .L203
.L201:
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
	breq .L207
	brsh .L208
	cpi r24,lo8(1)
	breq .L209
	cpi r24,lo8(2)
	breq .L210
	rjmp .L206
.L208:
	cpi r24,lo8(4)
	breq .L211
	cpi r24,lo8(5)
	breq .L212
	rjmp .L206
.L209:
	ldi r24,lo8(10)
	ldi r25,0
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad
.L210:
	ldi r24,lo8(50)
	ldi r25,0
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad
.L207:
	ldi r24,lo8(-106)
	ldi r25,0
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad
.L211:
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad
.L212:
	ldi r24,lo8(-36)
	ldi r25,lo8(5)
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad
.L206:
	cpi r24,lo8(7)
	breq .L214
	brsh .L215
	cpi r24,lo8(6)
	breq .L216
	rjmp .L205
.L215:
	cpi r24,lo8(8)
	breq .L217
	cpi r24,lo8(9)
	breq .L219
	rjmp .L205
.L216:
	ldi r24,lo8(100)
	ldi r25,0
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad_2
.L214:
	ldi r24,lo8(-112)
	ldi r25,lo8(1)
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad_2
.L217:
	ldi r24,lo8(-80)
	ldi r25,lo8(4)
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad_2
.L219:
	ldi r28,lo8(1)
	ldi r29,0
.L218:
	movw r22,r28
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L205
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L205
	adiw r28,1
	cpi r28,9
	cpc r29,__zero_reg__
	brne .L218
.L205:
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
	breq .L223
	brsh .L224
	cpi r24,lo8(1)
	breq .L225
	cpi r24,lo8(2)
	breq .L226
	rjmp .L222
.L224:
	cpi r24,lo8(4)
	breq .L227
	cpi r24,lo8(5)
	brne .+2
	rjmp .L228
	rjmp .L222
.L225:
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L221
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L221
	ldi r22,lo8(4)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rjmp long_color
.L226:
	ldi r22,lo8(4)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L221
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L221
	ldi r22,lo8(6)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rjmp long_color
.L223:
	ldi r22,lo8(6)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L221
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L221
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rjmp long_color
.L227:
	ldi r22,lo8(2)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L221
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L221
	ldi r22,lo8(5)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rjmp long_color
.L228:
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L221
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L221
	ldi r22,lo8(2)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rjmp long_color
.L222:
	cpi r24,lo8(7)
	breq .L230
	brsh .L231
	cpi r24,lo8(6)
	breq .L232
	ret
.L231:
	cpi r24,lo8(8)
	brne .+2
	rjmp .L233
	cpi r24,lo8(9)
	brne .+2
	rjmp .L234
	ret
.L232:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L221
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L221
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L221
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L221
	ldi r22,lo8(4)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L221
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L221
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp long_color
.L230:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L221
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L221
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L221
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L221
	ldi r22,lo8(6)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L221
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L221
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp long_color
.L233:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L221
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L221
	ldi r22,lo8(9)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L221
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L221
	ldi r22,lo8(6)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L221
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L221
	ldi r22,lo8(4)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp long_color
.L234:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L221
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L221
	ldi r22,lo8(4)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L221
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L221
	ldi r22,lo8(6)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L221
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L221
	ldi r22,lo8(4)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp long_color
.L221:
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
	breq .L236
	lds r25,stat
	cpse r25,__zero_reg__
	rjmp .L238
	ldi r22,0
	ldi r23,0
	movw r24,r28
	rcall long_color
	cpi r24,lo8(1)
	breq .L236
	ldi r24,lo8(1)
	lds r25,stat
	cpse r25,__zero_reg__
	rjmp .L236
	ldi r24,0
	rjmp .L236
.L238:
	ldi r24,lo8(1)
.L236:
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
	breq .L241
	brsh .L242
	cpi r24,lo8(1)
	breq .L243
	cpi r24,lo8(2)
	breq .L244
	rjmp .L240
.L242:
	cpi r24,lo8(4)
	brne .+2
	rjmp .L245
	cpi r24,lo8(5)
	brne .+2
	rjmp .L246
	rjmp .L240
.L243:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L239
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L239
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L244:
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L239
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L239
	ldi r20,lo8(6)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L241:
	ldi r20,lo8(6)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L239
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L239
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L245:
	ldi r20,lo8(2)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L239
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L239
	ldi r20,lo8(5)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L246:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L239
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L239
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L239
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L239
	ldi r20,lo8(6)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L240:
	cpi r24,lo8(7)
	breq .L248
	brsh .L249
	cpi r24,lo8(6)
	breq .L250
	ret
.L249:
	cpi r24,lo8(8)
	breq .L251
	cpi r24,lo8(9)
	breq .L252
	ret
.L250:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L239
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L239
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L248:
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L239
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L239
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L251:
	ldi r20,lo8(6)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L239
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L239
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L252:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L239
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L239
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L239
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L239
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L239
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L239
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L239
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L239
	ldi r20,lo8(6)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L239
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L239
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L239:
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
	breq .L255
	brsh .L256
	cpi r24,lo8(1)
	breq .L257
	cpi r24,lo8(2)
	breq .L258
	rjmp .L254
.L256:
	cpi r24,lo8(4)
	breq .L259
	cpi r24,lo8(5)
	breq .L260
	rjmp .L254
.L257:
	mov r24,r22
	rjmp make_color
.L258:
	mov r20,r22
	ldi r22,lo8(20)
	ldi r23,0
	ldi r24,lo8(20)
	ldi r25,0
	rjmp make_strob
.L255:
	mov r20,r22
	ldi r22,lo8(50)
	ldi r23,0
	ldi r24,lo8(50)
	ldi r25,0
	rjmp make_strob
.L259:
	mov r20,r22
	ldi r22,lo8(100)
	ldi r23,0
	ldi r24,lo8(100)
	ldi r25,0
	rjmp make_strob
.L260:
	mov r20,r22
	ldi r22,lo8(-12)
	ldi r23,lo8(1)
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
	rjmp make_strob
.L254:
	cpi r24,lo8(8)
	breq .L262
	brsh .L263
	cpi r24,lo8(6)
	breq .L264
	cpi r24,lo8(7)
	breq .L265
	ret
.L263:
	cpi r24,lo8(10)
	breq .L266
	brlo .L267
	cpi r24,lo8(11)
	breq .L268
	ret
.L264:
	mov r24,r22
	rjmp make_pulse
.L265:
	mov r24,r22
	rjmp grad_serie
.L262:
	mov r24,r22
	rjmp make_complex_strob
.L267:
	mov r24,r22
	rjmp make_mix
.L266:
	mov r24,r22
	rjmp make_mix_2
.L268:
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
	out 0x3b,__zero_reg__
	out 0x15,__zero_reg__
/* #APP */
 ;  234 "csb-light-grb-3.4b.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	sts stat,__zero_reg__
	ldi r28,lo8(32)
.L270:
	lds r24,power
	cpi r24,lo8(2)
	brne .L271
	rcall init_io
	out 0x3b,__zero_reg__
	out 0x15,__zero_reg__
/* #APP */
 ;  242 "csb-light-grb-3.4b.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	ldi r24,lo8(10)
	sts power,r24
	sbic 0x16,4
	rjmp .L272
.L286:
	sbis 0x16,4
	rjmp .L286
.L272:
	ldi r18,lo8(79999)
	ldi r24,hi8(79999)
	ldi r25,hlo8(79999)
1:	subi r18,1
	sbci r24,0
	sbci r25,0
	brne 1b
	rjmp .
	nop
	rjmp .L270
.L271:
	cpi r24,lo8(3)
	brne .L275
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
 ;  267 "csb-light-grb-3.4b.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
	sts power,__zero_reg__
/* #APP */
 ;  269 "csb-light-grb-3.4b.c" 1
	sleep
	
 ;  0 "" 2
/* #NOAPP */
	in r24,0x35
	andi r24,lo8(-33)
	out 0x35,r24
	rjmp .L270
.L275:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L276
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L277
	lds r22,mode
	lds r24,serie
	rcall make_serie
	rjmp .L270
.L277:
	lds r24,counter
	tst r24
	breq .L278
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
	rjmp .L270
.L278:
	ldi r24,0
	rcall make_color
	rjmp .L270
.L276:
	cpi r24,lo8(10)
	brne .L279
	rcall make_color
	rjmp .L270
.L279:
	cpi r24,lo8(11)
	brne .L280
	rcall make_color
	rjmp .L270
.L280:
	cpi r24,lo8(12)
	brne .L281
	rcall make_color
	rjmp .L270
.L281:
	cpi r24,lo8(13)
	brne .L282
	rcall make_color
	rjmp .L270
.L282:
	cpi r24,lo8(14)
	brne .L283
	rcall make_color
	rjmp .L270
.L283:
	cpi r24,lo8(15)
	brne .L284
	rcall make_color
	rjmp .L270
.L284:
	cpi r24,lo8(16)
	brne .L285
	rcall make_color
	rjmp .L270
.L285:
	ldi r24,0
	rcall make_color
	rjmp .L270
	.size	main, .-main
	.local	last_button_state.1839
	.comm	last_button_state.1839,1,1
	.local	hold.1837
	.comm	hold.1837,2,1
	.local	button_state.1838
	.comm	button_state.1838,1,1
	.local	delay.1816
	.comm	delay.1816,1,1
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
.global	half_light
	.data
	.type	half_light, @object
	.size	half_light, 4
half_light:
	.byte	27
	.byte	13
	.byte	4
	.byte	2
.global	light_r
	.type	light_r, @object
	.size	light_r, 4
light_r:
	.byte	90
	.byte	45
	.byte	15
	.byte	9
.global	light_delay
	.type	light_delay, @object
	.size	light_delay, 4
light_delay:
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.comm	brightness,1,1
	.comm	serie,1,1
	.comm	mode,1,1
	.ident	"GCC: (GNU) 4.9.2"
.global __do_copy_data
.global __do_clear_bss
