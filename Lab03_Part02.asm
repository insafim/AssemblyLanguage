    Processor	16F877A
    #Include	<P16F877A.INC>
    
    org		0X00
    COUNT	equ 0X20
    ADC		equ 0X21
    REF_SW1	equ 0X25
    REF_SW2	equ 0X26
    REF_SW3	equ 0X27
    REF_SW4	equ 0X28
    REF_SW5	equ 0X29
    REF_SW6	equ 0X2A
    
	
	
    GOTO	Main
    
Main:
    ;Select Bank 1 (01)
    bcf		STATUS,6    
    bsf		STATUS,5 
    
    clrf	TRISD	    ;PORT D as output
    bsf		TRISA,0	    ;PORT A, BIT 0 as input
    
    bcf		ADCON1,7    ;Left Justified
    
    bcf		ADCON1,3    ;Analog with AN3/RA3=Vref+(0001)
    bcf		ADCON1,2
    bcf		ADCON1,1
    bcf		ADCON1,0
    
    ;Select Bank 0(00)
    bcf		STATUS,5    
    
    clrf	PORTD	    ;PORT D is cleared
    
    bsf		ADCON0,7    ;Select Clock (Fosc/32)
    bcf		ADCON0,6 
    
    
    ;Set Reference Voltages Corresponding to each Switch
    ;Theses values were obtained manually by running Lab03_Paet01 program on this circuit
    
    ;SWITCH 1
    movlw	b'01111111'
    movwf	REF_SW1
    
    ;SWITCH 2
    movlw	b'01100110'
    movwf	REF_SW2
    
    ;SWITCH 3
    movlw	b'01001100'
    movwf	REF_SW3
    
    ;SWITCH 4
    movlw	b'00110011'
    movwf	REF_SW4
    
    ;SWITCH 5
    movlw	b'00011001'
    movwf	REF_SW5
    
    ;SWITCH 6
    movlw	b'00000000'
    movwf	REF_SW6
    

Start
    ;********A/D Conversion********
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
    movwf	ADC	    ;Move W register value to ADC Register


    ;Compare ADC results with reference values
    movf	ADC,0	    ;Move ADC register value to W
    subwf	REF_SW1,0   ;Compare W with the reference value
    btfsc	STATUS,2    ;If the values are equal STATUS, bit 2 will become 1. Then goto the next instruction
    goto	LED1	    ;else skip this instruction and go to the next.
    
    movf	ADC,0
    subwf	REF_SW2,0
    btfsc	STATUS,2
    goto	LED2
    
    movf	ADC,0
    subwf	REF_SW3,0
    btfsc	STATUS,2
    goto	LED3
    
    movf	ADC,0
    subwf	REF_SW4,0
    btfsc	STATUS,2
    goto	LED4
    
    movf	ADC,0
    subwf	REF_SW5,0
    btfsc	STATUS,2
    goto	LED5
    
    movf	ADC,0
    subwf	REF_SW6,0
    btfsc	STATUS,2
    goto	LED6
    
    clrf	PORTD
    goto	Start
    
LED1
    bsf		PORTD,RD0
    goto	Start

LED2
    bsf		PORTD,RD1
    goto	Start

LED3
    bsf		PORTD,RD2
    goto	Start
 
LED4
    bsf		PORTD,RD3
    goto	Start
  
LED5
    bsf		PORTD,RD4
    goto	Start
 
LED6
    bsf		PORTD,RD5
    goto	Start
    
    
;********20us Delay********
Delay   
    movlw	14h
    movwf	COUNT
Loop    
    decfsz  COUNT,1
    goto    Loop
return
	    
	   	    
end