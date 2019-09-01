	.file	"csb-light-2-channel.c"
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
	brlo .L6
	or r22,r23
	brne .L6
	lds r24,mode
	subi r24,lo8(-(1))
	cpi r24,lo8(12)
	brlo .L7
	ldi r24,lo8(1)
.L7:
	sts mode,r24
	lds r22,mode
	ldi r24,lo8(e_mode)
	ldi r25,hi8(e_mode)
	rcall eeprom_write_byte
	ldi r24,lo8(1)
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
	sbis 0x16,4
	rjmp .L10
	sts button_state.1618,__zero_reg__
	rjmp .L11
.L10:
	ldi r24,lo8(1)
	sts button_state.1618,r24
.L11:
	lds r22,button_state.1618
	cpi r22,lo8(1)
	brne .L12
	lds r24,hold.1617
	lds r25,hold.1617+1
	adiw r24,1
	sts hold.1617+1,r25
	sts hold.1617,r24
.L12:
	lds r24,last_button_state.1619
	cpse r22,r24
	rjmp .L15
	ldi r23,0
	lds r24,hold.1617
	lds r25,hold.1617+1
	rcall process_button
	rjmp .L13
.L15:
	ldi r24,0
.L13:
	lds r25,button_state.1618
	cpse r25,__zero_reg__
	rjmp .L14
	lds r18,last_button_state.1619
	cpse r18,__zero_reg__
	rjmp .L14
	sts hold.1617+1,__zero_reg__
	sts hold.1617,__zero_reg__
.L14:
	sts last_button_state.1619,r25
	sts stp,r24
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
.L19:
	cp r25,r24
	brsh .L20
	ldi r18,lo8(34)
	rjmp .L17
.L20:
	ldi r18,lo8(32)
.L17:
	cp r25,r22
	brsh .L18
	ori r18,lo8(1)
.L18:
	out 0x18,r18
	subi r25,lo8(-(1))
	cpi r25,lo8(20)
	brne .L19
	rjmp check_button
	.size	make_light, .-make_light
.global	l_make_light
	.type	l_make_light, @function
l_make_light:
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 4 */
.L__stack_usage = 4
	mov r17,r24
	mov r16,r22
	ldi r28,lo8(-12)
	ldi r29,lo8(1)
.L24:
	mov r22,r16
	mov r24,r17
	rcall make_light
	cpi r24,lo8(1)
	breq .L23
	sbiw r28,1
	brne .L24
	ldi r24,0
.L23:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	ret
	.size	l_make_light, .-l_make_light
.global	make_color
	.type	make_color, @function
make_color:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(1)
	breq .L31
	brlo .L35
	cpi r24,lo8(2)
	breq .L33
	cpi r24,lo8(3)
	brne .L35
	ldi r22,lo8(20)
	rjmp .L37
.L31:
	ldi r22,0
	rjmp .L38
.L33:
	ldi r22,lo8(20)
.L38:
	ldi r24,lo8(20)
	rjmp .L36
.L35:
	ldi r22,0
.L37:
	ldi r24,0
.L36:
	rjmp make_light
	.size	make_color, .-make_color
.global	long_color
	.type	long_color, @function
long_color:
	push r12
	push r13
	push r14
	push r15
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 7 */
.L__stack_usage = 7
	movw r12,r22
	movw r14,r24
	mov r17,r20
	ldi r28,0
	ldi r29,0
.L40:
	movw r24,r28
	ldi r26,0
	ldi r27,0
	cp r24,r12
	cpc r25,r13
	cpc r26,r14
	cpc r27,r15
	brsh .L49
	mov r24,r17
	rcall make_color
	cpi r24,lo8(1)
	breq .L41
	lds r24,stp
	cpi r24,lo8(1)
	breq .L41
	adiw r28,1
	rjmp .L40
.L49:
	ldi r24,0
.L41:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r15
	pop r14
	pop r13
	pop r12
	ret
	.size	long_color, .-long_color
	.section	.text.startup,"ax",@progbits
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(e_mode)
	ldi r25,hi8(e_mode)
	rcall eeprom_read_byte
	sts mode,r24
	cpi r24,lo8(12)
	brlo .L51
	ldi r24,lo8(1)
	sts mode,r24
