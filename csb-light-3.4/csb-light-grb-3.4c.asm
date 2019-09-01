	.file	"csb-light-grb-3.4c.c"
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
 ;  205 "csb-light-grb-3.4c.c" 1
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
	cpi r24,17
	ldi r18,39
	cpc r25,r18
	brlo .L30
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L43
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
.L30:
	cpi r24,89
	ldi r18,27
	cpc r25,r18
	brlo .L31
	ldi r24,lo8(16)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L44
	lds r24,brightness
	subi r24,lo8(-(1))
	cpi r24,lo8(4)
	brsh .L32
	sts brightness,r24
	rjmp .L33
.L32:
	sts brightness,__zero_reg__
.L33:
	rcall store_data
	sts stat,__zero_reg__
	ldi r24,lo8(1)
	ret
.L31:
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
	sts button_state.1925,__zero_reg__
	sbrc r24,4
	rjmp .L50
	ldi r24,lo8(1)
	sts button_state.1925,r24
	lds r24,hold.1924
	lds r25,hold.1924+1
	adiw r24,1
	sts hold.1924+1,r25
	sts hold.1924,r24
	lds r22,last_button_state.1926
	cpi r22,lo8(1)
	brne .L54
.L52:
	ldi r23,0
	lds r24,hold.1924
	lds r25,hold.1924+1
	rcall process_button
	lds r25,button_state.1925
	cpse r25,__zero_reg__
	rjmp .L51
.L53:
	lds r25,last_button_state.1926
	cpse r25,__zero_reg__
	rjmp .L55
	sts hold.1924+1,__zero_reg__
	sts hold.1924,__zero_reg__
	rjmp .L51
.L54:
	ldi r25,lo8(1)
	ldi r24,0
	rjmp .L51
.L55:
	ldi r25,0
.L51:
	sts last_button_state.1926,r25
	ret
.L50:
	lds r22,last_button_state.1926
	tst r22
	breq .L52
	ldi r24,0
	rjmp .L53
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
	lds r24,delay.1903
	subi r24,lo8(-(1))
	cpi r24,lo8(2)
	brlo .L67
	sts delay.1903,__zero_reg__
	rjmp check_button
.L67:
	sts delay.1903,r24
	ldi r24,0
	ret
	.size	make_light, .-make_light
.global	__mulsf3
.global	__gtsf2
.global	__floatunsisf
.global	__ltsf2
.global	l_make_light
	.type	l_make_light, @function
l_make_light:
	push r5
	push r6
	push r7
	push r8
	push r9
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
/* stack size = 15 */
.L__stack_usage = 15
	mov r7,r24
	mov r6,r22
	mov r5,r20
	movw r8,r16
	movw r10,r18
	lds r30,brightness
	ldi r31,0
	lsl r30
	rol r31
	lsl r30
	rol r31
	subi r30,lo8(-(light_delay))
	sbci r31,hi8(-(light_delay))
	ld r18,Z
	ldd r19,Z+1
	ldd r20,Z+2
	ldd r21,Z+3
	movw r24,r10
	movw r22,r8
	rcall __mulsf3
	ldi r18,0
	ldi r19,0
	movw r20,r18
	rcall __gtsf2
	cp __zero_reg__,r24
	brge .L75
	ldi r28,0
	ldi r29,0
.L71:
	mov r20,r5
	mov r22,r6
	mov r24,r7
	rcall make_light
	cpi r24,lo8(1)
	breq .L69
	adiw r28,1
	movw r22,r28
	ldi r24,0
	ldi r25,0
	rcall __floatunsisf
	movw r12,r22
	movw r14,r24
	lds r30,brightness
	ldi r31,0
	lsl r30
	rol r31
	lsl r30
	rol r31
	subi r30,lo8(-(light_delay))
	sbci r31,hi8(-(light_delay))
	ld r18,Z
	ldd r19,Z+1
	ldd r20,Z+2
	ldd r21,Z+3
	movw r24,r10
	movw r22,r8
	rcall __mulsf3
	movw r18,r22
	movw r20,r24
	movw r24,r14
	movw r22,r12
	rcall __ltsf2
	tst r24
	brlt .L71
	ldi r24,0
	rjmp .L69
