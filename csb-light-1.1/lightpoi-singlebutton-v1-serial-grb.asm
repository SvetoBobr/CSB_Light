	.file	"lightpoi-singlebutton-v1-serial-grb.c"
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
	cpi r24,-95
	ldi r18,15
	cpc r25,r18
	brlo .L2
	ldi r24,lo8(1)
	sts halt,r24
	ret
.L2:
	cpi r24,-67
	ldi r18,2
	cpc r25,r18
	brlo .L4
	or r22,r23
	brne .L11
	lds r24,serie
	cpi r24,lo8(1)
	brne .L5
	ldi r24,lo8(2)
	sts serie,r24
	rjmp .L6
.L5:
	ldi r24,lo8(1)
	sts serie,r24
.L6:
	ldi r24,lo8(1)
	sts mode,r24
	ret
.L4:
	sbiw r24,15
	brlo .L12
	lds r24,halt
	cpi r24,lo8(1)
	brne .L7
	or r22,r23
	brne .L13
	sts halt,__zero_reg__
	ret
.L7:
	cpi r20,lo8(1)
	brne .L8
	or r22,r23
	brne .L14
	lds r24,mode
	subi r24,lo8(-(1))
	cpi r24,lo8(10)
	brsh .L9
	sts mode,r24
	ldi r24,lo8(1)
	ret
.L9:
	ldi r24,lo8(1)
	sts mode,r24
	ret
.L8:
	cpi r20,lo8(2)
	brne .L15
	or r22,r23
	brne .L16
	lds r24,mode
	subi r24,lo8(-(-1))
	breq .L10
	sts mode,r24
	ldi r24,lo8(1)
	ret
.L10:
	ldi r24,lo8(9)
	sts mode,r24
	ldi r24,lo8(1)
	ret
.L11:
	ldi r24,0
	ret
.L12:
	ldi r24,0
	ret
.L13:
	ldi r24,0
	ret
.L14:
	ldi r24,0
	ret
.L15:
	ldi r24,0
	ret
.L16:
	ldi r24,0
	ret
	.size	process_button, .-process_button
.global	check_button
	.type	check_button, @function
check_button:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	sbis 0x16,4
	rjmp .L18
	sts button_state.1426,__zero_reg__
	ldi r28,0
	rjmp .L19
.L18:
	ldi r24,lo8(1)
	sts button_state.1426,r24
	ldi r24,lo8(2)
	sts but_n.1430,r24
	ldi r28,lo8(1)
	lds r24,hold.1425
	lds r25,hold.1425+1
	adiw r24,1
	sts hold.1425+1,r25
	sts hold.1425,r24
.L19:
	lds r29,last_button_state.1427
	cpse r28,r29
	rjmp .L22
	mov r22,r28
	ldi r23,0
	lds r20,but_n.1430
	lds r24,hold.1425
	lds r25,hold.1425+1
	rcall process_button
	rjmp .L20
.L22:
	ldi r24,0
.L20:
	cpse r28,__zero_reg__
	rjmp .L21
	cpse r29,__zero_reg__
	rjmp .L21
	sts hold.1425+1,__zero_reg__
	sts hold.1425,__zero_reg__
	sts but_n.1430,__zero_reg__
.L21:
	sts last_button_state.1427,r28
/* epilogue start */
	pop r29
	pop r28
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
.L28:
	cp r25,r24
	brlo .L29
	ldi r18,lo8(32)
	rjmp .L24
.L29:
	ldi r18,lo8(34)
.L24:
	cp r25,r22
	brsh .L25
	ori r18,lo8(1)
.L25:
	cp r25,r20
	brsh .L26
	ori r18,lo8(4)
.L26:
	out 0x18,r18
	subi r25,lo8(-(1))
	cpi r25,lo8(20)
	brne .L28
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
	mov r16,r24
	mov r17,r22
	mov r29,r20
	ldi r28,lo8(-106)
.L32:
	mov r20,r29
	mov r22,r17
	mov r24,r16
	rcall make_light
	cpi r24,lo8(1)
	breq .L31
	subi r28,lo8(-(-1))
	brne .L32
	mov r24,r28
.L31:
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
	cpi r24,lo8(2)
	breq .L36
	cpi r24,lo8(3)
	breq .L37
	cpi r24,lo8(1)
	brne .L48
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(20)
	rjmp make_light
