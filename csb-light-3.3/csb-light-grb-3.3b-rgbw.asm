	.file	"csb-light-grb-3.3b-rgbw.c"
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
	ldi r24,lo8(15)
	out 0x17,r24
	ldi r24,lo8(31)
	out 0x18,r24
	ret
	.size	init_io, .-init_io
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
	brlo .L18
	ldi r24,lo8(12)
	sts stat,r24
	or r22,r23
	breq .L19
.L22:
	ldi r24,0
	ret
.L19:
	sts pointer,__zero_reg__
	sts counter,__zero_reg__
	rjmp .L23
.L18:
	cpi r24,17
	ldi r18,39
	cpc r25,r18
	brlo .L21
	ldi r24,lo8(11)
	sts stat,r24
	or r22,r23
	brne .L22
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L23
	ldi r24,lo8(1)
	sts fav_on,r24
	sts pointer,r24
	rjmp .L38
.L23:
	sts fav_on,__zero_reg__
	rjmp .L38
.L21:
	cpi r24,89
	ldi r18,27
	cpc r25,r18
	brlo .L25
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L22
	lds r24,counter
	cpi r24,lo8(15)
	brsh .L22
	ldi r25,lo8(10)
	sts stat,r25
	or r22,r23
	brne .L22
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
.L38:
	rcall check_all
	rjmp .L37
.L25:
	cpi r24,-71
	ldi r18,11
	cpc r25,r18
	brlo .L26
	ldi r24,lo8(14)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L22
	ldi r24,lo8(3)
	sts power,r24
	rjmp .L37
.L26:
	cpi r24,-23
	ldi r18,3
	cpc r25,r18
	brlo .L27
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L22
	ldi r24,lo8(13)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L22
	lds r24,serie
	subi r24,lo8(-(1))
	cpi r24,lo8(12)
	brlo .L34
	ldi r24,lo8(1)
.L34:
	sts serie,r24
	ldi r24,lo8(1)
	sts mode,r24
.L37:
	rcall store_data
	sts stat,__zero_reg__
	rjmp .L36
.L27:
	sbiw r24,51
	brsh .+2
	rjmp .L22
	or r22,r23
	breq .+2
	rjmp .L22
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L30
	lds r24,mode
	subi r24,lo8(-(1))
	cpi r24,lo8(10)
	brlo .L35
	ldi r24,lo8(1)
.L35:
	sts mode,r24
	rjmp .L32
.L30:
	lds r24,pointer
	subi r24,lo8(-(1))
	sts pointer,r24
	lds r25,counter
	cp r25,r24
	brsh .L32
	ldi r24,lo8(1)
	sts pointer,r24
.L32:
	rcall check_all
	rcall store_data
.L36:
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
	rjmp .L40
	sts button_state.1917,__zero_reg__
	rjmp .L41
.L40:
	ldi r24,lo8(1)
	sts button_state.1917,r24
.L41:
	lds r22,button_state.1917
	cpi r22,lo8(1)
	brne .L42
	lds r24,hold.1916
	lds r25,hold.1916+1
	adiw r24,1
	sts hold.1916+1,r25
	sts hold.1916,r24
.L42:
	lds r24,last_button_state.1918
	cpse r22,r24
	rjmp .L45
	ldi r23,0
	lds r24,hold.1916
	lds r25,hold.1916+1
	rcall process_button
	rjmp .L43
.L45:
	ldi r24,0
.L43:
	lds r25,button_state.1917
	cpse r25,__zero_reg__
	rjmp .L44
	lds r18,last_button_state.1918
	cpse r18,__zero_reg__
	rjmp .L44
	sts hold.1916+1,__zero_reg__
	sts hold.1916,__zero_reg__
.L44:
	sts last_button_state.1918,r25
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
.L50:
	cp r25,r24
	brsh .L51
	ldi r18,lo8(26)
	rjmp .L47
.L51:
	ldi r18,lo8(24)
.L47:
	cp r25,r22
	brsh .L48
	ori r18,lo8(1)
.L48:
	cp r25,r20
	brsh .L49
	ori r18,lo8(4)