.L75:
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
	pop r12
	pop r11
	pop r10
	pop r9
	pop r8
	pop r7
	pop r6
	pop r5
	ret
	.size	l_make_light, .-l_make_light
.global	basic_pulse
	.type	basic_pulse, @function
basic_pulse:
	push r2
	push r3
	push r4
	push r5
	push r6
	push r7
	push r8
	push r9
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
/* stack size = 18 */
.L__stack_usage = 18
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r25,Z
	tst r25
	brne .+2
	rjmp .L80
	movw r2,r12
	mov r6,r16
	mov r7,r18
	mov r13,r20
	mov r15,r22
	mov r29,r24
	ldi r28,lo8(1)
	mov r4,__zero_reg__
	mov r5,__zero_reg__
.L78:
	movw r24,r4
	movw r22,r2
	rcall __floatunsisf
	movw r8,r22
	movw r10,r24
	mov r20,r13
	and r20,r28
	or r20,r14
	mov r22,r15
	and r22,r28
	or r22,r6
	movw r18,r10
	movw r16,r8
	mov r24,r29
	and r24,r28
	or r24,r7
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L77
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L81
	subi r28,lo8(-(1))
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r12,Z
	cp r12,r28
	brsh .L78
	tst r12
	breq .L77
.L83:
	mov r20,r13
	and r20,r12
	or r20,r14
	mov r22,r15
	and r22,r12
	or r22,r6
	movw r18,r10
	movw r16,r8
	mov r24,r29
	and r24,r12
	or r24,r7
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L77
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L82
	dec r12
	cpse r12,__zero_reg__
	rjmp .L83
	rjmp .L77
.L80:
	ldi r24,0
	rjmp .L77
.L81:
	ldi r24,lo8(1)
	rjmp .L77
.L82:
	ldi r24,lo8(1)
.L77:
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
	pop r9
	pop r8
	pop r7
	pop r6
	pop r5
	pop r4
	pop r3
	pop r2
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
	breq .L88
	cpi r24,lo8(3)
	breq .L89
	cpi r24,lo8(1)
	brne .L100
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
	rjmp .L91
.L88:
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
	rjmp .L91
.L89:
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
	rjmp .L91
.L100:
	cpi r24,lo8(5)
	breq .L93
	cpi r24,lo8(6)
	breq .L94
	cpi r24,lo8(4)
	brne .L101
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
	rjmp .L91
.L93:
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
	rjmp .L91
.L94:
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
	rjmp .L91
.L101:
	cpi r24,lo8(8)
	breq .L96
	cpi r24,lo8(9)
	breq .L97
	cpi r24,lo8(7)
	brne .L102
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
	rjmp .L91
.L96:
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
	rjmp .L91
.L97:
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
	rjmp .L91
.L102:
	ldi r24,0
.L91:
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
	push r7
	push r8
	push r9
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
/* stack size = 13 */
.L__stack_usage = 13
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r7,Z
	ldi r28,0
	ldi r29,0
	movw r8,r24
	mov r10,__zero_reg__
	mov r11,__zero_reg__
.L105:
	movw r24,r10
	movw r22,r8
	rcall __floatunsisf
	movw r12,r22
	movw r14,r24
	movw r16,r22
	movw r18,r24
	ldi r20,0
	mov r22,r28
	mov r24,r7
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L103
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L103
	adiw r28,1
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r7,Z
	mov r24,r7
	ldi r25,0
	cp r24,r28
	cpc r25,r29
	brsh .L105
	or r24,r25
	breq .L106
	ldi r28,lo8(1)
	ldi r29,0
.L107:
	movw r18,r14
	movw r16,r12
	ldi r20,0
	mov r22,r7
	mov r24,r7
	sub r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L103
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L103
	adiw r28,1
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r7,Z
	mov r24,r7
	ldi r25,0
	cp r24,r28
	cpc r25,r29
	brsh .L107
	tst r7
	brne .+2
	rjmp .L103
	ldi r28,lo8(1)
	ldi r29,0
.L108:
	movw r18,r14
	movw r16,r12
	mov r20,r28
	mov r22,r7
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L103
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L103
	adiw r28,1
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r7,Z
	mov r24,r7
	ldi r25,0
	cp r24,r28
	cpc r25,r29
	brsh .L108
