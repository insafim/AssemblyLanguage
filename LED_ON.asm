    processor   16f84a
    #include    <p16f84a.inc> ;Name and include the processor
    
    org		0x00	      ;Set the origin vector
    goto	Main          ;Start the program
    
Main:
    bsf	    STATUS,5	;Set the 5th bit of the registry to 1 to select bank 1
    movlw   b'00000000'	;Insert 0s to W to be sent to TRISB
    movwf   TRISB	;Make the port as output
    bcf	    STATUS,5	;Switch to bank 0
    movlw   b'11111111'	;Insert the given literal to W
    movwf   PORTB	;Move the literal to port B to switch all bits on
    goto    $		;Stay on this line
end
    

