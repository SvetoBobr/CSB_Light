	.file	"csb-light-grb-3.4d.c"
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
	lds r24,brightness
	cpi r24,lo8(4)
	brlo .L7
	sts brightness,__zero_reg__
.L7:
	ldi r30,lo8(modes)
	ldi r31,hi8(modes)
	ldi r26,lo8(series)
	ldi r27,hi8(series)
	ldi r24,lo8(1)
.L10:
	ld r25,Z
	cpi r25,lo8(10)
	brlo .L8
	st Z,r24
.L8:
	ld r25,X
	cpi r25,lo8(12)
	brlo .L9
	st X,r24
.L9:
	adiw r30,1
	adiw r26,1
	ldi r25,hi8(modes+15)
	cpi r30,lo8(modes+15)
	cpc r31,r25
	brne .L10
	lds r24,counter
	cpi r24,lo8(16)
	brlo .L11
	sts counter,__zero_reg__
.L11:
	lds r24,counter
	lds r25,pointer
	cp r25,r24
	brlo .L12
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
 ;  205 "csb-light-grb-3.4d.c" 1
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
	rjmp .L19
	ldi r25,lo8(10)
	sts power,r25
	ldi r25,lo8(19)
	out 0x18,r25
.L20:
	sbrc r24,4
	rjmp .L23
	in r24,0x16
	rjmp .L20
.L23:
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
.L19:
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
	breq .L26
.L29:
	ldi r24,0
	ret
.L26:
	sts pointer,__zero_reg__
	sts counter,__zero_reg__
	rjmp .L30
.L25:
	cpi r24,-55
	ldi r18,50
	cpc r25,r18
	brlo .L28
	ldi r24,lo8(11)
	sts stat,r24
	or r22,r23
	brne .L29
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L30
	ldi r24,lo8(1)
	sts fav_on,r24
	sts pointer,r24
	rjmp .L48
.L30:
	sts fav_on,__zero_reg__
	rjmp .L48
.L28:
	cpi r24,17
	ldi r18,39
	cpc r25,r18
	brlo .L32
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L29
	lds r24,counter
	cpi r24,lo8(15)
	brsh .L29
	ldi r25,lo8(10)
	sts stat,r25
	or r22,r23
	brne .L29
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
.L48:
	rcall check_all
	rjmp .L47
.L32:
	cpi r24,89
	ldi r18,27
	cpc r25,r18
	brlo .L33
	ldi r24,lo8(16)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L29
	lds r24,brightness
	subi r24,lo8(-(1))
	cpi r24,lo8(4)
	brsh .L34
	sts brightness,r24
	rjmp .L47
.L34:
	sts brightness,__zero_reg__
	rjmp .L47
.L33:
	cpi r24,-71
	ldi r18,11
	cpc r25,r18
	brlo .L36
	ldi r24,lo8(14)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L29
	ldi r24,lo8(3)
	sts power,r24
	rjmp .L47
.L36:
	cpi r24,-23
	ldi r18,3
	cpc r25,r18
	brlo .L37
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L29
	ldi r24,lo8(13)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L29
	lds r24,serie
	subi r24,lo8(-(1))
	cpi r24,lo8(12)
	brlo .L44
	ldi r24,lo8(1)
.L44:
	sts serie,r24
	ldi r24,lo8(1)
	sts mode,r24
.L47:
	rcall store_data
	sts stat,__zero_reg__
	rjmp .L46
.L37:
	cpi r24,101
	cpc r25,__zero_reg__
	brsh .+2
	rjmp .L29
	or r22,r23
	breq .+2
	rjmp .L29
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L40
	lds r24,mode
	subi r24,lo8(-(1))
	cpi r24,lo8(10)
	brlo .L45
	ldi r24,lo8(1)
.L45:
	sts mode,r24
	rjmp .L42
.L40:
	lds r24,pointer
	subi r24,lo8(-(1))
	sts pointer,r24
	lds r25,counter
	cp r25,r24
	brsh .L42
	ldi r24,lo8(1)
	sts pointer,r24
.L42:
	rcall check_all
	rcall store_data
