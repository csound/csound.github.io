fofx5.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
;USE THE FOLLOWING LINE OF CODE TO USE AN EXTERNAL MIDI KEYBOARD
;-odac -M0 -dm0
;USE THE FOLLOWING LINE TO USE THE VIRTUAL MIDI KEYBOARD
-odac -M0 -+rtmidi=virtual -dm0
</CsOptions>

<CsInstruments>
sr 			= 		44100
ksmps 			= 		16
nchnls 			= 		2
0dbfs			=		1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0

			FLpanel	"fof x 5", 1010, 680, 0, 0

;GENERAL_TEXT_SETTINGS			SIZE | FONT | ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,     4,     0,     0,      0

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,        9,    15,    380,    60,   500, 335	;EQ
ih		 	FLbox  	" ", 	6,        9,    15,    125,    60,   885, 335	;CHORUS
ih		 	FLbox  	" ", 	6,        9,    15,    490,   180,     0, 200	;FUNDEMENTAL AND AMPLITUDE MODULATION
ih		 	FLbox  	" ", 	6,        9,    15,    160,   180,   333, 200	;LFO VARIABILITY
ih		 	FLbox  	" ", 	6,        9,    15,    335,    80,     0, 300	;AMPLITUDE RANDOMIZATION
ih		 	FLbox  	" ", 	6,        9,    15,    215,    60,   500, 396	;REVERB
ih		 	FLbox  	" ", 	6,        9,    15,    295,    60,   715, 396	;DELAY
ih		 	FLbox  	" ", 	6,        9,    15,    340,   140,   500, 460	;INPUT MODE
ih		 	FLbox  	" ", 	6,        9,    15,    150,   170,   850, 460	;VOICE TYPE SELECT
ih		 	FLbox  	" ", 	6,        9,    15,    250,    60,   500, 150	;GRAIN ENVELOPE
ih		 	FLbox  	" ", 	6,        9,    15,    260,   120,   500, 215	;VOWEL LFO
ih		 	FLbox  	" ", 	6,        9,    15,    245,   120,   765, 215	;VOWEL RANDOMIZATION

;TEXT BOXES											TYPE | FONT | SIZE |  WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Octave", 							1,       9,    12,     100,    30,   610, 565
ih		 	FLbox  	"Semitones", 							1,       9,    12,     100,    30,   690, 565
ih		 	FLbox  	"Fundemental and Amplitude LFO",				1,       2,    12,     190,    10,   5,   206
ih		 	FLbox  	"LFO Variability",						1,       2,    12,     105,    10,   355, 206
ih		 	FLbox  	"Fundemental Randomization",					1,       2,    12,     165,    10,   5,   306
ih		 	FLbox  	"Grain Envelope",						1,       2,    11,      85,    10,   505, 155
ih		 	FLbox  	"Vowel LFO",							1,       2,    12,      70,    10,   505, 222
ih		 	FLbox  	"Vowel Randomization",						1,       2,    12,     130,    10,   770, 222

;COUNTERS					MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkOctave,   ihOctave 	FLcount  " ", 		4,    12,     1,      1,      2,    80,      20,   620,545,   -1
gkSemiStep, ihSemiStep 	FLcount  " ", 		0,    12,     1,      1,      2,    80,      20,   700,545,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT | ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,     1,    255,   255,   255		;LABELS MADE INVISIBLE

FLcolor2	255, 255, 50		;SET SECONDARY COLOUR TO YELLOW
;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkIPmode,   ihIPmode	FLbutBank	12,     1,     3,     30,    75,    510, 495,    -1
gkvoice, gihvoice	FLbutBank	12,     1,     5,     30,    125,   860, 495,    -1
gkLFOmode, ihLFOmode	FLbutBank	12,     1,     6,     30,    90,    510, 240,    -1
FLcolor2	0, 0, 0

;GENERAL_TEXT_SETTINGS			SIZE | FONT | ALIGN | RED | GREEN | BLUE
			FLlabel		13,      5,      4,   0,      0,     0		;LABELS MADE VISIBLE AGAIN

;TEXT BOXES									TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Fundemental and Vowel Input Mode", 		1,       2,    12,    220,    30,   505, 465
ih		 	FLbox  	"Sliders or MIDI", 				1,       5,    12,    120,    25,   540, 495
ih		 	FLbox  	"XY Panel", 					1,       5,    12,    70,     25,   540, 520
ih		 	FLbox  	"Counters", 					1,       5,    12,    70,     25,   540, 545
ih		 	FLbox  	"Voice", 					1,       2,    12,    50,     30,   860, 465
ih		 	FLbox  	"Bass         ", 				1,       5,    12,    70,     25,   905, 495
ih		 	FLbox  	"Tenor        ", 				1,       5,    12,    70,     25,   905, 520
ih		 	FLbox  	"Counter-Tenor", 				1,       5,    12,    70,     25,   905, 545
ih		 	FLbox  	"Alto         ", 				1,       5,    12,    70,     25,   905, 570
ih		 	FLbox  	"Soprano      ", 				1,       5,    12,    70,     25,   905, 595
ih		 	FLbox  	"Sine           ", 				1,       5,    11,   120,     15,   540, 240
ih		 	FLbox  	"Triangle       ", 				1,       5,    11,   120,     15,   540, 255
ih		 	FLbox  	"Bipolar Square ", 				1,       5,    11,   120,     15,   540, 270
ih		 	FLbox  	"Unipolar Square", 				1,       5,    11,   120,     15,   540, 285
ih		 	FLbox  	"Sawtooth Up    ", 				1,       5,    11,   120,     15,   540, 300
ih		 	FLbox  	"Sawtooth Down  ", 				1,       5,    11,   120,     15,   540, 315

;GENERAL_TEXT_SETTINGS			SIZE | FONT | ALIGN | RED | GREEN | BLUE
			FLlabel		13,     1,      1,     0,     0,      0

