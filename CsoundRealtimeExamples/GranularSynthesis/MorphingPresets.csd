MorphingPresets.csd
Written by Iain McCurdy, 2008

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM SOUND INTENSITY LEVEL REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL              | WIDTH | HEIGHT | X | Y
	FLpanel	"Morphing Presets",   500,     700,   0,  0

;SWITCHES                                						ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff			FLbutton	"On/Off",				1,    0,    22,    140,     25,    5,  5,    0,      1,      0,      -1
gkSyncCPS,ihSyncCPS		FLbutton	"Sync Start Phase to CPS",		64,   0,    22,    166,     50,    0,500,    0,      2,      0,      -1
gkIntegerLoc,ihIntegerLoc	FLbutton	"Start All Grains at Integer Location",	32,   0,    22,    166,     50,  166,500,    0,      2,      0,      -1
gkLessZero,ihLessZero		FLbutton	"Ignore Grains Starting at Phase<0",	16,   0,    22,    166,     50,  333,500,    0,      2,      0,      -1
gkInterp,ihInterp		FLbutton	"Interpolate Window",			8,    0,    22,    166,     50,    0,550,    0,      2,      0,      -1
gkNoInterp,ihNoInterp		FLbutton	"No Interpolate Waveform",		4,    0,    22,    166,     50,  166,550,    0,      2,      0,      -1
gkFreqCont,ihFreqCont		FLbutton	"Continual Freq. Modification",		2,    0,    22,    166,     50,  333,550,    0,      2,      0,      -1
gkSkipInit,ihSkipInit		FLbutton	"Skip Initialisation",			1,    0,    22,    166,     50,    0,600,    0,      2,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihSyncCPS		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihIntegerLoc	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihLessZero	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihInterp		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihNoInterp	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihFreqCont	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihSkipInit	;SET SECONDARY COLOUR TO YELLOW

;NUMBER DISPLAY BOXES		WIDTH | HEIGHT | X | Y
idamp	  FLvalue   "",     	80,       20,    5,  75
iddur	  FLvalue   "",     	80,       20,    5, 125
idpch	  FLvalue   "",     	80,       20,    5, 175
idfmd	  FLvalue   "",     	80,       20,    5, 225
iddens	  FLvalue   "",     	80,       20,    5, 275
idphs	  FLvalue   "",     	80,       20,    5, 325
idpmd	  FLvalue   "",     	80,       20,    5, 375
idfrpow	  FLvalue   "",     	80,       20,    5, 425
idprpow	  FLvalue   "",     	80,       20,    5, 475
idseed	  FLvalue   "",     	80,       15,  305,  30

;SLIDERS										MIN    |    MAX   | EXP | TYPE |   DISP   | WIDTH | HEIGHT |  X   |  Y
gkamp, ihamp		FLslider	"Amplitude",    				0,              1,   0,    23,    idamp,     490,     25,      5,    50
gkdur, gihdur		FLslider	"Grain Duration (ms.) *",			.001,           2,   0,    23,    iddur,     490,     25,      5,   100
gkpch, gihpch		FLslider	"Pitch *",					.016125,       16,  -1,    23,    idpch,     490,     25,      5,   150
gkfmd, gihfmd		FLslider	"Pitch Offset *",				0,              2,   0,    23,    idfmd,     490,     25,      5,   200
gkdens, gihdens		FLslider	"Density *",					1,            500,   0,    23,    iddens,    490,     25,      5,   250
gkphs, gihphs		FLslider	"Grain Phase *",				0,              1,   0,    23,    idphs,     490,     25,      5,   300
gkpmd, gihpmd		FLslider	"Grain Phase Random Offset *",			0,              1,   0,    23,    idpmd,     490,     25,      5,   350
gkfrpow, ihfrpow	FLslider	"Distribution of Random Frequency Variation",	-2,             2,   0,    23,    idfrpow,   490,     25,      5,   400
gkprpow,ihprpow		FLslider	"Distribution of Random Phase Variation",	-2,             2,   0,    23,    idprpow,   490,     25,      5,   450
gkseedL,ihseedL		FLslider	" ",						0,     2147483646,   0,    23,    idseed,    190,     12,    305,     5
gkseedR,ihseedR		FLslider	"Seed Value L/R",				0,     2147483646,   0,    23,    idseed,    190,     12,    305,    17

