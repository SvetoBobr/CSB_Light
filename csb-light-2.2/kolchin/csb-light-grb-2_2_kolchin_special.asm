	.file	"csb-light-grb-2_2_kolchin_special.c"
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
	cpi r24,-67
	ldi r18,2
	cpc r25,r18
	brlo .L2
	or r22,r23
	brne .L8
	lds r24,serie
	cpi r24,lo8(1)
	brne .L4
	ldi r24,lo8(2)
	sts serie,r24
	rjmp .L5
.L4:
	ldi r24,lo8(1)
	sts serie,r24
.L5:
	ldi r24,lo8(1)
	sts mode,r24
	ldi r22,lo8(1)
	ldi r24,lo8(e_mode)
	ldi r25,hi8(e_mode)
	rcall __eewr_byte_tn13
	lds r22,serie
	ldi r24,lo8(e_serie)
	ldi r25,hi8(e_serie)
	rcall __eewr_byte_tn13
	ldi r24,lo8(1)
	ret
.L2:
	sbiw r24,15
	brlo .L9
	or r22,r23
	brne .L10
	lds r24,mode
	subi r24,lo8(-(1))
	cpi r24,lo8(28)
	brsh .L6
	sts mode,r24
	rjmp .L7
.L6:
	ldi r24,lo8(1)
	sts mode,r24
.L7:
	lds r22,mode
	ldi r24,lo8(e_mode)
	ldi r25,hi8(e_mode)
	rcall __eewr_byte_tn13
	ldi r24,lo8(1)
	ret
.L8:
	ldi r24,0
	ret
.L9:
	ldi r24,0
	ret
.L10:
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
	sts button_state.1455,__zero_reg__
	sbrc r24,4
	rjmp .L15
	ldi r24,lo8(1)
	sts button_state.1455,r24
	lds r24,hold.1454
	lds r25,hold.1454+1
	adiw r24,1
	sts hold.1454+1,r25
	sts hold.1454,r24
	ldi r22,lo8(1)
	rjmp .L12
.L15:
	ldi r22,0
.L12:
	lds r24,last_button_state.1456
	cpse r22,r24
	rjmp .L16
	ldi r23,0
	lds r24,hold.1454
	lds r25,hold.1454+1
	rcall process_button
	rjmp .L13
.L16:
	ldi r24,0
.L13:
	lds r25,button_state.1455
	cpse r25,__zero_reg__
	rjmp .L14
	lds r18,last_button_state.1456
	cpse r18,__zero_reg__
	rjmp .L14
	sts hold.1454+1,__zero_reg__
	sts hold.1454,__zero_reg__
.L14:
	sts last_button_state.1456,r25
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
.L22:
	cp r25,r24
	brlo .L23
	ldi r18,lo8(32)
	rjmp .L18
.L23:
	ldi r18,lo8(34)
.L18:
	cp r25,r22
	brsh .L19
	ori r18,lo8(1)
.L19:
	cp r25,r20
	brsh .L20
	ori r18,lo8(4)
.L20:
	out 0x18,r18
	subi r25,lo8(-(1))
	cpi r25,lo8(-96)
	brne .L22
	rjmp check_button
	.size	make_light, .-make_light
.global	l_make_light
	.type	l_make_light, @function
l_make_light:
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 5 */
.L__stack_usage = 5
	mov r17,r24
	mov r16,r22
	mov r15,r20
	mov r29,r18
	tst r18
	breq .L27
	ldi r28,0
.L26:
	mov r20,r15
	mov r22,r16
	mov r24,r17
	rcall make_light
	cpi r24,lo8(1)
	breq .L25
	subi r28,lo8(-(1))
	cpse r28,r29
	rjmp .L26
	rjmp .L28
.L27:
	ldi r24,0
	rjmp .L25
.L28:
	ldi r24,0
.L25:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	ret
	.size	l_make_light, .-l_make_light
.global	make_rainbow
	.type	make_rainbow, @function
make_rainbow:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	mov r29,r24
	ldi r28,0