.L106:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r20,Z
	tst r20
	brne .+2
	rjmp .L103
	ldi r28,lo8(1)
	ldi r29,0
.L109:
	mov r22,r20
	sub r22,r28
	movw r18,r14
	movw r16,r12
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L103
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L103
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
	brsh .L109
	tst r20
	breq .L103
	ldi r28,lo8(1)
	ldi r29,0
.L110:
	movw r18,r14
	movw r16,r12
	ldi r22,0
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L103
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L103
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
	brsh .L110
	mov r24,r20
	tst r20
	breq .L103
	ldi r28,lo8(1)
	ldi r29,0
.L111:
	mov r20,r24
	sub r20,r28
	movw r18,r14
	movw r16,r12
	ldi r22,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L103
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L103
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
	brsh .L111
.L103:
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
	pop r9
	pop r8
	pop r7
	ret
	.size	make_grad, .-make_grad
.global	make_saw
	.type	make_saw, @function
make_saw:
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
	mov r13,r24
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r24,Z
	tst r24
	breq .L119
	mov r11,r20
	mov r12,r22
	mov r15,__zero_reg__
	ldi r29,0
	ldi r28,0
	mov r14,__zero_reg__
.L120:
	ldi r16,0
	ldi r17,0
	ldi r18,lo8(-96)
	ldi r19,lo8(64)
	mov r20,r15
	mov r22,r29
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L119
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L121
	inc r14
	add r28,r13
	add r29,r12
	add r15,r11
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r25,Z
	cp r14,r25
	brlo .L120
	rjmp .L119
.L121:
	ldi r24,lo8(1)
.L119:
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
	.size	make_saw, .-make_saw
.global	make_saw_rainbow
	.type	make_saw_rainbow, @function
make_saw_rainbow:
	push r16
	push r17
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 3 */
.L__stack_usage = 3
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r24,Z
	tst r24
	brne .+2
	rjmp .L124
	ldi r28,0
.L126:
	mov r22,r24
	sub r22,r28
	ldi r16,0
	ldi r17,0
	ldi r18,0
	ldi r19,lo8(64)
	mov r20,r22
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L123
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L123
	subi r28,lo8(-(1))
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r24,Z
	cp r28,r24
	brlo .L126
	tst r24
	brne .+2
	rjmp .L127
	ldi r28,0
.L128:
	ldi r16,0
	ldi r17,0
	ldi r18,0
	ldi r19,lo8(64)
	ldi r20,0
	mov r22,r28
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L123
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L123
	subi r28,lo8(-(1))
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r24,Z
	cp r28,r24
	brlo .L128
	tst r24
	brne .+2
	rjmp .L129
	ldi r28,0
.L130:
	ldi r16,0
	ldi r17,0
	ldi r18,0
	ldi r19,lo8(64)
	ldi r20,0
	mov r22,r24
	sub r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L123
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L123
	subi r28,lo8(-(1))
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r24,Z
	cp r28,r24
	brlo .L130
	mov r22,r24
	tst r24
	brne .+2
	rjmp .L129
	ldi r28,0
.L131:
	ldi r16,0
	ldi r17,0
	ldi r18,0
	ldi r19,lo8(64)
	mov r20,r28
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L123
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L123
	subi r28,lo8(-(1))
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r22,Z
	cp r28,r22
	brlo .L131
.L124:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r20,Z
	tst r20
	breq .L129
	ldi r28,0
.L132:
	mov r22,r20
	sub r22,r28
	ldi r16,0
	ldi r17,0
	ldi r18,0
	ldi r19,lo8(64)
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L123
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L123
	subi r28,lo8(-(1))
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r20,Z
	cp r28,r20
	brlo .L132
.L127:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r20,Z
	tst r20
	breq .L129
	ldi r28,0
.L133:
	sub r20,r28
	ldi r16,0
	ldi r17,0
	ldi r18,0
	ldi r19,lo8(64)
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L123
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L123
	subi r28,lo8(-(1))
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r20,Z
	cp r28,r20
	brlo .L133
.L129:
	ldi r16,0
	ldi r17,0
	ldi r18,lo8(32)
	ldi r19,lo8(65)
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
.L123:
/* epilogue start */
	pop r28
	pop r17
	pop r16
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
	breq .L142
	brsh .L143
	cpi r24,lo8(1)
	breq .L144
	cpi r24,lo8(2)
	breq .L145
	rjmp .L141
