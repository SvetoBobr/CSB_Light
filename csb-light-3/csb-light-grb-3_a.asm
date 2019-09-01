	.file	"csb-light-grb-3_a.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	check_all
	.type	check_all, @function
check_all:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
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
.L9:
	mov r21,r30
	sub r21,r18
	ld r20,Z
	cpi r20,lo8(10)
	brlo .L4
	st Z,r21
.L4:
	ld r20,X
	cpi r20,lo8(3)
	brlo .L5
	st X,r22
.L5:
	adiw r30,1
	adiw r26,1
	cp r30,r24
	cpc r31,r25
	brne .L9
	lds r24,counter
	cpi r24,lo8(6)
	brlo .L7
	ldi r24,lo8(1)
	sts counter,r24
.L7:
	lds r24,fav_on
	cpi r24,lo8(2)
	brlo .L1
	sts fav_on,__zero_reg__
	ret
.L3:
	ldi r18,lo8(modes)
	ldi r19,hi8(modes)
	ldi r26,lo8(series)
	ldi r27,hi8(series)
	ldi r24,lo8(modes+6)
	ldi r25,hi8(modes+6)
	movw r30,r18
	ldi r22,lo8(1)
	rjmp .L9
.L1:
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
	ldi r24,lo8(m1)
	ldi r25,hi8(m1)
	rcall __eerd_byte_tn45
	sts modes+1,r24
	ldi r24,lo8(m2)
	ldi r25,hi8(m2)
	rcall __eerd_byte_tn45
	sts modes+2,r24
	ldi r24,lo8(m3)
	ldi r25,hi8(m3)
	rcall __eerd_byte_tn45
	sts modes+3,r24
	ldi r24,lo8(m4)
	ldi r25,hi8(m4)
	rcall __eerd_byte_tn45
	sts modes+4,r24
	ldi r24,lo8(m5)
	ldi r25,hi8(m5)
	rcall __eerd_byte_tn45
	sts modes+5,r24
	ldi r24,lo8(s1)
	ldi r25,hi8(s1)
	rcall __eerd_byte_tn45
	sts series+1,r24
	ldi r24,lo8(s2)
	ldi r25,hi8(s2)
	rcall __eerd_byte_tn45
	sts series+2,r24
	ldi r24,lo8(s3)
	ldi r25,hi8(s3)
	rcall __eerd_byte_tn45
	sts series+3,r24
	ldi r24,lo8(s4)
	ldi r25,hi8(s4)
	rcall __eerd_byte_tn45
	sts series+4,r24
	ldi r24,lo8(s5)
	ldi r25,hi8(s5)
	rcall __eerd_byte_tn45
	sts series+5,r24
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
	lds r22,modes+1
	ldi r24,lo8(m1)
	ldi r25,hi8(m1)
	rcall __eewr_byte_tn45
	lds r22,modes+2
	ldi r24,lo8(m2)
	ldi r25,hi8(m2)
	rcall __eewr_byte_tn45
	lds r22,modes+3
	ldi r24,lo8(m3)
	ldi r25,hi8(m3)
	rcall __eewr_byte_tn45
	lds r22,modes+4
	ldi r24,lo8(m4)
	ldi r25,hi8(m4)
	rcall __eewr_byte_tn45
	lds r22,modes+5
	ldi r24,lo8(m5)
	ldi r25,hi8(m5)
	rcall __eewr_byte_tn45
	lds r22,series+1
	ldi r24,lo8(s1)
	ldi r25,hi8(s1)
	rcall __eewr_byte_tn45
	lds r22,series+2
	ldi r24,lo8(s2)
	ldi r25,hi8(s2)
	rcall __eewr_byte_tn45
	lds r22,series+3
	ldi r24,lo8(s3)
	ldi r25,hi8(s3)
	rcall __eewr_byte_tn45
	lds r22,series+4
	ldi r24,lo8(s4)
	ldi r25,hi8(s4)
	rcall __eewr_byte_tn45
	lds r22,series+5
	ldi r24,lo8(s5)
	ldi r25,hi8(s5)
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
	cpi r24,17
	ldi r18,39
	cpc r25,r18
	brlo .L13
	ldi r24,lo8(11)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L25
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L15
	ldi r24,lo8(1)
	sts fav_on,r24
	rjmp .L16
.L15:
	sts fav_on,__zero_reg__
.L16:
	rcall check_all
	rcall store_data
	sts stat,__zero_reg__
	ldi r24,lo8(1)
	ret
