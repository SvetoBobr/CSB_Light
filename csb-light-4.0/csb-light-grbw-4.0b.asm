	.file	"csb-light-grbw-4.0b.c"
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
	cpi r24,lo8(12)
	brlo .L3
	ldi r24,lo8(1)
	sts serie,r24
.L3:
	lds r24,brightness
	cpi r24,lo8(3)
	brlo .L4
	sts brightness,__zero_reg__
.L4:
	lds r24,wmode
	cpi r24,lo8(4)
	brlo .L5
	sts wmode,__zero_reg__
.L5:
	ldi r30,lo8(modes)
	ldi r31,hi8(modes)
	ldi r26,lo8(series)
	ldi r27,hi8(series)
	ldi r24,lo8(1)
.L8:
	ld r25,Z
	cpi r25,lo8(10)
	brlo .L6
	st Z,r24
.L6:
	ld r25,X
	cpi r25,lo8(12)
	brlo .L7
	st X,r24
.L7:
	adiw r30,1
	adiw r26,1
	ldi r25,hi8(modes+15)
	cpi r30,lo8(modes+15)
	cpc r31,r25
	brne .L8
	lds r24,counter
	cpi r24,lo8(16)
	brlo .L9
	sts counter,__zero_reg__
.L9:
	lds r24,counter
	lds r25,pointer
	cp r25,r24
	brlo .L10
	sts pointer,r24
.L10:
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
.global	__vector_2
	.type	__vector_2, @function
__vector_2:
	push r1
	push r0
	in r0,__SREG__
	push r0
	clr __zero_reg__
	push r18
	push r19
	push r20
	push r21
	push r22
	push r23
	push r24
	push r25
	push r26
	push r27
	push r30
	push r31
/* prologue: Signal */
/* frame size = 0 */
/* stack size = 15 */
.L__stack_usage = 15
/* #APP */
 ;  128 "csb-light-grbw-4.0b.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	rcall init_io
	in r25,0x16
	ldi r24,lo8(41)
.L18:
	sbrc r25,4
	rjmp .L22
	in r25,0x16
	ldi r30,lo8(3999)
	ldi r31,hi8(3999)
1:	sbiw r30,1
	brne 1b
	rjmp .
	nop
	subi r24,lo8(-(-1))
	brne .L18
	ldi r24,lo8(10)
	sts power,r24
	sts stat,__zero_reg__
	out 0x3b,__zero_reg__
	out 0x15,__zero_reg__
/* #APP */
 ;  143 "csb-light-grbw-4.0b.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	rjmp .L17
.L22:
	ldi r24,lo8(9999)
	ldi r25,hi8(9999)
1:	sbiw r24,1
	brne 1b
	rjmp .
	nop
	sts power,__zero_reg__
.L17:
/* epilogue start */
	pop r31
	pop r30
	pop r27
	pop r26
	pop r25
	pop r24
	pop r23
	pop r22
	pop r21
	pop r20
	pop r19
	pop r18
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
	cpi r24,57
	ldi r18,74
	cpc r25,r18
	brlo .L24
	ldi r24,lo8(12)
	sts stat,r24
	or r22,r23
	breq .L25
.L28:
	ldi r24,0
	ret
.L25:
	sts pointer,__zero_reg__
	sts counter,__zero_reg__
	rjmp .L29
.L24:
	cpi r24,-127
	ldi r18,62
	cpc r25,r18
	brlo .L27
	ldi r24,lo8(11)
	sts stat,r24
	or r22,r23
	brne .L28
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L29
	ldi r24,lo8(1)
	sts fav_on,r24
	sts pointer,r24
	rjmp .L50
.L29:
	sts fav_on,__zero_reg__
	rjmp .L50
.L27:
	cpi r24,-31
	ldi r18,46
	cpc r25,r18
	brlo .L31
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L28
	lds r24,counter
	cpi r24,lo8(15)
	brsh .L28
	ldi r25,lo8(10)
	sts stat,r25
	or r22,r23
	brne .L28
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
.L50:
	rcall check_all
	rjmp .L49
