.include "obj/Ai/Hero.h"
.include "obj/Global.h"
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
.include "obj/Actor.h"
.include "obj/Data/Animation.h"
.include "obj/Data/Actor.h"
.include "obj/Map.h"
.include "obj/Game.h"
.include "obj/MapScript.h"
 ;9
 ;10
 ;11
 ;12
 ;13
 ;14
 ;15
 ;16
 ;17
Ai_Hero_run: ;18
	Ai_switch Ai_Hero_update, Ai_dummy, Ai_Hero_collide, Ai_Hero_damage ;19
	rts ;20
 ;21
 ;22
Ai_Hero_update: ;23
	jsr Ai_Hero_handleInput ;24
 ;25
	lda Actor_direction,x ;26
	asl a ;27
	tay ;28
	lda Global_joy1 ;29
	and #Global_JOY__LEFT|Global_JOY__UP|Global_JOY__RIGHT|Global_JOY__DOWN ;30
	bne @walking ;31
		lda Ai_Hero_update_IDLE__ANIMATIONS,y ;32
		pha ;33
		lda Ai_Hero_update_IDLE__ANIMATIONS+1,y ;34
		tay ;35
		pla ;36
		jsr Actor___setAnimation ;37
		jmp @skipAnimation ;38
	@walking: ;39
		lda Ai_Hero_update_WALKING__ANIMATIONS,y ;40
		pha ;41
		lda Ai_Hero_update_WALKING__ANIMATIONS+1,y ;42
		tay ;43
		pla ;44
		jsr Actor___setAnimation ;45
	@skipAnimation: ;46
 ;47
	Global_jsrrts Ai_Hero_checkForScreenChange ;48
 ;49
	Ai_Hero_update_IDLE__ANIMATIONS: .addr Data_Animation_HERO__IDLE__LEFT,Data_Animation_HERO__IDLE__UP,Data_Animation_HERO__IDLE__RIGHT,Data_Animation_HERO__IDLE__DOWN ;50
	Ai_Hero_update_WALKING__ANIMATIONS: .addr Data_Animation_HERO__WALK__LEFT,Data_Animation_HERO__WALK__UP,Data_Animation_HERO__WALK__RIGHT,Data_Animation_HERO__WALK__DOWN ;51
 ;52
 ;53
Ai_Hero_checkForScreenChange: ;54
	ldy Global_joy1 ;55
	tya ;56
	and #Global_JOY__RIGHT ;57
	beq @skipRight ;58
		lda Ai_Hero_px ;59
		cmp #256-10 ;60
		bcs @right ;61
	@skipRight: ;62
	tya ;63
	and #Global_JOY__LEFT ;64
	beq @skipLeft ;65
		lda Ai_Hero_px ;66
		cmp #10 ;67
		bcc @left ;68
	@skipLeft: ;69
	tya ;70
	and #Global_JOY__DOWN ;71
	beq @skipDown ;72
		lda Ai_Hero_py ;73
		cmp #208-10 ;74
		bcs @down ;75
	@skipDown: ;76
	tya ;77
	and #Global_JOY__UP ;78
	beq @skipUp ;79
		lda Ai_Hero_py ;80
		cmp #16+8 ;81
		bcc @up ;82
	@skipUp: ;83
	rts ;84
	@left: ;85
		lda #256-8 ;86
		sta Ai_Hero_px ;87
		dec Map_worldIndex ;88
		Global_jsrrts Map_loadScreen ;89
	@right: ;90
		lda #8 ;91
		sta Ai_Hero_px ;92
		inc Map_worldIndex ;93
		Global_jsrrts Map_loadScreen ;94
	@up: ;95
		lda #208-8 ;96
		sta Ai_Hero_py ;97
		lda Map_worldIndex ;98
		sec ;99
		sbc #Map_WORLD__W ;100
		sta Map_worldIndex ;101
		Global_jsrrts Map_loadScreen ;102
	@down: ;103
		lda #16+8 ;104
		sta Ai_Hero_py ;105
		lda Map_worldIndex ;106
		clc ;107
		adc #Map_WORLD__W ;108
		sta Map_worldIndex ;109
		Global_jsrrts Map_loadScreen ;110
 ;111