.L32:
	mov r18,r29
	ldi r20,0
	mov r22,r28
	ldi r24,lo8(-96)
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L30
	subi r28,lo8(-(1))
	cpi r28,lo8(-95)
	brne .L32
	ldi r28,lo8(-97)
.L34:
	mov r18,r29
	ldi r20,0
	ldi r22,lo8(-96)
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L30
	subi r28,1
	brcc .L34
	ldi r28,lo8(1)
.L36:
	mov r18,r29
	mov r20,r28
	ldi r22,lo8(-96)
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L30
	subi r28,lo8(-(1))
	cpi r28,lo8(-95)
	brne .L36
	ldi r28,lo8(-97)
.L38:
	mov r18,r29
	ldi r20,lo8(-96)
	mov r22,r28
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L30
	subi r28,1
	brcc .L38
	ldi r28,lo8(1)
.L40:
	mov r18,r29
	ldi r20,lo8(-96)
	ldi r22,0
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L30
	subi r28,lo8(-(1))
	cpi r28,lo8(-95)
	brne .L40
	ldi r28,lo8(-97)
.L41:
	mov r18,r29
	mov r20,r28
	ldi r22,0
	ldi r24,lo8(-96)
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L30
	subi r28,1
	brcc .L41
	ldi r24,0
.L30:
/* epilogue start */
	pop r29
	pop r28
	ret
	.size	make_rainbow, .-make_rainbow
.global	make_color
	.type	make_color, @function
make_color:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpse r24,__zero_reg__
	rjmp .L44
	ldi r20,0
	ldi r22,0
	rjmp make_light
.L44:
	cpi r24,lo8(2)
	breq .L46
	cpi r24,lo8(3)
	breq .L47
	cpi r24,lo8(1)
	brne .L81
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(-96)
	rjmp make_light
.L46:
	ldi r20,0
	ldi r22,lo8(30)
	ldi r24,lo8(-96)
	rjmp make_light
.L47:
	ldi r20,0
	ldi r22,lo8(70)
	ldi r24,lo8(-96)
	rjmp make_light
.L81:
	cpi r24,lo8(5)
	breq .L50
	cpi r24,lo8(6)
	breq .L51
	cpi r24,lo8(4)
	brne .L82
	ldi r20,0
	ldi r22,lo8(-96)
	ldi r24,lo8(-96)
	rjmp make_light
.L50:
	ldi r20,0
	ldi r22,lo8(-96)
	ldi r24,lo8(70)
	rjmp make_light
.L51:
	ldi r20,0
	ldi r22,lo8(-96)
	ldi r24,lo8(30)
	rjmp make_light
.L82:
	cpi r24,lo8(8)
	breq .L54
	cpi r24,lo8(9)
	breq .L55
	cpi r24,lo8(7)
	brne .L83
	ldi r20,0
	ldi r22,lo8(-96)
	ldi r24,0
	rjmp make_light
.L54:
	ldi r20,lo8(30)
	ldi r22,lo8(-96)
	ldi r24,0
	rjmp make_light
.L55:
	ldi r20,lo8(70)
	ldi r22,lo8(-96)
	ldi r24,0
	rjmp make_light
.L83:
	cpi r24,lo8(11)
	breq .L58
	cpi r24,lo8(12)
	breq .L59
	cpi r24,lo8(10)
	brne .L84
	ldi r20,lo8(-96)
	ldi r22,lo8(-96)
	ldi r24,0
	rjmp make_light
.L58:
	ldi r20,lo8(-96)
	ldi r22,lo8(70)
	ldi r24,0
	rjmp make_light
.L59:
	ldi r20,lo8(-96)
	ldi r22,lo8(30)
	ldi r24,0
	rjmp make_light
.L84:
	cpi r24,lo8(14)
	breq .L62
	cpi r24,lo8(15)
	breq .L63
	cpi r24,lo8(13)
	brne .L85
	ldi r20,lo8(-96)
	ldi r22,0
	ldi r24,0
	rjmp make_light