.L13:
	cpi r24,-71
	ldi r18,11
	cpc r25,r18
	brlo .L17
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L26
	ldi r24,lo8(10)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L27
	lds r18,counter
	mov r24,r18
	ldi r25,0
	movw r30,r24
	subi r30,lo8(-(modes))
	sbci r31,hi8(-(modes))
	lds r19,mode
	st Z,r19
	movw r30,r24
	subi r30,lo8(-(series))
	sbci r31,hi8(-(series))
	lds r19,serie
	st Z,r19
	subi r18,lo8(-(1))
	sts counter,r18
	rcall check_all
	rcall store_data
	sts stat,__zero_reg__
	ldi r24,lo8(1)
	ret
.L17:
	cpi r24,-67
	ldi r18,2
	cpc r25,r18
	brlo .L18
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L28
	or r22,r23
	brne .L29
	lds r24,serie
	cpi r24,lo8(1)
	brne .L19
	ldi r24,lo8(2)
	sts serie,r24
	rjmp .L20
.L19:
	ldi r24,lo8(1)
	sts serie,r24
.L20:
	ldi r24,lo8(1)
	sts mode,r24
	rcall store_data
	ldi r24,lo8(1)
	ret
.L18:
	sbiw r24,15
	brlo .L30
	or r22,r23
	brne .L31
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L21
	lds r24,mode
	subi r24,lo8(-(1))
	cpi r24,lo8(10)
	brsh .L22
	sts mode,r24
	rjmp .L23
.L22:
	ldi r24,lo8(1)
	sts mode,r24
	rjmp .L23
.L21:
	lds r24,counter
	subi r24,lo8(-(1))
	cpi r24,lo8(6)
	brsh .L24
	sts counter,r24
	rjmp .L23
.L24:
	ldi r24,lo8(1)
	sts counter,r24
.L23:
	rcall check_all
	rcall store_data
	ldi r24,lo8(1)
	ret
.L25:
	ldi r24,0
	ret
.L26:
	ldi r24,0
	ret
.L27:
	ldi r24,0
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
	.size	process_button, .-process_button
.global	check_button
	.type	check_button, @function
check_button:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	in r24,0x16
	sts button_state.1642,__zero_reg__
	sbrc r24,4
	rjmp .L36
	ldi r24,lo8(1)
	sts button_state.1642,r24
	lds r24,hold.1641
	lds r25,hold.1641+1
	adiw r24,1
	sts hold.1641+1,r25
	sts hold.1641,r24
	ldi r22,lo8(1)
	rjmp .L33
.L36:
	ldi r22,0
.L33:
	lds r24,last_button_state.1643
	cpse r22,r24
	rjmp .L37
	ldi r23,0
	lds r24,hold.1641
	lds r25,hold.1641+1
	rcall process_button
	rjmp .L34
.L37:
	ldi r24,0
.L34:
	lds r25,button_state.1642
	cpse r25,__zero_reg__
	rjmp .L35
	lds r18,last_button_state.1643
	cpse r18,__zero_reg__
	rjmp .L35
	sts hold.1641+1,__zero_reg__
	sts hold.1641,__zero_reg__
.L35:
	sts last_button_state.1643,r25
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
.L43:
	cp r25,r24
	brlo .L44
	ldi r18,lo8(32)
	rjmp .L39
.L44:
	ldi r18,lo8(34)
.L39:
	cp r25,r22
	brsh .L40
	ori r18,lo8(1)
.L40:
	cp r25,r20
	brsh .L41
	ori r18,lo8(4)
.L41:
	out 0x18,r18
	subi r25,lo8(-(1))
	cpi r25,lo8(20)
	brne .L43
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
.L47:
	mov r20,r29
	mov r22,r17
	mov r24,r16
	rcall make_light
	cpi r24,lo8(1)
	breq .L46
	subi r28,lo8(-(-1))
	brne .L47
	mov r24,r28
.L46:
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
	breq .L51
	cpi r24,lo8(3)
	breq .L52
	cpi r24,lo8(1)
	brne .L68
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(20)
	rcall make_light
	ret
.L51:
	ldi r20,0
	ldi r22,lo8(5)
	ldi r24,lo8(20)
	rcall make_light
	ret
.L52:
	ldi r20,0
	ldi r22,lo8(20)
	ldi r24,lo8(20)
	rcall make_light
	ret
.L68:
	cpi r24,lo8(5)
	breq .L56
	cpi r24,lo8(6)
	breq .L57
	cpi r24,lo8(4)
	brne .L69
	ldi r20,0
	ldi r22,lo8(20)
	ldi r24,0
	rcall make_light
	ret