.L143:
	cpi r24,lo8(4)
	breq .L146
	cpi r24,lo8(5)
	breq .L147
	rjmp .L141
.L144:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rjmp make_saw
.L145:
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,0
	rjmp make_saw
.L142:
	ldi r20,lo8(1)
	ldi r22,0
	ldi r24,0
	rjmp make_saw
.L146:
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	rjmp make_saw
.L147:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	brne .+2
	rjmp .L140
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L140
	ldi r20,0
	ldi r22,lo8(1)
	rjmp make_saw
.L141:
	cpi r24,lo8(7)
	breq .L149
	brsh .L150
	cpi r24,lo8(6)
	breq .L151
	ret
.L150:
	cpi r24,lo8(8)
	breq .L152
	cpi r24,lo8(9)
	brne .+2
	rjmp .L153
	ret
.L151:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	brne .+2
	rjmp .L140
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L140
	ldi r20,lo8(1)
	ldi r22,0
	rjmp make_saw
.L149:
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,0
	rcall make_saw
	cpi r24,lo8(1)
	breq .L140
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L140
	ldi r20,lo8(1)
	ldi r22,0
	rjmp make_saw
.L152:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L140
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L140
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L140
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L140
	ldi r20,0
	ldi r22,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L140
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L140
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L140
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L140
	ldi r20,lo8(1)
	ldi r22,0
	rcall make_saw
	cpi r24,lo8(1)
	breq .L140
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L140
	ldi r20,lo8(1)
	ldi r22,0
	ldi r24,lo8(1)
	rjmp make_saw
.L153:
	rjmp make_saw_rainbow
.L140:
	ret
	.size	make_mix_2, .-make_mix_2
.global	make_light_color
	.type	make_light_color, @function
make_light_color:
	push r16
	push r17
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	cpi r24,lo8(2)
	breq .L156
	cpi r24,lo8(3)
	breq .L157
	cpi r24,lo8(1)
	brne .L167
	ldi r16,0
	ldi r17,0
	ldi r18,lo8(32)
	ldi r19,lo8(65)
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	ldi r22,0
	ldi r24,0
/* epilogue start */
	pop r17
	pop r16
	rjmp make_light
.L156:
	ldi r16,0
	ldi r17,0
	ldi r18,lo8(32)
	ldi r19,lo8(65)
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
/* epilogue start */
	pop r17
	pop r16
	rjmp make_light
.L157:
	ldi r16,0
	ldi r17,0
	ldi r18,lo8(32)
	ldi r19,lo8(65)
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,lo8(1)
/* epilogue start */
	pop r17
	pop r16
	rjmp make_light
.L167:
	cpi r24,lo8(5)
	breq .L160
	cpi r24,lo8(6)
	breq .L161
	cpi r24,lo8(4)
	brne .L168
	ldi r16,0
	ldi r17,0
	ldi r18,lo8(32)
	ldi r19,lo8(65)
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,0
/* epilogue start */
	pop r17
	pop r16
	rjmp make_light
.L160:
	ldi r16,0
	ldi r17,0
	ldi r18,lo8(32)
	ldi r19,lo8(65)
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	ldi r24,0
/* epilogue start */
	pop r17
	pop r16
	rjmp make_light
.L161:
	ldi r16,0
	ldi r17,0
	ldi r18,lo8(32)
	ldi r19,lo8(65)
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(1)
	ldi r22,0
	ldi r24,0
/* epilogue start */
	pop r17
	pop r16
	rjmp make_light
.L168:
	cpi r24,lo8(8)
	breq .L164
	cpi r24,lo8(9)
	breq .L165
	cpi r24,lo8(7)
	brne .L169
	ldi r16,0
	ldi r17,0
	ldi r18,lo8(32)
	ldi r19,lo8(65)
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(1)
	ldi r22,0
	ldi r24,lo8(1)
/* epilogue start */
	pop r17
	pop r16
	rjmp make_light
.L164:
	ldi r16,0
	ldi r17,0
	ldi r18,lo8(32)
	ldi r19,lo8(65)
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	ldi r24,lo8(1)
/* epilogue start */
	pop r17
	pop r16
	rjmp make_light