.L31:
	cpi r24,41
	ldi r18,35
	cpc r25,r18
	brlo .L32
	ldi r24,lo8(17)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L28
	lds r24,wmode
	subi r24,lo8(-(1))
	cpi r24,lo8(4)
	brsh .L33
	sts wmode,r24
	rjmp .L49
.L33:
	sts wmode,__zero_reg__
	rjmp .L49
.L32:
	cpi r24,113
	ldi r18,23
	cpc r25,r18
	brlo .L35
	ldi r24,lo8(16)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L28
	lds r24,brightness
	subi r24,lo8(-(1))
	cpi r24,lo8(3)
	brsh .L36
	sts brightness,r24
	rjmp .L49
.L36:
	sts brightness,__zero_reg__
	rjmp .L49
.L35:
	cpi r24,-71
	ldi r18,11
	cpc r25,r18
	brlo .L38
	ldi r24,lo8(14)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L28
	sts power,__zero_reg__
	rjmp .L49
.L38:
	cpi r24,-23
	ldi r18,3
	cpc r25,r18
	brlo .L39
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L28
	ldi r24,lo8(13)
	sts stat,r24
	or r22,r23
	breq .+2
	rjmp .L28
	lds r24,serie
	subi r24,lo8(-(1))
	cpi r24,lo8(12)
	brlo .L46
	ldi r24,lo8(1)
.L46:
	sts serie,r24
	ldi r24,lo8(1)
	sts mode,r24
.L49:
	rcall store_data
	sts stat,__zero_reg__
	rjmp .L48
.L39:
	cpi r24,101
	cpc r25,__zero_reg__
	brsh .+2
	rjmp .L28
	or r22,r23
	breq .+2
	rjmp .L28
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L42
	lds r24,mode
	subi r24,lo8(-(1))
	cpi r24,lo8(10)
	brlo .L47
	ldi r24,lo8(1)
.L47:
	sts mode,r24
	rjmp .L44
.L42:
	lds r24,pointer
	subi r24,lo8(-(1))
	sts pointer,r24
	lds r25,counter
	cp r25,r24
	brsh .L44
	ldi r24,lo8(1)
	sts pointer,r24
.L44:
	rcall check_all
	rcall store_data
.L48:
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
	rjmp .L52
	sts button_state.1929,__zero_reg__
	rjmp .L53
.L52:
	ldi r24,lo8(1)
	sts button_state.1929,r24
.L53:
	lds r22,button_state.1929
	cpi r22,lo8(1)
	brne .L54
	lds r24,hold.1928
	lds r25,hold.1928+1
	adiw r24,1
	sts hold.1928+1,r25
	sts hold.1928,r24
.L54:
	lds r24,last_button_state.1930
	cpse r22,r24
	rjmp .L57
	ldi r23,0
	lds r24,hold.1928
	lds r25,hold.1928+1
	rcall process_button
	rjmp .L55
.L57:
	ldi r24,0
.L55:
	lds r25,button_state.1929
	cpse r25,__zero_reg__
	rjmp .L56
	lds r18,last_button_state.1930
	cpse r18,__zero_reg__
	rjmp .L56
	sts hold.1928+1,__zero_reg__
	sts hold.1928,__zero_reg__
.L56:
	sts last_button_state.1930,r25
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
	breq .L65
	brlo .L64
	cpi r25,lo8(2)
	breq .L62
	cpi r25,lo8(3)
	breq .L63
	rjmp .L59
.L62:
	mov r18,r22
	ldi r19,0
	add r18,r24
	adc r19,__zero_reg__
	add r18,r20
	adc r19,__zero_reg__
	or r18,r19
	breq .L64
.L65:
	ldi r25,lo8(-116)
	sts w,r25
	rjmp .L59
