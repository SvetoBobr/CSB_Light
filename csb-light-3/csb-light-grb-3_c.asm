	.file	"csb-light-grb-3_c.c"
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
	ldi r24,lo8(3)
	sts mode,r24
.L2:
	lds r24,serie
	cpi r24,lo8(12)
	brlo .L3
	ldi r24,lo8(7)
	sts serie,r24
.L3:
	ldi r30,lo8(modes)
	ldi r31,hi8(modes)
	ldi r26,lo8(series)
	ldi r27,hi8(series)
	ldi r24,lo8(1)
.L6:
	ld r25,Z
	cpi r25,lo8(10)
	brlo .L4
	st Z,r24
.L4:
	ld r25,X
	cpi r25,lo8(12)
	brlo .L5
	st X,r24
.L5:
	adiw r30,1
	adiw r26,1
	ldi r25,hi8(modes+15)
	cpi r30,lo8(modes+15)
	cpc r31,r25
	brne .L6
	lds r24,counter
	cpi r24,lo8(16)
	brlo .L7
	sts counter,__zero_reg__
.L7:
	lds r24,counter
	lds r25,pointer
	cp r25,r24
	brlo .L8
	sts pointer,r24
.L8:
	lds r24,fav_on
	cpi r24,lo8(2)
	brlo .L1
	sts fav_on,__zero_reg__
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
	rcall eeprom_read_byte
	sts mode,r24
	ldi r24,lo8(e_serie)
	ldi r25,hi8(e_serie)
	rcall eeprom_read_byte
	sts serie,r24
	ldi r20,lo8(15)
	ldi r21,0
	ldi r22,lo8(fm)
	ldi r23,hi8(fm)
	ldi r24,lo8(modes)
	ldi r25,hi8(modes)
	rcall eeprom_read_block
	ldi r20,lo8(15)
	ldi r21,0
	ldi r22,lo8(sm)
	ldi r23,hi8(sm)
	ldi r24,lo8(series)
	ldi r25,hi8(series)
	rcall eeprom_read_block
	ldi r24,lo8(e_pointer)
	ldi r25,hi8(e_pointer)
	rcall eeprom_read_byte
	sts pointer,r24
	ldi r24,lo8(e_counter)
	ldi r25,hi8(e_counter)
	rcall eeprom_read_byte
	sts counter,r24
	ldi r24,lo8(e_fav_on)
	ldi r25,hi8(e_fav_on)
	rcall eeprom_read_byte
	sts fav_on,r24
	rjmp check_all
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
	rcall eeprom_write_byte
	lds r22,serie
	ldi r24,lo8(e_serie)
	ldi r25,hi8(e_serie)
	rcall eeprom_write_byte
	ldi r20,lo8(15)
	ldi r21,0
	ldi r22,lo8(fm)
	ldi r23,hi8(fm)
	ldi r24,lo8(modes)
	ldi r25,hi8(modes)
	rcall eeprom_write_block
	ldi r20,lo8(15)
	ldi r21,0
	ldi r22,lo8(sm)
	ldi r23,hi8(sm)
	ldi r24,lo8(series)
	ldi r25,hi8(series)
	rcall eeprom_write_block
	lds r22,pointer
	ldi r24,lo8(e_pointer)
	ldi r25,hi8(e_pointer)
	rcall eeprom_write_byte
	lds r22,counter
	ldi r24,lo8(e_counter)
	ldi r25,hi8(e_counter)
	rcall eeprom_write_byte
	lds r22,fav_on
	ldi r24,lo8(e_fav_on)
	ldi r25,hi8(e_fav_on)
	rjmp eeprom_write_byte
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
	or r22,r23
	breq .L16
.L19:
	ldi r24,0
	ret
.L16:
	sts pointer,__zero_reg__
	sts counter,__zero_reg__
	rjmp .L20
