.ifndef __MAP_H
__MAP_H = 1
Map_BORDER__TILE = $2E ;9
Map_WORLD__W = 4 ;11
Map_WORLD__H = 4 ;12
Map_MAP__W = 16 ;13
Map_MAP__H = 12 ;14
.globalzp Map_collisionPointDx ;16
.globalzp Map_collisionPointDy ;17
.globalzp Map_collisionTileX ;18
.globalzp Map_collisionTileY ;19
.global Map_map ;20
.globalzp Map_worldIndex ;21
.global Map_loadScreen ;24
.global Map_load ;35
.globalzp Map_load_addr ;36
.global Map_load_attributes ;37
.global Map_load_tmpPx ;38
.global Map_load_tmpPy ;39
.global Map_load_tmpId ;40
.global Map_load_displayTiles ;68
.global Map_load_setAttributes ;100
.global Map_load_spawnEnemies ;151
.macro Map_getTileFlags Map_getTileFlags_dx, Map_getTileFlags_dy ;195
	lda Map_getTileFlags_dx ;196
	ldy Map_getTileFlags_dy ;197
	jsr Map___getTileFlags ;198
.endmacro ;199
.global Map___getTileFlags ;200
.globalzp Map___getTileFlags_tmp ;201
.macro Map_notSolid Map_notSolid_dx,Map_notSolid_dy ;233
	lda Map_notSolid_dx ;234
	ldy Map_notSolid_dy ;235
	jsr Map___notSolid ;236
.endmacro ;237
.global Map___notSolid ;238
Map_POINT__A__X = 256-5 ;245
Map_POINT__A__Y = 0 ;246
Map_POINT__B__X = 5 ;247
Map_POINT__B__Y = 0 ;248
Map_POINT__C__X = 256-5 ;249
Map_POINT__C__Y = 7 ;250
Map_POINT__D__X = 5 ;251
Map_POINT__D__Y = 7 ;252
Map_EJECT__RIGHT = 16+5 ;254
Map_EJECT__LEFT = 6 ;255
Map_EJECT__DOWN = 16 ;256
Map_EJECT__UP = 8 ;257
.global Map_doCollision ;262
.macro Map_setTile Map_setTile_id,Map_setTile_tx,Map_setTile_ty ;332
	lda Map_setTile_id ;333
	ldx Map_setTile_tx ;334
	ldy Map_setTile_ty ;335
	jsr Map___setTile ;336
.endmacro ;337
.global Map___setTile ;338
.global Map___setTile_tmpTx ;339
.global Map___setTile_tmpId ;340
.endif