.L63:
	mov r18,r22
	ldi r19,0
	add r18,r24
	adc r19,__zero_reg__
	add r18,r20
	adc r19,__zero_reg__
	or r18,r19
	breq .L65
.L64:
	sts w,__zero_reg__
.L59:
	lds r19,w
	lds r25,button_state
	cpse r25,__zero_reg__
	rjmp .L66
	lds r25,brightness
	cpi r25,lo8(1)
	brne .L67
	lsr r24
	lsr r24
	lsr r22
	lsr r22
	lsr r20
	lsr r20
	lsr r19
	lsr r19
	rjmp .L66
.L67:
	cpi r25,lo8(2)
	brne .L66
	swap r24
	andi r24,lo8(15)
	swap r22
	andi r22,lo8(15)
	swap r20
	andi r20,lo8(15)
	swap r19
	andi r19,lo8(15)
.L66:
	ldi r18,0
.L72:
	cp r18,r24
	brsh .L73
	ldi r25,lo8(18)
	rjmp .L68
.L73:
	ldi r25,lo8(16)
.L68:
	cp r18,r22
	brsh .L69
	ori r25,lo8(1)
.L69:
	cp r18,r20
	brsh .L70
	ori r25,lo8(4)
.L70:
	cp r18,r19
	brsh .L71
	ori r25,lo8(8)
.L71:
	out 0x18,r25
	subi r18,lo8(-(1))
	cpi r18,lo8(-116)
	brne .L72
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
	breq .L83
	cpi r24,lo8(3)
	breq .L84
	cpi r24,lo8(1)
	brne .L94
	ldi r20,0
	rjmp .L101
.L83:
	ldi r20,0
	rjmp .L100
.L84:
	ldi r20,0
	rjmp .L99
.L94:
	cpi r24,lo8(5)
	breq .L87
	cpi r24,lo8(6)
	breq .L88
	cpi r24,lo8(4)
	brne .L95
	ldi r20,0
	rjmp .L103
.L87:
	ldi r20,lo8(1)
.L103:
	ldi r22,lo8(1)
	rjmp .L102
.L88:
	ldi r20,lo8(1)
.L101:
	ldi r22,0
.L102:
	ldi r24,0
	rjmp .L97
.L95:
	cpi r24,lo8(8)
	breq .L92
	cpi r24,lo8(9)
	breq .L92
	cpi r24,lo8(7)
	brne .L96
	ldi r20,lo8(1)
.L100:
	ldi r22,0
	rjmp .L98
.L92:
	ldi r20,lo8(1)
.L99:
	ldi r22,lo8(1)
.L98:
	ldi r24,lo8(1)
.L97:
	rjmp make_light
.L96:
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
.L105:
	cp r28,r16
	cpc r29,r17
	breq .L111
	mov r20,r13
	mov r22,r14
	mov r24,r15
	rcall make_light
	cpi r24,lo8(1)
	breq .L106
	adiw r28,1
	rjmp .L105
.L111:
	ldi r24,0
.L106:
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
.L116:
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
	brne .L113
.L115:
	ldi r24,lo8(1)
	rjmp .L114
.L113:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L115
	subi r28,lo8(-(1))
	cpi r28,lo8(-115)
	brne .L116
	ldi r28,lo8(-116)
.L117:
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
	breq .L115
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L115
	subi r28,lo8(-(-1))
	brne .L117
.L114:
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
	breq .L125
	cpi r24,lo8(3)
	breq .L126
	cpi r24,lo8(1)
	brne .L137
	ldi r30,lo8(30)
	mov r12,r30
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,0
	rjmp .L141
.L125:
	ldi r23,lo8(30)
	mov r12,r23
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,0
	rjmp .L143
.L126:
	ldi r22,lo8(30)
	mov r12,r22
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,0
	rjmp .L145
