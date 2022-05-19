    processor   16f84a
    #include    <p16f84a.inc> ;Name and include the processor
    
    org		0x00	      ;Set the origin vector
    COUNT1	equ 20h	      ;1st Counter for the delay loop
    COUNT2	equ 21h	      ;2nd Counter for the delay loop
    
    goto	Main          ;Start the program
    
Main:
    bcf	    PORTA,0	;Clear PortA, bit0 
    bsf	    STATUS,5	;Set the 5th bit of the registry to 1 to select bank 1
    bcf	    TRISA,0	;Set Port A Bit 0, to 0 to make as output
    bsf	    TRISB,0	;Set Port B Bit 0, to 1 to make as input
    bcf	    STATUS,5	;Switch to bank 0
Start:
    BTFSC   PORTB,0	;Get the value from PORT B,Bit 0. If it is zero then carry on as normal.If it is 1 then Turn ON the LED
    call    LEDon
    goto    Start
    
    ;Subroutine to Turn ON the LED
    LEDon
	    bsf	    PORTA,0	;Set PortA, Bit0 to 1 to switch on the LED
	    call    Delay	;Adding Delay
	    call    Delay
	    bcf	    PORTA,0	;Set PortA, Bit0 to 0 to switch off the LED
	    return
    
    
    ;Sunroutine for Delay
    Delay   
    movlw	b'11110111'
    movwf	COUNT1
    movlw	b'10100011'
    movwf	COUNT2
    Loop    decfsz  COUNT1,1
	    goto    Loop
	    decfsz  COUNT2,1
	    goto    Loop
	    return
end
    











