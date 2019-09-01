	.file	"csb-light-grb-2_2.c"
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
	rcall eeprom_write_byte
	lds r22,serie
	ldi r24,lo8(e_serie)
	ldi r25,hi8(e_serie)
	rcall eeprom_write_byte
	ldi r24,lo8(1)
	ret
.L2:
	sbiw r24,21
	brlo .L9
	or r22,r23
	brne .L10
	lds r24,mode
	subi r24,lo8(-(1))
	cpi r24,lo8(10)
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
	rcall eeprom_write_byte
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
	sts button_state.1608,__zero_reg__
	sbrc r24,4
	rjmp .L12
	ldi r24,lo8(1)
	sts button_state.1608,r24
	lds r24,hold.1607
	lds r25,hold.1607+1
	adiw r24,1
	sts hold.1607+1,r25
	sts hold.1607,r24
	lds r22,last_button_state.1609
	cpi r22,lo8(1)
	brne .L16
.L14:
	ldi r23,0
	lds r24,hold.1607
	lds r25,hold.1607+1
	rcall process_button
	lds r25,button_state.1608
	cpse r25,__zero_reg__
	rjmp .L13
.L15:
	lds r25,last_button_state.1609
	cpse r25,__zero_reg__
	rjmp .L17
	sts hold.1607+1,__zero_reg__
	sts hold.1607,__zero_reg__
	rjmp .L13
.L16:
	ldi r25,lo8(1)
	ldi r24,0
	rjmp .L13
.L17:
	ldi r25,0
.L13:
	sts last_button_state.1609,r25
	ret
.L12:
	lds r22,last_button_state.1609
	tst r22
	breq .L14
	ldi r24,0
	rjmp .L15
	.size	check_button, .-check_button
.global	make_light
	.type	make_light, @function
make_light:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r25,0
.L23:
	cp r25,r24
	brsh .L24
	ldi r18,lo8(34)
	rjmp .L20
.L24:
	ldi r18,lo8(32)
.L20:
	cp r25,r22
	brsh .L21
	ori r18,lo8(1)
.L21:
	cp r25,r20
	brsh .L22
	ori r18,lo8(4)
.L22:
	out 0x18,r18
	subi r25,lo8(-(1))
	cpi r25,lo8(20)
	brne .L23
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
.L28:
	mov r20,r29
	mov r22,r17
	mov r24,r16
	rcall make_light
	cpi r24,lo8(1)
	breq .L27
	subi r28,lo8(-(-1))
	brne .L28
	mov r24,r28
.L27:
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
	breq .L32
	cpi r24,lo8(3)
	breq .L33
	cpi r24,lo8(1)
	brne .L44
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(20)
	rjmp make_light
.L32:
	ldi r20,0
	ldi r22,lo8(5)
	ldi r24,lo8(20)
	rjmp make_light
.L33:
	ldi r20,0
	ldi r22,lo8(20)
	ldi r24,lo8(20)
	rjmp make_light
.L44:
	cpi r24,lo8(5)
	breq .L36
	cpi r24,lo8(6)
	breq .L37
	cpi r24,lo8(4)
	brne .L45
	ldi r20,0
	ldi r22,lo8(20)
	ldi r24,0
	rjmp make_light
.L36:
	ldi r20,lo8(20)
	ldi r22,lo8(5)
	ldi r24,0
	rjmp make_light
.L37:
	ldi r20,lo8(20)
	ldi r22,0
	ldi r24,0
	rjmp make_light
.L45:
	cpi r24,lo8(8)
	breq .L40
	cpi r24,lo8(9)
	breq .L41
	cpi r24,lo8(7)
	brne .L46
	ldi r20,lo8(20)
	ldi r22,0
	ldi r24,lo8(20)
	rjmp make_light
.L40:
	ldi r20,lo8(5)
	ldi r22,lo8(5)
	ldi r24,lo8(20)
	rjmp make_light
.L41:
	ldi r20,lo8(20)
	ldi r22,lo8(20)
	ldi r24,lo8(20)
	rjmp make_light
.L46:
	cpse r24,__zero_reg__
	rjmp .L43
	ldi r20,0
	ldi r22,0
	rjmp make_light
.L43:
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
	mov r16,r24
	ldi r17,0
	cp r16,__zero_reg__
	cpc r17,__zero_reg__
	breq .L50
	mov r15,r22
	ldi r28,0
	ldi r29,0
.L49:
	mov r24,r15
	rcall make_color
	cpi r24,lo8(1)
	breq .L48
	adiw r28,1
	cp r28,r16
	cpc r29,r17
	brne .L49
	ldi r24,0
	rjmp .L48
.L50:
	ldi r24,0
.L48:
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
	ldi r24,lo8(e_mode)
	ldi r25,hi8(e_mode)
	rcall eeprom_read_byte
	mov r28,r24
	sts mode,r24
	ldi r24,lo8(e_serie)
	ldi r25,hi8(e_serie)
	rcall eeprom_read_byte
	sts serie,r24
	cpi r28,lo8(10)
	brlo .L54
	ldi r25,lo8(1)
	sts mode,r25
