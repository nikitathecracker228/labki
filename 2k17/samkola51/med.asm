.include "m8535def.inc" 
.org 0 
.def i=r17 
.def razr1=r18 
.def razr2=r19 
.def razr3=r20 
.def temp=r21
.def i1=r24
.def i2=r16
.def i3=r26
 
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





ldi r16, HIGH(RAMEND); стек 
out SPH, r16 
ldi r16, LOW(RAMEND) 
out SPL, r16 


sbi DDRC,0
sbi DDRC,1 
cbi DDRC,3
cbi DDRD,3

ldi temp, 0b11111111 
rcall Send_byte_indicator
ldi temp, ch0 
rcall Send_byte_indicator
ldi temp, ch0
rcall Send_byte_indicator
ldi temp, ch0 
rcall Send_byte_indicator

LOOP:
	
 	sbis PIND,3
	rjmp OBNUL
	sbic PINC, 3 
	rjmp LOOP 
	rcall delay
	sbic PINC, 3; проверка на дребезг контактов 
	rjmp LOOP  
	rcall delay 
	rcall otpysk
	
	inc i;прибавить единицу 
	cpi i, 10
	BRLO razryad1
	inc i2 
	ldi i, 0
	cpi i2,10
	BRLO razryad1
	inc i3
	ldi i,0
	ldi i2,0
	cpi i3,3
	BRLO razryad1
OBNUL:
	ldi i,0
	ldi i3,0
	ldi i2,0
	
	rcall razryad1
	rjmp LOOP 



razryad1: 
mov razr1, i 
mov razr2, i2
mov razr3, i3
ldi temp, 0b11111111 
rcall Send_byte_indicator 
mov temp, razr3 
rcall download
 rcall Send_byte_indicator
mov temp, razr2 
rcall download
rcall Send_byte_indicator  
 mov temp, razr1 
rcall download
rcall Send_byte_indicator 
rjmp LOOP

otch: 
ldi i2,0
ret 





download: 
cpi temp,0 
BREQ nol 
; если равно 
cpi temp,1 
BREQ one 
cpi temp,2 
BREQ two 
cpi temp,3 
BREQ three 
cpi temp,4 
BREQ four 
cpi temp,5 
BREQ five 
cpi temp,6 
BREQ six 
cpi temp,7 
BREQ seven 
cpi temp,8 
BREQ eight 
cpi temp,9 
BREQ nine 
ret 

nol: 
ldi temp, ch0 
ret 
one: 
ldi temp, ch1 
ret 
two: 
ldi temp, ch2 
ret 
three: 
ldi temp, ch3 
ret 
four: 
ldi temp, ch4 
ret 
five: 
ldi temp, ch5 
ret 
six: 
ldi temp, ch6 
ret 
seven: 
ldi temp, ch7 
ret 
eight: 
ldi temp, ch8 
ret 
nine: 
ldi temp, ch9 
ret 


otpysk: 
sbis PINC, 3
rjmp otpysk 
ret 


delay: 
clr r23 
delay1: 
inc r23 
cpi r23,0 
brne delay1 
ret 


Send_byte_indicator: 
cbi PORTC,0 
cbi PORTC,1 
clr r22 


send_loop: 
lsr temp 
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
inc r22 
cpi r22,8 
brne send_loop 
ret

	/* mov i,i1 
	 inc i1;прибавить единицу 
	cpi i, 10
	BRLO razryad1
	ldi i,0
	ldi i1,0
	inc i1
	inc i2 ; если меньше 
	
	
	
	cpi i2, 10
	 rcall razryad1
	 cpi i2, 10
	brlo otch
	

	rcall razryad1 
	rjmp LOOP */