;			FLsetAlign ialign, ihandle
			FLsetAlign 9,      ihseedR	; (BOTTOM RIGHT)


;COUNTERS				     		MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkmaxolap, ihmaxolap	FLcount  "Maximum Overlaps", 	1,   1000,    1,     100,     1,    140,     25,   155, 5,    -1 
gkwfn, ihwfn		FLcount  "Grain Envelope", 	1,      6,    1,     100,     2,    166,     25,   166,605,   -1 

;TEXT BOXES              																														TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y 
ih		 FLbox  "Grain Envelopes: 1 - Hanning . 2 - Percussive (straight segments) . 3 - Percussive (exponential segments) . 4 - Gate (with anti click ramp up and ramp down) . 5 - Reverse Percussive (straight segments) . 6 - Reverse Percussive (exponential segments)", 	1,     1,      12,    500,     30,    0, 655

; INITIAL VALUES OF SLIDERS
;OPCODE		VALUE | HANDLE
FLsetVal_i   	0.2, 	ihamp
FLsetVal_i   	600, 	ihmaxolap
FLsetVal_i   	.25, 	gihdur
FLsetVal_i   	1, 	gihpch
FLsetVal_i   	0, 	gihfmd
FLsetVal_i   	5, 	gihdens
FLsetVal_i   	.45, 	gihphs
FLsetVal_i   	.0055, 	gihpmd
FLsetVal_i   	0, 	ihfrpow
FLsetVal_i   	0, 	ihprpow
FLsetVal_i   	0, 	ihseedL
FLsetVal_i   	0, 	ihseedR
FLsetVal_i   	1, 	ihwfn

	FLpanel_end

;MORPHING PANEL
				FLpanel	" ", 515, 450, 512, 0

;SWITCHES                                	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR | 4
gknull,ihCorner1	FLbutton	"",	0,    0,    1,      30,     30,   70, 20,    0,      11,      0,      0,   1
gknull,ihCorner2	FLbutton	"",	0,    0,    1,      30,     30,  450, 20,    0,      11,      0,      0,   2
gknull,ihCorner3	FLbutton	"",	0,    0,    1,      30,     30,   70,400,    0,      11,      0,      0,   3
gknull,ihCorner4	FLbutton	"",	0,    0,    1,      30,     30,  450,400,    0,      11,      0,      0,   4
gknull,ihLoad		FLbutton	"Load",	1,    0,    1,      40,     20,   10, 70,    0,      21,      0,    .01
gknull,ihSave		FLbutton	"Save",	1,    0,    1,      40,     20,   50, 70,    0,      31,      0,    .01
FLsetColor	100,100,255,ihCorner1	;LIGHT BLUE
FLsetColor	100,100,255,ihCorner2	;LIGHT BLUE
FLsetColor	100,100,255,ihCorner3	;LIGHT BLUE
FLsetColor	100,100,255,ihCorner4	;LIGHT BLUE
FLsetColor	255,100,100,ihSave	;LIGHT RED
FLsetColor	100,255,100,ihLoad	;LIGHT GREEN

;OUTX,OUTY,IHANDLEX,IHANDLEY	FLJOY	LABEL | MINX | MAXX | MINY | MAXY | EXPX | EXPY | DISPX | DISPY | WIDTH | HEIGHT | X |  Y
gkx, gky, ihx, ihy		FLjoy	" ",    0,       1,    0,      1,     0,     0,    -1,     -1,     350,    350,  100,  50

				FLpanel_end


;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 300, 512, 500
				FLscroll     515, 300, 0, 0

