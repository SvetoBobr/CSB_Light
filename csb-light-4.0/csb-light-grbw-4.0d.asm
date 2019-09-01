	.file	"csb-light-grbw-4.0d.c"
__SP_H__ = 0x3e
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
.global	check_all
	.type	check_all, @function
check_all:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r24,mode
	cpi r24,lo8(10)
	brlo .L5
	ldi r24,lo8(1)
	sts mode,r24
.L5:
	lds r24,serie
	cpi r24,lo8(12)
	brlo .L6
	ldi r24,lo8(1)
	sts serie,r24
.L6:
	lds r24,brightness
	cpi r24,lo8(3)
	brlo .L7
	sts brightness,__zero_reg__
.L7:
	lds r24,wmode
	cpi r24,lo8(4)
	brlo .L8
	sts wmode,__zero_reg__
.L8:
	ldi r30,lo8(modes)
	ldi r31,hi8(modes)
	ldi r26,lo8(series)
	ldi r27,hi8(series)
	ldi r24,lo8(1)
.L11:
	ld r25,Z
	cpi r25,lo8(10)
	brlo .L9
	st Z,r24
.L9:
	ld r25,X
	cpi r25,lo8(12)
	brlo .L10
	st X,r24
.L10:
	adiw r30,1
	adiw r26,1
	ldi r25,hi8(modes+15)
	cpi r30,lo8(modes+15)
	cpc r31,r25
	brne .L11
	lds r24,counter
	cpi r24,lo8(16)
	brlo .L12
	sts counter,__zero_reg__
.L12:
	lds r24,counter
	lds r25,pointer
	cp r25,r24
	brlo .L13
	sts pointer,r24
.L13:
	lds r24,fav_on
	cpi r24,lo8(2)
	brlo .L4
	sts fav_on,__zero_reg__
.L4:
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
	ldi r24,lo8(e_power)
	ldi r25,hi8(e_power)
	rcall eeprom_read_byte
	sts power,r24
	ldi r24,lo8(e_brightness)
	ldi r25,hi8(e_brightness)
	rcall eeprom_read_byte
	sts brightness,r24
	ldi r24,lo8(e_wmode)
	ldi r25,hi8(e_wmode)
	rcall eeprom_read_byte
	sts wmode,r24
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
	rcall eeprom_write_byte
	lds r22,power
	ldi r24,lo8(e_power)
	ldi r25,hi8(e_power)
	rcall eeprom_write_byte
	lds r22,brightness
	ldi r24,lo8(e_brightness)
	ldi r25,hi8(e_brightness)
	rcall eeprom_write_byte
	lds r22,wmode
	ldi r24,lo8(e_wmode)
	ldi r25,hi8(e_wmode)
	rjmp eeprom_write_byte
	.size	store_data, .-store_data
.global	init_io
	.type	init_io, @function
init_io:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	ldi r24,lo8(15)
	out 0x17,r24
	ldi r24,lo8(31)
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
	cpi r24,57
	ldi r18,74
	cpc r25,r18
	brlo .L20
	ldi r24,lo8(12)
	sts stat,r24
	or r22,r23
	breq .L21
.L24:
	ldi r24,0
	ret
.L21:
	sts pointer,__zero_reg__
	sts counter,__zero_reg__
	rjmp .L25
.L20:
	cpi r24,-127
	ldi r18,62
	cpc r25,r18
	brlo .L23
	ldi r24,lo8(11)
	sts stat,r24
	or r22,r23
	brne .L24
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L25
	ldi r24,lo8(1)
	sts fav_on,r24
	sts pointer,r24
	rjmp .L46
.L25:
	sts fav_on,__zero_reg__
	rjmp .L46
.L23:
	cpi r24,-31
	ldi r18,46
	cpc r25,r18
	brlo .L27
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L24
	lds r24,counter
	cpi r24,lo8(15)
	brsh .L24
	ldi r25,lo8(10)
	sts stat,r25
	or r22,r23
	brne .L24
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
.L46:
	rcall check_all
	rjmp .L45