.L46:
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
	rjmp .L50
	sts button_state.1925,__zero_reg__
	rjmp .L51
.L50:
	ldi r24,lo8(1)
	sts button_state.1925,r24
.L51:
	lds r22,button_state.1925
	cpi r22,lo8(1)
	brne .L52
	lds r24,hold.1924
	lds r25,hold.1924+1
	adiw r24,1
	sts hold.1924+1,r25
	sts hold.1924,r24
.L52:
	lds r24,last_button_state.1926
	cpse r22,r24
	rjmp .L55
	ldi r23,0
	lds r24,hold.1924
	lds r25,hold.1924+1
	rcall process_button
	rjmp .L53
.L55:
	ldi r24,0
.L53:
	lds r25,button_state.1925
	cpse r25,__zero_reg__
	rjmp .L54
	lds r18,last_button_state.1926
	cpse r18,__zero_reg__
	rjmp .L54
	sts hold.1924+1,__zero_reg__
	sts hold.1924,__zero_reg__
.L54:
	sts last_button_state.1926,r25
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
.L60:
	cp r25,r24
	brsh .L63
	ldi r18,lo8(34)
	rjmp .L57
.L63:
	ldi r18,lo8(32)
.L57:
	cp r25,r22
	brsh .L58
	ori r18,lo8(1)
.L58:
	cp r25,r20
	brsh .L59
	ori r18,lo8(4)
.L59:
	out 0x18,r18
	subi r25,lo8(-(1))
	cpi r25,lo8(90)
	brne .L60
	lds r24,delay.1903
	subi r24,lo8(-(1))
	cpi r24,lo8(2)
	brlo .L66
	sts delay.1903,__zero_reg__
	rjmp check_button
.L66:
	sts delay.1903,r24
	ldi r24,0
	ret
	.size	make_light, .-make_light
.global	__floatunsisf
.global	__mulsf3
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
	ldi r28,0
	ldi r29,0
.L68:
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
	sbrs r24,7
	rjmp .L74
	mov r20,r5
	mov r22,r6
	mov r24,r7
	rcall make_light
	cpi r24,lo8(1)
	breq .L69
	adiw r28,1
	rjmp .L68
.L74:
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
/* stack size = 16 */
.L__stack_usage = 16
	mov r15,r24
	mov r11,r22
	mov r10,r20
	mov r9,r18
	mov r8,r16
	ldi r29,lo8(1)
	movw r4,r12
	mov r6,__zero_reg__
	mov r7,__zero_reg__
.L76:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r28,Z
	cp r28,r29
	brlo .L86
	movw r24,r6
	movw r22,r4
	rcall __floatunsisf
	movw r16,r22
	movw r18,r24
	mov r20,r29
	and r20,r10
	or r20,r14
	mov r24,r29
	and r24,r11
	mov r22,r24
	or r22,r8
	mov r24,r29
	and r24,r15
	or r24,r9
	rcall l_make_light
	cpi r24,lo8(1)
	brne .L77
.L79:
	ldi r24,lo8(1)
	rjmp .L78
.L77:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L79
	subi r29,lo8(-(1))
	rjmp .L76
.L86:
	movw r4,r12
	mov r6,__zero_reg__
	mov r7,__zero_reg__
.L81:
	tst r28
	breq .L87
	movw r24,r6
	movw r22,r4
	rcall __floatunsisf
	movw r16,r22
	movw r18,r24
	mov r20,r28
	and r20,r10
	or r20,r14
	mov r24,r28
	and r24,r11
	mov r22,r24
	or r22,r8
	mov r24,r28
	and r24,r15
	or r24,r9
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L79
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L79
	subi r28,lo8(-(-1))
	rjmp .L81
.L87:
	ldi r24,0
.L78:
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
	breq .L90
	cpi r24,lo8(3)
	breq .L91
	cpi r24,lo8(1)
	brne .L102
	ldi r30,lo8(-56)
	mov r12,r30
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,0
	rjmp .L106
.L90:
	ldi r23,lo8(-56)
	mov r12,r23
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,0
	rjmp .L108