;SWITCHES                                           			ON | OFF | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On / Off (Off for MIDI)",	1,    0,    22,   160,      35,     5,   5,   0,       2,     0,      -1
gkRvbOnOff,ihRvbOnOff	FLbutton	"Reverb",			1,    0,    22,    65,      20,   510, 405,   0,     100,     0,      -1
gkDlyOnOff,ihDlyOnOff	FLbutton	"Delay",			1,    0,    22,    60,      20,   720, 405,   0,     102,     0,      -1
gkEQOnOff,ihEQOnOff	FLbutton	"EQ",				1,    0,    22,    65,      20,   510, 345,   0,       3,     0,      -1
gkChoOnOff,ihChoOnOff	FLbutton	"Chorus",			1,    0,    22,    65,      20,   890, 345,   0,       5,     0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihRvbOnOff	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihDlyOnOff	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihEQOnOff		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihChoOnOff	;SET SECONDARY COLOUR TO YELLOW

;GENERAL_TEXT_SETTINGS			SIZE | FONT | ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    0,     0,      0

;VALUE_DISPLAY_BOXES				WIDTH | HEIGHT | X | Y
idfund			FLvalue	" ",	 	70,      18,     5, 125
idoct			FLvalue	" ",	 	70,      18,     5, 175
idoutamp		FLvalue	" ",	 	70,      18,   505,  75
idporttime1		FLvalue	" ",	 	35,      18,   505, 125
idporttime2		FLvalue	" ",	 	35,      18,   755, 125
idenv			FLvalue	" ",		65,      18,   510, 180
idEQ			FLvalue	" ",		65,      18,   510, 365
idVlLFOamp		FLvalue	" ",		50,      18,   655, 300
idVlLFOfrq		FLvalue	"Hz.",		50,      18,   705, 300
idVlRndamp		FLvalue	" ",		50,      18,   775, 245
idVlRndfrq		FLvalue	" ",		50,      18,   875, 245
idRvb			FLvalue	" ",		65,      18,   510, 425
idfund2			FLvalue	"Fundemental",	65,      18,     5, 385
idndx2			FLvalue	"Vowel",	65,      18,     5, 435
iddly			FLvalue	" ",		60,      18,   720, 425
idmoddep		FLvalue	" ",		50,      18,   10,  280
idmodfrq		FLvalue	" ",		50,      18,   60,  280
idvibdep		FLvalue	" ",		50,      18,  110,  280
idtrmdep		FLvalue	" ",		50,      18,  160,  280
idmoddly		FLvalue	" ",		50,      18,  210,  280
idmodris		FLvalue	" ",		50,      18,  260,  280
idamprand		FLvalue	" ",		50,      18,  360,  280
idamprandF		FLvalue	" ",		50,      18,  410,  280
idfrqrand		FLvalue	" ",		50,      18,  360,  355
idfrqrandF		FLvalue	" ",		50,      18,  410,  355
idFundRnd		FLvalue	" ",		65,      18,   10,  340

;SLIDERS					     							MIN  | MAX | EXP | TYPE |   DISP   | WIDTH | HEIGHT | X | Y
gkndx, gihndx			FLslider	"A                           E                           I                           O                           U",            		0,   1,  0,   23,   -1,   490,     25,    5, 50
gkfund, gihfund			FLslider	"Fundemental (Hz)",					1,    3000,  -1,    23,  idfund,      490,     25,     5, 100
gkoct, ihoct			FLslider	"Octaviation Factor",					0,       8,   0,    23,  idoct,       490,     25,     5, 150
gkoutamp, ihoutamp		FLslider	"Amplitude",						0,       1,   0,    23,  idoutamp,    490,     25,   505,  50
gkporttime1, ihporttime1	FLslider	"Portamento on Fundemental",				0,       1,   0,    23,  idporttime1, 245,     25,   505, 100
gkporttime2, ihporttime2	FLslider	"Portamento on  Formant",				0,       1,   0,    23,  idporttime2, 245,     25,   755, 100
gkChoRate, ihChoRate		FLslider	"Rate",							.001,    2,   0,    23,  -1,           65,     14,   890, 367
gkVlRndType,ihVlRndType		FLslider	"Interp<------------------------------------->S&H",     0,       1,   0,    23,  -1,          225,     14,   775, 300
gkFundRndType,ihFundRndType	FLslider	"Interp<------->S&H",     				0,       1,   0,    23,  -1,          140,     20,   180, 330

;KNOBS								MIN | MAX | EXP | TYPE |   DISP    | WIDTH | X | Y
gkmoddep, gihmoddep	FLknob 		"ModDep", 		0,    1,      0,    1,    idmoddep,  40,   15,  225
gkmodfrq, ihmodfrq	FLknob 		"ModFrq", 		0,    10,     0,    1,    idmodfrq,  40,   65, 225
gkvibdep, ihvibdep	FLknob 		"VibDep", 		0,     .1,    0,    1,    idvibdep,  40,   115, 225
gktrmdep, ihtrmdep	FLknob 		"TrmDep", 		0,     1,     0,    1,    idtrmdep,  40,   165, 225
gkmoddly, ihmoddly	FLknob 		"ModDly", 		0,     3,     0,    1,    idmoddly,  40,   215, 225
gkmodris, ihmodris	FLknob 		"ModRis", 		0,     3,     0,    1,    idmodris,  40,   265, 225
gkamprand, ihamprand 	FLknob 		"AmpOS",		0,       1,   0,    1,    idamprand, 40,   365, 225
gkamprandF, ihamprandF 	FLknob 		"AmpOSF",		0,       10,  0,    1,    idamprandF,40,   415, 225
gkfrqrand, ihfrqrand 	FLknob 		"FrqOS",		0,       5,   0,    1,    idfrqrand, 40,   365, 300
gkfrqrandF, ihfrqrandF 	FLknob 		"FrqOSF",		0,       10,  0,    1,    idfrqrandF,40,   415, 300

gkFundRndA, ihFundRndA 	FLknob 		"RandAmp",		0,        2,  0,    1,    idFundRnd,40,  80, 320
gkFundRndF, ihFundRndF 	FLknob 		"RandFrq",		.00001,  30,  0,    1,    idFundRnd,40, 130, 320

