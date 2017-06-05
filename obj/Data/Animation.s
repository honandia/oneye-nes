.include "obj/Data/Animation.h"
Data_Animation_NONE: ;1
	.byte 0,256-1 ;2
 ;3
Data_Animation_HERO__IDLE__DOWN: ;4
	.byte 0,256-1 ;5
Data_Animation_HERO__IDLE__UP: ;6
	.byte 7,256-1 ;7
Data_Animation_HERO__IDLE__LEFT: ;8
	.byte 4,256-1 ;9
Data_Animation_HERO__IDLE__RIGHT: ;10
	.byte $40|4,256-1 ;11
 ;12
Data_Animation_HERO__WALK__DOWN: ;13
	.byte 1,1,1,1,1,1,1,1 ;14
	.byte 0,0,0,0,0,0,0,0 ;15
	.byte $40|1,$40|1,$40|1,$40|1,$40|1,$40|1,$40|1,$40|1 ;16
	.byte 0,0,0,0,0,0,0,0 ;17
	.byte 256-32 ;18
 ;19
Data_Animation_HERO__WALK__LEFT: ;20
	.byte 3,3,3,3,3,3,3,3 ;21
	.byte 4,4,4,4,4,4,4,4 ;22
	.byte 5,5,5,5,5,5,5,5 ;23
	.byte 4,4,4,4,4,4,4,4 ;24
	.byte 256-32 ;25
 ;26
Data_Animation_HERO__WALK__RIGHT: ;27
	.byte $40|3,$40|3,$40|3,$40|3,$40|3,$40|3,$40|3,$40|3 ;28
	.byte $40|4,$40|4,$40|4,$40|4,$40|4,$40|4,$40|4,$40|4 ;29
	.byte $40|5,$40|5,$40|5,$40|5,$40|5,$40|5,$40|5,$40|5 ;30
	.byte $40|4,$40|4,$40|4,$40|4,$40|4,$40|4,$40|4,$40|4 ;31
	.byte 256-32 ;32
 ;33
Data_Animation_HERO__WALK__UP: ;34
	.byte 6,6,6,6,6,6,6,6 ;35
	.byte 7,7,7,7,7,7,7,7 ;36
	.byte 8,8,8,8,8,8,8,8 ;37
	.byte 7,7,7,7,7,7,7,7 ;38
	.byte 256-32 ;39
 ;40
 ;41
Data_Animation_BANANARANG__FLY: ;42
	.byte 6,6 ;43
	.byte 5,5 ;44
	.byte 4,4 ;45
	.byte 3,3 ;46
	.byte 2,2 ;47
	.byte 1,1 ;48
	.byte 0,0 ;49
	.byte 256-7*2 ;50
 ;51
Data_Animation_MINOTAUR__WALK__DOWN: ;52
	.byte 0,0,0,0,0,0,0,0 ;53
	.byte 1,1,1,1,1,1,1,1 ;54
	.byte 2,2,2,2,2,2,2,2 ;55
	.byte 1,1,1,1,1,1,1,1 ;56
	.byte 256-32 ;57
Data_Animation_MINOTAUR__WALK__UP: ;58
	.byte 3,3,3,3,3,3,3,3 ;59
	.byte 4,4,4,4,4,4,4,4 ;60
	.byte 5,5,5,5,5,5,5,5 ;61
	.byte 4,4,4,4,4,4,4,4 ;62
	.byte 256-32 ;63
Data_Animation_MINOTAUR__WALK__LEFT: ;64
	.byte 6,6,6,6,6,6,6,6 ;65
	.byte 7,7,7,7,7,7,7,7 ;66
	.byte 8,8,8,8,8,8,8,8 ;67
	.byte 7,7,7,7,7,7,7,7 ;68
	.byte 256-32 ;69
Data_Animation_MINOTAUR__WALK__RIGHT: ;70
	.byte $40|6,$40|6,$40|6,$40|6,$40|6,$40|6,$40|6,$40|6 ;71
	.byte $40|7,$40|7,$40|7,$40|7,$40|7,$40|7,$40|7,$40|7 ;72
	.byte $40|8,$40|8,$40|8,$40|8,$40|8,$40|8,$40|8,$40|8 ;73
	.byte $40|7,$40|7,$40|7,$40|7,$40|7,$40|7,$40|7,$40|7 ;74
	.byte 256-32 ;75
 ;76
