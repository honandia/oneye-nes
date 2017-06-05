.ifndef __ACTOR_H
__ACTOR_H = 1
Actor_INDEX__HERO = 0 ;8
Actor_INDEX__WEAPON = 1 ;9
Actor_DIRECTION__LEFT = 0 ;10
Actor_DIRECTION__UP = 1 ;11
Actor_DIRECTION__RIGHT = 2 ;12
Actor_DIRECTION__DOWN = 3 ;13
Actor_FLAG_FLAG = 0+0 ;14
Actor_FLAG_NO__MAP__COLLISION = $04 ;16
Actor_INVINCIBILITY__TIME = 8 ;19
Actor_MAX__ACTORS = 16 ;22
Actor_PARTICLE__INDEX__START = 2 ;23
Actor_MAX__PARTICLES = 4 ;24
Actor_ENEMY__INDEX__START = 2+Actor_MAX__PARTICLES ;25
.globalzp Actor_oamIndex ;27
.global Actor_id ;29
.global Actor_px ;30
.global Actor_py ;31
.global Actor_vx ;32
.global Actor_vy ;33
.global Actor_hp ;34
.global Actor_timer ;35
.global Actor_flags ;36
.global Actor_invincibility ;37
.global Actor_lostControl ;38
.global Actor_animationAddrL ;39
.global Actor_animationAddrH ;40
.global Actor_animationIndex ;41
.global Actor_animationFrame ;42
.global Actor_direction ;43
.global Actor_var0 ;44
.global Actor_var1 ;45
.global Actor_var2 ;46
.macro Actor_setFlags Actor_setFlags_f ;48
	lda Actor_flags,x ;49
	ora #(Actor_setFlags_f) ;50
	sta Actor_flags,x ;51
.endmacro ;52
.macro Actor_clearFlags Actor_clearFlags_f ;54
	lda Actor_flags,x ;55
	and #~(Actor_clearFlags_f) ;56
	sta Actor_flags,x ;57
.endmacro ;58
.macro Actor_notFlags Actor_notFlags_f ;60
	lda Actor_flags,x ;61
	and #(Actor_notFlags_f) ;62
.endmacro ;63
.macro Actor_createX Actor_createX___id ;65
	lda Actor_createX___id ;66
	jsr Actor___createX ;67
.endmacro ;68
.global Actor___createX ;69
.macro Actor_createEnemy Actor_createEnemy___id ;89
	lda Actor_createEnemy___id ;90
	jsr Actor___createEnemy ;91
.endmacro ;92
.global Actor___createEnemy ;93
.globalzp Actor___createEnemy_tmp ;94
.macro Actor_createParticle Actor_createParticle___id ;109
	lda Actor_createParticle___id ;110
	jsr Actor___createParticle ;111
.endmacro ;112
.global Actor___createParticle ;113
.globalzp Actor___createParticle_tmp ;114
.global Actor_knockback ;129
.include "obj/Global.h" ;130
Actor_knockback___vy = Global_tmp1 ;130
.global Actor_knockbackY ;138
.include "obj/Global.h" ;139
Actor_knockbackY___vy = Global_tmp1 ;139
.global Actor_damage ;149
.global Actor_damage_amount ;150
.global Actor_damageY ;182
.global Actor_damageY_tmpX ;183
.global Actor_damageY_tmpY ;184
.global Actor_createExplosion ;194
.global Actor_createExplosion_tmpX ;195
.macro Actor_setPalette Actor_setPalette_pal ;211
	lda Actor_flags,x ;212
	and #%11111100 ;213
	ora Actor_setPalette_pal ;214
	sta Actor_flags,x ;215
.endmacro ;216
.macro Actor_setAnimation Actor_setAnimation_addr ;218
	lda #<Actor_setAnimation_addr ;219
	ldy #>Actor_setAnimation_addr ;220
	jsr Actor___setAnimation ;221
.endmacro ;222
.global Actor___setAnimation ;223
.globalzp Actor___setAnimation_tmp ;224
.global Actor_destroy ;242
.global Actor_destroyY ;251
.global Actor_destroyY_tmpX ;252
.global Actor_destroyY_tmpY ;253
.global Actor_destroyAllButHero ;263
.global Actor_updateAnimation ;273
.globalzp Actor_updateAnimation_tmp ;274
.globalzp Actor_updateAnimation_animationAddr ;275
.global Actor_updateAll ;297
.global Actor_doEnemyCollisions ;349
.global Actor_updatePhysics ;381
.global Actor_writeOam ;394
.globalzp Actor_writeOam_gfxAddr ;395
.globalzp Actor_writeOam_tmpX ;396
.globalzp Actor_writeOam_tmpY ;397
.globalzp Actor_writeOam_tmpPx ;398
.globalzp Actor_writeOam_tileIndex ;399
.globalzp Actor_writeOam_attributes ;400
.globalzp Actor_writeOam_animationAddr ;401
.globalzp Actor_writeOam_tileXAddr ;402
.globalzp Actor_writeOam_tileYAddr ;403
.global Actor_writeOam_write8x8 ;416
.global Actor_writeOam_write16x16 ;448
.global Actor_writeOam_TILE__X ;521
.global Actor_writeOam_TILE__Y ;522
.global Actor_writeOam_TILE__X__HFLIP ;523
.global Actor_writeOam_TILE__Y__HFLIP ;524
.global Actor_writeOam_writeTile ;527
.global Actor_getTx ;551
.global Actor_getTy ;560
.endif
