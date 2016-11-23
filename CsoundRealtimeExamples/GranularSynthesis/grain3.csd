grain3.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-odac -M0 -+rtmidi=virtual -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE LEVEL

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;		LABEL | WIDTH | HEIGHT | X | Y
	FLpanel	"grain3",500,   1000,   0,  0
;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ihCloudEnv	 	FLbox  	"", 	6,        9,    15,   496,    70,    2, 930	;GRAIN CLOUD ENVELOPE
ihPhase		 	FLbox  	"", 	6,        9,    15,   496,   194 ,    2, 305	;GRAIN PHASE CONTROLS

;SWITCHES                       							ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff			FLbutton	"On/Off(MIDI)",				1,    0,    22,    140,     25,    5,  5,    0,      1,      0,      -1
gkSyncCPS,ihoptions1		FLbutton	"Sync Start Phase to CPS",		64,   0,    22,    166,     50,    0,600,    0,      1,      0,      -1
gkIntegerLoc,ihoptions2		FLbutton	"Start All Grains at Integer Location",	32,   0,    22,    166,     50,  166,600,    0,      1,      0,      -1
gkLessZero,ihoptions3		FLbutton	"Ignore Grains Starting at Phase<0",	16,   0,    22,    166,     50,  333,600,    0,      1,      0,      -1
gkInterp,ihoptions4		FLbutton	"Interpolate Window",			8,    0,    22,    166,     50,    0,650,    0,      1,      0,      -1
gkNoInterp,ihoptions5		FLbutton	"No Interpolate Waveform",		4,    0,    22,    166,     50,  166,650,    0,      1,      0,      -1
gkFreqCont,ihoptions6		FLbutton	"Continual Freq. Modification",		2,    0,    22,    166,     50,  333,650,    0,      1,      0,      -1
gkSkipInit,ihoptions7		FLbutton	"Skip Initialisation",			1,    0,    22,    166,     50,    0,700,    0,      1,      0,      -1
gkMIDIToPch, ihMIDIToPch	FLbutton	"MIDI to Pitch",			1,    0,     2,    170,     20,  290,805,   -1
gkMIDIToDens, ihMIDIToDens	FLbutton	"MIDI to Density",			1,    0,     2,    170,     20,  290,825,   -1
gkfreeze,ihfreeze		FLbutton	"Freeze",				1,    0,    22,     80,     20,  415,425,   -1

FLsetColor2	100, 100, 255, ihMIDIToPch	;SET SECONDARY COLOUR TO BLUE
FLsetColor2	100, 100, 255, ihMIDIToDens	;SET SECONDARY COLOUR TO BLUE
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihoptions1	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihoptions2	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihoptions3	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihoptions4	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihoptions5	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihoptions6	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihoptions7	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihfreeze		;SET SECONDARY COLOUR TO YELLOW

;NUMBER DISPLAY BOXES		WIDTH | HEIGHT | X | Y
idamp	  FLvalue   " ",     	80,       20,    5,  75
iddur	  FLvalue   " ",     	80,       20,    5, 125
idpch	  FLvalue   " ",     	80,       20,    5, 175
idfmd	  FLvalue   " ",     	80,       20,    5, 225
iddens	  FLvalue   " ",     	80,       20,    5, 275
idphs	  FLvalue   " ",     	80,       20,    5, 375
idspd	  FLvalue   " ",     	80,       20,    5, 425
idpmd	  FLvalue   " ",     	80,       20,    5, 475
idfrpow	  FLvalue   " ",     	80,       20,    5, 525
idprpow	  FLvalue   " ",     	80,       20,    5, 575
idseed	  FLvalue   " ",     	80,       17,  305,  30
idAtt	  FLvalue   " ",     	60,       20,    5, 975
idRel	  FLvalue   " ",     	60,       20,  255, 975

