.ifndef __AI_GHOST_H
__AI_GHOST_H = 1
.include "obj/Actor.h" ;6
Ai_Ghost_state = Actor_var0 ;6
.include "obj/Actor.h" ;7
Ai_Ghost_shadowIndex = Actor_var1 ;7
Ai_Ghost_STATE__IDLE = 0 ;8
Ai_Ghost_STATE__ATTACK = 1 ;9
.global Ai_Ghost_run ;13
.global Ai_Ghost_update ;18
.include "obj/Global.h" ;19
Ai_Ghost_update_tmpPx = Global_tmp1 ;19
.include "obj/Global.h" ;20
Ai_Ghost_update_tmpPy = Global_tmp2 ;20
.include "obj/Global.h" ;21
Ai_Ghost_update_tmpX = Global_tmp3 ;21
.global Ai_Ghost_update_idle ;25
.global Ai_Ghost_update_attack ;33
.global Ai_Ghost_create ;54
.global Ai_Ghost_damage ;65
.global Ai_Ghost_destroy ;69
.endif
