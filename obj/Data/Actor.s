.include "obj/Data/Actor.h"
.include "obj/Ai.h"
.include "obj/Ai/Bananarang.h"
.include "obj/Ai/Beholder.h"
.include "obj/Ai/BeholderProjectile.h"
.include "obj/Ai/Bird.h"
.include "obj/Ai/Blob.h"
.include "obj/Ai/Explosion.h"
.include "obj/Ai/Ghost.h"
.include "obj/Ai/GorillaHand.h"
.include "obj/Ai/GorillaHead.h"
.include "obj/Ai/Hero.h"
.include "obj/Ai/Minotaur.h"
.include "obj/Ai/Powerup.h"
.include "obj/Ai/Shadow.h"
.include "obj/Ai/Util.h"
 ;2
 ;3
 ;4
 ;5
 ;6
 ;7
 ;8
 ;9
 ;10
 ;11
 ;12
 ;13
 ;14
 ;15
 ;16
 ;17
 ;18
 ;19
 ;20
Data_Actor_GFX: ;21
	.addr $0000, Data_Actor_GFX__HERO, Data_Actor_GFX__BANANARANG, Data_Actor_GFX__MINOTAUR, Data_Actor_GFX__EXPLOSION, Data_Actor_GFX__BEHOLDER, Data_Actor_GFX__BIRD, Data_Actor_GFX__BLOB, Data_Actor_GFX__GHOST, Data_Actor_GFX__SHADOW, Data_Actor_GFX__BEHOLDER__PROJECTILE, Data_Actor_GFX__POWERUP, Data_Actor_GFX__GORILLA__HAND, Data_Actor_GFX__GORILLA__HEAD ;22
Data_Actor_AI: ;23
	.addr $0000, Ai_Hero_run-1, Ai_Bananarang_run-1, Ai_Minotaur_run-1, Ai_Explosion_run-1, Ai_Beholder_run-1, Ai_Bird_run-1, Ai_Blob_run-1, Ai_Ghost_run-1, Ai_Shadow_run-1, Ai_BeholderProjectile_run-1, Ai_Powerup_run-1, Ai_GorillaHand_run-1, Ai_GorillaHead_run-1 ;24
Data_Actor_PALETTE: ;25
	.byte $00, $00, $01, $02, $01, $00, $01, $03, $02, $00, $01, $01, $01, $01 ;26
Data_Actor_HP: ;27
	.byte 0, 4, 0, 16, 0, 8, 6, 4, 24, 0, 0, 0, 0, 0 ;28
Data_Actor_SIZE: ;29
	.byte Data_Actor_SIZE__8x8, Data_Actor_SIZE__16x16, Data_Actor_SIZE__8x8, Data_Actor_SIZE__16x16, Data_Actor_SIZE__16x16, Data_Actor_SIZE__16x16, Data_Actor_SIZE__16x16, Data_Actor_SIZE__16x16, Data_Actor_SIZE__16x16, Data_Actor_SIZE__8x8, Data_Actor_SIZE__8x8, Data_Actor_SIZE__16x16, Data_Actor_SIZE__16x16, Data_Actor_SIZE__16x16 ;30
 ;31
Data_Actor_GFX__HERO: ;32
	;down ;33
	.byte $00,$01,$10,$11 ;34
	.byte $02,$03,$12,$13 ;35
	.byte $00,$00,$00,$00 ;36
	;left ;37
	.byte $06,$07,$16,$17 ;38
	.byte $08,$09,$18,$19 ;39
	.byte $0A,$0B,$1A,$1B ;40
	;up ;41
	.byte $20,$21,$30,$31 ;42
	.byte $22,$23,$32,$33 ;43
	.byte $24,$25,$34,$35 ;44
 ;45
Data_Actor_GFX__BANANARANG: ;46
	.byte $0E,$0F,$1E,$1F,$2E,$3E,$3F ;47
 ;48
Data_Actor_GFX__MINOTAUR: ;49
	.byte $4A,$4B,$5A,$5B ;down ;50
	.byte $4C,$4D,$5C,$5D ;51
	.byte $4E,$4F,$5E,$5F ;52
	.byte $6A,$6B,$7A,$7B ;up ;53
	.byte $6C,$6D,$7C,$7D ;54
	.byte $6E,$6F,$7E,$7F ;55
	.byte $8A,$8B,$9A,$9B ;left ;56
	.byte $8C,$8D,$9C,$9D ;57
	.byte $8E,$8F,$9E,$9F ;58
 ;59
Data_Actor_GFX__EXPLOSION: ;60
	.byte $60,$61,$70,$71 ;61
	.byte $62,$63,$72,$73 ;62
	.byte $64,$65,$74,$75 ;63
	.byte $66,$67,$76,$77 ;64
	.byte $FF,$FF,$78,$79 ;65
 ;66
Data_Actor_GFX__BEHOLDER: ;67
	.byte $46,$47,$56,$57 ;eye opened ;68
	.byte $48,$49,$58,$59 ;eye closed ;69
	.byte $42,$43,$52,$53 ;opening-1 ;70
	.byte $44,$45,$54,$55 ;opening-2 ;71
	.byte $40,$41,$50,$51 ;attack ;72
 ;73
Data_Actor_GFX__BIRD: ;74
	.byte $86,$87,$96,$97 ;standing ;75
	.byte $80,$81,$90,$91 ;flying ;76
	.byte $82,$83,$92,$93 ;77
	.byte $84,$85,$94,$95 ;78
 ;79
Data_Actor_GFX__BLOB: ;80
	.byte $AA,$AB,$BA,$BB ;81
	.byte $AC,$AD,$BC,$BD ;82
	.byte $AE,$AF,$BE,$BF ;83
 ;84
Data_Actor_GFX__GHOST: ;85
	.byte $A0,$A1,$B0,$B1 ;happy ;86
	.byte $A2,$A3,$B2,$B3 ;87
	.byte $A4,$A5,$B4,$B5 ;88
	.byte $A0,$A6,$B0,$B6 ;angry ;89
	.byte $A2,$A7,$B2,$B7 ;90
	.byte $A4,$A8,$B4,$B8 ;91
 ;92
Data_Actor_GFX__SHADOW: ;93
	.byte $68,$FF ;94
 ;95
Data_Actor_GFX__BEHOLDER__PROJECTILE: ;96
	.byte $2F ;97
 ;98
Data_Actor_GFX__POWERUP: ;99
	.byte $04,$05,$14,$15 ;100
	.byte $2A,$2B,$3A,$3B ;101
	.byte $2C,$2D,$3C,$3D ;102
	.byte $C0,$C1,$D0,$D1 ;103
	.byte $C2,$C3,$D2,$D3 ;104
	.byte $E4,$E5,$F4,$F5 ;105
	.byte $E8,$E9,$F8,$F9 ;106
	.byte $EA,$EB,$FA,$FB ;107
 ;108
Data_Actor_GFX__GORILLA__HAND: ;109
	.byte $E0,$E1,$F0,$F1 ;110
 ;111
Data_Actor_GFX__GORILLA__HEAD: ;112
	.byte $C4,$C5,$D4,$D5 ;113
	.byte $C6,$C7,$D6,$D7 ;114
	.byte $C8,$C9,$D8,$D9 ;115
 ;116
 ;117
 ;118
