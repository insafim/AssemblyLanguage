    processor   16f84a
    #include    <p16f84a.inc> ;Name and include the processor
    
    org		0x00	      ;Set the origin vector
    
    ;********Setting the Count*********
    COUNT1	equ 20h	      ;1st Counter for the delay loop
    COUNT2	equ 21h	      ;2nd Counter for the delay loop
    TEMP	equ 0x0d      ;Temporary store for W register
    goto	Main          ;Start the program
    
    org		0x04	      ;Interrupt Vector
    goto	Interrupt
    
Main:
    CLRF    PORTA	;To get rid of the initial time taken
    ;*********Set Up the Interrupt Registers**********
    bsf	    INTCON,7	;GIE-Global Interrrupt Enable(1=enable)
    bsf	    INTCON,4	;INTE-RB0 Interrupt Enable(1=enable)
    bcf	    INTCON,1	;Clear Flag Bit Just In Case
    
    ;*********Set Up the Ports*********
    bsf	    STATUS,5	;Set the 5th bit of the registry to 1 to select bank 1
    bcf	    TRISA,0	;Set Port A Bit 0, to 0 to make as output
    bsf	    TRISB,0	;Set Port B Bit 0, to 1 to make as input
    bcf	    STATUS,5	;Switch to bank 0
Start:
    bcf	    PORTA,0	;Set PortA, Bit0 to 0 to switch off the LED
    goto    Start
    
    ;Interrupt Routine to Turn ON the LED
    Interrupt   
	    movwf   TEMP	;Store the Value of W temporarily
	    bsf	    PORTA,0	;Make PortA,Bit0 High to turn on the LED
	    call    Delay	;Adding Delay
	    call    Delay       ;Calling delay again to get a delay of approx. 1 sec
	    bcf	    INTCON,1	;We need to clear this flag to enable more interrupts
	    movwf   TEMP	;Restore W to the value before the interrupt
	    retfie		;Come out of Interrupt Routine
    
    
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
    