.L27:
	cpi r24,41
	ldi r18,35
	cpc r25,r18
	brlo .L28
	ldi r24,lo8(17)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L24
	lds r24,wmode
	subi r24,lo8(-(1))
	cpi r24,lo8(4)
	brsh .L29
	sts wmode,r24
	rjmp .L45
.L29:
	sts wmode,__zero_reg__
	rjmp .L45
.L28:
	cpi r24,113
	ldi r18,23
	cpc r25,r18
	brlo .L31
	ldi r24,lo8(16)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L24
	lds r24,brightness
	subi r24,lo8(-(1))
	cpi r24,lo8(3)
	brsh .L32
	sts brightness,r24
	rjmp .L45
.L32:
	sts brightness,__zero_reg__
	rjmp .L45
.L31:
	cpi r24,-71
	ldi r18,11
	cpc r25,r18
	brlo .L34
	ldi r24,lo8(14)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L24
	sts power,__zero_reg__
	rjmp .L45
.L34:
	cpi r24,-23
	ldi r18,3
	cpc r25,r18
	brlo .L35
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L24
	ldi r24,lo8(13)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L24
	lds r24,serie
	subi r24,lo8(-(1))
	cpi r24,lo8(12)
	brlo .L42
	ldi r24,lo8(1)
.L42:
	sts serie,r24
	ldi r24,lo8(1)
	sts mode,r24
.L45:
	rcall store_data
	sts stat,__zero_reg__
	rjmp .L44
.L35:
	cpi r24,101
	cpc r25,__zero_reg__
	brsh .+2
	rjmp .L24
	or r22,r23
	breq .+2
	rjmp .L24
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L38
	lds r24,mode
	subi r24,lo8(-(1))
	cpi r24,lo8(10)
	brlo .L43
	ldi r24,lo8(1)
.L43:
	sts mode,r24
	rjmp .L40
.L38:
	lds r24,pointer
	subi r24,lo8(-(1))
	sts pointer,r24
	lds r25,counter
	cp r25,r24
	brsh .L40
	ldi r24,lo8(1)
	sts pointer,r24
.L40:
	rcall check_all
	rcall store_data
.L44:
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
	rjmp .L48
	sts button_state.1932,__zero_reg__
	rjmp .L49
.L48:
	ldi r24,lo8(1)
	sts button_state.1932,r24
.L49:
	lds r22,button_state.1932
	cpi r22,lo8(1)
	brne .L50
	lds r24,hold.1931
	lds r25,hold.1931+1
	adiw r24,1
	sts hold.1931+1,r25
	sts hold.1931,r24
.L50:
	lds r24,last_button_state.1933
	cpse r22,r24
	rjmp .L53
	ldi r23,0
	lds r24,hold.1931
	lds r25,hold.1931+1
	rcall process_button
	rjmp .L51
.L53:
	ldi r24,0
.L51:
	lds r25,button_state.1932
	cpse r25,__zero_reg__
	rjmp .L52
	lds r18,last_button_state.1933
	cpse r18,__zero_reg__
	rjmp .L52
	sts hold.1931+1,__zero_reg__
	sts hold.1931,__zero_reg__
.L52:
	sts last_button_state.1933,r25
	ret
	.size	check_button, .-check_button
.global	make_light
	.type	make_light, @function
make_light:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	lds r25,wmode
	cpi r25,lo8(1)
	breq .L61
	brlo .L60
	cpi r25,lo8(2)
	breq .L58
	cpi r25,lo8(3)
	breq .L59
	rjmp .L55
.L58:
	mov r18,r22
	ldi r19,0
	add r18,r24
	adc r19,__zero_reg__
	add r18,r20
	adc r19,__zero_reg__
	or r18,r19
	breq .L60
.L61:
	ldi r25,lo8(-116)
	sts w,r25
	rjmp .L55
.L59:
	mov r18,r22
	ldi r19,0
	add r18,r24
	adc r19,__zero_reg__
	add r18,r20
	adc r19,__zero_reg__
	or r18,r19
	breq .L61
.L60:
	sts w,__zero_reg__
