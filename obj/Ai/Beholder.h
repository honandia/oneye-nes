.ifndef __AI_BEHOLDER_H
__AI_BEHOLDER_H = 1
.include "obj/Actor.h" ;7
Ai_Beholder_state = Actor_var0 ;7
.include "obj/Actor.h" ;8
Ai_Beholder_shadowIndex = Actor_var1 ;8
.include "obj/Actor.h" ;9
Ai_Beholder_floatTimer = Actor_var2 ;9
Ai_Beholder_STATE__GUARD = 0 ;11
Ai_Beholder_STATE__ATTACK = 1 ;12
.global Ai_Beholder_run ;14
.global Ai_Beholder_update ;19
.include "obj/Global.h" ;20
Ai_Beholder_update_tmpPx = Global_tmp1 ;20
.include "obj/Global.h" ;21
Ai_Beholder_update_tmpPy = Global_tmp2 ;21
.include "obj/Global.h" ;22
Ai_Beholder_update_tmpFloatDy = Global_tmp1 ;22
.global Ai_Beholder_update_guard ;52
.global Ai_Beholder_update_attack ;62
.global Ai_Beholder_update_FLOAT__DY ;95
.global Ai_Beholder_create ;98
.global Ai_Beholder_damage ;110
.global Ai_Beholder_destroy ;126
.endif