.L165:
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	ldi r24,lo8(1)
/* epilogue start */
	pop r17
	pop r16
	rjmp make_light
.L169:
	ldi r24,0
/* epilogue start */
	pop r17
	pop r16
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
	breq .L172
	cpi r24,lo8(3)
	breq .L173
	cpi r24,lo8(1)
	brne .L194
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ldi r20,0
	ldi r22,0
	ld r24,Z
	rjmp make_light
.L172:
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
.L173:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r24,Z
	ldi r20,0
	mov r22,r24
	rjmp make_light
.L194:
	cpi r24,lo8(5)
	breq .L176
	cpi r24,lo8(6)
	breq .L177
	cpi r24,lo8(4)
	brne .L195
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ldi r20,0
	ld r22,Z
	ldi r24,0
	rjmp make_light
.L176:
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
.L177:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r20,Z
	ldi r22,0
	ldi r24,0
	rjmp make_light
.L195:
	cpi r24,lo8(8)
	breq .L180
	cpi r24,lo8(9)
	breq .L181
	cpi r24,lo8(7)
	brne .L196
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r24,Z
	mov r20,r24
	ldi r22,0
	rjmp make_light
.L180:
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
.L181:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r24,Z
	mov r20,r24
	mov r22,r24
	rjmp make_light
.L196:
	cpi r24,lo8(12)
	breq .L184
	brsh .L185
	cpi r24,lo8(10)
	breq .L186
	cpi r24,lo8(11)
	breq .L187
	rjmp .L183
.L185:
	cpi r24,lo8(13)
	breq .L188
	cpi r24,lo8(14)
	breq .L189
	rjmp .L183
.L186:
	ldi r20,0
	ldi r22,lo8(3)
	ldi r24,0
	rjmp make_light
.L187:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(3)
	rjmp make_light
.L184:
	ldi r20,lo8(3)
	ldi r22,lo8(3)
	ldi r24,lo8(3)
	rjmp make_light
.L188:
	ldi r20,lo8(3)
	ldi r22,0
	ldi r24,0
	rjmp make_light
.L189:
	ldi r20,0
	ldi r22,lo8(3)
	ldi r24,lo8(3)
	rjmp make_light
.L183:
	cpi r24,lo8(15)
	breq .L191
	cpi r24,lo8(16)
	breq .L192
	rjmp .L197
.L191:
	ldi r20,0
	ldi r22,lo8(3)
	ldi r24,lo8(3)
	rjmp make_light
.L192:
	ldi r20,lo8(3)
	ldi r22,0
	ldi r24,lo8(3)
	rjmp make_light
.L197:
	cpse r24,__zero_reg__
	rjmp .L193
	ldi r20,0
	ldi r22,0
	rjmp make_light
.L193:
	ldi r24,0
	ret
	.size	make_color, .-make_color
.global	long_color
	.type	long_color, @function
long_color:
	push r8
	push r9
	push r10
	push r11
	push r12
	push r13
	push r14
	push r15
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 11 */
.L__stack_usage = 11
	movw r8,r22
	movw r10,r24
	mov r17,r20
	lds r30,brightness
	ldi r31,0
	lsl r30
	rol r31
	lsl r30
	rol r31
	subi r30,lo8(-(light_delay))
	sbci r31,hi8(-(light_delay))
	ld r18,Z
	ldd r19,Z+1
	ldd r20,Z+2
	ldd r21,Z+3
	rcall __mulsf3
	ldi r18,0
	ldi r19,0
	movw r20,r18
	rcall __gtsf2
	cp __zero_reg__,r24
	brge .L205
	ldi r28,0
	ldi r29,0
.L201:
	mov r24,r17
	rcall make_color
	cpi r24,lo8(1)
	breq .L199
	adiw r28,1
	movw r22,r28
	ldi r24,0
	ldi r25,0
	rcall __floatunsisf
	movw r12,r22
	movw r14,r24
	lds r30,brightness
	ldi r31,0
	lsl r30
	rol r31
	lsl r30
	rol r31
	subi r30,lo8(-(light_delay))
	sbci r31,hi8(-(light_delay))
	ld r18,Z
	ldd r19,Z+1
	ldd r20,Z+2
	ldd r21,Z+3
	movw r24,r10
	movw r22,r8
	rcall __mulsf3
	movw r18,r22
	movw r20,r24
	movw r24,r14
	movw r22,r12
	rcall __ltsf2
	tst r24
	brlt .L201
	ldi r24,0
	rjmp .L199