.L137:
	cpi r24,lo8(5)
	breq .L130
	cpi r24,lo8(6)
	breq .L131
	cpi r24,lo8(4)
	brne .L138
	ldi r21,lo8(30)
	mov r12,r21
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
.L145:
	ldi r22,lo8(-1)
	rjmp .L144
.L130:
	ldi r20,lo8(30)
	mov r12,r20
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
	ldi r22,0
.L144:
	ldi r24,0
	rjmp .L142
.L131:
	ldi r19,lo8(30)
	mov r12,r19
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
	rjmp .L141
.L138:
	cpi r24,lo8(8)
	breq .L133
	cpi r24,lo8(9)
	breq .L134
	cpi r24,lo8(7)
	brne .L139
	ldi r18,lo8(30)
	mov r12,r18
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,0
	ldi r20,lo8(-1)
.L143:
	ldi r22,lo8(-1)
	rjmp .L140
.L133:
	ldi r25,lo8(30)
	mov r12,r25
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,lo8(-1)
	ldi r20,0
	ldi r22,lo8(63)
	rjmp .L140
.L134:
	ldi r24,lo8(30)
	mov r12,r24
	mov r13,__zero_reg__
	mov r14,__zero_reg__
	ldi r16,0
	ldi r18,lo8(25)
	ldi r20,lo8(63)
.L141:
	ldi r22,0
.L140:
	ldi r24,lo8(-1)
.L142:
	rcall basic_pulse
	rjmp .L128
.L139:
	ldi r24,0
.L128:
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
.L149:
	movw r18,r28
	ldi r20,0
	mov r22,r17
	ldi r24,lo8(-116)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L146
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L146
	subi r17,lo8(-(1))
	cpi r17,lo8(-115)
	brne .L149
	ldi r17,lo8(-117)
.L150:
	movw r18,r28
	ldi r20,0
	ldi r22,lo8(-116)
	mov r24,r17
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L146
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L146
	subi r17,1
	brcc .L150
	ldi r17,lo8(1)
.L151:
	movw r18,r28
	mov r20,r17
	ldi r22,lo8(-116)
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L146
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L146
	subi r17,lo8(-(1))
	cpi r17,lo8(-115)
	brne .L151
	ldi r17,lo8(-117)
.L152:
	movw r18,r28
	ldi r20,lo8(-116)
	mov r22,r17
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L146
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L146
	subi r17,1
	brcc .L152
	ldi r17,lo8(1)
.L153:
	movw r18,r28
	ldi r20,lo8(-116)
	ldi r22,0
	mov r24,r17
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L146
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L146
	subi r17,lo8(-(1))
	cpi r17,lo8(-115)
	brne .L153
	ldi r17,lo8(-117)
.L154:
	movw r18,r28
	mov r20,r17
	ldi r22,0
	ldi r24,lo8(-116)
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L146
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L146
	subi r17,1
	brcc .L154
.L146:
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
.L178:
	ldi r18,lo8(5)
	ldi r19,0
	mov r20,r29
	mov r22,r17
	mov r24,r16
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L177
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L179
	subi r28,lo8(-(-1))
	add r16,r13
	add r17,r14
	add r29,r15
	cpse r28,__zero_reg__
	rjmp .L178
	rjmp .L177
.L179:
	ldi r24,lo8(1)
.L177:
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
.L188:
	ldi r18,lo8(2)
	ldi r19,0
	mov r20,r28
	mov r22,r28
	ldi r24,lo8(-116)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L184
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L184
	subi r28,lo8(-(-1))
	brne .L188
.L189:
	ldi r18,lo8(2)
	ldi r19,0
	ldi r20,0
	mov r22,r28
	ldi r24,lo8(-116)
	rcall l_make_light
	cpi r24,lo8(1)
	brne .+2
	rjmp .L184
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L184
	subi r28,lo8(-(1))
	cpi r28,lo8(-116)
	brne .L189
.L190:
	ldi r18,lo8(2)
	ldi r19,0
	ldi r20,0
	ldi r22,lo8(-116)
	mov r24,r28
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L184
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L184
	subi r28,lo8(-(-1))
	brne .L190