gkris, ihris 		FLknob 		"Rise",			.001,  .05,   0,    1,    idenv,  40,   595, 155
gkdur, ihdur 		FLknob 		"Dur.", 		.017,    1,   0,    1,    idenv,  40,   645, 155
gkdec, ihdec 		FLknob 		"Dec.", 		.001,  .05,   0,    1,    idenv,  40,   695, 155
gkVlLFOAmp, ihVlLFOAmp 	FLknob 		"Depth",		0,       1,   0,   1,    idVlLFOamp,40,660, 245
gkVlLFOFrq, ihVlLFOFrq 	FLknob 		"Rate",			0,       20,  0,    1,    idVlLFOfrq,40,710, 245
gkVlRndAmp, ihVlRndAmp 	FLknob 		"Rnd.Amt",		0,       1,   0,   1,    idVlRndamp,40,830, 240
gkVlRndFrq, ihVlRndFrq 	FLknob 		"Rnd.Frq",		0,       50,  0,    1,    idVlRndfrq,40,930, 240
gkHPF, ihHPF 		FLknob 		"HPF", 			20,  20000,  -1,    1,    idEQ,   40,   580, 340
gkcf, ihcf 		FLknob 		"Cutoff", 		100,  8000,  -1,    1,    idEQ,   40,   630, 340
gkgain, ihgain 		FLknob 		"Gain", 		0,    15,     0,    1,    idEQ,   40,   680, 340
gkq, ihq 		FLknob 		"Res.", 		.707, 10,     0,    1,    idEQ,   40,   730, 340
gkLPF, ihLPF		FLknob 		"LPF", 			20,   20000, -1,    1,    idEQ,   40,   780, 340
gkEQlev, ihEQlev	FLknob 		"Level", 		0,    3,      0,    1,    idEQ,   40,   830, 340
gkChoDep, ihChoDep	FLknob 		"Depth", 		0,    1,      0,    1,    -1,     40,   960, 340

gkrndfund, ihrndfund	FLknob 		"Random Fundemental", 	0,     .1,    0,    1,    -1,     40,   950, 140
gkrvbmix, ihrvbmix	FLknob 		"Mix", 			0,     1,     0,    1,    idRvb,  40,   580, 400
gkrvbtim, ihrvbtim	FLknob 		"Size", 		0,     1,     0,    1,    idRvb,  40,   625, 400
gkhfdiff, ihhfdiff	FLknob 		"HF.Diff", 		0,     1,     0,    1,    idRvb,  40,   670, 400
gkDlyMix, ihDlyMix	FLknob 		"Mix", 			0,     1,     0,    1,    iddly,  40,   785, 400
gkDlyTim, ihDlyTim	FLknob 		"Time",			.001,  2,     0,    1,    iddly,  40,   830, 400
gkDlyFB,  ihDlyFB	FLknob 		"F.B.",			0,     .95,   0,    1,    iddly,  40,   875, 400
gkDlyModDep,ihDlyModDep	FLknob 		"ModDep",		0,     1,     0,    1,    iddly,  40,   920, 400
gkDlyModFrq,ihDlyModFrq	FLknob 		"ModFrq",		0,     10,    0,    1,    iddly,  40,   965, 400

;XY PANELS								MINX | MAXX | MINY | MAXY | EXPX | EXPY | DISPX | DISPY | WIDTH | HEIGHT | X | Y
gkfund2, gkndx2, gihfund2, gihndx2	FLjoy	"X - Freq  Y - Vowel",	10,    2000,    0,     1,    -1,     0,  idfund2, idndx2,  410,    280,    80,385

			FLsetVal_i	100, gihfund2
			FLsetVal_i	1126, gihndx2
			
			FLsetVal_i	0, 	gihndx
			FLsetVal_i	100, 	gihfund
			FLsetVal_i	0, 	ihoct
			FLsetVal_i	0, 	gihvoice
			FLsetVal_i	.22, 	gihmoddep
			FLsetVal_i	5.3, 	ihmodfrq
			FLsetVal_i	.5, 	ihmoddly
			FLsetVal_i	.5, 	ihmodris
			FLsetVal_i	.032, 	ihvibdep
			FLsetVal_i	.15, 	ihtrmdep
			FLsetVal_i	.5, 	ihrvbmix
			FLsetVal_i	.5, 	ihrvbtim
			FLsetVal_i	.1, 	ihhfdiff
			FLsetVal_i	.003, 	ihris
			FLsetVal_i	.02, 	ihdur
			FLsetVal_i	.007, 	ihdec
			FLsetVal_i	10000, 	ihoutamp
			FLsetVal_i	0, 	ihamprand
			FLsetVal_i	1, 	ihamprandF
			FLsetVal_i	.5, 	ihfrqrand
			FLsetVal_i	10, 	ihfrqrandF
			FLsetVal_i	20, 	ihHPF
			FLsetVal_i	300, 	ihcf
			FLsetVal_i	1, 	ihgain
			FLsetVal_i	3, 	ihq
			FLsetVal_i	20000, 	ihLPF
			FLsetVal_i	1, 	ihEQlev
			FLsetVal_i	.5, 	ihChoDep
			FLsetVal_i	.25, 	ihChoRate
			FLsetVal_i	0, 	ihVlLFOAmp
			FLsetVal_i	1, 	ihVlLFOFrq
			FLsetVal_i	0, 	ihVlRndAmp
			FLsetVal_i	1, 	ihVlRndFrq
			FLsetVal_i	0, 	ihIPmode
			FLsetVal_i	.03, 	ihporttime1
			FLsetVal_i	.05, 	ihporttime2
			FLsetVal_i	0, 	ihrndfund
			FLsetVal_i	.5, 	ihDlyMix	
			FLsetVal_i	.9, 	ihDlyTim	
			FLsetVal_i	.3, 	ihDlyFB	        
			FLsetVal_i	0, 	ihDlyModDep	        
			FLsetVal_i	.3, 	ihDlyModFrq	        
			FLsetVal_i	1.5, 	ihFundRndF 	        
			FLsetVal_i	.002, 	ihFundRndA 	        
			FLsetVal_i	7, 	ihOctave
			FLsetVal_i	0, 	ihSemiStep
			FLsetVal_i	1, 	ihRvbOnOff
			FLsetVal_i	0, 	ihVlRndType

			FLsetTextSize 	10, 	ihHPF
			FLsetTextSize 	10, 	ihcf
			FLsetTextSize 	10, 	ihgain
			FLsetTextSize 	10, 	ihq
			FLsetTextSize 	10, 	ihLPF
			FLsetTextSize 	10, 	ihEQlev
			FLsetTextSize 	10, 	ihChoDep
			FLsetTextSize 	10, 	ihChoRate
			FLsetTextSize 	10, 	ihris
			FLsetTextSize 	10, 	ihdur
			FLsetTextSize 	10, 	ihdec
			FLsetTextSize 	10, 	ihamprand
			FLsetTextSize 	10, 	ihamprandF
			FLsetTextSize 	10, 	ihfrqrand
			FLsetTextSize 	10, 	ihfrqrandF
			FLsetTextSize 	10, 	ihVlLFOAmp
			FLsetTextSize 	10, 	ihVlLFOFrq
			FLsetTextSize 	10, 	ihVlRndAmp
			FLsetTextSize 	10, 	ihVlRndFrq
			FLsetTextSize 	10, 	gihmoddep
			FLsetTextSize 	10, 	ihmodfrq
			FLsetTextSize 	10, 	ihmoddly
			FLsetTextSize 	10, 	ihmodris
			FLsetTextSize 	10, 	ihvibdep
			FLsetTextSize 	10, 	ihtrmdep
			FLsetTextSize 	10, 	ihrvbmix
			FLsetTextSize 	10, 	ihrvbtim
			FLsetTextSize 	10, 	ihhfdiff
			FLsetTextSize 	10, 	ihrndfund
			FLsetTextSize 	10, 	ihDlyMix	
			FLsetTextSize 	10, 	ihDlyTim	
			FLsetTextSize 	10, 	ihDlyFB	        
			FLsetTextSize 	10, 	ihDlyModDep
			FLsetTextSize 	10, 	ihDlyModFrq       
			FLsetTextSize 	10, 	ihFundRndF
			FLsetTextSize 	10, 	ihFundRndA       

			FLpanel_end	;END OF PANEL CONTENTS


