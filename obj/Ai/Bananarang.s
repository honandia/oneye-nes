.include "obj/Ai/Bananarang.h"
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
.include "obj/Game.h"
 ;6
 ;7
 ;8
 ;9
 ;10
 ;11
 ;12
Ai_Bananarang_run: ;13
	Ai_switch Ai_Bananarang_update,Ai_Bananarang_create,Ai_Bananarang_collide ;14
	rts ;15
 ;16
 ;17
Ai_Bananarang_update: ;18
	lda Ai_Bananarang_state,x ;19
	bne Ai_Bananarang_update_return ;20
	Ai_Bananarang_update_fly: ;21
		dec Actor_timer,x ;22
		bne @skipDestroy ;23
			lda #Ai_Bananarang_STATE__RETURN ;24
			sta Ai_Bananarang_state,x ;25
		@skipDestroy: ;26
		rts ;27
	Ai_Bananarang_update_return: ;28
		lda Ai_Hero_px ;29
		clc ;30
		adc #6 ;31
		sec ;32
		sbc Actor_px,x ;33
		cmp #8 ;34
		bcs @skipDestroy ;35
		lda Ai_Hero_py ;36
		clc ;37
		adc #6 ;38
		sec ;39
		sbc Actor_py,x ;40
		cmp #8 ;41
		bcs @skipDestroy ;42
			Global_jsrrts Actor_destroy ;43
		@skipDestroy: ;44
 ;45
		@vertical: ;46
			lda Ai_Hero_px ;47
			clc ;48
			adc #4 ;49
			cmp Actor_px,x ;50
			bcc @left ;51
			lda Ai_Hero_px ;52
			sec ;53
			sbc #4 ;54
			cmp Actor_px,x ;55
			bcc @horizontal ;56
			@right: ;57
				lda Game_bananarangSpeed ;58
				sta Actor_vx,x ;59
				bne @horizontal ;guaranteed branch ;60
			@left: ;61
				lda #0 ;62
				sec ;63
				sbc Game_bananarangSpeed ;64
				sta Actor_vx,x ;65
		@horizontal: ;66
			lda Ai_Hero_py ;67
			clc ;68
			adc #4 ;69
			cmp Actor_py,x ;70
			bcc @up ;71
			lda Ai_Hero_py ;72
			sec ;73
			sbc #4 ;74
			cmp Actor_py,x ;75
			bcc @end ;76
			@down: ;77
				lda Game_bananarangSpeed ;78
				sta Actor_vy,x ;79
				bne @end ;guaranteed branch ;80
			@up: ;81
				lda #0 ;82
				sec ;83
				sbc Game_bananarangSpeed ;84
				sta Actor_vy,x ;85
		@end: ;86
		rts ;87
 ;88
 ;89
Ai_Bananarang_create: ;90
	lda #Ai_Bananarang_STATE__FLY ;91
	sta Ai_Bananarang_state,x ;92
	Actor_setFlags Actor_FLAG_NO__MAP__COLLISION ;93
	Actor_setAnimation Data_Animation_BANANARANG__FLY ;94
	rts ;95
 ;96
Ai_Bananarang_collide: ;arg0(in:enemy) ;97
	ldy Ai_arg0 ;98
	lda Actor_invincibility,y ;99
	bne @end ;100
		lda Game_bananarangPower ;101
		jsr Actor_damageY ;102
		lda Ai_result ;103
		cmp #Ai_RESULT_INVINCIBLE ;104
		beq @invincible ;105
		cmp #Ai_RESULT_PASS__THROUGH ;106
		beq @passThrough ;107
		cmp #Ai_RESULT_DAMAGED__NO__KNOCKBACK ;108
		beq @invincible ;109
		@damaged: ;110
			lda #Ai_Bananarang_STATE__RETURN ;111
			sta Ai_Bananarang_state,x ;112
			lda Actor_vy,x ;113
			sta Actor_knockbackY___vy ;114
			lda Actor_vx,x ;115
			Global_jsrrts Actor_knockbackY ;116
		@invincible: ;deflect ;117
			lda #Ai_Bananarang_STATE__RETURN ;118
			sta Ai_Bananarang_state,x ;119
			rts ;120
		@passThrough: ;121
			rts ;122
	@end: ;123
	rts ;124