.L91:
	ldi r22,lo8(-56)
	mov r12,r22
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,0
	rjmp .L110
.L102:
	cpi r24,lo8(5)
	breq .L95
	cpi r24,lo8(6)
	breq .L96
	cpi r24,lo8(4)
	brne .L103
	ldi r21,lo8(-56)
	mov r12,r21
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
.L110:
	ldi r22,lo8(-1)
	rjmp .L109
.L95:
	ldi r20,lo8(-56)
	mov r12,r20
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
	ldi r22,0
.L109:
	ldi r24,0
	rjmp .L107
.L96:
	ldi r19,lo8(-56)
	mov r12,r19
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
	rjmp .L106
.L103:
	cpi r24,lo8(8)
	breq .L98
	cpi r24,lo8(9)
	breq .L99
	cpi r24,lo8(7)
	brne .L104
	ldi r18,lo8(-56)
	mov r12,r18
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
.L108:
	ldi r22,lo8(-1)
	rjmp .L105
.L98:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(half_light))
	sbci r31,hi8(-(half_light))
	ldi r25,lo8(-56)
	mov r12,r25
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,lo8(-1)
	ldi r20,0
	ld r22,Z
	rjmp .L105
.L99:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(half_light))
	sbci r31,hi8(-(half_light))
	ldi r24,lo8(-56)
	mov r12,r24
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,lo8(-1)
	ld r20,Z
.L106:
	ldi r22,0
.L105:
	ldi r24,lo8(-1)
.L107:
	rcall basic_pulse
	rjmp .L93
.L104:
	ldi r24,0
.L93:
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
	push r8
	push r9
	push r10
	push r11
	push r13
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 11 */
.L__stack_usage = 11
	movw r28,r24
	mov r14,__zero_reg__
	mov r15,__zero_reg__
	movw r8,r24
	mov r10,__zero_reg__
	mov r11,__zero_reg__
.L112:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r13,Z
	mov r24,r13
	ldi r25,0
	cp r24,r14
	cpc r25,r15
	brlo .L141
	movw r24,r10
	movw r22,r8
	rcall __floatunsisf
	movw r16,r22
	movw r18,r24
	ldi r20,0
	mov r22,r14
	mov r24,r13
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L111
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L111
	ldi r24,-1
	sub r14,r24
	sbc r15,r24
	rjmp .L112
.L141:
	clr r14
	inc r14
	mov r15,__zero_reg__
	movw r8,r28
	mov r10,__zero_reg__
	mov r11,__zero_reg__
.L116:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r13,Z
	mov r24,r13
	ldi r25,0
	cp r24,r14
	cpc r25,r15
	brlo .L142
	movw r24,r10
	movw r22,r8
	rcall __floatunsisf
	movw r16,r22
	movw r18,r24
	ldi r20,0
	mov r22,r13
	mov r24,r13
	sub r24,r14
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L111
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L111
	ldi r24,-1
	sub r14,r24
	sbc r15,r24
	rjmp .L116
.L142:
	clr r14
	inc r14
	mov r15,__zero_reg__
	movw r8,r28
	mov r10,__zero_reg__
	mov r11,__zero_reg__
.L118:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r13,Z
	mov r24,r13
	ldi r25,0
	cp r24,r14
	cpc r25,r15
	brlo .L143
	movw r24,r10
	movw r22,r8
	rcall __floatunsisf
	movw r16,r22
	movw r18,r24
	mov r20,r14
	mov r22,r13
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L111
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L111
	ldi r24,-1
	sub r14,r24
	sbc r15,r24
	rjmp .L118
.L143:
	clr r14
	inc r14
	mov r15,__zero_reg__
	movw r8,r28
	mov r10,__zero_reg__
	mov r11,__zero_reg__
.L120:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r13,Z
	mov r24,r13
	ldi r25,0
	cp r24,r14
	cpc r25,r15
	brlo .L144
	movw r24,r10
	movw r22,r8
	rcall __floatunsisf
	movw r16,r22
	movw r18,r24
	mov r22,r13
	sub r22,r14
	mov r20,r13
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L111
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L111
	ldi r24,-1
	sub r14,r24
	sbc r15,r24
	rjmp .L120
