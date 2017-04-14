;;;;;;; Playing state
LatchController:
	LDA #$01
	STA $4016
	LDA #$00
	STA $4016       ; tell both the controllers to latch buttons


ReadA: 
	LDA $4016       ; player 1 - A
	AND #%00000001  ; only look at bit 0
	BEQ ReadADone   ; branch to ReadADone if button is NOT pressed (0)
                  ; add instructions here to do something when button IS pressed (1)
ReadADone:        ; handling this button is done
  
ReadB: 
	LDA $4016       ; player 1 - B
	AND #%00000001  ; only look at bit 0
	BEQ ReadBDone   ; branch to ReadBDone if button is NOT pressed (0)
                  ; add instructions here to do something when button IS pressed (1)
;Jump
	LDA $0200       ; load sprite Y position
	SEC             ; make sure the carry flag is clear
	SBC #$04        ; A = A + 1
	STA $0200       ; save sprite X position
    STA PlayerY
	
	LDA $0204       ; load sprite X position
	SEC             ; make sure the carry flag is clear
	SBC #$04        ; A = A + 1
	STA $0204       ; save sprite X position
  
	LDA $0208       ; load sprite X position
	SEC             ; make sure the carry flag is clear
	SBC #$04        ; A = A + 1
	STA $0208       ; save sprite X position
  
	LDA $020C       ; load sprite X position
	SEC             ; make sure the carry flag is clear
	SBC #$04        ; A = A + 1
	STA $020C       ; save sprite X position
ReadBDone:        ; handling this button is done

ReadSelect: 
	LDA $4016       ; player 1 - Select
	AND #%00000001  ; only look at bit 0
	BEQ ReadSelectDone   ; branch to ReadBDone if button is NOT pressed (0)
                  ; add instructions here to do something when button IS pressed (1)  
ReadSelectDone:        ; handling this button is done

ReadStart: 
	LDA $4016       ; player 1 - Start
	AND #%00000001  ; only look at bit 0
	BEQ ReadStartDone   ; branch to ReadBDone if button is NOT pressed (0)
                  ; add instructions here to do something when button IS pressed (1)  
ReadStartDone:        ; handling this button is done  

ReadUp: 
	LDA $4016       ; player 1 - Up
	AND #%00000001  ; only look at bit 0
	BEQ ReadUpDone   ; branch to ReadBDone if button is NOT pressed (0)
                  ; add instructions here to do something when button IS pressed (1)  
  					     ; add instructions here to do something when button IS pressed (1)  
  ;LDA $0200       ; load sprite X position
  ;SEC             ; make sure the carry flag is clear
  ;SBC #$02        ; A = A + 1
  ;STA $0200       ; save sprite X position
  
  ;LDA $0204       ; load sprite X position
  ;SEC             ; make sure the carry flag is clear
  ;SBC #$02        ; A = A + 1
  ;STA $0204       ; save sprite X position
  
  ;LDA $0208       ; load sprite X position
  ;SEC             ; make sure the carry flag is clear
  ;SBC #$02        ; A = A + 1
  ;STA $0208       ; save sprite X position
  
  ;LDA $020C       ; load sprite X position
  ;SEC             ; make sure the carry flag is clear
  ;SBC #$02        ; A = A + 1
  ;STA $020C       ; save sprite X position
ReadUpDone:        ; handling this button is done  


ReadDown: 
	LDA $4016       ; player 1 - Down
	AND #%00000001  ; only look at bit 0
	BEQ ReadDownDone   ; branch to ReadBDone if button is NOT pressed (0)
                  ; add instructions here to do something when button IS pressed (1)  
  ;LDA $0200       ; load sprite X position
  ;CLC             ; make sure the carry flag is clear
  ;ADC #$02        ; A = A + 1
  ;STA $0200       ; save sprite X position
  
  ;LDA $0204       ; load sprite X position
  ;CLC             ; make sure the carry flag is clear
  ;ADC #$02        ; A = A + 1
  ;STA $0204       ; save sprite X position
  
  ;LDA $0208       ; load sprite X position
  ;CLC             ; make sure the carry flag is clear
  ;ADC #$02        ; A = A + 1
  ;STA $0208       ; save sprite X position
  
  ;LDA $020C       ; load sprite X position
  ;CLC             ; make sure the carry flag is clear
  ;ADC #$02        ; A = A + 1
  ;STA $020C       ; save sprite X position
ReadDownDone:        ; handling this button is done  

ReadLeft: 
	LDA $4016       ; player 1 - Left
	AND #%00000001  ; only look at bit 0
	BEQ ReadLeftDone   ; branch to ReadBDone if button is NOT pressed (0)
                  ; add instructions here to do something when button IS pressed (1)  
	LDA $0203       ; load sprite X position
	SEC             ; make sure carry flag is set
	SBC #$02        ; A = A - 1
	STA $0203       ; save sprite X position
	STA PlayerX
  
	LDA $0207       ; load sprite X position
	SEC             ; make sure carry flag is set
	SBC #$02        ; A = A - 1
	STA $0207       ; save sprite X position
  
	LDA $020B       ; load sprite X position
	SEC             ; make sure carry flag is set
	SBC #$02        ; A = A - 1
	STA $020B       ; save sprite X position
  
	LDA $020F       ; load sprite X position
	SEC             ; make sure carry flag is set
	SBC #$02        ; A = A - 1
	STA $020F       ; save sprite X position
ReadLeftDone:        ; handling this button is done  

ReadRight: 
	LDA $4016       ; player 1 - Right
	AND #%00000001  ; only look at bit 0
	BEQ ReadRightDone   ; branch to ReadBDone if button is NOT pressed (0)
                  ; add instructions here to do something when button IS pressed (1)  
	LDA $0203       ; load sprite X position
	CLC             ; make sure the carry flag is clear
	ADC #$02        ; A = A + 1
	STA $0203       ; save sprite X position
	STA PlayerX
  
	LDA $0207       ; load sprite X position
	CLC             ; make sure the carry flag is clear
	ADC #$02        ; A = A + 1
	STA $0207       ; save sprite X position
  
	LDA $020B       ; load sprite X position
	CLC             ; make sure the carry flag is clear
	ADC #$02        ; A = A + 1
	STA $020B       ; save sprite X position
  
	LDA $020F       ; load sprite X position
	CLC             ; make sure the carry flag is clear
	ADC #$02        ; A = A + 1
	STA $020F       ; save sprite X position

ReadRightDone:        ; handling this button is done  
	
	JSR CheckPlayerHitDown ;
	LDA #$00
	CMP IsPlayerGrounded
	BNE TouchingGround
		;~Gravity
		LDA $0200       ; load sprite X position
		CLC             ; make sure the carry flag is clear
		ADC #$02        ; A = A + 1
		STA $0200       ; save sprite X position
		STA PlayerY
		
		LDA $0204       ; load sprite X position
		CLC             ; make sure the carry flag is clear
		ADC #$02        ; A = A + 1
		STA $0204       ; save sprite X position

		LDA $0208       ; load sprite X position
		CLC             ; make sure the carry flag is clear
		ADC #$02        ; A = A + 1
		STA $0208       ; save sprite X position

		LDA $020C       ; load sprite X position
		CLC             ; make sure the carry flag is clear
		ADC #$02        ; A = A + 1
		STA $020C       ; save sprite X position
TouchingGround: