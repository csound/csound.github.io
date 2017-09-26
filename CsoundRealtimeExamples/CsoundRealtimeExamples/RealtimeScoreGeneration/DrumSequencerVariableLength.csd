DrumSequencerVariableLength.csd
Written by Iain McCurdy, 2008, updated 2012

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	8	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255,255,255,0,0,0
		FLpanel	" ",1045, 335, 0, 0

;BUTTONS                                             			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE |  I  | STARTTIM | IDUR |  p4
gkOnOff,ihOnOff	FLbutton	"On/Off",				1,    0,     2,    100,     30,    0,  0,    0,     1,      0,       -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
gkRndPitches,ihRndPitches	FLbutton	"Randomize!",		1,    0,     1,    100,     30,  200,  0,   0,      102,     0,       0.001
gkclear,ihclear			FLbutton	"Clear All",		1,    0,     1,    100,     30,  300,  0,   0,      103,     0,       0.001

;COUNTERS						MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | POS_X | POS_Y | IOPCODE
gkTempo,ihTempo 	FLcount		"Tempo",	1,    999,    1,     10,     21,   100,     20,     100,      0,      -1

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	5,        9,    15,    80,    183,     0, 48		;DRAW A BOX AROUND EACH GROUP OF 4 BUTTONS
ih		 	FLbox  	" ", 	5,        9,    15,    80,    183,    80, 48            ;DRAW A BOX AROUND EACH GROUP OF 4 BUTTONS
ih		 	FLbox  	" ", 	5,        9,    15,    80,    183,   160, 48            ;DRAW A BOX AROUND EACH GROUP OF 4 BUTTONS
ih		 	FLbox  	" ", 	5,        9,    15,    80,    183,   240, 48            ;DRAW A BOX AROUND EACH GROUP OF 4 BUTTONS
ih		 	FLbox  	" ", 	5,        9,    15,    80,    183,   320, 48            ;DRAW A BOX AROUND EACH GROUP OF 4 BUTTONS
ih		 	FLbox  	" ", 	5,        9,    15,    80,    183,   400, 48            ;DRAW A BOX AROUND EACH GROUP OF 4 BUTTONS
ih		 	FLbox  	" ", 	5,        9,    15,    80,    183,   480, 48            ;DRAW A BOX AROUND EACH GROUP OF 4 BUTTONS
ih		 	FLbox  	" ", 	5,        9,    15,    80,    183,   560, 48            ;DRAW A BOX AROUND EACH GROUP OF 4 BUTTONS

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Gain",			1,      5,     13,     90,     12,   648,  7
ih		 	FLbox  	"Transpose",		1,      5,     13,     90,     12,   848,  7
ih		 	FLbox  	"Delay (0-0.1 s.)",	1,      5,     13,     90,     12,   948, 30
ih		 	FLbox  	"Cycle Range",		1,      5,     13,     90,     12,   748, 35
ih		 	FLbox  	"1",			1,      5,     13,      4,     12,     4, 35
ih		 	FLbox  	"2",			1,      5,     13,      4,     12,    84, 35
ih		 	FLbox  	"3",			1,      5,     13,      4,     12,   164, 35
ih		 	FLbox  	"4",			1,      5,     13,      4,     12,   244, 35
ih		 	FLbox  	"5",			1,      5,     13,      4,     12,   324, 35
ih		 	FLbox  	"6",			1,      5,     13,      4,     12,   404, 35
ih		 	FLbox  	"7",			1,      5,     13,      4,     12,   484, 35
ih		 	FLbox  	"8",			1,      5,     13,      4,     12,   564, 35

;				            			MIN  | MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gkMasterGain, ihMasterGain	FLslider 	"Master",	0,      1,    0,    3,     -1,   100,      12,  642,  24
gkMasterPch, ihMasterPch	FLslider 	"Master",	0.0625, 8,   -1,    3,     -1,   100,      12,  842,  24
FLsetVal_i	1,ihMasterPch

iy	init	50

#define	ROW(COUNT)	
#
gk$COUNT,gih$COUNT._1	FLbutton	"",			1,    0,      4,     20,     20,      2, iy,  0,     9+$COUNT,    0,        0,     1
gk$COUNT,gih$COUNT._2	FLbutton	"",			1,    0,      4,     20,     20,     22, iy,  0,     9+$COUNT,    0,        0,     2
gk$COUNT,gih$COUNT._3	FLbutton	"",			1,    0,      4,     20,     20,     42, iy,  0,     9+$COUNT,    0,        0,     3
gk$COUNT,gih$COUNT._4	FLbutton	"",			1,    0,      4,     20,     20,     62, iy,  0,     9+$COUNT,    0,        0,     4
gk$COUNT,gih$COUNT._5	FLbutton	"",			1,    0,      4,     20,     20,     82, iy,  0,     9+$COUNT,    0,        0,     5
gk$COUNT,gih$COUNT._6	FLbutton	"",			1,    0,      4,     20,     20,    102, iy,  0,     9+$COUNT,    0,        0,     6
gk$COUNT,gih$COUNT._7	FLbutton	"",			1,    0,      4,     20,     20,    122, iy,  0,     9+$COUNT,    0,        0,     7
gk$COUNT,gih$COUNT._8	FLbutton	"",			1,    0,      4,     20,     20,    142, iy,  0,     9+$COUNT,    0,        0,     8
gk$COUNT,gih$COUNT._9	FLbutton	"",			1,    0,      4,     20,     20,    162, iy,  0,     9+$COUNT,    0,        0,     9
gk$COUNT,gih$COUNT._10	FLbutton	"",			1,    0,      4,     20,     20,    182, iy,  0,     9+$COUNT,    0,        0,    10
gk$COUNT,gih$COUNT._11	FLbutton	"",			1,    0,      4,     20,     20,    202, iy,  0,     9+$COUNT,    0,        0,    11
gk$COUNT,gih$COUNT._12	FLbutton	"",			1,    0,      4,     20,     20,    222, iy,  0,     9+$COUNT,    0,        0,    12
gk$COUNT,gih$COUNT._13	FLbutton	"",			1,    0,      4,     20,     20,    242, iy,  0,     9+$COUNT,    0,        0,    13
gk$COUNT,gih$COUNT._14	FLbutton	"",			1,    0,      4,     20,     20,    262, iy,  0,     9+$COUNT,    0,        0,    14
gk$COUNT,gih$COUNT._15	FLbutton	"",			1,    0,      4,     20,     20,    282, iy,  0,     9+$COUNT,    0,        0,    15
gk$COUNT,gih$COUNT._16	FLbutton	"",			1,    0,      4,     20,     20,    302, iy,  0,     9+$COUNT,    0,        0,    16
gk$COUNT,gih$COUNT._17	FLbutton	"",			1,    0,      4,     20,     20,    322, iy,  0,     9+$COUNT,    0,        0,    17
gk$COUNT,gih$COUNT._18	FLbutton	"",			1,    0,      4,     20,     20,    342, iy,  0,     9+$COUNT,    0,        0,    18
gk$COUNT,gih$COUNT._19	FLbutton	"",			1,    0,      4,     20,     20,    362, iy,  0,     9+$COUNT,    0,        0,    19
gk$COUNT,gih$COUNT._20	FLbutton	"",			1,    0,      4,     20,     20,    382, iy,  0,     9+$COUNT,    0,        0,    20
gk$COUNT,gih$COUNT._21	FLbutton	"",			1,    0,      4,     20,     20,    402, iy,  0,     9+$COUNT,    0,        0,    21
gk$COUNT,gih$COUNT._22	FLbutton	"",			1,    0,      4,     20,     20,    422, iy,  0,     9+$COUNT,    0,        0,    22
gk$COUNT,gih$COUNT._23	FLbutton	"",			1,    0,      4,     20,     20,    442, iy,  0,     9+$COUNT,    0,        0,    23
gk$COUNT,gih$COUNT._24	FLbutton	"",			1,    0,      4,     20,     20,    462, iy,  0,     9+$COUNT,    0,        0,    24
gk$COUNT,gih$COUNT._25	FLbutton	"",			1,    0,      4,     20,     20,    482, iy,  0,     9+$COUNT,    0,        0,    25
gk$COUNT,gih$COUNT._26	FLbutton	"",			1,    0,      4,     20,     20,    502, iy,  0,     9+$COUNT,    0,        0,    26
gk$COUNT,gih$COUNT._27	FLbutton	"",			1,    0,      4,     20,     20,    522, iy,  0,     9+$COUNT,    0,        0,    27
gk$COUNT,gih$COUNT._28	FLbutton	"",			1,    0,      4,     20,     20,    542, iy,  0,     9+$COUNT,    0,        0,    28
gk$COUNT,gih$COUNT._29	FLbutton	"",			1,    0,      4,     20,     20,    562, iy,  0,     9+$COUNT,    0,        0,    29
gk$COUNT,gih$COUNT._30	FLbutton	"",			1,    0,      4,     20,     20,    582, iy,  0,     9+$COUNT,    0,        0,    30
gk$COUNT,gih$COUNT._31	FLbutton	"",			1,    0,      4,     20,     20,    602, iy,  0,     9+$COUNT,    0,        0,    31
gk$COUNT,gih$COUNT._32	FLbutton	"",			1,    0,      4,     20,     20,    622, iy,  0,     9+$COUNT,    0,        0,    32
gk$COUNT.Gain, gih$COUNT.Gain		FLslider 	"",	0,      1,    0,    3,     -1,    100,      12,  642, iy+4
gk$COUNT.Pch, gih$COUNT.Pch		FLslider 	"",	25,   300,    0,    3,     -1,    100,      12,  842, iy+4
gk$COUNT.Dly, gih$COUNT.Dly		FLslider 	"",	0,     .1,    0,    3,     -1,    100,      12,  942, iy+4
;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | POS_X | POS_Y | IOPCODE
gkLen$COUNT,gihLen$COUNT 		FLcount		"",	0,      8, 0.25,      1,     21,    100,     20,     742,    iy,      -1
gkphs$COUNT, gihtimpnt$COUNT		FLslider 	"",	0,      8,    0,      1,     -1,    625,      9,       8,    iy+18
FLsetColor2	0,255,0,gihtimpnt$COUNT

		FLsetVal_i	100, 	gih$COUNT.Pch
		FLsetVal_i	1, 	gih$COUNT.Gain
		FLsetVal_i	8, 	gihLen$COUNT
		iy	=	iy+30
