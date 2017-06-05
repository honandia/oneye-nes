.include "obj/Map.h"
.include "obj/Global.h"
.include "obj/Ppu.h"
.include "obj/Data/Tileset.h"
.include "obj/Data/Map.h"
.include "obj/Actor.h"
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
 ;8
 ;9
 ;10
 ;11
 ;12
 ;13
 ;14
 ;15
.pushseg
.zeropage
Map_collisionPointDx: .res 1 ;16
Map_collisionPointDy: .res 1 ;17
Map_collisionTileX: .res 1 ;18
Map_collisionTileY: .res 1 ;19
.popseg
.pushseg
.bss
Map_map: .res 256 ;20
.popseg
.pushseg
.zeropage
Map_worldIndex: .res 1 ;21
.popseg
 ;22
 ;23
Map_loadScreen: ;24
	lda Map_worldIndex ;25
	asl a ;26
	tay ;27
	lda Data_Map_LIST,y ;28
	sta Map_load_addr ;29
	lda Data_Map_LIST+1,y ;30
	sta Map_load_addr+1 ;31
	Global_jsrrts Map_load ;32
 ;33
 ;34
Map_load: ;35
.pushseg
.zeropage
	Map_load_addr: .res 2 ;(in) ;36
.popseg
.pushseg
.bss
	Map_load_attributes: .res 1 ;37
	Map_load_tmpPx: .res 1 ;38
	Map_load_tmpPy: .res 1 ;39
	Map_load_tmpId: .res 1 ;40
.popseg
 ;41
	lda #20 ;42
	sta Game_screenChangeTimer ;freeze actors for a bit after changing screen ;43
	lda #0 ;44
	lda Ai_Hero_vx ;45
	lda Ai_Hero_vy ;46
 ;47
	jsr Actor_destroyAllButHero ;48
 ;49
	jsr Ppu_disableVideo ;50
	ldy #0 ;51
	@loop: ;52
		lda (Map_load_addr),y ;53
		sta Map_map+$10,y ;54
		iny ;55
		cpy #Map_MAP__W*Map_MAP__H ;56
		bne @loop ;57
	ldy #Map_MAP__W*Map_MAP__H+16 ;58
	lda #Map_BORDER__TILE ;59
	;clear bottom and top ;60
	@fill: ;61
		sta Map_map,y ;62
		iny ;63
		;cpy #240 ;64
		cpy #16 ;65
		bne @fill ;66
 ;67
	Map_load_displayTiles: ;68
		Ppu_setAddr $2000 ;69
		ldx #0 ;70
		@loop: ;71
			@evenRow: ;72
				ldy Map_map,x ;73
				lda Data_Tileset_TILE0,y ;74
				sta Global_PPUDATA ;75
				lda Data_Tileset_TILE1,y ;76
				sta Global_PPUDATA ;77
				inx ;78
				txa ;79
				and #$0F ;80
				bne @evenRow ;81
			txa ;82
			sec ;83
			sbc #16 ;84
			tax ;85
			@oddRow: ;86
				ldy Map_map,x ;87
				lda Data_Tileset_TILE2,y ;88
				sta Global_PPUDATA ;89
				lda Data_Tileset_TILE3,y ;90
				sta Global_PPUDATA ;91
				inx ;92
				txa ;93
				and #$0F ;94
				bne @oddRow ;95
			;cpx #MAP_W*MAP_H+16 ;96
			cpx #240 ;97
			bne @loop ;98
 ;99
	Map_load_setAttributes: ;100
		Ppu_setAddr $23C0 ;101
		ldx #0 ;102
		@loop: ;103
			ldy Map_map+$11,x ;104
			lda Data_Tileset_PALETTE,y ;105
			jsr @oraAttributes ;106
			ldy Map_map+$10,x ;107
			lda Data_Tileset_PALETTE,y ;108
			jsr @oraAttributes ;109
			ldy Map_map+1,x ;110
			lda Data_Tileset_PALETTE,y ;111
			jsr @oraAttributes ;112
			ldy Map_map,x ;113
			lda Data_Tileset_PALETTE,y ;114
			jsr @oraAttributes ;115
			sta Global_PPUDATA ;116
			inx ;117
			inx ;118
			txa ;119
			and #$0F ;120
			bne @loop ;121
			txa ;122
			clc ;123
			adc #16 ;124
			tax ;125
			cmp #Map_MAP__W*Map_MAP__H+32 ;126
			;cmp #MAP_W*MAP_H+40 ;127
			bcc @loop ;128
		ldx #8 ;129
		lda #$FF ;130
		@clearBottom: ;131
			sta Global_PPUDATA ;132
			dex ;133
			bne @clearBottom ;134
 ;135
	lda #0 ;136
	sta Global_PPUSCROLL ;137
	sta Global_PPUSCROLL ;138
 ;139
	jsr Ppu_enableVideo ;140
 ;141
	jmp Map_load_spawnEnemies ;142
 ;143
	@oraAttributes: ;144
		asl Map_load_attributes ;145
		asl Map_load_attributes ;146
		ora Map_load_attributes ;147
		sta Map_load_attributes ;148
		rts ;149
 ;150
	Map_load_spawnEnemies: ;151
		ldy #0 ;152
		clc ;153
		Global_adc16 Map_load_addr,,#Map_MAP__W*Map_MAP__H ;154
		@loop: ;155
			;byte 0 - id ;156
				lda (Map_load_addr),y ;157
				beq @end ;158
				sta Map_load_tmpId ;159
				iny ;160
			;byte 1 - tx ;161
				lda (Map_load_addr),y ;162
				asl a ;163
				asl a ;164
				asl a ;165
				asl a ;166
				clc ;167
				adc #8 ;168
				sta Map_load_tmpPx ;169
				iny ;170
			;byte 2 - ty ;171
				lda (Map_load_addr),y ;172
				asl a ;173
				asl a ;174
				asl a ;175
				asl a ;176
				clc ;177
				adc #8+16 ;178
				sta Map_load_tmpPy ;179
				iny ;180
			tya ;181
			pha ;182
			Actor_createEnemy Map_load_tmpId ;183
			lda Map_load_tmpPx ;184
			sta Actor_px,x ;185
			lda Map_load_tmpPy ;186
			sta Actor_py,x ;187
			pla ;188
			tay ;189
			jmp @loop ;190
		@end: ;191
		rts ;192
 ;193
 ;194
 ;195
 ;196
 ;197
 ;198
 ;199