.L51:
	ldi r24,lo8(7)
	out 0x17,r24
	ldi r24,lo8(23)
	out 0x18,r24
	ldi r17,lo8(20)
	ldi r28,lo8(1)
.L53:
	sts stp,__zero_reg__
	lds r24,mode
	cpi r24,lo8(2)
	breq .L55
	cpi r24,lo8(3)
	breq .L56
	cpi r24,lo8(1)
	breq .+2
	rjmp .L54
	ldi r20,lo8(1)
	ldi r22,lo8(50)
	ldi r23,0
	ldi r24,0
	ldi r25,0
	rcall long_color
	rjmp .L54
.L55:
	ldi r29,lo8(1)
.L61:
	ldi r22,lo8(20)
	mov r24,r29
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L58
	lds r24,stp
	cpi r24,lo8(1)
	brne .L59
.L58:
	sts stp,r28
.L62:
	ldi r29,lo8(19)
	rjmp .L60
.L59:
	subi r29,lo8(-(1))
	cpi r29,lo8(21)
	brne .L61
	rjmp .L62
.L63:
	lds r24,stp
	cpi r24,lo8(1)
	breq .L64
	subi r29,1
	brcs .L54
.L60:
	ldi r22,lo8(20)
	mov r24,r29
	rcall l_make_light
	cpi r24,lo8(1)
	brne .L63
.L64:
	sts stp,r28
	rjmp .L54
.L56:
	ldi r29,0
.L68:
	mov r22,r17
	sub r22,r29
	mov r24,r29
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L65
	lds r24,stp
	cpi r24,lo8(1)
	brne .L66
.L65:
	sts stp,r28
.L69:
	ldi r29,lo8(1)
	rjmp .L67
.L66:
	subi r29,lo8(-(1))
	cpi r29,lo8(21)
	brne .L68
	rjmp .L69
.L167:
	lds r24,stp
	cpi r24,lo8(1)
	breq .L64
	subi r29,lo8(-(1))
	cpi r29,lo8(21)
	breq .L54
.L67:
	mov r22,r29
	mov r24,r17
	sub r24,r29
	rcall l_make_light
	cpi r24,lo8(1)
	brne .L167
	rjmp .L64
.L54:
	lds r24,mode
	cpi r24,lo8(5)
	breq .L72
	cpi r24,lo8(6)
	breq .L73
	cpi r24,lo8(4)
	brne .L71
	ldi r20,lo8(2)
	rjmp .L164
.L72:
	ldi r20,lo8(3)
.L164:
	ldi r22,lo8(50)
	ldi r23,0
	ldi r24,0
	ldi r25,0
	rcall long_color
	rjmp .L71
.L73:
	ldi r29,lo8(1)
.L78:
	mov r22,r29
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L75
	lds r24,stp
	cpi r24,lo8(1)
	brne .L76
.L75:
	sts stp,r28
.L79:
	ldi r29,lo8(19)
	rjmp .L77
.L76:
	subi r29,lo8(-(1))
	cpi r29,lo8(21)
	brne .L78
	rjmp .L79
.L168:
	lds r24,stp
	cpi r24,lo8(1)
	breq .L80
	subi r29,1
	brcs .L71
.L77:
	mov r22,r29
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .L168
.L80:
	sts stp,r28
.L71:
	lds r24,mode
	cpi r24,lo8(8)
	breq .L83
	cpi r24,lo8(9)
	breq .L84
	cpi r24,lo8(7)
	brne .L82
	ldi r20,lo8(2)
	ldi r22,lo8(100)
	ldi r23,0
	ldi r24,0
	ldi r25,0
	rcall long_color
	ldi r20,lo8(3)
	rjmp .L166
.L83:
	ldi r20,lo8(2)
	ldi r22,lo8(100)
	ldi r23,0
	ldi r24,0
	ldi r25,0
	rcall long_color
	ldi r20,lo8(1)
.L166:
	ldi r22,lo8(-60)
	ldi r23,lo8(9)
	ldi r24,0
	ldi r25,0
	rjmp .L165