#
FLcolor2	255,0,0
$ROW(1)
$ROW(2)
$ROW(3)
$ROW(4)
$ROW(5)
$ROW(6)

;VALUE DISPLAY BOXES
idRvbSnd	FLvalue	"",      50,    15,     0, 255
idfblvl		FLvalue	"",      50,    15,     0, 285
idfco		FLvalue	"",      50,    15,     0, 315
idDlySnd	FLvalue	"",      50,    15,   240, 255
idDlyFB		FLvalue	"",      50,    15,   240, 285
idb		FLvalue	"",      50,    15,   548, 255
idT30		FLvalue	"",      50,    15,   548, 285
gkRvbSnd, ihRvbSnd	FLslider 	"Reverb Send",		0,        1,   0,    3,     idRvbSnd,   235,    15,     0, 240
gkfblvl, ihfblvl	FLslider 	"Reverb Time",		0,        1,   0,    3,      idfblvl,   235,    15,     0, 270
gkfco, ihfco		FLslider 	"Reverb Filter Cutoff",	20,   20000,   0,    3,        idfco,   235,    15,     0, 300
gkDlySnd, ihDlySnd	FLslider 	"Delay Send",		0,        1,   0,    3,     idDlySnd,   235,    15,   240, 240
gkDlyFB, ihDlyFB	FLslider 	"Delay Feedback",	0,        1,   0,    3,      idDlyFB,   235,    15,   240, 270