.L144:
	clr r14
	inc r14
	mov r15,__zero_reg__
	movw r8,r28
	mov r10,__zero_reg__
	mov r11,__zero_reg__
.L122:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r13,Z
	mov r24,r13
	ldi r25,0
	cp r24,r14
	cpc r25,r15
	brlo .L145
	movw r24,r10
	movw r22,r8
	rcall __floatunsisf
	movw r16,r22
	movw r18,r24
	mov r20,r13
	ldi r22,0
	mov r24,r14
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L111
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L111
	ldi r24,-1
	sub r14,r24
	sbc r15,r24
	rjmp .L122
.L145:
	clr r14
	inc r14
	mov r15,__zero_reg__
	movw r8,r28
	mov r10,__zero_reg__
	mov r11,__zero_reg__
.L124:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r28,Z
	mov r24,r28
	ldi r25,0
	cp r24,r14
	cpc r25,r15
	brlo .L111
	movw r24,r10
	movw r22,r8
	rcall __floatunsisf
	movw r16,r22
	movw r18,r24
	mov r20,r28
	sub r20,r14
	ldi r22,0
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L111
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L111
	ldi r24,-1
	sub r14,r24
	sbc r15,r24
	rjmp .L124
.L111:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r11
	pop r10
	pop r9
	pop r8
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
	mov r12,r22
	mov r11,r20
	mov r14,__zero_reg__
	ldi r29,0
	mov r15,__zero_reg__
	ldi r28,0
.L147:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r24,Z
	cp r28,r24
	brsh .L154
	ldi r16,0
	ldi r17,0
	ldi r18,lo8(-96)
	ldi r19,lo8(64)
	mov r20,r14
	mov r22,r29
	mov r24,r15
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L148
	add r15,r13
	add r29,r12
	add r14,r11
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L150
	subi r28,lo8(-(1))
	rjmp .L147
.L154:
	ldi r24,0
	rjmp .L148
.L150:
	ldi r24,lo8(1)
.L148:
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
	ldi r28,0
.L156:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r24,Z
	cp r28,r24
	brsh .L186
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
	rjmp .L155
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L155
	subi r28,lo8(-(1))
	rjmp .L156
.L186:
	ldi r28,0
.L161:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r24,Z
	cp r28,r24
	brsh .L187
	ldi r16,0
	ldi r17,0
	ldi r18,0
	ldi r19,lo8(64)
	ldi r20,0
	mov r22,r28
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L155
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L155
	subi r28,lo8(-(1))
	rjmp .L161
.L187:
	ldi r28,0
.L163:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r24,Z
	cp r28,r24
	brsh .L188
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
	rjmp .L155
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L155
	subi r28,lo8(-(1))
	rjmp .L163
.L188:
	ldi r28,0
.L165:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r22,Z
	cp r28,r22
	brsh .L189
	ldi r16,0
	ldi r17,0
	ldi r18,0
	ldi r19,lo8(64)
	mov r20,r28
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L155
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L155
	subi r28,lo8(-(1))
	rjmp .L165
.L189:
	ldi r28,0
.L167:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r20,Z
	cp r28,r20
	brsh .L190
	mov r22,r20
	sub r22,r28
	ldi r16,0
	ldi r17,0
	ldi r18,0
	ldi r19,lo8(64)
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L155
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L155
	subi r28,lo8(-(1))
	rjmp .L167
.L190:
	ldi r28,0
.L169:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r20,Z
	cp r28,r20
	brsh .L191
	sub r20,r28
	ldi r16,0
	ldi r17,0
	ldi r18,0
	ldi r19,lo8(64)
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L155
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L155
	subi r28,lo8(-(1))
	rjmp .L169
.L191:
	ldi r16,0
	ldi r17,0
	ldi r18,lo8(32)
	ldi r19,lo8(65)
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
.L155:
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
	breq .L208
	brsh .L195
	cpi r24,lo8(1)
	breq .L196
	cpi r24,lo8(2)
	brne .L193
	ldi r20,0
	ldi r22,lo8(1)
	rjmp .L234
