.include "obj/Ai/Shadow.h"
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
Ai_Shadow_run: ;10
	Ai_switch Ai_Shadow_update,Ai_Shadow_create ;11
	rts ;12
 ;13
 ;14
Ai_Shadow_update: ;15
	ldy Ai_Shadow_attachedTo,x ;16
	bmi @end ;17
		lda Actor_px,y ;18
		sta Actor_px,x ;19
		lda Actor_py,y ;20
		clc ;21
		adc Ai_Shadow_verticalOffset,x ;22
		sta Actor_py,x ;23
	@end: ;24
	rts ;25
 ;26
 ;27
Ai_Shadow_create: ;28
	lda #$FF ;29
	sta Ai_Shadow_attachedTo,x ;30
	Actor_setFlags Actor_FLAG_NO__MAP__COLLISION ;31
	Actor_setAnimation Data_Animation_SHADOW__FLICKER ;32
	rts ;33
