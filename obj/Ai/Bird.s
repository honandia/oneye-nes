.include "obj/Ai/Bird.h"
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
 ;6
 ;7
 ;8
 ;9
 ;10
 ;11
 ;12
Ai_Bird_run: ;13
	Ai_switch Ai_Bird_update,Ai_Bird_create,,Ai_Bird_damage,Ai_Bird_destroy ;14
	rts ;15
 ;16
 ;17
Ai_Bird_update: ;18
	;tmpPx = tmp1 ;19
	;tmpPy = tmp2 ;20
	;tmpX = tmp3 ;21
	lda Ai_Bird_state,x ;22
	cmp #Ai_Bird_STATE__TAKEOFF ;23
	beq Ai_Bird_update_takeoff ;24
	cmp #Ai_Bird_STATE__ATTACK ;25
	beq Ai_Bird_update_attack ;26
	Ai_Bird_update_idle: ;27
		jsr Ai_Util_getDistanceFromHero ;28
		cmp #$50 ;29
		bcs @end ;30
			Ai_Util_createShadow #4 ;31
			tya ;32
			sta Ai_Bird_shadowIndex,x ;33
 ;34
			lda #Ai_Bird_STATE__TAKEOFF ;35
			sta Ai_Bird_state,x ;36
			Actor_setAnimation Data_Animation_BIRD__FLY__LEFT ;37
			lda #20 ;38
			sta Actor_timer,x ;39
			lda #256-1 ;40
			sta Actor_vy,x ;41
		@end: ;42
		rts ;43
	Ai_Bird_update_takeoff: ;44
		ldy Ai_Bird_shadowIndex,x ;45
		lda #24 ;46
		sec ;47
		sbc Actor_timer,x ;48
		sta Ai_Shadow_verticalOffset,y ;49
 ;50
		dec Actor_timer,x ;51
		bne @end ;52
			lda #Ai_Bird_STATE__ATTACK ;53
			sta Ai_Bird_state,x ;54
		@end: ;55
		rts ;56
	Ai_Bird_update_attack: ;57
		Ai_Util_moveTowardsHero #1 ;58
		lda Actor_direction,x ;59
		cmp #Actor_DIRECTION__RIGHT ;60
		beq @right ;61
		@left: ;62
			Actor_setAnimation Data_Animation_BIRD__FLY__LEFT ;63
			rts ;64
		@right: ;65
			Actor_setAnimation Data_Animation_BIRD__FLY__RIGHT ;66
			rts ;67
 ;68
 ;69
Ai_Bird_create: ;70
	lda #Ai_Bird_STATE__IDLE ;71
	sta Ai_Bird_state,x ;72
	lda #$FF ;73
	sta Ai_Bird_shadowIndex,x ;74
	Actor_setFlags Actor_FLAG_NO__MAP__COLLISION ;75
	Actor_setAnimation Data_Animation_BIRD__IDLE ;76
	rts ;77
 ;78
Ai_Bird_damage: ;79
	lda Ai_arg0 ;80
	Global_jsrrts Ai_Util_damage ;81
 ;82
Ai_Bird_destroy: ;83
	txa ;84
	pha ;85
	lda Ai_Bird_shadowIndex,x ;86
	bmi @end ;87
		tax ;88
		jsr Actor_destroy ;89
	@end: ;90
	pla ;91
	tax ;92
	rts ;93
 ;94
