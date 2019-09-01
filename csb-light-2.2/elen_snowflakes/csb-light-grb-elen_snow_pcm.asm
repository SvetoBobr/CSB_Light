	.file	"csb-light-grb-elen_snow_pcm.c"
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
	brlo .L6
	or r22,r23
	brne .L12
	sts power,__zero_reg__
	rjmp .L14
.L6:
	sbiw r24,21
	brlo .L12
	or r22,r23
	brne .L12
	lds r24,mode
	subi r24,lo8(-(1))
	cpi r24,lo8(7)
	brlo .L13
	ldi r24,lo8(1)
.L13:
	sts mode,r24
	lds r22,mode
	ldi r24,lo8(e_mode)
	ldi r25,hi8(e_mode)
	rcall eeprom_write_byte
.L14:
	ldi r24,lo8(1)
	ret
.L12:
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
	rjmp .L16
	sts button_state.1765,__zero_reg__
	rjmp .L17
.L16:
	ldi r24,lo8(1)
	sts button_state.1765,r24
.L17:
	lds r22,button_state.1765
	cpi r22,lo8(1)
	brne .L18
	lds r24,hold.1764
	lds r25,hold.1764+1
	adiw r24,1
	sts hold.1764+1,r25
	sts hold.1764,r24
.L18:
	lds r24,last_button_state.1766
	cpse r22,r24
	rjmp .L21
	ldi r23,0
	lds r24,hold.1764
	lds r25,hold.1764+1
	rcall process_button
	rjmp .L19
.L21:
	ldi r24,0
.L19:
	lds r25,button_state.1765
	cpse r25,__zero_reg__
	rjmp .L20
	lds r18,last_button_state.1766
	cpse r18,__zero_reg__
	rjmp .L20
	sts hold.1764+1,__zero_reg__
	sts hold.1764,__zero_reg__
.L20:
	sts last_button_state.1766,r25
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
.L26:
	cp r25,r24
	brsh .L27
	ldi r18,lo8(34)
	rjmp .L23
.L27:
	ldi r18,lo8(32)
.L23:
	cp r25,r22
	brsh .L24
	ori r18,lo8(1)
.L24:
	cp r25,r20
	brsh .L25
	ori r18,lo8(4)
.L25:
	out 0x18,r18
	subi r25,lo8(-(1))
	cpi r25,lo8(20)
	brne .L26
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
	mov r29,r24
	mov r17,r22
	mov r16,r20
	ldi r28,lo8(-6)
.L31:
	mov r20,r16
	mov r22,r17
	mov r24,r29
	rcall make_light
	cpi r24,lo8(1)
	breq .L30
	subi r28,lo8(-(-1))
	brne .L31
	ldi r24,0
.L30:
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
	breq .L38
	cpi r24,lo8(4)
	breq .L39
	cpi r24,lo8(1)
	brne .L46
	ldi r20,lo8(5)
	ldi r22,lo8(5)
	rjmp .L49
.L38:
	ldi r20,lo8(20)
	ldi r22,lo8(5)
	rjmp .L50
.L39:
	ldi r20,lo8(20)
	ldi r22,0
	rjmp .L50
.L46:
	cpi r24,lo8(5)
	breq .L42
	cpi r24,lo8(6)
	breq .L43
	cpi r24,lo8(3)
	brne .L47
	ldi r20,lo8(20)
	ldi r22,0
	rjmp .L49
.L43:
	ldi r20,lo8(20)
	ldi r22,lo8(20)
.L50:
	ldi r24,0
	rjmp .L48
.L42:
	ldi r20,lo8(20)
	ldi r22,lo8(20)
.L49:
	ldi r24,lo8(20)
	rjmp .L48
.L47:
	cpse r24,__zero_reg__
	rjmp .L45
	ldi r20,0
	ldi r22,0
.L48:
	rjmp make_light
.L45:
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
	ldi r16,0
	ldi r17,0
	mov r28,r24
	ldi r29,0
.L52:
	cp r16,r28
	cpc r17,r29
	brsh .L58
	mov r24,r15
	rcall make_color
	cpi r24,lo8(1)
	breq .L53
	subi r16,-1
	sbci r17,-1
	rjmp .L52
.L58:
	ldi r24,0
.L53:
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
	brne .L61
	lds r24,mode
/* epilogue start */
	pop r28
	rjmp make_color
.L61:
	cpi r24,lo8(2)
	breq .+2
	rjmp .L60
	lds r24,mode
	cpi r24,lo8(2)
	breq .L65
	cpi r24,lo8(3)
	breq .L66
	cpi r24,lo8(1)
	brne .L64
	ldi r28,lo8(1)
.L68:
	mov r22,r28
	ldi r24,lo8(-16)
	rcall long_color
	subi r28,lo8(-(1))
	cpi r28,lo8(7)
	brne .L68
	rjmp .L64
