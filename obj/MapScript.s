.include "obj/MapScript.h"
.include "obj/Global.h"
.include "obj/Map.h"
.include "obj/Actor.h"
.include "obj/Vblank.h"
.include "obj/Ppu.h"
.include "obj/Game.h"
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
.include "obj/Data/Actor.h"
.include "obj/Screen.h"
 ;10
.pushseg
.bss
MapScript_powerup1Collected: .res 1 ;sequential ;11
MapScript_powerup2Collected: .res 1 ;... ;12
MapScript_powerup3Collected: .res 1 ;... ;13
MapScript_bananarangTx: .res 1 ;14
MapScript_bananarangTy: .res 1 ;15
MapScript_heroTx: .res 1 ;16
MapScript_heroTy: .res 1 ;17
.popseg
 ;18
 ;19
 ;20
 ;21
 ;22
 ;23
 ;24
 ;25
 ;26
 ;27
 ;28
 ;29
 ;30
 ;31
 ;32
 ;33
 ;34
 ;35
 ;36
MapScript_update: ;37
	lda #$FF ;38
	sta MapScript_bananarangTx ;39
	sta MapScript_bananarangTy ;40
	ldx #Actor_INDEX__WEAPON ;41
	lda Actor_id,x ;42
	beq @skipBananarang ;43
		jsr Actor_getTx ;44
		sta MapScript_bananarangTx ;45
		jsr Actor_getTy ;46
		sta MapScript_bananarangTy ;47
	@skipBananarang: ;48
 ;49
	lda #$FF ;50
	sta MapScript_heroTx ;51
	sta MapScript_heroTy ;52
	ldx #Actor_INDEX__HERO ;53
	lda Actor_id,x ;54
	beq @skipHero ;55
		jsr Actor_getTx ;56
		sta MapScript_heroTx ;57
		jsr Actor_getTy ;58
		sta MapScript_heroTy ;59
	@skipHero: ;60
 ;61
	lda Map_worldIndex ;62
	cmp #0 + 0*4 ;63
	bne :+ ;64
		jmp MapScript_M00 ;65
	: ;66
	lda Map_worldIndex ;67
	cmp #2 + 0*4 ;68
	bne :+ ;69
		jmp MapScript_M20 ;70
	: ;71
	cmp #3 + 0*4 ;72
	bne :+ ;73
		jmp MapScript_M30 ;74
	: ;75
	cmp #0 + 1*4 ;76
	bne :+ ;77
		jmp MapScript_M01 ;78
	: ;79
	cmp #1 + 1*4 ;80
	bne :+ ;81
		jmp MapScript_M11 ;82
	: ;83
	cmp #0 + 3*4 ;bottom left ;84
	bne :+ ;85
		jmp MapScript_M03 ;86
	: ;87
	cmp #1 + 4*4 ;dungeon 1 ;88
	bne :+ ;89
		jmp MapScript_M14 ;90
	: ;91
	cmp #2 + 4*4 ;dungeon 2 ;92
	bne :+ ;93
		jmp MapScript_M24 ;94
	: ;95
	cmp #3 + 4*4 ;dungeon 3 ;96
	bne :+ ;97
		jmp MapScript_M34 ;98
	: ;99
	rts ;100
 ;101
MapScript_M00: ;102
	MapScript_heroTouches #5,#4 ;103
	bne @end ;104
		lda #1 + 4*4 ;105
		jsr MapScript_enterDungeon ;106
	@end: ;107
	rts ;108
 ;109