Data_Animation_EXPLOSION: ;77
	.byte 0,0,0,0 ;78
	.byte 1,1,1,1 ;79
	.byte 2,2,2,2 ;80
	.byte 3,3,3,3 ;81
	.byte 4,4,4,4 ;82
	.byte 256-1 ;83
 ;84
Data_Animation_BEHOLDER__IDLE: ;85
	.byte 1,256-1 ;86
Data_Animation_BEHOLDER__OPEN__EYE: ;87
	.byte 2,2,2,2,2,2 ;88
	.byte 3,3,3,3,3,3 ;89
	.byte 0,256-1 ;90
Data_Animation_BEHOLDER__CLOSE__EYE: ;91
	.byte 3,3,3,3,3,3 ;92
	.byte 2,2,2,2,2,2 ;93
	.byte 1,256-1 ;94
Data_Animation_BEHOLDER__ATTACK: ;95
	.byte 4,4,4,4,4,4,0,256-1 ;96
 ;97
Data_Animation_BIRD__IDLE: ;98
	.byte 0,256-1 ;99
Data_Animation_BIRD__FLY__RIGHT: ;100
	.byte 1,1,1 ;101
	.byte 2,2,2 ;102
	.byte 3,3,3 ;103
	.byte 2,2,2 ;104
	.byte 256-4*3 ;105
Data_Animation_BIRD__FLY__LEFT: ;106
	.byte $40|1,$40|1,$40|1 ;107
	.byte $40|2,$40|2,$40|2 ;108
	.byte $40|3,$40|3,$40|3 ;109
	.byte $40|2,$40|2,$40|2 ;110
	.byte 256-4*3 ;111
 ;112
Data_Animation_BLOB__WALK: ;113
	.byte 0,0,0,0,0,0,0,0 ;114
	.byte 1,1,1,1,1,1,1,1 ;115
	.byte 2,2,2,2,2,2,2,2 ;116
	.byte 1,1,1,1,1,1,1,1 ;117
	.byte 256-32 ;118
 ;119
Data_Animation_GHOST__FLOAT: ;120
	.byte 0,0,0,0,0,0,0,0 ;121
	.byte 1,1,1,1,1,1,1,1 ;122
	.byte 2,2,2,2,2,2,2,2 ;123
	.byte 1,1,1,1,1,1,1,1 ;124
	.byte 256-32 ;125
Data_Animation_GHOST__ATTACK__LEFT: ;126
	.byte $40|3,$40|3,$40|3,$40|3,$40|3,$40|3,$40|3,$40|3 ;127
	.byte $40|4,$40|4,$40|4,$40|4,$40|4,$40|4,$40|4,$40|4 ;128
	.byte $40|5,$40|5,$40|5,$40|5,$40|5,$40|5,$40|5,$40|5 ;129
	.byte $40|4,$40|4,$40|4,$40|4,$40|4,$40|4,$40|4,$40|4 ;130
	.byte 256-32 ;131
Data_Animation_GHOST__ATTACK__RIGHT: ;132
	.byte 3,3,3,3,3,3,3,3 ;133
	.byte 4,4,4,4,4,4,4,4 ;134
	.byte 5,5,5,5,5,5,5,5 ;135
	.byte 4,4,4,4,4,4,4,4 ;136
	.byte 256-32 ;137
 ;138
Data_Animation_SHADOW__FLICKER: ;139
	.byte 0,1,256-2 ;140
 ;141
Data_Animation_GORILLA__HAND__RIGHT: ;142
	.byte 0,256-1 ;143
Data_Animation_GORILLA__HAND__LEFT: ;144
	.byte $40|0,256-1 ;145
 ;146
Data_Animation_GORILLA__HEAD0: ;147
	.byte 0,256-1 ;148
Data_Animation_GORILLA__HEAD1: ;149
	.byte 1,256-1 ;150
Data_Animation_GORILLA__HEAD2: ;151
	.byte 2,256-1 ;152
 ;153
Data_Animation_POWERUP__SPARKLE: ;154
	.byte 0,0,0,0,0,0,0,0 ;155
	.byte 0,0,0,0,0,0,0,0 ;156
	.byte 1,1,2,2,3,3,4,4,5,5,6,6 ;157
	.byte 0,0,0,0,0,0,0,0 ;158
	.byte 0,0,0,0,0,0,0,0 ;159
	.byte 256-44 ;160