;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                     Morphing Presets                        ", 	1,      5,     14,    490,     20,    5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,     20,    5,  20
ih		 	FLbox  	"This example is based on the example 'grain3.csd' so I would ", 	1,      5,     14,    490,     20,    5,  40
ih		 	FLbox  	"recommend investigating that example first.                  ", 	1,      5,     14,    490,     20,    5,  60
ih		 	FLbox  	"The innovation that this example introduces is the use of an ", 	1,      5,     14,    490,     20,    5,  80
ih		 	FLbox  	"X-Y 'FLjoy' panel to allow the user to 2-dimensionally morph ", 	1,      5,     14,    490,     20,    5, 100
ih		 	FLbox  	"between 4 presets.                                           ", 	1,      5,     14,    490,     20,    5, 120
ih		 	FLbox  	"The quickest way to see what this does is to click on the    ", 	1,      5,     14,    490,     20,    5, 140
ih		 	FLbox  	"green 'Load' button ensure that the files 'Preset1.txt',     ", 	1,      5,     14,    490,     20,    5, 160
ih		 	FLbox  	"'Preset2.txt', 'Preset3.txt' and 'Preset4.txt' are in the    ", 	1,      5,     14,    490,     20,    5, 180
ih		 	FLbox  	"same directory as this file), activate the on-screen 'On/Off'", 	1,      5,     14,    490,     20,    5, 200
ih		 	FLbox  	"button and to then drag the cross-hairs of the FLjoy panel.  ", 	1,      5,     14,    490,     20,    5, 220
ih		 	FLbox  	"Four distinct presets are referenced to the four corners of  ", 	1,      5,     14,    490,     20,    5, 240
ih		 	FLbox  	"the X-Y panel. Dragging the cross-hairs to locations other   ", 	1,      5,     14,    490,     20,    5, 260
ih		 	FLbox  	"than these four corners creates a morph, or interpolation,   ", 	1,      5,     14,    490,     20,    5, 280
ih		 	FLbox  	"between the four presets, the influence of each preset on the", 	1,      5,     14,    490,     20,    5, 300
ih		 	FLbox  	"resultant preset is relative to its closeness to the current ", 	1,      5,     14,    490,     20,    5, 320
ih		 	FLbox  	"location of the cross-hairs.                                 ", 	1,      5,     14,    490,     20,    5, 340
ih		 	FLbox  	"You will notice that only parameters whose slider labels     ", 	1,      5,     14,    490,     20,    5, 360
ih		 	FLbox  	"have been suffixed with an asterisk ('*') are influenced by  ", 	1,      5,     14,    490,     20,    5, 380
ih		 	FLbox  	"the presets.                                                 ", 	1,      5,     14,    490,     20,    5, 400
ih		 	FLbox  	"The sliders can of course be modified individually. A preset ", 	1,      5,     14,    490,     20,    5, 420
ih		 	FLbox  	"or snapshot can then be stored by clicking on one of the blue", 	1,      5,     14,    490,     20,    5, 440
ih		 	FLbox  	"boxes at each corner of the X-Y panel. All four presets can  ", 	1,      5,     14,    490,     20,    5, 460
ih		 	FLbox  	"be stored permanantly a set of four text files by clicking on", 	1,      5,     14,    490,     20,    5, 480
ih		 	FLbox  	"the red 'save' button. These four text files, and            ", 	1,      5,     14,    490,     20,    5, 500
ih		 	FLbox  	"consequently the four presets, can be re-loaded in a later   ", 	1,      5,     14,    490,     20,    5, 520
ih		 	FLbox  	"Csound session by clicking on the green 'load' button. The   ", 	1,      5,     14,    490,     20,    5, 540
ih		 	FLbox  	"mechanism by which this is achieved is explained in detail   ", 	1,      5,     14,    490,     20,    5, 560
ih		 	FLbox  	"in example 'ftsave_ftload.csd'.                              ", 	1,      5,     14,    490,     20,    5, 580
ih		 	FLbox  	"More parameters can easily be included in a preset by making ", 	1,      5,     14,    490,     20,    5, 600
ih		 	FLbox  	"a small modification to the code.                            ", 	1,      5,     14,    490,     20,    5, 620

				FLscrollEnd
				FLpanel_end

