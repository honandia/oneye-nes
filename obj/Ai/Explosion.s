.include "obj/Ai/Explosion.h"
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
Ai_Explosion_run: ;6
	Ai_switch Ai_Explosion_update,Ai_Explosion_create ;7
	rts ;8
 ;9
 ;10
Ai_Explosion_update: ;11
	dec Actor_timer,x ;12
	bne @skipDestroy ;13
		Global_jsrrts Actor_destroy ;14
	@skipDestroy: ;15
	rts ;16
 ;17
 ;18
Ai_Explosion_create: ;19
	lda #21 ;20
	sta Actor_timer,x ;21
	rts ;22
 ;23
