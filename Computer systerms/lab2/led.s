; led_on.s : switches on the arduino LED

; specify equivalent symbols

.equ SREG ,0x3f	; Status register , address 0 x3f. See data sheet , p.11
.equ PORTB ,0x05
.equ DDRB ,0x04




.org 0
main:	ldi r16,0
	out SREG ,r16
	ldi r16 ,0x0F
	out DDRB, r16 	
	ldi r16 ,0x0D
	out PORTB, r16


mainloop: rjmp mainloop
