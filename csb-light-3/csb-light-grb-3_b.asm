	.file	"csb-light-grb-3_b.c"
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
	cpi r24,lo8(3)
	brlo .L3
	ldi r24,lo8(1)
	sts serie,r24
	rjmp .L3
.L11:
	ld r20,Z+
	cpi r20,lo8(10)
	brlo .L4
	movw r28,r30
	sbiw r28,1
	mov r20,r30
	sub r20,r18
	st Y,r20
.L4:
	ld r20,X
	cpi r20,lo8(3)
	brlo .L5
	st X,r21
.L5:
	adiw r26,1
	cp r30,r24
	cpc r31,r25
	brne .L11
	lds r24,counter
	cpi r24,lo8(15)
	brlo .L7
	sts counter,__zero_reg__
	ldi r24,0
	rjmp .L8
.L7:
	lds r25,pointer
	cp r25,r24
	brlo .L9
.L8:
	sts pointer,r24
.L9:
	lds r24,fav_on
	cpi r24,lo8(2)
	brlo .L1
	sts fav_on,__zero_reg__
	rjmp .L1
.L3:
	ldi r18,lo8(modes)
	ldi r19,hi8(modes)
	ldi r26,lo8(series)
	ldi r27,hi8(series)
	ldi r24,lo8(modes+15)
	ldi r25,hi8(modes+15)
	movw r30,r18
	ldi r21,lo8(1)
	rjmp .L11
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
	rcall __eerd_byte_tn45
	sts mode,r24
	ldi r24,lo8(e_serie)
	ldi r25,hi8(e_serie)
	rcall __eerd_byte_tn45
	sts serie,r24
	ldi r20,lo8(15)
	ldi r21,0
	ldi r22,lo8(fm)
	ldi r23,hi8(fm)
	ldi r24,lo8(modes)
	ldi r25,hi8(modes)
	rcall __eerd_block_tn45
	ldi r20,lo8(15)
	ldi r21,0
	ldi r22,lo8(sm)
	ldi r23,hi8(sm)
	ldi r24,lo8(series)
	ldi r25,hi8(series)
	rcall __eerd_block_tn45
	ldi r24,lo8(e_pointer)
	ldi r25,hi8(e_pointer)
	rcall __eerd_byte_tn45
	sts pointer,r24
	ldi r24,lo8(e_counter)
	ldi r25,hi8(e_counter)
	rcall __eerd_byte_tn45
	sts counter,r24
	ldi r24,lo8(e_fav_on)
	ldi r25,hi8(e_fav_on)
	rcall __eerd_byte_tn45
	sts fav_on,r24
	rcall check_all
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
	rcall __eewr_byte_tn45
	lds r22,serie
	ldi r24,lo8(e_serie)
	ldi r25,hi8(e_serie)
	rcall __eewr_byte_tn45
	ldi r20,lo8(15)
	ldi r21,0
	ldi r22,lo8(fm)
	ldi r23,hi8(fm)
	ldi r24,lo8(modes)
	ldi r25,hi8(modes)
	rcall __eewr_block_tn45
	ldi r20,lo8(15)
	ldi r21,0
	ldi r22,lo8(sm)
	ldi r23,hi8(sm)
	ldi r24,lo8(series)
	ldi r25,hi8(series)
	rcall __eewr_block_tn45
	lds r22,pointer
	ldi r24,lo8(e_pointer)
	ldi r25,hi8(e_pointer)
	rcall __eewr_byte_tn45
	lds r22,counter
	ldi r24,lo8(e_counter)
	ldi r25,hi8(e_counter)
	rcall __eewr_byte_tn45
	lds r22,fav_on
	ldi r24,lo8(e_fav_on)
	ldi r25,hi8(e_fav_on)
	rcall __eewr_byte_tn45
	ret
	.size	store_data, .-store_data
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
	brlo .L15
	ldi r24,lo8(12)
	sts stat,r24
	sts pointer,__zero_reg__
	sts counter,__zero_reg__
	sts fav_on,__zero_reg__
	rcall check_all
	rcall store_data
	sts stat,__zero_reg__
	ldi r24,lo8(1)
	ret