.L56:
	ldi r20,lo8(20)
	ldi r22,lo8(5)
	ldi r24,0
	rcall make_light
	ret
.L57:
	ldi r20,lo8(20)
	ldi r22,0
	ldi r24,0
	rcall make_light
	ret
.L69:
	cpi r24,lo8(8)
	breq .L60
	cpi r24,lo8(9)
	breq .L61
	cpi r24,lo8(7)
	brne .L70
	ldi r20,lo8(20)
	ldi r22,0
	ldi r24,lo8(20)
	rcall make_light
	ret
.L60:
	ldi r20,lo8(5)
	ldi r22,lo8(5)
	ldi r24,lo8(20)
	rcall make_light
	ret
.L61:
	ldi r20,lo8(20)
	ldi r22,lo8(20)
	ldi r24,lo8(20)
	rcall make_light
	ret
.L70:
	cpi r24,lo8(11)
	breq .L64
	cpi r24,lo8(12)
	breq .L65
	cpi r24,lo8(10)
	brne .L71
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(3)
	rcall make_light
	ret
.L64:
	ldi r20,0
	ldi r22,lo8(3)
	ldi r24,0
	rcall make_light
	ret
.L65:
	ldi r20,lo8(3)
	ldi r22,lo8(3)
	ldi r24,lo8(3)
	rcall make_light
	ret
.L71:
	cpse r24,__zero_reg__
	rjmp .L67
	ldi r20,0
	ldi r22,0
	rcall make_light
	ret
.L67:
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
	breq .L75
	ldi r28,0
	ldi r29,0
.L74:
	mov r24,r15
	rcall make_color
	cpi r24,lo8(1)
	breq .L73
	adiw r28,1
	cp r28,r16
	cpc r29,r17
	brlo .L74
	rjmp .L76
.L75:
	ldi r24,0
	rjmp .L73
.L76:
	ldi r24,0
.L73:
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
	brne .L79
	mov r24,r22
	rcall make_color
	rjmp .L78
.L79:
	lds r24,serie
	cpi r24,lo8(2)
	breq .+2
	rjmp .L78
	cpi r22,lo8(1)
	breq .L82
	cpi r22,lo8(2)
	breq .L83
	rjmp .L118
.L82:
	ldi r28,lo8(1)
.L85:
	mov r22,r28
	ldi r24,lo8(-16)
	rcall long_color
	subi r28,lo8(-(1))
	cpi r28,lo8(8)
	brne .L85
	rjmp .L87
.L83:
	ldi r28,lo8(1)
.L86:
	mov r20,r28
	ldi r22,lo8(60)
	ldi r24,lo8(60)
	rcall make_strob
	subi r28,lo8(-(1))
	cpi r28,lo8(8)
	brne .L86
	rjmp .L87
.L118:
	cpi r22,lo8(3)
	breq .+2
	rjmp .L87
	ldi r28,0
.L89:
	ldi r20,0
	mov r22,r28
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L107
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L108
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L89
	rjmp .L109
.L107:
	ldi r28,lo8(1)
	rjmp .L88
.L108:
	ldi r28,lo8(1)
	rjmp .L88
.L109:
	ldi r28,0
.L88:
	ldi r29,lo8(19)
.L91:
	ldi r20,0
	ldi r22,lo8(20)
	mov r24,r29
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L110
	cpi r28,lo8(1)
	breq .L90
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L111
	subi r29,1
	brcc .L91
	rjmp .L90
.L110:
	ldi r28,lo8(1)
	rjmp .L90
.L111:
	ldi r28,lo8(1)
.L90:
	ldi r29,lo8(1)
.L93:
	mov r20,r29
	ldi r22,lo8(20)
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L112
	cpi r28,lo8(1)
	breq .L92
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L113
	subi r29,lo8(-(1))
	cpi r29,lo8(21)
	brne .L93
	rjmp .L92
.L112:
	ldi r28,lo8(1)
	rjmp .L92
.L113:
	ldi r28,lo8(1)
.L92:
	ldi r29,lo8(19)
.L95:
	ldi r20,lo8(20)
	mov r22,r29
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L114
	cpi r28,lo8(1)
	breq .L94
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L115
	subi r29,1
	brcc .L95
	rjmp .L94
.L114:
	ldi r28,lo8(1)
	rjmp .L94
.L115:
	ldi r28,lo8(1)
.L94:
	ldi r29,lo8(1)
