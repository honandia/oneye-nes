.include "obj/Ai/Powerup.h"
.include "obj/Actor.h"
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
.include "obj/Data/Animation.h"
 ;4
Ai_Powerup_run: ;5
	Ai_switch Ai_Powerup_update,Ai_Powerup_create,,Ai_Powerup_damage ;6
	rts ;7
 ;8
 ;9
Ai_Powerup_update: ;10
	rts ;11
 ;12
 ;13
Ai_Powerup_create: ;14
	Actor_setFlags Actor_FLAG_NO__MAP__COLLISION ;15
	Actor_setAnimation Data_Animation_POWERUP__SPARKLE ;16
	rts ;17
 ;18
Ai_Powerup_damage: ;19
	lda #Ai_RESULT_PASS__THROUGH ;20
	sta Ai_result ;21
	rts ;22