.L15:
	cpi r24,17
	ldi r18,39
	cpc r25,r18
	brlo .L17
	ldi r24,lo8(11)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L28
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L18
	ldi r24,lo8(1)
	sts fav_on,r24
	sts pointer,__zero_reg__
	rjmp .L19
.L18:
	sts fav_on,__zero_reg__
.L19:
	rcall check_all
	rcall store_data
	sts stat,__zero_reg__
	ldi r24,lo8(1)
	ret
.L17:
	cpi r24,-71
	ldi r18,11
	cpc r25,r18
	brlo .L20
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L29
	ldi r24,lo8(10)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L30
	lds r24,counter
	cpi r24,lo8(16)
	brsh .L21
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
.L21:
	rcall check_all
	rcall store_data
	sts stat,__zero_reg__
	ldi r24,lo8(1)
	ret
.L20:
	cpi r24,-67
	ldi r18,2
	cpc r25,r18
	brlo .L22
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L31
	or r22,r23
	brne .L32
	lds r24,serie
	cpi r24,lo8(1)
	brne .L23
	ldi r24,lo8(2)
	sts serie,r24
	rjmp .L24
.L23:
	ldi r24,lo8(1)
	sts serie,r24
.L24:
	ldi r24,lo8(1)
	sts mode,r24
	rcall store_data
	ldi r24,lo8(1)
	ret
.L22:
	sbiw r24,15
	brlo .L33
	or r22,r23
	brne .L34
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L25
	lds r24,mode
	subi r24,lo8(-(1))
	cpi r24,lo8(10)
	brsh .L26
	sts mode,r24
	rjmp .L27
.L26:
	ldi r24,lo8(1)
	sts mode,r24
	rjmp .L27
.L25:
	lds r24,pointer
	subi r24,lo8(-(1))
	sts pointer,r24
	lds r25,counter
	cp r25,r24
	brsh .L27
	sts pointer,__zero_reg__
.L27:
	rcall check_all
	rcall store_data
	ldi r24,lo8(1)
	ret
.L28:
	ldi r24,0
	ret
.L29:
	ldi r24,0
	ret
.L30:
	ldi r24,0
	ret
.L31:
	ldi r24,0
	ret
.L32:
	ldi r24,0
	ret
.L33:
	ldi r24,0
	ret
.L34:
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
	sts button_state.1635,__zero_reg__
	sbrc r24,4
	rjmp .L39
	ldi r24,lo8(1)
	sts button_state.1635,r24
	lds r24,hold.1634
	lds r25,hold.1634+1
	adiw r24,1
	sts hold.1634+1,r25
	sts hold.1634,r24
	ldi r22,lo8(1)
	rjmp .L36
.L39:
	ldi r22,0
.L36:
	lds r24,last_button_state.1636
	cpse r22,r24
	rjmp .L40
	ldi r23,0
	lds r24,hold.1634
	lds r25,hold.1634+1
	rcall process_button
	rjmp .L37
.L40:
	ldi r24,0
.L37:
	lds r25,button_state.1635
	cpse r25,__zero_reg__
	rjmp .L38
	lds r18,last_button_state.1636
	cpse r18,__zero_reg__
	rjmp .L38
	sts hold.1634+1,__zero_reg__
	sts hold.1634,__zero_reg__
.L38:
	sts last_button_state.1636,r25
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
.L46:
	cp r25,r24
	brlo .L47
	ldi r18,lo8(32)
	rjmp .L42
.L47:
	ldi r18,lo8(34)
.L42:
	cp r25,r22
	brsh .L43
	ori r18,lo8(1)
.L43:
	cp r25,r20
	brsh .L44
	ori r18,lo8(4)