.L195:
	cpi r24,lo8(4)
	breq .L198
	cpi r24,lo8(5)
	breq .L199
	rjmp .L193
.L196:
	ldi r20,0
	rjmp .L236
.L205:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
.L232:
	rcall make_saw
	cpi r24,lo8(1)
	brne .+2
	rjmp .L192
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L192
.L208:
	ldi r20,lo8(1)
	ldi r22,0
.L234:
	ldi r24,0
.L233:
	rjmp make_saw
.L198:
	ldi r20,lo8(1)
	ldi r22,lo8(1)
.L235:
	ldi r24,lo8(1)
	rjmp .L233
.L199:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	brne .+2
	rjmp .L192
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L192
	ldi r20,0
	ldi r22,lo8(1)
	rjmp .L233
.L193:
	cpi r24,lo8(7)
	breq .L203
	brsh .L204
	cpi r24,lo8(6)
	breq .L205
	ret
.L204:
	cpi r24,lo8(8)
	breq .L206
	cpi r24,lo8(9)
	breq .L207
	ret
.L203:
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,0
	rjmp .L232
.L206:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L192
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L192
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L192
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L192
	ldi r20,0
	ldi r22,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L192
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L192
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L192
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L192
	ldi r20,lo8(1)
	ldi r22,0
	rcall make_saw
	cpi r24,lo8(1)
	breq .L192
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L192
	ldi r20,lo8(1)
.L236:
	ldi r22,0
	rjmp .L235
.L207:
	rjmp make_saw_rainbow
.L192:
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
	breq .L239
	cpi r24,lo8(3)
	breq .L240
	cpi r24,lo8(1)
	brne .L250
	ldi r16,0
	ldi r17,0
	ldi r18,lo8(32)
	ldi r19,lo8(65)
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	rjmp .L257
.L239:
	ldi r16,0
	ldi r17,0
	ldi r18,lo8(32)
	ldi r19,lo8(65)
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	rjmp .L256
.L240:
	ldi r16,0
	ldi r17,0
	ldi r18,lo8(32)
	ldi r19,lo8(65)
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	rjmp .L255
.L250:
	cpi r24,lo8(5)
	breq .L243
	cpi r24,lo8(6)
	breq .L244
	cpi r24,lo8(4)
	brne .L251
	ldi r16,0
	ldi r17,0
	ldi r18,lo8(32)
	ldi r19,lo8(65)
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	rjmp .L259
.L243:
	ldi r16,0
	ldi r17,0
	ldi r18,lo8(32)
	ldi r19,lo8(65)
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(1)
.L259:
	ldi r22,lo8(1)
	rjmp .L258
.L244:
	ldi r16,0
	ldi r17,0
	ldi r18,lo8(32)
	ldi r19,lo8(65)
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(1)
.L257:
	ldi r22,0
.L258:
	ldi r24,0
	rjmp .L253
.L251:
	cpi r24,lo8(8)
	breq .L247
	cpi r24,lo8(9)
	breq .L248
	cpi r24,lo8(7)
	brne .L252
	ldi r16,0
	ldi r17,0
	ldi r18,lo8(32)
	ldi r19,lo8(65)
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(1)
.L256:
	ldi r22,0
	rjmp .L254
.L247:
	ldi r16,0
	ldi r17,0
	ldi r18,lo8(32)
	ldi r19,lo8(65)
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
.L248:
	ldi r20,lo8(1)
.L255:
	ldi r22,lo8(1)
.L254:
	ldi r24,lo8(1)
.L253:
/* epilogue start */
	pop r17
	pop r16
	rjmp make_light
.L252:
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
	breq .L262
	cpi r24,lo8(3)
	breq .L263
	cpi r24,lo8(1)
	brne .L284
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ldi r20,0
	ldi r22,0
	rjmp .L290
.L262:
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
	rjmp .L288
.L263:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r24,Z
	ldi r20,0
	rjmp .L291
.L284:
	cpi r24,lo8(5)
	breq .L266
	cpi r24,lo8(6)
	breq .L267
	cpi r24,lo8(4)
	brne .L285
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ldi r20,0
	ld r22,Z
	rjmp .L292
