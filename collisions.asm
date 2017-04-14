;;;;;;COLLSIONS
CheckPlayerHitDown:
	LDX #$00 ; X <- 0000 0000
	LDA PlayerY ; A <- Players y coordinate
	CLC ; clear carry
	ADC #$10 ; A <- A (player y) + 0001 0000 : get down sprite y 
	AND #$F0 ; A <- A AND 1111 0000 : get the highest part of A
	STA Temp ; Temp <- A
	
	LDA PlayerX ;
	CLC
	ADC #$03; A <- A (player x) + 0000 0011
	AND #$F0
	LSR A ; A <- all bit shifted one position to the right 
	LSR A
	LSR A
	LSR A; 4 tiimes , ie 1111 0000 -> 0000 1111
	ORA Temp
	STA Temp
	LDX Temp
	
	LDA background, X
	CMP #$24 ; sky tile
	
	BNE PlayerHitDown
	LDA #$00 ;
	STA IsPlayerGrounded ; IsPlayerGrounded flag <- 0
	RTS
PlayerHitDown:
	LDA #$01 ;
	STA IsPlayerGrounded ; IsPlayerGrounded flag <- 1
	RTS	