.L49:
	out 0x18,r18
	subi r25,lo8(-(1))
	cpi r25,lo8(20)
	brne .L50
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
.L54:
	cp r28,r16
	cpc r29,r17
	breq .L60
	mov r20,r13
	mov r22,r14
	mov r24,r15
	rcall make_light
	cpi r24,lo8(1)
	breq .L55
	adiw r28,1
	rjmp .L54
.L60:
	ldi r24,0
.L55:
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
	brne .L62
.L64:
	ldi r24,lo8(1)
	rjmp .L63
.L62:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L64
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L65
	ldi r28,lo8(20)
.L66:
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
	breq .L64
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L64
	subi r28,lo8(-(-1))
	brne .L66
.L63:
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
	breq .L74
	cpi r24,lo8(3)
	breq .L75
	cpi r24,lo8(1)
	brne .L86
	ldi r30,lo8(-56)
	mov r12,r30
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,0
	rjmp .L90
.L74:
	ldi r23,lo8(-56)
	mov r12,r23
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,0
	rjmp .L92
.L75:
	ldi r22,lo8(-56)
	mov r12,r22
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,0
	rjmp .L94
.L86:
	cpi r24,lo8(5)
	breq .L79
	cpi r24,lo8(6)
	breq .L80
	cpi r24,lo8(4)
	brne .L87
	ldi r21,lo8(-56)
	mov r12,r21
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
.L94:
	ldi r22,lo8(-1)
	rjmp .L93
.L79:
	ldi r20,lo8(-56)
	mov r12,r20
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
	ldi r22,0
.L93:
	ldi r24,0
	rjmp .L91
.L80:
	ldi r19,lo8(-56)
	mov r12,r19
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
	rjmp .L90
.L87:
	cpi r24,lo8(8)
	breq .L82
	cpi r24,lo8(9)
	breq .L83
	cpi r24,lo8(7)
	brne .L88
	ldi r18,lo8(-56)
	mov r12,r18
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
.L92:
	ldi r22,lo8(-1)
	rjmp .L89
.L82:
	ldi r25,lo8(-56)
	mov r12,r25
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,lo8(-1)
	ldi r20,0
	ldi r22,lo8(7)
	rjmp .L89
.L83:
	ldi r24,lo8(-56)
	mov r12,r24
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,lo8(25)
	ldi r20,lo8(7)
.L90:
	ldi r22,0
.L89:
	ldi r24,lo8(-1)
.L91:
	rcall basic_pulse
	rjmp .L77
.L88:
	ldi r24,0
.L77:
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
.L98:
	movw r18,r28
	ldi r20,0
	mov r22,r17
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L95
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L95
	subi r17,lo8(-(1))
	cpi r17,lo8(21)
	brne .L98
	ldi r17,lo8(19)
.L99:
	movw r18,r28
	ldi r20,0
	ldi r22,lo8(20)
	mov r24,r17
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L95
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L95
	subi r17,1
	brcc .L99
	ldi r17,lo8(1)
.L100:
	movw r18,r28
	mov r20,r17
	ldi r22,lo8(20)
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L95
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L95
	subi r17,lo8(-(1))
	cpi r17,lo8(21)
	brne .L100
	ldi r17,lo8(19)
.L101:
	movw r18,r28
	ldi r20,lo8(20)
	mov r22,r17
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L95
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L95
	subi r17,1
	brcc .L101
	ldi r17,lo8(1)
.L102:
	movw r18,r28
	ldi r20,lo8(20)
	ldi r22,0
	mov r24,r17
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L95
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L95
	subi r17,lo8(-(1))
	cpi r17,lo8(21)
	brne .L102
	ldi r17,lo8(19)
.L103:
	movw r18,r28
	mov r20,r17
	ldi r22,0
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L95
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L95
	subi r17,1
	brcc .L103
.L95:
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
.L127:
	ldi r18,lo8(5)
	ldi r19,0
	mov r20,r29
	mov r22,r17
	mov r24,r16
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L126
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L128
	subi r28,lo8(-(-1))
	add r16,r13
	add r17,r14
	add r29,r15
	cpse r28,__zero_reg__
	rjmp .L127
	rjmp .L126
.L128:
	ldi r24,lo8(1)