MapScript_M20: ;110
	MapScript_bananarangTouches #11,#5 ;111
	bne @end ;112
	@makeBridge: ;113
		ldx #Actor_INDEX__WEAPON ;114
		jsr Actor_destroy ;115
 ;116
		jsr Vblank_wait4 ;117
		Vblank_cmd_replace @bridge1 ;118
		Map_setTile #0, #9,#5 ;119
		Map_setTile #0, #9,#6 ;120
		Map_setTile #0, #8,#5 ;121
		Map_setTile #0, #8,#6 ;122
		jsr Vblank_wait4 ;123
		Vblank_cmd_replace @bridge2 ;124
	@end: ;125
	rts ;126
	@bridge1: ;127
		Ppu_setAddr $2196 ;128
		jsr MapScript_writePressedButtonTop ;129
		Ppu_setAddr $21B6 ;130
		jsr MapScript_writePressedButtonBottom ;131
		Ppu_setAddr $2190 ;132
		jsr MapScript_writeHorizontalBridgeTop1 ;133
		Ppu_setAddr $21B0 ;134
		jsr MapScript_writeHorizontalBridgeBottom1 ;135
		Ppu_setAddr $21D0 ;136
		jsr MapScript_writeHorizontalBridgeTop2 ;137
		Ppu_setAddr $21F0 ;138
		jsr MapScript_writeHorizontalBridgeBottom2 ;139
		Global_jsrrts Vblank_cmd_end ;140
	@bridge2: ;141
		Ppu_setAddr $2192 ;142
		jsr MapScript_writeHorizontalBridgeTop1 ;143
		Ppu_setAddr $21B2 ;144
		jsr MapScript_writeHorizontalBridgeBottom1 ;145
		Ppu_setAddr $21D2 ;146
		jsr MapScript_writeHorizontalBridgeTop2 ;147
		Ppu_setAddr $21F2 ;148
		jsr MapScript_writeHorizontalBridgeBottom2 ;149
		Global_jsrrts Vblank_cmd_end ;150
	rts ;151
 ;152
MapScript_M30: ;153
	MapScript_heroTouches #11,#4 ;154
	bne @end ;155
		lda #3 + 4*4 ;156
		jsr MapScript_enterDungeon ;157
	@end: ;158
	rts ;159
 ;160
MapScript_M01: ;161
	MapScript_heroTouches #5,#5 ;162
	bne @skipDungeonWarp ;163
		lda #2 + 4*4 ;164
		Global_jsrrts MapScript_enterDungeon ;165
	@skipDungeonWarp: ;166
 ;167
	MapScript_bananarangTouches #6,#8 ;168
	bne @end ;169
	@makeBridge: ;170
		ldx #Actor_INDEX__WEAPON ;171
		jsr Actor_destroy ;172
 ;173
		jsr Vblank_wait4 ;174
		Vblank_cmd_replace @bridge1 ;175
		Map_setTile #0, #4,#10 ;176
		Map_setTile #0, #5,#10 ;177
	@end: ;178
	rts ;179
	@bridge1: ;180
		Ppu_setAddr $224C ;181
		jsr MapScript_writePressedButtonTop ;182
		Ppu_setAddr $226C ;183
		jsr MapScript_writePressedButtonBottom ;184
		Ppu_setAddr $22C8 ;185
		jsr MapScript_writeVerticalBridgeRow ;186
		Ppu_setAddr $22E8 ;187
		jsr MapScript_writeVerticalBridgeRow ;188
		Global_jsrrts Vblank_cmd_end ;189
 ;190
 ;191
MapScript_M11: ;192
	MapScript_bananarangTouches #10,#4 ;193
	bne @end ;194
	@makeBridge: ;195
		ldx #Actor_INDEX__WEAPON ;196
		jsr Actor_destroy ;197
 ;198
		jsr Vblank_wait4 ;199
		Vblank_cmd_replace @bridge1 ;200
		Map_setTile #0, #9,#8 ;201
		Map_setTile #0, #10,#8 ;202
		jsr Vblank_wait4 ;203
		Vblank_cmd_replace @bridge2 ;204
		Map_setTile #0, #9,#7 ;205
		Map_setTile #0, #10,#7 ;206
		jsr Vblank_wait4 ;207
		;jsr Vblank.wait4 ;208
		;Vblank.cmd.replace @bridge3 ;209
		;Map.setTile #0, #9,#3 ;210
		;Map.setTile #0, #10,#3 ;211
		;jsr Vblank.wait4 ;212
		Vblank_cmd_replace @bridge4 ;213
		Map_setTile #0, #9,#2 ;214
		Map_setTile #0, #10,#2 ;215
	@end: ;216
	rts ;217
	@bridge1: ;218
		Ppu_setAddr $2154 ;219
		jsr MapScript_writePressedButtonTop ;220
		Ppu_setAddr $2174 ;221
		jsr MapScript_writePressedButtonBottom ;222
		Ppu_setAddr $2A52 ;223
		jsr MapScript_writeVerticalBridgeRow ;224
		Ppu_setAddr $2A72 ;225
		jsr MapScript_writeVerticalBridgeRow ;226
		Global_jsrrts Vblank_cmd_end ;227
	@bridge2: ;228
		Ppu_setAddr $2A12 ;229
		jsr MapScript_writeVerticalBridgeRow ;230
		Ppu_setAddr $2A32 ;231
		jsr MapScript_writeVerticalBridgeRow ;232
		Global_jsrrts Vblank_cmd_end ;233
	;@bridge3: ;234
	;	Ppu.setAddr $2912 ;235
	;	jsr writeVerticalBridgeRow ;236
	;	Ppu.setAddr $2932 ;237
	;	jsr writeVerticalBridgeRow ;238
	;	jsrrts Vblank.cmd.end ;239
	@bridge4: ;240
		Ppu_setAddr $28D2 ;241
		jsr MapScript_writeVerticalBridgeRow ;242
		Ppu_setAddr $28F2 ;243
		jsr MapScript_writeVerticalBridgeRow ;244
		Global_jsrrts Vblank_cmd_end ;245
 ;246
 ;247
 ;248