.L36:
	ldi r20,0
	ldi r22,lo8(5)
	ldi r24,lo8(20)
	rjmp make_light
.L37:
	ldi r20,0
	ldi r22,lo8(20)
	ldi r24,lo8(20)
	rjmp make_light
.L48:
	cpi r24,lo8(5)
	breq .L40
	cpi r24,lo8(6)
	breq .L41
	cpi r24,lo8(4)
	brne .L49
	ldi r20,0
	ldi r22,lo8(20)
	ldi r24,0
	rjmp make_light
.L40:
	ldi r20,lo8(20)
	ldi r22,lo8(5)
	ldi r24,0
	rjmp make_light
.L41:
	ldi r20,lo8(20)
	ldi r22,0
	ldi r24,0
	rjmp make_light
.L49:
	cpi r24,lo8(8)
	breq .L44
	cpi r24,lo8(9)
	breq .L45
	cpi r24,lo8(7)
	brne .L50
	ldi r20,lo8(20)
	ldi r22,0
	ldi r24,lo8(20)
	rjmp make_light
.L44:
	ldi r20,lo8(5)
	ldi r22,lo8(5)
	ldi r24,lo8(20)
	rjmp make_light
.L45:
	ldi r20,lo8(20)
	ldi r22,lo8(20)
	ldi r24,lo8(20)
	rjmp make_light
.L50:
	cpse r24,__zero_reg__
	rjmp .L47
	ldi r20,0
	ldi r22,0
	rjmp make_light
.L47:
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
	mov r15,r22
	mov r16,r24
	ldi r17,0
	cp r16,__zero_reg__
	cpc r17,__zero_reg__
	breq .L54
	ldi r28,0
	ldi r29,0
.L53:
	mov r24,r15
	rcall make_color
	cpi r24,lo8(1)
	breq .L52
	adiw r28,1
	cp r28,r16
	cpc r29,r17
	brlo .L53
	rjmp .L55
.L54:
	ldi r24,0
	rjmp .L52
.L55:
	ldi r24,0
.L52:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	ret
	.size	long_color, .-long_color
.global	make_strob
	.type	make_strob, @function
make_strob:
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	mov r28,r22
	mov r22,r20
	rcall long_color
	ldi r22,0
	mov r24,r28
	rcall long_color
	ldi r24,0
/* epilogue start */
	pop r28
	ret
	.size	make_strob, .-make_strob
.global	main
	.type	main, @function
main:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(7)
	out 0x17,r24
	ldi r24,lo8(23)
	out 0x18,r24
	ldi r24,lo8(1)
	sts mode,r24
	sts serie,r24
	sts halt,r24
	ldi r28,0
	ldi r16,lo8(19)
.L58:
	lds r24,halt
	cpi r24,lo8(1)
	brne .L60
	mov r24,r28
	rcall make_color
	rjmp .L58
.L60:
	lds r24,serie
	cpi r24,lo8(1)
	brne .L61
	lds r24,mode
	rcall make_color
	rjmp .L58
.L61:
	cpi r24,lo8(2)
	brne .L58
	lds r24,mode
	cpi r24,lo8(1)
	breq .L63
	cpi r24,lo8(2)
	breq .L64
	rjmp .L62
.L63:
	ldi r29,lo8(1)
.L65:
	mov r22,r29
	ldi r24,lo8(-16)
	rcall long_color
	subi r29,lo8(-(1))
	cpi r29,lo8(8)
	brne .L65
	rjmp .L62
.L64:
	ldi r29,lo8(1)
.L66:
	mov r20,r29
	ldi r22,lo8(60)
	ldi r24,lo8(60)
	rcall make_strob
	subi r29,lo8(-(1))
	cpi r29,lo8(8)
	brne .L66
.L62:
	lds r24,mode
	cpi r24,lo8(3)
	breq .+2
	rjmp .L67
	mov r29,r28
.L69:
	mov r20,r28
	mov r22,r29
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L86
	subi r29,lo8(-(1))
	cpi r29,lo8(21)
	brne .L69
	rjmp .L87
.L86:
	ldi r29,lo8(1)
	rjmp .L68
.L87:
	mov r29,r28
.L68:
	mov r17,r16
.L71:
	mov r20,r28
	ldi r22,lo8(20)
	mov r24,r17
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L88
	cpi r29,lo8(1)
	breq .L70
	subi r17,1
	brcc .L71
	rjmp .L70
