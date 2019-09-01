	.file	"csb-light-grb-kirilova.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	process_button
	.type	process_button, @function
process_button:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	sbiw r24,21
	brlo .L5
	or r22,r23
	brne .L6
	lds r24,mode
	subi r24,lo8(-(1))
	cpi r24,lo8(13)
	brsh .L3
	sts mode,r24
	rjmp .L4
.L3:
	ldi r24,lo8(1)
	sts mode,r24
.L4:
	lds r22,mode
	ldi r24,lo8(e_mode)
	ldi r25,hi8(e_mode)
	rcall __eewr_byte_tn45
	ldi r24,lo8(1)
	ret
.L5:
	ldi r24,0
	ret
.L6:
	ldi r24,0
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
	sts button_state.1521,__zero_reg__
	sbrc r24,4
	rjmp .L11
	ldi r24,lo8(1)
	sts button_state.1521,r24
	lds r24,hold.1520
	lds r25,hold.1520+1
	adiw r24,1
	sts hold.1520+1,r25
	sts hold.1520,r24
	ldi r22,lo8(1)
	rjmp .L8
.L11:
	ldi r22,0
.L8:
	lds r24,last_button_state.1522
	cpse r22,r24
	rjmp .L12
	ldi r23,0
	lds r24,hold.1520
	lds r25,hold.1520+1
	rcall process_button
	rjmp .L9
.L12:
	ldi r24,0
.L9:
	lds r25,button_state.1521
	cpse r25,__zero_reg__
	rjmp .L10
	lds r18,last_button_state.1522
	cpse r18,__zero_reg__
	rjmp .L10
	sts hold.1520+1,__zero_reg__
	sts hold.1520,__zero_reg__
.L10:
	sts last_button_state.1522,r25
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
.L18:
	cp r25,r24
	brlo .L19
	ldi r18,lo8(32)
	rjmp .L14
.L19:
	ldi r18,lo8(34)
.L14:
	cp r25,r22
	brsh .L15
	ori r18,lo8(1)
.L15:
	cp r25,r20
	brsh .L16
	ori r18,lo8(4)
.L16:
	out 0x18,r18
	subi r25,lo8(-(1))
	cpi r25,lo8(20)
	brne .L18
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
	cp r18,__zero_reg__
	cpc r19,__zero_reg__
	breq .L23
	ldi r28,0
	ldi r29,0
.L22:
	mov r20,r13
	mov r22,r14
	mov r24,r15
	rcall make_light
	cpi r24,lo8(1)
	breq .L21
	adiw r28,1
	cp r28,r16
	cpc r29,r17
	brne .L22
	rjmp .L24
.L23:
	ldi r24,0
	rjmp .L21
.L24:
	ldi r24,0
.L21:
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
.global	supermode_1
	.type	supermode_1, @function
supermode_1:
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	ldi r28,0
.L28:
	ldi r18,lo8(127)
	ldi r19,lo8(2)
	ldi r20,0
	mov r22,r28
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L25
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L28
	ldi r28,lo8(19)
.L30:
	ldi r18,lo8(127)
	ldi r19,lo8(2)
	ldi r20,0
	ldi r22,lo8(20)
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L25
	subi r28,1
	brcc .L30
	ldi r28,lo8(1)
.L32:
	ldi r18,lo8(127)
	ldi r19,lo8(2)
	mov r20,r28
	ldi r22,lo8(20)
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L25
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L32
	ldi r28,lo8(19)
.L34:
	ldi r18,lo8(127)
	ldi r19,lo8(2)
	ldi r20,lo8(20)
	mov r22,r28
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L25
	subi r28,1
	brcc .L34
	ldi r28,lo8(1)
.L36:
	ldi r18,lo8(127)
	ldi r19,lo8(2)
	ldi r20,lo8(20)
	ldi r22,0
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L25
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L36
	ldi r28,lo8(19)
.L37:
	ldi r18,lo8(127)
	ldi r19,lo8(2)
	mov r20,r28
	ldi r22,0
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L25
	subi r28,1
	brcc .L37
.L25:
/* epilogue start */
	pop r28
	ret
	.size	supermode_1, .-supermode_1
.global	l_make_flashing_light
	.type	l_make_flashing_light, @function