;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 600,550, 0
				FLscroll     515, 600, 0,  0

;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                         FOF x 6                             ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"This example make use of six simultaneous instances of the   ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"opcode to imitate a variety of singing voices singing various", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"vowel sounds.                                                ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"The interface allows a variety of methods for inputting the  ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"essential parameter values and the patch incorporates several", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"additional effects and elaborations.                         ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"The first method for parameter input is 'Sliders or MIDI'. To", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"use sliders, first activate the main 'On/Off' button which   ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"then allows control of the fundemental of the tone using the ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"'Fundemental (Hz)' slider and of the vowel using the         ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"'A E I O U' slider. To use MIDI just leave the main 'On/Off' ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"button deactivated and play notes on the MIDI keyboard. The  ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"instrument is monophonic with portamento between notes       ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"controllable using the 'Portamento on Fundemental' control.  ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"MIDI continuous controller 2 can be used to modulate the     ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"vowel type produced and controller 1 controls vibrato depth. ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"The second method for parameter input is 'XY Panel'. With    ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"this method activated, fundemental and vowel type of the tone", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"are controllable using the XY panel at the bottom of the     ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"interface. Movement in the vertical plane varys the          ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"fundemental and movement in the horizontal plane vary the    ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"vowel type.                                                  ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"Selecting the 'Counters' option for parameter input mode     ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"allows the fundemental to be defined using the two           ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"neighbouring counters. In this mode, vowel type is varyed    ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"using the slider.                                            ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"A bordered panel contains various controls for fundemental   ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"and amplitude LFO modulation. 'Vibrato' refers to fundemental", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"modulation and 'tremolo' refers to amplitude modulation.     ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"There are controls for how quickly the modulation builds,    ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"('ModRis') and the delay time before it begins to build,     ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"('ModDly'). There is overall control of modulation depth and ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"frequency ('ModDep' and 'ModFrq') and independent control    ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"over vibrato and tremolo depth ('VibDep' and 'TrmDep').      ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"Audio output can be rendered by clicking 'File Open' and then", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"activating 'Record'. Recording can be paused and restarted by", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"deactivating and reactivating the 'Record' button. Clicking  ", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"'File Open' again will clear any previously recorded         ", 	1,      5,     14,    490,    20,     5, 820
ih		 	FLbox  	"material. A 24 bit sound file called 'fofx6Output.wav' will  ", 	1,      5,     14,    490,    20,     5, 840
ih		 	FLbox  	"be created in the default directory for SFDIR.               ", 	1,      5,     14,    490,    20,     5, 860

				FLscrollEnd
				FLpanel_end

		FLlabel		13,      1,      1,     0,     0,     0	;FORMAT LABEL				
;RECORD OUTPUT PANEL
		FLpanel	"Record",   300,    35,  0, 735
;BUTTONS                        	LABEL       | ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkfileopen,ihfileopen	FLbutton	"File Open",  1,    0,    21,    140,     25,    5,  5,     0,    103,    0,       -1
gkrecord,ihrecord	FLbutton	"Record",     1,    0,    22,    140,     25,  150,  5,    -1
FLsetColor2	255, 255, 50, ihfileopen	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 50, 50, ihrecord		;SET SECONDARY COLOUR TO RED
FLpanel_end	;END OF PANEL CONTENTS

			FLrun		;RUN THE WIDGET THREAD!

gasend			init		0	;GLOBAL VARIABLE USED TO PASS AUDIO BETWEEN INSTRUMENTS 
gaDlySend		init		0	;GLOBAL VARIABLE USED TO PASS AUDIO TO DELAY EFFECT
                  
gisine	ftgen	0, 0, 4096, 10, 1				;SINE WAVE
giexp	ftgen	0, 0, 1024, 19, 0.5, 0.5, 270, 0.5		;EXPONENTIAL CURVE USED TO DEFINE THE ENVELOPE SHAPE OF FOF PULSES

