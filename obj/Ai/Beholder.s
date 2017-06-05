.include "obj/Ai/Beholder.h"
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
 ;13
Ai_Beholder_run: ;14
	Ai_switch Ai_Beholder_update,Ai_Beholder_create,,Ai_Beholder_damage,Ai_Beholder_destroy ;15
	rts ;16
 ;17
 ;18
Ai_Beholder_update: ;19
 ;20
 ;21
 ;22
 ;23
	ldy Ai_Beholder_floatTimer,x ;24
	lda Ai_Beholder_update_FLOAT__DY,y ;25
	sta Ai_Beholder_update_tmpFloatDy ;26
 ;27
	ldy Ai_Beholder_shadowIndex,x ;28
	eor #$FF ;29
	clc ;30
	adc #1 ;31
	clc ;32
	adc Ai_Shadow_verticalOffset,y ;33
	sta Ai_Shadow_verticalOffset,y ;34
 ;35
	;ldy floatTimer,x ;36
	;lda FLOAT_DY,y ;37
	lda Ai_Beholder_update_tmpFloatDy ;38
	clc ;39
	adc Actor_py,x ;40
	sta Actor_py,x ;41
	inc Ai_Beholder_floatTimer,x ;42
	lda Ai_Beholder_floatTimer,x ;43
	cmp #32 ;44
	bne @skipResetFloatTimer ;45
		lda #0 ;46
		sta Ai_Beholder_floatTimer,x ;47
	@skipResetFloatTimer: ;48
 ;49
	lda Ai_Beholder_state,x ;50
	bne Ai_Beholder_update_attack ;51
	Ai_Beholder_update_guard: ;52
		dec Actor_timer,x ;53
		bne @end ;54
			lda #Ai_Beholder_STATE__ATTACK ;55
			sta Ai_Beholder_state,x ;56
			lda #60 ;57
			sta Actor_timer,x ;58
			Actor_setAnimation Data_Animation_BEHOLDER__OPEN__EYE ;59
		@end: ;60
		rts ;61
	Ai_Beholder_update_attack: ;62
		lda Actor_timer,x ;63
		cmp #40 ;64
		bne @skipAttack ;65
			lda Actor_px,x ;66
			sta Ai_Beholder_update_tmpPx ;67
			lda Actor_py,x ;68
			sta Ai_Beholder_update_tmpPy ;69
 ;70
			txa ;71
			pha ;72
			Actor_createEnemy #Data_Actor_ID__BEHOLDER__PROJECTILE ;73
			lda Ai_Beholder_update_tmpPx ;74
			sta Actor_px,x ;75
			lda Ai_Beholder_update_tmpPy ;76
			sta Actor_py,x ;77
			lda #4 ;78
			sta Actor_vy,x ;79
			pla ;80
			tax ;81
		@skipAttack: ;82
 ;83
		dec Actor_timer,x ;84
		bne @end ;85
			lda #Ai_Beholder_STATE__GUARD ;86
			sta Ai_Beholder_state,x ;87
			lda #120 ;88
			sta Actor_timer,x ;89
			Actor_setAnimation Data_Animation_BEHOLDER__CLOSE__EYE ;90
 ;91
		@end: ;92
		rts ;93
 ;94
	Ai_Beholder_update_FLOAT__DY: .byte 1,0,1,0,0,0,1,0,0,0,0,0,0,0,0,0,256-1,0,0,0,256-1,0,256-1,0,0,0,0,0,0,0,0,0 ;95
 ;96
 ;97
Ai_Beholder_create: ;98
	Ai_Util_createShadow #24 ;99
	tya ;100
	sta Ai_Beholder_shadowIndex,x ;101
 ;102
	lda #Ai_Beholder_STATE__GUARD ;103
	sta Ai_Beholder_state,x ;104
	lda #60 ;105
	sta Actor_timer,x ;106
	Actor_setAnimation Data_Animation_BEHOLDER__IDLE ;107
	rts ;108
 ;109
Ai_Beholder_damage: ;110
	lda Ai_Beholder_state,x ;111
	cmp #Ai_Beholder_STATE__GUARD ;112
	beq @invincible ;113
	@damage: ;114
		lda Ai_arg0 ;115
		jsr Ai_Util_damage ;116
		;TODO: put knockback call in enemy AIs (on damage) ;117
		lda #Ai_RESULT_DAMAGED__NO__KNOCKBACK ;118
		sta Ai_result ;119
		rts ;120
	@invincible: ;121
		lda #Ai_RESULT_INVINCIBLE ;122
		sta Ai_result ;123
		rts ;124
 ;125
Ai_Beholder_destroy: ;126
	txa ;127
	pha ;128
	lda Ai_Beholder_shadowIndex,x ;129
	bmi @end ;130
		tax ;131
		jsr Actor_destroy ;132
	@end: ;133
	pla ;134
	tax ;135
	rts ;136