gkb, ihb		FLslider 	"HF Loss",		0.001,   20,  -1,    3,          idb,   235,    15,   548, 240
gkT30, ihT30		FLslider 	"Note Duration",	0.05,     8,  -1,    3,        idT30,   235,    15,   548, 270

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"B.C. L",		1,       6,    11,     50,     20,   800, 240
ih		 	FLbox  	"B.C. R",		1,       6,    11,     50,     20,   800, 270
ih		 	FLbox  	"Clamped ",		1,       5,    11,     50,     20,   880, 240
ih		 	FLbox  	"Pivoting",		1,       5,    11,     50,     20,   880, 255
ih		 	FLbox  	"Clamped ",		1,       5,    11,     50,     20,   880, 270
ih		 	FLbox  	"Pivoting",		1,       5,    11,     50,     20,   880, 285

;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | POS_X | POS_Y | IOPCODE
gkDelTim1,ihDelTim1 		FLcount		"Delay L",	1,    32,     1,      1,      2,    100,     18,     240,   300,      -1
gkDelTim2,ihDelTim2 		FLcount		"Delay R",	1,    32,     1,      1,      2,    100,     18,     350,   300,      -1

;GENERAL_TEXT_SETTINGS			isize, ifont, ialign, ired, igreen, iblue
			FLlabel		13,      1,       1,   255,  255,    240		;NUMBERS MADE INVISIBLE

;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkbcL, ihbcL		FLbutBank	12,     1,     2,     25,    30,    850, 240,    -1
gkbcR, ihbcR		FLbutBank	12,     1,     2,     25,    30,    850, 270,    -1

;GENERAL_TEXT_SETTINGS			isize, ifont, ialign, ired, igreen, iblue
			FLlabel		13,      5,      4,   0,      0,     0		;LABELS MADE VISIBLE AGAIN

		FLsetVal_i	0.4, 	ihRvbSnd
		FLsetVal_i	.7, 	ihfblvl
		FLsetVal_i	10000, 	ihfco
		FLsetVal_i	0.2, 	ihDlySnd
		FLsetVal_i	.4, 	ihDlyFB
		FLsetVal_i	12, 	ihDelTim1
		FLsetVal_i	20, 	ihDelTim2
		FLsetVal_i	220, 	ihTempo
		FLsetVal_i	.5, 	ihMasterGain
		FLsetVal_i	1, 	ihb
		FLsetVal_i	2.6, 	ihT30
		FLsetVal_i	0, 	ihbcL
		FLsetVal_i	0, 	ihbcR

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ",1045, 320, 0, 385
;TEXT BOXES																				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                                   Looping Sequencer With Individually Variable Length Loops                                      ", 	1,       5,    14,    1040,    20,    5,   0
ih		 	FLbox  	"----------------------------------------------------------------------------------------------------------------------------------", 	1,       5,    14,    1040,    20,    5,  20
ih		 	FLbox  	"This example expands on the design from the 'Simple Drum Sequencer' example. Besides expanding the basic loop length to 8 beats   ", 	1,       5,    14,    1040,    20,    5,  40
ih		 	FLbox  	"(32 semiquavers) the principle innovation is that the user can shorten the range of the loop for each sound. The moving green bars", 	1,       5,    14,    1040,    20,    5,  60
ih		 	FLbox  	"representing current loop position for each sound should help clarify exactly what is happening. Each beat is divided into four   ", 	1,       5,    14,    1040,    20,    5,  80
ih		 	FLbox  	"semiquavers so that 0.25 in the 'Cycle Length' value represents 1 semiquaver, a value of 1 represents 1 beat.                     ", 	1,       5,    14,    1040,    20,    5, 100
ih		 	FLbox  	"If changes are made to a cycle lengths, these changes will only be applied in the code whenever the phrase loops back to the      ", 	1,       5,    14,    1040,    20,    5, 120
ih		 	FLbox  	"beginning. This is done in order to retain rhythmic coherence whenever changes are made to phrase length.                         ", 	1,       5,    14,    1040,    20,    5, 140
ih		 	FLbox  	"Notes that are outside the range of the loop for that sound will not be played.                                                   ", 	1,       5,    14,    1040,    20,    5, 160
ih		 	FLbox  	"The sounds produced are kalimba-like sounds produced using Stefan Bilbao's 'barmodel' physical model. The pitch of each of the six", 	1,       5,    14,    1040,    20,    5, 180
ih		 	FLbox  	"sounds can be modified using the transpose sliders, they can be randomised on mass using the 'Randomize!' button and are in fact  ", 	1,       5,    14,    1040,    20,    5, 200
ih		 	FLbox  	"randomised automatically upon startup.                                                                                            ", 	1,       5,    14,    1040,    20,    5, 220
ih		 	FLbox  	"The 'Delay' sliders allow each sound to be individually delayed by a small amount with respect to the others. This is intended to ", 	1,       5,    14,    1040,    20,    5, 240
ih		 	FLbox  	"allow the creation of 'flam'-like gestures.                                                                                       ", 	1,       5,    14,    1040,    20,    5, 260
ih		 	FLbox  	"A reverb effect (making use of the 'reverbsc' opcode) is included.                                                                ", 	1,       5,    14,    1040,    20,    5, 280
ih		 	FLbox  	"A tempo synced delay effect is also included. Reverb times for the left and right channel are defined separately in semiquavers.  ", 	1,       5,    14,    1040,    20,    5, 300

				FLpanel_end

		FLrun		;RUN THE WIDGET THREAD!

