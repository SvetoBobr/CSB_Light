	.file	"csb-light-grb-3-1_c.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	check_all
	.type	check_all, @function
check_all:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	lds r24,mode
	cpi r24,lo8(10)
	brlo .L2
	ldi r24,lo8(1)
	sts mode,r24
.L2:
	lds r24,serie
	cpi r24,lo8(8)
	brlo .L3
	ldi r24,lo8(1)
	sts serie,r24
	rjmp .L3
.L7:
	ld r24,Z
	cpi r24,lo8(10)
	brlo .L4
	st Z,r25
.L4:
	ld r24,X
	cpi r24,lo8(8)
	brlo .L5
	st X,r25
.L5:
	ld r24,Y
	cpse r24,__zero_reg__
	rjmp .L6
	st Y,r25
.L6:
	adiw r30,1
	adiw r28,1
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
	brlo .L1
	sts fav_on,__zero_reg__
	rjmp .L1
.L3:
	ldi r30,lo8(modes)
	ldi r31,hi8(modes)
	ldi r28,lo8(speed)
	ldi r29,hi8(speed)
	ldi r26,lo8(series)
	ldi r27,hi8(series)
	ldi r18,lo8(modes+15)
	ldi r19,hi8(modes+15)
	ldi r25,lo8(1)
	rjmp .L7
.L1:
/* epilogue start */
	pop r29
	pop r28
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
	ldi r20,lo8(16)
	ldi r21,0
	ldi r22,lo8(fm)
	ldi r23,hi8(fm)
	ldi r24,lo8(modes)
	ldi r25,hi8(modes)
	rcall eeprom_read_block
	ldi r20,lo8(16)
	ldi r21,0
	ldi r22,lo8(sm)
	ldi r23,hi8(sm)
	ldi r24,lo8(series)
	ldi r25,hi8(series)
	rcall eeprom_read_block
	ldi r20,lo8(16)
	ldi r21,0
	ldi r22,lo8(speedm)
	ldi r23,hi8(speedm)
	ldi r24,lo8(speed)
	ldi r25,hi8(speed)
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
	ret
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
	ldi r20,lo8(16)
	ldi r21,0
	ldi r22,lo8(fm)
	ldi r23,hi8(fm)
	ldi r24,lo8(modes)
	ldi r25,hi8(modes)
	rcall eeprom_write_block
	ldi r20,lo8(16)
	ldi r21,0
	ldi r22,lo8(sm)
	ldi r23,hi8(sm)
	ldi r24,lo8(series)
	ldi r25,hi8(series)
	rcall eeprom_write_block
	ldi r20,lo8(16)
	ldi r21,0
	ldi r22,lo8(speedm)
	ldi r23,hi8(speedm)
	ldi r24,lo8(speed)
	ldi r25,hi8(speed)
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
	rjmp eeprom_write_byte
	.size	store_data, .-store_data
.global	process_button
	.type	process_button, @function
process_button:
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	cpi r20,lo8(1)
	breq .+2
	rjmp .L16
	cpi r24,81
	ldi r18,70
	cpc r25,r18
	brlo .L17
	ldi r24,lo8(12)
	sts stat,r24
	cpse r22,__zero_reg__
	rjmp .L31
	sts pointer,__zero_reg__
	sts counter,__zero_reg__
	sts fav_on,__zero_reg__
	rcall check_all
	rcall store_data
	sts stat,__zero_reg__
	ldi r28,lo8(1)
	rjmp .L18
.L17:
	cpi r24,17
	ldi r18,39
	cpc r25,r18
	brlo .L19
	ldi r24,lo8(11)
	sts stat,r24
	cpse r22,__zero_reg__
	rjmp .L32
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L20
	ldi r24,lo8(1)
	sts fav_on,r24
	sts pointer,r24
	rjmp .L21
.L20:
	sts fav_on,__zero_reg__
.L21:
	rcall check_all
	rcall store_data
	sts stat,__zero_reg__
	ldi r28,lo8(1)
	rjmp .L18
.L19:
	cpi r24,-71
	ldi r18,11
	cpc r25,r18
	brlo .L22
	lds r28,fav_on
	cpse r28,__zero_reg__
	rjmp .L33
	lds r24,counter
	cpi r24,lo8(15)
	brlo .+2
	rjmp .L18
	ldi r25,lo8(10)
	sts stat,r25
	cpse r22,__zero_reg__
	rjmp .L18
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
	movw r30,r24
	subi r30,lo8(-(speed))
	sbci r31,hi8(-(speed))
	ldi r18,lo8(31)
	st Z,r18
	rcall check_all
	rcall store_data
	sts stat,__zero_reg__
	ldi r28,lo8(1)
	rjmp .L18
.L22:
	cpi r24,-67
	ldi r18,2
	cpc r25,r18
	brlo .L23
	lds r28,fav_on
	cpse r28,__zero_reg__
	rjmp .L34
	ldi r24,lo8(13)
	sts stat,r24
	cpse r22,__zero_reg__
	rjmp .L18
	lds r24,serie
	subi r24,lo8(-(1))
	cpi r24,lo8(8)
	brsh .L24
	sts serie,r24
	rjmp .L25