;SLIDERS										MIN     |    MAX    | EXP | TYPE |   DISP   | WIDTH | HEIGHT | X   | Y
gkamp, ihamp		FLslider	"Amplitude",    				0,                1,   0,    23,     idamp,     490,     25,    5,    50
gkdur, ihdur		FLslider	"Grain Duration (ms.)",				.001,             1,   0,    23,     iddur,     490,     25,    5,   100
gkpch, ihpch		FLslider	"Pitch",					-4,               2,   0,    23,     idpch,     490,     25,    5,   150
gkfmd, ihfmd		FLslider	"Pitch Offset",					0,                2,   0,    23,     idfmd,     490,     25,    5,   200
gkdens, ihdens		FLslider	"Density",					1,              500,   0,    23,     iddens,    490,     25,    5,   250
gkphs, gihphs		FLslider	"Grain Phase (CC#1)",				0,                1,   0,    23,     idphs,     490,     25,    5,   350
gkspd, ihspd		FLslider	"Speed",					-2,               2,   0,    23,     idspd,     490,     25,    5,   400
gkpmd, ihpmd		FLslider	"Grain Phase Random Offset",			0,                1,   0,    23,     idpmd,     490,     25,    5,   450
gkfrpow, ihfrpow	FLslider	"Distribution of Random Frequency Variation",	-2,               2,   0,    23,     idfrpow,   490,     25,    5,   500
gkprpow,ihprpow		FLslider	"Distribution of Random Phase Variation",	-2,               2,   0,    23,     idprpow,   490,     25,    5,   550
gkseedL,ihseedL		FLslider	" ",						0,       2147483646,   0,    23,     idseed,    190,     12,  305,     5
gkseedR,ihseedR		FLslider	"Seed Value L/R",				0,       2147483646,   0,    23,     idseed,    190,     12,  305,    17
gkDensRnd,ihDensRnd	FLslider	"Density Randomize Amount",			0,               10,   0,    23,     -1,        490,     25,    5,   880
gkAtt,ihAtt		FLslider	"Attack Time",					0.05,            10,   0,    23,     idAtt,     240,     25,    5,   950
gkRel,ihRel		FLslider	"Release",					0.05,            10,   0,    23,     idRel,     240,     25,  255,   950

;			FLsetAlign ialign, ihandle
			FLsetAlign 9,      ihseedR	; (BOTTOM RIGHT)

;COUNTERS				     		MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkmaxolap, ihmaxolap	FLcount  "Maximum Overlaps", 	1,   1000,    1,     100,     1,    140,     25,   155, 5,    -1 
gkwfn, ihwfn		FLcount  "Grain Envelope", 	1,      6,    1,     100,     2,    166,     25,   166,705,   -1 
gksfn, ihsfn		FLcount  "Sound File Input", 	1,      3,    1,     100,     2,    150,     25,    50,805,   -1 
;gkPhsMode, ihPhsMode	FLcount  "Grain Phase Mode 0=Manual 1=Speed_Control", 	1,      3,    1,     100,     2,    150,     25,    50,300,   -1 

;GENERAL_TEXT_SETTINGS			isize, ifont, ialign, ired, igreen, iblue
			FLlabel		13,      1,       1,   255,  255,   255		;NUMBERS MADE INVISIBLE

;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkPhsMode, ihPhsMode	FLbutBank	4,     1,     2,     20,     15*2,   155, 315,   -1

;GENERAL_TEXT_SETTINGS			isize, ifont, ialign, ired, igreen, iblue
			FLlabel		13,      1,      1,   0,      0,     0		;LABELS MADE VISIBLE AGAIN
;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Grain Phase Mode:", 	1,      6,     12,    120,    15,    30,  315
ih		 	FLbox  	"Manual       ", 	1,      5,     12,    100,    15,   175,  315
ih		 	FLbox  	"Speed Control", 	1,      5,     12,    100,    15,   175,  330

;TEXT BOXES              																																TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y 
ih		 FLbox  "Grain Envelopes: 1 - Hanning . 2 - Percussive (straight segments) . 3 - Percussive (exponential segments) . 4 - Gate (with anti click ramp up and ramp down) . 5 - Reverse Percussive (straight segments) . 6 - Reverse Percussive (exponential segments)", 	1,      1,      12,    500,     30,    0, 755
ih		 FLbox  "Sound Files: 1 - Voice . 2 - Drum Loop . 3 - Classical Guitar", 																								1,      1,      12,    250,     30,    0, 845
ih		 FLbox  "Grain Cloud Envelope", 																													1,      3,      12,    130,     15,    5, 931