.L15:
	cpi r24,17
	ldi r18,39
	cpc r25,r18
	brlo .L18
	ldi r24,lo8(11)
	sts stat,r24
	or r22,r23
	brne .L19
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L20
	ldi r24,lo8(1)
	sts fav_on,r24
	sts pointer,r24
	rjmp .L34
.L20:
	sts fav_on,__zero_reg__
	rjmp .L34
.L18:
	cpi r24,-95
	ldi r18,15
	cpc r25,r18
	brlo .L22
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L19
	lds r24,counter
	cpi r24,lo8(15)
	brsh .L19
	ldi r25,lo8(10)
	sts stat,r25
	or r22,r23
	brne .L19
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
.L34:
	rcall check_all
	rjmp .L33
.L22:
	cpi r24,-23
	ldi r18,3
	cpc r25,r18
	brlo .L23
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L19
	ldi r24,lo8(13)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L19
	lds r24,serie
	subi r24,lo8(-(1))
	cpi r24,lo8(12)
	brlo .L30
	ldi r24,lo8(1)
.L30:
	sts serie,r24
	ldi r24,lo8(1)
	sts mode,r24
.L33:
	rcall store_data
	sts stat,__zero_reg__
	rjmp .L32
.L23:
	sbiw r24,51
	brsh .+2
	rjmp .L19
	or r22,r23
	breq .+2
	rjmp .L19
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L26
	lds r24,mode
	subi r24,lo8(-(1))
	cpi r24,lo8(10)
	brlo .L31
	ldi r24,lo8(1)
.L31:
	sts mode,r24
	rjmp .L28
.L26:
	lds r24,pointer
	subi r24,lo8(-(1))
	sts pointer,r24
	lds r25,counter
	cp r25,r24
	brsh .L28
	ldi r24,lo8(1)
	sts pointer,r24
.L28:
	rcall check_all
	rcall store_data
.L32:
	ldi r24,lo8(1)
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
	rjmp .L36
	sts button_state.1767,__zero_reg__
	rjmp .L37
.L36:
	ldi r24,lo8(1)
	sts button_state.1767,r24
.L37:
	lds r22,button_state.1767
	cpi r22,lo8(1)
	brne .L38
	lds r24,hold.1766
	lds r25,hold.1766+1
	adiw r24,1
	sts hold.1766+1,r25
	sts hold.1766,r24
.L38:
	lds r24,last_button_state.1768
	cpse r22,r24
	rjmp .L41
	ldi r23,0
	lds r24,hold.1766
	lds r25,hold.1766+1
	rcall process_button
	rjmp .L39
.L41:
	ldi r24,0
.L39:
	lds r25,button_state.1767
	cpse r25,__zero_reg__
	rjmp .L40
	lds r18,last_button_state.1768
	cpse r18,__zero_reg__
	rjmp .L40
	sts hold.1766+1,__zero_reg__
	sts hold.1766,__zero_reg__
.L40:
	sts last_button_state.1768,r25
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
	brsh .L47
	ldi r18,lo8(34)
	rjmp .L43
.L47:
	ldi r18,lo8(32)
.L43:
	cp r25,r22
	brsh .L44
	ori r18,lo8(1)
.L44:
	cp r25,r20
	brsh .L45
	ori r18,lo8(4)
.L45:
	out 0x18,r18
	subi r25,lo8(-(1))
	cpi r25,lo8(20)
	brne .L46
	rjmp check_button
	.size	make_light, .-make_light
.global	l_make_light
	.type	l_make_light, @function
l_make_light:
	push r13
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 7 */
.L__stack_usage = 7
	mov r15,r24
	mov r14,r22
	mov r13,r20
	movw r16,r18
	ldi r28,0
	ldi r29,0
.L50:
	cp r28,r16
	cpc r29,r17
	breq .L56
	mov r20,r13
	mov r22,r14
	mov r24,r15
	rcall make_light
	cpi r24,lo8(1)
	breq .L51
	adiw r28,1
	rjmp .L50
.L56:
	ldi r24,0