.L126:
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
.L137:
	ldi r18,lo8(2)
	ldi r19,0
	mov r20,r28
	mov r22,r28
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L133
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L133
	subi r28,lo8(-(-1))
	brne .L137
.L138:
	ldi r18,lo8(2)
	ldi r19,0
	ldi r20,0
	mov r22,r28
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L133
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L133
	subi r28,lo8(-(1))
	cpi r28,lo8(20)
	brne .L138
.L139:
	ldi r18,lo8(2)
	ldi r19,0
	ldi r20,0
	ldi r22,lo8(20)
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L133
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L133
	subi r28,lo8(-(-1))
	brne .L139
.L140:
	ldi r18,lo8(2)
	ldi r19,0
	mov r20,r28
	ldi r22,lo8(20)
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L133
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L133
	subi r28,lo8(-(1))
	cpi r28,lo8(20)
	brne .L140
.L141:
	ldi r18,lo8(2)
	ldi r19,0
	ldi r20,lo8(20)
	mov r22,r28
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L133
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L133
	subi r28,lo8(-(-1))
	brne .L141
	ldi r28,lo8(20)
.L142:
	ldi r18,lo8(2)
	ldi r19,0
	mov r20,r28
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L133
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L133
	subi r28,lo8(-(-1))
	brne .L142
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
/* epilogue start */
	pop r28
	rjmp l_make_light
.L133:
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
	breq .L180
	brsh .L167
	cpi r24,lo8(1)
	breq .L168
	cpi r24,lo8(2)
	brne .L165
	ldi r20,0
	ldi r22,lo8(1)
	rjmp .L206
.L167:
	cpi r24,lo8(4)
	breq .L170
	cpi r24,lo8(5)
	breq .L171
	rjmp .L165
.L168:
	ldi r20,0
	rjmp .L208
.L177:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
.L204:
	rcall make_saw
	cpi r24,lo8(1)
	brne .+2
	rjmp .L164
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L164
.L180:
	ldi r20,lo8(1)
	ldi r22,0
.L206:
	ldi r24,0
.L205:
	rjmp make_saw
.L170:
	ldi r20,lo8(1)
	ldi r22,lo8(1)
.L207:
	ldi r24,lo8(1)
	rjmp .L205
.L171:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	brne .+2
	rjmp .L164
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L164
	ldi r20,0
	ldi r22,lo8(1)
	rjmp .L205
.L165:
	cpi r24,lo8(7)
	breq .L175
	brsh .L176
	cpi r24,lo8(6)
	breq .L177
	ret
.L176:
	cpi r24,lo8(8)
	breq .L178
	cpi r24,lo8(9)
	breq .L179
	ret
.L175:
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,0
	rjmp .L204
.L178:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L164
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L164
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L164
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L164
	ldi r20,0
	ldi r22,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L164
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L164
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L164
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L164
	ldi r20,lo8(1)
	ldi r22,0
	rcall make_saw
	cpi r24,lo8(1)
	breq .L164
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L164
	ldi r20,lo8(1)
.L208:
	ldi r22,0
	rjmp .L207
.L179:
	rjmp make_saw_rainbow
.L164:
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
	breq .L211
	cpi r24,lo8(3)
	breq .L212
	cpi r24,lo8(1)
	brne .L222
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	rjmp .L229
.L211:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	rjmp .L228
.L212:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	rjmp .L227
.L222:
	cpi r24,lo8(5)
	breq .L215
	cpi r24,lo8(6)
	breq .L216
	cpi r24,lo8(4)
	brne .L223
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	rjmp .L231
.L215:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(1)
.L231:
	ldi r22,lo8(1)
	rjmp .L230
.L216:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(1)
.L229:
	ldi r22,0
.L230:
	ldi r24,0
	rjmp .L225
.L223:
	cpi r24,lo8(8)
	breq .L219
	cpi r24,lo8(9)
	breq .L220
	cpi r24,lo8(7)
	brne .L224
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(1)
.L228:
	ldi r22,0
	rjmp .L226
.L219:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
.L220:
	ldi r20,lo8(1)
.L227:
	ldi r22,lo8(1)
.L226:
	ldi r24,lo8(1)
.L225:
	rjmp make_light
