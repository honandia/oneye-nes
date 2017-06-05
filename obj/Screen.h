.ifndef __SCREEN_H
__SCREEN_H = 1
.globalzp Screen_activeScreen ;6
.globalzp Screen_screenTimer ;7
Screen_ID__NONE = $FF ;9
Screen_ID__TITLE = 0 ;10
Screen_ID__GAME__OVER = 1 ;11
Screen_ID__ENDING = 2 ;12
Screen_ID__STORY = 3 ;13
.global Screen_update ;15
.global Screen_Title ;29
.global Screen_Title_load ;30
.global Screen_Title_update ;40
.global Screen_GameOver ;49
.global Screen_GameOver_load ;50
.global Screen_GameOver_update ;60
.global Screen_Ending ;69
.global Screen_Ending_load ;70
.global Screen_Ending_update ;82
.global Screen_Story ;86
.global Screen_Story_load ;87
.global Screen_Story_update ;99
.macro Screen_load Screen_load_addr ;115
	lda #<Screen_load_addr ;116
	ldy #>Screen_load_addr ;117
	jsr Screen___load ;118
.endmacro ;119
.global Screen___load ;120
.globalzp Screen___load_addr ;121
.global Screen_STORY ;141
.global Screen_TITLE ;142
.global Screen_GAME__OVER ;143
.global Screen_ENDING ;144
.global Screen_TITLE__PALETTE ;147
.global Screen_ENDING__PALETTE ;151
.global Screen_STORY__PALETTE ;152
.global Screen_GAME__OVER__PALETTE ;153
.endif
