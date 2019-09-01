	.file	"csb-light-grb-2_2_elen_special.c"
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
	cpi r24,81
	cpc r25,__zero_reg__
	brlo .L9
	or r22,r23
	brne .L10
	lds r24,mode
	subi r24,lo8(-(1))
	cpi r24,lo8(6)
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
	sts button_state.1472,__zero_reg__
	sbrc r24,4
	rjmp .L12
	ldi r24,lo8(1)
	sts button_state.1472,r24
	lds r24,hold.1471
	lds r25,hold.1471+1
	adiw r24,1
	sts hold.1471+1,r25
	sts hold.1471,r24
	lds r22,last_button_state.1473
	cpi r22,lo8(1)
	brne .L17
.L15:
	ldi r23,0
	lds r24,hold.1471
	lds r25,hold.1471+1
	rcall process_button
	rjmp .L13
.L17:
	ldi r24,0
.L13:
	lds r25,button_state.1472
	cpse r25,__zero_reg__
	rjmp .L14
.L16:
	lds r18,last_button_state.1473
	cpse r18,__zero_reg__
	rjmp .L14
	sts hold.1471+1,__zero_reg__
	sts hold.1471,__zero_reg__
.L14:
	sts last_button_state.1473,r25
	ret
.L12:
	lds r22,last_button_state.1473
	tst r22
	breq .L15
	lds r25,button_state.1472
	ldi r24,0
	rjmp .L16
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
	cpi r25,lo8(-96)
	brne .L23
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
	tst r18
	breq .L29
	mov r29,r18
	mov r15,r20
	mov r16,r22
	mov r17,r24
	ldi r28,0
.L28:
	mov r20,r15
	mov r22,r16
	mov r24,r17
	rcall make_light
	cpi r24,lo8(1)
	breq .L27
	subi r28,lo8(-(1))
	cpse r28,r29
	rjmp .L28
	ldi r24,0
	rjmp .L27
.L29:
	ldi r24,0
.L27:
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
.L33:
	mov r18,r29
	ldi r20,0
	mov r22,r28
	ldi r24,lo8(-96)
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L32
	subi r28,lo8(-(1))
	cpi r28,lo8(-95)
	brne .L33
	ldi r28,lo8(-97)
.L34:
	mov r18,r29
	ldi r20,0
	ldi r22,lo8(-96)
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L32
	subi r28,1
	brcc .L34
	ldi r28,lo8(1)
.L35:
	mov r18,r29
	mov r20,r28
	ldi r22,lo8(-96)
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L32
	subi r28,lo8(-(1))
	cpi r28,lo8(-95)
	brne .L35
	ldi r28,lo8(-97)
.L36:
	mov r18,r29
	ldi r20,lo8(-96)
	mov r22,r28
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L32
	subi r28,1
	brcc .L36
	ldi r28,lo8(1)
.L37:
	mov r18,r29
	ldi r20,lo8(-96)
	ldi r22,0
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L32
	subi r28,lo8(-(1))
	cpi r28,lo8(-95)
	brne .L37
	ldi r28,lo8(-97)
.L38:
	mov r18,r29
	mov r20,r28
	ldi r22,0
	ldi r24,lo8(-96)
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L32
	subi r28,1
	brcc .L38
	ldi r24,0
.L32:
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
	rjmp .L46
	ldi r20,0
	ldi r22,0
	rjmp make_light
.L46:
	cpi r24,lo8(3)
	breq .L48
	brsh .L49
	cpi r24,lo8(1)
	breq .L50
	cpi r24,lo8(2)
	breq .L51
	rjmp .L47
.L49:
	cpi r24,lo8(4)
	breq .L52
	cpi r24,lo8(5)
	breq .L53
	rjmp .L47
.L50:
	ldi r20,lo8(-96)
	ldi r22,0
	ldi r24,0
	rjmp make_light
.L51:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(-96)
	rjmp make_light
.L48:
	ldi r20,0
	ldi r22,lo8(-96)
	ldi r24,0
	rjmp make_light
.L52:
	ldi r22,lo8(1)
	ldi r24,lo8(50)
	rcall long_color
	mov r25,r24
	cpi r24,lo8(1)
	breq .L54
	ldi r22,0
	ldi r24,lo8(50)
	rcall long_color
	mov r25,r24
	cpi r24,lo8(1)
	breq .L54
	ldi r22,lo8(2)
	ldi r24,lo8(50)
	rcall long_color
	mov r25,r24
	cpi r24,lo8(1)
	breq .L54
	ldi r22,0
	ldi r24,lo8(50)
	rcall long_color
	mov r25,r24
	cpi r24,lo8(1)
	breq .L54
	ldi r22,lo8(3)
	ldi r24,lo8(50)
	rcall long_color
	mov r25,r24
	cpi r24,lo8(1)
	breq .L54
	ldi r22,0
	ldi r24,lo8(50)
	rcall long_color
	ldi r25,lo8(1)
	cpi r24,lo8(1)
	breq .L54
	ldi r25,0
	rjmp .L54
.L53:
	ldi r24,lo8(50)
	rjmp make_rainbow
.L47:
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rjmp make_light
.L54:
	mov r24,r25
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
	rcall eeprom_read_byte
	mov r28,r24
	sts mode,r24
	ldi r24,lo8(e_serie)
	ldi r25,hi8(e_serie)
	rcall eeprom_read_byte
	sts serie,r24
	cpi r28,lo8(6)
	brlo .L57
	ldi r25,lo8(1)
	sts mode,r25
.L57:
	cpi r24,lo8(2)
	brlo .L58
	ldi r24,lo8(1)
	sts serie,r24
.L58:
	ldi r24,lo8(7)
	out 0x17,r24
	ldi r24,lo8(23)
	out 0x18,r24
.L59:
	lds r24,mode
	rcall make_color
	rjmp .L59
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
	mov r16,r24
	ldi r17,0
	cp r16,__zero_reg__
	cpc r17,__zero_reg__
	breq .L63
	mov r15,r22
	ldi r28,0
	ldi r29,0
.L62:
	mov r24,r15
	rcall make_color
	cpi r24,lo8(1)
	breq .L61
	adiw r28,1
	cp r28,r16
	cpc r29,r17
	brne .L62
	ldi r24,0
	rjmp .L61
.L63:
	ldi r24,0
.L61:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	ret
	.size	long_color, .-long_color
	.local	last_button_state.1473
	.comm	last_button_state.1473,1,1
	.local	hold.1471
	.comm	hold.1471,2,1
	.local	button_state.1472
	.comm	button_state.1472,1,1
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
	.ident	"GCC: (GNU) 4.9.2"
.global __do_clear_bss