.L205:
	ldi r24,0
.L199:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop r10
	pop r9
	pop r8
	ret
	.size	long_color, .-long_color
.global	make_grad_2
	.type	make_grad_2, @function
make_grad_2:
	push r12
	push r13
	push r14
	push r15
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 6 */
.L__stack_usage = 6
	ldi r28,lo8(1)
	ldi r29,0
	movw r12,r24
	mov r14,__zero_reg__
	mov r15,__zero_reg__
.L208:
	movw r24,r14
	movw r22,r12
	rcall __floatunsisf
	movw r20,r28
	rcall long_color
	cpi r24,lo8(1)
	breq .L206
	lds r25,stat
	cpse r25,__zero_reg__
	rjmp .L206
	adiw r28,1
	cpi r28,10
	cpc r29,__zero_reg__
	brne .L208
.L206:
/* epilogue start */
	pop r29
	pop r28
	pop r15
	pop r14
	pop r13
	pop r12
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
	breq .L212
	brsh .L213
	cpi r24,lo8(1)
	breq .L214
	cpi r24,lo8(2)
	breq .L215
	rjmp .L211
.L213:
	cpi r24,lo8(4)
	breq .L216
	cpi r24,lo8(5)
	breq .L217
	rjmp .L211
.L214:
	ldi r24,lo8(10)
	ldi r25,0
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad
.L215:
	ldi r24,lo8(50)
	ldi r25,0
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad
.L212:
	ldi r24,lo8(-106)
	ldi r25,0
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad
.L216:
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad
.L217:
	ldi r24,lo8(-36)
	ldi r25,lo8(5)
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad
.L211:
	cpi r24,lo8(7)
	breq .L219
	brsh .L220
	cpi r24,lo8(6)
	breq .L221
	rjmp .L210
.L220:
	cpi r24,lo8(8)
	breq .L222
	cpi r24,lo8(9)
	breq .L224
	rjmp .L210
.L221:
	ldi r24,lo8(100)
	ldi r25,0
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad_2
.L219:
	ldi r24,lo8(-112)
	ldi r25,lo8(1)
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad_2
.L222:
	ldi r24,lo8(-80)
	ldi r25,lo8(4)
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad_2
.L224:
	ldi r28,lo8(1)
	ldi r29,0
.L223:
	movw r20,r28
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(52)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	breq .L210
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L210
	adiw r28,1
	cpi r28,9
	cpc r29,__zero_reg__
	brne .L223
.L210:
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
	breq .L228
	brsh .L229
	cpi r24,lo8(1)
	breq .L230
	cpi r24,lo8(2)
	breq .L231
	rjmp .L227
.L229:
	cpi r24,lo8(4)
	brne .+2
	rjmp .L232
	cpi r24,lo8(5)
	brne .+2
	rjmp .L233
	rjmp .L227
.L230:
	ldi r20,lo8(1)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(112)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L226
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L226
	ldi r20,lo8(4)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(112)
	ldi r25,lo8(66)
	rjmp long_color
.L231:
	ldi r20,lo8(4)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(112)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L226
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L226
	ldi r20,lo8(6)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(112)
	ldi r25,lo8(66)
	rjmp long_color
.L228:
	ldi r20,lo8(6)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(112)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L226
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L226
	ldi r20,lo8(1)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(112)
	ldi r25,lo8(66)
	rjmp long_color
.L232:
	ldi r20,lo8(2)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(112)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L226
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L226
	ldi r20,lo8(5)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(112)
	ldi r25,lo8(66)
	rjmp long_color
.L233:
	ldi r20,lo8(1)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(112)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L226
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L226
	ldi r20,lo8(2)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(112)
	ldi r25,lo8(66)
	rjmp long_color
.L227:
	cpi r24,lo8(7)
	brne .+2
	rjmp .L235
	brsh .L236
	cpi r24,lo8(6)
	breq .L237
	ret
