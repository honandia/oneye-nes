.include "obj/Ppu.h"
.include "obj/Global.h"
 ;2
.zeropage ;3
Ppu_ppuctrl: .res 1 ;4
 ;5
.bss ;6
Ppu_ntscpal: .res 1 ;7
 ;8
.code ;9
 ;10
Ppu_BASE__NAMETABLE__ADDRS: ;11
	.byte $20,$24,$28,$2C ;12
 ;13
 ;14
 ;15
 ;16
 ;17
 ;18
 ;19
 ;20
 ;21
 ;22
 ;23
 ;24
 ;25
 ;26
 ;27
 ;28
 ;29
 ;30
 ;31
 ;32
 ;33
 ;34
 ;35
 ;36
 ;37
 ;38
 ;39
 ;40
 ;41
 ;42
 ;43
 ;44
 ;45
 ;46
 ;47
 ;48
;prepare only, changes will take effect on next ppuctrl_rewrite, ppuctrl_set, etc. ;49
 ;50
 ;51
 ;52
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
;a(out) ;65
 ;66
 ;67
 ;68
 ;69
 ;70
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
 ;97
 ;98
 ;99
 ;100
 ;101
 ;102
 ;103
 ;104
 ;105
 ;106
 ;107
 ;108
 ;109
 ;110
 ;111
 ;112
 ;113
 ;114
 ;115
 ;116
 ;117
Ppu_waitVblank: ;118
	@loop: ;119
		lda Global_PPUSTATUS ;120
		bpl @loop ;121
	rts ;122
 ;123
 ;124
Ppu_detectNtscPal: ;125
	;http://nesdev.com/bbs/viewtopic.php?t=4057 ;126
	lda Global_PPUSTATUS		; clear VBL flag ;127
	@wvbl: ;128
		lda Global_PPUSTATUS ;129
		bpl @wvbl ;130
 ;131
	ldx #52 			; 29799 delay ;132
	ldy #24 ;133
	@dly: ;134
		dex ;135
		bne @dly ;136
		dey ;137
		bne @dly ;138
 ;139
	ldx #$00 ;140
	lda Global_PPUSTATUS		; high bit set if NTSC, clear if PAL ;141
	bmi @ntsc ;142
		ldx #$01 ;143
	@ntsc: ;144
	stx Ppu_ntscpal ;145
	rts ;146
 ;147
 ;148
 ;149
Ppu_startup: ;150
	jsr Ppu_waitVblank ;151
	jsr Ppu_waitVblank ;152
	lda #$00 ;153
	sta Ppu_ppuctrl ;154
	sta Global_PPUCTRL ;155
	sta Global_PPUMASK ;156
	lda #$00 ;157
	sta Ppu_ppuctrl ;158
 ;159
	jsr Ppu_waitVblank ;160
	jsr Ppu_detectNtscPal ;2 frames ;161
	jsr Ppu_waitVblank ;162
	jsr Ppu_init ;163
	Ppu_setPpuctrl Global_PPUCTRL_NMI__ENABLED ;164
	rts ;165
 ;166
 ;167
Ppu___setTile: ;168
	sty Global_tmp1 ;169
	bit Global_PPUSTATUS ;170
	lsr a ;171
	lsr a ;172
	lsr a ;py/=8 ;173
	lsr a ;174
	lsr a ;175
	lsr a ;py/=8 ;176
	sta Global_tmp0 ;177
	Ppu_getBaseNametableAddr ;178
	clc ;179
	adc Global_tmp0 ;180
	sta Global_PPUADDR ;181
 ;182
	lda #$00 ;183
	sta Global_PPUADDR ;184
 ;185
	lda Global_tmp1 ;186
	sta Global_PPUDATA ;187
 ;188
;	ldx #(px*2 + ((py*2*32) & $FF)) ;189
;	ldy #(py*2/8) ;190
;	lda #(w*2) ;191
;	sta mb_width ;192
;	lda #(h*2) ;193
;	sta mb_height ;194
 ;195
 ;196
Ppu_init: ;197
	lda #$00 ;198
	sta Ppu_ppuctrl ;199
	Ppu_setPpuctrl Global_PPUCTRL_BG__ADDR__1000 ;200
	lda #%00011110 ; enable sprite and background visibility+clipping ;201
	sta Global_PPUMASK ;202
	rts ;203
 ;204
 ;205
Ppu_enableVideo: ;206
	lda #%00011110 ; a - enable sprite and background visibility+clipping ;207
	sta Global_PPUMASK ;208
	rts ;209
 ;210
 ;211
Ppu_disableVideo: ;212
	lda #%00000110 ; disable sprite and background visibility ;213
	sta Global_PPUMASK ;214
	rts ;215
 ;216