.L191:
	ldi r18,lo8(2)
	ldi r19,0
	mov r20,r28
	ldi r22,lo8(-116)
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L184
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L184
	subi r28,lo8(-(1))
	cpi r28,lo8(-116)
	brne .L191
.L192:
	ldi r18,lo8(2)
	ldi r19,0
	ldi r20,lo8(-116)
	mov r22,r28
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L184
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L184
	subi r28,lo8(-(-1))
	brne .L192
	ldi r28,lo8(-116)
.L193:
	ldi r18,lo8(2)
	ldi r19,0
	mov r20,r28
	ldi r22,0
	ldi r24,0
	rcall l_make_light
	cpi r24,lo8(1)
	breq .L184
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L184
	subi r28,lo8(-(-1))
	brne .L193
	ldi r18,lo8(10)
	ldi r19,0
	ldi r20,0
	ldi r22,0
/* epilogue start */
	pop r28
	rjmp l_make_light
.L184:
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
	breq .L231
	brsh .L218
	cpi r24,lo8(1)
	breq .L219
	cpi r24,lo8(2)
	brne .L216
	ldi r20,0
	ldi r22,lo8(1)
	rjmp .L257
.L218:
	cpi r24,lo8(4)
	breq .L221
	cpi r24,lo8(5)
	breq .L222
	rjmp .L216
.L219:
	ldi r20,0
	rjmp .L259
.L228:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
.L255:
	rcall make_saw
	cpi r24,lo8(1)
	brne .+2
	rjmp .L215
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L215
.L231:
	ldi r20,lo8(1)
	ldi r22,0
.L257:
	ldi r24,0
.L256:
	rjmp make_saw
.L221:
	ldi r20,lo8(1)
	ldi r22,lo8(1)
.L258:
	ldi r24,lo8(1)
	rjmp .L256
.L222:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	brne .+2
	rjmp .L215
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L215
	ldi r20,0
	ldi r22,lo8(1)
	rjmp .L256
.L216:
	cpi r24,lo8(7)
	breq .L226
	brsh .L227
	cpi r24,lo8(6)
	breq .L228
	ret
.L227:
	cpi r24,lo8(8)
	breq .L229
	cpi r24,lo8(9)
	breq .L230
	ret
.L226:
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,0
	rjmp .L255
.L229:
	ldi r20,0
	ldi r22,0
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L215
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L215
	ldi r20,0
	ldi r22,lo8(1)
	ldi r24,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L215
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L215
	ldi r20,0
	ldi r22,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L215
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L215
	ldi r20,lo8(1)
	ldi r22,lo8(1)
	rcall make_saw
	cpi r24,lo8(1)
	breq .L215
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L215
	ldi r20,lo8(1)
	ldi r22,0
	rcall make_saw
	cpi r24,lo8(1)
	breq .L215
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L215
	ldi r20,lo8(1)
.L259:
	ldi r22,0
	rjmp .L258
.L230:
	rjmp make_saw_rainbow
.L215:
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
	breq .L262
	brlo .L263
	cpi r24,lo8(2)
	breq .L264
	cpi r24,lo8(3)
	brne .L301
	ldi r20,0
	rjmp .L294
.L263:
	ldi r20,0
	rjmp .L292
.L262:
	ldi r20,0
	rjmp .L297
.L264:
	ldi r20,0
	rjmp .L298
.L301:
	cpi r24,lo8(5)
	breq .L267
	cpi r24,lo8(6)
	breq .L268
	cpi r24,lo8(4)
	brne .L286
	ldi r20,0
	ldi r22,lo8(-116)
	rjmp .L289
.L267:
	ldi r20,lo8(-116)
	ldi r22,lo8(50)
	rjmp .L289
.L268:
	ldi r20,lo8(-116)
	rjmp .L292
