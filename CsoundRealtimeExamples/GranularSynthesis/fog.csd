fog.csd
Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
-odac -M0 -+rtmidi=virtual -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;		LABEL | WIDTH | HEIGHT | X | Y
	FLpanel	"fog",   500,     850,   0,  0
;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ihCloudEnv	 	FLbox  	"", 	6,        9,    15,   496,    70,    2, 775	;GRAIN CLOUD ENVELOPE

;TEXT BOXES              					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y 
ihtmodelabel	 FLbox  "0-Grain-by-Grain  1-Continuous", 	1,     9,      12,   150,     30,    150, 50

;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gktransmode, ihtransmode	FLcount  "Transposition Mode",	0,     1,     1,      1,     2,     140,    25,    155, 5,   -1

;SWITCHES                       						ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff, ihOnOff			FLbutton	"On/Off(MIDI)",		1,    0,    22,    140,     25,    5,  5,    0,      1,      0,      -1
gkMIDIToTrans, ihMIDIToTrans		FLbutton	"MIDI to Transposition",1,    0,    22,    170,     20,  300, 50,   -1
gkMIDIToDens, ihMIDIToDens		FLbutton	"MIDI to Density",	1,    0,    22,    170,     20,  300, 70,   -1
gkTransToUnison, ihTransToUnison	FLbutton	"To Unison",		1,    0,    21,     77,     15,  253,505,    0,      2,      0,      0.01
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	100, 100, 255, ihMIDIToTrans	;SET SECONDARY COLOUR TO BLUE
FLsetColor2	100, 100, 255, ihMIDIToDens	;SET SECONDARY COLOUR TO BLUE

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,       1,   255,   255,   255		;NUMBERS MADE INVISIBLE
;BUTTON BANKS			   			TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkinput,   ihinput			FLbutBank	4,     1,     3,     20,      45,    45, 35,   -1
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN
;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X  |  Y
ih		 	FLbox  	"File:", 		1,       5,    12,     40,     15,    5,   34
ih		 	FLbox  	"Voice ", 		1,       5,    12,     40,     15,   65,   34
ih		 	FLbox  	"Drums ", 		1,       5,    12,     40,     15,   65,   49
ih		 	FLbox  	"Guitar", 		1,       5,    12,     40,     15,   65,   64
ih		 	FLbox   "Grain Cloud Envelope",	1,       3,    12,    130,     15,    5,  776

;NUMBER DISPLAY BOXES		WIDTH | HEIGHT | X | Y
idoct		FLvalue	" ",      70,     20,    5, 455
idtrans		FLvalue	" ",      70,     20,    5, 505
iddur		FLvalue	" ",      70,     20,    5, 555
idris		FLvalue	" ",      60,     20,    5, 605
iddec		FLvalue	" ",      60,     20,  255, 605
idband		FLvalue	" ",      70,     20,    5, 655
idamp		FLvalue	" ",      70,     20,    5, 705
idAtt	  	FLvalue   " ",    60,     17,    5, 825
idRel	 	FLvalue   " ",    60,     17,  255, 825

;SLIDERS					      					MIN | MAX | EXP | TYPE |     DISP   | WIDTH | HEIGHT | X   | Y
gkoct, ihoct		FLslider	"Octaviation Index",  				0,    4,     0,    23,      idoct,     490,     25,    5, 430
gktrans, gihtrans	FLslider	"Transposition Factor",  			-2,   2,     0,    23,      idtrans,   327,     25,    3, 480
gkTransRnd, ihTransRnd	FLslider	"Trans. Random",  				0,    1,     0,    23,      -1,        166,     25,  336, 480
gkdur, ihdur		FLslider	"Grain Duration",  				.01,  2,    -1,    23,      iddur,     490,     25,    5, 530
gkris, ihris		FLslider	"Grain Rise Time",  				.001, .2,    0,    23,      idris,     240,     25,    5, 580
gkdec, ihdec		FLslider	"Grain Decay Time",  				.001, .2,    0,    23,      iddec,     240,     25,  255, 580
gkband, ihband		FLslider	"Bandwidth (Grain Exponential Decay)",  	0,    100,   0,    23,      idband,    490,     25,    5, 630
gkamp, ihamp		FLslider	"Amplitude",  					0,    1,     0,    23,      idamp,     490,     25,    5, 680
gkporttime,ihporttime	FLslider 	"Portamento Amount",				0,    1,     0,    23,      -1,        190,     15,  305,  10
gkPtrRnd,ihPtrRnd	FLslider 	"Pointer Randomness",				0,    1,     0,    23,      -1,        160,     25,    3, 730
gkDensRnd,ihDensRnd	FLslider 	"Density Randomness",				0,    3,     0,    23,      -1,        160,     25,  169, 730
gkBwRnd,ihBwRnd		FLslider 	"Bandwidth Randomness",				0,    3,     0,    23,      -1,        160,     25,  336, 730
gkAtt,ihAtt		FLslider	"Attack Time",					0.05,10,     0,    23,      idAtt,     240,     25,    5, 800
gkRel,ihRel		FLslider	"Release",					0.05,10,     0,    23,      idRel,     240,     25,  255, 800