; FUNCTION TABLES STORING DATA FOR VARIOUS VOICE FORMANTS
;BASS
giBF1		ftgentmp	0,  0, 8, -2,	600,		400,	250,	400,	350	;FREQ
giBF2		ftgentmp	0,  0, 8, -2,	1040,	1620,	1750,	750,	600	;FREQ
giBF3		ftgentmp	0,  0, 8, -2,	2250,	2400,	2600,	2400,	2400	;FREQ
giBF4		ftgentmp	0,  0, 8, -2,	2450,	2800,	3050,	2600,	2675	;FREQ
giBF5		ftgentmp	0,  0, 8, -2,	2750,	3100,	3340,	2900,	2950	;FREQ
        	
giBDb1		ftgentmp	0, 0, 8, -2,	0,	0,	0,	0,	0	;dB
giBDb2		ftgentmp	0, 0, 8, -2,	-7,	-12,	-30,	-11,	-20	;dB
giBDb3		ftgentmp	0, 0, 8, -2,	-9,	-9,	-16,	-21,	-32	;dB
giBDb4		ftgentmp	0, 0, 8, -2,	-9,	-12,	-22,	-20,	-28	;dB
giBDb5		ftgentmp	0, 0, 8, -2,	-20,	-18,	-28,	-40,	-36	;dB
        	
giBBW1		ftgentmp	0, 0, 8, -2,	60,	40,	60,	40,	40	;BAND WIDTH
giBBW2		ftgentmp	0, 0, 8, -2,	70,	80,	90,	80,	80	;BAND WIDTH
giBBW3		ftgentmp	0, 0, 8, -2,	110,	100,	100,	100,	100	;BAND WIDTH
giBBW4		ftgentmp	0, 0, 8, -2,	120,	120,	120,	120,	120	;BAND WIDTH
giBBW5		ftgentmp	0, 0, 8, -2,	130,	120,	120,	120,	120	;BAND WIDTH
;TENOR  	
giTF1		ftgentmp	0, 0, 8, -2,	650, 	400,	290,	400,	350	;FREQ
giTF2		ftgentmp	0, 0, 8, -2,	1080, 	1700,   1870,	800,	600	;FREQ
giTF3		ftgentmp	0, 0, 8, -2,	2650,	2600,   2800,	2600,	2700	;FREQ
giTF4		ftgentmp	0, 0, 8, -2,	2900,	3200,   3250,	2800,	2900	;FREQ
giTF5		ftgentmp	0, 0, 8, -2,	3250,	3580,   3540,	3000,	3300	;FREQ
        	
giTDb1		ftgentmp	0, 0, 8, -2,	0,	0,	0,	0,	0	;dB
giTDb2		ftgentmp	0, 0, 8, -2,	-6,	-14,	-15,	-10,	-20	;dB
giTDb3		ftgentmp	0, 0, 8, -2,	-7,	-12,	-18,	-12,	-17	;dB
giTDb4		ftgentmp	0, 0, 8, -2,	-8,	-14,	-20,	-12,	-14	;dB
giTDb5		ftgentmp	0, 0, 8, -2,	-22,	-20,	-30,	-26,	-26	;dB
        	
giTBW1		ftgentmp	0, 0, 8, -2,	80,	70,	40,	40,	40	;BAND WIDTH
giTBW2		ftgentmp	0, 0, 8, -2,	90,	80,	90,	80,	60	;BAND WIDTH
giTBW3		ftgentmp	0, 0, 8, -2,	120,	100,	100,	100,	100	;BAND WIDTH
giTBW4		ftgentmp	0, 0, 8, -2,	130,	120,	120,	120,	120	;BAND WIDTH                                         
giTBW5		ftgentmp	0, 0, 8, -2,	140,	120,	120,	120,	120	;BAND WIDTH
;COUNTER TENOR
giCTF1		ftgentmp	0, 0, 8, -2,	660,	440,	270,	430,	370	;FREQ
giCTF2		ftgentmp	0, 0, 8, -2,	1120,	1800,	1850,	820,	630	;FREQ
giCTF3		ftgentmp	0, 0, 8, -2,	2750,	2700,	2900,	2700,	2750	;FREQ
giCTF4		ftgentmp	0, 0, 8, -2,	3000,	3000,	3350,	3000,	3000	;FREQ
giCTF5		ftgentmp	0, 0, 8, -2,	3350,	3300,	3590,	3300,	3400	;FREQ
        	
giTBDb1		ftgentmp	0, 0, 8, -2,	0,	0,	0,	0,	0	;dB
giTBDb2		ftgentmp	0, 0, 8, -2,	-6,	-14,	-24,	-10,	-20	;dB
giTBDb3		ftgentmp	0, 0, 8, -2,	-23,	-18,	-24,	-26,	-23	;dB
giTBDb4		ftgentmp	0, 0, 8, -2,	-24,	-20,	-36,	-22,	-30	;dB
giTBDb5		ftgentmp	0, 0, 8, -2,	-38,	-20,	-36,	-34,	-30	;dB
        	
giTBW1		ftgentmp	0, 0, 8, -2,	80,	70,	40,	40,	40	;BAND WIDTH
giTBW2		ftgentmp	0, 0, 8, -2,	90,	80,	90,	80,	60	;BAND WIDTH
giTBW3		ftgentmp	0, 0, 8, -2,	120,	100,	100,	100,	100	;BAND WIDTH
giTBW4		ftgentmp	0, 0, 8, -2,	130,	120,	120,	120,	120	;BAND WIDTH
giTBW5		ftgentmp	0, 0, 8, -2,	140,	120,	120,	120,	120	;BAND WIDTH
;ALTO   	
giAF1		ftgentmp	0, 0, 8, -2,	800,	400,	350,	450,	325	;FREQ
giAF2		ftgentmp	0, 0, 8, -2,	1150,	1600,	1700,	800,	700	;FREQ
giAF3		ftgentmp	0, 0, 8, -2,	2800,	2700,	2700,	2830,	2530	;FREQ
giAF4		ftgentmp	0, 0, 8, -2,	3500,	3300,	3700,	3500,	2500	;FREQ
giAF5		ftgentmp	0, 0, 8, -2,	4950,	4950,	4950,	4950,	4950	;FREQ
        	