.L286:
	cpi r24,lo8(8)
	breq .L271
	cpi r24,lo8(9)
	breq .L272
	cpi r24,lo8(7)
	brne .L287
	ldi r20,lo8(-116)
.L297:
	ldi r22,0
	rjmp .L293
.L271:
	ldi r20,lo8(50)
.L298:
	ldi r22,lo8(50)
	rjmp .L293
.L272:
	ldi r20,lo8(-116)
.L294:
	ldi r22,lo8(-116)
.L293:
	ldi r24,lo8(-116)
	rjmp .L290
.L287:
	cpi r24,lo8(12)
	breq .L299
	brsh .L276
	cpi r24,lo8(10)
	breq .L277
	cpi r24,lo8(11)
	brne .L274
	ldi r20,0
	rjmp .L296
.L276:
	cpi r24,lo8(13)
	breq .L279
	cpi r24,lo8(14)
	brne .L274
	ldi r20,0
	rjmp .L300
.L277:
	ldi r20,0
	rjmp .L291
.L279:
	ldi r20,lo8(16)
.L292:
	ldi r22,0
	rjmp .L289
.L274:
	cpi r24,lo8(16)
	breq .L282
	cpi r24,lo8(17)
	breq .L283
	cpi r24,lo8(15)
	brne .L288
.L299:
	ldi r20,lo8(16)
.L300:
	ldi r22,lo8(16)
	rjmp .L295
.L282:
	ldi r20,lo8(16)
.L296:
	ldi r22,0
.L295:
	ldi r24,lo8(16)
	rjmp .L290
.L283:
	ldi r20,lo8(16)
.L291:
	ldi r22,lo8(16)
.L289:
	ldi r24,0
.L290:
	rjmp make_light
.L288:
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
.L303:
	cp r28,r16
	cpc r29,r17
	breq .L309
	mov r24,r15
	rcall make_color
	cpi r24,lo8(1)
	breq .L304
	adiw r28,1
	rjmp .L303
.L309:
	ldi r24,0
.L304:
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
.L312:
	movw r22,r28
	movw r24,r16
	rcall long_color
	cpi r24,lo8(1)
	breq .L310
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L310
	adiw r28,1
	cpi r28,10
	cpc r29,__zero_reg__
	brne .L312
.L310:
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
	breq .L319
	brsh .L320
	cpi r24,lo8(1)
	breq .L321
	cpi r24,lo8(2)
	brne .L318
	ldi r24,lo8(10)
	ldi r25,0
	rjmp .L336
.L320:
	cpi r24,lo8(4)
	breq .L323
	cpi r24,lo8(5)
	brne .L318
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
	rjmp .L336
.L321:
	ldi r24,lo8(2)
	ldi r25,0
	rjmp .L336
.L319:
	ldi r24,lo8(50)
	ldi r25,0
.L336:
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad
.L323:
	ldi r24,lo8(100)
	ldi r25,0
	rjmp .L336
.L318:
	cpi r24,lo8(7)
	breq .L326
	brsh .L327
	cpi r24,lo8(6)
	brne .L317
	ldi r24,lo8(100)
	ldi r25,0
	rjmp .L337
.L327:
	cpi r24,lo8(8)
	breq .L329
	cpi r24,lo8(9)
	brne .L317
	ldi r28,lo8(1)
	ldi r29,0
	rjmp .L331
.L326:
	ldi r24,lo8(-112)
	ldi r25,lo8(1)
	rjmp .L337
.L329:
	ldi r24,lo8(-80)
	ldi r25,lo8(4)
.L337:
/* epilogue start */
	pop r29
	pop r28
	rjmp make_grad_2
.L338:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L317
	adiw r28,1
	cpi r28,9
	cpc r29,__zero_reg__
	breq .L317
.L331:
	movw r22,r28
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .L338
.L317:
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
	breq .L341
	brsh .L342
	cpi r24,lo8(1)
	breq .L343
	cpi r24,lo8(2)
	breq .L344
	rjmp .L340