.L51:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	ret
	.size	l_make_light, .-l_make_light
.global	basic_pulse
	.type	basic_pulse, @function
basic_pulse:
	push r11
	push r12
	push r13
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 9 */
.L__stack_usage = 9
	mov r29,r24
	mov r17,r22
	mov r15,r20
	mov r11,r18
	ldi r28,lo8(1)
.L61:
	mov r20,r15
	and r20,r28
	or r20,r14
	mov r22,r17
	and r22,r28
	or r22,r16
	movw r18,r12
	mov r24,r29
	and r24,r28
	or r24,r11
	rcall l_make_light
	cpi r24,lo8(1)
	brne .L58
.L60:
	ldi r24,lo8(1)
	rjmp .L59
.L58:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L60
	subi r28,lo8(-(1))
	cpi r28,lo8(21)
	brne .L61
	ldi r28,lo8(20)
.L62:
	mov r20,r15
	and r20,r28
	or r20,r14
	mov r22,r17
	and r22,r28
	or r22,r16
	movw r18,r12
	mov r24,r29
	and r24,r28
	or r24,r11
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L60
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L60
	subi r28,lo8(-(-1))
	brne .L62
.L59:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	ret
	.size	basic_pulse, .-basic_pulse
.global	make_pulse
	.type	make_pulse, @function
make_pulse:
	push r12
	push r13
	push r14
	push r16
/* prologue: function */
/* frame size = 0 */
/* stack size = 4 */
.L__stack_usage = 4
	cpi r24,lo8(2)
	breq .L70
	cpi r24,lo8(3)
	breq .L71
	cpi r24,lo8(1)
	brne .L82
	ldi r30,lo8(-56)
	mov r12,r30
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,0
	rjmp .L86
.L70:
	ldi r23,lo8(-56)
	mov r12,r23
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,0
	rjmp .L88
.L71:
	ldi r22,lo8(-56)
	mov r12,r22
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,0
	rjmp .L90
.L82:
	cpi r24,lo8(5)
	breq .L75
	cpi r24,lo8(6)
	breq .L76
	cpi r24,lo8(4)
	brne .L83
	ldi r21,lo8(-56)
	mov r12,r21
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
.L90:
	ldi r22,lo8(-1)
	rjmp .L89
.L75:
	ldi r20,lo8(-56)
	mov r12,r20
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
	ldi r22,0
.L89:
	ldi r24,0
	rjmp .L87
.L76:
	ldi r19,lo8(-56)
	mov r12,r19
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
	rjmp .L86
.L83:
	cpi r24,lo8(8)
	breq .L78
	cpi r24,lo8(9)
	breq .L79
	cpi r24,lo8(7)
	brne .L84
	ldi r18,lo8(-56)
	mov r12,r18
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
.L88:
	ldi r22,lo8(-1)
	rjmp .L85
.L78:
	ldi r25,lo8(-56)
	mov r12,r25
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,lo8(-1)
	ldi r20,0
	ldi r22,lo8(7)
	rjmp .L85
.L79:
	ldi r24,lo8(-56)
	mov r12,r24
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,lo8(25)
	ldi r20,lo8(7)
.L86:
	ldi r22,0
.L85:
	ldi r24,lo8(-1)
.L87:
	rcall basic_pulse
	rjmp .L73
.L84:
	ldi r24,0
.L73:
/* epilogue start */
	pop r16
	pop r14
	pop r13
	pop r12
	ret
	.size	make_pulse, .-make_pulse
.global	make_grad
	.type	make_grad, @function
make_grad:
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 3 */
.L__stack_usage = 3
	movw r28,r24
	ldi r17,0
.L94:
	movw r18,r28
	ldi r20,0
	mov r22,r17
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L91
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L91
	subi r17,lo8(-(1))
	cpi r17,lo8(21)
	brne .L94
	ldi r17,lo8(19)