.L55:
	lds r19,w
	lds r25,button_state
	cpse r25,__zero_reg__
	rjmp .L62
	lds r25,brightness
	cpi r25,lo8(1)
	brne .L63
	lsr r24
	lsr r24
	lsr r22
	lsr r22
	lsr r20
	lsr r20
	lsr r19
	lsr r19
	rjmp .L62
.L63:
	cpi r25,lo8(2)
	brne .L62
	swap r24
	andi r24,lo8(15)
	swap r22
	andi r22,lo8(15)
	swap r20
	andi r20,lo8(15)
	swap r19
	andi r19,lo8(15)
.L62:
	ldi r18,0
.L68:
	cp r18,r24
	brsh .L69
	ldi r25,lo8(18)
	rjmp .L64
.L69:
	ldi r25,lo8(16)
.L64:
	cp r18,r22
	brsh .L65
	ori r25,lo8(1)
.L65:
	cp r18,r20
	brsh .L66
	ori r25,lo8(4)
.L66:
	cp r18,r19
	brsh .L67
	ori r25,lo8(8)
.L67:
	out 0x18,r25
	subi r18,lo8(-(1))
	cpi r18,lo8(-116)
	brne .L68
	rjmp check_button
	.size	make_light, .-make_light
.global	make_light_color
	.type	make_light_color, @function
make_light_color:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(2)
	breq .L79
	cpi r24,lo8(3)
	breq .L80
	cpi r24,lo8(1)
	brne .L90
	ldi r20,0
	rjmp .L97
.L79:
	ldi r20,0
	rjmp .L96
.L80:
	ldi r20,0
	rjmp .L95
.L90:
	cpi r24,lo8(5)
	breq .L83
	cpi r24,lo8(6)
	breq .L84
	cpi r24,lo8(4)
	brne .L91
	ldi r20,0
	rjmp .L99
.L83:
	ldi r20,lo8(1)
.L99:
	ldi r22,lo8(1)
	rjmp .L98
.L84:
	ldi r20,lo8(1)
.L97:
	ldi r22,0
.L98:
	ldi r24,0
	rjmp .L93
.L91:
	cpi r24,lo8(8)
	breq .L88
	cpi r24,lo8(9)
	breq .L88
	cpi r24,lo8(7)
	brne .L92
	ldi r20,lo8(1)
.L96:
	ldi r22,0
	rjmp .L94
.L88:
	ldi r20,lo8(1)
.L95:
	ldi r22,lo8(1)
.L94:
	ldi r24,lo8(1)
.L93:
	rjmp make_light
.L92:
	ldi r24,0
	ret
	.size	make_light_color, .-make_light_color
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
.L101:
	cp r28,r16
	cpc r29,r17
	breq .L107
	mov r20,r13
	mov r22,r14
	mov r24,r15
	rcall make_light
	cpi r24,lo8(1)
	breq .L102
	adiw r28,1
	rjmp .L101
.L107:
	ldi r24,0
.L102:
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
.L112:
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
	brne .L109
.L111:
	ldi r24,lo8(1)
	rjmp .L110
.L109:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L111
	subi r28,lo8(-(1))
	cpi r28,lo8(-115)
	brne .L112
	ldi r28,lo8(-116)
.L113:
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
	breq .L111
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L111
	subi r28,lo8(-(-1))
	brne .L113
.L110:
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
	breq .L121
	cpi r24,lo8(3)
	breq .L122
	cpi r24,lo8(1)
	brne .L133
	ldi r30,lo8(30)
	mov r12,r30
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,0
	rjmp .L137
.L121:
	ldi r23,lo8(30)
	mov r12,r23
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,0
	rjmp .L139
.L122:
	ldi r22,lo8(30)
	mov r12,r22
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,0
	rjmp .L141
.L133:
	cpi r24,lo8(5)
	breq .L126
	cpi r24,lo8(6)
	breq .L127
	cpi r24,lo8(4)
	brne .L134
	ldi r21,lo8(30)
	mov r12,r21
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
.L141:
	ldi r22,lo8(-1)
	rjmp .L140
.L126:
	ldi r20,lo8(30)
	mov r12,r20
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
	ldi r22,0
