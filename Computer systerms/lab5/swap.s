; led_on.s : switches on the arduino LED

; specify equivalent symbols

.equ SREG ,0x3f	; Status register , address 0 x3f. See data sheet , p.11
.equ PORTB ,0x05
.equ DDRB ,0x04
.equ PORTD ,0x0B
.equ DDRD ,0x0A





main:	
	ldi r16,0
	ldi r20,0x0f
	out SREG ,r16
	
	ldi r16,0xFF
	out DDRB, r16
	out DDRD, r16 
	;out PORTB,  r16
	
	
	ldi r25,0xff	
loop4:	call swap
	call display
	call delay
	dec r25
        cpi r25,0
        brne loop4
		
swap:	mov r19,r20
	lsl r19
	lsl r19
	lsl r19
	lsl r19
	lsr r20
	lsr r20
	lsr r20
	lsr r20
	or r20,r19
	ret
	

display:	mov r17,r20
		lsr r17
		lsr r17
		lsr r17
		lsr r17
		mov r18,r20
		lsl r18
		lsl r18
		lsl r18
		lsl r18
		out PORTB, r17
		out PORTD, r18
		ret

		
delay: ldi r22,27
loop3:  nop
        ldi r21,255  


loop2:  nop
        ldi r24,255

loop1:  nop
        dec r24
        cpi r24,0
        brne loop1

        dec r23
        cpi r23,0
        brne loop2

        dec r22
        cpi r22,0
        brne loop3

        ret
        
        		
