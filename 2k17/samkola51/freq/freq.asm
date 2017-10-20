/* frequency generator from 1 to 9 kHz */

/* clock rate of 1 MHz */

.include "m8535def.inc"

.equ top1 = 999 ; for frequency 1 kHz
.equ top2 = 499 ; for frequency 2 kHz
.equ top3 = 332 ; for frequency 3 kHz
.equ top4 = 249 ; for frequency 4 kHz
.equ top5 = 199 ; for frequency 5 kHz
.equ top6 = 166 ; for frequency 6 kHz
.equ top7 = 142 ; for frequency 7 kHz
.equ top8 = 124 ; for frequency 8 kHz
.equ top9 = 110 ; for frequency 9 kHz

.def temp = r16
.def switch = r17

.org 0x00 

	rjmp reset

.org 0x15 

reset: 

	ldi temp, high(RAMEND) 
	out SPH, temp 
	ldi temp, low(RAMEND) 
	out SPL, temp

	ldi temp, 0b11110000
	out DDRB, temp

	sbi DDRD, 4


loop:

	ldi temp, 0b01110000
	out PORTB, temp
	sbis PIND, 5
	rjmp clik_1
	sbis PIND, 6
	rjmp clik_2
	sbis PIND, 7
	rjmp clik_3

	ldi temp, 0b11100000
	out PORTB, temp
	sbis PIND, 5
	rjmp clik_4
	sbis PIND, 6
	rjmp clik_5
	sbis PIND, 7
	rjmp clik_6

	ldi temp, 0b11010000
	out PORTB, temp
	sbis PIND, 5
	rjmp clik_7
	sbis PIND, 6
	rjmp clik_8
	sbis PIND, 7
	rjmp clik_9

	rjmp loop

loop_past_clik:

	ldi temp, 0b10110000
	out PORTB, temp

	sbis PIND, 5
	rcall change_dependency

	sbis PIND, 7
	rjmp stop_timer1

	rjmp loop_past_clik

clik_1:

	ldi XH, high(top1)
	ldi XL, low(top1)

	ldi YH, high(top1 / 2)
	ldi YL, low(top1 / 2)

	ldi ZH, high(top1 / 4)
	ldi ZL, low(top1 / 4)

	rcall init_timer1

	rjmp loop_past_clik

clik_2:

	ldi XH, high(top2)
	ldi XL, low(top2)

	ldi YH, high(top2 / 2)
	ldi YL, low(top2 / 2)

	ldi ZH, high(top2 / 4)
	ldi ZL, low(top2 / 4)

	rcall init_timer1

	rjmp loop_past_clik

clik_3:

	ldi XH, high(top3)
	ldi XL, low(top3)

	ldi YH, high(top3 / 2)
	ldi YL, low(top3 / 2)

	ldi ZH, high(top3 / 4)
	ldi ZL, low(top3 / 4)

	rcall init_timer1

	rjmp loop_past_clik

clik_4:

	ldi XH, high(top4)
	ldi XL, low(top4)

	ldi YH, high(top4 / 2)
	ldi YL, low(top4 / 2)

	ldi ZH, high(top4 / 4)
	ldi ZL, low(top4 / 4)

	rcall init_timer1

	rjmp loop_past_clik

clik_5:

	ldi XH, high(top5)
	ldi XL, low(top5)

	ldi YH, high(top5 / 2)
	ldi YL, low(top5 / 2)

	ldi ZH, high(top5 / 4)
	ldi ZL, low(top5 / 4)

	rcall init_timer1

	rjmp loop_past_clik

clik_6:

	ldi XH, high(top6)
	ldi XL, low(top6)

	ldi YH, high(top6 / 2)
	ldi YL, low(top6 / 2)

	ldi ZH, high(top6 / 4)
	ldi ZL, low(top6 / 4)

	rcall init_timer1

	rjmp loop_past_clik

clik_7:

	ldi XH, high(top7)
	ldi XL, low(top7)

	ldi YH, high(top7 / 2)
	ldi YL, low(top7 / 2)

	ldi ZH, high(top7 / 4)
	ldi ZL, low(top7 / 4)

	rcall init_timer1

	rjmp loop_past_clik

clik_8:

	ldi XH, high(top8)
	ldi XL, low(top8)

	ldi YH, high(top8 / 2)
	ldi YL, low(top8 / 2)

	ldi ZH, high(top8 / 4)
	ldi ZL, low(top8 / 4)

	rcall init_timer1

	rjmp loop_past_clik

clik_9:

	ldi XH, high(top9)
	ldi XL, low(top9)

	ldi YH, high(top9 / 2)
	ldi YL, low(top9 / 2)

	ldi ZH, high(top9 / 4)
	ldi ZL, low(top9 / 4)

	rcall init_timer1

	rjmp loop_past_clik

init_timer1:
	
	out OCR1AH, XH
	out OCR1AL, XL

	out OCR1BH, YH
	out OCR1BL, YL

	ldi temp, 0b00100011
	out TCCR1A, temp

	ldi temp, 0b00011001
	out TCCR1B, temp

	ret

stop_timer1:

	ldi temp, 0b00011000
	out TCCR1B, temp
	
	clr switch	

	rjmp loop

change_dependency:

	ldi temp, (1 << 0)
	eor switch, temp
	cpi switch, 1
	breq dependency_2_to_4
	brne dependency_4_to_2

	ret

dependency_2_to_4:
	
	out OCR1BH, ZH
	out OCR1BL, ZL

	ret

dependency_4_to_2:
	
	out OCR1BH, YH
	out OCR1BL, YL

	ret
