.include "obj/Ai/Util.h"
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
.include "obj/Data/Actor.h"
 ;5
 ;6
 ;7
 ;8
 ;9
Ai_Util___moveTowardsHero: ;10
.pushseg
.bss
	Ai_Util___moveTowardsHero_speed: .res 1 ;11
.popseg
	sta Ai_Util___moveTowardsHero_speed ;12
	lda Ai_Hero_py ;13
	clc ;14
	adc #4 ;15
	cmp Actor_py,x ;16
	bcc @up ;17
	lda Ai_Hero_py ;18
	sec ;19
	sbc #4 ;20
	cmp Actor_py,x ;21
	bcc @skipVertical ;22
	@down: ;23
		lda Ai_Util___moveTowardsHero_speed ;24
		sta Actor_vy,x ;25
		lda #Actor_DIRECTION__DOWN ;26
		sta Actor_direction,x ;27
		jmp @skipVertical ;28
	@up: ;29
		lda #0 ;30
		sec ;31
		sbc Ai_Util___moveTowardsHero_speed ;32
		sta Actor_vy,x ;33
		lda #Actor_DIRECTION__UP ;34
		sta Actor_direction,x ;35
	@skipVertical: ;36
 ;37
	lda Ai_Hero_px ;38
	clc ;39
	adc #4 ;40
	cmp Actor_px,x ;41
	bcc @left ;42
	lda Ai_Hero_px ;43
	sec ;44
	sbc #4 ;45
	cmp Actor_px,x ;46
	bcc @skipHorizontal ;47
	@right: ;48
		lda Ai_Util___moveTowardsHero_speed ;49
		sta Actor_vx,x ;50
		lda #Actor_DIRECTION__RIGHT ;51
		sta Actor_direction,x ;52
		jmp @skipHorizontal ;53
	@left: ;54
		lda #0 ;55
		sec ;56
		sbc Ai_Util___moveTowardsHero_speed ;57
		sta Actor_vx,x ;58
		lda #Actor_DIRECTION__LEFT ;59
		sta Actor_direction,x ;60
	@skipHorizontal: ;61
	rts ;62
 ;63
 ;64
 ;65
 ;66
 ;67
 ;68
 ;69
 ;70
 ;71
 ;72
 ;73
 ;74
 ;75
 ;76
 ;77
 ;78
 ;79
 ;80
 ;81
Ai_Util___setDirectionAnimation: ;82
	;vars sequential in memory! ;83
.pushseg
.bss
	Ai_Util___setDirectionAnimation_left: .res 2 ;84
	Ai_Util___setDirectionAnimation_up: .res 2 ;85
	Ai_Util___setDirectionAnimation_right: .res 2 ;86
	Ai_Util___setDirectionAnimation_down: .res 2 ;87
.popseg
	sta Ai_Util___setDirectionAnimation_down ;88
	sty Ai_Util___setDirectionAnimation_down+1 ;89
	lda Actor_direction,x ;90
	asl a ;91
	tay ;92
	lda Ai_Util___setDirectionAnimation_left,y ;93
	pha ;94
	lda Ai_Util___setDirectionAnimation_left+1,y ;95
	tay ;96
	pla ;97
	Global_jsrrts Actor___setAnimation ;98
 ;99
 ;100
Ai_Util_getDistanceFromHero: ;101
.pushseg
.bss
	Ai_Util_getDistanceFromHero_tmpPx: .res 1 ;102
.popseg
	lda Ai_Hero_px ;103
	sec ;104
	sbc Actor_px,x ;105
	Global_abs a ;106
	sta Ai_Util_getDistanceFromHero_tmpPx ;107
 ;108
	lda Ai_Hero_py ;109
	sec ;110
	sbc Actor_py,x ;111
	Global_abs a ;112
 ;113
	clc ;114
	adc Ai_Util_getDistanceFromHero_tmpPx ;115
	rts ;116
 ;117
 ;118
Ai_Util_damage: ;119
	lda Actor_hp,x ;120
	sec ;121
	sbc Ai_arg0 ;122
	sta Actor_hp,x ;123
	beq @destroy ;124
	bmi @destroy ;125
	rts ;126
	@destroy: ;127
		jsr Actor_createExplosion ;128
		Global_jsrrts Actor_destroy ;129
 ;130
 ;131
 ;132
 ;133
 ;134
 ;135
Ai_Util___createShadow: ;136
 ;137
	pha ;138
	stx Ai_Util___createShadow_tmpX ;139
	Actor_createParticle #Data_Actor_ID__SHADOW ;140
	lda Ai_Util___createShadow_tmpX ;141
	sta Ai_Shadow_attachedTo,x ;142
	pla ;143
	sta Ai_Shadow_verticalOffset,x ;144
	txa ;145
	tay ;146
	ldx Ai_Util___createShadow_tmpX ;147
	rts ;148
 ;149