.L140:
	ldi r24,0
	rjmp .L138
.L127:
	ldi r19,lo8(30)
	mov r12,r19
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
	rjmp .L137
.L134:
	cpi r24,lo8(8)
	breq .L129
	cpi r24,lo8(9)
	breq .L130
	cpi r24,lo8(7)
	brne .L135
	ldi r18,lo8(30)
	mov r12,r18
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
.L139:
	ldi r22,lo8(-1)
	rjmp .L136
.L129:
	ldi r25,lo8(30)
	mov r12,r25
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,lo8(-1)
	ldi r20,0
	ldi r22,lo8(63)
	rjmp .L136
.L130:
	ldi r24,lo8(30)
	mov r12,r24
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,lo8(25)
	ldi r20,lo8(63)
.L137:
	ldi r22,0
.L136:
	ldi r24,lo8(-1)
.L138:
	rcall basic_pulse
	rjmp .L124
.L135:
	ldi r24,0
.L124:
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
.L145:
	movw r18,r28
	ldi r20,0
	mov r22,r17
	ldi r24,lo8(-116)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L142
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L142
	subi r17,lo8(-(1))
	cpi r17,lo8(-115)
	brne .L145
	ldi r17,lo8(-117)
.L146:
	movw r18,r28
	ldi r20,0
	ldi r22,lo8(-116)
	mov r24,r17
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L142
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L142
	subi r17,1
	brcc .L146
	ldi r17,lo8(1)
.L147:
	movw r18,r28
	mov r20,r17
	ldi r22,lo8(-116)
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L142
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L142
	subi r17,lo8(-(1))
	cpi r17,lo8(-115)
	brne .L147
	ldi r17,lo8(-117)
.L148:
	movw r18,r28
	ldi r20,lo8(-116)
	mov r22,r17
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L142
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L142
	subi r17,1
	brcc .L148
	ldi r17,lo8(1)
.L149:
	movw r18,r28
	ldi r20,lo8(-116)
	ldi r22,0
	mov r24,r17
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L142
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L142
	subi r17,lo8(-(1))
	cpi r17,lo8(-115)
	brne .L149
	ldi r17,lo8(-117)
.L150:
	movw r18,r28
	mov r20,r17
	ldi r22,0
	ldi r24,lo8(-116)
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L142
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L142
	subi r17,1
	brcc .L150
.L142:
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
	ldi r28,lo8(-116)
.L174:
	ldi r18,lo8(5)
	ldi r19,0
	mov r20,r29
	mov r22,r17
	mov r24,r16
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L173
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L175
	subi r28,lo8(-(-1))
	add r16,r13
	add r17,r14
	add r29,r15
	cpse r28,__zero_reg__
	rjmp .L174
	rjmp .L173
.L175:
	ldi r24,lo8(1)
.L173:
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
	ldi r28,lo8(-116)
.L184:
	ldi r18,lo8(2)
	ldi r19,0
	mov r20,r28
	mov r22,r28
	ldi r24,lo8(-116)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L180
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L180
	subi r28,lo8(-(-1))
	brne .L184
.L185:
	ldi r18,lo8(2)
	ldi r19,0
	ldi r20,0
	mov r22,r28
	ldi r24,lo8(-116)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L180
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L180
	subi r28,lo8(-(1))
	cpi r28,lo8(-116)
	brne .L185
.L186:
	ldi r18,lo8(2)
	ldi r19,0
	ldi r20,0
	ldi r22,lo8(-116)
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L180
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L180
	subi r28,lo8(-(-1))
	brne .L186
.L187:
	ldi r18,lo8(2)
	ldi r19,0
	mov r20,r28
	ldi r22,lo8(-116)
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L180
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L180
	subi r28,lo8(-(1))
	cpi r28,lo8(-116)
	brne .L187
.L188:
	ldi r18,lo8(2)
	ldi r19,0
	ldi r20,lo8(-116)
	mov r22,r28
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L180
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L180
	subi r28,lo8(-(-1))
	brne .L188
	ldi r28,lo8(-116)
