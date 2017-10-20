.include "m8535def.inc" 
.def Acc0 = r16 
.def Acc1 = r17
 
.org 0x0
 
rjmp Reset 

.org 0
 
RESET:
 
	ldi Acc0, HIGH (RAMEND) 
	out SPH, Acc0 
	ldi Acc0, LOW (RAMEND) 
	out SPL,Acc0 

	rcall Init_UART 

/*ldi Acc0, 'H' 
rcall Send_UART 
ldi Acc0, 'e' 
rcall Send_UART 
ldi Acc0, 'l' 
rcall Send_UART 
ldi Acc0, 'l' 
rcall Send_UART 
ldi Acc0, 'o' 
rcall Send_UART 
ldi Acc0, '!' 
rcall Send_UART 
*/ 
	rcall Send_UART_message 

Loop: 

;ldi Acc0, 'H' 
;rcall Send_UART 
	rjmp Loop
 
;---------------------------— 
Init_UART:
 	
	ldi Acc0, ( 1 << TXEN ) | ( 1 << RXEN) | ( 1 << RXCIE )
	sbi UCSRB, TXEN
	sbi UCSRDB, RXEN 
	sbi UCSRA, U2X
	 
	ldi Acc0, 12 
	out UBRRL, Acc0 
	ret 


Send_UART: 

	out UDR, Acc0 

check_complete:
 
	sbis UCSRA, UDRE 
	rjmp check_complete 

	cbi UCSRA, UDRE 
	ret
	 
Send_UART_message:
 
	ldi ZH,HIGH(Message*2) 
	ldi ZL,LOW(Message*2)
	 
Send_loop:
 
	lpm Acc0, Z+ 
	cpi Acc0, 0 
	breq End_send 
	rcall Send_UART_byte 
	rjmp Send_loop 

End_send:
 
	ret 

Init_ports:

	ldi Acc0, 0b00000011
	out DDRC, Acc0
	ret

Message:
 
.db "Hello, world!\n\r", 0x0
