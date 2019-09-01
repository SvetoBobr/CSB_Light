	.file	"csb-light-grb-elen_snow_1.c"
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
	sbiw r24,21
	brlo .L9
	or r22,r23
	brne .L10
	lds r24,mode
	subi r24,lo8(-(1))
	cpi r24,lo8(7)
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
	sts button_state.1483,__zero_reg__
	sbrc r24,4
	rjmp .L15
	ldi r24,lo8(1)
	sts button_state.1483,r24
	lds r24,hold.1482
	lds r25,hold.1482+1
	adiw r24,1
	sts hold.1482+1,r25
	sts hold.1482,r24
	ldi r22,lo8(1)
	rjmp .L12
.L15:
	ldi r22,0
.L12:
	lds r24,last_button_state.1484
	cpse r22,r24
	rjmp .L16
	ldi r23,0
	lds r24,hold.1482
	lds r25,hold.1482+1
	rcall process_button
	rjmp .L13
.L16:
	ldi r24,0
.L13:
	lds r25,button_state.1483
	cpse r25,__zero_reg__
	rjmp .L14
	lds r18,last_button_state.1484
	cpse r18,__zero_reg__
	rjmp .L14
	sts hold.1482+1,__zero_reg__
	sts hold.1482,__zero_reg__
.L14:
	sts last_button_state.1484,r25
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
	cpi r25,lo8(20)
	brne .L22
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
	ldi r28,lo8(-6)
.L26:
	mov r20,r29
	mov r22,r17
	mov r24,r16
	rcall make_light
	cpi r24,lo8(1)
	breq .L25
	subi r28,lo8(-(-1))
	brne .L26
	mov r24,r28
.L25:
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
	breq .L30
	cpi r24,lo8(4)
	breq .L31
	cpi r24,lo8(1)
	brne .L38
	ldi r20,lo8(5)
	ldi r22,lo8(5)
	ldi r24,lo8(20)
	rjmp make_light
.L30:
	ldi r20,lo8(20)
	ldi r22,lo8(5)
	ldi r24,0
	rjmp make_light
.L31:
	ldi r20,lo8(20)
	ldi r22,0
	ldi r24,0
	rjmp make_light
.L38:
	cpi r24,lo8(5)
	breq .L34
	cpi r24,lo8(6)
	breq .L35
	cpi r24,lo8(3)
	brne .L39
	ldi r20,lo8(20)
	ldi r22,0
	ldi r24,lo8(20)
	rjmp make_light
.L35:
	ldi r20,lo8(20)
	ldi r22,lo8(20)
	ldi r24,0
	rjmp make_light
.L34:
	ldi r20,lo8(20)
	ldi r22,lo8(20)
	ldi r24,lo8(20)
	rjmp make_light
.L39:
	cpse r24,__zero_reg__
	rjmp .L37
	ldi r20,0
	ldi r22,0
	rjmp make_light
.L37:
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
	breq .L43
	ldi r28,0
	ldi r29,0
.L42:
	mov r24,r15
	rcall make_color
	cpi r24,lo8(1)
	breq .L41
	adiw r28,1
	cp r28,r16
	cpc r29,r17
	brlo .L42
	rjmp .L44
.L43:
	ldi r24,0
	rjmp .L41
.L44:
	ldi r24,0
.L41:
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
.global	make_serie
	.type	make_serie, @function
make_serie:
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	lds r24,serie
	cpi r24,lo8(1)
	brne .L47
	lds r24,mode
/* epilogue start */
	pop r28
	rjmp make_color
.L47:
	cpi r24,lo8(2)
	breq .+2
	rjmp .L46
	lds r24,mode
	cpi r24,lo8(2)
	breq .L50
	cpi r24,lo8(3)
	breq .L51
	cpi r24,lo8(1)
	brne .L49
	ldi r28,lo8(1)
.L53:
	mov r22,r28
	ldi r24,lo8(-16)
	rcall long_color
	subi r28,lo8(-(1))
	cpi r28,lo8(7)
	brne .L53
	rjmp .L49
.L50:
	ldi r28,lo8(1)
.L54:
	mov r20,r28
	ldi r22,lo8(60)
	ldi r24,lo8(60)
	rcall make_strob
	subi r28,lo8(-(1))
	cpi r28,lo8(7)
	brne .L54
	rjmp .L49
.L51:
	ldi r28,lo8(1)
.L56:
	ldi r20,lo8(20)
	mov r22,r28
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L46
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L56
	ldi r28,lo8(19)
.L57:
	ldi r20,lo8(20)
	mov r22,r28
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L46
	subi r28,1
	brcc .L57
.L49:
	lds r24,mode
	cpi r24,lo8(5)
	breq .L58
	cpi r24,lo8(6)
	breq .L59
	cpi r24,lo8(4)
	breq .+2
	rjmp .L46
	ldi r28,lo8(1)
.L62:
	ldi r20,lo8(20)
	ldi r22,0
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L46
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L62
	ldi r28,lo8(19)
.L63:
	ldi r20,lo8(20)
	ldi r22,0
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L46
	subi r28,1
	brcc .L63
	rjmp .L46
.L58:
	ldi r28,lo8(1)
.L65:
	ldi r20,lo8(20)
	mov r22,r28
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L46
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L65
	ldi r28,lo8(19)
.L66:
	ldi r20,lo8(20)
	mov r22,r28
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L46
	subi r28,1
	brcc .L66
	rjmp .L46
.L59:
	ldi r28,lo8(1)
.L68:
	ldi r20,lo8(20)
	mov r22,r28
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L46
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L68
	ldi r28,lo8(1)
.L70:
	ldi r20,lo8(20)
	ldi r22,lo8(20)
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L46
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L70
	ldi r28,lo8(19)
.L72:
	ldi r20,lo8(20)
	mov r22,r28
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L46
	subi r28,1
	brcc .L72
	ldi r28,lo8(19)
.L73:
	ldi r20,lo8(20)
	ldi r22,0
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L46
	subi r28,1
	brcc .L73
.L46:
/* epilogue start */
	pop r28
	ret
	.size	make_serie, .-make_serie
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
	cpi r28,lo8(7)
	brlo .L75
	ldi r25,lo8(1)
	sts mode,r25
.L75:
	cpi r24,lo8(3)
	brlo .L76
	ldi r24,lo8(1)
	sts serie,r24
.L76:
	ldi r24,lo8(7)
	out 0x17,r24
	ldi r24,lo8(23)
	out 0x18,r24
.L77:
	rcall make_serie
	rjmp .L77
	.size	main, .-main
	.local	last_button_state.1484
	.comm	last_button_state.1484,1,1
	.local	hold.1482
	.comm	hold.1482,2,1
	.local	button_state.1483
	.comm	button_state.1483,1,1
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