;RECORD OUTPUT PANEL
		FLpanel	"Record",   300,    35,  0, 755
;BUTTONS                        	LABEL       | ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkfileopen,ihfileopen	FLbutton	"File Open",  1,    0,    21,    140,     25,    5,  5,     0,     99,    0,       -1
gkrecord,ihrecord	FLbutton	"Record",     1,    0,    22,    140,     25,  150,  5,    -1
FLsetColor2	255, 255, 50, ihfileopen	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 50, 50, ihrecord		;SET SECONDARY COLOUR TO RED
FLpanel_end	;END OF PANEL CONTENTS

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

giDataTypeFlag	=	1	;0=BINARY NON-ZERO=TEXT - THIS DEFINES THE DATA TYPE IN THE FILE SAVED TO SUBSEQUENTLY LOADED FROM DISK

instr	1
	if		gkOnOff==0	then	;SENSE FLTK ON/OFF SWITCH
			turnoff			;TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif					;END OF CONDITIONAL BRANCHING
	kSwitch		changed	gkmaxolap, gkseedL, gkseedR, gkSyncCPS, gkIntegerLoc, gkLessZero, gkInterp, gkNoInterp, gkFreqCont, gkFreqCont, gkSkipInit, gkwfn
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	START			;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif					;END OF CONDITIONAL BRANCHING
	START:					;LABEL
	ifn 		= 	99	;SOURCE SOUND/WAVEFORM FUNCTION TABLE
	kpitch 		= 	(sr*gkpch)/ftlen(ifn)	;MATHEMATICALLY REINTERPRET USER INPUTTED PITCH RATIO VALUE INTO A FORMAT THAT IS USABLE AS AN INPUT ARGUMENT BY THE grain3 OPCODE - ftlen(x) FUNCTION RETURNS THE LENGTH OF A FUNCTION TABLE (no. x), REFER TO MANUAL FOR MORE INFO.
	imaxovr 	= 	i(gkmaxolap)	;MAXIMUM NUMBER OF OVERLAPS
	kphs 		= 	gkphs*(nsamp(ifn)/ftlen(ifn))	;MATHREMATICALLY REINTERPRET USER INPUTTED PHASE VALUE INTO A FORMAT THAT IS USABLE AS AN INPUT ARGUMENT  BY THE grain3 OPCODE
	imode		=	i(gkSyncCPS) + i(gkIntegerLoc) + i(gkLessZero) + i(gkInterp) + i(gkNoInterp) + i(gkFreqCont) + i(gkFreqCont) + i(gkSkipInit)	;SUM THE MODE BUTTON OUTPUTS
	aSigL		grain3	kpitch, kphs, gkfmd, gkpmd, gkdur, gkdens, imaxovr, ifn, i(gkwfn)+99, gkfrpow, gkprpow , i(gkseedL), int(imode)
	aSigR		grain3	kpitch, kphs, gkfmd, gkpmd, gkdur, gkdens, imaxovr, ifn, i(gkwfn)+99, gkfrpow, gkprpow , i(gkseedR), int(imode)
	rireturn
			outs 	aSigL*gkamp, aSigR*gkamp
	ktrigger	changed	gkx, gky
	if		ktrigger!=1 kgoto SKIP

