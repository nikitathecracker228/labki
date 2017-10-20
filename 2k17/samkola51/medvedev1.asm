.include "m8535def.inc"
.org 0

    ldi r16, HIGH(RAMEND)
	OUT SPH, r16
	ldi r16, LOW(RAMEND)
	out SPL, r16
   	
   
	sbi DDRC, 0
	sbi DDRC, 1
	cbi DDRC, 3 

.equ ch0=0b00000011
.equ ch1=0b10011111
.equ ch2=0b00100101
.equ ch3=0b00001101		
.equ ch4=0b10011001
.equ ch5=0b01001001		
.equ ch6=0b01000001		
.equ ch7=0b00011111		
.equ ch8=0b00000001		
.equ ch9=0b00001001		
			
	



	


Send_byte_indicator:
    cbi PORTC,0
	cbi PORTC,1
	clr r18
	

send_loop:
 	lsr r17
	brcs Send1
	rjmp Send0

Send1: 
	sbi PORTC,1
	rjmp strobe
Send0:
	cbi PORTC,1
	
strobe:
		sbi PORTC,0
		nop
		nop
		cbi PORTC,0
		inc r18
		cpi r18,8
		brne send_loop
		ret 	