.L88:
	ldi r29,lo8(1)
.L70:
	ldi r17,lo8(1)
.L73:
	mov r20,r17
	ldi r22,lo8(20)
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L89
	cpi r29,lo8(1)
	breq .L72
	subi r17,lo8(-(1))
	cpi r17,lo8(21)
	brne .L73
	rjmp .L72
.L89:
	ldi r29,lo8(1)
.L72:
	mov r17,r16
.L75:
	ldi r20,lo8(20)
	mov r22,r17
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L90
	cpi r29,lo8(1)
	breq .L74
	subi r17,1
	brcc .L75
	rjmp .L74
.L90:
	ldi r29,lo8(1)
.L74:
	ldi r17,lo8(1)
.L77:
	ldi r20,lo8(20)
	mov r22,r28
	mov r24,r17
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L91
	cpi r29,lo8(1)
	breq .L76
	subi r17,lo8(-(1))
	cpi r17,lo8(21)
	brne .L77
	rjmp .L76
.L91:
	ldi r29,lo8(1)
.L76:
	mov r17,r16
.L78:
	mov r20,r17
	mov r22,r28
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L67
	cpi r29,lo8(1)
	breq .L67
	subi r17,1
	brcc .L78
.L67:
	lds r24,mode
	cpi r24,lo8(5)
	breq .L80
	cpi r24,lo8(6)
	breq .L81
	cpi r24,lo8(4)
	brne .L79
	ldi r20,lo8(6)
	ldi r22,lo8(60)
	ldi r24,lo8(60)
	rcall make_strob
	ldi r20,lo8(3)
	ldi r22,lo8(60)
	ldi r24,lo8(60)
	rcall make_strob
	rjmp .L79
.L80:
	ldi r20,lo8(1)
	ldi r22,lo8(60)
	ldi r24,lo8(60)
	rcall make_strob
	ldi r20,lo8(4)
	ldi r22,lo8(60)
	ldi r24,lo8(60)
	rcall make_strob
	rjmp .L79
.L81:
	ldi r20,lo8(2)
	ldi r22,lo8(60)
	ldi r24,lo8(60)
	rcall make_strob
	ldi r20,lo8(7)
	ldi r22,lo8(60)
	ldi r24,lo8(60)
	rcall make_strob
.L79:
	lds r24,mode
	cpi r24,lo8(8)
	breq .L83
	cpi r24,lo8(9)
	breq .L84
	cpi r24,lo8(7)
	breq .+2
	rjmp .L58
	ldi r20,lo8(9)
	ldi r22,lo8(30)
	ldi r24,lo8(30)
	rcall make_strob
	rjmp .L58
.L83:
	ldi r20,lo8(9)
	ldi r22,lo8(30)
	ldi r24,lo8(30)
	rcall make_strob
	ldi r20,lo8(1)
	ldi r22,lo8(30)
	ldi r24,lo8(30)
	rcall make_strob
	ldi r20,lo8(9)
	ldi r22,lo8(30)
	ldi r24,lo8(30)
	rcall make_strob
	ldi r20,lo8(6)
	ldi r22,lo8(30)
	ldi r24,lo8(30)
	rcall make_strob
	rjmp .L58
.L84:
	ldi r20,lo8(9)
	ldi r22,lo8(30)
	ldi r24,lo8(30)
	rcall make_strob
	ldi r20,lo8(4)
	ldi r22,lo8(30)
	ldi r24,lo8(30)
	rcall make_strob
	ldi r20,lo8(9)
	ldi r22,lo8(30)
	ldi r24,lo8(30)
	rcall make_strob
	ldi r20,lo8(6)
	ldi r22,lo8(30)
	ldi r24,lo8(30)
	rcall make_strob
	rjmp .L58
	.size	main, .-main
	.local	last_button_state.1427
	.comm	last_button_state.1427,1,1
	.local	hold.1425
	.comm	hold.1425,2,1
	.local	but_n.1430
	.comm	but_n.1430,1,1
	.local	button_state.1426
	.comm	button_state.1426,1,1
	.comm	halt,1,1
	.comm	serie,1,1
	.comm	mode,1,1
	.ident	"GCC: (GNU) 4.8.1"
.global __do_clear_bss
