.include "obj/Ai.h"
.include "obj/Global.h"
.include "obj/Actor.h"
.include "obj/Data/Actor.h"
 ;4
 ;5
 ;6
 ;7
 ;8
 ;9
 ;10
 ;11
 ;12
 ;13
 ;14
 ;15
 ;16
 ;17
 ;18
 ;19
.pushseg
.zeropage
Ai_arg0: .res 1 ;20
Ai_arg1: .res 1 ;21
Ai_result: .res 1 ;22
.popseg
 ;23
Ai_dummy: ;24
	rts ;25
 ;26
 ;27
 ;28
 ;29
 ;30
 ;31
Ai___call: ;32
	sty Global_tmp0 ;33
	lda #0 ;34
	sta Ai_result ;35
	txa ;36
	pha ;37
	jsr @aiFunc ;38
	pla ;39
	tax ;40
	rts ;41
	@aiFunc: ;42
		lda Actor_id,x ;43
		asl a ;44
		tay ;45
		lda Data_Actor_AI+1,y ;46
		pha ;47
		lda Data_Actor_AI,y ;48
		pha ;49
		ldy Global_tmp0 ;50
		rts ;jump table ;51
	;rts ;52
 ;53
 ;54
 ;55
 ;56
 ;57
 ;58
 ;59
 ;60
 ;61
 ;62
 ;63
 ;64
 ;65
 ;66
 ;67
 ;68
 ;69
;to be employed by ai scripts y(in:ai event) ;70
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
 ;82
 ;83
 ;84
 ;85
 ;86
 ;87
 ;88
 ;89
 ;90
 ;91
 ;92
 ;93
 ;94
 ;95
 ;96