MapScript_M03: ;249
	MapScript_bananarangTouches #4,#1 ;250
	bne @end ;251
	@makeBridge: ;252
		ldx #Actor_INDEX__WEAPON ;253
		jsr Actor_destroy ;254
 ;255
		jsr Vblank_wait4 ;256
		Vblank_cmd_replace @bridge1 ;257
		Map_setTile #0, #5,#4 ;258
		Map_setTile #0, #6,#4 ;259
		jsr Vblank_wait4 ;260
		Vblank_cmd_replace @bridge2 ;261
		Map_setTile #0, #5,#3 ;262
		Map_setTile #0, #6,#3 ;263
	@end: ;264
	rts ;265
	@bridge1: ;266
		Ppu_setAddr $2888 ;267
		jsr MapScript_writePressedButtonTop ;268
		Ppu_setAddr $28A8 ;269
		jsr MapScript_writePressedButtonBottom ;270
		Ppu_setAddr $214A ;271
		jsr MapScript_writeVerticalBridgeRow ;272
		Ppu_setAddr $216A ;273
		jsr MapScript_writeVerticalBridgeRow ;274
		Global_jsrrts Vblank_cmd_end ;275
	@bridge2: ;276
		Ppu_setAddr $210A ;277
		jsr MapScript_writeVerticalBridgeRow ;278
		Ppu_setAddr $212A ;279
		jsr MapScript_writeVerticalBridgeRow ;280
		Global_jsrrts Vblank_cmd_end ;281
 ;282
MapScript_writePressedButtonTop: ;283
	ldy #$90 ;284
	sty Global_PPUDATA ;285
	iny ;286
	sty Global_PPUDATA ;287
	rts ;288
MapScript_writePressedButtonBottom: ;289
	ldy #$A0 ;290
	sty Global_PPUDATA ;291
	iny ;292
	sty Global_PPUDATA ;293
	rts ;294
 ;295
MapScript_writeVerticalBridgeRow: ;296
	ldy #$A4 ;297
	sty Global_PPUDATA ;298
	iny ;299
	sty Global_PPUDATA ;300
	sty Global_PPUDATA ;301
	iny ;302
	sty Global_PPUDATA ;303
	rts ;304
 ;305
MapScript_writeHorizontalBridgeTop1: ;306
	lda #$74 ;307
	sta Global_PPUDATA ;308
	sta Global_PPUDATA ;309
	rts ;310
MapScript_writeHorizontalBridgeBottom1: ;311
MapScript_writeHorizontalBridgeTop2: ;312
	lda #$84 ;313
	sta Global_PPUDATA ;314
	sta Global_PPUDATA ;315
	rts ;316
MapScript_writeHorizontalBridgeBottom2: ;317
	lda #$94 ;318
	sta Global_PPUDATA ;319
	sta Global_PPUDATA ;320
	rts ;321
 ;322
 ;323
