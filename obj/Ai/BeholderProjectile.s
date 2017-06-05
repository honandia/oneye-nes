.include "obj/Ai/BeholderProjectile.h"
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
.include "obj/Map.h"
 ;6
Ai_BeholderProjectile_run: ;7
	Ai_switch Ai_BeholderProjectile_update,Ai_BeholderProjectile_create,,Ai_BeholderProjectile_damage ;8
	rts ;9
 ;10
 ;11
Ai_BeholderProjectile_update: ;12
	dec Actor_timer,x ;13
	beq @skipDestroy ;14
	lda Actor_py,x ;15
	cmp #Map_MAP__H*16+16 ;16
	bcc @skipDestroy ;17
	@destroy: ;18
		Global_jsrrts Actor_destroy ;19
	@skipDestroy: ;20
	rts ;21
 ;22
 ;23
Ai_BeholderProjectile_create: ;24
	lda #60 ;25
	sta Actor_timer,x ;26
	Actor_setFlags Actor_FLAG_NO__MAP__COLLISION ;27
	Actor_setAnimation Data_Animation_NONE ;28
	rts ;29
 ;30
Ai_BeholderProjectile_damage: ;31
	lda #Ai_RESULT_PASS__THROUGH ;32
	sta Ai_result ;33
	rts ;34
