.include "obj/Actor.h"
.include "obj/Global.h"
.include "obj/Data/Actor.h"
.include "obj/Data/Animation.h"
.include "obj/Map.h"
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
.include "obj/Game.h"
 ;7
 ;8
 ;9
 ;10
 ;11
 ;12
 ;13
 ;14
 ;15
 ;16
 ;17
 ;18
 ;19
 ;20
 ;21
 ;22
 ;23
 ;24
 ;25
 ;26
.pushseg
.zeropage
Actor_oamIndex: .res 1 ;27
.popseg
 ;28
.pushseg
.bss
Actor_id: .res Actor_MAX__ACTORS ;29
Actor_px: .res Actor_MAX__ACTORS ;30
Actor_py: .res Actor_MAX__ACTORS ;31
Actor_vx: .res Actor_MAX__ACTORS ;32
Actor_vy: .res Actor_MAX__ACTORS ;33
Actor_hp: .res Actor_MAX__ACTORS ;34
Actor_timer: .res Actor_MAX__ACTORS ;35
Actor_flags: .res Actor_MAX__ACTORS ;36
Actor_invincibility: .res Actor_MAX__ACTORS ;37
Actor_lostControl: .res Actor_MAX__ACTORS ;38
Actor_animationAddrL: .res Actor_MAX__ACTORS ;39
Actor_animationAddrH: .res Actor_MAX__ACTORS ;40
Actor_animationIndex: .res Actor_MAX__ACTORS ;41
Actor_animationFrame: .res Actor_MAX__ACTORS ;42
Actor_direction: .res Actor_MAX__ACTORS ;43
Actor_var0: .res Actor_MAX__ACTORS ;44
Actor_var1: .res Actor_MAX__ACTORS ;45
Actor_var2: .res Actor_MAX__ACTORS ;46
.popseg
 ;47
 ;48
 ;49
 ;50
 ;51
 ;52
 ;53
 ;54
 ;55
 ;56
 ;57
 ;58
 ;59
 ;60
 ;61
 ;62
 ;63
 ;64
 ;65
 ;66
 ;67
 ;68
Actor___createX: ;69
	sta Actor_id,x ;70
	tay ;71
	lda Data_Actor_HP,y ;72
	sta Actor_hp,x ;73
	lda Data_Actor_PALETTE,y ;74
	sta Actor_flags,x ;75
	lda #0 ;76
	sta Actor_timer,x ;77
	sta Actor_invincibility,x ;78
	sta Actor_px,x ;79
	sta Actor_py,x ;80
	sta Actor_vx,x ;81
	sta Actor_vy,x ;82
	sta Actor_animationAddrH,x ;83
	sta Actor_animationIndex,x ;84
	Ai_call #Ai_EVENT_CREATE ;85
	rts ;86
 ;87
 ;88
 ;89
 ;90
 ;91
 ;92
Actor___createEnemy: ;93
.pushseg
.zeropage
	Actor___createEnemy_tmp: .res 1 ;94
.popseg
	sta Actor___createEnemy_tmp ;95
	ldx #Actor_ENEMY__INDEX__START ;96
	@loop: ;97
		lda Actor_id,x ;98
		bne @continue ;99
			lda Actor___createEnemy_tmp ;100
			Global_jsrrts Actor___createX ;101
		@continue: ;102
		inx ;103
		cpx #Actor_MAX__ACTORS ;104
		bne @loop ;105
	rts ;106
 ;107
 ;108
 ;109
 ;110
 ;111
 ;112
Actor___createParticle: ;113
.pushseg
.zeropage
	Actor___createParticle_tmp: .res 1 ;114
.popseg
	sta Actor___createParticle_tmp ;115
	ldx #Actor_PARTICLE__INDEX__START ;116
	@loop: ;117
		lda Actor_id,x ;118
		bne @continue ;119
			lda Actor___createParticle_tmp ;120
			Global_jsrrts Actor___createX ;121
		@continue: ;122
		inx ;123
		cpx #Actor_PARTICLE__INDEX__START+Actor_MAX__PARTICLES ;124
		bne @loop ;125
	rts ;126
 ;127
 ;128
