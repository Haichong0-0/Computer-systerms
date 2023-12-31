.equ SREG,  0x3f    ; Status register. See data sheet, p.11

.equ DDRD,  0x0A    ; Register defining pins on port B to be input (0) or output (1)
.equ PORTD, 0x0B    ; Output port for PORTD

.equ DDRB,  0x04    ; Register defining pins on port B to be input (0) or output (1)
.equ PORTB, 0x05    ; Output port for PORTB

        .org 0

main:   ldi r16, 0      
        out SREG,r16

        ldi r16,0xff
        out DDRB, r16
        out DDRD, r16

        call knumdisplay
        call initdisplay
        
        ldi r23,0
mloop:  mov r24,r23
        lsr r24 ;move 1 bit to carry
        brcs odd; test if carry
        call morseeven
        inc r23
        cpi r23,50
        brne mloop
        jmp next
odd:    call morseodd
        inc r23
        cpi r23,50
        brne mloop

next:   ldi r24,200
        call pingp
        

        



knumdisplay:    ;k23004818
                ldi r21,10
                ldi r20, 2      
                call display
                ldi r20, 3      
                call display
                ldi r20, 0      
                call display
                ldi r20, 0      
                call display
                ldi r20, 4      
                call display
                ldi r20, 8      
                call display
                ldi r20, 1      
                call display
                ldi r20, 8      
                call display
                ret

initdisplay:    ;G.H
                ldi r20,7 ;G
                call display ;delay still for 1s
                ldi r20, 27 ;.
                call display
                ldi r20,8 ;H
                call display
                ret

morseodd:       ;GEO 
                ldi r21,6 ;on for 600ms
                ldi r22,2 ;off for 200ms 
                call morsedisplay
                ldi r21,6 
                ldi r22,2 
                call morsedisplay
                ldi r21,2 
                ldi r22,6 
                call morsedisplay ; G end
                ldi r21,2 ;E start
                ldi r22,6 
                call morsedisplay;E end
                ldi r21,6 ;O start
                ldi r22,2 
                call morsedisplay
                ldi r21,6 
                ldi r22,2 
                call morsedisplay
                ldi r21,6 
                ldi r22,14
                call morsedisplay;O end
                ret

morseeven:      ;OEG
                ldi r21,6 ;O start
                ldi r22,2 
                call morsedisplay
                ldi r21,6 
                ldi r22,2 
                call morsedisplay
                ldi r21,6 
                ldi r22,6
                call morsedisplay;O end
                ldi r21,2 ;E start
                ldi r22,6 
                call morsedisplay;E end
                ldi r21,6 ;G start
                ldi r22,2 
                call morsedisplay    
                ldi r21,6 
                ldi r22,2 
                call morsedisplay
                ldi r21,2 
                ldi r22,14
                call morsedisplay ; G end
                ret

morsedisplay:   ;consider each on off as a loop
                ;r21 for on duration, r22 for off dureation
                ldi r20,0xff; on
                call display
                mov r21,r22
                ldi r20,0x00;;off
                call display
                ret


pingp:  ldi r21,2 ;reach position for 0.2s
        ldi r20,0x01; Starts with 00000001
        call display

ploop:  ldi r23,7 ;repeat

left:   lsl r20
        call display
        dec r23
        cpi r23,0
        brne left

        ldi r23,7 
right:  lsr r20
        call display
        dec r23
        cpi r23,0
        brne right
        
        dec r24
        cpi r24,0
        brne ploop
        ret


;delays for 0.1 seconds
delay:  ldi r17, 250 ; 250
        ldi r18, 128 ; 128
        ldi r19, 10  ; 10
        ; 5 cycles * 250 * 128 * 9 / 16,000,000 = 0.10000 seconds (100ms)
loop1:  nop        ; 1 cycle
        dec r17    ; 1 cycle
        cpi r17, 0 ; 1 cycle
        brne loop1 ; 2 cycles when branching
        ldi r17, 250 ; reset inner loop
        dec r18
        cpi r18, 0
        brne loop1
        ldi r18, 128 ; reset first outer loop
        dec r19
        cpi r19, 0
        brne loop1
        ret


display:	;display with delay value: r20, delay: 0.1*r21
		out PORTB, r20
		out PORTD, r20
                mov r25,r21
sloop:          call delay
                dec r25
                cpi r25,0
                brne sloop
		ret
                