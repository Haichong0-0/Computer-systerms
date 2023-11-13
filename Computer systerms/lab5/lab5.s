; led_on.s : switches on the arduino LED

; specify equivalent symbols

.equ SREG ,0x3f	; Status register , address 0 x3f. See data sheet , p.11
.equ PORTB ,0x05
.equ DDRB ,0x04
.equ PORTD ,0x0B
.equ DDRD ,0x0A





main:	
	ldi r16,0
	ldi r17,0x0D
	ldi r18, 0xB0
	out SREG ,r16
	
	ldi r16,0xFF
	out DDRB, r16
	ldi r16, 0xFF
	out DDRD, r16 
	
	out PORTB, r17
	out PORTD, r18
		
	
	
	


mainloop: rjmp mainloop