MapScript_M14: ;dungeon 3 ;324
	MapScript_heroTouches #7,#9 ;325
	beq @leave ;326
	MapScript_heroTouches #8,#9 ;327
	bne @end ;328
	@leave: ;329
		lda #5*16+8 ;330
		sta Ai_Hero_px ;331
		lda #4*16+8+16 ;332
		sta Ai_Hero_py ;333
		lda #0 + 0*4 ;334
		jsr MapScript_leaveDungeon ;335
	@end: ;336
	rts ;337
 ;338
MapScript_M24: ;dungeon 2 ;339
	MapScript_heroTouches #7,#9 ;340
	beq @leave ;341
	MapScript_heroTouches #8,#9 ;342
	bne @end ;343
	@leave: ;344
		lda #5*16+8 ;345
		sta Ai_Hero_px ;346
		lda #5*16+8+16 ;347
		sta Ai_Hero_py ;348
		lda #0 + 1*4 ;349
		jsr MapScript_leaveDungeon ;350
	@end: ;351
	rts ;352
 ;353
MapScript_M34: ;dungeon 1 ;354
	MapScript_heroTouches #7,#9 ;355
	beq @leave ;356
	MapScript_heroTouches #8,#9 ;357
	bne @end ;358
	@leave: ;359
		lda #11*16+8 ;360
		sta Ai_Hero_px ;361
		lda #4*16+8+16 ;362
		sta Ai_Hero_py ;363
		lda #3 + 0*4 ;364
		jsr MapScript_leaveDungeon ;365
	@end: ;366
	rts ;367
 ;368
 ;369
MapScript_enterDungeon: ;a(in) ;370
	tay ;371
	lda Global_joy1 ;372
	and #Global_JOY__UP ;373
	beq @end ;374
		sty Map_worldIndex ;375
		jsr Ppu_disableVideo ;376
		Game_loadPalette__VBL Game_PALETTE__DUNGEON ;377
		jsr Ppu_enableVideo ;378
		jsr Map_loadScreen ;379
		lda #128 ;380
		sta Ai_Hero_px ;381
		lda #154 ;382
		sta Ai_Hero_py ;383
 ;384
		jsr MapScript_getDungeonNumber ;385
		tay ;386
		lda MapScript_powerup1Collected,y ;387
		bne @end ;388
			Actor_createEnemy #Data_Actor_ID__POWERUP ;389
			lda #6*16 + 8 + 16 ;390
			sta Actor_py,x ;391
			lda #128 ;392
			sta Actor_px,x ;393
	@end: ;394
	rts ;395
 ;396
MapScript_leaveDungeon: ;397
	sta Map_worldIndex ;398
	jsr Ppu_disableVideo ;399
	Game_loadPalette__VBL Game_PALETTE ;400
	jsr Ppu_enableVideo ;401
	jsr Map_loadScreen ;402
	rts ;403
 ;404
MapScript_getDungeonNumber: ;405
	lda Map_worldIndex ;406
	cmp #1 + 4*4 ;407
	beq @r2 ;408
	cmp #2 + 4*4 ;409
	beq @r1 ;410
	lda #0 ;411
	rts ;412
	@r1: ;413
		lda #1 ;414
		rts ;415
	@r2: ;416
		lda #2 ;417
		rts ;418
 ;419
MapScript_collectPowerup: ;420
	jsr MapScript_getDungeonNumber ;421
	tay ;422
	lda #1 ;423
	sta MapScript_powerup1Collected,y ;424
	inc Game_bananarangSpeed ;425
	inc Game_bananarangPower ;426
 ;427
	;on 3rd power up, end game ;428
	lda MapScript_powerup3Collected ;429
	beq @end ;430
		jsr Vblank_wait4 ;431
		jsr Vblank_wait4 ;432
		jsr Vblank_wait4 ;433
		jsr Vblank_wait4 ;434
		jsr Vblank_wait4 ;435
		jsr Vblank_wait4 ;436
		jsr Vblank_wait4 ;437
		jsr Vblank_wait4 ;438
		jsr Vblank_wait4 ;439
		jsr Vblank_wait4 ;440
		jsr Vblank_wait4 ;441
		jsr Vblank_wait4 ;442
		Global_jsrrts Screen_Ending_load ;443
	@end: ;444
	rts ;445
 ;446