Actor_knockback: ;129
 ;130
	sta Actor_vx,x ;131
	lda Actor_knockback___vy ;132
	sta Actor_vy,x ;133
	lda #10 ;134
	sta Actor_lostControl,x ;135
	rts ;136
 ;137
Actor_knockbackY: ;138
 ;139
	sta Actor_vx,y ;140
	lda Actor_knockbackY___vy ;141
	sta Actor_vy,y ;142
	lda #10 ;143
	sta Actor_lostControl,y ;144
	rts ;145
 ;146
;义 ;147
 ;148
Actor_damage: ;149
.pushseg
.bss
	Actor_damage_amount: .res 1 ;150
.popseg
	sta Actor_damage_amount ;151
	lda Actor_invincibility,x ;152
	bne @end ;153
	lda Actor_damage_amount ;154
	sta Ai_arg0 ;155
	Ai_call #Ai_EVENT_DAMAGE ;156
	lda Ai_result ;157
	cmp #Ai_RESULT_DAMAGED ;158
	beq @damaged ;159
	cmp #Ai_RESULT_DAMAGED__NO__KNOCKBACK ;160
	beq @damaged ;161
		@end: ;162
		rts ;163
	@damaged: ;164
		lda #Actor_INVINCIBILITY__TIME ;165
		sta Actor_invincibility,x ;166
		rts ;167
 ;168
;	lda Actor.hp,x ;169
;	sec ;170
;	sbc amount ;171
;	sta Actor.hp,x ;172
;	beq @destroy ;173
;	bmi @destroy ;174
;	@end: ;175
;	rts ;176
;	@destroy: ;177
;		jsr createExplosion ;178
;		jsrrts destroy ;179
 ;180
 ;181
Actor_damageY: ;182
.pushseg
.bss
	Actor_damageY_tmpX: .res 1 ;183
	Actor_damageY_tmpY: .res 1 ;184
.popseg
	sty Actor_damageY_tmpY ;185
	stx Actor_damageY_tmpX ;186
	ldx Actor_damageY_tmpY ;187
	jsr Actor_damage ;188
	ldx Actor_damageY_tmpX ;189
	ldy Actor_damageY_tmpY ;190
	rts ;191
 ;192
 ;193
Actor_createExplosion: ;194
.pushseg
.bss
	Actor_createExplosion_tmpX: .res 1 ;195
.popseg
	lda Actor_px,x ;196
	pha ;197
	lda Actor_py,x ;198
	pha ;199
	stx Actor_createExplosion_tmpX ;200
	Actor_createParticle #Data_Actor_ID__EXPLOSION ;201
	Actor_setAnimation Data_Animation_EXPLOSION ;202
	pla ;203
	sta Actor_py,x ;204
	pla ;205
	sta Actor_px,x ;206
	ldx Actor_createExplosion_tmpX ;207
	rts ;208
 ;209
 ;210
 ;211
 ;212
 ;213
 ;214
 ;215
 ;216
 ;217
 ;218
 ;219
 ;220
 ;221
 ;222
Actor___setAnimation: ;223
.pushseg
.zeropage
	Actor___setAnimation_tmp: .res 1 ;224
.popseg
	sta Actor___setAnimation_tmp ;225
	cmp Actor_animationAddrL,x ;226
	bne @set ;227
	tya ;228
	cmp Actor_animationAddrH,x ;229
	beq @end ;230
	@set: ;231
		tya ;232
		sta Actor_animationAddrH,x ;233
		lda Actor___setAnimation_tmp ;234
		sta Actor_animationAddrL,x ;235
		lda #0 ;236
		sta Actor_animationIndex,x ;237
	@end: ;238
	rts ;239
 ;240
 ;241