giADb1		ftgentmp	0, 0, 8, -2,	0,	0,	0,	0,	0	;dB
giADb2		ftgentmp	0, 0, 8, -2,	-4,	-24,	-20,	-9,	-12	;dB
giADb3		ftgentmp	0, 0, 8, -2,	-20,	-30,	-30,	-16,	-30	;dB
giADb4		ftgentmp	0, 0, 8, -2,	-36,	-35,	-36,	-28,	-40	;dB
giADb5		ftgentmp	0, 0, 8, -2,	-60,	-60,	-60,	-55,	-64	;dB
        	
giABW1		ftgentmp	0, 0, 8, -2,	50,	60,	50,	70,	50	;BAND WIDTH
giABW2		ftgentmp	0, 0, 8, -2,	60,	80,	100,	80,	60	;BAND WIDTH
giABW3		ftgentmp	0, 0, 8, -2,	170,	120,	120,	100,	170	;BAND WIDTH
giABW4		ftgentmp	0, 0, 8, -2,	180,	150,	150,	130,	180	;BAND WIDTH
giABW5		ftgentmp	0, 0, 8, -2,	200,	200,	200,	135,	200	;BAND WIDTH
;SOPRANO
giSF1		ftgentmp	0, 0, 8, -2,	800,	350,	270,	450,	325	;FREQ
giSF2		ftgentmp	0, 0, 8, -2,	1150,	2000,	2140,	800,	700	;FREQ
giSF3		ftgentmp	0, 0, 8, -2,	2900,	2800,	2950,	2830,	2700	;FREQ
giSF4		ftgentmp	0, 0, 8, -2,	3900,	3600,	3900,	3800,	3800	;FREQ
giSF5		ftgentmp	0, 0, 8, -2,	4950,	4950,	4950,	4950,	4950	;FREQ
        	
giSDb1		ftgentmp	0, 0, 8, -2,	0,	0,	0,	0,	0	;dB
giSDb2		ftgentmp	0, 0, 8, -2,	-6,	-20,	-12,	-11,	-16	;dB
giSDb3		ftgentmp	0, 0, 8, -2,	-32,	-15,	-26,	-22,	-35	;dB
giSDb4		ftgentmp	0, 0, 8, -2,	-20,	-40,	-26,	-22,	-40	;dB
giSDb5		ftgentmp	0, 0, 8, -2,	-50,	-56,	-44,	-50,	-60	;dB
        	
giSBW1		ftgentmp	0, 0, 8, -2,	80,	60,	60,	70,	50	;BAND WIDTH
giSBW2		ftgentmp	0, 0, 8, -2,	90,	90,	90,	80,	60	;BAND WIDTH
giSBW3		ftgentmp	0, 0, 8, -2,	120,	100,	100,	100,	170	;BAND WIDTH
giSBW4		ftgentmp	0, 0, 8, -2,	130,	150,	120,	130,	180	;BAND WIDTH
giSBW5		ftgentmp	0, 0, 8, -2,	140,	200,	120,	135,	200	;BAND WIDTH

instr		1	;MIDI ACTIVATED INSTRUMENT 
	;READ VALUES FOR FREQUENCY FROM A MIDI KEYBOARD 
	icps			cpsmidi
	;CREATE A K-RATE GLOBAL VARIABLE FROM MIDI FREQ. VALUES
	
	gkfund			init		icps	;READ VALUES FOR FUNDEMENTAL FROM MIDI KEYBOARD IF MIDI ACTIVATED
	
        ;MIDI CONTROLLER SYNCHRONISATION
