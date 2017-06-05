.include "obj/Screen.h"
.include "obj/Global.h"
.include "obj/Game.h"
.include "obj/Ppu.h"
.include "obj/Actor.h"
 ;5
.pushseg
.zeropage
Screen_activeScreen: .res 1 ;6
Screen_screenTimer: .res 1 ;7
.popseg
 ;8
 ;9
 ;10
 ;11
 ;12
 ;13
 ;14
Screen_update: ;15
	lda Screen_activeScreen ;16
	cmp #Screen_ID__TITLE ;17
	beq Screen_Title_update ;18
	cmp #Screen_ID__GAME__OVER ;19
	beq Screen_GameOver_update ;20
	cmp #Screen_ID__ENDING ;21
	beq Screen_Ending_update ;22
	cmp #Screen_ID__STORY ;23
	bne @skipStoryUpdate ;24
		jmp Screen_Story_update ;25
	@skipStoryUpdate: ;26
	rts ;27
 ;28
Screen_Title: ;29
	Screen_Title_load: ;30
		jsr Actor_destroyAllButHero ;31
		jsr Actor_updateAll ;32
		lda #Screen_ID__TITLE ;33
		sta Screen_activeScreen ;34
		jsr Ppu_disableVideo ;35
		Game_loadPalette__VBL Screen_TITLE__PALETTE ;36
		jsr Ppu_enableVideo ;37
		Screen_load Screen_TITLE ;38
		rts ;39
	Screen_Title_update: ;40
		lda Global_joy1Press ;41
		and #Global_JOY__START ;42
		beq @end ;43
			jsr Screen_Story_load ;44
		@end: ;45
		rts ;46
 ;47
 ;48
Screen_GameOver: ;49
	Screen_GameOver_load: ;50
		jsr Actor_destroyAllButHero ;51
		jsr Actor_updateAll ;52
		lda #Screen_ID__GAME__OVER ;53
		sta Screen_activeScreen ;54
		jsr Ppu_disableVideo ;55
		Game_loadPalette__VBL Screen_GAME__OVER__PALETTE ;56
		jsr Ppu_enableVideo ;57
		Screen_load Screen_GAME__OVER ;58
		rts ;59
	Screen_GameOver_update: ;60
		lda Global_joy1Press ;61
		and #Global_JOY__START ;62
		beq @end ;63
			jsr Screen_Title_load ;64
		@end: ;65
		rts ;66
 ;67
 ;68
Screen_Ending: ;69
	Screen_Ending_load: ;70
		ldx #Actor_INDEX__HERO ;71
		jsr Actor_destroy ;72
		jsr Actor_destroyAllButHero ;73
		jsr Actor_updateAll ;74
		lda #Screen_ID__ENDING ;75
		sta Screen_activeScreen ;76
		jsr Ppu_disableVideo ;77
		Game_loadPalette__VBL Screen_ENDING__PALETTE ;78
		jsr Ppu_enableVideo ;79
		Screen_load Screen_ENDING ;80
		rts ;81
	Screen_Ending_update: ;82
		rts ;83
 ;84
 ;85
Screen_Story: ;86
	Screen_Story_load: ;87
		jsr Actor_destroyAllButHero ;88
		jsr Actor_updateAll ;89
		lda #Screen_ID__STORY ;90
		sta Screen_activeScreen ;91
		jsr Ppu_disableVideo ;92
		Game_loadPalette__VBL Screen_STORY__PALETTE ;93
		jsr Ppu_enableVideo ;94
		Screen_load Screen_STORY ;95
		lda #255 ;96
		sta Screen_screenTimer ;97
		rts ;98
	Screen_Story_update: ;99
		lda Global_frameCount ;100
		and #1 ;101
		bne @skipTimer ;102
			dec Screen_screenTimer ;103
			beq @loadTitle ;104
		@skipTimer: ;105
		lda Global_joy1Press ;106
		and #Global_JOY__START ;107
		beq @end ;108
		@loadTitle: ;109
			jsr Game_start ;110
		@end: ;111
		rts ;112
 ;113
 ;114
 ;115
 ;116
 ;117
 ;118
 ;119
Screen___load: ;120
.pushseg
.zeropage
	Screen___load_addr: .res 2 ;121
.popseg
	sta Screen___load_addr ;122
	sty Screen___load_addr+1 ;123
	jsr Ppu_disableVideo ;124
	Ppu_setAddr $2000 ;125
	ldy #0 ;126
	jsr @write256 ;127
	jsr @write256 ;128
	jsr @write256 ;129
	jsr @write256 ;130
	Global_jsrrts Ppu_enableVideo ;131
	@write256: ;132
		lda (Screen___load_addr),y ;133
		sta Global_PPUDATA ;134
		iny ;135
		bne @write256 ;136
		inc Screen___load_addr+1 ;137
		rts ;138
 ;139
 ;140
Screen_STORY: .incbin "data/banananana-story.nam" ;141
Screen_TITLE: .incbin "data/banananana-title.nam" ;142
Screen_GAME__OVER: .incbin "data/banananana-game-over.nam" ;143
Screen_ENDING: .incbin "data/banananana-win.nam" ;144
 ;145
 ;146
Screen_TITLE__PALETTE: ;.incbin "data/banananana-title.pal" ;147
.byte $28,$08,$19,$39, $29,$07,$17,$27, $29,$00,$10,$20, $29,$00,$10,$20 ;148
.byte $29,$0F,$0F,$0F, $29,$0F,$0F,$0F, $29,$0F,$0F,$0F, $29,$0F,$0F,$0F ;149
 ;150
Screen_ENDING__PALETTE: ;.incbin "data/banananana-win.pal" ;151
Screen_STORY__PALETTE: ;152
Screen_GAME__OVER__PALETTE: ;.incbin "data/banananana-game-over.nam.pal" ;153
.byte $07,$27,$16,$36, $07,$0F,$10,$20, $29,$00,$10,$20, $07,$17,$26,$36 ;154
.byte $07,$0F,$0F,$0F, $07,$0F,$0F,$0F, $07,$0F,$0F,$0F, $07,$0F,$0F,$0F ;155
 ;156
 ;157
 ;158