.L24:
	ldi r24,lo8(1)
	sts serie,r24
.L25:
	ldi r24,lo8(1)
	sts mode,r24
	rcall store_data
	sts stat,__zero_reg__
	ldi r28,lo8(1)
	rjmp .L18
.L23:
	sbiw r24,15
	brsh .+2
	rjmp .L35
	cpse r22,__zero_reg__
	rjmp .L36
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L26
	lds r24,mode
	subi r24,lo8(-(1))
	cpi r24,lo8(10)
	brsh .L27
	sts mode,r24
	rjmp .L28
.L27:
	ldi r24,lo8(1)
	sts mode,r24
	rjmp .L28
.L26:
	lds r24,pointer
	subi r24,lo8(-(1))
	sts pointer,r24
	lds r25,counter
	cp r25,r24
	brsh .L28
	ldi r24,lo8(1)
	sts pointer,r24
.L28:
	rcall check_all
	rcall store_data
	ldi r28,lo8(1)
	rjmp .L18
.L16:
	cpi r20,lo8(2)
	breq .+2
	rjmp .L37
	lds r28,fav_on
	cpi r28,lo8(1)
	breq .+2
	rjmp .L38
	cpi r24,-71
	ldi r18,11
	cpc r25,r18
	brlo .L29
	ldi r24,lo8(10)
	sts stat,r24
	cpse r22,__zero_reg__
	rjmp .L39
	lds r30,pointer
	ldi r31,0
	subi r30,lo8(-(speed))
	sbci r31,hi8(-(speed))
	ldi r24,lo8(31)
	st Z,r24
	rcall check_all
	rcall store_data
	sts stat,__zero_reg__
	rjmp .L18
.L29:
	cpi r24,-67
	ldi r18,2
	cpc r25,r18
	brlo .L30
	cpse r22,__zero_reg__
	rjmp .L40
	lds r30,pointer
	ldi r31,0
	subi r30,lo8(-(speed))
	sbci r31,hi8(-(speed))
	ld r24,Z
	subi r24,lo8(-(-3))
	st Z,r24
	rcall check_all
	rcall store_data
	sts stat,__zero_reg__
	rjmp .L18
.L30:
	sbiw r24,15
	brlo .L41
	cpse r22,__zero_reg__
	rjmp .L42
	lds r30,pointer
	ldi r31,0
	subi r30,lo8(-(speed))
	sbci r31,hi8(-(speed))
	ld r24,Z
	subi r24,lo8(-(3))
	st Z,r24
	rcall check_all
	rcall store_data
	sts stat,__zero_reg__
	rjmp .L18
.L31:
	ldi r28,0
	rjmp .L18
.L32:
	ldi r28,0
	rjmp .L18
.L33:
	ldi r28,0
	rjmp .L18
.L34:
	ldi r28,0
	rjmp .L18
.L35:
	ldi r28,0
	rjmp .L18
.L36:
	ldi r28,0
	rjmp .L18
.L37:
	ldi r28,0
	rjmp .L18
.L38:
	ldi r28,0
	rjmp .L18
.L39:
	ldi r28,0
	rjmp .L18
.L40:
	ldi r28,0
	rjmp .L18
.L41:
	ldi r28,0
	rjmp .L18
.L42:
	ldi r28,0
.L18:
	mov r24,r28
/* epilogue start */
	pop r28
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
	sts button_state.1659,__zero_reg__
	sbrc r24,4
	rjmp .L44
	ldi r25,lo8(1)
	sts button_state.1659,r25
	sts but_n.1663,r25
	sbrc r24,3
	rjmp .L45
.L51:
	ldi r24,lo8(1)
	sts button_state.1659,r24
	ldi r24,lo8(2)
	sts but_n.1663,r24
.L45:
	lds r22,button_state.1659
	cpi r22,lo8(1)
	brne .L46
	lds r24,hold.1658
	lds r25,hold.1658+1
	adiw r24,1
	sts hold.1658+1,r25
	sts hold.1658,r24
.L46:
	lds r24,last_button_state.1660
	cpse r22,r24
	rjmp .L54
.L49:
	lds r20,but_n.1663
	lds r24,hold.1658
	lds r25,hold.1658+1
	rcall process_button
	rjmp .L47
.L54:
	ldi r24,0
.L47:
	lds r25,button_state.1659
	cpse r25,__zero_reg__
	rjmp .L48
.L53:
	lds r18,last_button_state.1660
	cpse r18,__zero_reg__
	rjmp .L48
	sts hold.1658+1,__zero_reg__
	sts hold.1658,__zero_reg__
	sts but_n.1663,__zero_reg__
.L48:
	sts last_button_state.1660,r25
	ret
.L57:
	lds r22,last_button_state.1660
	cpse r22,__zero_reg__
	rjmp .L56
	rjmp .L49
.L44:
	sbrs r24,3
	rjmp .L51
	rjmp .L57