;INITIAL VALUES OF SLIDERS
;OPCODE		VALUE | HANDLE
FLsetVal_i   	0.25, 	ihamp
FLsetVal_i   	600, 	ihmaxolap
FLsetVal_i   	.25, 	ihdur
FLsetVal_i   	1, 	ihpch
FLsetVal_i   	0, 	ihfmd
FLsetVal_i   	100, 	ihdens
FLsetVal_i   	0.45, 	gihphs
FLsetVal_i   	1, 	ihspd
FLsetVal_i   	0.0055,	ihpmd
FLsetVal_i   	0.000001, 	ihfrpow
FLsetVal_i   	0, 	ihprpow
FLsetVal_i   	0, 	ihseedL
FLsetVal_i   	0, 	ihseedR
FLsetVal_i   	1, 	ihwfn
FLsetVal_i   	1, 	ihsfn
FLsetVal_i   	8, 	ihoptions4
FLsetVal_i   	0.05, 	ihAtt
FLsetVal_i   	0.05, 	ihRel
	FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 700, 512, 0
				FLscroll     515, 700, 0, 0

;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          grain3                             ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"grain3 performs granular synthesis upon a stored function    ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"table. The function table used can contain a simple single   ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"cycle waveform or it can contain a stored sample. In this    ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"example a sound sample stored within a GEN 1 function table  ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"is used. By studying the code it is seen that interrogation  ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"of the sample's duration is needed in order for the 'phase'  ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"parameter to be used effectively. 'Phase' effectively defines", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"to the location within the waveform or function table from   ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"which samples will be read.                                  ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"Grain phase can be controlled either manually, using the     ", 	1,      5,     14,    490,    20,     5, 220 
ih		 	FLbox  	"'Grain Phase' slider or MIDI controller 1, or it can be      ", 	1,      5,     14,    490,    20,     5, 240 
ih		 	FLbox  	"controlled by varying the speed of a phasor ('Speed' slider) ", 	1,      5,     14,    490,    20,     5, 260 
ih		 	FLbox  	"which in turn defines the grain phase.                       ", 	1,      5,     14,    490,    20,     5, 280 
ih		 	FLbox  	"In this example pitch is reinterpretted mathematically so    ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"that the values inputted via the interface are ratios to the ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"original pitch of the sample. i.e. a value of represents no  ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"transposition, a value of 2 represents a transposition up 1  ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"octave, a value of .5 represents a transposition down 1      ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"octave and so on.                                            ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"The grain3 opcode allows for user modification of what sort  ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"of random distribution it uses in its randomisation          ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"precedures for pitch and phase. This example allows the user ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"to modify these setting but for a more in depth explanation  ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"of what exactly these values represent the user is directed  ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"to the Csound Manual.                                        ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"The 'seed value' (optional) is used to seed the pseudo-random", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"number generator that is used in the randomization of pitch  ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"and phase. A value of zero means that the system clock       ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"reading will be used as a seed value.                        ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"Another optional input argument, called 'imode' in the manual", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"allows for the setting of a variety of subtle options in the ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"precise way in which grains are produced. For convenience    ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"these options are represented individually with a series of  ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"switches in this example.                                    ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"The user must supply a windowing function via a function     ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"table that the opcode will use to apply an amplitude envelope", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"to each grain. In this example six different envelope types  ", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"are offerred for experimentation. Descriptions of the        ", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"different types on offer are included on the main panel. To  ", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"hear most clearly the effect of using different grain        ", 	1,      5,     14,    490,    20,     5, 820
ih		 	FLbox  	"envelopes set 'Density' to a low value and set 'Grain        ", 	1,      5,     14,    490,    20,     5, 840
ih		 	FLbox  	"Duration' to a high setting.                                 ", 	1,      5,     14,    490,    20,     5, 860
ih		 	FLbox  	"This instrument can also be activated via MIDI. MIDI pitch   ", 	1,      5,     14,    490,    20,     5, 880
ih		 	FLbox  	"values can be mapped to grain density and/or to the pitch of ", 	1,      5,     14,    490,    20,     5, 900
ih		 	FLbox  	"the material contained within the grain. In the latter       ", 	1,      5,     14,    490,    20,     5, 920
ih		 	FLbox  	"mapping option, middle C is the point at which no            ", 	1,      5,     14,    490,    20,     5, 940
ih		 	FLbox  	"transposition occurs. Using MIDI activation, polyphony is    ", 	1,      5,     14,    490,    20,     5, 960
ih		 	FLbox  	"possible. Grain phase can also be controlled via MIDI        ", 	1,      5,     14,    490,    20,     5, 980
ih		 	FLbox  	"controller nr. 1 (modulation wheel).                         ", 	1,      5,     14,    490,    20,     5,1000
ih		 	FLbox  	"A random factor can be multiplied to the density control to  ", 	1,      5,     14,    490,    20,     5,1020
ih		 	FLbox  	"prevent the tone produced through synchronous reiteration of ", 	1,      5,     14,    490,    20,     5,1040
ih		 	FLbox  	"identical grains.                                            ", 	1,      5,     14,    490,    20,     5,1060
ih		 	FLbox  	"The attack and release times of an amplitude envelope applied", 	1,      5,     14,    490,    20,     5,1080
ih		 	FLbox  	"to the entire grain cloud can be modulated by the user using ", 	1,      5,     14,    490,    20,     5,1100
ih		 	FLbox  	"two on screen sliders. These controls are probably most      ", 	1,      5,     14,    490,    20,     5,1120
ih		 	FLbox  	"useful when triggering this example via MIDI.                ", 	1,      5,     14,    490,    20,     5,1140
ih		 	FLbox  	"Audio output can be rendered by clicking 'File Open' and then", 	1,      5,     14,    490,    20,     5,1160
ih		 	FLbox  	"activating 'Record'. Recording can be paused and restarted by", 	1,      5,     14,    490,    20,     5,1180
ih		 	FLbox  	"deactivating and reactivating the 'Record' button. Clicking  ", 	1,      5,     14,    490,    20,     5,1200
ih		 	FLbox  	"'File Open' again will clear any previously recorded         ", 	1,      5,     14,    490,    20,     5,1220
ih		 	FLbox  	"material. A 24 bit sound file called 'Grain3Output.wav' will ", 	1,      5,     14,    490,    20,     5,1240
ih		 	FLbox  	"be created in the default directory for SFDIR.               ", 	1,      5,     14,    490,    20,     5,1260

				FLscrollEnd
				FLpanel_end