Ai_Hero_handleInput: ;112
 ;113
 ;114
 ;115
	lda #0 ;116
	sta Ai_Hero_vx ;117
	sta Ai_Hero_vy ;118
 ;119
	@up: ;120
		lda Global_joy1 ;121
		and #Global_JOY__UP ;122
		beq @down ;123
			lda #256-Ai_Hero_SPEED ;124
			sta Actor_vy,x ;125
			lda #Actor_DIRECTION__UP ;126
			sta Actor_direction,x ;127
	@down: ;128
		lda Global_joy1 ;129
		and #Global_JOY__DOWN ;130
		beq @left ;131
			lda #Ai_Hero_SPEED ;132
			sta Actor_vy,x ;133
			lda #Actor_DIRECTION__DOWN ;134
			sta Actor_direction,x ;135
	@left: ;136
		lda Global_joy1 ;137
		and #Global_JOY__LEFT ;138
		beq @right ;139
			lda #256-Ai_Hero_SPEED ;140
			sta Actor_vx,x ;141
			lda #Actor_DIRECTION__LEFT ;142
			sta Actor_direction,x ;143
	@right: ;144
		lda Global_joy1 ;145
		and #Global_JOY__RIGHT ;146
		beq @B ;147
			lda #Ai_Hero_SPEED ;148
			sta Actor_vx,x ;149
			lda #Actor_DIRECTION__RIGHT ;150
			sta Actor_direction,x ;151
	@B: ;152
		lda Global_joy1Press ;153
		and #Global_JOY__B ;154
		beq @end ;155
			lda Actor_id+Actor_INDEX__WEAPON ;156
			bne @end ;only shoot when old banana has returned to monkey ;157
			lda Actor_px,x ;158
			sta Ai_Hero_tmpPx ;159
			lda Actor_py,x ;160
			sta Ai_Hero_tmpPy ;161
			lda Actor_direction,x ;162
			sta Ai_Hero_tmpDirection ;163
			;ATTACK!!! ;164
			txa ;165
			pha ;166
			ldx #Actor_INDEX__WEAPON ;167
			Actor_createX #Data_Actor_ID__BANANARANG ;168
			lda Ai_Hero_tmpPx ;169
			sta Actor_px,x ;170
			lda Ai_Hero_tmpPy ;171
			sta Actor_py,x ;172
			ldy Ai_Hero_tmpDirection ;173
			lda @DIRECTION_VX,y ;174
			bmi @vxNeg ;175
			bne @vxPos ;176
				@vxZero: ;177
					lda #0 ;178
					jmp @skipVx ;179
				@vxPos: ;180
					lda Game_bananarangSpeed ;181
					jmp @skipVx ;182
				@vxNeg: ;183
					lda #0 ;184
					sec ;185
					sbc Game_bananarangSpeed ;186
			@skipVx: ;187
			sta Actor_vx,x ;188
			lda @DIRECTION_VY,y ;189
			bmi @vyNeg ;190
			bne @vyPos ;191
				@vyZero: ;192
					lda #0 ;193
					jmp @skipVy ;194
				@vyPos: ;195
					lda Game_bananarangSpeed ;196
					jmp @skipVy ;197
				@vyNeg: ;198
					lda #0 ;199
					sec ;200
					sbc Game_bananarangSpeed ;201
			@skipVy: ;202
			sta Actor_vy,x ;203
			lda #15 ;204
			sta Actor_timer,x ;205
			;Actor.setAnimation Data.Animation.BANANARANG_FLY ;206
			pla ;207
			tax ;208
	@end: ;209
	rts ;210
	@DIRECTION_VX: .byte 256-1,0,1,0 ;211
	@DIRECTION_VY: .byte 0,256-1,0,1 ;212
 ;213
 ;214
Ai_Hero_collide: ;arg0:enemy ;215
	ldy Ai_arg0 ;216
	lda Actor_id,y ;217
	sty $FD ;218
	sta $FF ;219
	inc $FE ;220
	cmp #Data_Actor_ID__POWERUP ;221
	bne @enemy ;222
		jsr Actor_destroyY ;223
		Global_jsrrts MapScript_collectPowerup ;224
	@enemy: ;225
	lda Actor_invincibility,x ;226
	bne @end ;227
		lda #1 ;228
		jsr Actor_damage ;229
		lda Actor_vy,y ;230
		sta Actor_knockback___vy ;231
		lda Actor_vx,y ;232
		jsr Actor_knockback ;233
		lda #90 ;234
		sta Actor_invincibility,x ;235
	@end: ;236
	rts ;237
 ;238
Ai_Hero_damage: ;239
	lda Ai_arg0 ;240
	Global_jsrrts Ai_Util_damage ;241