.L56:
	lds r25,button_state.1659
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
	ldi r21,lo8(24)
	ldi r19,lo8(26)
.L62:
	cp r25,r24
	brsh .L63
	mov r18,r19
	rjmp .L59
.L63:
	mov r18,r21
.L59:
	cp r25,r22
	brsh .L60
	ori r18,lo8(1)
.L60:
	cp r25,r20
	brsh .L61
	ori r18,lo8(4)
.L61:
	out 0x18,r18
	subi r25,lo8(-(1))
	cpi r25,lo8(20)
	brne .L62
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
	ldi r19,0
	movw r16,r18
	lsl r16
	rol r17
	lsl r16
	rol r17
	add r18,r16
	adc r19,r17
	movw r16,r18
	lsl r16
	rol r17
	rcall make_light
	cp r16,__zero_reg__
	cpc r17,__zero_reg__
	breq .L68
	ldi r28,0
	ldi r29,0
.L67:
	mov r20,r13
	mov r22,r14
	mov r24,r15
	rcall make_light
	cpi r24,lo8(1)
	breq .L66
	adiw r28,1
	cp r16,r28
	cpc r17,r29
	brne .L67
	ldi r24,0
	rjmp .L66
.L68:
	ldi r24,0
.L66:
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
	mov r13,r18
	ldi r28,lo8(1)
.L72:
	mov r11,r12
	mov r20,r28
	and r20,r15
	or r20,r14
	mov r22,r28
	and r22,r17
	or r22,r16
	mov r18,r12
	mov r24,r28
	and r24,r29
	or r24,r13
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L71
	lds r25,stat
	cpse r25,__zero_reg__
	rjmp .L74
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L72
	ldi r28,lo8(20)
.L73:
	mov r20,r28
	and r20,r15
	or r20,r14
	mov r22,r28
	and r22,r17
	or r22,r16
	mov r18,r11
	mov r24,r28
	and r24,r29
	or r24,r13
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L71
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L75
	subi r28,lo8(-(-1))
	brne .L73
	rjmp .L71
.L74:
	ldi r24,lo8(1)
	rjmp .L71
.L75:
	ldi r24,lo8(1)
.L71:
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
	mov r12,r22
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(-1)
	rcall basic_pulse
	rjmp .L83
.L80:
	mov r12,r22
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,0
	ldi r22,lo8(-1)
	ldi r24,lo8(-1)
	rcall basic_pulse
	rjmp .L83
.L81:
	mov r12,r22
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,0
	ldi r22,lo8(-1)
	ldi r24,0
	rcall basic_pulse
	rjmp .L83
.L92:
	cpi r24,lo8(5)
	breq .L85
	cpi r24,lo8(6)
	breq .L86
	cpi r24,lo8(4)
	brne .L93
	mov r12,r22
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
	ldi r22,lo8(-1)
	ldi r24,0
	rcall basic_pulse
	rjmp .L83
.L85:
	mov r12,r22
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
	ldi r22,0
	ldi r24,0
	rcall basic_pulse
	rjmp .L83
.L86:
	mov r12,r22
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
	ldi r22,0
	ldi r24,lo8(-1)
	rcall basic_pulse
	rjmp .L83
.L93:
	cpi r24,lo8(8)
	breq .L88
	cpi r24,lo8(9)
	breq .L89
	cpi r24,lo8(7)
	brne .L94
	mov r12,r22
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
	ldi r22,lo8(-1)
	ldi r24,lo8(-1)
	rcall basic_pulse
	rjmp .L83
.L88:
	mov r12,r22
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,lo8(-1)
	ldi r20,0
	ldi r22,lo8(7)
	ldi r24,lo8(-1)
	rcall basic_pulse
	rjmp .L83
.L89:
	mov r12,r22
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,lo8(25)
	ldi r20,lo8(7)
	ldi r22,0
	ldi r24,lo8(-1)
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
	ldi r28,0
	mov r29,r24
.L97:
	mov r17,r29
	mov r18,r29
	ldi r20,0
	mov r22,r28
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L95
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L95
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L97
	ldi r28,lo8(19)
.L98:
	mov r18,r17
	ldi r20,0
	ldi r22,lo8(20)
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L95
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L95
	subi r28,1
	brcc .L98
	ldi r28,lo8(1)
.L99:
	mov r18,r17
	mov r20,r28
	ldi r22,lo8(20)
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L95
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L95
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L99
	ldi r28,lo8(19)
.L100:
	mov r18,r17
	ldi r20,lo8(20)
	mov r22,r28
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L95
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L95
	subi r28,1
	brcc .L100
	ldi r28,lo8(1)
.L101:
	mov r18,r17
	ldi r20,lo8(20)
	ldi r22,0
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L95
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L95
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L101
	ldi r28,lo8(19)
.L102:
	mov r18,r17
	mov r20,r28
	ldi r22,0
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L95
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L95
	subi r28,1
	brcc .L102
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
/* stack size = 8 */
.L__stack_usage = 8
	mov r12,r24
	mov r13,r22
	mov r14,r20
	mov r15,r18
	ldi r16,0
	ldi r17,0
	ldi r29,0
	ldi r28,lo8(20)