.L224:
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
	breq .L234
	cpi r24,lo8(3)
	breq .L235
	cpi r24,lo8(1)
	brne .L255
	ldi r20,0
	rjmp .L267
.L234:
	ldi r20,0
.L263:
	ldi r22,lo8(5)
.L260:
	ldi r24,lo8(20)
	rjmp .L259
.L235:
	ldi r20,0
	rjmp .L268
.L255:
	cpi r24,lo8(5)
	breq .L238
	cpi r24,lo8(6)
	breq .L239
	cpi r24,lo8(4)
	brne .L256
	ldi r20,0
	ldi r22,lo8(20)
	rjmp .L261
.L238:
	ldi r20,lo8(20)
	ldi r22,lo8(5)
	rjmp .L261
.L239:
	ldi r20,lo8(20)
	rjmp .L262
.L256:
	cpi r24,lo8(8)
	breq .L242
	cpi r24,lo8(9)
	breq .L243
	cpi r24,lo8(7)
	brne .L257
	ldi r20,lo8(20)
.L267:
	ldi r22,0
	rjmp .L260
.L242:
	ldi r20,lo8(5)
	rjmp .L263
.L243:
	ldi r20,lo8(20)
.L268:
	ldi r22,lo8(20)
	rjmp .L260
.L257:
	cpi r24,lo8(12)
	breq .L246
	brsh .L247
	cpi r24,lo8(10)
	breq .L248
	cpi r24,lo8(11)
	brne .L245
	ldi r20,0
	ldi r22,0
	rjmp .L264
.L247:
	cpi r24,lo8(13)
	breq .L250
	cpi r24,lo8(14)
	breq .L266
	rjmp .L245
.L248:
	ldi r20,0
	ldi r22,lo8(3)
	rjmp .L261
.L246:
	ldi r20,lo8(3)
	rjmp .L265
.L250:
	ldi r20,lo8(3)
.L262:
	ldi r22,0
.L261:
	ldi r24,0
	rjmp .L259
.L245:
	cpi r24,lo8(15)
	brne .L258
.L266:
	ldi r20,0
.L265:
	ldi r22,lo8(3)
.L264:
	ldi r24,lo8(3)
	rjmp .L259
.L258:
	cpse r24,__zero_reg__
	rjmp .L254
	ldi r20,0
	ldi r22,0
.L259:
	rjmp make_light
.L254:
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
.L270:
	cp r28,r16
	cpc r29,r17
	breq .L276
	mov r24,r15
	rcall make_color
	cpi r24,lo8(1)
	breq .L271
	adiw r28,1
	rjmp .L270
.L276:
	ldi r24,0
.L271:
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
.L279:
	movw r22,r28
	movw r24,r16
	rcall long_color
	cpi r24,lo8(1)
	breq .L277
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L277
	adiw r28,1
	cpi r28,10
	cpc r29,__zero_reg__
	brne .L279
.L277:
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
	breq .L286
	brsh .L287
	cpi r24,lo8(1)
	breq .L288
	cpi r24,lo8(2)
	brne .L285
	ldi r24,lo8(50)
	ldi r25,0
	rjmp .L303
.L287:
	cpi r24,lo8(4)
	breq .L290
	cpi r24,lo8(5)
	brne .L285
	ldi r24,lo8(-36)
	ldi r25,lo8(5)
	rjmp .L303
.L288:
	ldi r24,lo8(10)
	ldi r25,0
	rjmp .L303
.L286:
	ldi r24,lo8(-106)
	ldi r25,0
.L303:
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad
.L290:
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
	rjmp .L303
.L285:
	cpi r24,lo8(7)
	breq .L293
	brsh .L294
	cpi r24,lo8(6)
	brne .L284
	ldi r24,lo8(100)
	ldi r25,0
	rjmp .L304
.L294:
	cpi r24,lo8(8)
	breq .L296
	cpi r24,lo8(9)
	brne .L284
	ldi r28,lo8(1)
	ldi r29,0
	rjmp .L298
.L293:
	ldi r24,lo8(-112)
	ldi r25,lo8(1)
	rjmp .L304
.L296:
	ldi r24,lo8(-80)
	ldi r25,lo8(4)