.L189:
	ldi r18,lo8(2)
	ldi r19,0
	mov r20,r28
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L180
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L180
	subi r28,lo8(-(-1))
	brne .L189
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
/* epilogue start */
	pop r28
	rjmp l_make_light
.L180:
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
	breq .L227
	brsh .L214
	cpi r24,lo8(1)
	breq .L215
	cpi r24,lo8(2)
	brne .L212
	ldi r20,0
	ldi r22,lo8(1)
	rjmp .L253
.L214:
	cpi r24,lo8(4)
	breq .L217
	cpi r24,lo8(5)
	breq .L218
	rjmp .L212
.L215:
	ldi r20,0
	rjmp .L255
.L224:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
.L251:
	rcall make_saw
	cpi r24,lo8(1)
	brne .+2
	rjmp .L211
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L211
.L227:
	ldi r20,lo8(1)
	ldi r22,0
.L253:
	ldi r24,0
.L252:
	rjmp make_saw
.L217:
	ldi r20,lo8(1)
	ldi r22,lo8(1)
.L254:
	ldi r24,lo8(1)
	rjmp .L252
.L218:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	brne .+2
	rjmp .L211
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L211
	ldi r20,0
	ldi r22,lo8(1)
	rjmp .L252
.L212:
	cpi r24,lo8(7)
	breq .L222
	brsh .L223
	cpi r24,lo8(6)
	breq .L224
	ret
.L223:
	cpi r24,lo8(8)
	breq .L225
	cpi r24,lo8(9)
	breq .L226
	ret
.L222:
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,0
	rjmp .L251
.L225:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L211
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L211
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L211
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L211
	ldi r20,0
	ldi r22,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L211
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L211
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L211
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L211
	ldi r20,lo8(1)
	ldi r22,0
	rcall make_saw
	cpi r24,lo8(1)
	breq .L211
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L211
	ldi r20,lo8(1)
.L255:
	ldi r22,0
	rjmp .L254
.L226:
	rjmp make_saw_rainbow
.L211:
	ret
	.size	make_mix_2, .-make_mix_2
.global	make_color
	.type	make_color, @function
make_color:
/* prologue: function */
/* frame size = 0 */
/* stack size = 0 */
.L__stack_usage = 0
	cpi r24,lo8(1)
	breq .L258
	brlo .L259
	cpi r24,lo8(2)
	breq .L260
	cpi r24,lo8(3)
	brne .L297
	ldi r20,0
	rjmp .L290
.L259:
	ldi r20,0
	rjmp .L288
.L258:
	ldi r20,0
	rjmp .L293
.L260:
	ldi r20,0
	rjmp .L294
.L297:
	cpi r24,lo8(5)
	breq .L263
	cpi r24,lo8(6)
	breq .L264
	cpi r24,lo8(4)
	brne .L282
	ldi r20,0
	ldi r22,lo8(-116)
	rjmp .L285
.L263:
	ldi r20,lo8(-116)
	ldi r22,lo8(50)
	rjmp .L285
.L264:
	ldi r20,lo8(-116)
	rjmp .L288
.L282:
	cpi r24,lo8(8)
	breq .L267
	cpi r24,lo8(9)
	breq .L268
	cpi r24,lo8(7)
	brne .L283
	ldi r20,lo8(-116)
.L293:
	ldi r22,0
	rjmp .L289
.L267:
	ldi r20,lo8(50)
.L294:
	ldi r22,lo8(50)
	rjmp .L289
.L268:
	ldi r20,lo8(-116)
.L290:
	ldi r22,lo8(-116)
.L289:
	ldi r24,lo8(-116)
	rjmp .L286
.L283:
	cpi r24,lo8(12)
	breq .L295
	brsh .L272
	cpi r24,lo8(10)
	breq .L273
	cpi r24,lo8(11)
	brne .L270
	ldi r20,0
	rjmp .L292
.L272:
	cpi r24,lo8(13)
	breq .L275
	cpi r24,lo8(14)
	brne .L270
	ldi r20,0
	rjmp .L296
.L273:
	ldi r20,0
	rjmp .L287
.L275:
	ldi r20,lo8(16)
.L288:
	ldi r22,0
	rjmp .L285
