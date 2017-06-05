.ifndef __PPU_H
__PPU_H = 1
.globalzp Ppu_ppuctrl ;4
.global Ppu_ntscpal ;7
.global Ppu_BASE__NAMETABLE__ADDRS ;11
.macro Ppu_setAddr Ppu_setAddr_addr ;14
	bit Global_PPUSTATUS ;15
	lda #>(Ppu_setAddr_addr) ;16
	sta Global_PPUADDR ;17
	lda #<(Ppu_setAddr_addr) ;18
	sta Global_PPUADDR ;19
.endmacro ;20
.include "obj/Global.h" ;20
.macro Ppu_setAddrFast Ppu_setAddrFast_addr ;use setAddr initially before using this one ;22
	lda #>(Ppu_setAddrFast_addr) ;23
	sta Global_PPUADDR ;24
	lda #<(Ppu_setAddrFast_addr) ;25
	sta Global_PPUADDR ;26
.endmacro ;27
.include "obj/Global.h" ;27
.macro Ppu_setAddrIndirect Ppu_setAddrIndirect_addr ;29
	bit Global_PPUSTATUS ;30
	lda 1+(Ppu_setAddrIndirect_addr) ;31
	sta Global_PPUADDR ;32
	lda 0+(Ppu_setAddrIndirect_addr) ;33
	sta Global_PPUADDR ;34
.endmacro ;35
.include "obj/Global.h" ;35
.macro Ppu_setTile Ppu_setTile_px,Ppu_setTile_py,Ppu_setTile_id ;a,x,tmp0 / absolute screen coordinates ;37
	ldx Ppu_setTile_px ;38
	lda Ppu_setTile_py ;39
	ldy Ppu_setTile_id ;40
	jsr Ppu___setTile ;41
.endmacro ;42
.macro Ppu_rewritePpuctrl ;used to fix scrolling ;44
	lda Ppu_ppuctrl ;45
	sta Global_PPUCTRL ;46
.endmacro ;47
.include "obj/Global.h" ;47
.macro Ppu_prepareBaseNametable Ppu_prepareBaseNametable_val ;(0 = $2000; 1 = $2400; 2 = $2800; 3 = $2C00) ;50
	lda Ppu_ppuctrl ;51
	and #%11111100 ;52
	ora Ppu_prepareBaseNametable_val ;53
	sta Ppu_ppuctrl ;54
.endmacro ;55
.macro Ppu_setBaseNametable Ppu_setBaseNametable_val ;(0 = $2000; 1 = $2400; 2 = $2800; 3 = $2C00) ;57
	lda Ppu_ppuctrl ;58
	and #%11111100 ;59
	ora Ppu_setBaseNametable_val ;60
	sta Ppu_ppuctrl ;61
	sta Global_PPUCTRL ;62
.endmacro ;63
.include "obj/Global.h" ;63
.macro Ppu_getBaseNametable ;66
	lda Ppu_ppuctrl ;67
	and #%00000011 ;68
.endmacro ;69
.macro Ppu_getBaseNametableAddr ;y ;71
	Ppu_getBaseNametable ;72
	tay ;73
	lda Ppu_BASE__NAMETABLE__ADDRS,y ;74
.endmacro ;75
.macro Ppu_setPpuctrl Ppu_setPpuctrl_bits ;77
	lda #Ppu_setPpuctrl_bits ;78
	ora Ppu_ppuctrl ;79
	sta Ppu_ppuctrl ;80
	sta Global_PPUCTRL ;81
.endmacro ;82
.include "obj/Global.h" ;82
.macro Ppu_unsetPpuctrl Ppu_unsetPpuctrl_bits ;84
	lda #Ppu_unsetPpuctrl_bits ;85
	eor #$FF ;86
	and Ppu_ppuctrl ;87
	sta Ppu_ppuctrl ;88
	sta Global_PPUCTRL ;89
.endmacro ;90
.include "obj/Global.h" ;90
.macro Ppu_writeOam Ppu_writeOam_absaddr,Ppu_writeOam_px,Ppu_writeOam_py,Ppu_writeOam_attr,Ppu_writeOam_tile ;93
	.ifnblank Ppu_writeOam_py ;94
		lda Ppu_writeOam_py ;95
		sta Ppu_writeOam_absaddr ;96
	.endif ;97
	.ifnblank Ppu_writeOam_tile ;98
		lda Ppu_writeOam_tile ;99
		sta Ppu_writeOam_absaddr+1 ;100
	.endif ;101
	.ifnblank Ppu_writeOam_attr ;102
		lda Ppu_writeOam_attr ;103
		sta Ppu_writeOam_absaddr+2 ;104
	.endif ;105
	.ifnblank Ppu_writeOam_px ;106
		lda Ppu_writeOam_px ;107
		sta Ppu_writeOam_absaddr+3 ;108
	.endif ;109
.endmacro ;110
.macro Ppu_clearOam Ppu_clearOam_absaddr ;112
	lda #$FF ;113
	sta Ppu_clearOam_absaddr ;114
.endmacro ;115
.global Ppu_waitVblank ;118
.global Ppu_detectNtscPal ;125
.global Ppu_startup ;150
.global Ppu___setTile ;168
.global Ppu_init ;197
.global Ppu_enableVideo ;206
.global Ppu_disableVideo ;212
.endif