l_make_flashing_light:
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
/* stack size = 11 */
.L__stack_usage = 11
	mov r13,r24
	mov r12,r22
	mov r11,r20
	movw r16,r18
	cp r18,__zero_reg__
	cpc r19,__zero_reg__
	breq .L45
	mov r14,__zero_reg__
	mov r15,__zero_reg__
	mov __tmp_reg__,r31
	ldi r31,lo8(29)
	mov r9,r31
	mov r31,__tmp_reg__
	mov r10,__zero_reg__
	rjmp .L40
.L44:
	mov r20,r11
	mov r22,r12
	mov r24,r13
	rcall make_light
	cpi r24,lo8(1)
	breq .L39
	sbiw r28,1
	sbiw r28,0
	brne .L44
	mov r28,r9
	mov r29,r10
.L43:
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall make_light
	cpi r24,lo8(1)
	breq .L39
	sbiw r28,1
	sbiw r28,0
	brne .L43
	ldi r24,-1
	sub r14,r24
	sbc r15,r24
	cp r14,r16
	cpc r15,r17
	breq .L46
.L40:
	mov r28,r9
	mov r29,r10
	rjmp .L44
.L45:
	ldi r24,0
	rjmp .L39
.L46:
	ldi r24,0
.L39:
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
	ret
	.size	l_make_flashing_light, .-l_make_flashing_light
.global	supermode_2
	.type	supermode_2, @function
supermode_2:
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	ldi r28,0
.L50:
	ldi r18,lo8(-21)
	ldi r19,lo8(1)
	ldi r20,0
	mov r22,r28
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L47
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L50
	ldi r18,lo8(35)
	ldi r19,0
	ldi r20,0
	ldi r22,lo8(20)
	ldi r24,lo8(20)
	rcall l_make_flashing_light
	ldi r28,lo8(1)
.L52:
	ldi r18,lo8(-21)
	ldi r19,lo8(1)
	ldi r20,0
	ldi r22,lo8(20)
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L47
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L52
	ldi r18,lo8(35)
	ldi r19,0
	ldi r20,0
	mov r22,r28
	ldi r24,lo8(20)
	rcall l_make_flashing_light
	ldi r28,lo8(1)
.L54:
	ldi r18,lo8(-21)
	ldi r19,lo8(1)
	mov r20,r28
	ldi r22,lo8(20)
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L47
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L54
	ldi r18,lo8(35)
	ldi r19,0
	ldi r20,lo8(20)
	ldi r22,0
	ldi r24,lo8(20)
	rcall l_make_flashing_light
	ldi r28,lo8(19)
.L56:
	ldi r18,lo8(-21)
	ldi r19,lo8(1)
	ldi r20,lo8(20)
	mov r22,r28
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L47
	subi r28,1
	brcc .L56
	ldi r18,lo8(35)
	ldi r19,0
	ldi r20,lo8(20)
	ldi r22,0
	ldi r24,0
	rcall l_make_flashing_light
	ldi r28,lo8(1)
.L58:
	ldi r18,lo8(-21)
	ldi r19,lo8(1)
	ldi r20,lo8(20)
	ldi r22,0
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L47
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L58
	ldi r18,lo8(35)
	ldi r19,0
	ldi r20,lo8(20)
	ldi r22,0
	ldi r24,lo8(20)
	rcall l_make_flashing_light
	ldi r28,lo8(19)
.L60:
	ldi r18,lo8(-21)
	ldi r19,lo8(1)
	mov r20,r28
	ldi r22,0
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L47
	subi r28,1
	brcc .L60
	ldi r18,lo8(35)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(20)
/* epilogue start */
	pop r28
	rjmp l_make_flashing_light
.L47:
/* epilogue start */
	pop r28
	ret
	.size	supermode_2, .-supermode_2
.global	supermode_3
	.type	supermode_3, @function
supermode_3:
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	ldi r28,0
.L64:
	ldi r18,lo8(9)
	ldi r19,0
	ldi r20,0
	mov r22,r28
	ldi r24,lo8(20)
	rcall l_make_flashing_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L61
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L64
	ldi r28,lo8(19)
.L66:
	ldi r18,lo8(9)
	ldi r19,0
	ldi r20,0
	ldi r22,lo8(20)
	mov r24,r28
	rcall l_make_flashing_light
	cpi r24,lo8(1)
	breq .L61
	subi r28,1
	brcc .L66
	ldi r28,lo8(1)