.L342:
	cpi r24,lo8(4)
	breq .L345
	cpi r24,lo8(5)
	brne .+2
	rjmp .L346
	rjmp .L340
.L343:
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L339
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L339
	ldi r22,lo8(4)
	ldi r23,0
	rjmp .L414
.L344:
	ldi r22,lo8(4)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L339
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L339
	ldi r22,lo8(6)
	ldi r23,0
.L414:
	ldi r24,lo8(60)
	ldi r25,0
	rjmp .L412
.L341:
	ldi r22,lo8(6)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L339
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L339
	ldi r22,lo8(1)
	ldi r23,0
	rjmp .L414
.L345:
	ldi r22,lo8(2)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L339
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L339
	ldi r22,lo8(5)
	ldi r23,0
	rjmp .L414
.L346:
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(60)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L339
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L339
	ldi r22,lo8(2)
	ldi r23,0
	rjmp .L414
.L340:
	cpi r24,lo8(7)
	breq .L350
	brsh .L351
	cpi r24,lo8(6)
	breq .L352
	ret
.L351:
	cpi r24,lo8(8)
	brne .+2
	rjmp .L353
	cpi r24,lo8(9)
	brne .+2
	rjmp .L354
	ret
.L352:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L339
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L339
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L339
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L339
	ldi r22,lo8(4)
	ldi r23,0
	rjmp .L408
.L350:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L339
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L339
	ldi r22,lo8(1)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	brne .+2
	rjmp .L339
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L339
	ldi r22,lo8(6)
	ldi r23,0
.L408:
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L339
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L339
	ldi r22,lo8(1)
	ldi r23,0
	rjmp .L413
.L353:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L339
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L339
	ldi r22,lo8(9)
	ldi r23,0
	rjmp .L411
.L354:
	ldi r22,0
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L339
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L339
	ldi r22,lo8(4)
	ldi r23,0
.L411:
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L339
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L339
	ldi r22,lo8(6)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall long_color
	cpi r24,lo8(1)
	breq .L339
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L339
	ldi r22,lo8(4)
	ldi r23,0
.L413:
	ldi r24,lo8(45)
	ldi r25,0
.L412:
	rjmp long_color
.L339:
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
	brne .L416
.L418:
	ldi r24,lo8(1)
	rjmp .L417
.L416:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L418
	ldi r22,0
	ldi r23,0
	movw r24,r28
	rcall long_color
	cpi r24,lo8(1)
	breq .L418
	ldi r24,lo8(1)
	lds r25,stat
	cpse r25,__zero_reg__
	rjmp .L417
	ldi r24,0
.L417:
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
	breq .L425
	brsh .L426
	cpi r24,lo8(1)
	breq .L427
	cpi r24,lo8(2)
	brne .+2
	rjmp .L485
	rjmp .L424
.L426:
	cpi r24,lo8(4)
	breq .L429
	cpi r24,lo8(5)
	breq .L430
	rjmp .L424
.L427:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L423
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L423
	ldi r20,lo8(4)
	rjmp .L488
.L425:
	ldi r20,lo8(6)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L423
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L423
	ldi r20,lo8(1)
	rjmp .L488
.L429:
	ldi r20,lo8(2)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L423
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L423
	ldi r20,lo8(5)
	rjmp .L488
.L430:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L423
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L423
.L485:
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	brne .+2
	rjmp .L423
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L423
	ldi r20,lo8(6)
	rjmp .L488
.L424:
	cpi r24,lo8(7)
	breq .L435
	brsh .L436
	cpi r24,lo8(6)
	breq .L437
	ret
.L436:
	cpi r24,lo8(8)
	brne .+2
	rjmp .L487
	cpi r24,lo8(9)
	breq .L439
	ret
.L437:
	ldi r20,lo8(1)
	rjmp .L486
.L435:
	ldi r20,lo8(4)
.L486:
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L423
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L423
	ldi r20,lo8(9)