.L95:
	movw r18,r28
	ldi r20,0
	ldi r22,lo8(20)
	mov r24,r17
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L91
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L91
	subi r17,1
	brcc .L95
	ldi r17,lo8(1)
.L96:
	movw r18,r28
	mov r20,r17
	ldi r22,lo8(20)
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L91
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L91
	subi r17,lo8(-(1))
	cpi r17,lo8(21)
	brne .L96
	ldi r17,lo8(19)
.L97:
	movw r18,r28
	ldi r20,lo8(20)
	mov r22,r17
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L91
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L91
	subi r17,1
	brcc .L97
	ldi r17,lo8(1)
.L98:
	movw r18,r28
	ldi r20,lo8(20)
	ldi r22,0
	mov r24,r17
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L91
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L91
	subi r17,lo8(-(1))
	cpi r17,lo8(21)
	brne .L98
	ldi r17,lo8(19)
.L99:
	movw r18,r28
	mov r20,r17
	ldi r22,0
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L91
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L91
	subi r17,1
	brcc .L99
.L91:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	ret
	.size	make_grad, .-make_grad
.global	make_saw
	.type	make_saw, @function
make_saw:
	push r13
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 7 */
.L__stack_usage = 7
	mov r13,r24
	mov r14,r22
	mov r15,r20
	ldi r29,0
	ldi r17,0
	ldi r16,0
	ldi r28,lo8(20)
.L123:
	ldi r18,lo8(5)
	ldi r19,0
	mov r20,r29
	mov r22,r17
	mov r24,r16
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L122
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L124
	subi r28,lo8(-(-1))
	add r16,r13
	add r17,r14
	add r29,r15
	cpse r28,__zero_reg__
	rjmp .L123
	rjmp .L122
.L124:
	ldi r24,lo8(1)
.L122:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	ret
	.size	make_saw, .-make_saw
.global	make_saw_rainbow
	.type	make_saw_rainbow, @function
make_saw_rainbow:
	push r28
/* prologue: function */
/* frame size = 0 */
/* stack size = 1 */
.L__stack_usage = 1
	ldi r28,lo8(20)
.L133:
	ldi r18,lo8(2)
	ldi r19,0
	mov r20,r28
	mov r22,r28
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L129
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L129
	subi r28,lo8(-(-1))
	brne .L133
.L134:
	ldi r18,lo8(2)
	ldi r19,0
	ldi r20,0
	mov r22,r28
	ldi r24,lo8(20)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L129
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L129
	subi r28,lo8(-(1))
	cpi r28,lo8(20)
	brne .L134
.L135:
	ldi r18,lo8(2)
	ldi r19,0
	ldi r20,0
	ldi r22,lo8(20)
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L129
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L129
	subi r28,lo8(-(-1))
	brne .L135
.L136:
	ldi r18,lo8(2)
	ldi r19,0
	mov r20,r28
	ldi r22,lo8(20)
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L129
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L129
	subi r28,lo8(-(1))
	cpi r28,lo8(20)
	brne .L136
.L137:
	ldi r18,lo8(2)
	ldi r19,0
	ldi r20,lo8(20)
	mov r22,r28
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L129
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L129
	subi r28,lo8(-(-1))
	brne .L137
	ldi r28,lo8(20)
.L138:
	ldi r18,lo8(2)
	ldi r19,0
	mov r20,r28
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L129
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L129
	subi r28,lo8(-(-1))
	brne .L138
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
/* epilogue start */
	pop r28
	rjmp l_make_light
.L129:
/* epilogue start */
	pop r28
	ret
	.size	make_saw_rainbow, .-make_saw_rainbow
.global	make_mix_2
	.type	make_mix_2, @function
make_mix_2:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(3)
	breq .L176
	brsh .L163
	cpi r24,lo8(1)
	breq .L164
	cpi r24,lo8(2)
	brne .L161
	ldi r20,0
	ldi r22,lo8(1)
	rjmp .L202
.L163:
	cpi r24,lo8(4)
	breq .L166
	cpi r24,lo8(5)
	breq .L167
	rjmp .L161