Actor_destroy: ;242
	lda Actor_id,x ;243
	beq @end ;244
		Ai_call #Ai_EVENT_DESTROY ;245
		lda #0 ;246
		sta Actor_id,x ;247
	@end: ;248
	rts ;249
 ;250
Actor_destroyY: ;251
.pushseg
.bss
	Actor_destroyY_tmpX: .res 1 ;252
	Actor_destroyY_tmpY: .res 1 ;253
.popseg
	sty Actor_destroyY_tmpY ;254
	stx Actor_destroyY_tmpX ;255
	ldx Actor_destroyY_tmpY ;256
	jsr Actor_destroy ;257
	ldx Actor_destroyY_tmpX ;258
	ldy Actor_destroyY_tmpY ;259
	rts ;260
 ;261
 ;262
Actor_destroyAllButHero: ;263
	ldx #Actor_INDEX__HERO+1 ;264
	@loop: ;265
		jsr Actor_destroy ;266
		inx ;267
		cpx #Actor_MAX__ACTORS ;268
		bne @loop ;269
	rts ;270
 ;271
 ;272
Actor_updateAnimation: ;273
.pushseg
.zeropage
	Actor_updateAnimation_tmp: .res 1 ;274
	Actor_updateAnimation_animationAddr: .res 2 ;275
.popseg
	lda Actor_animationAddrH,x ;276
	beq @end ;277
		sta Actor_updateAnimation_animationAddr+1 ;278
		lda Actor_animationAddrL,x ;279
		sta Actor_updateAnimation_animationAddr ;280
		@again: ;281
		ldy Actor_animationIndex,x ;282
		tya ;283
		lda (Actor_updateAnimation_animationAddr),y ;284
		bpl @skipRewind ;285
			clc ;286
			adc Actor_animationIndex,x ;287
			sta Actor_animationIndex,x ;288
			jmp @again ;289
		@skipRewind: ;290
		sta Actor_animationFrame,x ;291
		inc Actor_animationIndex,x ;292
	@end: ;293
	rts ;294
 ;295
 ;296
Actor_updateAll: ;297
	lda #0 ;298
	sta Actor_oamIndex ;299
	ldx #Actor_MAX__ACTORS-1 ;300
	@loop: ;301
		lda Actor_id,x ;302
		beq @continue ;303
			lda Game_screenChangeTimer ;304
			bne @display ;305
				lda Actor_lostControl,x ;306
				bne @skipAi ;307
					Ai_call #Ai_EVENT_UPDATE ;308
					;ai can destroy actor, so check for id again ;309
					lda Actor_id,x ;310
					beq @continue ;311
				@skipAi: ;312
				jsr Actor_updatePhysics ;313
				lda Actor_flags,x ;314
				and #Actor_FLAG_NO__MAP__COLLISION ;315
				bne @skipMapCollision ;316
					jsr Map_doCollision ;317
				@skipMapCollision: ;318
				cpx #Actor_INDEX__WEAPON+1 ;319
				bcs @skipEnemyCollisions ;320
					jsr Actor_doEnemyCollisions ;321
				@skipEnemyCollisions: ;322
 ;323
				lda Actor_invincibility,x ;324
				beq @skipInvincibilityTimer ;325
					dec Actor_invincibility,x ;326
				@skipInvincibilityTimer: ;327
				lda Actor_lostControl,x ;328
				beq @skipLostControlTimer ;329
					dec Actor_lostControl,x ;330
				@skipLostControlTimer: ;331
			@display: ;332
			jsr Actor_updateAnimation ;333
			jsr Actor_writeOam ;334
		@continue: ;335
		dex ;336
		bpl @loop ;337
 ;338
	ldx Actor_oamIndex ;339
	lda #$FF ;340
	@fillOam: ;341
		sta Global_oam,x ;342
		inx ;343
		bne @fillOam ;344
	@end: ;345
	rts ;346
 ;347
 ;348