.L97:
	ldi r20,lo8(20)
	ldi r22,0
	mov r24,r29
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L116
	cpi r28,lo8(1)
	breq .L96
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L117
	subi r29,lo8(-(1))
	cpi r29,lo8(21)
	brne .L97
	rjmp .L96
.L116:
	ldi r28,lo8(1)
	rjmp .L96
.L117:
	ldi r28,lo8(1)
.L96:
	ldi r29,lo8(19)
.L98:
	mov r20,r29
	ldi r22,0
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L78
	cpi r28,lo8(1)
	brne .+2
	rjmp .L78
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L78
	subi r29,1
	brcc .L98
	rjmp .L78
.L87:
	cpi r29,lo8(5)
	breq .L100
	cpi r29,lo8(6)
	breq .L101
	cpi r29,lo8(4)
	brne .L119
	ldi r20,lo8(6)
	ldi r22,lo8(60)
	ldi r24,lo8(60)
	rcall make_strob
	ldi r20,lo8(3)
	ldi r22,lo8(60)
	ldi r24,lo8(60)
	rcall make_strob
	rjmp .L78
.L100:
	ldi r20,lo8(1)
	ldi r22,lo8(60)
	ldi r24,lo8(60)
	rcall make_strob
	ldi r20,lo8(4)
	ldi r22,lo8(60)
	ldi r24,lo8(60)
	rcall make_strob
	rjmp .L78
.L101:
	ldi r20,lo8(2)
	ldi r22,lo8(60)
	ldi r24,lo8(60)
	rcall make_strob
	ldi r20,lo8(7)
	ldi r22,lo8(60)
	ldi r24,lo8(60)
	rcall make_strob
	rjmp .L78
.L119:
	cpi r29,lo8(8)
	breq .L104
	cpi r29,lo8(9)
	breq .L105
	cpi r29,lo8(7)
	brne .L78
	ldi r20,lo8(9)
	ldi r22,lo8(30)
	ldi r24,lo8(30)
	rcall make_strob
	rjmp .L78
.L104:
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
	rjmp .L78
.L105:
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
.L78:
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
	sts fav_on,__zero_reg__
.L121:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L122
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L123
	lds r22,mode
	lds r24,serie
	rcall make_serie
	rjmp .L121
.L123:
	lds r24,counter
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
	rjmp .L121
.L122:
	cpi r24,lo8(10)
	brne .L125
	rcall make_color
	rjmp .L121
.L125:
	cpi r24,lo8(11)
	brne .L126
	rcall make_color
	rjmp .L121
.L126:
	cpi r24,lo8(12)
	brne .L127
	rcall make_color
	rjmp .L121
.L127:
	ldi r24,0
	rcall make_color
	rjmp .L121
	.size	main, .-main
	.local	last_button_state.1643
	.comm	last_button_state.1643,1,1
	.local	hold.1641
	.comm	hold.1641,2,1
	.local	button_state.1642
	.comm	button_state.1642,1,1
.global	e_fav_on
	.section	.eeprom,"aw",@progbits
	.type	e_fav_on, @object
	.size	e_fav_on, 1
e_fav_on:
	.zero	1
.global	e_counter
	.type	e_counter, @object
	.size	e_counter, 1
e_counter:
	.zero	1
.global	s5
	.type	s5, @object
	.size	s5, 1
s5:
	.zero	1
.global	s4
	.type	s4, @object
	.size	s4, 1
s4:
	.zero	1
.global	s3
	.type	s3, @object
	.size	s3, 1
s3:
	.zero	1
.global	s2
	.type	s2, @object
	.size	s2, 1
s2:
	.zero	1
.global	s1
	.type	s1, @object
	.size	s1, 1
s1:
	.zero	1
.global	m5
	.type	m5, @object
	.size	m5, 1
m5:
	.zero	1
.global	m4
	.type	m4, @object
	.size	m4, 1
m4:
	.zero	1
.global	m3
	.type	m3, @object
	.size	m3, 1
m3:
	.zero	1
.global	m2
	.type	m2, @object
	.size	m2, 1
m2:
	.zero	1
.global	m1
	.type	m1, @object
	.size	m1, 1
m1:
	.zero	1
	.comm	counter,1,1
	.comm	series,6,1
	.comm	modes,6,1
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
	.comm	fav_on,1,1
	.comm	stat,1,1
	.comm	serie,1,1
	.comm	mode,1,1
	.ident	"GCC: (GNU) 4.8.1"
.global __do_clear_bss
