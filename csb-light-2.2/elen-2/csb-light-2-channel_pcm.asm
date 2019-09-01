	.file	"csb-light-2-channel_pcm.c"
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
	brlo .L5
	or r22,r23
	brne .L11
	sts power,__zero_reg__
	rjmp .L13
.L5:
	sbiw r24,21
	brlo .L11
	or r22,r23
	brne .L11
	lds r24,mode
	subi r24,lo8(-(1))
	cpi r24,lo8(9)
	brlo .L12
	ldi r24,lo8(1)
.L12:
	sts mode,r24
	lds r22,mode
	ldi r24,lo8(e_mode)
	ldi r25,hi8(e_mode)
	rcall eeprom_write_byte
.L13:
	ldi r24,lo8(1)
	ret
.L11:
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
	rjmp .L15
	sts button_state.1743,__zero_reg__
	rjmp .L16
.L15:
	ldi r24,lo8(1)
	sts button_state.1743,r24
.L16:
	lds r22,button_state.1743
	cpi r22,lo8(1)
	brne .L17
	lds r24,hold.1742
	lds r25,hold.1742+1
	adiw r24,1
	sts hold.1742+1,r25
	sts hold.1742,r24
.L17:
	lds r24,last_button_state.1744
	cpse r22,r24
	rjmp .L20
	ldi r23,0
	lds r24,hold.1742
	lds r25,hold.1742+1
	rcall process_button
	rjmp .L18
.L20:
	ldi r24,0
.L18:
	lds r25,button_state.1743
	cpse r25,__zero_reg__
	rjmp .L19
	lds r18,last_button_state.1744
	cpse r18,__zero_reg__
	rjmp .L19
	sts hold.1742+1,__zero_reg__
	sts hold.1742,__zero_reg__
.L19:
	sts last_button_state.1744,r25
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
.L24:
	cp r25,r24
	brsh .L25
	ldi r18,lo8(34)
	rjmp .L22
.L25:
	ldi r18,lo8(32)
.L22:
	cp r25,r22
	brsh .L23
	ori r18,lo8(1)
.L23:
	out 0x18,r18
	subi r25,lo8(-(1))
	cpi r25,lo8(20)
	brne .L24
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
.L29:
	mov r22,r16
	mov r24,r17
	rcall make_light
	cpi r24,lo8(1)
	breq .L28
	sbiw r28,1
	brne .L29
	ldi r24,0
.L28:
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
	breq .L36
	brlo .L40
	cpi r24,lo8(2)
	breq .L38
	cpi r24,lo8(3)
	brne .L40
	ldi r22,lo8(20)
	rjmp .L42
.L36:
	ldi r22,0
	rjmp .L43
.L38:
	ldi r22,lo8(20)
.L43:
	ldi r24,lo8(20)
	rjmp .L41
.L40:
	ldi r22,0
.L42:
	ldi r24,0
.L41:
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
.L45:
	movw r24,r28
	ldi r26,0
	ldi r27,0
	cp r24,r12
	cpc r25,r13
	cpc r26,r14
	cpc r27,r15
	brsh .L54
	mov r24,r17
	rcall make_color
	cpi r24,lo8(1)
	breq .L46
	lds r24,stp
	cpi r24,lo8(1)
	breq .L46
	adiw r28,1
	rjmp .L45
.L54:
	ldi r24,0
.L46:
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
	ldi r24,lo8(10)
	sts power,r24
	out 0x3b,__zero_reg__
	out 0x15,__zero_reg__
/* #APP */
 ;  94 "csb-light-2-channel_pcm.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	ldi r24,lo8(e_mode)
	ldi r25,hi8(e_mode)
	rcall eeprom_read_byte
	sts mode,r24
	cpi r24,lo8(9)
	brlo .L56
	ldi r24,lo8(1)
	sts mode,r24
.L56:
	ldi r24,lo8(7)
	out 0x17,r24
	ldi r24,lo8(23)
	out 0x18,r24
	ldi r29,lo8(20)
	ldi r17,lo8(16)
	ldi r16,lo8(32)
	ldi r24,lo8(7)
	mov r15,r24
	ldi r25,lo8(23)
	mov r14,r25
	ldi r18,lo8(10)
	mov r13,r18
.L57:
	sts stp,__zero_reg__
	lds r24,power
	cpi r24,lo8(2)
	brne .L59
	out 0x17,r15
	out 0x18,r14
	out 0x3b,__zero_reg__
	out 0x15,__zero_reg__
/* #APP */
 ;  111 "csb-light-2-channel_pcm.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	sts power,r13
	in r24,0x16
	ldi r25,lo8(10)
.L62:
	in r24,0x16
	ldi r30,lo8(4999)
	ldi r31,hi8(4999)
1:	sbiw r30,1
	brne 1b
	rjmp .
	nop
	sbrs r24,4
	rjmp .L60
	sts power,__zero_reg__
	rjmp .L61