.L304:
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad_2
.L305:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L284
	adiw r28,1
	cpi r28,9
	cpc r29,__zero_reg__
	breq .L284
.L298:
	movw r22,r28
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .L305
.L284:
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
	breq .L308
	brsh .L309
	cpi r24,lo8(1)
	breq .L310
	cpi r24,lo8(2)
	breq .L311
	rjmp .L307
.L309:
	cpi r24,lo8(4)
	breq .L312
	cpi r24,lo8(5)
	brne .+2
	rjmp .L313
	rjmp .L307
.L310:
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L306
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L306
	ldi r22,lo8(4)
	ldi r23,0
	rjmp .L381
.L311:
	ldi r22,lo8(4)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L306
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L306
	ldi r22,lo8(6)
	ldi r23,0
.L381:
	ldi r24,lo8(60)
	ldi r25,0
	rjmp .L379
.L308:
	ldi r22,lo8(6)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L306
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L306
	ldi r22,lo8(1)
	ldi r23,0
	rjmp .L381
.L312:
	ldi r22,lo8(2)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L306
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L306
	ldi r22,lo8(5)
	ldi r23,0
	rjmp .L381
.L313:
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L306
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L306
	ldi r22,lo8(2)
	ldi r23,0
	rjmp .L381
.L307:
	cpi r24,lo8(7)
	breq .L317
	brsh .L318
	cpi r24,lo8(6)
	breq .L319
	ret
.L318:
	cpi r24,lo8(8)
	brne .+2
	rjmp .L320
	cpi r24,lo8(9)
	brne .+2
	rjmp .L321
	ret
.L319:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L306
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L306
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L306
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L306
	ldi r22,lo8(4)
	ldi r23,0
	rjmp .L375
.L317:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L306
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L306
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L306
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L306
	ldi r22,lo8(6)
	ldi r23,0
.L375:
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L306
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L306
	ldi r22,lo8(1)
	ldi r23,0
	rjmp .L380
.L320:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L306
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L306
	ldi r22,lo8(9)
	ldi r23,0
	rjmp .L378
.L321:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L306
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L306
	ldi r22,lo8(4)
	ldi r23,0
.L378:
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L306
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L306
	ldi r22,lo8(6)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L306
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L306
	ldi r22,lo8(4)
	ldi r23,0
.L380:
	ldi r24,lo8(45)
	ldi r25,0
.L379:
	rjmp long_color
.L306:
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
	brne .L383
.L385:
	ldi r24,lo8(1)
	rjmp .L384
.L383:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L385
	ldi r22,0
	ldi r23,0
	movw r24,r28
	rcall long_color
	cpi r24,lo8(1)
	breq .L385
	ldi r24,lo8(1)
	lds r25,stat
	cpse r25,__zero_reg__
	rjmp .L384
	ldi r24,0
.L384:
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
	breq .L392
	brsh .L393
	cpi r24,lo8(1)
	breq .L394
	cpi r24,lo8(2)
	brne .+2
	rjmp .L452
	rjmp .L391
.L393:
	cpi r24,lo8(4)
	breq .L396
	cpi r24,lo8(5)
	breq .L397
	rjmp .L391
.L394:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L390
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L390
	ldi r20,lo8(4)
	rjmp .L455
.L392:
	ldi r20,lo8(6)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L390
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L390
	ldi r20,lo8(1)
	rjmp .L455
.L396:
	ldi r20,lo8(2)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L390
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L390
	ldi r20,lo8(5)
	rjmp .L455
.L397:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L390
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L390
.L452:
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L390
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L390
	ldi r20,lo8(6)
	rjmp .L455
.L391:
	cpi r24,lo8(7)
	breq .L402
	brsh .L403
	cpi r24,lo8(6)
	breq .L404
	ret
.L403:
	cpi r24,lo8(8)
	brne .+2
	rjmp .L454
	cpi r24,lo8(9)
	breq .L406
	ret
.L404:
	ldi r20,lo8(1)
	rjmp .L453
.L402:
	ldi r20,lo8(4)
.L453:
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L390
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L390
	ldi r20,lo8(9)
.L455:
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L406:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L390
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L390
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L390
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L390
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L390
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L390
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L390
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L390
.L454:
	ldi r20,lo8(6)
	rjmp .L453
