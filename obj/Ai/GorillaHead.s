.include "obj/Ai/GorillaHead.h"
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
.include "obj/MapScript.h"
 ;6
 ;7
Ai_GorillaHead_run: ;8
	Ai_switch Ai_GorillaHead_update,Ai_GorillaHead_create,,Ai_GorillaHead_damage ;9
	rts ;10
 ;11
 ;12
Ai_GorillaHead_update: ;13
	rts ;14
 ;15
 ;16
Ai_GorillaHead_create: ;17
	Actor_setFlags Actor_FLAG_NO__MAP__COLLISION ;18
	jsr MapScript_getDungeonNumber ;19
	cmp #1 ;20
	beq @head1 ;21
	cmp #2 ;22
	beq @head2 ;23
	@head0: ;24
		Actor_setAnimation Data_Animation_GORILLA__HEAD0 ;25
		rts ;26
	@head1: ;27
		Actor_setAnimation Data_Animation_GORILLA__HEAD1 ;28
		rts ;29
	@head2: ;30
		Actor_setAnimation Data_Animation_GORILLA__HEAD2 ;31
		rts ;32
 ;33
Ai_GorillaHead_damage: ;34
	lda #Ai_RESULT_PASS__THROUGH ;35
	sta Ai_result ;36
	rts ;37