.L60:
	subi r25,lo8(-(-1))
	brne .L62
.L63:
	sbrc r24,4
	rjmp .L61
	in r24,0x16
	rjmp .L63
.L61:
	ldi r24,lo8(-28037)
	ldi r25,hi8(-28037)
1:	sbiw r24,1
	brne 1b
	rjmp .
	nop
	rjmp .L57
.L59:
	cpse r24,__zero_reg__
	rjmp .L65
	out 0x17,__zero_reg__
	out 0x18,r17
	in r24,0x35
	andi r24,lo8(-25)
	ori r24,lo8(16)
	out 0x35,r24
	in r24,0x35
	ori r24,lo8(32)
	out 0x35,r24
	out 0x3b,r16
	out 0x15,r17
/* #APP */
 ;  133 "csb-light-2-channel_pcm.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
	sts power,__zero_reg__
/* #APP */
 ;  135 "csb-light-2-channel_pcm.c" 1
	sleep
	
 ;  0 "" 2
/* #NOAPP */
	in r24,0x35
	andi r24,lo8(-33)
	out 0x35,r24
	rjmp .L57
.L65:
	lds r24,mode
	cpi r24,lo8(2)
	breq .L67
	cpi r24,lo8(3)
	breq .L68
	cpi r24,lo8(1)
	breq .+2
	rjmp .L66
	ldi r20,lo8(1)
	ldi r22,lo8(50)
	ldi r23,0
	ldi r24,0
	ldi r25,0
	rcall long_color
	rjmp .L66
.L67:
	ldi r28,lo8(1)
.L73:
	ldi r22,lo8(20)
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L70
	lds r24,stp
	cpi r24,lo8(1)
	brne .L71
.L70:
	ldi r24,lo8(1)
	sts stp,r24
.L74:
	ldi r28,lo8(19)
	rjmp .L72
.L71:
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L73
	rjmp .L74
.L75:
	lds r24,stp
	cpi r24,lo8(1)
	breq .L76
	subi r28,1
	brcs .L66
.L72:
	ldi r22,lo8(20)
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	brne .L75
.L76:
	ldi r24,lo8(1)
	sts stp,r24
	rjmp .L66
.L68:
	ldi r28,0
.L80:
	mov r22,r29
	sub r22,r28
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L77
	lds r24,stp
	cpi r24,lo8(1)
	brne .L78
.L77:
	ldi r24,lo8(1)
	sts stp,r24
.L81:
	ldi r28,lo8(1)
	rjmp .L79
.L78:
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L80
	rjmp .L81
.L126:
	lds r24,stp
	cpi r24,lo8(1)
	breq .L76
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	breq .L66
.L79:
	mov r22,r28
	mov r24,r29
	sub r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	brne .L126
	rjmp .L76
.L66:
	lds r24,mode
	cpi r24,lo8(5)
	breq .L84
	cpi r24,lo8(6)
	breq .L85
	cpi r24,lo8(4)
	brne .L83
	ldi r20,lo8(2)
	rjmp .L125
.L84:
	ldi r20,lo8(3)
.L125:
	ldi r22,lo8(50)
	ldi r23,0
	ldi r24,0
	ldi r25,0
	rcall long_color
	rjmp .L83
.L85:
	ldi r28,lo8(1)
.L90:
	mov r22,r28
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L87
	lds r24,stp
	cpi r24,lo8(1)
	brne .L88
.L87:
	ldi r24,lo8(1)
	sts stp,r24
.L91:
	ldi r28,lo8(19)
	rjmp .L89
.L88:
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L90
	rjmp .L91
.L127:
	lds r24,stp
	cpi r24,lo8(1)
	breq .L92
	subi r28,1
	brcs .L83
.L89:
	mov r22,r28
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .L127
.L92:
	ldi r24,lo8(1)
	sts stp,r24
.L83:
	lds r24,mode
	cpi r24,lo8(7)
	breq .L94
	cpi r24,lo8(8)
	breq .+2
	rjmp .L57
	ldi r20,lo8(2)
	ldi r22,lo8(100)
	ldi r23,0
	ldi r24,0
	ldi r25,0
	rcall long_color
	ldi r20,lo8(1)
	rjmp .L124
.L94:
	ldi r20,lo8(2)
	ldi r22,lo8(100)
	ldi r23,0
	ldi r24,0
	ldi r25,0
	rcall long_color
	ldi r20,lo8(3)
.L124:
	ldi r22,lo8(-60)
	ldi r23,lo8(9)
	ldi r24,0
	ldi r25,0
	rcall long_color
	rjmp .L57
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
	.local	last_button_state.1744
	.comm	last_button_state.1744,1,1
	.local	hold.1742
	.comm	hold.1742,2,1
	.local	button_state.1743
	.comm	button_state.1743,1,1
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
	.comm	power,1,1
	.comm	mode,1,1
	.ident	"GCC: (GNU) 5.4.0"
.global __do_clear_bss
