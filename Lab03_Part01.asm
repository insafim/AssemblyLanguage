    processor   16f877a
    #include    <p16f877a.inc> ;Name and include the processor
    
    org		0x00	      ;Set the origin vector
    COUNT	equ 20h	      
    COUNT1	equ 21h	  
    COUNT2	equ 22h
    
	
    goto	Main          ;Start the program
    
Main:
    ;******Configure I/O*******
    bcf		STATUS,6    ;Select Bank 1(01)
    bsf		STATUS,5  
    clrf	TRISD	    ;PortD configured as Output

    bsf		TRISA,0	    ;PortA configured as Input
    
    bcf		ADCON1,7    ;Left Justified
    
    bcf		ADCON1,3    ;Analog with AN3/RA3=Vref+(0001)
    bcf		ADCON1,2
    bcf		ADCON1,1
    bsf		ADCON1,0
    
    bcf		STATUS,5    ;Select Bank 0(00)
    clrf	PORTD	    ;PortD is cleared
    
    bsf		ADCON0,7    ;Select Clock (Fosc/32)
    bcf		ADCON0,6 
    
Conversion
    ;********AN0********
    bcf		ADCON0,5    ;Select Channel 0 (000)
    bcf		ADCON0,4
    bcf		ADCON0,3

    bsf		ADCON0,0    ;Turn on ADC
    call	Delay
    bsf		ADCON0,2    ;Start Conversion
    
Loop1
    btfsc	ADCON0,2    ;Wait until the conversion is complete
    goto	Loop1
    
    movf	ADRESH,0    ;Move the value in ADRESH to W register
    movwf	PORTD	    ;Move W register value to PORTD
    
    call	Seconds_2	    ;2 seconds delay
    	    
    ;********AN1********
    bcf		ADCON0,5    ;Select Channel 1 (001)
    bcf		ADCON0,4
    bsf		ADCON0,3

    bsf		ADCON0,0    ;Turn on ADC
    call	Delay
    bsf		ADCON0,2    ;Start Conversion
    
Loop2
    btfsc	ADCON0,2    ;Wait until the conversion is complete
    goto	Loop2
    
    movf	ADRESH,0    ;Move the value in ADRESH to W register
    movwf	PORTD	    ;Move W register value to PORTD
    
    call	Seconds_2	    ;2 seconds delay
    
    goto	Conversion
    
    ;********20us Delay********
    Delay   
    movlw	14h
    movwf	COUNT
    Loop    decfsz  COUNT,1
	    goto    Loop
	    return
	
    ;********2 seconds Delay********
    Delay1   
    movlw	b'11110110'
    movwf	COUNT1
    movlw	b'10100010'
    movwf	COUNT2
 
    Loop3   decfsz  COUNT1,1
	    goto    Loop3
	    decfsz  COUNT2,1
	    goto    Loop3
	    return
	    
    Seconds_2
	call Delay1
	call Delay1
	call Delay1
	call Delay1
	return
	    
	    
end