.L164:
	ldi r20,0
	rjmp .L204
.L173:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
.L200:
	rcall make_saw
	cpi r24,lo8(1)
	brne .+2
	rjmp .L160
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L160
.L176:
	ldi r20,lo8(1)
	ldi r22,0
.L202:
	ldi r24,0
.L201:
	rjmp make_saw
.L166:
	ldi r20,lo8(1)
	ldi r22,lo8(1)
.L203:
	ldi r24,lo8(1)
	rjmp .L201
.L167:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	brne .+2
	rjmp .L160
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L160
	ldi r20,0
	ldi r22,lo8(1)
	rjmp .L201
.L161:
	cpi r24,lo8(7)
	breq .L171
	brsh .L172
	cpi r24,lo8(6)
	breq .L173
	ret
.L172:
	cpi r24,lo8(8)
	breq .L174
	cpi r24,lo8(9)
	breq .L175
	ret
.L171:
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,0
	rjmp .L200
.L174:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L160
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L160
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L160
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L160
	ldi r20,0
	ldi r22,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L160
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L160
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L160
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L160
	ldi r20,lo8(1)
	ldi r22,0
	rcall make_saw
	cpi r24,lo8(1)
	breq .L160
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L160
	ldi r20,lo8(1)
.L204:
	ldi r22,0
	rjmp .L203
.L175:
	rjmp make_saw_rainbow
.L160:
	ret
	.size	make_mix_2, .-make_mix_2
.global	make_light_color
	.type	make_light_color, @function
make_light_color:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(2)
	breq .L207
	cpi r24,lo8(3)
	breq .L208
	cpi r24,lo8(1)
	brne .L218
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	rjmp .L225
.L207:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	rjmp .L224
.L208:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	rjmp .L223
.L218:
	cpi r24,lo8(5)
	breq .L211
	cpi r24,lo8(6)
	breq .L212
	cpi r24,lo8(4)
	brne .L219
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,0
	rjmp .L227
.L211:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(1)
.L227:
	ldi r22,lo8(1)
	rjmp .L226
.L212:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(1)
.L225:
	ldi r22,0
.L226:
	ldi r24,0
	rjmp .L221
.L219:
	cpi r24,lo8(8)
	breq .L215
	cpi r24,lo8(9)
	breq .L216
	cpi r24,lo8(7)
	brne .L220
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	ldi r20,lo8(1)
.L224:
	ldi r22,0
	rjmp .L222
.L215:
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
	ldi r24,0
	rcall l_make_light
.L216:
	ldi r20,lo8(1)
.L223:
	ldi r22,lo8(1)
.L222:
	ldi r24,lo8(1)
.L221:
	rjmp make_light
.L220:
	ldi r24,0
	ret
	.size	make_light_color, .-make_light_color
.global	make_color
	.type	make_color, @function
make_color:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(2)
	breq .L230
	cpi r24,lo8(3)
	breq .L231
	cpi r24,lo8(1)
	brne .L248
	ldi r20,0
	rjmp .L257
.L230:
	ldi r20,0
.L255:
	ldi r22,lo8(5)
.L252:
	ldi r24,lo8(20)
	rjmp .L251
.L231:
	ldi r20,0
	rjmp .L258
.L248:
	cpi r24,lo8(5)
	breq .L234
	cpi r24,lo8(6)
	breq .L235
	cpi r24,lo8(4)
	brne .L249
	ldi r20,0
	ldi r22,lo8(20)
	rjmp .L253
.L234:
	ldi r20,lo8(20)
	ldi r22,lo8(5)
	rjmp .L253
.L235:
	ldi r20,lo8(20)
	rjmp .L254
.L249:
	cpi r24,lo8(8)
	breq .L238
	cpi r24,lo8(9)
	breq .L239
	cpi r24,lo8(7)
	brne .L250
	ldi r20,lo8(20)