Actor_doEnemyCollisions: ;349
	ldy #Actor_ENEMY__INDEX__START ;350
	@loop: ;351
		lda Actor_id,y ;352
		beq @continue ;353
			lda Actor_px,x ;354
			clc ;355
			adc #8 ;356
			sec ;357
			sbc Actor_px,y ;358
			cmp #16 ;359
			bcs @continue ;360
 ;361
			lda Actor_py,x ;362
			clc ;363
			adc #8 ;364
			sec ;365
			sbc Actor_py,y ;366
			cmp #16 ;367
			bcs @continue ;368
 ;369
			sty Ai_arg0 ;370
			Ai_call #Ai_EVENT_COLLIDE ;371
			ldy Ai_arg0 ;372
			rts ;373
		@continue: ;374
		iny ;375
		cpy #Actor_MAX__ACTORS ;376
		bne @loop ;377
	rts ;378
 ;379
 ;380
Actor_updatePhysics: ;381
	lda Actor_px,x ;382
	clc ;383
	adc Actor_vx,x ;384
	sta Actor_px,x ;385
 ;386
	lda Actor_py,x ;387
	clc ;388
	adc Actor_vy,x ;389
	sta Actor_py,x ;390
	rts ;391
 ;392
 ;393
Actor_writeOam: ;394
.pushseg
.zeropage
	Actor_writeOam_gfxAddr: .res 2 ;395
	Actor_writeOam_tmpX: .res 1 ;396
	Actor_writeOam_tmpY: .res 1 ;397
	Actor_writeOam_tmpPx: .res 1 ;398
	Actor_writeOam_tileIndex: .res 1 ;399
	Actor_writeOam_attributes: .res 1 ;400
	Actor_writeOam_animationAddr: .res 2 ;401
	Actor_writeOam_tileXAddr: .res 2 ;402
	Actor_writeOam_tileYAddr: .res 2 ;403