.L54:
	cpi r24,lo8(3)
	brlo .L55
	ldi r24,lo8(1)
	sts serie,r24
.L55:
	ldi r24,lo8(7)
	out 0x17,r24
	ldi r24,lo8(23)
	out 0x18,r24
.L56:
	lds r24,serie
	cpi r24,lo8(1)
	brne .L58
	lds r24,mode
	rcall make_color
	rjmp .L56
.L58:
	cpi r24,lo8(2)
	brne .L56
	lds r24,mode
	cpi r24,lo8(1)
	breq .L83
	cpi r24,lo8(2)
	breq .L84
	rjmp .L98
.L83:
	ldi r28,lo8(1)
.L60:
	mov r22,r28
	ldi r24,lo8(-16)
	rcall long_color
	subi r28,lo8(-(1))
	cpi r28,lo8(8)
	brne .L60
	rjmp .L62
.L84:
	ldi r28,lo8(1)
.L61:
	mov r20,r28
	ldi r22,lo8(60)
	ldi r24,lo8(60)
	rcall make_strob
	subi r28,lo8(-(1))
	cpi r28,lo8(8)
	brne .L61
	rjmp .L62
.L98:
	cpi r24,lo8(3)
	breq .+2
	rjmp .L63
.L82:
	ldi r28,0
.L65:
	ldi r20,0
	mov r22,r28
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L85
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L65
	ldi r28,0
	rjmp .L64
.L85:
	ldi r28,lo8(1)
.L64:
	ldi r29,lo8(19)
.L67:
	ldi r20,0
	ldi r22,lo8(20)
	mov r24,r29
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L86
	cpi r28,lo8(1)
	breq .L66
	subi r29,1
	brcc .L67
	rjmp .L66
.L86:
	ldi r28,lo8(1)
.L66:
	ldi r29,lo8(1)
.L69:
	mov r20,r29
	ldi r22,lo8(20)
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L87
	cpi r28,lo8(1)
	breq .L68
	subi r29,lo8(-(1))
	cpi r29,lo8(21)
	brne .L69
	rjmp .L68
.L87:
	ldi r28,lo8(1)
.L68:
	ldi r29,lo8(19)
.L71:
	ldi r20,lo8(20)
	mov r22,r29
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L88
	cpi r28,lo8(1)
	breq .L70
	subi r29,1
	brcc .L71
	rjmp .L70
.L88:
	ldi r28,lo8(1)
.L70:
	ldi r29,lo8(1)
.L73:
	ldi r20,lo8(20)
	ldi r22,0
	mov r24,r29
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L89
	cpi r28,lo8(1)
	breq .L72
	subi r29,lo8(-(1))
	cpi r29,lo8(21)
	brne .L73
	rjmp .L72
.L89:
	ldi r28,lo8(1)
.L72:
	ldi r29,lo8(19)
.L74:
	mov r20,r29
	ldi r22,0
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L63
	cpi r28,lo8(1)
	breq .L63
	subi r29,1
	brcc .L74
.L63:
	lds r24,mode
	cpi r24,lo8(5)
	breq .L76
	cpi r24,lo8(6)
	breq .L77
	cpi r24,lo8(4)
	brne .L75
	ldi r20,lo8(6)
	ldi r22,lo8(60)
	ldi r24,lo8(60)
	rcall make_strob
	ldi r20,lo8(3)
	ldi r22,lo8(60)
	ldi r24,lo8(60)
	rcall make_strob
	rjmp .L75
.L76:
	ldi r20,lo8(1)
	ldi r22,lo8(60)
	ldi r24,lo8(60)
	rcall make_strob
	ldi r20,lo8(4)
	ldi r22,lo8(60)
	ldi r24,lo8(60)
	rcall make_strob
	rjmp .L75
.L77:
	ldi r20,lo8(2)
	ldi r22,lo8(60)
	ldi r24,lo8(60)
	rcall make_strob
	ldi r20,lo8(7)
	ldi r22,lo8(60)
	ldi r24,lo8(60)
	rcall make_strob
.L75:
	lds r24,mode
	cpi r24,lo8(8)
	breq .L79
	cpi r24,lo8(9)
	breq .L80
	cpi r24,lo8(7)
	breq .+2
	rjmp .L56
	ldi r20,lo8(9)
	ldi r22,lo8(30)
	ldi r24,lo8(30)
	rcall make_strob
	rjmp .L56
.L79:
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
	rjmp .L56
.L80:
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
	rjmp .L56
.L62:
	lds r24,mode
	cpi r24,lo8(3)
	breq .+2
	rjmp .L63
	rjmp .L82
	.size	main, .-main
	.local	last_button_state.1609
	.comm	last_button_state.1609,1,1
	.local	hold.1607
	.comm	hold.1607,2,1
	.local	button_state.1608
	.comm	button_state.1608,1,1
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
	.ident	"GCC: (GNU) 5.4.0"
.global __do_clear_bss