.L68:
	ldi r18,lo8(9)
	ldi r19,0
	mov r20,r28
	ldi r22,lo8(20)
	ldi r24,0
	rcall l_make_flashing_light
	cpi r24,lo8(1)
	breq .L61
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L68
	ldi r28,lo8(19)
.L70:
	ldi r18,lo8(9)
	ldi r19,0
	ldi r20,lo8(20)
	mov r22,r28
	ldi r24,0
	rcall l_make_flashing_light
	cpi r24,lo8(1)
	breq .L61
	subi r28,1
	brcc .L70
	ldi r28,lo8(1)
.L72:
	ldi r18,lo8(9)
	ldi r19,0
	ldi r20,lo8(20)
	ldi r22,0
	mov r24,r28
	rcall l_make_flashing_light
	cpi r24,lo8(1)
	breq .L61
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L72
	ldi r28,lo8(19)
.L73:
	ldi r18,lo8(9)
	ldi r19,0
	mov r20,r28
	ldi r22,0
	ldi r24,lo8(20)
	rcall l_make_flashing_light
	cpi r24,lo8(1)
	breq .L61
	subi r28,1
	brcc .L73
.L61:
/* epilogue start */
	pop r28
	ret
	.size	supermode_3, .-supermode_3
.global	make_color
	.type	make_color, @function
make_color:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(2)
	breq .L76
	cpi r24,lo8(3)
	breq .L77
	cpi r24,lo8(1)
	brne .L88
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(20)
	rjmp make_light
.L76:
	ldi r20,0
	ldi r22,lo8(5)
	ldi r24,lo8(20)
	rjmp make_light
.L77:
	ldi r20,0
	ldi r22,lo8(20)
	ldi r24,lo8(20)
	rjmp make_light
.L88:
	cpi r24,lo8(5)
	breq .L80
	cpi r24,lo8(6)
	breq .L81
	cpi r24,lo8(4)
	brne .L89
	ldi r20,0
	ldi r22,lo8(20)
	ldi r24,0
	rjmp make_light
.L80:
	ldi r20,lo8(20)
	ldi r22,lo8(5)
	ldi r24,0
	rjmp make_light
.L81:
	ldi r20,lo8(20)
	ldi r22,0
	ldi r24,0
	rjmp make_light
.L89:
	cpi r24,lo8(8)
	breq .L84
	cpi r24,lo8(9)
	breq .L85
	cpi r24,lo8(7)
	brne .L90
	ldi r20,lo8(20)
	ldi r22,0
	ldi r24,lo8(20)
	rjmp make_light
.L84:
	ldi r20,lo8(5)
	ldi r22,lo8(5)
	ldi r24,lo8(20)
	rjmp make_light
.L85:
	ldi r20,lo8(20)
	ldi r22,lo8(20)
	ldi r24,lo8(20)
	rjmp make_light
.L90:
	cpse r24,__zero_reg__
	rjmp .L87
	ldi r20,0
	ldi r22,0
	rjmp make_light
.L87:
	ldi r24,0
	ret
	.size	make_color, .-make_color
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(e_mode)
	ldi r25,hi8(e_mode)
	rcall __eerd_byte_tn45
	sts mode,r24
	cpi r24,lo8(13)
	brlo .L92
	ldi r24,lo8(1)
	sts mode,r24
.L92:
	ldi r24,lo8(7)
	out 0x17,r24
	ldi r24,lo8(23)
	out 0x18,r24
.L93:
	lds r24,mode
	cpi r24,lo8(10)
	brsh .L95
	rcall make_color
	rjmp .L93
.L95:
	cpi r24,lo8(11)
	breq .L96
	cpi r24,lo8(12)
	breq .L97
	cpi r24,lo8(10)
	brne .L93
	rcall supermode_1
	rjmp .L93
.L96:
	rcall supermode_2
	rjmp .L93
.L97:
	rcall supermode_3
	rjmp .L93
	.size	main, .-main
	.local	last_button_state.1522
	.comm	last_button_state.1522,1,1
	.local	hold.1520
	.comm	hold.1520,2,1
	.local	button_state.1521
	.comm	button_state.1521,1,1
.global	e_mode
	.section	.eeprom,"aw",@progbits
	.type	e_mode, @object
	.size	e_mode, 1
e_mode:
	.zero	1
	.comm	mode,1,1
	.ident	"GCC: (GNU) 4.8.1"
.global __do_clear_bss
