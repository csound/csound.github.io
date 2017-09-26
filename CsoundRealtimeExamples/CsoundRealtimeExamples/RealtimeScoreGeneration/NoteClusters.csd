NoteClusters.csd
Written by Iain McCurdy, 2008

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 	= 	44100  
ksmps 	= 	8
nchnls 	= 	2
0dbfs	=	1
	seed 	0	;RANDOM NUMBER GENERATORS SEEDED FROM SYSTEM CLOCK

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 100, 100, 200	;SET INTERFACE COLOURS
;			LABEL            | WIDTH | HEIGHT | X | Y
	FLpanel	"NOTE CLUSTER GENERATOR",   500,    460,    0,  0

;                                                      ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"On/Off",		1,   0,    22,    140,     30,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES					WIDTH | HEIGHT | X |  Y
idClusterFrq			FLvalue	" ",     	60,       20,    5,   80
idOctMin			FLvalue	" ",     	60,       20,    5,  190
idOctMax			FLvalue	" ",     	60,       20,  435,  190
idSpread			FLvalue	" ",     	60,       20,    5,  240
idDurMin			FLvalue	" ",     	60,       20,    5,  290
idDurMax			FLvalue	" ",     	60,       20,  435,  290
idGainMin			FLvalue	" ",     	60,       20,    5,  390
idGainMax			FLvalue	" ",     	60,       20,  435,  390

;					            					MIN  | MAX | EXP | TYPE |   DISP      | WIDTH | HEIGHT | X | Y
gkClusterFrq, ihClusterFrq		FLslider 	"Cluster Frequency",		.1,    10,    0,     3,  idClusterFrq,   490,    25,     5,  50
gkOctMin, ihOctMin			FLslider 	"",				4,     14,    0,     3,  idOctMin,       490,    12,     5, 160
gkOctMax, ihOctMax			FLslider 	"Pitch Range (oct)",		4,     14,    0,     3,  idOctMax,       490,    12,     5, 172
gkSpread, ihSpread			FLslider 	"Event Spread",			0,     10,    0,     3,  idSpread,       490,    25,     5, 210
gkDurMin, ihDurMin			FLslider 	"",				0.01,  10,    0,     3,  idDurMin,       490,    12,     5, 260
gkDurMax, ihDurMax			FLslider 	"Duration Range",		0.01,  10,    0,     3,  idDurMax,       490,    12,     5, 272
gkPanSprd, ihPanSprd			FLslider 	"Panning Spread",		0,    0.5,    0,     3,  -1,             490,    25,     5, 310
gkGainMin, ihGainMin			FLslider 	"",				0,      1,    0,     3,  idGainMin,      490,    12,     5, 360
gkGainMax, ihGainMax			FLslider 	"Gain Range",			0,      1,    0,     3,  idGainMax,      490,    12,     5, 372
gkAttTim, ihAttTim			FLslider 	"Attack Time",			0,    0.5,    0,     3,  -1,             490,    25,     5, 410

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE
gkEvents, ihEvents 			FLcount  "Number of Events", 	1,    100,     1,      1,      2,   100,     25,   200, 100,   -1

			FLsetVal_i	0.5, 	ihClusterFrq
			FLsetVal_i	9, 	ihOctMin
			FLsetVal_i	12, 	ihOctMax
			FLsetVal_i	0.5, 	ihSpread
			FLsetVal_i	1, 	ihDurMin
			FLsetVal_i	3, 	ihDurMax
			FLsetVal_i	0.5, 	ihPanSprd
			FLsetVal_i	0, 	ihGainMin
			FLsetVal_i	1, 	ihGainMax
			FLsetVal_i	0, 	ihAttTim
			FLsetVal_i	3, 	ihEvents

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 300, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                    NOTE CLUSTER GENERATOR                   ", 	1,      5,     14,    490,     20,    5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,     20,    5,  20
ih		 	FLbox  	"This example demonstrates how to execute a chunk of code     ", 	1,      5,     14,    490,     20,    5,  40
ih		 	FLbox  	"using a looping chunk of code. This is implemented with the  ", 	1,      5,     14,    490,     20,    5,  60
ih		 	FLbox  	"assistance of one of Csound's opcodes for this purpose       ", 	1,      5,     14,    490,     20,    5,  80
ih		 	FLbox  	"'loop_lt'.                                                   ", 	1,      5,     14,    490,     20,    5, 100
ih		 	FLbox  	"Here the technique is used to generate aleatoric clusters of ", 	1,      5,     14,    490,     20,    5, 120
ih	  	 	FLbox  	"notes. Clusters are triggered automatically at a frequency   ", 	1,      5,     14,    490,     20,    5, 140
ih		 	FLbox  	"defined using the 'Cluster Frequency' slider but the exact   ", 	1,      5,     14,    490,     20,    5, 160
ih		 	FLbox  	"number of notes in each cluster is defined using an on-screen", 	1,      5,     14,    490,     20,    5, 180
ih		 	FLbox  	"counter 'Number of Events'.                                  ", 	1,      5,     14,    490,     20,    5, 200
ih		 	FLbox  	"Various other parameters involved in the algorithmic         ", 	1,      5,     14,    490,     20,    5, 220
ih		 	FLbox  	"generation of these notes such as note duration, pitch, the  ", 	1,      5,     14,    490,     20,    5, 240
ih		 	FLbox  	"spread of note onsets within a cluster, gain, panning and    ", 	1,      5,     14,    490,     20,    5, 260
ih		 	FLbox  	"attack time are user controllable.                           ", 	1,      5,     14,    490,     20,    5, 280

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine		ftgen		0,0,65536,10,1	;A SINE WAVE

