.include "obj/Ai/GorillaHand.h"
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
Ai_GorillaHand_run: ;7
	Ai_switch Ai_GorillaHand_update,Ai_GorillaHand_create,,Ai_GorillaHand_damage ;8
	rts ;9
 ;10
 ;11
Ai_GorillaHand_update: ;12
	rts ;13
 ;14
 ;15
Ai_GorillaHand_create: ;16
	Actor_setFlags Actor_FLAG_NO__MAP__COLLISION ;17
	Actor_setAnimation Data_Animation_GORILLA__HAND__RIGHT ;18
	cpx #Actor_ENEMY__INDEX__START+2 ;19
	bcc @end ;20
		Actor_setAnimation Data_Animation_GORILLA__HAND__LEFT ;21
	@end: ;22
	rts ;23
 ;24
Ai_GorillaHand_damage: ;25
	lda #Ai_RESULT_PASS__THROUGH ;26
	sta Ai_result ;27
	rts ;28