.L44:
	out 0x18,r18
	subi r25,lo8(-(1))
	cpi r25,lo8(20)
	brne .L46
	rcall check_button
	ret
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
.L50:
	mov r20,r29
	mov r22,r17
	mov r24,r16
	rcall make_light
	cpi r24,lo8(1)
	breq .L49
	subi r28,lo8(-(-1))
	brne .L50
	mov r24,r28
.L49:
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
	breq .L54
	cpi r24,lo8(3)
	breq .L55
	cpi r24,lo8(1)
	brne .L71
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(20)
	rcall make_light
	ret
.L54:
	ldi r20,0
	ldi r22,lo8(5)
	ldi r24,lo8(20)
	rcall make_light
	ret
.L55:
	ldi r20,0
	ldi r22,lo8(20)
	ldi r24,lo8(20)
	rcall make_light
	ret
.L71:
	cpi r24,lo8(5)
	breq .L59
	cpi r24,lo8(6)
	breq .L60
	cpi r24,lo8(4)
	brne .L72
	ldi r20,0
	ldi r22,lo8(20)
	ldi r24,0
	rcall make_light
	ret
.L59:
	ldi r20,lo8(20)
	ldi r22,lo8(5)
	ldi r24,0
	rcall make_light
	ret
.L60:
	ldi r20,lo8(20)
	ldi r22,0
	ldi r24,0
	rcall make_light
	ret
.L72:
	cpi r24,lo8(8)
	breq .L63
	cpi r24,lo8(9)
	breq .L64
	cpi r24,lo8(7)
	brne .L73
	ldi r20,lo8(20)
	ldi r22,0
	ldi r24,lo8(20)
	rcall make_light
	ret
.L63:
	ldi r20,lo8(5)
	ldi r22,lo8(5)
	ldi r24,lo8(20)
	rcall make_light
	ret
.L64:
	ldi r20,lo8(20)
	ldi r22,lo8(20)
	ldi r24,lo8(20)
	rcall make_light
	ret
.L73:
	cpi r24,lo8(11)
	breq .L67
	cpi r24,lo8(12)
	breq .L68
	cpi r24,lo8(10)
	brne .L74
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(3)
	rcall make_light
	ret
.L67:
	ldi r20,0
	ldi r22,lo8(3)
	ldi r24,0
	rcall make_light
	ret
.L68:
	ldi r20,lo8(3)
	ldi r22,lo8(3)
	ldi r24,lo8(3)
	rcall make_light
	ret
.L74:
	cpse r24,__zero_reg__
	rjmp .L70
	ldi r20,0
	ldi r22,0
	rcall make_light
	ret
.L70:
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
	breq .L78
	ldi r28,0
	ldi r29,0
.L77:
	mov r24,r15
	rcall make_color
	cpi r24,lo8(1)
	breq .L76
	adiw r28,1
	cp r28,r16
	cpc r29,r17
	brlo .L77
	rjmp .L79
.L78:
	ldi r24,0
	rjmp .L76
.L79:
	ldi r24,0
.L76:
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
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	mov r29,r22
	cpi r24,lo8(1)
	brne .L82
	mov r24,r22
	rcall make_color
	rjmp .L81
.L82:
	lds r24,serie
	cpi r24,lo8(2)
	breq .+2
	rjmp .L81
	cpi r22,lo8(1)
	breq .L85
	cpi r22,lo8(2)
	breq .L86
	rjmp .L110
.L85:
	ldi r28,lo8(1)
.L88:
	mov r22,r28
	ldi r24,lo8(-16)
	rcall long_color
	subi r28,lo8(-(1))
	cpi r28,lo8(8)
	brne .L88
	rjmp .L90
.L86:
	ldi r28,lo8(1)
.L89:
	mov r20,r28
	ldi r22,lo8(60)
	ldi r24,lo8(60)
	rcall make_strob
	subi r28,lo8(-(1))
	cpi r28,lo8(8)
	brne .L89
	rjmp .L90
.L110:
	cpi r22,lo8(3)
	breq .+2
	rjmp .L90
	ldi r28,0
