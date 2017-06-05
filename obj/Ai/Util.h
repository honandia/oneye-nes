.ifndef __AI_UTIL_H
__AI_UTIL_H = 1
.macro Ai_Util_moveTowardsHero Ai_Util_moveTowardsHero_speed ;6
	lda Ai_Util_moveTowardsHero_speed ;7
	jsr Ai_Util___moveTowardsHero ;8
.endmacro ;9
.global Ai_Util___moveTowardsHero ;10
.global Ai_Util___moveTowardsHero_speed ;11
.macro Ai_Util_setDirectionAnimation Ai_Util_setDirectionAnimation_left,Ai_Util_setDirectionAnimation_up,Ai_Util_setDirectionAnimation_right,Ai_Util_setDirectionAnimation_down ;y ;65
	lda #<Ai_Util_setDirectionAnimation_left ;66
	sta Ai_Util___setDirectionAnimation_left ;67
	lda #>Ai_Util_setDirectionAnimation_left ;68
	sta Ai_Util___setDirectionAnimation_left+1 ;69
	lda #<Ai_Util_setDirectionAnimation_up ;70
	sta Ai_Util___setDirectionAnimation_up ;71
	lda #>Ai_Util_setDirectionAnimation_up ;72
	sta Ai_Util___setDirectionAnimation_up+1 ;73
	lda #<Ai_Util_setDirectionAnimation_right ;74
	sta Ai_Util___setDirectionAnimation_right ;75
	lda #>Ai_Util_setDirectionAnimation_right ;76
	sta Ai_Util___setDirectionAnimation_right+1 ;77
	lda #<Ai_Util_setDirectionAnimation_down ;78
	ldy #>Ai_Util_setDirectionAnimation_down ;79
	jsr Ai_Util___setDirectionAnimation ;80
.endmacro ;81
.global Ai_Util___setDirectionAnimation ;82
.global Ai_Util___setDirectionAnimation_left ;84
.global Ai_Util___setDirectionAnimation_up ;85
.global Ai_Util___setDirectionAnimation_right ;86
.global Ai_Util___setDirectionAnimation_down ;87
.global Ai_Util_getDistanceFromHero ;101
.global Ai_Util_getDistanceFromHero_tmpPx ;102
.global Ai_Util_damage ;119
.macro Ai_Util_createShadow Ai_Util_createShadow_verticalOffset ;132
	lda Ai_Util_createShadow_verticalOffset ;133
	jsr Ai_Util___createShadow ;134
.endmacro ;135
.global Ai_Util___createShadow ;136
.include "obj/Global.h" ;137
Ai_Util___createShadow_tmpX = Global_tmp1 ;137
.endif