.L270:
	cpi r24,lo8(16)
	breq .L278
	cpi r24,lo8(17)
	breq .L279
	cpi r24,lo8(15)
	brne .L284
.L295:
	ldi r20,lo8(16)
.L296:
	ldi r22,lo8(16)
	rjmp .L291
.L278:
	ldi r20,lo8(16)
.L292:
	ldi r22,0
.L291:
	ldi r24,lo8(16)
	rjmp .L286
.L279:
	ldi r20,lo8(16)
.L287:
	ldi r22,lo8(16)
.L285:
	ldi r24,0
.L286:
	rjmp make_light
.L284:
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
.L299:
	cp r28,r16
	cpc r29,r17
	breq .L305
	mov r24,r15
	rcall make_color
	cpi r24,lo8(1)
	breq .L300
	adiw r28,1
	rjmp .L299
.L305:
	ldi r24,0
.L300:
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
.L308:
	movw r22,r28
	movw r24,r16
	rcall long_color
	cpi r24,lo8(1)
	breq .L306
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L306
	adiw r28,1
	cpi r28,10
	cpc r29,__zero_reg__
	brne .L308
.L306:
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
	breq .L315
	brsh .L316
	cpi r24,lo8(1)
	breq .L317
	cpi r24,lo8(2)
	brne .L314
	ldi r24,lo8(10)
	ldi r25,0
	rjmp .L332
.L316:
	cpi r24,lo8(4)
	breq .L319
	cpi r24,lo8(5)
	brne .L314
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
	rjmp .L332
.L317:
	ldi r24,lo8(2)
	ldi r25,0
	rjmp .L332
.L315:
	ldi r24,lo8(50)
	ldi r25,0
.L332:
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad
.L319:
	ldi r24,lo8(100)
	ldi r25,0
	rjmp .L332
.L314:
	cpi r24,lo8(7)
	breq .L322
	brsh .L323
	cpi r24,lo8(6)
	brne .L313
	ldi r24,lo8(100)
	ldi r25,0
	rjmp .L333
.L323:
	cpi r24,lo8(8)
	breq .L325
	cpi r24,lo8(9)
	brne .L313
	ldi r28,lo8(1)
	ldi r29,0
	rjmp .L327
.L322:
	ldi r24,lo8(-112)
	ldi r25,lo8(1)
	rjmp .L333
.L325:
	ldi r24,lo8(-80)
	ldi r25,lo8(4)
.L333:
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad_2
.L334:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L313
	adiw r28,1
	cpi r28,9
	cpc r29,__zero_reg__
	breq .L313
.L327:
	movw r22,r28
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .L334
.L313:
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
	breq .L337
	brsh .L338
	cpi r24,lo8(1)
	breq .L339
	cpi r24,lo8(2)
	breq .L340
	rjmp .L336
.L338:
	cpi r24,lo8(4)
	breq .L341
	cpi r24,lo8(5)
	brne .+2
	rjmp .L342
	rjmp .L336
.L339:
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L335
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L335
	ldi r22,lo8(4)
	ldi r23,0
	rjmp .L410
.L340:
	ldi r22,lo8(4)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L335
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L335
	ldi r22,lo8(6)
	ldi r23,0
.L410:
	ldi r24,lo8(60)
	ldi r25,0
	rjmp .L408
.L337:
	ldi r22,lo8(6)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L335
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L335
	ldi r22,lo8(1)
	ldi r23,0
	rjmp .L410
.L341:
	ldi r22,lo8(2)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L335
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L335
	ldi r22,lo8(5)
	ldi r23,0
	rjmp .L410
.L342:
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L335
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L335
	ldi r22,lo8(2)
	ldi r23,0
	rjmp .L410
.L336:
	cpi r24,lo8(7)
	breq .L346
	brsh .L347
	cpi r24,lo8(6)
	breq .L348
	ret
.L347:
	cpi r24,lo8(8)
	brne .+2
	rjmp .L349
	cpi r24,lo8(9)
	brne .+2
	rjmp .L350
	ret
.L348:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L335
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L335
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L335
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L335
	ldi r22,lo8(4)
	ldi r23,0
	rjmp .L404