.L266:
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
	rjmp .L292
.L267:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r20,Z
	rjmp .L293
.L285:
	cpi r24,lo8(8)
	breq .L270
	cpi r24,lo8(9)
	breq .L271
	cpi r24,lo8(7)
	brne .L286
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r24,Z
	mov r20,r24
	rjmp .L289
.L270:
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
.L290:
	ld r24,Z
	rjmp .L288
.L271:
	lds r30,brightness
	ldi r31,0
	subi r30,lo8(-(light_r))
	sbci r31,hi8(-(light_r))
	ld r24,Z
	mov r20,r24
.L291:
	mov r22,r24
	rjmp .L288
.L286:
	cpi r24,lo8(12)
	breq .L274
	brsh .L275
	cpi r24,lo8(10)
	breq .L276
	cpi r24,lo8(11)
	brne .L273
	ldi r20,0
	rjmp .L295
.L275:
	cpi r24,lo8(13)
	breq .L278
	cpi r24,lo8(14)
	breq .L281
	rjmp .L273
.L276:
	ldi r20,0
	ldi r22,lo8(3)
	rjmp .L292
.L274:
	ldi r20,lo8(3)
	rjmp .L296
.L278:
	ldi r20,lo8(3)
.L293:
	ldi r22,0
.L292:
	ldi r24,0
	rjmp .L288
.L273:
	cpi r24,lo8(15)
	breq .L281
	cpi r24,lo8(16)
	brne .L297
	ldi r20,lo8(3)
	rjmp .L295
.L281:
	ldi r20,0
.L296:
	ldi r22,lo8(3)
	rjmp .L294
.L295:
	ldi r22,0
.L294:
	ldi r24,lo8(3)
	rjmp .L288
.L297:
	cpse r24,__zero_reg__
	rjmp .L283
	ldi r20,0
.L289:
	ldi r22,0
.L288:
	rjmp make_light
.L283:
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
	ldi r28,0
	ldi r29,0
.L299:
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
	sbrs r24,7
	rjmp .L305
	mov r24,r17
	rcall make_color
	cpi r24,lo8(1)
	breq .L300
	adiw r28,1
	rjmp .L299
.L305:
	ldi r24,0
.L300:
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
.L308:
	movw r24,r14
	movw r22,r12
	rcall __floatunsisf
	movw r20,r28
	rcall long_color
	cpi r24,lo8(1)
	breq .L306
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L306
	adiw r28,1
	cpi r28,10
	cpc r29,__zero_reg__
	brne .L308
.L306:
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
	breq .L315
	brsh .L316
	cpi r24,lo8(1)
	breq .L317
	cpi r24,lo8(2)
	brne .L314
	ldi r24,lo8(50)
	ldi r25,0
	rjmp .L332
.L316:
	cpi r24,lo8(4)
	breq .L319
	cpi r24,lo8(5)
	brne .L314
	ldi r24,lo8(-36)
	ldi r25,lo8(5)
	rjmp .L332
.L317:
	ldi r24,lo8(10)
	ldi r25,0
	rjmp .L332
.L315:
	ldi r24,lo8(-106)
	ldi r25,0
.L332:
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad
.L319:
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
	rjmp .L332
.L314:
	cpi r24,lo8(7)
	breq .L322
	brsh .L323
	cpi r24,lo8(6)
	brne .L313
	ldi r24,lo8(100)
	ldi r25,0
	rjmp .L333
.L323:
	cpi r24,lo8(8)
	breq .L325
	cpi r24,lo8(9)
	brne .L313
	ldi r28,lo8(1)
	ldi r29,0
	rjmp .L327
.L322:
	ldi r24,lo8(-112)
	ldi r25,lo8(1)
	rjmp .L333
.L325:
	ldi r24,lo8(-80)
	ldi r25,lo8(4)
.L333:
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad_2
.L334:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L313
	adiw r28,1
	cpi r28,9
	cpc r29,__zero_reg__
	breq .L313
