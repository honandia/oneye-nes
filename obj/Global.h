.ifndef __GLOBAL_H
__GLOBAL_H = 1
Global_PPUCTRL = $2000 ;1
Global_PPUMASK = $2001 ;2
Global_PPUSTATUS = $2002 ;3
Global_OAMADDR = $2003 ;4
Global_OAMDATA = $2004 ;5
Global_PPUSCROLL = $2005 ;6
Global_PPUADDR = $2006 ;7
Global_PPUDATA = $2007 ;8
Global_PPUCTRL_PPUCTRL = 0+0 ;10
Global_PPUCTRL_ADDR__INCREMENT32 = %00000100 ;11
Global_PPUCTRL_SPRITE__ADDR__1000 = %00001000 ;12
Global_PPUCTRL_BG__ADDR__1000 = %00010000 ;13
Global_PPUCTRL_SPRITE__SIZE__8x16 = %00100000 ;14
Global_PPUCTRL_NMI__ENABLED = %10000000 ;15
Global_JOY__RIGHT = $01 ;18
Global_JOY__LEFT = $02 ;19
Global_JOY__DOWN = $04 ;20
Global_JOY__UP = $08 ;21
Global_JOY__START = $10 ;22
Global_JOY__SELECT = $20 ;23
Global_JOY__B = $40 ;24
Global_JOY__A = $80 ;25
.global Global_oam ;28
.globalzp Global_tmp0 ;32
.globalzp Global_tmp1 ;33
.globalzp Global_tmp2 ;34
.globalzp Global_tmp3 ;35
.globalzp Global_tmp4 ;36
.globalzp Global_tmp5 ;37
.globalzp Global_tmp6 ;38
.globalzp Global_tmp7 ;39
.globalzp Global_tmp8 ;40
.globalzp Global_tmp9 ;41
.globalzp Global_frameCount ;43
.globalzp Global_joy1 ;44
.globalzp Global_joy1Press ;45
.globalzp Global_joy1Release ;46
.globalzp Global_joy1Prev ;47
.globalzp Global_joy2 ;48
.globalzp Global_joy2Press ;49
.globalzp Global_joy2Release ;50
.globalzp Global_joy2Prev ;51
.macro Global_jsrrts Global_jsrrts_addr ;55
	jmp Global_jsrrts_addr ;56
.endmacro ;57
.macro Global_mul8yne Global_mul8yne_n ;a(out:result), y (n*y) !=0 ;60
	lda #0 ;61
	clc ;62
:	adc Global_mul8yne_n ;63
	dey ;64
	bne :- ;65
.endmacro ;66
.macro Global_mul8y Global_mul8y_n ;a(out:result),y ;68
	lda #0 ;69
	cpy #0 ;70
	beq :++ ;71
	clc ;72
:	adc Global_mul8y_n ;73
	dey ;74
	bne :- ;75
	: ;76
.endmacro ;77
.macro Global_div16 Global_div16_lb,Global_div16_hb,Global_div16_n ;y(out:result), lb and hb not preserved ;79
	ldy #0 ;80
: ;81
	lda Global_div16_lb ;82
	sec ;83
	sbc Global_div16_n ;84
	sta Global_div16_lb ;85
	lda Global_div16_hb ;86
	sbc #0 ;87
	bmi :+ ;88
	sta Global_div16_hb ;89
	iny ;90
	bne :- ;guaranteed branch unless overflow occurs ;91
: ;92
.endmacro ;93
.macro Global_inc16 Global_inc16_lb, Global_inc16_hb ;a,c ;95
	.ifblank Global_inc16_hb  ;pointer to low byte... followed by high byte ;96
		inc Global_inc16_lb ;97
		bne :+ ;98
			inc Global_inc16_lb+1 ;99
		: ;100
	.else ;two (separate low and high) bytes specified ;101
		inc Global_inc16_lb ;102
		bne :+ ;103
			inc Global_inc16_hb ;104
		: ;105
	.endif ;106
.endmacro ;107
.macro Global_inc16x Global_inc16x_lb, Global_inc16x_hb ;a,carry ;109
	.ifblank Global_inc16x_hb ;110
		inc Global_inc16x_lb,x ;111
		bne :+ ;112
			inc Global_inc16x_lb+1,x ;113
		: ;114
	.else ;two (separate low and high) bytes specified ;115
		inc Global_inc16x_lb,x ;116
		bne :+ ;117
			inc Global_inc16x_hb,x ;118
		: ;119
	.endif ;120
