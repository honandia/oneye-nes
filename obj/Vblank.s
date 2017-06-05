.include "obj/Vblank.h"
.include "obj/Global.h"
.pushseg
.zeropage
Vblank_nmiActive: .res 1 ;2
Vblank_cmdAddr: .res 2 ;3
.popseg
 ;4
Vblank_wait4: ;5
	jsr Vblank_wait ;6
	jsr Vblank_wait ;7
	jsr Vblank_wait ;8
	Global_jsrrts Vblank_wait ;9
 ;10
Vblank_wait: ;11
	@loop: ;12
		lda Vblank_nmiActive ;13
		beq @loop ;14
	lda #0 ;15
	sta Vblank_nmiActive ;16
	rts ;17
 ;18
Vblank_cmd: ;19
	;.macro push addr ;20
	;	lda addr ;21
	;	sta cmdAddr ;22
	;	lda addr+1 ;23
	;	sta cmdAddr+1 ;24
	;.endmacro ;25
 ;26
 ;27
 ;28
 ;29
 ;30
 ;31
 ;32
	Vblank_cmd_end: ;33
		lda #0 ;34
		sta Vblank_cmdAddr+1 ;35
		rts ;36
 ;37
 ;38
Vblank_runCmdFunc: ;39
	jmp (Vblank_cmdAddr) ;40
 ;41
Vblank_nmi: ;42
	pha ;43
	txa ;44
	pha ;45
	tya ;46
	pha ;47
 ;48
	lda Vblank_nmiActive ;no sprite graphics updates as long as the game is lagging ;49
	bne @skip ;50
		lda #$00 ;51
		sta Global_OAMADDR ;52
		lda #>Global_oam ;53
		sta $4014 ;54
 ;55
		;no anything, actually ;56
		lda Vblank_cmdAddr+1 ;57
		beq @skip ;58
			jsr Vblank_runCmdFunc ;59
	@skip: ;60
 ;61
	Global_inc16 Global_frameCount ;62
	lda #1 ;63
	sta Vblank_nmiActive ;64
 ;65
	bit Global_PPUSTATUS ;66
	lda #0 ;67
	sta Global_PPUSCROLL ;68
	sta Global_PPUSCROLL ;69
 ;70
	pla ;71
	tay ;72
	pla ;73
	tax ;74
	pla ;75
	rti ;76