.L327:
	movw r20,r28
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(52)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	brne .L334
.L313:
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
	breq .L337
	brsh .L338
	cpi r24,lo8(1)
	breq .L339
	cpi r24,lo8(2)
	breq .L340
	rjmp .L336
.L338:
	cpi r24,lo8(4)
	breq .L341
	cpi r24,lo8(5)
	brne .+2
	rjmp .L342
	rjmp .L336
.L339:
	ldi r20,lo8(1)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(112)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L335
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L335
	ldi r20,lo8(4)
	ldi r21,0
	rjmp .L410
.L340:
	ldi r20,lo8(4)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(112)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L335
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L335
	ldi r20,lo8(6)
	ldi r21,0
.L410:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(112)
	ldi r25,lo8(66)
	rjmp .L408
.L337:
	ldi r20,lo8(6)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(112)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L335
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L335
	ldi r20,lo8(1)
	ldi r21,0
	rjmp .L410
.L341:
	ldi r20,lo8(2)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(112)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L335
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L335
	ldi r20,lo8(5)
	ldi r21,0
	rjmp .L410
.L342:
	ldi r20,lo8(1)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(112)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L335
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L335
	ldi r20,lo8(2)
	ldi r21,0
	rjmp .L410
.L336:
	cpi r24,lo8(7)
	breq .L346
	brsh .L347
	cpi r24,lo8(6)
	breq .L348
	ret
.L347:
	cpi r24,lo8(8)
	brne .+2
	rjmp .L349
	cpi r24,lo8(9)
	brne .+2
	rjmp .L350
	ret
.L348:
	ldi r20,0
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(52)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L335
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L335
	ldi r20,lo8(1)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(52)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L335
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L335
	ldi r20,lo8(4)
	ldi r21,0
	rjmp .L404
.L346:
	ldi r20,0
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(52)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L335
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L335
	ldi r20,lo8(1)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(52)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L335
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L335
	ldi r20,lo8(6)
	ldi r21,0
.L404:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(52)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L335
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L335
	ldi r20,lo8(1)
	ldi r21,0
	rjmp .L409
.L349:
	ldi r20,0
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(52)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	breq .L335
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L335
	ldi r20,lo8(9)
	ldi r21,0
	rjmp .L407
.L350:
	ldi r20,0
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(52)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	breq .L335
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L335
	ldi r20,lo8(4)
	ldi r21,0
.L407:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(52)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	breq .L335
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L335
	ldi r20,lo8(6)
	ldi r21,0
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(52)
	ldi r25,lo8(66)
	rcall long_color
	cpi r24,lo8(1)
	breq .L335
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L335
	ldi r20,lo8(4)
	ldi r21,0
.L409:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(52)
	ldi r25,lo8(66)
.L408:
	rjmp long_color
.L335:
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
	movw r28,r22
	mov r16,r20
	ldi r17,0
	movw r22,r24
	ldi r24,0
	ldi r25,0
	rcall __floatunsisf
	movw r20,r16
	rcall long_color
	cpi r24,lo8(1)
	brne .L412
.L414:
	ldi r24,lo8(1)
	rjmp .L413
.L412:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L414
	movw r22,r28
	ldi r24,0
	ldi r25,0
	rcall __floatunsisf
	ldi r20,0
	ldi r21,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L414
	ldi r24,lo8(1)
	lds r25,stat
	cpse r25,__zero_reg__
	rjmp .L413
	ldi r24,0
.L413:
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
	breq .L421
	brsh .L422
	cpi r24,lo8(1)
	breq .L423
	cpi r24,lo8(2)
	brne .+2
	rjmp .L481
	rjmp .L420
.L422:
	cpi r24,lo8(4)
	breq .L425
	cpi r24,lo8(5)
	breq .L426
	rjmp .L420
.L423:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L419
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L419
	ldi r20,lo8(4)
	rjmp .L484
.L421:
	ldi r20,lo8(6)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L419
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L419
	ldi r20,lo8(1)
	rjmp .L484
.L425:
	ldi r20,lo8(2)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L419
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L419
	ldi r20,lo8(5)
	rjmp .L484
.L426:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L419
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L419
.L481:
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L419
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L419
	ldi r20,lo8(6)
	rjmp .L484