.endmacro ;121
.macro Global_adc16 Global_adc16_lb, Global_adc16_hb, Global_adc16_n, Global_adc16_ldest, Global_adc16_hdest ;a,carry ;124
	.if .match({Global_adc16_n},x) ;125
		txa ;126
	.elseif .match({Global_adc16_n},y) ;127
		tya ;128
	.elseif .match({Global_adc16_n},a) ;129
	.else ;130
		lda Global_adc16_n ;131
	.endif ;132
	adc Global_adc16_lb ;133
	.ifblank Global_adc16_ldest ;134
		sta Global_adc16_lb ;135
	.else ;136
		sta Global_adc16_ldest ;137
	.endif ;138
	.ifblank Global_adc16_hb ;139
		lda Global_adc16_lb+1 ;140
		adc #$00 ;141
		.ifnblank Global_adc16_hdest ;142
			sta Global_adc16_hdest ;143
		.elseif .not(.blank(Global_adc16_ldest)) ;144
			sta Global_adc16_ldest+1 ;145
		.else ;146
			sta Global_adc16_lb+1 ;147
		.endif ;148
	.else ;149
		lda Global_adc16_hb ;150
		adc #$00 ;151
		.ifnblank Global_adc16_hdest ;152
			sta Global_adc16_hdest ;153
		.elseif .not(.blank(Global_adc16_ldest)) ;154
			sta Global_adc16_ldest+1 ;155
		.else ;156
			sta Global_adc16_hb ;157
		.endif ;158
	.endif ;159
.endmacro ;160
.macro Global_adc16x Global_adc16x_lb, Global_adc16x_hb, Global_adc16x_n, Global_adc16x_ldest, Global_adc16x_hdest ;a,carry ;163
	.if .match({Global_adc16x_n}, y) ;164
		tya ;165
	.elseif .match({Global_adc16x_n}, a) ;166
	.else ;167
		lda Global_adc16x_n ;168
	.endif ;169
	adc Global_adc16x_lb,x ;170
	.ifblank Global_adc16x_ldest ;171
		sta Global_adc16x_lb,x ;172
	.else ;173
		sta Global_adc16x_ldest ;174
	.endif ;175
	.ifblank Global_adc16x_hb ;176
		lda Global_adc16x_lb+1,x ;177
		adc #$00 ;178
		.ifnblank Global_adc16x_hdest ;179
			sta Global_adc16x_hdest ;180
		.elseif .not(.blank(Global_adc16x_ldest)) ;181
			sta Global_adc16x_ldest+1 ;182
		.else ;183
			sta Global_adc16x_lb+1,x ;184
		.endif ;185
	.else ;186
		lda Global_adc16x_hb,x ;187
		adc #$00 ;188
		.ifnblank Global_adc16x_hdest ;189
			sta Global_adc16x_hdest ;190
		.elseif .not(.blank(Global_adc16x_ldest)) ;191
			sta Global_adc16x_ldest+1 ;192
		.else ;193
			sta Global_adc16x_hb,x ;194
		.endif ;195
	.endif ;196
.endmacro ;197
.macro Global_sbc16 Global_sbc16_lb,Global_sbc16_hb, Global_sbc16_n, Global_sbc16_ldest,Global_sbc16_hdest ;a,carry ;200
	lda Global_sbc16_lb ;201
	sbc Global_sbc16_n ;202
	.ifblank Global_sbc16_ldest ;203
		sta Global_sbc16_lb ;204
	.else ;205
		sta Global_sbc16_ldest ;206
	.endif ;207
	.ifblank Global_sbc16_hb ;208
		lda Global_sbc16_lb+1 ;209
		sbc #$00 ;210
		.ifnblank Global_sbc16_hdest ;211
			sta Global_sbc16_hdest ;212
		.elseif .not(.blank(Global_sbc16_ldest)) ;213
			sta Global_sbc16_ldest+1 ;214
		.else ;215
			sta Global_sbc16_lb+1 ;216
		.endif ;217
	.else ;218
		lda Global_sbc16_hb ;219
		sbc #$00 ;220
		.ifnblank Global_sbc16_hdest ;221
			sta Global_sbc16_hdest ;222
		.elseif .not(.blank(Global_sbc16_ldest)) ;223
			sta Global_sbc16_ldest+1 ;224
		.else ;225
			sta Global_sbc16_hb ;226
		.endif ;227
	.endif ;228