instr	1	;TRIGGER CLUSTER GENERATOR
	if	gkOnOff=0	then		;IF FLTK ON/OFF BUTTON IS OFF...
		turnoff				;TURNOFF THIS INSTRUMENT IMMEDIATELY
	endif					;END OF CONDITIONAL BRANCHING
	kTrigger	metro     gkClusterFrq
	schedkwhen	kTrigger, 0, 0, 2, 0, 0.001	;TRIGGER INSTR 2 FOR A VERY SHORT TIME
endin

instr	2	;TRIGGER EVENTS WITHIN A CLUSTER 
	kndx	init	0				;COUNTER INITIAL VALUE
	loop:						;POINT OF CODE TO LEAP BACK TO
	kamp	random	gkGainMin,gkGainMax		;AMPLITUDE
	kstart	init	0				;INITIAL START TIME
	koct	random	gkOctMin, gkOctMax		;PITCH RANDOM RANGE
	kpan	random	0.5-gkPanSprd,0.5+gkPanSprd	;PANNING RANDOM RANGE
	kdur	random	gkDurMin,gkDurMax		;DURATION RANDOM RANGE
	;                                      p4    p5    p6
		event	"i", 3, kstart, kdur, kamp, koct, kpan	;TRIGGER NOTE EVENT IN INSTR 2
	kstart	random	0,gkSpread			;RANDOM START TIME - RANGE DEFINED BY FLTK 'Spread' SLIDER VALUE
	loop_lt	kndx,1,gkEvents,loop			;LOOP BACK TO LABEL UNTIL INCREMENTING COUNTER REACHES NUMBER OF EVENTS DEFINED
	turnoff						;TURNOFF THIS INSTRUMENT IMMEDIATELY
endin

instr	3	;SOUND PRODUCING INSTRUMENT
	aenv	expseg	0.001,.005+(p3*i(gkAttTim)),1,(p3*(1-i(gkAttTim)))-.005,0.001	;CREATE AMPLITUDE ENVELOPE
	asig	oscili	0.2*aenv*p4, cpsoct(p5), gisine					;AUDIO OSCILLATOR
	outs	asig*p6, asig*(1-p6)							;SEND AUDIO TO OUTPUTS
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT
</CsScore>

</CsoundSynthesizer>