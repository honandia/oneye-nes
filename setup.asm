;; initialize stuff
; clrmem:
	; LDA #$00
	; STA VRAM_PT_0, x
	; STA $0100, x
	; STA OAM_RAM_ADDR, x
	; STA $0400, x
	; STA $0500, x
	; STA $0600, x
	; STA $0700, x
	; LDA #$FE
	; STA $0300, x
	; INX
	; BNE clrmem
	; JSR vblank_wait

; LoadPalettes:
	; LDA PPU_STATUS            ; read PPU status to reset the high/low latch
	; LDA #$3F
	; STA PPU_ADDR             ; write the high byte of $3F00 address
	; LDA #$00
	; STA PPU_ADDR             ; write the low byte of $3F00 address
	; LDX #$00              ; start out at 0
; LoadPalettesLoop:
	; LDA palette, x        ; load data from address (palette + the value in x)
                          ; 1st time through loop it will load palette+0
                          ; 2nd time through loop it will load palette+1
                          ; 3rd time through loop it will load palette+2
                          ; etc
	; STA PPU_DATA             ; write to PPU
	; INX                   ; X = X + 1
	; CPX #$20              ; Compare X to hex $10, decimal 16 - copying 16 bytes = 4 sprites
	; BNE LoadPalettesLoop  ; Branch to LoadPalettesLoop if compare was Not Equal to zero
                        ; if compare was equal to 32, keep going down

LoadSprites:
	LDX #$00              ; start at 0
LoadSpritesLoop:
	LDA sprites, x        ; load data from address (sprites +  x)
	STA OAM_RAM_ADDR, x          ; store into RAM address ($0200 + x)
	INX                   ; X = X + 1
	CPX #$10              ; Compare X to hex $10, decimal 16
	BNE LoadSpritesLoop   ; Branch to LoadSpritesLoop if compare was Not Equal to zero
                        ; if compare was equal to 16, keep going down7 
	
	LDA PPU_STATUS
	LDA #$20
	STA PPU_ADDR             ; write the high byte of $2000 address
	LDA #$00
	STA PPU_ADDR             ; write the low byte of $2000 address
 
	LDA #low(background)
	STA AddrLow
	LDA #high(background)
	STA AddrHigh
  
	LDX #$04              ; Loop X 4 times
	LDY #$00              ; Loop Y 256 times
LoadBackgroundsLoop:
	LDA [AddrLow],y
	STA PPU_DATA
	INY
	BNE LoadBackgroundsLoop
	; Outer loop
	INC AddrHigh           ; increment high byte of address backg to next 256 byte chunk
	DEX                    ; one chunk done so X = X - 1.
	BNE LoadBackgroundsLoop   ; if X isn't zero, do again
          
LoadAttribute:
	LDA PPU_STATUS             ; read PPU status to reset the high/low latch
	LDA #$23
	STA PPU_ADDR             ; write the high byte of $23C0 address
	LDA #$C0
	STA PPU_ADDR             ; write the low byte of $23C0 address
	LDX #$00              ; start out at 0
LoadAttributeLoop:
	LDA attribute, x      ; load data from address (attribute + the value in x)
	STA PPU_DATA             ; write to PPU
	INX                   ; X = X + 1
	CPX #$40              ; Compare X to hex $08, decimal 8 - copying 8 bytes
	BNE LoadAttributeLoop  ; Branch to LoadAttributeLoop if compare was Not Equal to zero
                        ; if compare was equal to 128, keep going down
              					
	LDA #%10000000   ; enable NMI, sprites from Pattern Table 1
	STA PPU_CTRL

	LDA #%00011110   ; enable sprites, enable background, no clipping on left side
	STA PPU_MASK