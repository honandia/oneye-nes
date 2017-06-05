.ifndef __AI_BIRD_H
__AI_BIRD_H = 1
.include "obj/Actor.h" ;7
Ai_Bird_state = Actor_var0 ;7
.include "obj/Actor.h" ;8
Ai_Bird_shadowIndex = Actor_var1 ;8
Ai_Bird_STATE__IDLE = 0 ;9
Ai_Bird_STATE__ATTACK = 2 ;10
Ai_Bird_STATE__TAKEOFF = 1 ;11
.global Ai_Bird_run ;13
.global Ai_Bird_update ;18
.global Ai_Bird_update_idle ;27
.global Ai_Bird_update_takeoff ;44
.global Ai_Bird_update_attack ;57
.global Ai_Bird_create ;70
.global Ai_Bird_damage ;79
.global Ai_Bird_destroy ;83
.endif
