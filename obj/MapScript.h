.ifndef __MAPSCRIPT_H
__MAPSCRIPT_H = 1
.global MapScript_powerup1Collected ;11
.global MapScript_powerup2Collected ;12
.global MapScript_powerup3Collected ;13
.global MapScript_bananarangTx ;14
.global MapScript_bananarangTy ;15
.global MapScript_heroTx ;16
.global MapScript_heroTy ;17
.macro MapScript_bananarangTouches MapScript_bananarangTouches_tx,MapScript_bananarangTouches_ty ;19
	lda MapScript_bananarangTx ;20
	cmp MapScript_bananarangTouches_tx ;21
	bne :+ ;22
	lda MapScript_bananarangTy ;23
	cmp MapScript_bananarangTouches_ty ;24
	: ;25
.endmacro ;26
.macro MapScript_heroTouches MapScript_heroTouches_tx,MapScript_heroTouches_ty ;28
	lda MapScript_heroTx ;29
	cmp MapScript_heroTouches_tx ;30
	bne :+ ;31
	lda MapScript_heroTy ;32
	cmp MapScript_heroTouches_ty ;33
	: ;34
.endmacro ;35
.global MapScript_update ;37
.global MapScript_M00 ;102
.global MapScript_M20 ;110
.global MapScript_M30 ;153
.global MapScript_M01 ;161
.global MapScript_M11 ;192
.global MapScript_M03 ;249
.global MapScript_writePressedButtonTop ;283
.global MapScript_writePressedButtonBottom ;289
.global MapScript_writeVerticalBridgeRow ;296
.global MapScript_writeHorizontalBridgeTop1 ;306
.global MapScript_writeHorizontalBridgeBottom1 ;311
.global MapScript_writeHorizontalBridgeTop2 ;312
.global MapScript_writeHorizontalBridgeBottom2 ;317
.global MapScript_M14 ;324
.global MapScript_M24 ;339
.global MapScript_M34 ;354
.global MapScript_enterDungeon ;370
.global MapScript_leaveDungeon ;397
.global MapScript_getDungeonNumber ;405
.global MapScript_collectPowerup ;420
.endif