.popseg
 ;404
	lda Actor_invincibility,x ;405
	lsr a ;406
	and #1 ;407
	beq @continue ;408
		rts ;409
	@continue: ;410
 ;411
	ldy Actor_id,x ;412
	lda Data_Actor_SIZE,y ;413
	bne Actor_writeOam_write16x16 ;414
 ;415
	Actor_writeOam_write8x8: ;416
		lda Actor_flags,x ;417
		and #$03 ;418
		sta Actor_writeOam_attributes ;419
 ;420
		;gfxAddr = GFX + animationIndex*1 ;421
			lda Actor_id,x ;422
			asl a ;423
			tay ;424
			lda Actor_animationFrame,x ;425
			and #$3F ;426
			clc ;427
			adc Data_Actor_GFX,y ;428
			sta Actor_writeOam_gfxAddr ;429
			lda Data_Actor_GFX+1,y ;430
			adc #0 ;431
			sta Actor_writeOam_gfxAddr+1 ;432
 ;433
		lda #256-4 ;434
		clc ;435
		adc Actor_px,x ;436
		sta Actor_writeOam_tmpPx ;437
 ;438
		ldy #0 ;439
		lda (Actor_writeOam_gfxAddr),y ;440
		sta Actor_writeOam_tileIndex ;441
 ;442
		lda #256-4 - 1 ;443
		clc ;444
		adc Actor_py,x ;445
		Global_jsrrts Actor_writeOam_writeTile ;446
 ;447
	Actor_writeOam_write16x16: ;448
		lda Actor_animationFrame,x ;449
		and #$40 ;450
		bne @hflip ;451
		@noFlip: ;452
			lda #<Actor_writeOam_TILE__X ;453
			sta Actor_writeOam_tileXAddr ;454
			lda #>Actor_writeOam_TILE__X ;455
			sta Actor_writeOam_tileXAddr+1 ;456
			lda #<Actor_writeOam_TILE__Y ;457
			sta Actor_writeOam_tileYAddr ;458
			lda #>Actor_writeOam_TILE__Y ;459
			sta Actor_writeOam_tileYAddr+1 ;460
			lda Actor_flags,x ;461
			and #$03 ;462
			sta Actor_writeOam_attributes ;463
			jmp @skipFlip ;464
		@hflip: ;465
			lda #<Actor_writeOam_TILE__X__HFLIP ;466
			sta Actor_writeOam_tileXAddr ;467
			lda #>Actor_writeOam_TILE__X__HFLIP ;468
			sta Actor_writeOam_tileXAddr+1 ;469
			lda #<Actor_writeOam_TILE__Y__HFLIP ;470
			sta Actor_writeOam_tileYAddr ;471
			lda #>Actor_writeOam_TILE__Y__HFLIP ;472
			sta Actor_writeOam_tileYAddr+1 ;473
			lda Actor_flags,x ;474
			and #$03 ;475
			ora #%01000000 ;476
			sta Actor_writeOam_attributes ;477
		@skipFlip: ;478
 ;479
		;gfxAddr = GFX + animationIndex*4 ;480
			lda Actor_id,x ;481
			asl a ;482
			tay ;483
			lda Actor_animationFrame,x ;484
			and #$3F ;485
			asl a ;486
			asl a ;487
			clc ;488
			adc Data_Actor_GFX,y ;489
			sta Actor_writeOam_gfxAddr ;490
			lda Data_Actor_GFX+1,y ;491
			adc #0 ;492
			sta Actor_writeOam_gfxAddr+1 ;493
 ;494
		ldy #0 ;495
		@loopThroughTiles: ;496
			lda (Actor_writeOam_tileXAddr),y ;497
			clc ;498
			adc Actor_px,x ;499
			sta Actor_writeOam_tmpPx ;500
 ;501
			sty Actor_writeOam_tmpY ;502
			ldy #0 ;503
			lda (Actor_writeOam_gfxAddr),y ;504
			Global_inc16 Actor_writeOam_gfxAddr ;505
			sta Actor_writeOam_tileIndex ;506
			ldy Actor_writeOam_tmpY ;507
 ;508
			lda (Actor_writeOam_tileYAddr),y ;509
			clc ;510
			adc Actor_py,x ;511
			sec ;512
			sbc #1 ;513
			jsr Actor_writeOam_writeTile ;514
 ;515
			iny ;516
			cpy #4 ;517
			bne @loopThroughTiles ;518
		rts ;519
 ;520
		Actor_writeOam_TILE__X: .byte 256-8,0,256-8,0 ;521
		Actor_writeOam_TILE__Y: .byte 256-8,256-8,0,0 ;522
		Actor_writeOam_TILE__X__HFLIP: .byte 0,256-8,0,256-8 ;523
		Actor_writeOam_TILE__Y__HFLIP: .byte 256-8,256-8,0,0 ;524
 ;525
 ;526
	Actor_writeOam_writeTile: ;a(in:py) ;527
		stx Actor_writeOam_tmpX ;528
		ldx Actor_oamIndex ;529
		;byte 0 - y ;530
			sta Global_oam,x ;531
			inx ;532
		;byte 1 - tile index ;533
			lda Actor_writeOam_tileIndex ;534
			sta Global_oam,x ;535
			inx ;536
		;byte 2 - attributes ;537
			lda Actor_writeOam_attributes ;538
			sta Global_oam,x ;539
			inx ;540
		;byte 3 - x ;541
			lda Actor_writeOam_tmpPx ;542
			sta Global_oam,x ;543
			inx ;544
		stx Actor_oamIndex ;545
		ldx Actor_writeOam_tmpX ;546
		rts ;547
 ;548
 ;549
 ;550
Actor_getTx: ;551
	lda Actor_px,x ;552
	lsr a ;553
	lsr a ;554
	lsr a ;555
	lsr a ;556
	rts ;557
 ;558
 ;559
Actor_getTy: ;560
	lda Actor_py,x ;561
	sec ;562
	sbc #16 ;563
	lsr a ;564
	lsr a ;565
	lsr a ;566
	lsr a ;567
	rts ;568
 ;569
 ;570