.L65:
	ldi r28,lo8(1)
.L69:
	mov r20,r28
	ldi r22,lo8(60)
	ldi r24,lo8(60)
	rcall make_strob
	subi r28,lo8(-(1))
	cpi r28,lo8(7)
	brne .L69
	rjmp .L64
.L66:
	ldi r28,lo8(1)
.L72:
	ldi r20,lo8(20)
	mov r22,r28
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L60
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L72
	ldi r28,lo8(19)
.L73:
	ldi r20,lo8(20)
	mov r22,r28
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L60
	subi r28,1
	brcc .L73
.L64:
	lds r24,mode
	cpi r24,lo8(5)
	breq .L74
	cpi r24,lo8(6)
	breq .L75
	cpi r24,lo8(4)
	breq .+2
	rjmp .L60
	ldi r28,lo8(1)
.L77:
	ldi r20,lo8(20)
	ldi r22,0
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L60
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L77
	ldi r28,lo8(19)
.L78:
	ldi r20,lo8(20)
	ldi r22,0
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L60
	subi r28,1
	brcc .L78
	rjmp .L60
.L74:
	ldi r28,lo8(1)
.L79:
	ldi r20,lo8(20)
	mov r22,r28
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L60
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L79
	ldi r28,lo8(19)
.L80:
	ldi r20,lo8(20)
	mov r22,r28
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L60
	subi r28,1
	brcc .L80
	rjmp .L60
.L75:
	ldi r28,lo8(1)
.L81:
	ldi r20,lo8(20)
	mov r22,r28
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L60
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L81
	ldi r28,lo8(1)
.L82:
	ldi r20,lo8(20)
	ldi r22,lo8(20)
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L60
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L82
	ldi r28,lo8(19)
.L83:
	ldi r20,lo8(20)
	mov r22,r28
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L60
	subi r28,1
	brcc .L83
	ldi r28,lo8(19)
.L84:
	ldi r20,lo8(20)
	ldi r22,0
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L60
	subi r28,1
	brcc .L84
.L60:
/* epilogue start */
	pop r28
	ret
	.size	make_serie, .-make_serie
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
 ;  161 "csb-light-grb-elen_snow_pcm.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	ldi r24,lo8(e_mode)
	ldi r25,hi8(e_mode)
	rcall eeprom_read_byte
	mov r28,r24
	sts mode,r24
	ldi r24,lo8(e_serie)
	ldi r25,hi8(e_serie)
	rcall eeprom_read_byte
	sts serie,r24
	cpi r28,lo8(7)
	brlo .L128
	ldi r25,lo8(1)
	sts mode,r25
.L128:
	cpi r24,lo8(3)
	brlo .L129
	ldi r24,lo8(1)
	sts serie,r24
.L129:
	rcall init_io
	ldi r28,lo8(16)
	ldi r29,lo8(32)
	ldi r17,lo8(10)
.L130:
	lds r24,power
	cpi r24,lo8(2)
	brne .L131
	rcall init_io
	out 0x3b,__zero_reg__
	out 0x15,__zero_reg__
/* #APP */
 ;  181 "csb-light-grb-elen_snow_pcm.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	sts power,r17
	in r24,0x16
	ldi r25,lo8(10)
.L134:
	in r24,0x16
	ldi r30,lo8(4999)
	ldi r31,hi8(4999)
1:	sbiw r30,1
	brne 1b
	rjmp .
	nop
	sbrs r24,4
	rjmp .L132
	sts power,__zero_reg__
	rjmp .L133
.L132:
	subi r25,lo8(-(-1))
	brne .L134
.L135:
	sbrc r24,4
	rjmp .L133
	in r24,0x16
	rjmp .L135
.L133:
	ldi r24,lo8(-28037)
	ldi r25,hi8(-28037)
1:	sbiw r24,1
	brne 1b
	rjmp .
	nop
	rjmp .L130
.L131:
	cpse r24,__zero_reg__
	rjmp .L138
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
 ;  203 "csb-light-grb-elen_snow_pcm.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
	sts power,__zero_reg__
/* #APP */
 ;  205 "csb-light-grb-elen_snow_pcm.c" 1
	sleep
	
 ;  0 "" 2
/* #NOAPP */
	in r24,0x35
	andi r24,lo8(-33)
	out 0x35,r24
	rjmp .L130
.L138:
	rcall make_serie
	rjmp .L130
	.size	main, .-main
	.local	last_button_state.1766
	.comm	last_button_state.1766,1,1
	.local	hold.1764
	.comm	hold.1764,2,1
	.local	button_state.1765
	.comm	button_state.1765,1,1
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
	.comm	power,1,1
	.comm	serie,1,1
	.comm	mode,1,1
	.ident	"GCC: (GNU) 5.4.0"
.global __do_clear_bss