.L257:
	ldi r22,0
	rjmp .L252
.L238:
	ldi r20,lo8(5)
	rjmp .L255
.L239:
	ldi r20,lo8(20)
.L258:
	ldi r22,lo8(20)
	rjmp .L252
.L250:
	cpi r24,lo8(11)
	breq .L242
	brsh .L243
	cpi r24,lo8(10)
	brne .L241
	ldi r20,0
	ldi r22,lo8(3)
	rjmp .L253
.L243:
	cpi r24,lo8(12)
	breq .L245
	cpi r24,lo8(13)
	brne .L241
	ldi r20,lo8(3)
	rjmp .L254
.L242:
	ldi r20,0
	ldi r22,0
	rjmp .L256
.L245:
	ldi r20,lo8(3)
	ldi r22,lo8(3)
.L256:
	ldi r24,lo8(3)
	rjmp .L251
.L254:
	ldi r22,0
.L253:
	ldi r24,0
	rjmp .L251
.L241:
	cpse r24,__zero_reg__
	rjmp .L247
	ldi r20,0
	ldi r22,0
.L251:
	rjmp make_light
.L247:
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
	movw r16,r24
	mov r15,r22
	ldi r28,0
	ldi r29,0
.L260:
	cp r28,r16
	cpc r29,r17
	breq .L266
	mov r24,r15
	rcall make_color
	cpi r24,lo8(1)
	breq .L261
	adiw r28,1
	rjmp .L260
.L266:
	ldi r24,0
.L261:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	ret
	.size	long_color, .-long_color
.global	make_grad_2
	.type	make_grad_2, @function
make_grad_2:
	push r16
	push r17
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 4 */
.L__stack_usage = 4
	movw r16,r24
	ldi r28,lo8(1)
	ldi r29,0
.L269:
	movw r22,r28
	movw r24,r16
	rcall long_color
	cpi r24,lo8(1)
	breq .L267
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L267
	adiw r28,1
	cpi r28,10
	cpc r29,__zero_reg__
	brne .L269
.L267:
/* epilogue start */
	pop r29
	pop r28
	pop r17
	pop r16
	ret
	.size	make_grad_2, .-make_grad_2
.global	grad_serie
	.type	grad_serie, @function
grad_serie:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	cpi r24,lo8(3)
	breq .L276
	brsh .L277
	cpi r24,lo8(1)
	breq .L278
	cpi r24,lo8(2)
	brne .L275
	ldi r24,lo8(50)
	ldi r25,0
	rjmp .L293
.L277:
	cpi r24,lo8(4)
	breq .L280
	cpi r24,lo8(5)
	brne .L275
	ldi r24,lo8(-36)
	ldi r25,lo8(5)
	rjmp .L293
.L278:
	ldi r24,lo8(10)
	ldi r25,0
	rjmp .L293
.L276:
	ldi r24,lo8(-106)
	ldi r25,0
.L293:
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad
.L280:
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
	rjmp .L293
.L275:
	cpi r24,lo8(7)
	breq .L283
	brsh .L284
	cpi r24,lo8(6)
	brne .L274
	ldi r24,lo8(100)
	ldi r25,0
	rjmp .L294
.L284:
	cpi r24,lo8(8)
	breq .L286
	cpi r24,lo8(9)
	brne .L274
	ldi r28,lo8(1)
	ldi r29,0
	rjmp .L288
.L283:
	ldi r24,lo8(-112)
	ldi r25,lo8(1)
	rjmp .L294
.L286:
	ldi r24,lo8(-80)
	ldi r25,lo8(4)
.L294:
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad_2
.L295:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L274
	adiw r28,1
	cpi r28,9
	cpc r29,__zero_reg__
	breq .L274
.L288:
	movw r22,r28
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .L295
.L274:
/* epilogue start */
	pop r29
	pop r28
	ret
	.size	grad_serie, .-grad_serie
.global	make_mix
	.type	make_mix, @function
