.include "m8535def.inc"
.def Acc0 = r16 
.def Acc1 = r17

.equ CLK = 0
.equ D = 1

.org 0x0
	rjmp RESET ; Reset Handler
-	rjmp EXT_INT0 ; IRQ0 Handler
	reti;rjmp EXT_INT1 ; IRQ1 Handler
	reti;rjmp TIM2_COMP ; Timer2 Compare Handler
	reti;rjmp TIM2_OVF ; Timer2 Overflow Handler
	reti;rjmp TIM1_CAPT ; Timer1 Capture Handler
	reti;rjmp TIM1_COMPA ; Timer1 Compare A Handler
	reti;rjmp TIM1_COMPB ; Timer1 Compare B Handler
	reti;rjmp TIM1_OVF ; Timer1 Overflow Handler
	reti;rjmp TIM0_OVF ; Timer0 Overflow Handler
	reti;'rjmp SPI_STC ; SPI Transfer Complete Handler
	reti;rjmp USART_RXC ; USART RX Complete Handler
	reti;rjmp USART_UDRE ; UDR Empty Handler
	reti;rjmp USART_TXC ; USART TX Complete Handler
	rjmp ADC_INT ; ADC Conversion Complete Handler
	reti;rjmp EE_RDY ; EEPROM Ready Handler
	reti;rjmp ANA_COMP ; Analog Comparator Handler
	reti;rjmp TWSI ; Two-wire Serial Interface Handler
	reti;rjmp EXT_INT2 ; IRQ2 Handler
	reti;rjmp TIM0_COMP ; Timer0 Compare Handler
	reti;rjmp SPM_RDY ; Store Program Memory Ready Handler

RESET:
	ldi r16,high(RAMEND) ; Main program start
	out SPH,r16 ; Set Stack Pointer to top of RAM
	ldi r16,low(RAMEND)
	out SPL,r16

	sbi DDRC, CLK
    sbi DDRC, D

	sbi DDRB, 3
	sbi PORTB, 3

	ldi Acc0, 0b10
	out MCUCR, r16

	ldi Acc0, (1<<6)
	out GICR, r16

	ldi Acc0, 0b01000000
	out ADMUX, Acc0
	
	ldi Acc0, 0b10001101
	out ADSRA, Acc0
	
		
	 					

	sei ; Enable interrupts

LOOP:
	rjmp LOOP
	
EXT_INT0:

	push Acc0

	cbi Portb, 3

	ldi Acc0, 0b1101101
	out ADSRA, Acc0
	
	pop Acc0
		
	reti

ADC_INT:

	push Acc0

	cbi Portb, 3

	in Acc0, ADCH
	rcall Segment
	
	in Acc0, ADCL
	rcall Segment
	
	pop Acc0
	
	reti

Segment:
	
	clr Acc1

Seg:

	lsl Acc0
	brcc set1
	rjmp set0


set0:

	sbi PORTC, D


set1:

	sbi PORTC, D
	rjmp strob


strob:

	sbi PORTC, CLK
	cbi PORTC, CLK
	inc Acc1
	cpi Acc1, 8
	brne Seg
	ret

 