;NUMBER DISPLAY BOXES			WIDTH | HEIGHT | X | Y
idfund			FLvalue	"Pointer",70,      20,     5,  380
idform			FLvalue	"Density",70,      20,   425,  380

;XY PANELS								MINX | MAXX | MINY | MAXY | EXPX | EXPY | DISPX | DISPY | WIDTH | HEIGHT | X | Y
gkptr, gkdens, ihptr, ihdens	FLjoy	"X - Pointer  Y - Density",	0,       1,   0.5,    400,    0,    -1,  idfund, idform,   490,    280,    5, 100
FLsetColor2	255, 0, 0, ihptr	;SET SECONDARY COLOUR TO RED
FLsetColor2	255, 0, 0, ihdens	;SET SECONDARY COLOUR TO RED

; INITIALISATION OF SLIDERS
			FLsetVal_i   	0,	ihtransmode
			FLsetVal_i   	.3,	ihptr
			FLsetVal_i   	20,	ihdens
			FLsetVal_i   	0,	ihoct
			FLsetVal_i   	1,	gihtrans
			FLsetVal_i   	.1,	ihdur
			FLsetVal_i   	.01,	ihris
			FLsetVal_i   	.01,	ihdec
			FLsetVal_i   	10,	ihband
			FLsetVal_i   	0.2,	ihamp
			FLsetVal_i	0.1, 	ihporttime
			FLsetVal_i   	0.05, 	ihAtt
			FLsetVal_i   	0.05, 	ihRel

	FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 	515, 700, 512, 0
				FLscroll	515, 700, 0, 0