zakinit	8,8		;INITIALISE ZAK SPACE (8 A-RATE, 8 K-RATE)
giRvbSndChn	=	1	;ZAK CHANNEL NUMBER USED FOR REVERB SEND
giDlySndChn	=	3	;ZAK CHANNEL NUMBER USED FOR REVERB SEND

gisine	ftgen	0,0,4096,10,1

seed	0

;BLANK FUNCTION TABLE FOR STORAGE OF SEQUENCE DATA
giblank		ftgen		0,0,256,-2,	0,	0.25,	0.001,	0,\
						0,	0.5,	0.001,	0,\
						0,	0.75,	0.001,	0,\
						0,	1,	0.001,	0,\
						0,	1.25,	0.001,	0,\
						0,	1.5,	0.001,	0,\
						0,	1.75,	0.001,	0,\
						0,	2,	0.001,	0,\
						0,	2.25,	0.001,	0,\
						0,	2.5,	0.001,	0,\
						0,	2.75,	0.001,	0,\
						0,	3,	0.001,	0,\
						0,	3.25,	0.001,	0,\
						0,	3.5,	0.001,	0,\
						0,	3.75,	0.001,	0,\
						0,	4,	0.001,	0,\
						0,	4.25,	0.001,	0,\
						0,	4.5,	0.001,	0,\
						0,	4.75,	0.001,	0,\
						0,	5,	0.001,	0,\
						0,	5.25,	0.001,	0,\
						0,	5.5,	0.001,	0,\
						0,	5.75,	0.001,	0,\
						0,	6,	0.001,	0,\
						0,	6.25,	0.001,	0,\
						0,	6.5,	0.001,	0,\
						0,	6.75,	0.001,	0,\
						0,	7,	0.001,	0,\
						0,	7.25,	0.001,	0,\
						0,	7.5,	0.001,	0,\
						0,	7.75,	0.001,	0,\
						0,	8,	0.001,	0,\
						-1,	8,	-1,	-1

