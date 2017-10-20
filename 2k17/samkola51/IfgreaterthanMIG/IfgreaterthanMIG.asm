.include "m8535def.inc"
.org 0 
.def counter=r22
.def prevn=r20
.def nextn=r21
rjmp Reset

.org 0x15
Reset:

	ldi r16, HIGH(RAMEND)
	out SPH, r16
	ldi r16, LOW(RAMEND)
	out SPL, r16
; ------------------------------------------------------------------------
    ldi r16, 0b11110000
	out DDRB, r16

	cbi DDRD,5 
    cbi DDRD,6
	cbi DDRD,7

	sbi DDRB,3
	sbi PORTB,3 // ?oia aeia ia ai?ae n?aco

Loop:
	cbi PORTB,7 ; first line
	sbi PORTB,4
	sbi PORTB,5
	sbi PORTB,6

	sbis PIND,5
	rjmp one

	sbis PIND,6
	rjmp two

	sbis PIND,7
	rjmp three
; ------------------------------------------------------------------------
	sbi PORTB,7 ; second line
	cbi PORTB,4
	sbi PORTB,5
	sbi PORTB,6

	sbis PIND,5
	rjmp four

	sbis PIND,6
	rjmp five

	sbis PIND,7
	rjmp six
; ------------------------------------------------------------------------
	sbi PORTB,7 ; third line
	sbi PORTB,4
	cbi PORTB,5
	sbi PORTB,6

	sbis PIND,5
	rjmp seven

	sbis PIND,6
	rjmp eight

	sbis PIND,7
	rjmp nine
; ------------------------------------------------------------------------

	sbi PORTB,7 ; fourth line
	sbi PORTB,4
	sbi PORTB,5
	cbi PORTB,6

	sbis PIND,6
	rjmp zero
rjmp Loop
; ------------------------------------------------------------------------
one:
	ldi prevn, 0b00000001
	rjmp Numberi
two:
	ldi prevn, 0b00000010
	rjmp Numberi
three:
	ldi prevn, 0b00000011
	rjmp Numberi
four:
	ldi prevn, 0b00000100
	rjmp Numberi
five:
	ldi prevn, 0b00000101
	rjmp Numberi
six:
	ldi prevn, 0b00000110
	rjmp Numberi
seven:
	ldi prevn, 0b00000111
	rjmp Numberi
eight:
	ldi prevn, 0b00001000
	rjmp Numberi
nine:
	ldi prevn, 0b00001001
	rjmp Numberi
zero:
	ldi prevn, 0b00000000
	rjmp Numberi

Numberi:
	cbi PORTB,7 ; first line
	sbi PORTB,4
	sbi PORTB,5
	sbi PORTB,6

	sbis PIND,5
	rjmp onei

	sbis PIND,6
	rjmp twoi

	sbis PIND,7
	rjmp threei
; ------------------------------------------------------------------------
	sbi PORTB,7 ; second line
	cbi PORTB,4
	sbi PORTB,5
	sbi PORTB,6

	sbis PIND,5
	rjmp fouri

	sbis PIND,6
	rjmp fivei

	sbis PIND,7
	rjmp sixi
; ------------------------------------------------------------------------
	sbi PORTB,7 ; third line
	sbi PORTB,4
	cbi PORTB,5
	sbi PORTB,6

	sbis PIND,5
	rjmp seveni

	sbis PIND,6
	rjmp eighti

	sbis PIND,7
	rjmp ninei
; ------------------------------------------------------------------------

	sbi PORTB,7 ; fourth line
	sbi PORTB,4
	sbi PORTB,5
	cbi PORTB,6

	sbis PIND,6
	rjmp zeroi
rjmp Numberi
; ------------------------------------------------------------------------
onei:
	ldi nextn, 0b00000001
	rjmp Compare
twoi:
	ldi nextn, 0b00000010
	rjmp Compare
threei:
	ldi nextn, 0b00000011
	rjmp Compare
fouri:
	ldi nextn, 0b00000100
	rjmp Compare
fivei:
	ldi nextn, 0b00000101
	rjmp Compare
sixi:
	ldi nextn, 0b00000110
	rjmp Compare
seveni:
	ldi nextn, 0b00000111
	rjmp Compare
eighti:
	ldi nextn, 0b00001000
	rjmp Compare
ninei:
	ldi nextn, 0b00001001
	rjmp Compare
zeroi:
	ldi nextn, 0b00000000
	rjmp Compare


; ------------------------------------------------------------------------
Compare:
CP nextn,prevn
BREQ Resign
BRPL MIG   
rjmp Numberi                         //BRLT Resign   
                         		     // BRLO Resign

/*Resign:
MOV prevn, nextn
rjmp Numberi*/
Resign:
MOV prevn, nextn
rjmp Numberi


MIG:
  MOV prevn, nextn
  sbi PORTB,3
  rcall Long_delay
  cbi PORTB, 3 
  rcall Long_delay
  sbi PORTB,3 
  rcall Long_delay
  cbi PORTB, 3 
  rcall Long_delay
  sbi PORTB,3 
  rcall Long_delay
  cbi PORTB, 3 
  rcall Long_delay
  sbi PORTB, 3 
rjmp Numberi //???

Long_delay:
	clr r19
Long_delay_Loop:
	rcall Delay
	inc r19
	cpi r19,0
	brne Long_delay_Loop
	ret
Delay:
	clr r18
Delay_Loop:
	inc r18
	cpi r18,0
	brne Delay_Loop
	ret

//-------------------------------- //