.L84:
	ldi r20,lo8(2)
	ldi r22,lo8(-116)
	ldi r23,lo8(60)
	ldi r24,0
	ldi r25,0
	rcall long_color
	ldi r20,lo8(3)
	ldi r22,lo8(-116)
	ldi r23,lo8(60)
	ldi r24,0
	ldi r25,0
	rcall long_color
	ldi r20,lo8(1)
	ldi r22,lo8(-116)
	ldi r23,lo8(60)
	ldi r24,0
	ldi r25,0
.L165:
	rcall long_color
.L82:
	lds r24,mode
	cpi r24,lo8(10)
	breq .L86
	cpi r24,lo8(11)
	breq .+2
	rjmp .L53
	ldi r29,lo8(1)
	rjmp .L108
.L86:
	ldi r20,lo8(2)
	ldi r22,lo8(124)
	ldi r23,lo8(21)
	ldi r24,0
	ldi r25,0
	rcall long_color
	ldi r29,lo8(19)
.L91:
	ldi r22,lo8(20)
	mov r24,r29
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L88
	lds r24,stp
	cpi r24,lo8(1)
	brne .L89
.L88:
	sts stp,r28
.L92:
	ldi r29,lo8(1)
	rjmp .L90
.L89:
	subi r29,1
	brcc .L91
	rjmp .L92
.L169:
	lds r24,stp
	cpi r24,lo8(1)
	breq .L93
	subi r29,lo8(-(1))
	cpi r29,lo8(21)
	breq .L95
.L90:
	ldi r22,lo8(20)
	mov r24,r29
	rcall l_make_light
	cpi r24,lo8(1)
	brne .L169
.L93:
	sts stp,r28
.L95:
	ldi r20,lo8(2)
	ldi r22,lo8(124)
	ldi r23,lo8(21)
	ldi r24,0
	ldi r25,0
	rcall long_color
	ldi r29,lo8(19)
.L99:
	mov r22,r29
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L96
	lds r24,stp
	cpi r24,lo8(1)
	brne .L97
.L96:
	sts stp,r28
.L100:
	ldi r29,lo8(1)
	rjmp .L98
.L97:
	subi r29,1
	brcc .L99
	rjmp .L100
.L170:
	lds r24,stp
	cpi r24,lo8(1)
	brne .+2
	rjmp .L53
	subi r29,lo8(-(1))
	cpi r29,lo8(21)
	brne .+2
	rjmp .L53
.L98:
	mov r22,r29
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .L170
	rjmp .L53
.L171:
	lds r24,stp
	cpi r24,lo8(1)
	breq .L105
	subi r29,lo8(-(1))
	cpi r29,lo8(21)
	breq .L109
.L108:
	mov r22,r29
	mov r24,r29
	rcall l_make_light
	cpi r24,lo8(1)
	brne .L171
.L105:
	sts stp,r28
.L109:
	ldi r29,lo8(19)
	rjmp .L107
.L172:
	lds r24,stp
	cpi r24,lo8(1)
	brne .+2
	rjmp .L53
	subi r29,1
	brcc .+2
	rjmp .L53
.L107:
	mov r22,r29
	mov r24,r29
	rcall l_make_light
	cpi r24,lo8(1)
	brne .L172
	rjmp .L53
	.size	main, .-main
	.text
.global	make_strob
	.type	make_strob, @function
make_strob:
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	mov r28,r22
	mov r22,r24
	ldi r23,0
	ldi r24,0
	ldi r25,0
	rcall long_color
	mov r22,r28
	ldi r23,0
	ldi r24,0
	ldi r25,0
	ldi r20,0
	rcall long_color
	ldi r24,0
/* epilogue start */
	pop r28
	ret
	.size	make_strob, .-make_strob
	.local	last_button_state.1619
	.comm	last_button_state.1619,1,1
	.local	hold.1617
	.comm	hold.1617,2,1
	.local	button_state.1618
	.comm	button_state.1618,1,1
.global	stp
	.section .bss
	.type	stp, @object
	.size	stp, 1
stp:
	.zero	1
.global	e_mode
	.section	.eeprom,"aw",@progbits
	.type	e_mode, @object
	.size	e_mode, 1
e_mode:
	.zero	1
	.comm	mode,1,1
	.ident	"GCC: (GNU) 5.4.0"
.global __do_clear_bss
