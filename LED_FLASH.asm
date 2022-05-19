    processor   16f84a
    #include    <p16f84a.inc> ;Name and include the processor
    
    org		0x00	      ;Set the origin vector
    COUNT1	equ 08h	      ;Counter for the delay loop
    COUNT2	equ 09h	      ;2nd Counter for the delay loop
    goto	Main          ;Start the program
    
Main:
    bsf	    STATUS,5	;Set the 5th bit of the registry to 1 to select bank 1
    movlw   b'00000000'	;Insert 0s to W to be sent to TRISB
    movwf   TRISB	;Make the port as output
    bcf	    STATUS,5	;Switch to bank 0
Start:
    movlw   b'11111111'	;Insert the given literal to W
    movwf   PORTB	;Move the literal to port B to switch all bits on
    call    Delay	;Adding Delay
    movlw   b'00000000'	;Insert the given literal to W
    movwf   PORTB	;Move the literal to port B to switch all bits off
    call    Delay	;Adding Delay
    goto    Start
    
    ;Sunroutine
    Delay   
    Loop    decfsz  COUNT1,1
	    goto    Loop
	    decfsz  COUNT2,1
	    goto    Loop
	    return
end
    





