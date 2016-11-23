; PadSynth.csd
; Written by Iain McCurdy, 2015

<CsoundSynthesizer>

<CsOptions>
-odac -dm0 -+rtmidi=virtual -M0
;-odac -dm0 -odac -M8
</CsOptions>

<CsInstruments>
sr	=	44100
ksmps	=	32
nchnls	=	2
0dbfs	=	1

massign	0,1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL       | WIDTH | HEIGHT | X | Y
		FLpanel	"Pad Synth",   500,    725,    0,  0

;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
gidBase				FLvalue	"",     50,     18,     5,  21
idBW				FLvalue	"",     50,     18,     5,  71
idPartScal			FLvalue	"",     50,     18,     5, 121
idHarmStr			FLvalue	"",     50,     18,     5, 171

;SLIDERS					            		MIN | MAX  | EXP | TYPE | DISP     | WIDTH | HEIGHT | X | Y
gkBase, gihBase			FLslider 	"Base Freq. (Hertz)",	20,   10000, -1,    23,  gidBase,      490,     20,    5,  1
gkBW, ihBW			FLslider 	"Bandwidth",		1,    10000, -1,    23,  idBW,        490,     20,    5, 51
gkPartScal, ihPartScal		FLslider 	"Partial Scaling",	1,       30, -1,    23,  idPartScal,  490,     20,    5,101
gkHarmStr, ihHarmStr		FLslider 	"Harmonic Stretch",	0.1,      8, -1,    23,  idHarmStr,   490,     20,    5,151

;BORDERS					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Table:", 	1,      1,     14,    50,      14,   150,200
;COUNTERS						MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X   | Y | OPCODE
gkTabSize, ihTabSize 		FLcount  "Table Size", 	1,    24,    1,      1,      2,     80,     22,     5,   195,   -1
gkTable,gihTable 		FLcount  "User", 	1,     9,    1,      1,      2,    100,     22,   200,   195,   -1
FLsetVal_i	1,gihTable



;BORDERS						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
gih0		 	FLbox  	"[------------------------------------------------ H a r m o n i c s ------------------------------------------------]", 	1,      1,     12,   490,      11,    4, 240
gihInfo		 	FLbox  	"", 			1,       5,    12,   250,      20,    6, 720
FLsetAlign 6, gihInfo

;SLIDERS					        MIN  | MAX  | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gk1 , gih1 			FLslider 	"1",	0,      1,     0,    24,    -1,    15,     80,     10, 253
gk2 , gih2 			FLslider 	"2",	0,      1,     0,    24,    -1,    15,     80,     30, 253
gk3 , gih3 			FLslider 	"3",	0,      1,     0,    24,    -1,    15,     80,     50, 253
gk4 , gih4 			FLslider 	"4",	0,      1,     0,    24,    -1,    15,     80,     70, 253
gk5 , gih5 			FLslider 	"5",	0,      1,     0,    24,    -1,    15,     80,     90, 253
gk6 , gih6 			FLslider 	"6",	0,      1,     0,    24,    -1,    15,     80,    110, 253
gk7 , gih7 			FLslider 	"7",	0,      1,     0,    24,    -1,    15,     80,    130, 253
gk8 , gih8 			FLslider 	"8",	0,      1,     0,    24,    -1,    15,     80,    150, 253
gk9 , gih9 			FLslider 	"9",	0,      1,     0,    24,    -1,    15,     80,    170, 253
gk10, gih10			FLslider 	"10",	0,      1,     0,    24,    -1,    15,     80,    190, 253
gk11, gih11			FLslider 	"11",	0,      1,     0,    24,    -1,    15,     80,    210, 253
gk12, gih12			FLslider 	"12",	0,      1,     0,    24,    -1,    15,     80,    230, 253
gk13, gih13			FLslider 	"13",	0,      1,     0,    24,    -1,    15,     80,    250, 253
gk14, gih14			FLslider 	"14",	0,      1,     0,    24,    -1,    15,     80,    270, 253
gk15, gih15			FLslider 	"15",	0,      1,     0,    24,    -1,    15,     80,    290, 253
gk16, gih16			FLslider 	"16",	0,      1,     0,    24,    -1,    15,     80,    310, 253
gk17, gih17			FLslider 	"17",	0,      1,     0,    24,    -1,    15,     80,    330, 253
gk18, gih18			FLslider 	"18",	0,      1,     0,    24,    -1,    15,     80,    350, 253
gk19, gih19			FLslider 	"19",	0,      1,     0,    24,    -1,    15,     80,    370, 253
gk20, gih20			FLslider 	"20",	0,      1,     0,    24,    -1,    15,     80,    390, 253
gk21, gih21			FLslider 	"21",	0,      1,     0,    24,    -1,    15,     80,    410, 253
gk22, gih22			FLslider 	"22",	0,      1,     0,    24,    -1,    15,     80,    430, 253
gk23, gih23			FLslider 	"23",	0,      1,     0,    24,    -1,    15,     80,    450, 253
gk24, gih24			FLslider 	"24",	0,      1,     0,    24,    -1,    15,     80,    470, 253