.L62:
	ldi r20,lo8(-96)
	ldi r22,0
	ldi r24,lo8(30)
	rjmp make_light
.L63:
	ldi r20,lo8(-96)
	ldi r22,0
	ldi r24,lo8(70)
	rjmp make_light
.L85:
	cpi r24,lo8(17)
	breq .L66
	cpi r24,lo8(18)
	breq .L67
	cpi r24,lo8(16)
	brne .L86
	ldi r20,lo8(-96)
	ldi r22,0
	ldi r24,lo8(-96)
	rjmp make_light
.L66:
	ldi r20,lo8(70)
	ldi r22,0
	ldi r24,lo8(-96)
	rjmp make_light
.L67:
	ldi r20,lo8(30)
	ldi r22,0
	ldi r24,lo8(-96)
	rjmp make_light
.L86:
	cpi r24,lo8(20)
	breq .L70
	cpi r24,lo8(21)
	breq .L71
	cpi r24,lo8(19)
	brne .L87
	ldi r20,lo8(30)
	ldi r22,lo8(30)
	ldi r24,lo8(-96)
	rjmp make_light
.L70:
	ldi r20,lo8(70)
	ldi r22,lo8(70)
	ldi r24,lo8(-96)
	rjmp make_light
.L71:
	ldi r20,lo8(-96)
	ldi r22,lo8(-96)
	ldi r24,lo8(-96)
	rjmp make_light
.L87:
	cpi r24,lo8(23)
	breq .L74
	cpi r24,lo8(24)
	breq .L75
	cpi r24,lo8(22)
	brne .L88
	ldi r24,lo8(1)
	rjmp make_rainbow
.L74:
	ldi r24,lo8(10)
	rjmp make_rainbow
.L75:
	ldi r24,lo8(30)
	rjmp make_rainbow
.L88:
	cpi r24,lo8(26)
	breq .L78
	cpi r24,lo8(27)
	breq .L79
	cpi r24,lo8(25)
	brne .L89
	ldi r24,lo8(50)
	rjmp make_rainbow
.L78:
	ldi r24,lo8(-106)
	rjmp make_rainbow
.L79:
	ldi r24,lo8(-1)
	rjmp make_rainbow
.L89:
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rjmp make_light
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
	rcall __eerd_byte_tn13
	mov r28,r24
	sts mode,r24
	ldi r24,lo8(e_serie)
	ldi r25,hi8(e_serie)
	rcall __eerd_byte_tn13
	sts serie,r24
	cpi r28,lo8(28)
	brlo .L91
	ldi r25,lo8(1)
	sts mode,r25
.L91:
	cpi r24,lo8(2)
	brlo .L92
	ldi r24,lo8(1)
	sts serie,r24
.L92:
	ldi r24,lo8(7)
	out 0x17,r24
	ldi r24,lo8(23)
	out 0x18,r24
.L93:
	lds r24,mode
	rcall make_color
	rjmp .L93
	.size	main, .-main
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
	breq .L97
	ldi r28,0
	ldi r29,0
.L96:
	mov r24,r15
	rcall make_color
	cpi r24,lo8(1)
	breq .L95
	adiw r28,1
	cp r28,r16
	cpc r29,r17
	brlo .L96
	rjmp .L98
.L97:
	ldi r24,0
	rjmp .L95
.L98:
	ldi r24,0
.L95:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	ret
	.size	long_color, .-long_color
	.local	last_button_state.1456
	.comm	last_button_state.1456,1,1
	.local	hold.1454
	.comm	hold.1454,2,1
	.local	button_state.1455
	.comm	button_state.1455,1,1
.global	e_serie
	.section	.eeprom,"aw",@progbits
	.type	e_serie, @object
	.size	e_serie, 1
e_serie:
	.zero	1
.global	e_mode
	.type	e_mode, @object
	.size	e_mode, 1
e_mode:
	.zero	1
	.comm	serie,1,1
	.comm	mode,1,1
	.ident	"GCC: (GNU) 4.8.1"
.global __do_clear_bss
