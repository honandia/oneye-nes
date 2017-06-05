.include "obj/Ai/Minotaur.h"
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
Ai_Minotaur_run: ;6
	Ai_switch Ai_Minotaur_update,Ai_Minotaur_create,,Ai_Minotaur_damage ;7
	rts ;8
 ;9
 ;10
Ai_Minotaur_update: ;11
	lda #0 ;12
	sta Actor_vx,x ;13
	sta Actor_vy,x ;14
	lda Global_frameCount ;15
	and #1 ;16
	beq @end ;17
		Ai_Util_moveTowardsHero #1 ;18
		Ai_Util_setDirectionAnimation Data_Animation_MINOTAUR__WALK__LEFT, Data_Animation_MINOTAUR__WALK__UP, Data_Animation_MINOTAUR__WALK__RIGHT, Data_Animation_MINOTAUR__WALK__DOWN ;19
	@end: ;20
	rts ;21
 ;22
 ;23
Ai_Minotaur_create: ;24
	Actor_setAnimation Data_Animation_MINOTAUR__WALK__DOWN ;25
	rts ;26
 ;27
Ai_Minotaur_damage: ;28
	lda Ai_arg0 ;29
	Global_jsrrts Ai_Util_damage ;30
 ;31