.L488:
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rjmp make_strob
.L439:
	ldi r20,lo8(1)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L423
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L423
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L423
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L423
	ldi r20,lo8(4)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L423
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L423
	ldi r20,lo8(9)
	ldi r22,lo8(45)
	ldi r23,0
	ldi r24,lo8(45)
	ldi r25,0
	rcall make_strob
	cpi r24,lo8(1)
	breq .L423
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L423
.L487:
	ldi r20,lo8(6)
	rjmp .L486
.L423:
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
	breq .L491
	brsh .L492
	cpi r25,lo8(1)
	breq .L493
	cpi r25,lo8(2)
	brne .L490
	mov r20,r22
	ldi r22,lo8(20)
	ldi r23,0
	ldi r24,lo8(20)
	ldi r25,0
	rjmp .L505
.L492:
	cpi r25,lo8(4)
	breq .L495
	cpi r25,lo8(5)
	brne .L490
	mov r20,r22
	ldi r22,lo8(-12)
	ldi r23,lo8(1)
	ldi r24,lo8(-12)
	ldi r25,lo8(1)
	rjmp .L505
.L493:
	rjmp make_color
.L491:
	mov r20,r22
	ldi r22,lo8(50)
	ldi r23,0
	ldi r24,lo8(50)
	ldi r25,0
.L505:
	rjmp make_strob
.L495:
	mov r20,r22
	ldi r22,lo8(100)
	ldi r23,0
	ldi r24,lo8(100)
	ldi r25,0
	rjmp .L505
.L490:
	cpi r25,lo8(8)
	breq .L498
	brsh .L499
	cpi r25,lo8(6)
	breq .L500
	cpi r25,lo8(7)
	breq .L501
	ret
.L499:
	cpi r25,lo8(10)
	breq .L502
	brlo .L503
	cpi r25,lo8(11)
	breq .L504
	ret
.L500:
	rjmp make_pulse
.L501:
	rjmp grad_serie
.L498:
	rjmp make_complex_strob
.L503:
	rjmp make_mix
.L502:
	rjmp make_mix_2
.L504:
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
 ;  242 "csb-light-grbw-4.0b.c" 1
	cli
 ;  0 "" 2
/* #NOAPP */
	sts stat,__zero_reg__
	ldi r28,lo8(32)
.L507:
	lds r24,power
	cpse r24,__zero_reg__
	rjmp .L508
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
 ;  254 "csb-light-grbw-4.0b.c" 1
	sei
 ;  0 "" 2
 ;  255 "csb-light-grbw-4.0b.c" 1
	sleep
	
 ;  0 "" 2
/* #NOAPP */
	in r24,0x35
	andi r24,lo8(-33)
	out 0x35,r24
	rjmp .L507
.L508:
	lds r24,stat
	cpse r24,__zero_reg__
	rjmp .L510
	lds r24,fav_on
	cpse r24,__zero_reg__
	rjmp .L511
	lds r22,mode
	lds r24,serie
	rjmp .L524
.L511:
	lds r24,counter
	tst r24
	breq .L512
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
.L524:
	rcall make_serie
	rjmp .L507
.L510:
	cpi r24,lo8(10)
	breq .L523
	cpi r24,lo8(11)
	breq .L523
	cpi r24,lo8(12)
	breq .L523
	cpi r24,lo8(13)
	breq .L523
	cpi r24,lo8(14)
	breq .L523
	cpi r24,lo8(15)
	breq .L523
	cpi r24,lo8(16)
	breq .L523
	cpi r24,lo8(17)
	breq .L523
.L512:
	ldi r24,0
.L523:
	rcall make_color
	rjmp .L507
	.size	main, .-main
	.local	last_button_state.1930
	.comm	last_button_state.1930,1,1
	.local	hold.1928
	.comm	hold.1928,2,1
	.local	button_state.1929
	.comm	button_state.1929,1,1
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