.L420:
	cpi r24,lo8(7)
	breq .L431
	brsh .L432
	cpi r24,lo8(6)
	breq .L433
	ret
.L432:
	cpi r24,lo8(8)
	brne .+2
	rjmp .L483
	cpi r24,lo8(9)
	breq .L435
	ret
.L433:
	ldi r20,lo8(1)
	rjmp .L482
.L431:
	ldi r20,lo8(4)
.L482:
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L419
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L419
	ldi r20,lo8(9)
.L484:
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L435:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L419
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L419
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L419
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L419
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L419
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L419
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L419
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L419
.L483:
	ldi r20,lo8(6)
	rjmp .L482
.L419:
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
	breq .L487
	brsh .L488
	cpi r25,lo8(1)
	breq .L489
	cpi r25,lo8(2)
	brne .L486
	mov r20,r22
	ldi r22,lo8(20)
	ldi r23,0
	ldi r24,lo8(20)
	ldi r25,0
	rjmp .L501
.L488:
	cpi r25,lo8(4)
	breq .L491
	cpi r25,lo8(5)
	brne .L486
	mov r20,r22
	ldi r22,lo8(-12)
	ldi r23,lo8(1)
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
	rjmp .L501
.L489:
	rjmp make_color
.L487:
	mov r20,r22
	ldi r22,lo8(50)
	ldi r23,0
	ldi r24,lo8(50)
	ldi r25,0
.L501:
	rjmp make_strob
.L491:
	mov r20,r22
	ldi r22,lo8(100)
	ldi r23,0
	ldi r24,lo8(100)
	ldi r25,0
	rjmp .L501
.L486:
	cpi r25,lo8(8)
	breq .L494
	brsh .L495
	cpi r25,lo8(6)
	breq .L496
	cpi r25,lo8(7)
	breq .L497
	ret
.L495:
	cpi r25,lo8(10)
	breq .L498
	brlo .L499
	cpi r25,lo8(11)
	breq .L500
	ret
.L496:
	rjmp make_pulse
.L497:
	rjmp grad_serie
.L494:
	rjmp make_complex_strob
.L499:
	rjmp make_mix
.L498:
	rjmp make_mix_2
.L500:
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
 ;  234 "csb-light-grb-3.4d.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	sts stat,__zero_reg__
	ldi r28,lo8(32)
.L503:
	lds r24,power
	cpi r24,lo8(2)
	brne .L504
	rcall init_io
	out 0x3b,__zero_reg__
	out 0x15,__zero_reg__
/* #APP */
 ;  242 "csb-light-grb-3.4d.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	ldi r24,lo8(10)
	sts power,r24
.L506:
	in r24,0x16
	sbrs r24,4
	rjmp .L506
	ldi r18,lo8(79999)
	ldi r24,hi8(79999)
	ldi r25,hlo8(79999)
1:	subi r18,1
	sbci r24,0
	sbci r25,0
	brne 1b
	rjmp .
	nop
	rjmp .L503
.L504:
	cpi r24,lo8(3)
	brne .L508
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
 ;  267 "csb-light-grb-3.4d.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
	sts power,__zero_reg__
/* #APP */
 ;  269 "csb-light-grb-3.4d.c" 1
	sleep
	
 ;  0 "" 2
/* #NOAPP */
	in r24,0x35
	andi r24,lo8(-33)
	out 0x35,r24
	rjmp .L503
.L508:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L509
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L510
	lds r22,mode
	lds r24,serie
	rjmp .L522
.L510:
	lds r24,counter
	tst r24
	breq .L511
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
.L522:
	rcall make_serie
	rjmp .L503
.L509:
	cpi r24,lo8(10)
	breq .L521
	cpi r24,lo8(11)
	breq .L521
	cpi r24,lo8(12)
	breq .L521
	cpi r24,lo8(13)
	breq .L521
	cpi r24,lo8(14)
	breq .L521
	cpi r24,lo8(15)
	breq .L521
	cpi r24,lo8(16)
	breq .L521
.L511:
	ldi r24,0
.L521:
	rcall make_color
	rjmp .L503
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
