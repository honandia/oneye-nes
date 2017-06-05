.ifndef __AI_H
__AI_H = 1
Ai_EVENT_EVENT = 0+0 ;5
Ai_EVENT_UPDATE = 0 ;6
Ai_EVENT_CREATE = 1 ;7
Ai_EVENT_COLLIDE = 2 ;arg0:colliding actor ;8
Ai_EVENT_DAMAGE = 3 ;arg0:amount ;9
Ai_EVENT_DESTROY = 4 ;10
Ai_RESULT_RESULT = 0+0 ;13
Ai_RESULT_DAMAGED = 0 ;14
Ai_RESULT_INVINCIBLE =  0+1 ;15
Ai_RESULT_PASS__THROUGH =  0+2 ;16
Ai_RESULT_DAMAGED__NO__KNOCKBACK =  0+3 ;17
.globalzp Ai_arg0 ;20
.globalzp Ai_arg1 ;21
.globalzp Ai_result ;22
.global Ai_dummy ;24
.macro Ai_call Ai_call___event ;x(in:actor index),y,tmp0 ;28
	ldy Ai_call___event ;29
	jsr Ai___call ;30
.endmacro ;31
.global Ai___call ;32
.macro Ai_switchFuncL Ai_switchFuncL_func ;55
	.ifnblank Ai_switchFuncL_func ;56
		.byte <(Ai_switchFuncL_func-1) ;57
	.else ;58
		.byte <(Ai_dummy-1) ;59
	.endif ;60
.endmacro ;61
.macro Ai_switchFuncH Ai_switchFuncH_func ;62
	.ifnblank Ai_switchFuncH_func ;63
		.byte >(Ai_switchFuncH_func-1) ;64
	.else ;65
		.byte >(Ai_dummy-1) ;66
	.endif ;67
.endmacro ;68
.macro Ai_switch Ai_switch_update,Ai_switch_create,Ai_switch_collision,Ai_switch_damage,Ai_switch_destroy ;71
	;.ifdef DEBUG ;72
	;	cpy #5 ;73
	;	bcc @skip_brk_switchAI ;74
	;		tya ;75
	;		Debug.break #ERROR::FUNC_TABLE_INDEX,a ;76
	;	@skip_brk_switchAI: ;77
	;.endif ;78
	lda @funcsH,y ;79
	pha ;80
	lda @funcsL,y ;81
	pha ;82
	rts ;jump table ;83
	@funcsL: ;84
		Ai_switchFuncL Ai_switch_update ;85
		Ai_switchFuncL Ai_switch_create ;86
		Ai_switchFuncL Ai_switch_collision ;87
		Ai_switchFuncL Ai_switch_damage ;88
		Ai_switchFuncL Ai_switch_destroy ;89
	@funcsH: ;90
		Ai_switchFuncH Ai_switch_update ;91
		Ai_switchFuncH Ai_switch_create ;92
		Ai_switchFuncH Ai_switch_collision ;93
		Ai_switchFuncH Ai_switch_damage ;94
		Ai_switchFuncH Ai_switch_destroy ;95
.endmacro ;96
.endif