.L111:
	mov r18,r15
	mov r20,r16
	mov r22,r17
	mov r24,r29
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L112
	lds r25,stat
	cpse r25,__zero_reg__
	rjmp .L113
	subi r28,lo8(-(-1))
	add r29,r12
	add r17,r13
	add r16,r14
	cpse r28,__zero_reg__
	rjmp .L111
	rjmp .L110
.L112:
	mov r28,r24
	rjmp .L110
.L113:
	ldi r28,lo8(1)
.L110:
	mov r24,r28
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
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
.L117:
	ldi r18,lo8(2)
	mov r20,r28
	mov r22,r28
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L115
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L115
	subi r28,lo8(-(-1))
	brne .L117
.L118:
	ldi r18,lo8(2)
	ldi r20,0
	mov r22,r28
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L115
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L115
	subi r28,lo8(-(1))
	cpi r28,lo8(20)
	brne .L118
.L119:
	ldi r18,lo8(2)
	ldi r20,0
	ldi r22,lo8(20)
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L115
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L115
	subi r28,lo8(-(-1))
	brne .L119
.L120:
	ldi r18,lo8(2)
	mov r20,r28
	ldi r22,lo8(20)
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L115
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L115
	subi r28,lo8(-(1))
	cpi r28,lo8(20)
	brne .L120
.L121:
	ldi r18,lo8(2)
	ldi r20,lo8(20)
	mov r22,r28
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L115
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L115
	subi r28,lo8(-(-1))
	brne .L121
	ldi r28,lo8(20)
.L122:
	ldi r18,lo8(2)
	mov r20,r28
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L115
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L115
	subi r28,lo8(-(-1))
	brne .L122
	ldi r18,lo8(10)
	ldi r20,0
	ldi r22,0
/* epilogue start */
	pop r28
	rjmp l_make_light
.L115:
/* epilogue start */
	pop r28
	ret
	.size	make_saw_rainbow, .-make_saw_rainbow
.global	make_light_color
	.type	make_light_color, @function
make_light_color:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(2)
	breq .L131
	cpi r24,lo8(3)
	breq .L132
	cpi r24,lo8(1)
	brne .L142
	ldi r18,lo8(10)
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rjmp make_light
.L131:
	ldi r18,lo8(10)
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rjmp make_light
.L132:
	ldi r18,lo8(10)
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	rjmp make_light
.L142:
	cpi r24,lo8(5)
	breq .L135
	cpi r24,lo8(6)
	breq .L136
	cpi r24,lo8(4)
	brne .L143
	ldi r18,lo8(10)
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,0
	rjmp make_light
.L135:
	ldi r18,lo8(10)
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	ldi r24,0
	rjmp make_light
.L136:
	ldi r18,lo8(10)
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(1)
	ldi r22,0
	ldi r24,0
	rjmp make_light
.L143:
	cpi r24,lo8(8)
	breq .L139
	cpi r24,lo8(9)
	breq .L140
	cpi r24,lo8(7)
	brne .L144
	ldi r18,lo8(10)
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(1)
	ldi r22,0
	ldi r24,lo8(1)
	rjmp make_light
.L139:
	ldi r18,lo8(10)
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	rjmp make_light
.L140:
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	rjmp make_light
.L144:
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
	breq .L147
	cpi r24,lo8(3)
	breq .L148
	cpi r24,lo8(1)
	brne .L165
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(20)
	rjmp make_light
.L147:
	ldi r20,0
	ldi r22,lo8(5)
	ldi r24,lo8(20)
	rjmp make_light
.L148:
	ldi r20,0
	ldi r22,lo8(20)
	ldi r24,lo8(20)
	rjmp make_light
.L165:
	cpi r24,lo8(5)
	breq .L151
	cpi r24,lo8(6)
	breq .L152
	cpi r24,lo8(4)
	brne .L166
	ldi r20,0
	ldi r22,lo8(20)
	ldi r24,0
	rjmp make_light
.L151:
	ldi r20,lo8(20)
	ldi r22,lo8(5)
	ldi r24,0
	rjmp make_light
.L152:
	ldi r20,lo8(20)
	ldi r22,0
	ldi r24,0
	rjmp make_light
.L166:
	cpi r24,lo8(8)
	breq .L155
	cpi r24,lo8(9)
	breq .L156
	cpi r24,lo8(7)
	brne .L167
	ldi r20,lo8(20)
	ldi r22,0
	ldi r24,lo8(20)
	rjmp make_light
.L155:
	ldi r20,lo8(5)
	ldi r22,lo8(5)
	ldi r24,lo8(20)
	rjmp make_light
.L156:
	ldi r20,lo8(20)
	ldi r22,lo8(20)
	ldi r24,lo8(20)
	rjmp make_light
.L167:
	cpi r24,lo8(11)
	breq .L159
	brsh .L160
	cpi r24,lo8(10)
	breq .L161
	rjmp .L158