#define CONTROLLER(NAME'NUMBER'MIN'MAX)
        #
        k$NAME          ctrl7           1,$NUMBER,0,1           ;READ MIDI CONTROLLER
        ktrig$NAME      changed         k$NAME                  ;CREATE A TRIGGER PULSE IF MIDI CONTROLLER IS MOVED
        k$NAME          scale           k$NAME, $MAX, $MIN      ;VARIABLE HAS TO BE RESCALED HERE, DOING IT IN THE ctrl7 LINE UPSETS THE WORKING OF THE changed OPCODE ABOVE
        FLsetVal        ktrig$NAME,     k$NAME, gih$NAME        ;UPDATE FLTK VALUATOR IF MIDI CONTROLLER HAS BEEN MOVED
        #
        ;           NAME    NUM MIN MAX
        $CONTROLLER(ndx'     1 ' 0 ' 1)
        $CONTROLLER(moddep'  2 ' 0 ' 1)
	
	iNumInst1		active		1	;SENSE THE NUMBER OF ACTIVE INSTANCES OF INSTR 1 (THIS INSTRUMENT)
	if	iNumInst1=1	then			;IF THE NUMBER OF ACTIVE INSTANCES OF INSTR 1 (THIS INSTRUMENT) IS EQUAL TO 1.
		event_i	"i", 2, 0, 3600			;TRIGGER A LONG NOTE IN INSTRUMENT 2
	endif						;END OF CONDITIONAL BRANCHING
endin
	
instr	2	;FOF INSTRUMENT
	;REINITILISATION CHECK=================================================================================================================================================	
	kSwitch			changed		gkvoice, gkLFOmode	;IF VARIABLES THAT NEED RE-INITIALIZATION ARE CHANGED kSwitch WILL BE A MOMENTARY '1', OTHERWISE IT IS ZERO
	if	kSwitch=1	then					;IF kSwitch=1 THEN
		reinit	UPDATE		;BEGIN A REINITIALIZATION PASS FROM LABEL 'UPDATE'
	endif				;END OF CONDITIONAL BRANCHING
	UPDATE:				;A LABEL
	;======================================================================================================================================================================	
	
	;NOTE ACTIVE STATUS CHECK==============================================================================================================================================
	if			gkOnOff=1	kgoto	CONTINUE	;SENSE FLTK ON/OFF SWITCH: IF 'ON' JUMP TO 'CONTINUE' LABEL
	gkNumInstr1 		active 		1			;DETERMINE THE NUMBER OF INSTANCES OF INSTR 1 (MIDI ACTIVATED) THAT ARE PLAYING
	if			gkNumInstr1!=0	kgoto	CONTINUE	;KEEP PLAYING UNLESS MIDI POLYPHONY IS ZERO
				turnoff					;TURNOFF THIS INSTRUMENT IMMEDIATELY
	CONTINUE:  
	;======================================================================================================================================================================		
	
	;AMPLITUDE ENVELOPE====================================================================================================================================================
	aenv			linsegr		.0001, .1, 1.5, .3, 1, .1, .0001
	;======================================================================================================================================================================
	
	;PORTAMENTO FUNCTION===================================================================================================================================================
	kporttime		linseg		0,.001,1,1,1		;PORTAMENTO FUNCTION
	kporttime1		=		kporttime * gkporttime1	;PORTAMENTO FUNCTION
	kporttime2		=		kporttime * gkporttime2	;PORTAMENTO FUNCTION
	
	iolaps 			= 		14850	;MAXIMUM NUMBER OF OVERLAPS (OVERESTIMATE)
	ifna 			= 		gisine	;WAVEFORM FOR GRAIN CONTENTS
	ifnb 			= 		giexp	;EXPONENTIAL SHAPE USED FOR GRAIN ENVELOPING
	itotdur 		= 		3600	;NOTE WILL LAST FOR 1 HOUR (OVERESTIMATE)
	;======================================================================================================================================================================
	
	;FUNDEMENTAL/FORMANT INPUT FORMAT======================================================================================================================================
	if	gkIPmode!=0	kgoto	SKIP1
		kndx			=	gkndx
		kfund			=	gkfund
	SKIP1:
		if	gkIPmode!=1	kgoto	SKIP2
		kndx			=		gkndx2
		kfund			=		gkfund2
	SKIP2:
		if	gkIPmode!=2	kgoto	SKIP3
		kndx			=	gkndx
		kfund			=		cpspch(gkOctave+(gkSemiStep*.01))
	SKIP3:
	;======================================================================================================================================================================
	
	;FUNDEMENTAL_RANDOM_OFFSET=============================================================================================================================================
	irandfundrange		=		i(gkrndfund)
	ifundrand		random		irandfundrange, -irandfundrange
	kFundRndi		randomi		gkFundRndA, -gkFundRndA, gkFundRndF
	kFundRndh		randomh		gkFundRndA, -gkFundRndA, gkFundRndF
	kFundRnd		ntrpol		kFundRndi, kFundRndh, gkFundRndType
	kfund			=		kfund*(1+ifundrand)*(1+kFundRnd)
	;======================================================================================================================================================================
	
	;VOWEL_MODULATION======================================================================================================================================================
	kvowelLFO		lfo		gkVlLFOAmp, gkVlLFOFrq, i(gkLFOmode)
	kvowelRndi		randomi		-gkVlRndAmp, gkVlRndAmp, gkVlRndFrq
	kvowelRndh		randomh		-gkVlRndAmp, gkVlRndAmp, gkVlRndFrq
	kvowelRnd		ntrpol		kvowelRndi, kvowelRndh, gkVlRndType
	kndx			=		kndx+kvowelLFO+kvowelRnd
	kndx			mirror		kndx, 0, 1				;REFLECT OUT OF RANGE VALUES
	;======================================================================================================================================================================
	
	;FOF_AMPLITUDE_BANDWIDTH_&_FORMANT_DERIVATION==========================================================================================================================
	;CREATE A MACRO FOR EACH FORMANT TO REDUCE CODE REPETITION
#define	FORMANT(N)
	#
	invals			=		4								;
	k$N.form 		tablei		kndx*invals, giBF1+(i(gkvoice)*15)+$N-1	;READ FORMANT FREQUENCY FROM TABLE
	k$N.db 			tablei		kndx*invals, giBDb1+(i(gkvoice)*15)+$N-1	;READ DECIBEL VALUE FROM TABLE
	k$N.amp			=		ampdb(k$N.db)					;CONVERT TO AN AMPLITUDE VALUE                                                
	k$N.band 		tablei		kndx*invals, giBBW1+(i(gkvoice)*15)+$N-1	;READ BANDWIDTH FROM TABLE
	#
	;EXECUTE MACRO MULTIPLE TIMES
	$FORMANT(1)                                                                                      
	$FORMANT(2)                                                                                      
	$FORMANT(3)                                                                                        
	$FORMANT(4)
	$FORMANT(5)
	;======================================================================================================================================================================
	
	rireturn			;RETURN TO PERFORMANCE TIME PASSES
	
	;PORTAMENTO PARAMETER SMOOTHING APPLIED TO FORMANT, BANDWIDTH AND FUNDEMENTAL PARAMETERS===============================================================================
	k1form			portk		k1form, kporttime2
	k2form			portk		k2form, kporttime2
	k3form			portk		k3form, kporttime2
	k4form			portk		k4form, kporttime2
	k5form			portk		k5form, kporttime2
	k1band			portk		k1band, kporttime2
	k2band			portk		k2band, kporttime2
	k3band			portk		k3band, kporttime2
	k4band			portk		k4band, kporttime2
	k5band			portk		k5band, kporttime2
	kfund			portk		kfund,  kporttime1
	;======================================================================================================================================================================
	
	;MODULATION============================================================================================================================================================
	kamprnd			randomi		0, gkamprand, gkamprandF
	kmoddep			=		gkmoddep + kamprnd
	kmoddep			limit		kmoddep, 0, 1
	kfrqrnd			randomi		0, gkfrqrand, gkfrqrandF
	kmodfrq			=		gkmodfrq+kfrqrnd
	kmoddep			limit		kmoddep, 0, 10
	kmodenv			linseg		0, i(gkmoddly)+.00001, 0, i(gkmodris), 1, 1, 1
	kvib			oscili		gkvibdep*kmodenv*gkmoddep, kmodfrq, gisine
	kvib			=		kvib+1
	kfund			=		kfund*kvib
	ktrm			oscil		gktrmdep*.5*kmodenv*kmoddep, gkmodfrq, gisine
	ktrm			=		ktrm+.5
	;======================================================================================================================================================================

	;FOF===================================================================================================================================================================
	a1 			fof 		k1amp, kfund, k1form, gkoct, k1band, gkris, gkdur, gkdec, iolaps, ifna, ifnb, itotdur
	a2 			fof 		k2amp, kfund, k2form, gkoct, k2band, gkris, gkdur, gkdec, iolaps, ifna, ifnb, itotdur
	a3 			fof 		k3amp, kfund, k3form, gkoct, k3band, gkris, gkdur, gkdec, iolaps, ifna, ifnb, itotdur
	a4 			fof 		k4amp, kfund, k4form, gkoct, k4band, gkris, gkdur, gkdec, iolaps, ifna, ifnb, itotdur
	a5 			fof 		k5amp, kfund, k5form, gkoct, k5band, gkris, gkdur, gkdec, iolaps, ifna, ifnb, itotdur
	;======================================================================================================================================================================

	;OUT===================================================================================================================================================================
	avoice			=		(a1+a2+a3+a4+a5) * ktrm * gkoutamp * aenv
	gasend			=		gasend + avoice 
	;======================================================================================================================================================================
endin

instr		3	;EQ
	if	gkEQOnOff=0	then							;IF EQ ON/OFF SWITCH IS OFF...
		turnoff									;TURN OFF THIS INSTRUMENT IMMEDIATELY
	endif										;END OF CONDITIONAL BRANCHING
	aEQ 			pareq 		gasend, gkcf, ampdb(gkgain), gkq	;APPLY PARAMETRIC EQ
	aEQ			buthp		aEQ, gkHPF				;APPLY HIGH PASS FILTER
	aEQ			butlp		aEQ, gkLPF				;APPLY LOW PASS FILTER
	gasend			=		aEQ*gkEQlev				;CREATE NEW gasend AUDIO VARIABLE
endin

instr		4	;DRY SIGNAL OUTPUT
				outs 		gasend*(1-gkrvbmix), gasend*(1-gkrvbmix)		;SEND AUDIO TO OUTPUTS
endin


instr		5	;CHORUS
	if	gkChoOnOff=0	then		;IF EQ ON/OFF SWITCH IS OFF...       
				turnoff 	;TURN OFF THIS INSTRUMENT IMMEDIATELY
	endif                           	;END OF CONDITIONAL BRANCHING        
	atim1 			jspline 	.005*gkChoDep, 4  *gkChoRate, 4.1*gkChoRate	;RANDOM SPLINE CURVE FOR DELAY TIME TO BE USED BY CHORUS
	atim2 			jspline 	.005*gkChoDep, 4.1*gkChoRate, 4.2*gkChoRate	;RANDOM SPLINE CURVE FOR DELAY TIME TO BE USED BY CHORUS
	atim3 			jspline 	.005*gkChoDep, 4.2*gkChoRate, 4.3*gkChoRate	;RANDOM SPLINE CURVE FOR DELAY TIME TO BE USED BY CHORUS
	;DELAY LINE============================================================================================================================================================
	aignore			delayr		.01
	atap1			deltap3		abs(atim1)+.001
	atap2			deltap3		abs(atim2)+.001
	atap3			deltap3		abs(atim3)+.001
				delayw		gasend
	;======================================================================================================================================================================
	outs 		atap1+(atap2*.7), atap3+(atap2*.7)		;SEND AUDIO TO OUTPUTS
endin


instr 		100	;REVERB
	if	gkRvbOnOff=0	then		;IF EQ ON/OFF SWITCH IS OFF...       
				turnoff         ;TURN OFF THIS INSTRUMENT IMMEDIATELY
	endif                                   ;END OF CONDITIONAL BRANCHING        
				denorm		gasend	;DENORMALIZE AUDIO SIGNAL
	arvbL, arvbR 		freeverb 	gasend, gasend, gkrvbtim, gkhfdiff, sr
				outs 		arvbL*gkrvbmix, arvbR*gkrvbmix		;SEND AUDIO TO OUTPUTS
endin

instr		102	;PING PONG DELAY
	if	gkDlyOnOff=0	then		;IF EQ ON/OFF SWITCH IS OFF...       
				turnoff         ;TURN OFF THIS INSTRUMENT IMMEDIATELY
	endif                                   ;END OF CONDITIONAL BRANCHING        
	
	iporttime		init		.2
	kporttime		linseg		0,.001,iporttime,1,iporttime
	
	kDlyTim			portk		gkDlyTim, kporttime
	kDlyMod			lfo		gkDlyModDep, gkDlyModFrq, 0
	kDlyTim			=		kDlyTim+kDlyMod
	kDlyTim			limit		kDlyTim, .001, 2
	aDlyTim			interp		kDlyTim
	
	imaxdelay		=		2		;MAXIMUM DELAY TIME
	
	;LEFT CHANNEL OFFSETTING DELAY (NO FEEDBACK!)
	aBuffer			delayr		imaxdelay*.5
	aLeftOffset		deltap3		aDlyTim*.5
				delayw		gasend*gkDlyMix
			
	;LEFT CHANNEL DELAY WITH FEEDBACK
	aFBsigL			init		0
	aBuffer			delayr		imaxdelay
	aDlySigL		deltap3		aDlyTim
				delayw		aLeftOffset + aFBsigL
	aFBsigL			=		aDlySigL * gkDlyFB
	
	;RIGHT CHANNEL DELAY WITH FEEDBACK
	aFBsigR			init		0
	aBuffer			delayr		imaxdelay
	aDlySigR		deltap3		aDlyTim
				delayw		(gasend*gkDlyMix) + aFBsigR
	aFBsigR			=		aDlySigR * gkDlyFB	
				outs 		aDlySigL+aLeftOffset, aDlySigR		;SEND AUDIO TO OUTPUTS
endin

instr	103	;RECORDING INSTRUMENT
	if gkrecord=1	then	;IF 'Record' switch is on...
	aL,aR	monitor
	;	OPCODE	FILENAME               | FORMAT | OUT1  | OUT2 etc...
		fout	"fofx5Output.wav",     8,      aL,     aR; AUDIO FILE OUTPUT FORMAT IS 24 BIT. CHANGE IF REQUIRED
	endif
endin

instr		300	;CLEAR GLOBAL VARIBLES
		clear	gasend
endin

</CsInstruments>

<CsScore>
i 4   0 3600	;DRY OUTPUT
i 300 0 3600	;RESETTING OF GLOBAL AUDIO VARIABLES
</CsScore>

</CsoundSynthesizer>