;A TEXT MACRO IS DEFINED THAT PROVIDES THE CODE THAT WILL BE USED TO DERIVE A VALUE FOR EACH PARAMETER GOVERNED BY THE PRESETS
;THIS CODE WILL BE REPEATED FOR EACH PARAMETER SO TO USE A MACRO GREATLY REDUCES THE AMOUNT OF CODE NEEDED, PARTICULARLY IF A LARGE NUMBER OF PARAMETERS ARE NEEDED 
;START OF TEXT MACRO
#define	MORPH(VAR'NDX)	#
	k$VAR.1		table	$NDX, 1			;DERIVE PARAMETER FOR PRESET 1 (UPPER LEFT CORNER) 
	k$VAR.2		table	$NDX, 2			;DERIVE PARAMETER FOR PRESET 2 (UPPER RIGHT CORNER)
	k$VAR.3		table	$NDX, 3			;DERIVE PARAMETER FOR PRESET 3 (BOTTOM LEFT CORNER)
	k$VAR.4		table	$NDX, 4			;DERIVE PARAMETER FOR PRESET 4 (BOTTOM RIGHT CORNER)
	k$VAR.XTop	ntrpol	k$VAR.1,k$VAR.2,gkx	;CREATE AN INTERIM VARIABLE INTERPOLATED BETWEEN PRESET 1 AND PRESET 2 (UPPER EDGE OF FLpanel)
	k$VAR.XBot	ntrpol	k$VAR.3,k$VAR.4,gkx	;CREATE AN INTERIM VARIABLE INTERPOLATED BETWEEN PRESET 3 AND PRESET 4 (BOTTOM EDGE OF FLpanel)
	k$VAR		ntrpol	k$VAR.XBot,k$VAR.XTop,gky	;DERIVE THE FINAL VALUE FOR THE REQUIRED PARAMETER BY INTERPOLATING BETWEEN UPPER EDGE VARIABLE AND BOTTOM EDGE VARIABLE
	FLsetVal	ktrigger,k$VAR,gih$VAR	;UPDATE SLIDER APPEARANCE FOR RELEVANT PARAMETER
#
;END OF TEXT MACRO

