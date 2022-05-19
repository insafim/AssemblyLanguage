    processor   16f84a
    #include    <p16f84a.inc> ;Name and include the processor
    
    org		0x00	      ;Set the origin vector
    goto	Main          ;Start the program
    
    COUNT1	equ 20h	      ;1st Counter for the delay loop
    COUNT2	equ 21h	      ;2nd Counter for the delay loop
    
    
    ;Registration No. :E/16/142
    ;A=1 B=4 C=2
    ;Waiting Time = 4s
    
    
Main:
    bsf	    STATUS,5	;Set the 5th bit of the registry to 1 to select bank 1
    movlw   b'00000000'	;Insert 0s to W to be sent to TRISB
    movwf   TRISB	;Make the port as output
    bcf	    STATUS,5	;Switch to bank 0
    
Start: 
    movlw   0x5		;Insert 5 to W to be sent to GPR 0Eh
    movwf   0Eh		;Value 5 is in 0Eh
    
    movlw   0x4 	;Insert B to W
    subwf   0Eh,0	;(5-B) 
    call    Compare
    call    LED1
    
    movlw   0x2 	;Insert C to W
    subwf   0Eh,0	;(5-C)
    call    Compare
    call    LED2
    
    goto    Start

    

;Subroutine to compare B and C with 5
    Compare
    BTFSC STATUS,Z ;Z=1 if B=5, else Z=0. Skip Next if Z=0
    goto Equal
    BTFSS STATUS,C ;C=0 if B>5, else C=1. Skip Next if C=1
    goto Greater
    goto Less
    
    Equal
	movlw b'00000011'
	bcf STATUS,C ;Clear C in STATUS register
	bcf STATUS,Z ;Clear Z in STATUS register
	return

    Greater
	movlw b'00000010'
	return
    
    Less
	movlw b'00000001'
	bcf STATUS,C ;Clear C in STATUS register
	return
    
    return
  
  
    LED1
    movwf   PORTB	;Move the literal to port B to switch all bits on
    call    Seconds_4
    movlw   b'00000000'	;Insert the given literal to W
    movwf   PORTB	;Move the literal to port B to switch all bits off
    return
    
    LED2
    movwf   0Fh
    swapf   0Fh,0
    movwf   PORTB	;Move the literal to port B to switch all bits on
    call    Seconds_4
    movlw   b'00000000'	;Insert the given literal to W
    movwf   PORTB	;Move the literal to port B to switch all bits off
    return
    
    ;Sunroutine for Delay
    Delay   
    movlw	b'11110110'
    movwf	COUNT1
    movlw	b'10100010'
    movwf	COUNT2
 
    Loop    decfsz  COUNT1,1
	    goto    Loop
	    decfsz  COUNT2,1
	    goto    Loop
	    return
	    
    Seconds_4
	call Delay
	call Delay
	call Delay
	call Delay
	call Delay
	call Delay
	call Delay
	call Delay
	return
	
    
end