.L160:
	cpi r24,lo8(12)
	breq .L162
	cpi r24,lo8(13)
	breq .L163
	rjmp .L158
.L161:
	ldi r20,0
	ldi r22,lo8(3)
	ldi r24,0
	rjmp make_light
.L159:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(3)
	rjmp make_light
.L162:
	ldi r20,lo8(3)
	ldi r22,lo8(3)
	ldi r24,lo8(3)
	rjmp make_light
.L163:
	ldi r20,lo8(3)
	ldi r22,0
	ldi r24,0
	rjmp make_light
.L158:
	cpse r24,__zero_reg__
	rjmp .L164
	ldi r20,0
	ldi r22,0
	rjmp make_light
.L164:
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
	breq .L171
	mov r15,r22
	movw r16,r24
	ldi r28,0
	ldi r29,0
.L170:
	mov r24,r15
	rcall make_color
	cpi r24,lo8(1)
	breq .L169
	adiw r28,1
	cp r28,r16
	cpc r29,r17
	brne .L170
	ldi r24,0
	rjmp .L169
.L171:
	ldi r24,0
.L169:
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
.L175:
	movw r22,r28
	movw r24,r16
	rcall long_color
	cpi r24,lo8(1)
	breq .L173
	lds r25,stat
	cpse r25,__zero_reg__
	rjmp .L173
	adiw r28,1
	cpi r28,10
	cpc r29,__zero_reg__
	brne .L175
.L173:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	ret
	.size	make_grad_2, .-make_grad_2
.global	make_mix_2
	.type	make_mix_2, @function
make_mix_2:
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	cpi r24,lo8(3)
	breq .L179
	mov r28,r22
	cpi r24,lo8(4)
	brsh .L180
	cpi r24,lo8(1)
	breq .L181
	cpi r24,lo8(2)
	breq .L182
	rjmp .L178
.L180:
	cpi r24,lo8(4)
	breq .L183
	cpi r24,lo8(5)
	breq .L184
	rjmp .L178
.L181:
	mov r18,r22
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
/* epilogue start */
	pop r28
	rjmp make_saw
.L182:
	mov r18,r22
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,0
/* epilogue start */
	pop r28
	rjmp make_saw
.L179:
	mov r18,r22
	ldi r20,lo8(1)
	ldi r22,0
	ldi r24,0
/* epilogue start */
	pop r28
	rjmp make_saw
.L183:
	mov r18,r22
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	ldi r24,lo8(1)
/* epilogue start */
	pop r28
	rjmp make_saw
.L184:
	mov r18,r22
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	brne .+2
	rjmp .L177
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L177
	mov r18,r28
	ldi r20,0
	ldi r22,lo8(1)
/* epilogue start */
	pop r28
	rjmp make_saw
.L178:
	cpi r24,lo8(7)
	breq .L186
	brsh .L187
	cpi r24,lo8(6)
	breq .L188
	rjmp .L177
.L187:
	cpi r24,lo8(8)
	breq .L189
	cpi r24,lo8(9)
	breq .L190
	rjmp .L177
.L188:
	mov r18,r28
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L177
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L177
	mov r18,r28
	ldi r20,lo8(1)
	ldi r22,0
/* epilogue start */
	pop r28
	rjmp make_saw
.L186:
	mov r22,r28
	ldi r23,0
	movw r24,r22
	lsl r24
	rol r25
	add r24,r22
	adc r25,r23
	movw r18,r24
	lsl r18
	rol r19
	swap r18
	swap r19
	andi r19,0xf0
	eor r19,r18
	andi r18,0xf0
	eor r19,r18
	add r24,r18
	adc r25,r19
	add r24,r22
	adc r25,r23
/* epilogue start */
	pop r28
	rjmp make_grad
.L189:
	mov r24,r28
	ldi r25,0
/* epilogue start */
	pop r28
	rjmp make_grad_2
.L190:
/* epilogue start */
	pop r28
	rjmp make_saw_rainbow
.L177:
/* epilogue start */
	pop r28
	ret
	.size	make_mix_2, .-make_mix_2
.global	grad_serie
	.type	grad_serie, @function
grad_serie:
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 4 */
.L__stack_usage = 4
	cpi r24,lo8(3)
	breq .L193
	brsh .L194
	cpi r24,lo8(1)
	breq .L195
	cpi r24,lo8(2)
	breq .L196
	rjmp .L192
.L194:
	cpi r24,lo8(4)
	breq .L197
	cpi r24,lo8(5)
	breq .L198
	rjmp .L192