.endmacro ;229
.macro Global_sbc16y Global_sbc16y_lb,Global_sbc16y_hb, Global_sbc16y_n, Global_sbc16y_ldest,Global_sbc16y_hdest ;a,carry ;231
	lda Global_sbc16y_lb,y ;232
	sbc Global_sbc16y_n ;233
	.ifblank Global_sbc16y_ldest ;234
		sta Global_sbc16y_lb,y ;235
	.else ;236
		sta Global_sbc16y_ldest ;237
	.endif ;238
	.ifblank Global_sbc16y_hb ;239
		lda Global_sbc16y_lb+1,y ;240
		sbc #$00 ;241
		.ifnblank Global_sbc16y_hdest ;242
			sta Global_sbc16y_hdest ;243
		.elseif .not(.blank(Global_sbc16y_ldest)) ;244
			sta Global_sbc16y_ldest+1 ;245
		.else ;246
			sta Global_sbc16y_lb+1,y ;247
		.endif ;248
	.else ;249
		lda Global_sbc16y_hb,y ;250
		sbc #$00 ;251
		.ifnblank Global_sbc16y_hdest ;252
			sta Global_sbc16y_hdest ;253
		.elseif .not(.blank(Global_sbc16y_ldest)) ;254
			sta Global_sbc16y_ldest+1 ;255
		.else ;256
			sta Global_sbc16y_hb,y ;257
		.endif ;258
	.endif ;259
.endmacro ;260
.macro Global_sbc16x Global_sbc16x_lb,Global_sbc16x_hb, Global_sbc16x_n, Global_sbc16x_ldest,Global_sbc16x_hdest ;a,carry ;262
	lda Global_sbc16x_lb,x ;263
	sbc Global_sbc16x_n ;264
	.ifblank Global_sbc16x_ldest ;265
		sta Global_sbc16x_lb,x ;266
	.else ;267
		sta Global_sbc16x_ldest ;268
	.endif ;269
	.ifblank Global_sbc16x_hb ;270
		lda Global_sbc16x_lb+1,x ;271
		sbc #$00 ;272
		.ifnblank Global_sbc16x_hdest ;273
			sta Global_sbc16x_hdest ;274
		.elseif .not(.blank(Global_sbc16x_ldest)) ;275
			sta Global_sbc16x_ldest+1 ;276
		.else ;277
			sta Global_sbc16x_lb+1,x ;278
		.endif ;279
	.else ;280
		lda Global_sbc16x_hb,x ;281
		sbc #$00 ;282
		.ifnblank Global_sbc16x_hdest ;283
			sta Global_sbc16x_hdest ;284
		.elseif .not(.blank(Global_sbc16x_ldest)) ;285
			sta Global_sbc16x_ldest+1 ;286
		.else ;287
			sta Global_sbc16x_hb,x ;288
		.endif ;289
	.endif ;290
.endmacro ;291
.macro Global_limit16lower Global_limit16lower_lb,Global_limit16lower_hb,Global_limit16lower_ln,Global_limit16lower_hn ;293
.scope ;294
	lda Global_limit16lower_hb ;295
	cmp Global_limit16lower_hn ;296
	bcc @limit ;297
	bne @end ;298
	lda Global_limit16lower_lb ;299
	cmp Global_limit16lower_ln ;300
	bcs @end ;301
	@limit: ;302
		lda Global_limit16lower_hn ;303
		sta Global_limit16lower_hb ;304
		lda Global_limit16lower_ln ;305
		sta Global_limit16lower_lb ;306
	@end: ;307
.endscope ;308
.endmacro ;309
.macro Global_limit16upper Global_limit16upper_lb,Global_limit16upper_hb,Global_limit16upper_ln,Global_limit16upper_hn ;311
.scope ;312
	lda Global_limit16upper_hb ;313
	cmp Global_limit16upper_hn ;314
	bcc @end ;315
	bne @limit ;316
	lda Global_limit16upper_lb ;317
	cmp Global_limit16upper_ln ;318
	bcc @end ;319
	@limit: ;320
		lda Global_limit16upper_hn ;321
		sta Global_limit16upper_hb ;322
		lda Global_limit16upper_ln ;323
		sta Global_limit16upper_lb ;324
	@end: ;325
.endscope ;326
.endmacro ;327
.macro Global_abs Global_abs_n ;329
	.if .match({Global_abs_n}, a) ;330
		cmp #0 ;331
	.else ;332
		lda Global_abs_n ;333
	.endif ;334
	bpl :+ ;335
		eor #$FF ;336
		sec ;337
		adc #0 ;338
	: ;339
.endmacro ;340
.endif
