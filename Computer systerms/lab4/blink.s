.equ SREG ,0x3f ; Status register. See data sheet , p.11
.equ DDRB ,0x04 ; Data Direction Register for PORTB
.equ PORTB ,0x05 ; Address of PORTB

.org 0


main:   ldi r16,0
        ldi r21,20

        out SREG, r16
        ldi r16,0xFF
        ldi r17,0x00
        out DDRB, r16


loop4:  out PORTB, r16
        call delay
        
        out PORTB, r17
        call delay
    
        dec r21
        cpi r21,0
        brne loop4


delay: ldi r20,27
loop3:  nop
        ldi r19,255  


loop2:  nop
        ldi r18,255

loop1:  nop
        dec r18
        cpi r18,0
        brne loop1

        dec r19
        cpi r19,0
        brne loop2

        dec r20
        cpi r20,0
        brne loop3

        ret

