.ifndef __VBLANK_H
__VBLANK_H = 1
.globalzp Vblank_nmiActive ;2
.globalzp Vblank_cmdAddr ;3
.global Vblank_wait4 ;5
.global Vblank_wait ;11
.global Vblank_cmd ;19
	.macro Vblank_cmd_replace Vblank_cmd_replace_addr ;26
		lda #<Vblank_cmd_replace_addr ;27
		sta Vblank_cmdAddr ;28
		lda #>Vblank_cmd_replace_addr ;29
		sta Vblank_cmdAddr+1 ;30
	.endmacro ;31
.global Vblank_cmd_end ;33
.global Vblank_runCmdFunc ;39
.global Vblank_nmi ;42
.endif
