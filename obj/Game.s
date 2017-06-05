.include "obj/Game.h"
.include "obj/Global.h"
.include "obj/Data/Actor.h"
.include "obj/Data/Animation.h"
.include "obj/Actor.h"
.include "obj/Map.h"
.include "obj/MapScript.h"
.include "obj/Ppu.h"
.include "obj/Screen.h"
.include "obj/Ai.h"
.include "obj/Ai/Bananarang.h"
.include "obj/Ai/Beholder.h"
.include "obj/Ai/BeholderProjectile.h"
.include "obj/Ai/Bird.h"
.include "obj/Ai/Blob.h"
.include "obj/Ai/Explosion.h"
.include "obj/Ai/Ghost.h"
.include "obj/Ai/GorillaHand.h"
.include "obj/Ai/GorillaHead.h"
.include "obj/Ai/Hero.h"
.include "obj/Ai/Minotaur.h"
.include "obj/Ai/Powerup.h"
.include "obj/Ai/Shadow.h"
.include "obj/Ai/Util.h"
 ;10
.pushseg
.zeropage
Game_bananarangLevel: .res 1 ;11
Game_bananarangSpeed: .res 1 ;12
Game_bananarangPower: .res 1 ;13
Game_gameOverScreenTimer: .res 1 ;14
Game_screenChangeTimer: .res 1 ;15
.popseg
 ;16
Game_initialize: ;17
	Global_jsrrts Screen_Title_load ;18
 ;19
Game_start: ;20
	jsr Ppu_disableVideo ;21
	Game_loadPalette__VBL Game_PALETTE ;22
	jsr Ppu_enableVideo ;23
 ;24
	lda #Screen_ID__NONE ;25
	sta Screen_activeScreen ;26
 ;27
	lda #3 ;28
	;lda #2 ;29
	sta Game_bananarangSpeed ;30
	lda #2 ;31
	sta Game_bananarangPower ;32
 ;33
	lda #0 ;34
	sta MapScript_powerup1Collected ;35
	sta MapScript_powerup2Collected ;36
	sta MapScript_powerup3Collected ;37
 ;38
	;DEBUG ;39
	;lda #5 ;40
	;sta Game.bananarangSpeed ;41
	;lda #30 ;42
	;sta bananarangPower ;43
 ;44
	ldx #Actor_INDEX__HERO ;45
	Actor_createX #Data_Actor_ID__HERO ;46
	lda #120 ;47
 ;48
	sta Actor_px,x ;49
 ;50
 ;51
	sta Actor_py,x ;52
	lda #Actor_DIRECTION__RIGHT ;53
	sta Actor_direction,x ;54
	Actor_setAnimation Data_Animation_HERO__IDLE__RIGHT ;55
 ;56
 ;57
	;Ppu.prepareBaseNametable 0 ;58
 ;59
	;Ppu.setBaseNametable 0 ;60
 ;61
	lda #0 + 3*4 ;62
	;lda #1 + 3*4 ;63
	sta Map_worldIndex ;64
	Global_jsrrts Map_loadScreen ;65
	;jsr Map.loadScreen ;66
 ;67
 ;68
 ;69
Game_update: ;70
	lda Screen_activeScreen ;71
	bmi @game ;72
	@screen: ;73
		Global_jsrrts Screen_update ;74
	@game: ;75
 ;76
	lda Game_screenChangeTimer ;77
	beq @skipScreenChangeTimer ;78
		dec Game_screenChangeTimer ;79
	@skipScreenChangeTimer: ;80
 ;81
	lda Game_gameOverScreenTimer ;82
	beq @skipGameOverTimer ;83
		dec Game_gameOverScreenTimer ;84
		bne @skipGameOver ;85
		Global_jsrrts Screen_GameOver_load ;86
	@skipGameOverTimer: ;87
	lda Ai_Hero_id ;88
	bne @skipGameOver ;89
		lda #60 ;90
		sta Game_gameOverScreenTimer ;91
	@skipGameOver: ;92
	jsr Actor_updateAll ;93
	Global_jsrrts MapScript_update ;94
 ;95
 ;96
 ;97
 ;98
 ;99
 ;100
 ;101
 ;102
 ;103
Game___loadPalette__VBL: ;104
.pushseg
.zeropage
	Game___loadPalette__VBL_addr: .res 2 ;105
.popseg
	sta Game___loadPalette__VBL_addr ;106
	sty Game___loadPalette__VBL_addr+1 ;107
	jsr Ppu_disableVideo ;108
	Ppu_setAddr $3F00 ;109
	ldy #0 ;110
	@loop: ;111
		lda (Game___loadPalette__VBL_addr),y ;112
		sta Global_PPUDATA ;113
		iny ;114
		cpy #$20 ;115
		bne @loop ;116
	Global_jsrrts Ppu_enableVideo ;117
 ;118
 ;119
Game_PALETTE: ;120
	.byte $29,$08,$19,$39, $29,$07,$17,$27, $29,$37,$25,$04, $29,$20,$10,$00 ;.byte $29,$08,$19,$39, $29,$2D,$10,$37, $29,$07,$17,$27, $29,$0F,$10,$20 ;121
	.byte $0F,$05,$26,$30, $29,$25,$13,$37, $29,$04,$10,$30, $29,$01,$21,$3C ; .byte $0F,$05,$26,$30, $29,$15,$27,$37, $29,$04,$10,$30, $29,$01,$21,$3C ;122
Game_PALETTE__DUNGEON: ;123
	.byte $0F,$1C,$2C,$39, $0F,$0F,$17,$27, $0F,$0F,$16,$25, $0F,$0F,$10,$20 ;124
	.byte $0F,$03,$14,$35, $0F,$15,$27,$37, $0F,$15,$26,$37, $0F,$08,$19,$39 ;125
 ;126
 ;127