Map___getTileFlags: ;200
.pushseg
.zeropage
	Map___getTileFlags_tmp: .res 1 ;201
.popseg
	sta Map_collisionPointDx ;202
	sty Map_collisionPointDy ;203
	;tx = (px+dx)/16 ;204
		clc ;205
		adc Actor_px,x ;206
		lsr a ;207
		lsr a ;208
		lsr a ;209
		lsr a ;210
		sta Map___getTileFlags_tmp ;211
		asl a ;212
		asl a ;213
		asl a ;214
		asl a ;215
		sta Map_collisionTileX ;216
	;ty*16 = int((py+dy)/16) * 16 ;217
		tya ;218
		clc ;219
		adc Actor_py,x ;220
		and #$F0 ;221
		sta Map_collisionTileY ;222
	;map index ;223
		clc ;224
		adc Map___getTileFlags_tmp ;225
		tay ;226
	lda Map_map,y ;227
	tay ;228
	lda Data_Tileset_FLAGS,y ;229
	rts ;230
 ;231
 ;232
 ;233
 ;234
 ;235
 ;236
 ;237
Map___notSolid: ;238
	jsr Map___getTileFlags ;239
	and #Data_Tileset_FLAG__SOLID ;240
	rts ;241
 ;242
 ;243
;collision points: ;244
 ;245
 ;246
 ;247
 ;248
 ;249
 ;250
 ;251
 ;252
 ;253
 ;254
 ;255
 ;256
 ;257
