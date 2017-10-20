.include "m8535def.inc" 
.equ diode =3 
.def acc0=r16 
.def acc1=r17 
.org 0 

rjmp Reset 

.org 0x15 
Reset: 
	ldi acc0, HIGH(RAMEND) 
	out SPH, acc0 // stack pointer high 
	ldi acc0, LOW(RAMEND) 
	out SPL, acc0 // stack pointer low 

rcall init_ports 

Loop: 

	ldi acc1,0b01001001    // assigning mode of operation on PWM for the timer T0
	out TCCR0, acc1 

Test1: 

	ldi acc0,0b01111000           
	out PORTB,acc0            // line 1 on keyboard
	nop 

	sbis PIND,5 
	rjmp First 

	sbis PIND,6 
	rjmp Second 

	sbis PIND,7 
	rjmp Third 

Test2: 
	ldi acc0,0b11101000       // line 2 on keyboard
	out PORTB,acc0 
	nop 

	sbis PIND,5 
	rjmp Fourth 

	sbis PIND,6 
	rjmp Fifth 

	sbis PIND,7 
	rjmp Sixth 

Test3: 
	ldi acc0,0b11011000        // line 3 on keyboard
	out PORTB,acc0 
	nop 
	
	sbis PIND,5 
	rjmp Seventh 

	sbis PIND,6 
	rjmp Eighth 

	sbis PIND,7 
	rjmp Ninth 

rjmp Loop 

//----------------------------------— 
First: 
	ldi acc1,0b01111001               // assigning mode of operation on PWM for the timer T0 (SEE DATASHEET)
	out TCCR0, acc1 

	ldi acc0, 40
	out OCR0, acc0 
Firstt: 
	sbis PIND,5 
	rjmp Firstt 
	rjmp Loop // Aa?an iaoee ?aaai aa?ano ia?aie eiiaiau iinea ia? 

Second: 
	ldi acc1,0b01111001 
	out TCCR0, acc1 

	ldi acc0, 60
	out OCR0, acc0 
Secondd: 
	sbis PIND,6 
	rjmp Secondd 
	rjmp Loop 
Third: 
	ldi acc1,0b01111001 
	out TCCR0, acc1 

	ldi acc0, 80
	out OCR0, acc0 
Thirdd: 
	sbis PIND,7 
	rjmp Thirdd 
	rjmp Loop 

Fourth: 
	ldi acc1,0b01111001 
	out TCCR0, acc1 

	ldi acc0, 100
	out OCR0, acc0 
Fourthh: 
	sbis PIND,5 
	rjmp Fourthh 
	rjmp Loop 
Fifth: 
	ldi acc1,0b01111001 
	out TCCR0, acc1 

	ldi acc0, 120
	out OCR0, acc0 
Fifthh: 
	sbis PIND,6 
	rjmp Fifthh 
	rjmp Loop 
Sixth: 
	ldi acc1,0b01111001 
	out TCCR0, acc1 

	ldi acc0, 140
	out OCR0, acc0 
Sixthh: 
	sbis PIND,7 
	rjmp Sixthh 
	rjmp Loop 

Seventh: 
	ldi acc1,0b01111001 
	out TCCR0, acc1 

	ldi acc0, 160 
	out OCR0, acc0 
Seventhh: 
	sbis PIND,5 
	rjmp Seventhh 
	rjmp Loop 

Eighth: 
	ldi acc1,0b01111001 
	out TCCR0, acc1 

	ldi acc0, 200 
	out OCR0, acc0 
Eighthh: 
	sbis PIND,6 
	rjmp Eighthh 
	rjmp Loop 

Ninth:
	
	cbi PORTB,3 

Ninthh: 
	sbis PIND,7 
	rjmp Ninthh 
	rjmp Loop 

init_ports: 
	ldi acc0,0b11111000 
	out DDRB,acc0 
ret
