.include "obj/Ai/Ghost.h"
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
 ;5
 ;6
 ;7
 ;8
 ;9
 ;10
 ;11
 ;12
Ai_Ghost_run: ;13
	Ai_switch Ai_Ghost_update,Ai_Ghost_create,,Ai_Ghost_damage,Ai_Ghost_destroy ;14
	rts ;15
 ;16
 ;17
Ai_Ghost_update: ;18
 ;19
 ;20
 ;21
	lda Ai_Ghost_state,x ;22
	cmp #Ai_Ghost_STATE__ATTACK ;23
	beq Ai_Ghost_update_attack ;24
	Ai_Ghost_update_idle: ;25
		jsr Ai_Util_getDistanceFromHero ;26
		cmp #$50 ;27
		bcs @end ;28
			lda #Ai_Ghost_STATE__ATTACK ;29
			sta Ai_Ghost_state,x ;30
		@end: ;31
		rts ;32
	Ai_Ghost_update_attack: ;33
		lda #0 ;34
		sta Actor_vx,x ;35
		sta Actor_vy,x ;36
		lda Global_frameCount ;37
		and #1 ;38
		bne @skipMovement ;39
			Ai_Util_moveTowardsHero #1 ;40
		@skipMovement: ;41
 ;42
		lda Actor_direction,x ;43
		cmp #Actor_DIRECTION__RIGHT ;44
		beq @right ;45
		@left: ;46
			Actor_setAnimation Data_Animation_GHOST__ATTACK__LEFT ;47
			rts ;48
		@right: ;49
			Actor_setAnimation Data_Animation_GHOST__ATTACK__RIGHT ;50
			rts ;51
 ;52
 ;53
Ai_Ghost_create: ;54
	Ai_Util_createShadow #20 ;55
	tya ;56
	sta Ai_Ghost_shadowIndex,x ;57
 ;58
	lda #Ai_Ghost_STATE__IDLE ;59
	sta Ai_Ghost_state,x ;60
	Actor_setFlags Actor_FLAG_NO__MAP__COLLISION ;61
	Actor_setAnimation Data_Animation_GHOST__FLOAT ;62
	rts ;63
 ;64
Ai_Ghost_damage: ;65
	lda Ai_arg0 ;66
	Global_jsrrts Ai_Util_damage ;67
 ;68
Ai_Ghost_destroy: ;69
	txa ;70
	pha ;71
	lda Ai_Ghost_shadowIndex,x ;72
	bmi @end ;73
		tax ;74
		jsr Actor_destroy ;75
	@end: ;76
	pla ;77
	tax ;78
	rts ;79