;RECORD OUTPUT PANEL
		FLpanel	"Record",   300,    35, 512, 755
;BUTTONS                        	LABEL       | ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkfileopen,ihfileopen	FLbutton	"File Open",  1,    0,    21,    140,     25,    5,  5,     0,     99,    0,       -1
gkrecord,ihrecord	FLbutton	"Record",     1,    0,    22,    140,     25,  150,  5,    -1
FLsetColor2	255, 255, 50, ihfileopen	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 50, 50, ihrecord		;SET SECONDARY COLOUR TO RED
FLpanel_end	;END OF PANEL CONTENTS

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; THE SOUND FILES USED IN THE GRANULATION
;              NUM | INIT_TIME | SIZE | GEN_ROUTINE | FILE_PATH          | IN_SKIP | FORMAT | CHANNEL
gifile1L ftgen 0,        0,     524288,       1,    "AndItsAll.wav",          0,        4,        1 
gifile2L ftgen 0,        0,     524288,       1,    "loop.wav",               0,        4,        1 
gifile3L ftgen 0,        0,     1048576,      1,    "ClassicalGuitar.wav",    0,        4,        1 

gifile1R ftgen 0,        0,     524288,       1,    "AndItsAll.wav",          0,        4,        1 ;MONO FILE SO USE LEFT CHANNEL AGAIN
gifile2R ftgen 0,        0,     524288,       1,    "loop.wav",               0,        4,        1 ;MONO FILE SO USE LEFT CHANNEL AGAIN
gifile3R ftgen 0,        0,     1048576,      1,    "ClassicalGuitar.wav",    0,        4,        2 ;STEREO FILE SO USE RIGHT CHANNEL

;GRAIN ENVELOPE WINDOW FUNCTION TABLES:
giwfn1	ftgen	0,  0, 512,  20, 2				; HANNING WINDOW
giwfn2	ftgen	0,  0, 512,  7, 0, 12, 1, 500, 0		; PERCUSSIVE - STRAIGHT SEGMENTS
giwfn3	ftgen	0,  0, 512,  5, 0.001, 12, 1, 500, 0.001	; PERCUSSIVE - EXPONENTIAL SEGMENTS
giwfn4	ftgen	0,  0, 512,  7, 0, 6, 1, 500, 1, 6, 0		; GATE - WITH ANTI-CLICK RAMP UP AND RAMP DOWN SEGMENTS
giwfn5	ftgen	0,  0, 512,  7, 0, 500, 1, 12, 0		; REVERSE PERCUSSIVE - STRAIGHT SEGMENTS
giwfn6	ftgen	0,  0, 512,  5, 0.001, 500, 1, 12, 0.001	; REVERSE PERCUSSIVE - EXPONENTIAL SEGMENTS