.L92:
	ldi r20,0
	mov r22,r28
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L81
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L81
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L92
	ldi r28,lo8(19)
.L94:
	ldi r20,0
	ldi r22,lo8(20)
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L81
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L81
	subi r28,1
	brcc .L94
	ldi r28,lo8(1)
.L96:
	mov r20,r28
	ldi r22,lo8(20)
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L81
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L81
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L96
	ldi r28,lo8(19)
.L98:
	ldi r20,lo8(20)
	mov r22,r28
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L81
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L81
	subi r28,1
	brcc .L98
	ldi r28,lo8(1)
.L100:
	ldi r20,lo8(20)
	ldi r22,0
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L81
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L81
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L100
	ldi r28,lo8(19)
.L101:
	mov r20,r28
	ldi r22,0
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L81
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L81
	subi r28,1
	brcc .L101
	rjmp .L81
.L90:
	cpi r29,lo8(5)
	breq .L103
	cpi r29,lo8(6)
	breq .L104
	cpi r29,lo8(4)
	brne .L111
	ldi r20,lo8(6)
	ldi r22,lo8(60)
	ldi r24,lo8(60)
	rcall make_strob
	ldi r20,lo8(3)
	ldi r22,lo8(60)
	ldi r24,lo8(60)
	rcall make_strob
	rjmp .L81
.L103:
	ldi r20,lo8(1)
	ldi r22,lo8(60)
	ldi r24,lo8(60)
	rcall make_strob
	ldi r20,lo8(4)
	ldi r22,lo8(60)
	ldi r24,lo8(60)
	rcall make_strob
	rjmp .L81
.L104:
	ldi r20,lo8(2)
	ldi r22,lo8(60)
	ldi r24,lo8(60)
	rcall make_strob
	ldi r20,lo8(7)
	ldi r22,lo8(60)
	ldi r24,lo8(60)
	rcall make_strob
	rjmp .L81
.L111:
	cpi r29,lo8(8)
	breq .L107
	cpi r29,lo8(9)
	breq .L108
	cpi r29,lo8(7)
	brne .L81
	ldi r20,lo8(9)
	ldi r22,lo8(30)
	ldi r24,lo8(30)
	rcall make_strob
	rjmp .L81
.L107:
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
	rjmp .L81
.L108:
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
.L81:
/* epilogue start */
	pop r29
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
	rcall read_data
	ldi r24,lo8(7)
	out 0x17,r24
	ldi r24,lo8(23)
	out 0x18,r24
	sts stat,__zero_reg__
.L113:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L114
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L115
	lds r22,mode
	lds r24,serie
	rcall make_serie
	rjmp .L113
.L115:
	lds r24,counter
	tst r24
	breq .L117
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
	rcall make_serie
	rjmp .L113
.L117:
	ldi r24,0
	rcall make_color
	rjmp .L113
.L114:
	cpi r24,lo8(10)
	brne .L118
	rcall make_color
	rjmp .L113
.L118:
	cpi r24,lo8(11)
	brne .L119
	rcall make_color
	rjmp .L113
.L119:
	cpi r24,lo8(12)
	brne .L120
	rcall make_color
	rjmp .L113
.L120:
	ldi r24,0
	rcall make_color
	rjmp .L113
	.size	main, .-main
	.local	last_button_state.1636
	.comm	last_button_state.1636,1,1
	.local	hold.1634
	.comm	hold.1634,2,1
	.local	button_state.1635
	.comm	button_state.1635,1,1
.global	e_fav_on
	.section	.eeprom,"aw",@progbits
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
	.size	sm, 15
sm:
	.zero	15
.global	fm
	.type	fm, @object
	.size	fm, 15
fm:
	.zero	15
	.comm	fav_on,1,1
	.comm	pointer,1,1
	.comm	counter,1,1
	.comm	series,15,1
	.comm	modes,15,1
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
	.ident	"GCC: (GNU) 4.8.1"
.global __do_clear_bss
