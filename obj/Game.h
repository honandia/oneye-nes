.ifndef __GAME_H
__GAME_H = 1
.globalzp Game_bananarangLevel ;11
.globalzp Game_bananarangSpeed ;12
.globalzp Game_bananarangPower ;13
.globalzp Game_gameOverScreenTimer ;14
.globalzp Game_screenChangeTimer ;15
.global Game_initialize ;17
.global Game_start ;20
.global Game_update ;70
.macro Game_loadPalette__VBL Game_loadPalette__VBL_addr ;99
	lda #<Game_loadPalette__VBL_addr ;100
	ldy #>Game_loadPalette__VBL_addr ;101
	jsr Game___loadPalette__VBL ;102
.endmacro ;103
.global Game___loadPalette__VBL ;104
.globalzp Game___loadPalette__VBL_addr ;105
.global Game_PALETTE ;120
.global Game_PALETTE__DUNGEON ;123
.endif