;CREATE AN ITERATION OF THE 'MORPH' CODE MACRO
$MORPH(dens'0)

$MORPH(dur'1)
$MORPH(pch'2)
$MORPH(fmd'3)
$MORPH(phs'4)
$MORPH(pmd'5)

SKIP:
endin

instr	11	;SAVE DATA TO A FUNCTION TABLE, THIS INSTRUMENT IS ACTIVATED EACH TIME A BLUE CORNER BUTTON IS PRESSED
	tableiw	i(gkdens), 0, p4	;PARAMETER VALUE IS WRITTEN TO ITS OWN UNIQUE LOCATION IN THE FUNCTION TABLE FOR THAT PRESET
	tableiw	i(gkdur),  1, p4	;PARAMETER VALUE IS WRITTEN TO ITS OWN UNIQUE LOCATION IN THE FUNCTION TABLE FOR THAT PRESET
	tableiw	i(gkpch),  2, p4	;PARAMETER VALUE IS WRITTEN TO ITS OWN UNIQUE LOCATION IN THE FUNCTION TABLE FOR THAT PRESET
	tableiw	i(gkfmd),  3, p4	;PARAMETER VALUE IS WRITTEN TO ITS OWN UNIQUE LOCATION IN THE FUNCTION TABLE FOR THAT PRESET
	tableiw	i(gkphs),  4, p4	;PARAMETER VALUE IS WRITTEN TO ITS OWN UNIQUE LOCATION IN THE FUNCTION TABLE FOR THAT PRESET
	tableiw	i(gkpmd),  5, p4	;PARAMETER VALUE IS WRITTEN TO ITS OWN UNIQUE LOCATION IN THE FUNCTION TABLE FOR THAT PRESET
endin

instr	21	;LOAD DATA FROM STORED TEXT FILES, THIS INSTRUMENT IS ACTIVATED BRIEFLY WHENEVER THE GREEN 'Load' BUTTON IS PRESSED
	ftload "Preset1.txt", giDataTypeFlag, 1		;LOAD FILE TO FUNCTION TABLE
	ftload "Preset2.txt", giDataTypeFlag, 2		;LOAD FILE TO FUNCTION TABLE
	ftload "Preset3.txt", giDataTypeFlag, 3		;LOAD FILE TO FUNCTION TABLE
	ftload "Preset4.txt", giDataTypeFlag, 4		;LOAD FILE TO FUNCTION TABLE
endin

instr	31	;SAVE DATA TO TEXT FILES STORED ON DISK, THIS INSTRUMENT IS ACTIVATED BRIEFLY WHENEVER THE RED 'Save' BUTTON IS PRESSED
	ftsave "Preset1.txt", giDataTypeFlag, 1		;FUNCTION TABLE IS SAVED AS A TEXT FILE (FILE EXTENSION COULD BE ANYTHING OR NOTHING BUT MAKING IT A TEXT FILE MAKES IT EASY TO OPEN AND EXAMINE AND POSSIBLY ALTER - FOR THIS, DATA TYPE FLAG SHOULD BE NON-ZERO)
	ftsave "Preset2.txt", giDataTypeFlag, 2		;FUNCTION TABLE IS SAVED AS A TEXT FILE (FILE EXTENSION COULD BE ANYTHING OR NOTHING BUT MAKING IT A TEXT FILE MAKES IT EASY TO OPEN AND EXAMINE AND POSSIBLY ALTER - FOR THIS, DATA TYPE FLAG SHOULD BE NON-ZERO)
	ftsave "Preset3.txt", giDataTypeFlag, 3		;FUNCTION TABLE IS SAVED AS A TEXT FILE (FILE EXTENSION COULD BE ANYTHING OR NOTHING BUT MAKING IT A TEXT FILE MAKES IT EASY TO OPEN AND EXAMINE AND POSSIBLY ALTER - FOR THIS, DATA TYPE FLAG SHOULD BE NON-ZERO)
	ftsave "Preset4.txt", giDataTypeFlag, 4		;FUNCTION TABLE IS SAVED AS A TEXT FILE (FILE EXTENSION COULD BE ANYTHING OR NOTHING BUT MAKING IT A TEXT FILE MAKES IT EASY TO OPEN AND EXAMINE AND POSSIBLY ALTER - FOR THIS, DATA TYPE FLAG SHOULD BE NON-ZERO)
endin

instr	99	;RECORDING INSTRUMENT
	if gkrecord=1	then	;IF 'Record' switch is on...
	aL,aR	monitor
	;	OPCODE	FILENAME                    | FORMAT | OUT1  | OUT2 etc...
		fout	"MorphingPresetsOutput.wav",     8,     aL,     aR	; AUDIO FILE OUTPUT FORMAT IS 24 BIT. CHANGE IF REQUIRED
	endif
endin

</CsInstruments>

<CsScore>
f 1 0 8 -2 0	;FUNCTION TABLE USED TO STORE DATA FOR PRESET 1
f 2 0 8 -2 0	;FUNCTION TABLE USED TO STORE DATA FOR PRESET 2
f 3 0 8 -2 0	;FUNCTION TABLE USED TO STORE DATA FOR PRESET 3
f 4 0 8 -2 0	;FUNCTION TABLE USED TO STORE DATA FOR PRESET 4
;NOTE THAT FUNCTION TABLES WILL NEED TO BE ENLARGED IF MORE THAT 8 PARAMETERS ARE TO BE INCLUDED IN THE PRESETS

; THE SOUND FILE USED IN THE GRANULATION
; NUM | INIT_TIME | SIZE | GEN_ROUTINE | FILE_PATH          | IN_SKIP | FORMAT | CHANNEL
f  99        0      1048576       1    "ClassicalGuitar.wav"     0         4        1 

;GRAIN ENVELOPE WINDOW FUNCTION TABLES:
f100  0 512  20 2			; HANNING WINDOW
f101  0 512  7 0 12 1 500 0		; PERCUSSIVE - STRAIGHT SEGMENTS
f102  0 512  5 .00001 12 1 500 .00001	; PERCUSSIVE - EXPONENTIAL SEGMENTS
f103  0 512  7 0 6 1 500 1 6 0		; GATE - WITH ANTI-CLICK RAMP UP AND RAMP DOWN SEGMENTS
f104  0 512  7 0 500 1 12 0		; REVERSE PERCUSSIVE - STRAIGHT SEGMENTS
f105  0 131072  5 .00001 [131072-1024] 1 1024 .00001	; REVERSE PERCUSSIVE - EXPONENTIAL SEGMENTS

i 1 0 3600		;INSTRUMENT 1 PLAYS FOR 1 HOUR (ALSO KEEPS PERFORMANCE GOING)
</CsScore>

</CsoundSynthesizer>