.L195:
	mov r24,r22
	ldi r25,0
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	rjmp make_grad
.L196:
	ldi r23,0
	movw r24,r22
	lsl r24
	rol r25
	lsl r24
	rol r25
	add r24,r22
	adc r25,r23
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	rjmp make_grad
.L193:
	ldi r23,0
	movw r24,r22
	swap r24
	swap r25
	andi r25,0xf0
	eor r25,r24
	andi r24,0xf0
	eor r25,r24
	sub r24,r22
	sbc r25,r23
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	rjmp make_grad
.L197:
	ldi r23,0
	movw r24,r22
	lsl r24
	rol r25
	lsl r24
	rol r25
	add r22,r24
	adc r23,r25
	movw r24,r22
	lsl r24
	rol r25
	lsl r24
	rol r25
	add r24,r22
	adc r25,r23
	lsl r24
	rol r25
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	rjmp make_grad
.L198:
	ldi r23,0
	movw r24,r22
	lsl r24
	rol r25
	lsl r24
	rol r25
	add r22,r24
	adc r23,r25
	movw r24,r22
	swap r24
	swap r25
	andi r25,0xf0
	eor r25,r24
	andi r24,0xf0
	eor r25,r24
	sub r24,r22
	sbc r25,r23
	lsl r24
	rol r25
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	rjmp make_grad
.L192:
	cpi r24,lo8(7)
	breq .L200
	brsh .L201
	cpi r24,lo8(6)
	breq .L202
	rjmp .L191
.L201:
	cpi r24,lo8(8)
	breq .L203
	cpi r24,lo8(9)
	breq .L204
	rjmp .L191
.L202:
	ldi r23,0
	movw r24,r22
	lsl r24
	rol r25
	lsl r24
	rol r25
	add r24,r22
	adc r25,r23
	lsl r24
	rol r25
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	rjmp make_grad_2
.L200:
	ldi r23,0
	movw r24,r22
	lsl r24
	rol r25
	lsl r24
	rol r25
	add r24,r22
	adc r25,r23
	lsl r24
	rol r25
	lsl r24
	rol r25
	lsl r24
	rol r25
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	rjmp make_grad_2
.L203:
	ldi r23,0
	movw r24,r22
	swap r24
	swap r25
	andi r25,0xf0
	eor r25,r24
	andi r24,0xf0
	eor r25,r24
	sub r24,r22
	sbc r25,r23
	lsl r24
	rol r25
	lsl r24
	rol r25
	lsl r24
	rol r25
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	rjmp make_grad_2
.L204:
	ldi r23,0
	movw r28,r22
	lsl r28
	rol r29
	lsl r28
	rol r29
	add r28,r22
	adc r29,r23
	ldi r16,lo8(1)
	ldi r17,0
.L205:
	movw r22,r16
	movw r24,r28
	rcall long_color
	cpi r24,lo8(1)
	breq .L191
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L191
	subi r16,-1
	sbci r17,-1
	cpi r16,9
	cpc r17,__zero_reg__
	brne .L205
.L191:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	ret
	.size	grad_serie, .-grad_serie
.global	make_mix
	.type	make_mix, @function
make_mix:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	cpi r24,lo8(3)
	breq .L209
	brsh .L210
	cpi r24,lo8(1)
	breq .L211
	cpi r24,lo8(2)
	breq .L212
	rjmp .L208
.L210:
	cpi r24,lo8(4)
	brne .+2
	rjmp .L213
	cpi r24,lo8(5)
	brne .+2
	rjmp .L214
	rjmp .L208
.L211:
	mov r28,r22
	ldi r29,0
	ldi r22,lo8(1)
	ldi r23,0
	movw r24,r28
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L207
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L207
	ldi r22,lo8(4)
	ldi r23,0
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	rjmp long_color
.L212:
	mov r28,r22
	ldi r29,0
	ldi r22,lo8(4)
	ldi r23,0
	movw r24,r28
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L207
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L207
	ldi r22,lo8(6)
	ldi r23,0
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	rjmp long_color
.L209:
	mov r28,r22
	ldi r29,0
	ldi r22,lo8(6)
	ldi r23,0
	movw r24,r28
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L207
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L207
	ldi r22,lo8(1)
	ldi r23,0
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	rjmp long_color
.L213:
	mov r28,r22
	ldi r29,0
	ldi r22,lo8(2)
	ldi r23,0
	movw r24,r28
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L207
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L207
	ldi r22,lo8(5)
	ldi r23,0
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	rjmp long_color
.L214:
	mov r28,r22
	ldi r29,0
	ldi r22,lo8(1)
	ldi r23,0
	movw r24,r28
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L207
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L207
	ldi r22,lo8(2)
	ldi r23,0
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	rjmp long_color
.L208:
	cpi r24,lo8(7)
	breq .L216
	brsh .L217
	cpi r24,lo8(6)
	breq .L218
	rjmp .L207
.L217:
	cpi r24,lo8(8)
	brne .+2
	rjmp .L219
	cpi r24,lo8(9)
	brne .+2
	rjmp .L220
	rjmp .L207