make_mix:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(3)
	breq .L298
	brsh .L299
	cpi r24,lo8(1)
	breq .L300
	cpi r24,lo8(2)
	breq .L301
	rjmp .L297
.L299:
	cpi r24,lo8(4)
	breq .L302
	cpi r24,lo8(5)
	brne .+2
	rjmp .L303
	rjmp .L297
.L300:
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L296
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L296
	ldi r22,lo8(4)
	ldi r23,0
	rjmp .L371
.L301:
	ldi r22,lo8(4)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L296
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L296
	ldi r22,lo8(6)
	ldi r23,0
.L371:
	ldi r24,lo8(60)
	ldi r25,0
	rjmp .L369
.L298:
	ldi r22,lo8(6)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L296
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L296
	ldi r22,lo8(1)
	ldi r23,0
	rjmp .L371
.L302:
	ldi r22,lo8(2)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L296
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L296
	ldi r22,lo8(5)
	ldi r23,0
	rjmp .L371
.L303:
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L296
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L296
	ldi r22,lo8(2)
	ldi r23,0
	rjmp .L371
.L297:
	cpi r24,lo8(7)
	breq .L307
	brsh .L308
	cpi r24,lo8(6)
	breq .L309
	ret
.L308:
	cpi r24,lo8(8)
	brne .+2
	rjmp .L310
	cpi r24,lo8(9)
	brne .+2
	rjmp .L311
	ret
.L309:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L296
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L296
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L296
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L296
	ldi r22,lo8(4)
	ldi r23,0
	rjmp .L365
.L307:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L296
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L296
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L296
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L296
	ldi r22,lo8(6)
	ldi r23,0
.L365:
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L296
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L296
	ldi r22,lo8(1)
	ldi r23,0
	rjmp .L370
.L310:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L296
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L296
	ldi r22,lo8(9)
	ldi r23,0
	rjmp .L368
.L311:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L296
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L296
	ldi r22,lo8(4)
	ldi r23,0
.L368:
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L296
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L296
	ldi r22,lo8(6)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L296
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L296
	ldi r22,lo8(4)
	ldi r23,0
.L370:
	ldi r24,lo8(45)
	ldi r25,0
.L369:
	rjmp long_color
.L296:
	ret
	.size	make_mix, .-make_mix
.global	make_strob
	.type	make_strob, @function
make_strob:
	push r28
	push r29
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	movw r28,r22
	mov r22,r20
	ldi r23,0
	rcall long_color
	cpi r24,lo8(1)
	brne .L373
.L375:
	ldi r24,lo8(1)
	rjmp .L374
.L373:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L375
	ldi r22,0
	ldi r23,0
	movw r24,r28
	rcall long_color
	cpi r24,lo8(1)
	breq .L375
	ldi r24,lo8(1)
	lds r25,stat
	cpse r25,__zero_reg__
	rjmp .L374
	ldi r24,0
.L374:
/* epilogue start */
	pop r29
	pop r28
	ret
	.size	make_strob, .-make_strob
.global	make_complex_strob
	.type	make_complex_strob, @function
make_complex_strob:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(3)
	breq .L382
	brsh .L383
	cpi r24,lo8(1)
	breq .L384
	cpi r24,lo8(2)
	brne .+2
	rjmp .L442
	rjmp .L381
.L383:
	cpi r24,lo8(4)
	breq .L386
	cpi r24,lo8(5)
	breq .L387
	rjmp .L381
.L384:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L380
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L380
	ldi r20,lo8(4)
	rjmp .L445
.L382:
	ldi r20,lo8(6)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L380
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L380
	ldi r20,lo8(1)
	rjmp .L445
.L386:
	ldi r20,lo8(2)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L380
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L380
	ldi r20,lo8(5)
	rjmp .L445
.L387:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L380
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L380
.L442:
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L380
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L380
	ldi r20,lo8(6)
	rjmp .L445