.L236:
	cpi r24,lo8(8)
	brne .+2
	rjmp .L238
	cpi r24,lo8(9)
	brne .+2
	rjmp .L239
	ret
.L237:
	ldi r20,0
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(52)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L226
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L226
	ldi r20,lo8(1)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(52)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L226
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L226
	ldi r20,lo8(4)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(52)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L226
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L226
	ldi r20,lo8(1)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(52)
	ldi r25,lo8(66)
	rjmp long_color
.L235:
	ldi r20,0
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(52)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L226
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L226
	ldi r20,lo8(1)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(52)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L226
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L226
	ldi r20,lo8(6)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(52)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L226
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L226
	ldi r20,lo8(1)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(52)
	ldi r25,lo8(66)
	rjmp long_color
.L238:
	ldi r20,0
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(52)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L226
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L226
	ldi r20,lo8(9)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(52)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L226
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L226
	ldi r20,lo8(6)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(52)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	breq .L226
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L226
	ldi r20,lo8(4)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(52)
	ldi r25,lo8(66)
	rjmp long_color
.L239:
	ldi r20,0
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(52)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	breq .L226
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L226
	ldi r20,lo8(4)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(52)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	breq .L226
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L226
	ldi r20,lo8(6)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(52)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	breq .L226
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L226
	ldi r20,lo8(4)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(52)
	ldi r25,lo8(66)
	rjmp long_color
.L226:
	ret
	.size	make_mix, .-make_mix
.global	make_strob
	.type	make_strob, @function
make_strob:
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 4 */
.L__stack_usage = 4
	movw r16,r22
	mov r28,r20
	ldi r29,0
	movw r22,r24
	ldi r24,0
	ldi r25,0
	rcall __floatunsisf
	movw r20,r28
	rcall long_color
	cpi r24,lo8(1)
	breq .L241
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L243
	movw r22,r16
	ldi r24,0
	ldi r25,0
	rcall __floatunsisf
	ldi r20,0
	ldi r21,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L241
	ldi r24,lo8(1)
	lds r25,stat
	cpse r25,__zero_reg__
	rjmp .L241
	ldi r24,0
	rjmp .L241
.L243:
	ldi r24,lo8(1)
.L241:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
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
	breq .L246
	brsh .L247
	cpi r24,lo8(1)
	breq .L248
	cpi r24,lo8(2)
	breq .L249
	rjmp .L245
.L247:
	cpi r24,lo8(4)
	brne .+2
	rjmp .L250
	cpi r24,lo8(5)
	brne .+2
	rjmp .L251
	rjmp .L245
.L248:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L244
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L244
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L249:
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L244
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L244
	ldi r20,lo8(6)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L246:
	ldi r20,lo8(6)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L244
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L244
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L250:
	ldi r20,lo8(2)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L244
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L244
	ldi r20,lo8(5)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L251:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L244
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L244
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L244
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L244
	ldi r20,lo8(6)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L245:
	cpi r24,lo8(7)
	breq .L253
	brsh .L254
	cpi r24,lo8(6)
	breq .L255
	ret
.L254:
	cpi r24,lo8(8)
	breq .L256
	cpi r24,lo8(9)
	breq .L257
	ret
.L255:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L244
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L244
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L253:
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L244
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L244
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L256:
	ldi r20,lo8(6)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L244
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L244
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L257:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L244
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L244
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L244
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L244
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L244
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L244
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L244
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L244
	ldi r20,lo8(6)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L244
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L244
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L244:
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
	breq .L260
	brsh .L261
	cpi r24,lo8(1)
	breq .L262
	cpi r24,lo8(2)
	breq .L263
	rjmp .L259
.L261:
	cpi r24,lo8(4)
	breq .L264
	cpi r24,lo8(5)
	breq .L265
	rjmp .L259
.L262:
	mov r24,r22
	rjmp make_color
.L263:
	mov r20,r22
	ldi r22,lo8(20)
	ldi r23,0
	ldi r24,lo8(20)
	ldi r25,0
	rjmp make_strob
.L260:
	mov r20,r22
	ldi r22,lo8(50)
	ldi r23,0
	ldi r24,lo8(50)
	ldi r25,0
	rjmp make_strob