initc7	1,0,0.45	;INITIALIZE MIDI CONTROLLER

opcode	Grain3b,a,kkkkkkiiikkiiik
	kpch, kphs, kfmd, kpmd, kdur, kdens, imaxovr, isfn, iwfn, kfrpow, kprpow , iseed, imode, iPhsMode, kDensRnd	xin
	kpch		=	(iPhsMode==1?kpch-kphs:kpch)	;IF 'SPEED CONTROL' GRAIN PHASE MODE IS SELECTED COMPENSATE PITCH TO CORRECT FOR UNWANTED TRANSPOSITIONS
	kpitch 		= 	(sr*(kpch))/ftlen(isfn)	;MATHEMATICALLY REINTERPRET USER INPUTTED PITCH RATIO VALUE INTO A FORMAT THAT IS USABLE AS AN INPUT ARGUMENT BY THE grain3 OPCODE - ftlen(x) FUNCTION RETURNS THE LENGTH OF A FUNCTION TABLE (no. x), REFER TO MANUAL FOR MORE INFO.
	
	kfmd		=	(sr*(kfmd*kpch))/ftlen(isfn)
	
	;IF 'SPEED CONTROL' GRAIN PHASE MODE HAS BEEN CHOSEN CREATE A MOVING PHASE ACCORDING TO SPEED RATIO (gkspd)
	if iPhsMode==1 then
	 kphs		phasor	kphs/(nsamp(isfn)/sr)
	endif
	
	kphs 		= 	kphs*(nsamp(isfn)/ftlen(isfn))	;MATHEMATICALLY REINTERPRET USER INPUTTED PHASE VALUE INTO A FORMAT THAT IS USABLE AS AN INPUT ARGUMENT  BY THE grain3 OPCODE
	kDensRnd 	exprand kDensRnd			;CREATE A RANDOM OFFSET FACTOR THAT WILL BE APPLIED TO FOR DENSITY
	kdens		=	kdens * (1 + kDensRnd)		;DENSITY VALUE IS OFFSET BY RANDOM FACTOR
	asig	grain3	kpitch, kphs, kfmd, kpmd, kdur, kdens, imaxovr, isfn, iwfn, kfrpow, kprpow , iseed, imode
	xout	asig

endop

