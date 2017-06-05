.ifndef __AI_HERO_H
__AI_HERO_H = 1
Ai_Hero_SPEED = 1 ;10
.include "obj/Actor.h" ;11
Ai_Hero_id = Actor_id ;11
.include "obj/Actor.h" ;12
Ai_Hero_px = Actor_px ;12
.include "obj/Actor.h" ;13
Ai_Hero_py = Actor_py ;13
.include "obj/Actor.h" ;14
Ai_Hero_vx = Actor_vx ;14
.include "obj/Actor.h" ;15
Ai_Hero_vy = Actor_vy ;15
.global Ai_Hero_run ;18
.global Ai_Hero_update ;23
.global Ai_Hero_update_IDLE__ANIMATIONS ;50
.global Ai_Hero_update_WALKING__ANIMATIONS ;51
.global Ai_Hero_checkForScreenChange ;54
.global Ai_Hero_handleInput ;112
.include "obj/Global.h" ;113
Ai_Hero_tmpPx = Global_tmp1 ;113
.include "obj/Global.h" ;114
Ai_Hero_tmpPy = Global_tmp2 ;114
.include "obj/Global.h" ;115
Ai_Hero_tmpDirection = Global_tmp3 ;115
.global Ai_Hero_collide ;215
.global Ai_Hero_damage ;239
.endif