;===AMPLITUDE===
;BORDERS						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 			6,      9,     15,    490,    115,    5, 350
ih		 	FLbox  	"Amplitude Envelope", 	1,      1,     14,    480,     15,   10, 355

;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
idAAtt				FLvalue	"",     50,     18,    115-40, 440
idADec				FLvalue	"",     50,     18,    185-40, 440
idASus				FLvalue	"",     50,     18,    255-40, 440
idARel				FLvalue	"",     50,     18,    325-40, 440
idAGain				FLvalue	"",     50,     18,    425-40, 440

; KNOBS				FLknob 			   MIN  | MAX | EXP | TYPE | DISP | WIDTH | X | Y
gkAAtt, ihAAtt 			FLknob 		"Attack",  0.001,  5,   -1,    1,   idAAtt,  50,   115-40,375
gkADec, ihADec 			FLknob 		"Decay",   0.001,  5,   -1,    1,   idADec,  50,   185-40,375
gkASus, ihASus 			FLknob 		"Sustain", 0,      1,    0,    1,   idASus,  50,   255-40,375
gkARel, ihARel 			FLknob 		"Release", 0.001,  5,   -1,    1,   idARel,  50,   325-40,375
gkAGain, ihAGain 		FLknob 		"Gain",    0.1,    5,   -1,    1,   idAGain, 50,   425-40,375


;===FILTER===
;BORDERS						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 			6,      9,     15,    490,    115,    5, 470
ih		 	FLbox  	"Filter", 		1,      1,     14,    480,     15,   10, 475

;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkFOnOff,ihFOnOff	FLbutton	"On/Off",		1,    0,     2,    80,     25,    20, 495,   -1
FLsetColor2	255,255,100,ihFOnOff

;VALUE_DISPLAY_BOXES		WIDTH | HEIGHT | X | Y
idFL1		FLvalue	"",     50,     18,    120, 560
idFT1		FLvalue	"",     50,     18,    180, 560
idFSus		FLvalue	"",     50,     18,    240, 560
idFRelTim	FLvalue	"",     50,     18,    300, 560
idFRelLev	FLvalue	"",     50,     18,    360, 560


; KNOBS				FLknob 			   MIN  | MAX | EXP | TYPE | DISP   | WIDTH | X | Y
gkFL1,     ihFL1 		FLknob 		"Level 1", 0.01,  10,   -1,    1,   idFL1,     50,   120,495
gkFT1,     ihFT1 		FLknob 		"Time 1",  0.001,  8,   -1,    1,   idFT1,     50,   180,495
gkFSus,    ihFSus 		FLknob 		"Sustain", 0.01,  10,    0,    1,   idFSus,    50,   240,495
gkFRelTim, ihFRelTim 		FLknob 		"Rel.Time",0.001,  5,   -1,    1,   idFRelTim, 50,   300,495
gkFRelLev, ihFRelLev 		FLknob 		"Rel.Lev", 0.001, 10,   -1,    1,   idFRelLev, 50,   360,495

;COUNTERS						MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X   | Y | OPCODE
gkFPos, ihFPos 			FLcount  "Pos.", 	1,    24,    1,      1,      2,     80,     22,    20,   540,   -1


;===REVERB===
;BORDERS						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 			6,      9,     15,    490,    115,    5, 590
ih		 	FLbox  	"Reverb", 		1,      1,     14,    480,     15,   10, 595

;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
idRSend				FLvalue	"",     50,     18,    115+40, 680
idRSize				FLvalue	"",     50,     18,    185+40, 680
idR__CF				FLvalue	"",     50,     18,    255+40, 680