.L264:
	mov r20,r22
	ldi r22,lo8(100)
	ldi r23,0
	ldi r24,lo8(100)
	ldi r25,0
	rjmp make_strob
.L265:
	mov r20,r22
	ldi r22,lo8(-12)
	ldi r23,lo8(1)
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
	rjmp make_strob
.L259:
	cpi r24,lo8(8)
	breq .L267
	brsh .L268
	cpi r24,lo8(6)
	breq .L269
	cpi r24,lo8(7)
	breq .L270
	ret
.L268:
	cpi r24,lo8(10)
	breq .L271
	brlo .L272
	cpi r24,lo8(11)
	breq .L273
	ret
.L269:
	mov r24,r22
	rjmp make_pulse
.L270:
	mov r24,r22
	rjmp grad_serie
.L267:
	mov r24,r22
	rjmp make_complex_strob
.L272:
	mov r24,r22
	rjmp make_mix
.L271:
	mov r24,r22
	rjmp make_mix_2
.L273:
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
 ;  234 "csb-light-grb-3.4c.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	sts stat,__zero_reg__
	ldi r28,lo8(32)
.L275:
	lds r24,power
	cpi r24,lo8(2)
	brne .L276
	rcall init_io
	out 0x3b,__zero_reg__
	out 0x15,__zero_reg__
/* #APP */
 ;  242 "csb-light-grb-3.4c.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	ldi r24,lo8(10)
	sts power,r24
	sbic 0x16,4
	rjmp .L277
.L291:
	sbis 0x16,4
	rjmp .L291
.L277:
	ldi r18,lo8(79999)
	ldi r24,hi8(79999)
	ldi r25,hlo8(79999)
1:	subi r18,1
	sbci r24,0
	sbci r25,0
	brne 1b
	rjmp .
	nop
	rjmp .L275
.L276:
	cpi r24,lo8(3)
	brne .L280
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
 ;  267 "csb-light-grb-3.4c.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
	sts power,__zero_reg__
/* #APP */
 ;  269 "csb-light-grb-3.4c.c" 1
	sleep
	
 ;  0 "" 2
/* #NOAPP */
	in r24,0x35
	andi r24,lo8(-33)
	out 0x35,r24
	rjmp .L275
.L280:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L281
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L282
	lds r22,mode
	lds r24,serie
	rcall make_serie
	rjmp .L275
.L282:
	lds r24,counter
	tst r24
	breq .L283
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
	rjmp .L275
.L283:
	ldi r24,0
	rcall make_color
	rjmp .L275
.L281:
	cpi r24,lo8(10)
	brne .L284
	rcall make_color
	rjmp .L275
.L284:
	cpi r24,lo8(11)
	brne .L285
	rcall make_color
	rjmp .L275
.L285:
	cpi r24,lo8(12)
	brne .L286
	rcall make_color
	rjmp .L275
.L286:
	cpi r24,lo8(13)
	brne .L287
	rcall make_color
	rjmp .L275
.L287:
	cpi r24,lo8(14)
	brne .L288
	rcall make_color
	rjmp .L275
.L288:
	cpi r24,lo8(15)
	brne .L289
	rcall make_color
	rjmp .L275
.L289:
	cpi r24,lo8(16)
	brne .L290
	rcall make_color
	rjmp .L275
.L290:
	ldi r24,0
	rcall make_color
	rjmp .L275
	.size	main, .-main
	.local	last_button_state.1926
	.comm	last_button_state.1926,1,1
	.local	hold.1924
	.comm	hold.1924,2,1
	.local	button_state.1925
	.comm	button_state.1925,1,1
	.local	delay.1903
	.comm	delay.1903,1,1
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
	.size	light_delay, 16
light_delay:
	.byte	0
	.byte	0
	.byte	-128
	.byte	63
	.byte	-102
	.byte	-103
	.byte	-103
	.byte	63
	.byte	-51
	.byte	-52
	.byte	-52
	.byte	63
	.byte	0
	.byte	0
	.byte	0
	.byte	64
	.comm	brightness,1,1
	.comm	serie,1,1
	.comm	mode,1,1
	.ident	"GCC: (GNU) 5.4.0"
.global __do_copy_data
.global __do_clear_bss
