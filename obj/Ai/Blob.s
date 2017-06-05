.include "obj/Ai/Blob.h"
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
Ai_Blob_run: ;6
	Ai_switch Ai_Blob_update,Ai_Blob_create,,Ai_Blob_damage ;7
	rts ;8
 ;9
 ;10
Ai_Blob_update: ;11
	lda #0 ;12
	sta Actor_vx,x ;13
	sta Actor_vy,x ;14
	lda Global_frameCount ;15
	and #3 ;16
	bne @end ;17
		Ai_Util_moveTowardsHero #1 ;18
	@end: ;19
	rts ;20
 ;21
 ;22
Ai_Blob_create: ;23
	Actor_setAnimation Data_Animation_BLOB__WALK ;24
	rts ;25
 ;26
Ai_Blob_damage: ;27
	lda Ai_arg0 ;28
	Global_jsrrts Ai_Util_damage ;29
 ;30