instr	1
	kporttime	linseg	0,0.001,0.1			;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A SET VALUE	

	iMIDIActiveValue	=	1		;IF MIDI ACTIVATED
	iMIDIflag		=	0		;IF FLTK ACTIVATED
	mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 
	icps	cpsmidi		;READ MIDI PITCH VALUES - THIS VALUE CAN BE MAPPED TO GRAIN DENSITY AND/OR PITCH DEPENDING ON THE SETTING OF THE MIDI MAPPING SWITCHES
	if	gkOnOff=0&&iMIDIflag=0	then ;SENSE FLTK ON/OFF SWITCH & WHETHER THIS IS A MIDI NOTE ITS STATUS WILL BE IGNORED
				turnoff	;TURNOFF THIS INSTRUMENT IMMEDIATELY
	endif				;END OF THIS CONDITIONAL BRANCH

	if iMIDIflag=1&&gkMIDIToPch=1 then		;IF THIS IS A MIDI ACTIVATED NOTE AND MIDI-TO-PITCH SWITCH IS ON... 
		kpch	=	icps/cpsoct(8)		;MAP TO MIDI NOTE VALUE TO PITCH (CONVERT TO RATIO: MIDDLE C IS POINT OF UNISON)
	else					;OTHERWISE...
		kpch		portk	gkpch, kporttime	;USE THE FLTK SLIDER VALUE
	endif					;END OF THIS CONDITIONAL BRANCH

	if iMIDIflag=1&&gkMIDIToDens=1 then		;IF THIS IS A MIDI ACTIVATED NOTE AND MIDI-TO-PITCH SWITCH IS ON... 
		kdens	=	icps		;MAP TO MIDI NOTE VALUE TO GRAIN DENSITY
	else					;OTHERWISE...
		kdens		portk	gkdens,  kporttime	;PORTAMENTO IS APPLIED TO SMOOTH VALUE CHANGES VIA THE FLTK SLIDERS
	endif					;END OF THIS CONDITIONAL BRANCH

	kSwitch		changed	gkPhsMode,gkmaxolap, gkseedL, gkseedR, gkSyncCPS, gkIntegerLoc, gkLessZero, gkInterp, gkNoInterp, gkFreqCont, gkFreqCont, gkSkipInit, gkwfn, gksfn
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	START			;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif
	START:
	isfnL 		= 	gifile1L + i(gksfn) - 1	;SOURCE SOUND/WAVEFORM FUNCTION TABLE
	isfnR 		= 	gifile1R + i(gksfn) - 1	;SOURCE SOUND/WAVEFORM FUNCTION TABLE
	iwfn		=	giwfn1 + i(gkwfn) - 1
	
	kphs		=	(gkPhsMode==1?gkspd*(1-gkfreeze):gkphs)	;CHOOSE 'MANUAL PHASE' OR 'SPEED' ACCORDING TO GRAIN PHASE MODE SELECTED
	
	aSigL	Grain3b	kpch, kphs, gkfmd, gkpmd, gkdur, kdens, i(gkmaxolap), isfnR, iwfn, gkfrpow, gkprpow , i(gkseedR), i(gkSyncCPS) + i(gkIntegerLoc) + i(gkLessZero) + i(gkInterp) + i(gkNoInterp) + i(gkFreqCont) + i(gkFreqCont) + i(gkSkipInit),i(gkPhsMode),gkDensRnd
	aSigR	Grain3b	kpch, kphs, gkfmd, gkpmd, gkdur, kdens, i(gkmaxolap), isfnR, iwfn, gkfrpow, gkprpow , i(gkseedR), i(gkSyncCPS) + i(gkIntegerLoc) + i(gkLessZero) + i(gkInterp) + i(gkNoInterp) + i(gkFreqCont) + i(gkFreqCont) + i(gkSkipInit),i(gkPhsMode),gkDensRnd
	rireturn	;RETURN TO PERFORMANCE TIME PASSES
	aenv	expsegr	0.0001,i(gkAtt),1,i(gkRel),0.0001	;CLOUD AMPLITUDE ENVELOPE
	outs 		aSigL  * gkamp * aenv, aSigR  * gkamp * aenv				;SEND AUDIO TO OUTPUTS
endin

instr	2	;UPDATE FLTK SLIDERS FROM MIDI CONTROLLER VALUES
        ;MIDI CONTROLLER SYNCHRONISATION
#define CONTROLLER(NAME'NUMBER'MIN'MAX)
        #
        k$NAME          ctrl7           1,$NUMBER,0,1           ;READ MIDI CONTROLLER
        ktrig$NAME      changed         k$NAME                  ;CREATE A TRIGGER PULSE IF MIDI CONTROLLER IS MOVED
        k$NAME          scale           k$NAME, $MAX, $MIN      ;VARIBALE HAS TO BE RESCALED HERE, DOING IT IN THE ctrl7 LINE UPSETS THE WORKING OF THE changed OPCODE ABOVE
        FLsetVal        ktrig$NAME,     k$NAME, gih$NAME                ;UPDATE FLTK VALUATOR IF MIDI CONTROLLER HAS BEEN MOVED
        #
        ;           NAME    NUM MIN MAX
        $CONTROLLER(phs'     1 ' 0 ' 1)
endin

instr	99	;RECORDING INSTRUMENT
	if gkrecord=1	then						;IF 'Record' SWITCH IS ON...
	aL,aR	monitor
	;	OPCODE	FILENAME         | FORMAT | OUT1  | OUT2 etc...
		fout	"grain3Output.wav",   8,      aL,     aR		;AUDIO FILE OUTPUT FORMAT IS 24 BIT. CHANGE IF REQUIRED
	endif								;END OF THIS CONDITIONAL BRANCH
endin

</CsInstruments>

<CsScore>
i 2 0 3600	;UPDATE FLTK SLIDERS FROM MIDI CONTROLLER VALUES
</CsScore>

</CsoundSynthesizer>