gi1		ftgen		0,0,256,-2,0	;EMPTY TABLES INITIALLY. CONTENTS WILL BE COPIED FROM TABLE giblank
gi2		ftgen		0,0,256,-2,0	;EMPTY TABLES INITIALLY. CONTENTS WILL BE COPIED FROM TABLE giblank
gi3		ftgen		0,0,256,-2,0	;EMPTY TABLES INITIALLY. CONTENTS WILL BE COPIED FROM TABLE giblank
gi4		ftgen		0,0,256,-2,0	;EMPTY TABLES INITIALLY. CONTENTS WILL BE COPIED FROM TABLE giblank
gi5		ftgen		0,0,256,-2,0	;EMPTY TABLES INITIALLY. CONTENTS WILL BE COPIED FROM TABLE giblank
gi6		ftgen		0,0,256,-2,0	;EMPTY TABLES INITIALLY. CONTENTS WILL BE COPIED FROM TABLE giblank

;copy table giblank to all other tables and set random initial values for some valuators (performed once at the beginning of the performance)
tableicopy gi1, giblank
tableicopy gi2, giblank
tableicopy gi3, giblank
tableicopy gi4, giblank
tableicopy gi5, giblank
tableicopy gi6, giblank

instr	1	; NOTE TRIGGERING INSTRUMENT
	if	gkOnOff=0	then		;if note on/off button is off...
		turnoff				;turn this instrument off
	endif					;end of conditional
	kTempoRatio	=	gkTempo/60	;tempo in beats per second
	
	kp1		init	0		;initialise value outputs from timedseq
	kp2		init	0
	kp3		init	0
	kp4		init	0
#define	LOOP(COUNT)	
	#
	kLen$COUNT	init	i(gkLen$COUNT)			;local phrase length for this row initialised when note begins 
	kphs$COUNT    	phasor  (kTempoRatio)/kLen$COUNT	;create a moving phase pointer in the range 0 - 1
	kphs$COUNT.old	init	0				;initialise phase value from previous k-rate interation (needed for first comparison in the next line)
	if kphs$COUNT<kphs$COUNT.old then			;if phase has just reset to the beginning...
	 kLen$COUNT	=	gkLen$COUNT			;assign global phrase length value to the local phrase length version (but only when phrase pointer is at the beginning, this ensures rhythmic coherence when phrase lengths are changed)
	endif
	kphs$COUNT.old	=	kphs$COUNT			;create phase value from previous k-rate iteration which will be used in the next iteration
	gktimpnt$COUNT 	=        kphs$COUNT * kLen$COUNT	;scale phase pointer according to the phrase length for this row
	ktrig   timedseq gktimpnt$COUNT,gi$COUNT, kp1, kp2,kp3, kp4	;read triggers from table for this row
	;	schedkwhen ktrigger, kmintim, kmaxnum, kinsnum,    kwhen,       kdur
		schedkwhen ktrig,       0,        0,   p1+$COUNT,  gk$COUNT.Dly, kp3	;generate a note (if a trigger / '1' value) is met
	#
	
	;expand macro for each row
	$LOOP(1)
	$LOOP(2)
	$LOOP(3)
	$LOOP(4)
	$LOOP(5)
	$LOOP(6)
endin

#define	KALIMBA(I'COUNT)
	#
instr	$I
	p3	=	i(gkT30)	;DEFINE DURATION FOR THIS SOUND
	ivel	random	0.2,1
	ib	=	i(gkb)	;high frequency loss
	ibcL	=	i(gkbcL)+1
	ibcR	=	i(gkbcR)+1	
	asig 	barmodel	ibcL, ibcR, i(gk$COUNT.Pch)*i(gkMasterPch), ib, 0, p3, 0.5, 1000*ivel, 0.07	;KALIMBA SOUND CREATED USING barmodel OPCODE (SEE CSOUND MANUAL FOR MORE INFO.)
	asigL	=	asig*i(gk$COUNT.Gain)*i(gkMasterGain)*2	;DEFINE LEFT CHANNEL AUDIO
	asigR	=	asig*i(gk$COUNT.Gain)*i(gkMasterGain)*2	;DEFINE RIGHT CHANNEL AUDIO
		outs	asigL, asigR 	;SEND AUDIO TO OUTPUTS
	zawm	asigL*gkRvbSnd, giRvbSndChn
	zawm	asigR*gkRvbSnd, giRvbSndChn+1
	zawm	asigL*gkDlySnd, giDlySndChn
	zawm	asigR*gkDlySnd, giDlySndChn+1