.L381:
	cpi r24,lo8(7)
	breq .L392
	brsh .L393
	cpi r24,lo8(6)
	breq .L394
	ret
.L393:
	cpi r24,lo8(8)
	brne .+2
	rjmp .L444
	cpi r24,lo8(9)
	breq .L396
	ret
.L394:
	ldi r20,lo8(1)
	rjmp .L443
.L392:
	ldi r20,lo8(4)
.L443:
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L380
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L380
	ldi r20,lo8(9)
.L445:
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L396:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L380
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L380
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L380
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L380
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L380
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L380
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L380
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L380
.L444:
	ldi r20,lo8(6)
	rjmp .L443
.L380:
	ret
	.size	make_complex_strob, .-make_complex_strob
.global	make_serie
	.type	make_serie, @function
make_serie:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	mov r25,r24
	mov r24,r22
	cpi r25,lo8(3)
	breq .L448
	brsh .L449
	cpi r25,lo8(1)
	breq .L450
	cpi r25,lo8(2)
	brne .L447
	mov r20,r22
	ldi r22,lo8(20)
	ldi r23,0
	ldi r24,lo8(20)
	ldi r25,0
	rjmp .L462
.L449:
	cpi r25,lo8(4)
	breq .L452
	cpi r25,lo8(5)
	brne .L447
	mov r20,r22
	ldi r22,lo8(-12)
	ldi r23,lo8(1)
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
	rjmp .L462
.L450:
	rjmp make_color
.L448:
	mov r20,r22
	ldi r22,lo8(50)
	ldi r23,0
	ldi r24,lo8(50)
	ldi r25,0
.L462:
	rjmp make_strob
.L452:
	mov r20,r22
	ldi r22,lo8(100)
	ldi r23,0
	ldi r24,lo8(100)
	ldi r25,0
	rjmp .L462
.L447:
	cpi r25,lo8(8)
	breq .L455
	brsh .L456
	cpi r25,lo8(6)
	breq .L457
	cpi r25,lo8(7)
	breq .L458
	ret
.L456:
	cpi r25,lo8(10)
	breq .L459
	brlo .L460
	cpi r25,lo8(11)
	breq .L461
	ret
.L457:
	rjmp make_pulse
.L458:
	rjmp grad_serie
.L455:
	rjmp make_complex_strob
.L460:
	rjmp make_mix
.L459:
	rjmp make_mix_2
.L461:
	rjmp make_light_color
	.size	make_serie, .-make_serie
	.section	.text.startup,"ax",@progbits
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
.L464:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L465
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L466
	lds r22,mode
	lds r24,serie
	rjmp .L477
.L466:
	lds r24,counter
	tst r24
	breq .L468
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
.L477:
	rcall make_serie
	rjmp .L464
.L468:
	ldi r24,0
	rjmp .L476
.L465:
	cpi r24,lo8(10)
	breq .L476
	cpi r24,lo8(11)
	breq .L476
	cpi r24,lo8(12)
	breq .L476
	cpi r24,lo8(13)
	brne .L472
.L476:
	rcall make_color
	rjmp .L464
.L472:
	cpi r24,lo8(14)
	brne .L468
	ldi r20,lo8(1)
	ldi r22,lo8(100)
	ldi r23,0
	ldi r24,lo8(50)
	ldi r25,0
	rcall make_strob
	rjmp .L464
	.size	main, .-main
	.local	last_button_state.1768
	.comm	last_button_state.1768,1,1
	.local	hold.1766
	.comm	hold.1766,2,1
	.local	button_state.1767
	.comm	button_state.1767,1,1
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
	.size	sm, 16
sm:
	.zero	16
.global	fm
	.type	fm, @object
	.size	fm, 16
fm:
	.zero	16
	.comm	fav_on,1,1
	.comm	pointer,1,1
	.comm	counter,1,1
	.comm	series,16,1
	.comm	modes,16,1
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
	.ident	"GCC: (GNU) 5.4.0"
.global __do_clear_bss