.L218:
	mov r28,r22
	ldi r29,0
	ldi r22,0
	ldi r23,0
	movw r24,r28
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L207
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L207
	ldi r22,lo8(1)
	ldi r23,0
	movw r24,r28
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L207
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L207
	ldi r22,lo8(4)
	ldi r23,0
	movw r24,r28
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L207
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L207
	ldi r22,lo8(1)
	ldi r23,0
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	rjmp long_color
.L216:
	mov r28,r22
	ldi r29,0
	ldi r22,0
	ldi r23,0
	movw r24,r28
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L207
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L207
	ldi r22,lo8(1)
	ldi r23,0
	movw r24,r28
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L207
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L207
	ldi r22,lo8(6)
	ldi r23,0
	movw r24,r28
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L207
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L207
	ldi r22,lo8(1)
	ldi r23,0
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	rjmp long_color
.L219:
	mov r28,r22
	ldi r29,0
	ldi r22,0
	ldi r23,0
	movw r24,r28
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L207
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L207
	ldi r22,lo8(9)
	ldi r23,0
	movw r24,r28
	rcall long_color
	cpi r24,lo8(1)
	breq .L207
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L207
	ldi r22,lo8(6)
	ldi r23,0
	movw r24,r28
	rcall long_color
	cpi r24,lo8(1)
	breq .L207
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L207
	ldi r22,lo8(4)
	ldi r23,0
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	rjmp long_color
.L220:
	mov r28,r22
	ldi r29,0
	ldi r22,0
	ldi r23,0
	movw r24,r28
	rcall long_color
	cpi r24,lo8(1)
	breq .L207
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L207
	ldi r22,lo8(4)
	ldi r23,0
	movw r24,r28
	rcall long_color
	cpi r24,lo8(1)
	breq .L207
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L207
	ldi r22,lo8(6)
	ldi r23,0
	movw r24,r28
	rcall long_color
	cpi r24,lo8(1)
	breq .L207
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L207
	ldi r22,lo8(4)
	ldi r23,0
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	rjmp long_color
.L207:
/* epilogue start */
	pop r29
	pop r28
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
	breq .L222
	lds r25,stat
	cpse r25,__zero_reg__
	rjmp .L224
	ldi r22,0
	ldi r23,0
	movw r24,r28
	rcall long_color
	cpi r24,lo8(1)
	breq .L222
	ldi r24,lo8(1)
	lds r25,stat
	cpse r25,__zero_reg__
	rjmp .L222
	ldi r24,0
	rjmp .L222
.L224:
	ldi r24,lo8(1)
.L222:
/* epilogue start */
	pop r29
	pop r28
	ret
	.size	make_strob, .-make_strob
.global	make_complex_strob
	.type	make_complex_strob, @function
make_complex_strob:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	cpi r24,lo8(3)
	breq .L227
	brsh .L228
	cpi r24,lo8(1)
	breq .L229
	cpi r24,lo8(2)
	breq .L230
	rjmp .L226
.L228:
	cpi r24,lo8(4)
	brne .+2
	rjmp .L231
	cpi r24,lo8(5)
	brne .+2
	rjmp .L232
	rjmp .L226
.L229:
	mov r28,r22
	ldi r29,0
	ldi r20,lo8(1)
	movw r22,r28
	movw r24,r28
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L225
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L225
	ldi r20,lo8(4)
	movw r22,r28
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	rjmp make_strob
.L230:
	mov r28,r22
	ldi r29,0
	ldi r20,lo8(4)
	movw r22,r28
	movw r24,r28
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L225
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L225
	ldi r20,lo8(6)
	movw r22,r28
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	rjmp make_strob
.L227:
	mov r28,r22
	ldi r29,0
	ldi r20,lo8(6)
	movw r22,r28
	movw r24,r28
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L225
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L225
	ldi r20,lo8(1)
	movw r22,r28
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	rjmp make_strob
.L231:
	mov r28,r22
	ldi r29,0
	ldi r20,lo8(2)
	movw r22,r28
	movw r24,r28
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L225
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L225
	ldi r20,lo8(5)
	movw r22,r28
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	rjmp make_strob
.L232:
	mov r28,r22
	ldi r29,0
	ldi r20,lo8(1)
	movw r22,r28
	movw r24,r28
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L225
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L225
	ldi r20,lo8(4)
	movw r22,r28
	movw r24,r28
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L225
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L225
	ldi r20,lo8(6)
	movw r22,r28
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	rjmp make_strob
.L226:
	cpi r24,lo8(7)
	breq .L234
	brsh .L235
	cpi r24,lo8(6)
	breq .L236
	rjmp .L225
.L235:
	cpi r24,lo8(8)
	breq .L237
	cpi r24,lo8(9)
	breq .L238
	rjmp .L225
