.include "m8535def.inc"
.org 0
	ldi r16, HIGH(RAMEND)
	out SPH, r16
	ldi r16, LOW(RAMEND)
	out SPL, r16

	ldi r16, 0b11111000
	out DDRB, r16
	ldi r16, 0b11101000
	out PORTB, r16

Loop:
	sbic PIND,7
	rjmp Loop
	cbi PORTB,3
	rcall Long_Delay
	sbi PORTB,3
	rcall Long_Delay
	rjmp Loop

;----------------------------
Delay:
	clr r16
Delay_Loop:
	inc r16
	cpi r16,0
	brne Delay_Loop
	ret
;----------------------------
Long_Delay:
	clr r17
Long_Delay_Loop:
	inc r17
	rcall Long_Delay
	cpi r17,0
	brne Long_Delay_Loop
	ret
;----------------------------
Send_byte_indicator:
	cbi PORTC,0
	cbi PORTC,1
	clr r19
Send_Loop|:
	lsr r18
	brcs Send1
	rjmp Send0
	
Send1:
	sbi PORTC,0
	rjmp Strobe

Send0:			
	cbi PORTC,0
Strobe:
 	sbi PORTC,1
	cbi PORTC,1
	inc r19
	cpi r19,8
	brne Send_Loop
	ret
		

	