; KNOBS				FLknob 			   MIN  | MAX | EXP | TYPE | DISP | WIDTH | X | Y
gkRSend, ihRSend 		FLknob 		"Mix",    0,       1,     0,    1,  idRSend,  50,   115+40,615
gkRSize, ihRSize 		FLknob 		"Size",   0,     0.99,    0,    1,  idRSize,  50,   185+40,615
gkR__CF, ihR__CF 		FLknob 		"Damping",20,    20000,  -1,    1,  idR__CF,  50,   255+40,615

;SET_INITIAL_VALUES		VALUE 	       | HANDLE
		FLsetVal_i	cpsmidinn(60),  gihBase
		FLsetVal_i	10, 		ihBW
		FLsetVal_i	2.4, 		ihPartScal
		FLsetVal_i	1, 		ihHarmStr
		FLsetVal_i	0.5, 		ihAAtt
		FLsetVal_i	0.01, 		ihADec
		FLsetVal_i	1, 		ihASus
		FLsetVal_i	0.5, 		ihARel
		FLsetVal_i	1, 		ihAGain

		FLsetVal_i	1, 		ihFOnOff
		FLsetVal_i	10, 		ihFL1 		
		FLsetVal_i	3, 		ihFT1 		
		FLsetVal_i	1, 		ihFSus 		
		FLsetVal_i	0.5, 		ihFRelTim 	
		FLsetVal_i	5, 		ihFRelLev 	
		FLsetVal_i	3, 		ihFPos 		

		FLsetVal_i	0.5, 		ihRSend
		FLsetVal_i	0.85, 		ihRSize
		FLsetVal_i	8000, 		ihR__CF
		FLsetVal_i	1-0, 		gih1
		FLsetVal_i	1-0.1, 		gih2 
		FLsetVal_i	1-0.2, 		gih3 
		FLsetVal_i	1-0.1, 		gih4 
		FLsetVal_i	1-0, 		gih5 
		FLsetVal_i	1-0, 		gih6 
		FLsetVal_i	1-0, 		gih7 
		FLsetVal_i	1-0, 		gih8 
		FLsetVal_i	1-0, 		gih9 
		FLsetVal_i	1-0, 		gih10
		FLsetVal_i	1-0.1, 		gih11
		FLsetVal_i	1-0.2, 		gih12
		FLsetVal_i	1-0.4, 		gih13
		FLsetVal_i	1-0.5, 		gih14
		FLsetVal_i	1-0.7, 		gih15
		FLsetVal_i	1-0.9, 		gih16
		FLsetVal_i	1-0.5, 		gih17
		FLsetVal_i	1-0.2, 		gih18
		FLsetVal_i	1-0.001, 	gih19
		FLsetVal_i	1-0, 		gih20
		FLsetVal_i	1-0, 		gih21
		FLsetVal_i	1-0, 		gih22
		FLsetVal_i	1-0, 		gih23
		FLsetVal_i	1-0, 		gih24

		FLsetVal_i	18, 		ihTabSize


		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 700, 512, 0
				FLscroll     515, 700,  0, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                         Pad Synth                           ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"'padsynth' is actually a GEN routine that generates a        ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"loopable function table exhibiting a dense texture that, when", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"replayed using an oscillator, resembles what is referred to  ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"as a 'pad'.                                                  ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"The sliders in the GUI control the input arguments of the GEN", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"routine, the knobs control additional elements added to this ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"example. For this reason, changing the parameters controlled ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"by the sliders will force the table to be rebuilt, then      ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"resulting in interruptions in the output. In performance it  ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"will be better to think of 'padsynth' as creating a fixed    ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"complex spectrum which is then processed using techniques of ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"subtractive synthesis.                                       ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"'Bandwidth' effectively controls modulation of the partial   ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"frequencies (mainly amplitude modulation but also some       ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"frequency modulation): increasing this increases the amount  ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"a noise component that will be preset in all partials.       ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"'Fundemental' is the fundemental of the tone. Too high a     ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"value here will result in quantisation artefacts.            ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"'Harmonic Stretch' scales all partial frequencies.           ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"'Partial Scaling' scales the modulations from partial to     ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"partial, raising this beyond 1 will result in increasing     ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"excursive modulations in higher partials - this effect can   ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"be likened to adding 'air' into the pad texture whilst       ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"retaining clarity in the lower partials. Experimentation with", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"this parameter should help in gaining an understanding of its", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"effect.                                                      ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"The amplitudes of the harmonic partials are set using the    ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"mini vertical sliders.                                       ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"Reducing the table size will reduce the load time and the    ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"time it takes to recalculate the table whenever a change is  ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"made to 'padsynth's parameters, but if the table becomes too ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"small, looping will become obvious.                          ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"The filter envelope added to this example modulates a        ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"bandpass filter's bandwidth as opposed to its cutoff         ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"frequency. The cutoff frequency is defined using the 'Pos'   ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"counter and defines a ratio above the base frequency.        ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"Therefore a value of '3' here will emphasise the 3rd partial ", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"of any note when bandwidth is narrowed.                      ", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"A variety of additional 'preset' tables are also offered. If ", 	1,      5,     14,    490,    20,     5, 820
ih		 	FLbox  	"any of these are chosen the partial sliders are not          ", 	1,      5,     14,    490,    20,     5, 840
ih		 	FLbox  	"available. Base frequency will also become unavalable as this", 	1,      5,     14,    490,    20,     5, 860
ih		 	FLbox  	"will be set automatically to the correct value. Note that    ", 	1,      5,     14,    490,    20,     5, 880
ih		 	FLbox  	"these a single tables that are scaled scaled up or down the  ", 	1,      5,     14,    490,    20,     5, 900
ih		 	FLbox  	"entire keyboard from their point of unison therefore they    ", 	1,      5,     14,    490,    20,     5, 920
ih		 	FLbox  	"will sound less like their sources, the further away from    ", 	1,      5,     14,    490,    20,     5, 940
ih		 	FLbox  	"their points of unison they are played.                      ", 	1,      5,     14,    490,    20,     5, 960
				FLscroll_end
				FLpanel_end
				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gaRvbL,gaRvbR	init	0


instr	2	; Always on. Updates PadSynth table when relevant widgets are changed.

 ktrig	changed	gkBase,gkBW,gkPartScal,gkHarmStr,gkTabSize,gkTable,gk1,gk2,gk3,gk4,gk5,gk6,gk7,gk8,gk9,gk10,gk11,gk12,gk13,gk14,gk15,gk16,gk17,gk18,gk19,gk20,gk21,gk22,gk23,gk24
 if ktrig==1 then
  reinit	UpdateTable
 endif
 UpdateTable:
 FLsetText	"Calculating tables. Please wait...",gihInfo

 if i(gkTable)==1 then
  FLshow	gihBase
  FLshow	gidBase
  FLshow	gih0
  FLshow	gih1
  FLshow	gih2
  FLshow	gih3
  FLshow	gih4
  FLshow	gih5
  FLshow	gih6
  FLshow	gih7
  FLshow	gih8
  FLshow	gih9
  FLshow	gih10
  FLshow	gih11
  FLshow	gih12
  FLshow	gih13
  FLshow	gih14
  FLshow	gih15
  FLshow	gih16
  FLshow	gih17
  FLshow	gih18
  FLshow	gih19
  FLshow	gih20
  FLshow	gih21
  FLshow	gih22
  FLshow	gih23
  FLshow	gih24
 else
  FLhide	gihBase
  FLhide	gidBase
  FLhide	gih0
  FLhide	gih1
  FLhide	gih2
  FLhide	gih3
  FLhide	gih4
  FLhide	gih5
  FLhide	gih6
  FLhide	gih7
  FLhide	gih8
  FLhide	gih9
  FLhide	gih10
  FLhide	gih11
  FLhide	gih12
  FLhide	gih13
  FLhide	gih14
  FLhide	gih15
  FLhide	gih16
  FLhide	gih17
  FLhide	gih18
  FLhide	gih19
  FLhide	gih20
  FLhide	gih21
  FLhide	gih22
  FLhide	gih23
  FLhide	gih24
 endif
 
 giBW		=	i(gkBW)
 giPartScal	=	i(gkPartScal)
 giTabLen	=	2^i(gkTabSize)	; IF THIS IS TOO SMALL, LOOPING OF THE SPECTRUM WILL BECOME AUDIBLE
 ;                                                                                        FIRST TWO VALUES FOR hampl NEED TO BE '1'.
 if i(gkTable)==1 then
  FLsetText	"                       ", gihTable
  FLsetText	"User", gihTable
  giBase		=	i(gkBase)
  giTable 	ftgen 1, 0, giTabLen, "padsynth", giBase, giBW, giPartScal, i(gkHarmStr), 1, 1, 1.00001-(i(gk1)*0.99999),1-i(gk2),1-i(gk3),1-i(gk4),1-i(gk5),1-i(gk6),1-i(gk7),1-i(gk8),1-i(gk9),1-i(gk10),1-i(gk11),1-i(gk12),1-i(gk13),1-i(gk14),1-i(gk15),1-i(gk16),1-i(gk17),1-i(gk18),1-i(gk19),1-i(gk20),1-i(gk21),1-i(gk22),1-i(gk23),1-i(gk24)
 elseif i(gkTable)==2 then	; double bass
  FLsetText	"                       ", gihTable
  FLsetText	"D.Bass", gihTable
  giBase		=	cpsmidinn(24)
  giTable 	ftgen 1, 0, giTabLen, "padsynth", giBase, giBW, giPartScal, i(gkHarmStr), 1, 1, 0.050982,0.269147,1.000005,0.658602,0.409921,0.234611,0.371689,0.081631,0.193677,0.176088,0.325643,0.073972,0.139508,0.089290,0.133734,0.084015,0.019990,0.027201,0.017902,0.041521,0.007125,0.015291,0.015586,0.060973,0.014650,0.002686,0.018208,0.022200,0.005778,0.016678,0.011366,0.005039,0.010690,0.004182,0.004080,0.022196,0.001317,0.015622,0.006383,0.048913,0.043438,0.028458,0.019492,0.004084,0.022969,0.008893,0.009430,0.005096,0.011939,0.003356,0.002472,0.010081,0.003020,0.007064,0.020432,0.002298,0.004490,0.004640,0.005406,0.000578,0.002732,0.004642,0.003090,0.002380,0.003776,0.003052,0.002165,0.001143,0.004033,0.002833,0.000987,0.002324,0.003665,0.000774,0.003714,0.003576,0.003869,0.000651,0.001704,0.000521,0.002186,0.000385,0.001712,0.000832,0.000895,0.001616,0.000491,0.000556,0.000794,0.000267,0.000365,0.000915,0.000410,0.000555,0.000234,0.000876,0.001052,0.001316,0.000456
 elseif i(gkTable)==3 then	; clarinet
  FLsetText	"                       ", gihTable
  FLsetText	"Clarinet", gihTable
  giBase		=	cpsmidinn(50)
  giTable 	ftgen 1, 0, giTabLen, "padsynth", giBase, giBW, giPartScal, i(gkHarmStr), 1, 1, 0.273597,0.027434,0.737705,0.049480,0.448437,0.272536,0.131175,0.129945,0.283082,0.130714,0.026719,0.037582,0.018953,0.010729,0.067580,0.024573,0.016586,0.049988,0.033294,0.017090,0.008591,0.021128,0.007237,0.016060,0.016060
 elseif i(gkTable)==4 then	; bass clarinet
  FLsetText	"                       ", gihTable
  FLsetText	"Bass Clarinet", gihTable
  giBase		=	cpsmidinn(35)
  giTable 	ftgen 1, 0, giTabLen, "padsynth", giBase, giBW, giPartScal, i(gkHarmStr), 1, 1, 0.384232,0.038085,0.578537,0.029558,0.143002,0.119033,0.397678,0.113380,0.577246,0.158831,0.577514,0.094994,0.440674,0.109136,0.500666,0.132354,0.360370,0.104810,0.231403,0.089565,0.207353,0.099773,0.209066,0.123801,0.158769,0.079383,0.036078,0.019583,0.010310,0.017060,0.029465,0.045821,0.031622,0.038326,0.052222,0.058647,0.083956,0.079748,0.081955,0.097274,0.069934,0.075100,0.049259,0.058121,0.068078,0.065276,0.070165,0.065898,0.072432,0.055423,0.052283,0.036547,0.034082,0.035287,0.044801,0.053917,0.050263,0.036979,0.034264,0.035892,0.035011,0.037199,0.041542,0.043201,0.039923,0.035164,0.035828,0.036193,0.037155,0.035493,0.034546,0.035091,0.029891,0.027394,0.026174,0.023757,0.021365,0.019468,0.016295,0.015301,0.015263,0.014310,0.013239,0.011972,0.011445,0.011727,0.012391,0.013892,0.015395,0.015147,0.015137,0.014816,0.013898,0.012682,0.011462,0.009883,0.008579,0.007797,0.007749
 elseif i(gkTable)==5 then	; contrabass clarinet
  FLsetText	"                       ", gihTable
  FLsetText	"CB.Clarinet", gihTable
  giBase		=	cpsmidinn(26)
  giTable 	ftgen 1, 0, giTabLen, "padsynth", giBase, giBW, giPartScal, i(gkHarmStr), 1, 1, 0.100160,0.005519,0.631940,0.013046,0.749042,0.308868,0.475605,0.152792,0.074315,0.238927,0.152260,0.251283,0.030787,0.052465,0.032473,0.121972,0.064172,0.090564,0.043994,0.091868,0.039563,0.058622,0.024531,0.023127,0.026665,0.067522,0.081377,0.057914,0.066176,0.036134,0.026135,0.021056,0.038011,0.036534,0.058393,0.040915,0.050051,0.038446,0.034166,0.021341,0.014481,0.015708,0.025527,0.026622,0.033577,0.027355,0.034434,0.022920,0.016354,0.010905,0.011160,0.015075,0.019871,0.017505,0.013189,0.011442,0.008511,0.007974,0.006368,0.005988,0.005976,0.005922,0.006590,0.008199,0.006566,0.005254,0.004955,0.005576,0.005463,0.005101,0.003955,0.003622,0.004027,0.003772,0.003504,0.002848,0.002183,0.002075,0.002143,0.002014,0.001907,0.001850,0.001736,0.001543,0.001318,0.001180,0.001107,0.001066,0.001169,0.001372,0.001533,0.001667,0.001738,0.001655,0.001604,0.001603,0.001571,0.001575,0.001638,0.001696
 elseif i(gkTable)==6 then	; oboe
  FLsetText	"                       ", gihTable
  FLsetText	"Oboe", gihTable
  giBase		=	cpsmidinn(59)
  giTable 	ftgen 1, 0, giTabLen, "padsynth", giBase, giBW, giPartScal, i(gkHarmStr), 1, 1, 0.239013,0.078927,0.241030,0.206347,0.832266,0.054540,0.013821,0.007450,0.022905,0.021737,0.018123,0.013105,0.002361,0.001433,0.003509,0.002589,0.001326,0.000743,0.000990,0.000868,0.000863,0.000994,0.000406,0.000288,0.000288
 elseif i(gkTable)==7 then	; bassoon
  FLsetText	"                       ", gihTable
  FLsetText	"Bassoon", gihTable
  giBase		=	cpsmidinn(34)
  giTable 	ftgen 1, 0, giTabLen, "padsynth", giBase, giBW, giPartScal, i(gkHarmStr), 1, 1, 0.213868,0.268493,0.244166,0.230801,0.105833,0.308087,0.556920,0.478956,0.523357,0.900665,0.213470,0.229596,0.031221,0.040117,0.067113,0.060158,0.030778,0.061028,0.143814,0.063668,0.126426,0.055009,0.049138,0.085854,0.113027,0.111464,0.088765,0.037342,0.050990,0.035579,0.040460,0.032219,0.027305,0.034141,0.019655,0.009315,0.008270,0.006748,0.006472,0.007088,0.008133,0.007046,0.007850,0.005791,0.006273,0.006847,0.007249,0.009398,0.010309,0.010418,0.010247,0.010333,0.009562,0.008180,0.009576,0.009469,0.008529,0.008844,0.008053,0.007565,0.008026,0.007284,0.007299,0.007423,0.008280,0.008374,0.008239,0.008512,0.009431,0.010246,0.010350,0.009381,0.008652,0.008150,0.007888,0.007951,0.008166,0.008210,0.007921,0.007548,0.007147,0.006991,0.006978,0.006527,0.005617,0.004781,0.004549,0.004707,0.004803,0.004640,0.004303,0.003866,0.003524,0.003348,0.003108,0.002766,0.002439,0.002278,0.002406,0.002733
 elseif i(gkTable)==8 then	; contrabassoon
  FLsetText	"                       ", gihTable
  FLsetText	"C.Bassoon", gihTable
  giBase		=	cpsmidinn(38)
  giTable 	ftgen 1, 0, giTabLen, "padsynth", giBase, giBW, giPartScal, i(gkHarmStr), 1, 1, 0.240531,0.304670,0.289169,0.727482,0.578083,0.169149,0.057305,0.193624,0.167977,0.206006,0.182632,0.057408,0.103574,0.044785,0.084239,0.068303,0.030771,0.133375,0.096231,0.037016,0.046566,0.020770,0.020264,0.015211,0.029647,0.018603,0.027940,0.062861,0.033828,0.015594,0.016305,0.025478,0.034356,0.038642,0.028451,0.026747,0.014914,0.016727,0.015524,0.013236,0.014264,0.013651,0.014838,0.016490,0.021208,0.017660,0.013009,0.014867,0.013013,0.010426,0.009144,0.009462,0.009367,0.009624,0.008079,0.007399,0.009012,0.009384,0.008661,0.009051,0.009394,0.010578,0.011610,0.012184,0.010442,0.009130,0.008795,0.008468,0.010039,0.011205,0.011438,0.011489,0.010526,0.008902,0.007391,0.006198,0.005970,0.005264,0.004331,0.003874,0.003514,0.003418,0.003518,0.003409,0.003150,0.003023,0.003047,0.003199,0.003624,0.003999,0.003839,0.003629,0.003712,0.003872,0.003974,0.003836,0.003596,0.003353,0.003177,0.003070
 elseif i(gkTable)==9 then	; contrabassoon
  FLsetText	"                       ", gihTable
  FLsetText	"Bass Ahh", gihTable
  giBase		=	cpsmidinn(48)
  giTable 	ftgen 1, 0, giTabLen, "padsynth", giBase, giBW, giPartScal, i(gkHarmStr), 1, 1, 0.001482,0.007584,0.024916,0.084669,0.120825,0.037691,0.032860,0.097651,0.021318,0.007128,0.001455,0.000373,0.000311,0.001646,0.006016,0.016943,0.049158,0.018410,0.045129,0.018996,0.013181,0.005616,0.002740,0.001081,0.000371,0.000296,0.000174,0.000109
 endif

 FLsetText	"Ready!                             ",gihInfo
endin

instr	1	; SOUNDING INSTRUMENT. TRIGGERED BY MIDI NOTES.
 ifreq	cpsmidi
 ivel	ampmidi	0.4
 
; aAmpEnv	cossegr		0, i(gkAAtt),1, i(gkADec), i(gkASus), 36000, i(gkASus),i(gkARel), 0	; SUSTAIN SEGMENT (36000) NECESSARY DUE TO cosseg BUG
 aAmpEnv	linsegr		0, i(gkAAtt),1, i(gkADec), i(gkASus),                  i(gkARel), 0	
 
 aL	poscil	ivel*aAmpEnv*gkAGain, (ifreq*sr)/(giTabLen*giBase), giTable
 aR	poscil	ivel*aAmpEnv*gkAGain, (ifreq*sr)/(giTabLen*giBase), giTable, 0.5	; OFFSET RIGHT CHANNEL PHASE 

 if i(gkFOnOff)==1 then									; IF FILTER SWITCH IS 'ON'
  kBW		expsegr	i(gkFL1), i(gkFT1), i(gkFSus), i(gkFRelTim), i(gkFRelLev)	; BANDWIDTH ENVELOPE
  kPortTime	linseg	0,0.001,0.1							; RAMPING UP FUNCTION
  kCF		portk	ifreq * gkFPos, kPortTime					; SMOOTH CHANGES TO CUTOFF POSITION COUNTER
  aL		reson	aL, kCF, kCF*kBW, 1						; BANDPASS FILTER
  aR		reson	aR, kCF, kCF*kBW, 1
 endif
 	outs	aL,aR

 gaRvbL	+=	aL*gkRSend
 gaRvbR	+=	aR*gkRSend
 
endin


instr	99	; Reverb. Always on.
 aL,aR	reverbsc	gaRvbL,gaRvbR,gkRSize,gkR__CF
 	outs		aL,aR
 	clear		gaRvbL,gaRvbR
endin

instr	100
 asig poscil	0.5,500
 	outs	asig,asig
endin

</CsInstruments>

<CsScore>
i 2  0 [3600*24*7]	; Reinitialises the "padsynth" GEN routine when changes made to widgets pertaining to its creation are made.
i 99 0 [3600*24*7]	; Reverb
</CsScore>

</CsoundSynthesizer>