.include "m8535def.inc" 
.def temp = r16 
.def story = r17 
 
.org 0x0 
 
	rjmp reset 
 
.org 0x15 
 
reset: 
  
	ldi temp, high(ramend) 
	out sph, temp 
	ldi temp, low(ramend) 
	out spl, temp 
 
	ldi temp, 0b11111000 
	out DDRB, temp 
	ldi temp, 0b00010000 
	out DDRD, temp

	sbi PORTB, 3
	sbi PORTD, 4 
 
loop_0: 
  
	ldi temp, 0b01111000 
	out PORTB, temp 
	sbic PIND, 5 
	rjmp loop_0 
 
loop_1: 
  
	ldi temp, 0b11011000 
	out PORTB, temp 
	sbic PIND, 6 
	rjmp loop_0 
 
loop_2: 
  
	ldi temp, 0b01111000 
	out PORTB, temp 
	sbic PIND, 5 
	rjmp loop_0 
 
loop_3: 
  
	ldi temp, 0b01111000 
	out PORTB, temp 
	sbic PIND, 6 
	rjmp loop_0 
 
blink: 
 
	sbi PORTB, 3 
	cbi PORTD, 4 
	rcall long_delay 
	sbi PORTD, 4 
	cbi PORTB, 3 
	rcall long_delay 
	rjmp blink 
 
delay: 
 
	clr r16 
 
	delay_loop: 
 
		inc r16 
		cpi r16, 0 
		brne delay_loop 
	ret 
 
long_delay: 
 
	clr r17 
 
	long_delay_loop: 
 
		inc r17 
		rcall delay 
		cpi r17, 128 
		brne long_delay_loop 
	ret