.L346:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L335
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L335
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L335
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L335
	ldi r22,lo8(6)
	ldi r23,0
.L404:
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L335
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L335
	ldi r22,lo8(1)
	ldi r23,0
	rjmp .L409
.L349:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L335
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L335
	ldi r22,lo8(9)
	ldi r23,0
	rjmp .L407
.L350:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L335
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L335
	ldi r22,lo8(4)
	ldi r23,0
.L407:
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L335
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L335
	ldi r22,lo8(6)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L335
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L335
	ldi r22,lo8(4)
	ldi r23,0
.L409:
	ldi r24,lo8(45)
	ldi r25,0
.L408:
	rjmp long_color
.L335:
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
	brne .L412
.L414:
	ldi r24,lo8(1)
	rjmp .L413
.L412:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L414
	ldi r22,0
	ldi r23,0
	movw r24,r28
	rcall long_color
	cpi r24,lo8(1)
	breq .L414
	ldi r24,lo8(1)
	lds r25,stat
	cpse r25,__zero_reg__
	rjmp .L413
	ldi r24,0
.L413:
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
	breq .L421
	brsh .L422
	cpi r24,lo8(1)
	breq .L423
	cpi r24,lo8(2)
	brne .+2
	rjmp .L481
	rjmp .L420
.L422:
	cpi r24,lo8(4)
	breq .L425
	cpi r24,lo8(5)
	breq .L426
	rjmp .L420
.L423:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L419
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L419
	ldi r20,lo8(4)
	rjmp .L484
.L421:
	ldi r20,lo8(6)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L419
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L419
	ldi r20,lo8(1)
	rjmp .L484
.L425:
	ldi r20,lo8(2)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L419
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L419
	ldi r20,lo8(5)
	rjmp .L484
.L426:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L419
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L419
.L481:
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L419
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L419
	ldi r20,lo8(6)
	rjmp .L484
.L420:
	cpi r24,lo8(7)
	breq .L431
	brsh .L432
	cpi r24,lo8(6)
	breq .L433
	ret
.L432:
	cpi r24,lo8(8)
	brne .+2
	rjmp .L483
	cpi r24,lo8(9)
	breq .L435
	ret
.L433:
	ldi r20,lo8(1)
	rjmp .L482
.L431:
	ldi r20,lo8(4)
.L482:
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L419
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L419
	ldi r20,lo8(9)
.L484:
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L435:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L419
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L419
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L419
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L419
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L419
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L419
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L419
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L419
.L483:
	ldi r20,lo8(6)
	rjmp .L482
.L419:
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
	breq .L487
	brsh .L488
	cpi r25,lo8(1)
	breq .L489
	cpi r25,lo8(2)
	brne .L486
	mov r20,r22
	ldi r22,lo8(20)
	ldi r23,0
	ldi r24,lo8(20)
	ldi r25,0
	rjmp .L501
.L488:
	cpi r25,lo8(4)
	breq .L491
	cpi r25,lo8(5)
	brne .L486
	mov r20,r22
	ldi r22,lo8(-12)
	ldi r23,lo8(1)
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
	rjmp .L501
.L489:
	rjmp make_color
.L487:
	mov r20,r22
	ldi r22,lo8(50)
	ldi r23,0
	ldi r24,lo8(50)
	ldi r25,0
.L501:
	rjmp make_strob
.L491:
	mov r20,r22
	ldi r22,lo8(100)
	ldi r23,0
	ldi r24,lo8(100)
	ldi r25,0
	rjmp .L501
.L486:
	cpi r25,lo8(8)
	breq .L494
	brsh .L495
	cpi r25,lo8(6)
	breq .L496
	cpi r25,lo8(7)
	breq .L497
	ret
.L495:
	cpi r25,lo8(10)
	breq .L498
	brlo .L499
	cpi r25,lo8(11)
	breq .L500
	ret
.L496:
	rjmp make_pulse
.L497:
	rjmp grad_serie
.L494:
	rjmp make_complex_strob
.L499:
	rjmp make_mix