;A----B ;258
;|    | ;259
;|    | ;260
;C----D ;261
Map_doCollision: ;262
 ;263
	lda Actor_vx,x ;264
	beq @skipHorizontal ;265
	bmi @left ;266
	@right: ;B,D ;267
		Map_notSolid #Map_POINT__B__X,#Map_POINT__B__Y+1 ;268
		bne @ejectLeft ;269
		Map_notSolid #Map_POINT__D__X,#Map_POINT__D__Y-1 ;270
		bne @ejectLeft ;271
		jmp @skipHorizontal ;272
	@left: ;A,C ;273
		Map_notSolid #Map_POINT__A__X,#Map_POINT__A__Y+1 ;274
		bne @ejectRight ;275
		Map_notSolid #Map_POINT__C__X,#Map_POINT__C__Y-1 ;276
		bne @ejectRight ;277
	@skipHorizontal: ;278
 ;279
	lda Actor_vy,x ;280
	beq @skipVertical ;281
	bmi @up ;282
	@down: ;C,D ;283
		Map_notSolid #Map_POINT__C__X,#Map_POINT__C__Y ;284
		bne @ejectUp ;285
		Map_notSolid #Map_POINT__D__X,#Map_POINT__D__Y ;286
		bne @ejectUp ;287
		jmp @skipVertical ;288
	@up: ;A,B ;289
		Map_notSolid #Map_POINT__A__X,#Map_POINT__A__Y ;290
		bne @ejectDown ;291
		Map_notSolid #Map_POINT__B__X,#Map_POINT__B__Y ;292
		bne @ejectDown ;293
	@skipVertical: ;294
	rts ;295
 ;296
	@ejectLeft: ;297
		lda Map_collisionTileX ;298
		sec ;299
		sbc #Map_EJECT__LEFT ;300
		sta Actor_px,x ;301
		lda #0 ;302
		sta Actor_vx,x ;303
		jmp @skipHorizontal ;304
	@ejectRight: ;305
		lda Map_collisionTileX ;306
		clc ;307
		adc #Map_EJECT__RIGHT ;308
		sta Actor_px,x ;309
		lda #0 ;310
		sta Actor_vx,x ;311
		jmp @skipHorizontal ;312
 ;313
	@ejectDown: ;314
		lda Map_collisionTileY ;315
		clc ;316
		adc #Map_EJECT__DOWN ;317
		sta Actor_py,x ;318
		lda #0 ;319
		sta Actor_vy,x ;320
		jmp @skipVertical ;321
	@ejectUp: ;322
		lda Map_collisionTileY ;323
		sec ;324
		sbc #Map_EJECT__UP ;325
		sta Actor_py,x ;326
		lda #0 ;327
		sta Actor_vy,x ;328
		jmp @skipVertical ;329
 ;330
 ;331
 ;332
 ;333
 ;334
 ;335
 ;336
 ;337
Map___setTile: ;338
.pushseg
.bss
	Map___setTile_tmpTx: .res 1 ;339
	Map___setTile_tmpId: .res 1 ;340
.popseg
	;ppuAddr: .reszp 2 ;341
	sta Map___setTile_tmpId ;342
	stx Map___setTile_tmpTx ;343
	;map index = tx + ty*MAP_W + MAP_W ;344
		tya ;345
		asl a ;346
		asl a ;347
		asl a ;348
		asl a ;349
		clc ;350
		adc Map___setTile_tmpTx ;351
		adc #Map_MAP__W ;352
		tax ;353
	stx $FF ;354
 ;355
	lda Map___setTile_tmpId ;356
	sta Map_map,x ;357
 ;358
	;ppu addr = $2000 + ty*64 + tx*2 ;359
	;	lda #0 ;360
	;	sta ppuAddr+1 ;361
	;	tya ;362
	;	sta ppuAddr ;363
	;	.repeat 6 ;364
	;		asl a ;365
	;		rol ppuAddr+1 ;366
	;	.endrepeat ;367
	;	;sta ppuAddr ;368
	;	asl tmpTx ;369
	;	clc ;370
	;	adc tmpTx ;371
	;	lda ppuAddr+1 ;372
	;	adc #$20 ;373
	;	sta ppuAddr+1 ;374
 ;375
	;Ppu.setAddr ppuAddr ;376
	rts ;377
 ;378