endin
	#	

$KALIMBA(2'1)
$KALIMBA(3'2)
$KALIMBA(4'3)
$KALIMBA(5'4)
$KALIMBA(6'5)
$KALIMBA(7'6)

;;;	WRITE CHANGED FL-GRID VALUES TO TABLE
#define	WRITE_VAL(I'COUNT)
#
instr	$I
	tableiw	i(gk$COUNT), ((p4-1)*4)+3, gi$COUNT 	
endin
#

$WRITE_VAL(10'1)
$WRITE_VAL(11'2)
$WRITE_VAL(12'3)
$WRITE_VAL(13'4)
$WRITE_VAL(14'5)
$WRITE_VAL(15'6)


instr	102	;RANDOMISE SLIDERS
#define	RANDOMIZE_SLIDERS(COUNT)
	#
	iPch$COUNT	random		25,300		;DEFINE RANDOM INITIAL VALUES FOR 'TRANSPOSE' SLIDERS
	FLsetVal_i	iPch$COUNT, gih$COUNT.Pch	;SEND RANDOM 'TRANSPOSE' VALUES TO SLIDERS
	iLen$COUNT.Dec	random		1,3						;DEFINE RANDOM INITIAL VALUES FOR 'RANGE' COUNTERS
	iLen$COUNT.Int	random		4,8                                     	;DEFINE RANDOM INITIAL VALUES FOR 'RANGE' COUNTERS
	iLen$COUNT		=		(int(iLen$COUNT.Dec)*0.5)+int(iLen$COUNT.Int)	;DEFINE RANDOM INITIAL VALUES FOR 'RANGE' COUNTERS
	FLsetVal_i	iLen$COUNT, gihLen$COUNT				;SEND RANDOM 'RANGE' VALUES TO COUNTERS
	iDly$COUNT	random		0, 0.03		;DEFINE RANDOM INITIAL VALUES FOR 'TRANSPOSE' SLIDERS
	FLsetVal_i	iDly$COUNT, gih$COUNT.Dly	;SEND RANDOM 'DELAY' VALUES TO SLIDERS
	#
	$RANDOMIZE_SLIDERS(1)
	$RANDOMIZE_SLIDERS(2)
	$RANDOMIZE_SLIDERS(3)
	$RANDOMIZE_SLIDERS(4)
	$RANDOMIZE_SLIDERS(5)
	$RANDOMIZE_SLIDERS(6)
endin	

instr	103
#define	ResetRow(COUNT)
	#
	FLsetVal_i	0,gih$COUNT._1	
	FLsetVal_i	0,gih$COUNT._2	
	FLsetVal_i	0,gih$COUNT._3	
	FLsetVal_i	0,gih$COUNT._4	
	FLsetVal_i	0,gih$COUNT._5	
	FLsetVal_i	0,gih$COUNT._6	
	FLsetVal_i	0,gih$COUNT._7	
	FLsetVal_i	0,gih$COUNT._8	
	FLsetVal_i	0,gih$COUNT._9	
	FLsetVal_i	0,gih$COUNT._10      
	FLsetVal_i	0,gih$COUNT._11      
	FLsetVal_i	0,gih$COUNT._12      
	FLsetVal_i	0,gih$COUNT._13      
	FLsetVal_i	0,gih$COUNT._14      
	FLsetVal_i	0,gih$COUNT._15      
	FLsetVal_i	0,gih$COUNT._16      
	FLsetVal_i	0,gih$COUNT._17      
	FLsetVal_i	0,gih$COUNT._18      
	FLsetVal_i	0,gih$COUNT._19      
	FLsetVal_i	0,gih$COUNT._20      
	FLsetVal_i	0,gih$COUNT._21      
	FLsetVal_i	0,gih$COUNT._22      
	FLsetVal_i	0,gih$COUNT._23      
	FLsetVal_i	0,gih$COUNT._24      
	FLsetVal_i	0,gih$COUNT._25      
	FLsetVal_i	0,gih$COUNT._26      
	FLsetVal_i	0,gih$COUNT._27      
	FLsetVal_i	0,gih$COUNT._28      
	FLsetVal_i	0,gih$COUNT._29      
	FLsetVal_i	0,gih$COUNT._30      
	FLsetVal_i	0,gih$COUNT._31      
	FLsetVal_i	0,gih$COUNT._32     
	tableicopy gi$COUNT, giblank
	#
	$ResetRow(1)
	$ResetRow(2)
	$ResetRow(3)
	$ResetRow(4)
	$ResetRow(5)
	$ResetRow(6)
endin

instr	998	;DUAL TEMPO DELAY
	aL	zar		giDlySndChn
	aR	zar		giDlySndChn+1
	kSwitch		changed		gkTempo, gkDelTim1, gkDelTim2 	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if		kSwitch=1	then	;IF kSwitch=1, I.E. IF ANY OF THE ABOVE LISTED PARAMETERS HAVE CHANGED...
		reinit		START		;...PERFORM AN I-RATE PASS BEGINNING FROM THE GIVEN LABEL
	endif					;END OF CONDITIONAL BRANCHING
	START:					;A LABEL	
	ideltimL	=	(15*i(gkDelTim1))/i(gkTempo)
	ideltimR	=	(15*i(gkDelTim2))/i(gkTempo)
	abuffer	delayr	ideltimL
	atapL	deltap	ideltimL
		delayw	aL + (atapL*gkDlyFB)
	abuffer	delayr	ideltimR
	atapR	deltap	ideltimR
		delayw	aR + (atapR*gkDlyFB)
	outs	atapL, atapR
endin

instr 	999		;REVERB
	aL	zar		giRvbSndChn
	aR	zar		giRvbSndChn+1
	denorm		aL, aR	;DENORMALIZE BOTH CHANNELS OF AUDIO SIGNAL
	arvbL, arvbR 	reverbsc 	aL, aR, gkfblvl, gkfco, sr;, i(gkpitchm), i(gkskip) 
	outs		arvbL, arvbR
	zacl		1,8
endin
	
instr	1000	;UPDATE LOOP INDICATORS
	ktrigger	metro	20	;IF PERFORMANCE ISSUES ARISE REDUCING THIS VALUE MIGHT HELP
	FLsetVal	ktrigger, gktimpnt1, gihtimpnt1
	FLsetVal	ktrigger, gktimpnt2, gihtimpnt2
	FLsetVal	ktrigger, gktimpnt3, gihtimpnt3
	FLsetVal	ktrigger, gktimpnt4, gihtimpnt4
	FLsetVal	ktrigger, gktimpnt5, gihtimpnt5
	FLsetVal	ktrigger, gktimpnt6, gihtimpnt6
endin

instr	1001	;SET INITIAL PATTERN
	FLsetVal	1,1, gih1_1
	FLsetVal	1,1, gih5_3
	FLsetVal	1,1, gih2_5
	FLsetVal	1,1, gih6_7
	FLsetVal	1,1, gih3_9
	FLsetVal	1,1, gih1_11
	FLsetVal	1,1, gih4_13
	FLsetVal	1,1, gih2_15
	FLsetVal	1,1, gih4_17
	FLsetVal	1,1, gih5_19
	FLsetVal	1,1, gih2_21
	FLsetVal	1,1, gih6_23
	FLsetVal	1,1, gih1_25
	FLsetVal	1,1, gih3_27
	FLsetVal	1,1, gih2_29
	FLsetVal	1,1, gih5_31
endin

</CsInstruments>

<CsScore>
i 102 0 0	;RANDOMISE SLIDERS
i 998 0 3600	;DELAY
i 999 0 3600	;REVERB
i 1000 0 3600	;LOOP INDICATORS
i 1001 0 0.01	;SET INITIAL PATTERN
</CsScore>

</CsoundSynthesizer>