.L498:
	rjmp make_mix_2
.L500:
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
	ldi r24,lo8(10)
	sts power,r24
	rcall read_data
	rcall init_io
	out 0x3b,__zero_reg__
	out 0x15,__zero_reg__
/* #APP */
 ;  222 "csb-light-grbw-4.0d.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	sts stat,__zero_reg__
	ldi r28,lo8(32)
.L503:
	lds r24,power
	cpi r24,lo8(2)
	brne .L504
	rcall init_io
	out 0x3b,__zero_reg__
	out 0x15,__zero_reg__
/* #APP */
 ;  230 "csb-light-grbw-4.0d.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	ldi r24,lo8(10)
	sts power,r24
	in r24,0x16
	ldi r25,lo8(10)
.L507:
	in r24,0x16
	ldi r30,lo8(-25537)
	ldi r31,hi8(-25537)
1:	sbiw r30,1
	brne 1b
	rjmp .
	nop
	sbrs r24,4
	rjmp .L505
	sts power,__zero_reg__
	rjmp .L506
.L505:
	subi r25,lo8(-(-1))
	brne .L507
.L508:
	sbrc r24,4
	rjmp .L506
	in r24,0x16
	rjmp .L508
.L506:
	ldi r31,lo8(239999)
	ldi r18,hi8(239999)
	ldi r24,hlo8(239999)
1:	subi r31,1
	sbci r18,0
	sbci r24,0
	brne 1b
	rjmp .
	nop
	rjmp .L503
.L504:
	cpse r24,__zero_reg__
	rjmp .L511
	out 0x17,__zero_reg__
	ldi r25,lo8(16)
	out 0x18,r25
	in r24,0x35
	andi r24,lo8(-25)
	ori r24,lo8(16)
	out 0x35,r24
	in r24,0x35
	ori r24,lo8(32)
	out 0x35,r24
	out 0x3b,r28
	out 0x15,r25
/* #APP */
 ;  252 "csb-light-grbw-4.0d.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
	sts power,__zero_reg__
/* #APP */
 ;  254 "csb-light-grbw-4.0d.c" 1
	sleep
	
 ;  0 "" 2
/* #NOAPP */
	in r24,0x35
	andi r24,lo8(-33)
	out 0x35,r24
	rjmp .L503
.L511:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L512
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L513
	lds r22,mode
	lds r24,serie
	rjmp .L527
.L513:
	lds r24,counter
	tst r24
	breq .L514
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
.L527:
	rcall make_serie
	rjmp .L503
.L512:
	cpi r24,lo8(10)
	breq .L526
	cpi r24,lo8(11)
	breq .L526
	cpi r24,lo8(12)
	breq .L526
	cpi r24,lo8(13)
	breq .L526
	cpi r24,lo8(14)
	breq .L526
	cpi r24,lo8(15)
	breq .L526
	cpi r24,lo8(16)
	breq .L526
	cpi r24,lo8(17)
	breq .L526
.L514:
	ldi r24,0
.L526:
	rcall make_color
	rjmp .L503
	.size	main, .-main
	.local	last_button_state.1933
	.comm	last_button_state.1933,1,1
	.local	hold.1931
	.comm	hold.1931,2,1
	.local	button_state.1932
	.comm	button_state.1932,1,1
.global	e_power
	.section	.eeprom,"aw",@progbits
	.type	e_power, @object
	.size	e_power, 1
e_power:
	.zero	1
	.comm	power,1,1
.global	e_fav_on
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
.global	e_brightness
	.type	e_brightness, @object
	.size	e_brightness, 1
e_brightness:
	.zero	1
.global	e_wmode
	.type	e_wmode, @object
	.size	e_wmode, 1
e_wmode:
	.zero	1
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
.global	button_state
	.section .bss
	.type	button_state, @object
	.size	button_state, 1
button_state:
	.zero	1
	.comm	stat,1,1
	.comm	wmode,1,1
	.comm	w,1,1
	.comm	serie,1,1
	.comm	mode,1,1
	.comm	brightness,1,1
	.ident	"GCC: (GNU) 5.4.0"
.global __do_clear_bss