.L236:
	mov r28,r22
	ldi r29,0
	ldi r20,lo8(1)
	movw r22,r28
	movw r24,r28
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L225
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L225
	ldi r20,lo8(9)
	movw r22,r28
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	rjmp make_strob
.L234:
	mov r28,r22
	ldi r29,0
	ldi r20,lo8(4)
	movw r22,r28
	movw r24,r28
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L225
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L225
	ldi r20,lo8(9)
	movw r22,r28
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	rjmp make_strob
.L237:
	mov r28,r22
	ldi r29,0
	ldi r20,lo8(6)
	movw r22,r28
	movw r24,r28
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L225
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L225
	ldi r20,lo8(9)
	movw r22,r28
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	rjmp make_strob
.L238:
	mov r28,r22
	ldi r29,0
	ldi r20,lo8(1)
	movw r22,r28
	movw r24,r28
	rcall make_strob
	cpi r24,lo8(1)
	breq .L225
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L225
	ldi r20,lo8(9)
	movw r22,r28
	movw r24,r28
	rcall make_strob
	cpi r24,lo8(1)
	breq .L225
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L225
	ldi r20,lo8(4)
	movw r22,r28
	movw r24,r28
	rcall make_strob
	cpi r24,lo8(1)
	breq .L225
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L225
	ldi r20,lo8(9)
	movw r22,r28
	movw r24,r28
	rcall make_strob
	cpi r24,lo8(1)
	breq .L225
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L225
	ldi r20,lo8(6)
	movw r22,r28
	movw r24,r28
	rcall make_strob
	cpi r24,lo8(1)
	breq .L225
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L225
	ldi r20,lo8(9)
	movw r22,r28
	movw r24,r28
/* epilogue start */
	pop r29
	pop r28
	rjmp make_strob
.L225:
/* epilogue start */
	pop r29
	pop r28
	ret
	.size	make_complex_strob, .-make_complex_strob
.global	make_serie
	.type	make_serie, @function
make_serie:
	push r16
	push r17
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	mov r30,r24
	mov r24,r22
	mov r16,r30
	ldi r17,0
	movw r30,r16
	sbiw r30,1
	cpi r30,7
	cpc r31,__zero_reg__
	brsh .L240
	subi r30,lo8(-(gs(.L242)))
	sbci r31,hi8(-(gs(.L242)))
	ijmp
	.section	.progmem.gcc_sw_table,"ax",@progbits
	.p2align	1
.L242:
	rjmp .L241
	rjmp .L243
	rjmp .L244
	rjmp .L245
	rjmp .L246
	rjmp .L247
	rjmp .L248
	.text
.L241:
/* epilogue start */
	pop r17
	pop r16
	rjmp make_color
.L243:
	mov r18,r20
	ldi r19,0
	mov r20,r22
	movw r22,r18
	movw r24,r18
/* epilogue start */
	pop r17
	pop r16
	rjmp make_strob
.L244:
	mov r22,r20
/* epilogue start */
	pop r17
	pop r16
	rjmp make_pulse
.L245:
	mov r22,r20
/* epilogue start */
	pop r17
	pop r16
	rjmp make_complex_strob
.L246:
	mov r22,r20
/* epilogue start */
	pop r17
	pop r16
	rjmp make_mix
.L247:
	mov r22,r20
/* epilogue start */
	pop r17
	pop r16
	rjmp make_mix_2
.L248:
/* epilogue start */
	pop r17
	pop r16
	rjmp make_light_color
.L240:
	ldi r24,0
	rcall make_color
/* epilogue start */
	pop r17
	pop r16
	rjmp check_all
	.size	make_serie, .-make_serie
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	rcall read_data
	rcall check_all
	ldi r24,lo8(7)
	out 0x17,r24
	ldi r24,lo8(31)
	out 0x18,r24
	sts stat,__zero_reg__
.L250:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L251
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L252
	ldi r20,lo8(31)
	lds r22,mode
	lds r24,serie
	rcall make_serie
	rjmp .L250
.L252:
	lds r24,counter
	tst r24
	breq .L254
	lds r24,pointer
	ldi r25,0
	movw r26,r24
	subi r26,lo8(-(speed))
	sbci r27,hi8(-(speed))
	movw r30,r24
	subi r30,lo8(-(modes))
	sbci r31,hi8(-(modes))
	movw r28,r24
	subi r28,lo8(-(series))
	sbci r29,hi8(-(series))
	ld r20,X
	ld r22,Z
	ld r24,Y
	rcall make_serie
	rjmp .L250
.L254:
	ldi r24,0
	rcall make_color
	rjmp .L250
.L251:
	cpi r24,lo8(10)
	brne .L255
	rcall make_color
	rjmp .L250
.L255:
	cpi r24,lo8(11)
	brne .L256
	rcall make_color
	rjmp .L250
.L256:
	cpi r24,lo8(12)
	brne .L257
	rcall make_color
	rjmp .L250
.L257:
	cpi r24,lo8(13)
	brne .L258
	rcall make_color
	rjmp .L250
.L258:
	cpi r24,lo8(14)
	brne .L259
	ldi r20,lo8(1)
	ldi r22,lo8(100)
	ldi r23,0
	ldi r24,lo8(50)
	ldi r25,0
	rcall make_strob
	rjmp .L250
.L259:
	ldi r24,0
	rcall make_color
	sts stat,__zero_reg__
	rjmp .L250
	.size	main, .-main
	.local	last_button_state.1660
	.comm	last_button_state.1660,1,1
	.local	hold.1658
	.comm	hold.1658,2,1
	.local	but_n.1663
	.comm	but_n.1663,1,1
	.local	button_state.1659
	.comm	button_state.1659,1,1
	.comm	speed,16,1
.global	speedm
	.section	.eeprom,"aw",@progbits
	.type	speedm, @object
	.size	speedm, 16
speedm:
	.zero	16
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