.L390:
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
	breq .L458
	brsh .L459
	cpi r25,lo8(1)
	breq .L460
	cpi r25,lo8(2)
	brne .L457
	mov r20,r22
	ldi r22,lo8(20)
	ldi r23,0
	ldi r24,lo8(20)
	ldi r25,0
	rjmp .L472
.L459:
	cpi r25,lo8(4)
	breq .L462
	cpi r25,lo8(5)
	brne .L457
	mov r20,r22
	ldi r22,lo8(-12)
	ldi r23,lo8(1)
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
	rjmp .L472
.L460:
	rjmp make_color
.L458:
	mov r20,r22
	ldi r22,lo8(50)
	ldi r23,0
	ldi r24,lo8(50)
	ldi r25,0
.L472:
	rjmp make_strob
.L462:
	mov r20,r22
	ldi r22,lo8(100)
	ldi r23,0
	ldi r24,lo8(100)
	ldi r25,0
	rjmp .L472
.L457:
	cpi r25,lo8(8)
	breq .L465
	brsh .L466
	cpi r25,lo8(6)
	breq .L467
	cpi r25,lo8(7)
	breq .L468
	ret
.L466:
	cpi r25,lo8(10)
	breq .L469
	brlo .L470
	cpi r25,lo8(11)
	breq .L471
	ret
.L467:
	rjmp make_pulse
.L468:
	rjmp grad_serie
.L465:
	rjmp make_complex_strob
.L470:
	rjmp make_mix
.L469:
	rjmp make_mix_2
.L471:
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
 ;  188 "csb-light-grb-3.3b-rgbw.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	sts stat,__zero_reg__
	ldi r28,lo8(16)
	ldi r29,lo8(32)
	ldi r17,lo8(3)
.L474:
	lds r24,power
	cpi r24,lo8(2)
	brne .L475
	rcall init_io
	out 0x3b,__zero_reg__
	out 0x15,__zero_reg__
/* #APP */
 ;  196 "csb-light-grb-3.3b-rgbw.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	ldi r24,lo8(10)
	sts power,r24
	in r24,0x16
	ldi r25,lo8(10)
.L478:
	in r24,0x16
	ldi r30,lo8(4999)
	ldi r31,hi8(4999)
1:	sbiw r30,1
	brne 1b
	rjmp .
	nop
	sbrs r24,4
	rjmp .L476
	sts power,r17
	rjmp .L477
.L476:
	subi r25,lo8(-(-1))
	brne .L478
.L479:
	sbrc r24,4
	rjmp .L477
	in r24,0x16
	rjmp .L479
.L477:
	ldi r24,lo8(-28037)
	ldi r25,hi8(-28037)
1:	sbiw r24,1
	brne 1b
	rjmp .
	nop
	rjmp .L474
.L475:
	cpi r24,lo8(3)
	brne .L482
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
 ;  218 "csb-light-grb-3.3b-rgbw.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
	sts power,__zero_reg__
/* #APP */
 ;  220 "csb-light-grb-3.3b-rgbw.c" 1
	sleep
	
 ;  0 "" 2
/* #NOAPP */
	in r24,0x35
	andi r24,lo8(-33)
	out 0x35,r24
	rjmp .L474
.L482:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L483
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L484
	lds r22,mode
	lds r24,serie
	rjmp .L496
.L484:
	lds r24,counter
	tst r24
	breq .L485
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
.L496:
	rcall make_serie
	rjmp .L474
.L483:
	cpi r24,lo8(10)
	breq .L495
	cpi r24,lo8(11)
	breq .L495
	cpi r24,lo8(12)
	breq .L495
	cpi r24,lo8(13)
	breq .L495
	cpi r24,lo8(14)
	breq .L495
	cpi r24,lo8(15)
	breq .L495
.L485:
	ldi r24,0
.L495:
	rcall make_color
	rjmp .L474
	.size	main, .-main
	.local	last_button_state.1918
	.comm	last_button_state.1918,1,1
	.local	hold.1916
	.comm	hold.1916,2,1
	.local	button_state.1917
	.comm	button_state.1917,1,1
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
