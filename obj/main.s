.include "obj/main.h"
;#4C ;1
.include "obj/Global.h"
.include "obj/Ppu.h"
.include "obj/Vblank.h"
.include "obj/Game.h"
 ;6
.segment "HEADER" ;7
 ;8
.byte "NES" ;9
.byte $1a ;10
.byte $02 		; 4 - 2*16k PRG ROM ;11
.byte $01 		; 5 - 8k CHR ROM ;12
.byte %00000001	; 6 - mapper ;13
.byte $00 		; 7 ;14
.byte $00 		; 8 - ;15
.byte $00 		; 9 - NTSC ;16
.byte $00 ;17
; Filler ;18
.byte $00,$00,$00,$00,$00 ;19
 ;20
.code ;21
 ;22
main_PALETTE: ;23
	;.byte $29,$19,$39,$20, $29,$00,$10,$20, $29,$00,$10,$20, $29,$00,$10,$20 ;24
	;.byte $29,$08,$19,$39, $29,$2D,$10,$37, $29,$07,$17,$27, $29,$0F,$10,$20 ;25
	;.byte $29,$03,$14,$35, $29,$15,$27,$37, $29,$04,$10,$30, $29,$01,$21,$3C ;26
 ;27
	.byte $0F,$0F,$16,$25, $0F,$1C,$2C,$39, $0F,$07,$17,$27, $0F,$00,$10,$20 ;28
	.byte $0F,$03,$14,$35, $0F,$15,$27,$37, $0F,$04,$25,$30, $0F,$01,$21,$3C ;29
 ;30
	;$29,$05,$16,$27 ;31
 ;32
main_main: ;33
	cld ;34
	ldx #$40 ;35
	stx $4017 ;disable APU frame IRQ ;36
	ldx #$FF ;37
	txs ;38
	lda #$00 ;39
	sta $4015 ;40
 ;41
	jsr main_clearRam ;42
	jsr Ppu_startup ;43
	jsr Ppu_disableVideo ;44
	Game_loadPalette__VBL Game_PALETTE ;45
	;jsr Palette.clear ;46
	;jsr loadChr ;47
	jsr Ppu_enableVideo ;48
	jsr Game_initialize ;49
 ;50
	@mainLoop: ;51
		lda Vblank_nmiActive ;52
		beq @mainLoop ;53
		jsr main_updateInput ;54
		jsr Game_update ;55
		lda #0 ;56
		sta Vblank_nmiActive ;57
		jmp @mainLoop ;58
 ;59
; poll joypad registers ;60
main_updateInput: ;61
	lda Global_joy1 ;62
	sta Global_joy1Prev ;63
	lda Global_joy2 ;64
	sta Global_joy2Prev ;65
 ;66
	ldx #$01 ;67
	stx $4016 ;68
	dex ;69
	stx $4016 ;70
	ldx #$08 ;71
	@loop: ;72
		lda $4016 ;73
		lsr ;74
		rol Global_joy1 ;75
		lda $4017 ;76
		lsr ;77
		rol Global_joy2 ;78
		dex ;79
		bne @loop ;80
 ;81
	lda Global_joy1 ;82
	eor Global_joy1Prev ;83
	pha ;84
	and Global_joy1 ;85
	sta Global_joy1Press ;86
	pla ;87
	and Global_joy1Prev ;88
	sta Global_joy1Release ;89
	lda Global_joy2 ;90
	eor Global_joy2Prev ;91
	pha ;92
	and Global_joy2 ;93
	sta Global_joy2Press ;94
	pla ;95
	and Global_joy2Prev ;96
	sta Global_joy2Release ;97
	rts ;98
 ;99
 ;100
main_clearRam: ;101
	ldx #$00 ;102
	lda #$00 ;103
	@loop: ;104
		sta $00,x ;105
		sta $200,x ;106
		sta $300,x ;107
		sta $400,x ;108
		sta $500,x ;109
		sta $600,x ;110
		sta $700,x ;111
		inx ;112
		bne @loop ;113
	rts ;114
 ;115
main_irq: ;116
	rti ;117
 ;118
.segment "CHRROM" ;119
main_CHR: ;120
.incbin "data/bananarang.chr" ;121
 ;122
.segment "VECTORS" ;123
.word Vblank_nmi ;124
.word main_main ;125
.word main_irq ;126
 ;127
 ;128