;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                            fog                              ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"Fog performs granular synthesis upon sound material stored   ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"within a GEN 1 function table using a method that bears many ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"simularities to the fof opcode.                              ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"The amplitude envelope that is applied to each grain is      ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"controlled by a combination of the 'Grain Duration' (kdur),  ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"'Grain Rise Time' (kris), 'Grain Decay Time' (kdec) and      ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"'Bandwidth (Grain Exponential Decay)' (kband). Bandwidth     ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"controls how an exponential curve defined in a separate      ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"function is applied to the decay of each grain.              ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"'Pointer' (aspd) defines the point from within the stored    ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"sound file (range 0-1) that grains will be read.             ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"'Density' (kdens) controls the frequency of grain duration in", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"grains per second.                                           ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"'Transposition Factor' (ktrans) controls the transposition of", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"each grain. 1=no transposition. 2=up one octave. 0.5=down one", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"octave and so on... A minus sign indicates that grains will  ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"be played backwards, the numerical part functions in the same", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"way.                                                         ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"'Transposition Mode' (itmode) is a 2-way switch defining     ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"whether transposition modulation is carried out on a grain by", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"grain basis or continually, even within the duration of a    ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"grain. To appreciate this effect first create a texture with ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"large sparse grains.                                         ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"'Octaviation Index' (koct) is typically zero but as it tends ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"to 1 every other grain is increasingly attenuated. When it is", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"exactly 1 the grain density is effectively halved. From 1 to ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"2 the process is repeated and the density is halved again and", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"so on from 2 to 3 and beyond. This effect is perceived quite ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"differently for dense and sparse textures.                   ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"In this example a controllable amount of portamento is       ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"applied to 'Pointer', 'Transposition Factor' and 'Density' in", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"order to allow smoother changes of their values.             ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"A random factor can be multiplied to the density control to  ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"prevent the tone produced through synchronous reiteration of ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"identical grains. Random factors can simlarly be multiplied  ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"to grain pointer location and bandwidth (the consequence of  ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"which is grain duration).                                    ", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"This instrument can also be activated via MIDI. MIDI pitch   ", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"values can be mapped to grain density and/or to the pitch of ", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"the material contained within the grain. In the latter       ", 	1,      5,     14,    490,    20,     5, 820
ih		 	FLbox  	"mapping option, middle C is the point at which no            ", 	1,      5,     14,    490,    20,     5, 840
ih		 	FLbox  	"transposition occurs. Using MIDI activation, polyphony is    ", 	1,      5,     14,    490,    20,     5, 860
ih		 	FLbox  	"possible.                                                    ", 	1,      5,     14,    490,    20,     5, 880
ih		 	FLbox  	"The attack and release times of an amplitude envelope applied", 	1,      5,     14,    490,    20,     5, 900
ih		 	FLbox  	"to the entire grain cloud can be modulated by the user using ", 	1,      5,     14,    490,    20,     5, 920
ih		 	FLbox  	"two on screen sliders. These controls are probably most      ", 	1,      5,     14,    490,    20,     5, 940
ih		 	FLbox  	"useful when triggering this example via MIDI.                ", 	1,      5,     14,    490,    20,     5, 960
ih		 	FLbox  	"Audio output can be rendered by clicking 'File Open' and then", 	1,      5,     14,    490,    20,     5, 980
ih		 	FLbox  	"activating 'Record'. Recording can be paused and restarted by", 	1,      5,     14,    490,    20,     5,1000
ih		 	FLbox  	"deactivating and reactivating the 'Record' button. Clicking  ", 	1,      5,     14,    490,    20,     5,1020
ih		 	FLbox  	"'File Open' again will clear any previously recorded         ", 	1,      5,     14,    490,    20,     5,1040
ih		 	FLbox  	"material. A 24 bit sound file called 'FogOutput.wav' will", 	1,      5,     14,    490,    20,     5,1060
ih		 	FLbox  	"be created in the default directory for SFDIR.               ", 	1,      5,     14,    490,    20,     5,1080
                                                                                                                                                 
				FLscrollEnd
				FLpanel_end

			FLlabel		13,      1,      1,     0,     0,     0			;FORMAT LABEL
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

; CURVE USED TO FORM ATTACK AND DECAY PORTIONS OF EACH GRAIN
;              NUM | INIT_TIME | SIZE | GEN_ROUTINE |  PARTIAL_NUMBER_1 | STRENGTH_1 | PHASE_1 | DC_OFFSET_1
giattdec ftgen  0,        0,     524288,     19,             0.5,             0.5,        270,         0.5	; I.E. A RISING SIGMOID

instr	1
	kporttime	linseg	0,0.001,1	;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A SET VALUE	
	kporttime	=		kporttime * gkporttime	;FLTK SLIDER FOR PORTAMENTO TIME MULTIPLIED TO kporttime FUNCTION
	iMIDIActiveValue	=	1		;IF MIDI ACTIVATED
	iMIDIflag		=	0		;IF FLTK ACTIVATED
	mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 
	icps	cpsmidi		;READ MIDI PITCH VALUES - THIS VALUE CAN BE MAPPED TO GRAIN DENSITY AND/OR PITCH DEPENDING ON THE SETTING OF THE MIDI MAPPING SWITCHES
	if	gkOnOff=0&&iMIDIflag=0	then ;SENSE FLTK ON/OFF SWITCH & WHETHER THIS IS A MIDI NOTE ITS STATUS WILL BE IGNORED
				turnoff	;TURNOFF THIS INSTRUMENT IMMEDIATELY
	endif

	if iMIDIflag=1&&gkMIDIToTrans=1 then		;IF THIS IS A MIDI ACTIVATED NOTE AND MIDI-TO-PITCH SWITCH IS ON... 
		ktrans	=	icps/cpsoct(8)		;MAP TO MIDI NOTE VALUE TO PITCH (CONVERT TO RATIO: MIDDLE C IS POINT OF UNISON)
	else					;OTHERWISE...
		ktrans		portk	gktrans, kporttime	;USE THE FLTK SLIDER VALUE
	endif					;END OF THIS CONDITIONAL BRANCH

	if iMIDIflag=1&&gkMIDIToDens=1 then		;IF THIS IS A MIDI ACTIVATED NOTE AND MIDI-TO-PITCH SWITCH IS ON... 
		kdens	=	icps		;MAP TO MIDI NOTE VALUE TO GRAIN DENSITY
	else					;OTHERWISE...
		kdens		portk	gkdens,  kporttime	;PORTAMENTO IS APPLIED TO SMOOTH VALUE CHANGES VIA THE FLTK SLIDERS
	endif					;END OF THIS CONDITIONAL BRANCH

	kDensRnd	random	0, gkDensRnd	;DENSITY RANDOMNESS FUNCTION
	kdens		=	kdens * (1 + kDensRnd)	;APPLY RANDOMNESS 	
	
	kTransRnd	random	-gkTransRnd,gkTransRnd
	ktrans		=	ktrans * (cpsoct(8+kTransRnd)/cpsoct(8))
	
	kSwitch		changed	gktransmode, gkinput	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	START			;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif
	START:

	ifnSoundFileL	=	gifile1L+i(gkinput)	; FUNCTION TABLE NUMBER OF THE SOUND FILE THAT WILL BE GRANULATED
	ifnSoundFileR	=	gifile1R+i(gkinput)	; FUNCTION TABLE NUMBER OF THE SOUND FILE THAT WILL BE GRANULATED
	ifnRiseDecayShape=	giattdec	; FUNCTION TABLE THAT DEFINES THE SHAPE OF THE ATTACK AND DECAY OF EACH GRAIN
	
	kPtrRnd		random	-gkPtrRnd,gkPtrRnd	;DETERMINE POINTER RANDOM FACTOR
	kptr		=	gkptr + kPtrRnd	;ADD POINTER RANDOM FACTOR
	kptr		wrap	kptr, 0, 1	;WRAP AROUND OUT OF RANGE POINTER VALUES
	kptr		=	kptr * (nsamp(ifnSoundFileL)/ftlen(ifnSoundFileL))	;KPTR VALUE IS RESCALED TO ACCOUNT FOR UNUSED SAMPLES
											;IN THE FUNCTION TABLE
	
	kBwRnd		random	0,gkBwRnd		;DETERMINE BANDWIDTH EANDOM FACTOR
	kband		=	gkband * (1 + kBwRnd)	;BANDWIDTH RANDOM FACTOR IS APPLIED

	iNumOverLaps	=	2000	; MAXIMUM NUMBER OF OVERLAPS (OVERESTIMATATION IS A GOOD IDEA HERE TO PREVENT CRASHES)
	
	itotdur		=	3600	; JUST PUT A LARGE NUMBER HERE FOR REAL TIME - FOR NON-REAL TIME GIVE IT p3
	
	kptr		portk	kptr,    kporttime      ;PORTAMENTO IS APPLIED TO SMOOTH VALUE CHANGES VIA THE FLTK SLIDERS
	aptr		interp	kptr			;A NEW A-RATE VARIABLE (aptr) IS CREATED BASE ON kptr
	
	;                                                                                                                               OPTIONAL->
	aL	fog	gkamp, kdens, ktrans, aptr, gkoct, kband, gkris, gkdur, gkdec, iNumOverLaps, ifnSoundFileL, ifnRiseDecayShape, itotdur, 0, i(gktransmode), 1
	aR	fog	gkamp, kdens, ktrans, aptr, gkoct, kband, gkris, gkdur, gkdec, iNumOverLaps, ifnSoundFileR, ifnRiseDecayShape, itotdur, 0, i(gktransmode), 1
	aenv	expsegr	0.0001,i(gkAtt),1,i(gkRel),0.0001	; CLOUD AMPLITUDE ENVELOPE
	rireturn	;RETURN TO PERFORMANCE TIME PASSES
	outs 		aL * aenv, aR * aenv
endin

instr	2	;SETS TRANSPOSITION SLIDER TO UNISON
	FLsetVal_i	1, gihtrans
endin

instr	99	;RECORDING INSTRUMENT
	if gkrecord=1	then	;IF 'Record' switch is on...
	aL,aR	monitor
	;	OPCODE	FILENAME               | FORMAT | OUT1  | OUT2 etc...
		fout	"FogOutput.wav",           8,     aL,      aR; AUDIO FILE OUTPUT FORMAT IS 24 BIT. CHANGE IF REQUIRED
	endif
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT ALLOWS REAL-TIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>