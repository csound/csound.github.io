grain2.csd
Written by Iain McCurdy, 2011

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
	FLpanel	"grain2",500,    760,   0,  0
;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ihCloudEnv	 	FLbox  	"", 	6,        9,    15,   496,     70,    2, 680	;GRAIN CLOUD ENVELOPE

;SWITCHES                       							ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff			FLbutton	"On/Off(MIDI)",				1,    0,    22,    140,     25,    5,  5,    0,      1,      0,      -1
gkoptions1,ihoptions1		FLbutton	"Interpolate Grain Window",		8,    0,    22,    166,     50,    0,400,    0,      1,      0,      -1
gkoptions2,ihoptions2		FLbutton	"Do Not Interpolate Grain Waveform",	4,    0,    22,    166,     50,  166,400,    0,      1,      0,      -1
gkoptions3,ihoptions3		FLbutton	"Continuous Freq. Modulation",		2,    0,    22,    166,     50,  333,400,    0,      1,      0,      -1
gkoptions4,ihoptions4		FLbutton	"Skip Initialisation",			1,    0,    22,    166,     50,    0,450,    0,      1,      0,      -1
gkMIDIToPch, ihMIDIToPch	FLbutton	"MIDI to Pitch",			1,    0,     2,    170,     20,  290,605,   -1
gkMIDIToDens, ihMIDIToDens	FLbutton	"MIDI to Density",			1,    0,     2,    170,     20,  290,625,   -1
FLsetColor2	100, 100, 255, ihMIDIToPch	;SET SECONDARY COLOUR TO BLUE
FLsetColor2	100, 100, 255, ihMIDIToDens	;SET SECONDARY COLOUR TO BLUE
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihoptions1	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihoptions2	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihoptions3	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihoptions4	;SET SECONDARY COLOUR TO YELLOW

;NUMBER DISPLAY BOXES		WIDTH | HEIGHT | X | Y
idamp	  FLvalue   " ",     	80,       20,    5,  75
iddur	  FLvalue   " ",     	80,       20,    5, 125
idratio	  FLvalue   " ",     	80,       20,    5, 175
idcps	  FLvalue   " ",     	80,       20,    5, 225
idfmd	  FLvalue   " ",     	80,       20,    5, 275
idovrlp	  FLvalue   " ",     	80,       20,    5, 325
idfrpow	  FLvalue   " ",     	80,       20,    5, 375
idseed	  FLvalue   " ",     	80,       17,  305,  30
idAtt	  FLvalue   " ",     	60,       20,    5, 725
idRel	  FLvalue   " ",     	60,       20,  255, 725

;SLIDERS										MIN     |    MAX    | EXP | TYPE |   DISP   | WIDTH | HEIGHT | X   | Y
gkamp, ihamp		FLslider	"Amplitude",    				0,                1,   0,    23,     idamp,     490,     25,    5,    50
gkdur, ihdur		FLslider	"Grain Duration (ms.)",				.001,             1,   0,    23,     iddur,     490,     25,    5,   100
gkratio, ihratio	FLslider	"Pitch Ratio (SOUND FILE INPUT)",		0.125,      4,    0,    23,     idratio,   490,     25,    5,   150
gkcps, ihcps		FLslider	"Pitch CPS (WAVEFORM INPUT)",			1,        5000,    0,    23,     idcps,     490,     25,    5,   200
gkfmd, ihfmd		FLslider	"Random Pitch",					0,               .3,   0,    23,     idfmd,     490,     25,    5,   250
gkovrlp, ihovrlp	FLslider	"Number of Overlaps",				1,              200,   0,    23,     idovrlp,   490,     25,    5,   300
gkfrpow, ihfrpow	FLslider	"Distribution of Random Pitch Variation",	-2,               2,   0,    23,     idfrpow,   490,     25,    5,   350
gkseedL,ihseedL		FLslider	"",						0,       2147483646,   0,    23,     idseed,    190,     12,  305,     5
gkseedR,ihseedR		FLslider	"Seed Value L/R",				0,       2147483646,   0,    23,     idseed,    190,     12,  305,    17
gkAtt,ihAtt		FLslider	"Attack Time",					0.05,            10,   0,    23,     idAtt,     240,     25,    5,   700
gkRel,ihRel		FLslider	"Release",					0.05,            10,   0,    23,     idRel,     240,     25,  255,   700

;			FLsetAlign ialign, ihandle
			FLsetAlign 9,      ihseedR	; (BOTTOM RIGHT)

;COUNTERS				     		MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkwfn, ihwfn		FLcount  "Grain Envelope", 	1,      6,    1,     100,     2,    166,     25,   166,505,   -1 
gksfn, ihsfn		FLcount  "Sound File Input", 	1,      5,    1,     100,     2,    150,     25,    50,605,   -1 

;TEXT BOXES              																																TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y 
ih		 FLbox  "Grain Envelopes: 1 - Hanning . 2 - Percussive (straight segments) . 3 - Percussive (exponential segments) . 4 - Gate (with anti click ramp up and ramp down) . 5 - Reverse Percussive (straight segments) . 6 - Reverse Percussive (exponential segments)", 	1,      1,      12,    500,     30,    0, 555
ih		 FLbox  "Wave Input: 1-Voice . 2-Drum Loop . 3-Classical Guitar . 4-Sine . 5-Buzz", 																							1,      1,      12,    250,     30,    0, 645
ih		 FLbox  "Grain Cloud Envelope", 																													1,      3,      12,    130,     15,    5, 681

;INITIAL VALUES OF SLIDERS
;OPCODE		VALUE | HANDLE
FLsetVal_i   	0.25, 	ihamp
FLsetVal_i   	.25, 	ihdur
FLsetVal_i   	1, 	ihratio
FLsetVal_i   	300, 	ihcps
FLsetVal_i   	0, 	ihfmd
FLsetVal_i   	10, 	ihovrlp
FLsetVal_i   	2, 	ihfrpow
FLsetVal_i   	0, 	ihseedL
FLsetVal_i   	0, 	ihseedR
FLsetVal_i   	1, 	ihwfn
FLsetVal_i   	1, 	ihsfn
FLsetVal_i   	0.05, 	ihAtt
FLsetVal_i   	0.05, 	ihRel

	FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 280, 512, 0

;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          grain2                             ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"grain2 is a simpler version of grain3. grain3 offers more    ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"input parameters and greater user control.                   ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"grain2 provides no user control of grain phase (pointer      ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"position), instead initial phase is chosen randomly across   ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"the source function table.                                   ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"Density is defined as the number of overlaps. This is an     ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"i-rate parameter, in this example moving its slider forces   ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"reinitialisations in order to implement the update but this  ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"will inevitably cause discontinuities in the audio output.   ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"If density is thought of as grains per second then increasing", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"'Number of Overlaps' will increase density but reducing      ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"'Grain Duration' will also increase density.                 ", 	1,      5,     14,    490,    20,     5, 260

			FLpanel_end

;RECORD OUTPUT PANEL
		FLpanel	"Record",   300,    35, 512, 755
;BUTTONS                        	LABEL       | ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkfileopen,ihfileopen	FLbutton	"File Open",  1,    0,    21,    140,     25,    5,  5,     0,     99,    0,       -1
gkrecord,ihrecord	FLbutton	"Record",     1,    0,    22,    140,     25,  150,  5,    -1
FLsetColor2	255, 255, 50, ihfileopen	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 50, 50, ihrecord		;SET SECONDARY COLOUR TO RED
FLpanel_end	;END OF PANEL CONTENTS
garecL		init		0	;INITIALIZE RECORD SIGNAL AUDIO VARIABLE LEFT CHANNEL (TO ZERO / SILENCE)
garecR		init		0	;INITIALIZE RECORD SIGNAL AUDIO VARIABLE LEFT CHANNEL (TO ZERO / SILENCE)

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

gisine		ftgen	0,        0,     4096,         10,    1			;SINE WAVE
gibuzz		ftgen	0,        0,     2048,         11,    30, 1, 0.8	;BUZZ WAVEFORM

;GRAIN ENVELOPE WINDOW FUNCTION TABLES:
giwfn1	ftgen	0,  0, 512,  20, 2				; HANNING WINDOW
giwfn2	ftgen	0,  0, 512,  7, 0, 12, 1, 500, 0		; PERCUSSIVE - STRAIGHT SEGMENTS
giwfn3	ftgen	0,  0, 512,  5, 0.001, 12, 1, 500, 0.001	; PERCUSSIVE - EXPONENTIAL SEGMENTS
giwfn4	ftgen	0,  0, 512,  7, 0, 6, 1, 500, 1, 6, 0		; GATE - WITH ANTI-CLICK RAMP UP AND RAMP DOWN SEGMENTS
giwfn5	ftgen	0,  0, 512,  7, 0, 500, 1, 12, 0		; REVERSE PERCUSSIVE - STRAIGHT SEGMENTS
giwfn6	ftgen	0,  0, 512,  5, 0.001, 500, 1, 12, 0.001	; REVERSE PERCUSSIVE - EXPONENTIAL SEGMENTS

initc7	1,0,0.45	;INITIALIZE MIDI CONTROLLER

instr	1
	kporttime	linseg	0,0.001,0.1			;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A SET VALUE	

	iMIDIActiveValue	=	1		;IF MIDI ACTIVATED
	iMIDIflag		=	0		;IF FLTK ACTIVATED
	mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 
	icps	cpsmidi		;READ MIDI PITCH VALUES - THIS VALUE CAN BE MAPPED TO GRAIN DENSITY AND/OR PITCH DEPENDING ON THE SETTING OF THE MIDI MAPPING SWITCHES
	if	gkOnOff=0&&iMIDIflag=0	then		;SENSE FLTK ON/OFF SWITCH & WHETHER THIS IS A MIDI NOTE ITS STATUS WILL BE IGNORED
				turnoff			;TURNOFF THIS INSTRUMENT IMMEDIATELY
	endif						;END OF THIS CONDITIONAL BRANCH

	if iMIDIflag=1&&gkMIDIToPch=1 then		;IF THIS IS A MIDI ACTIVATED NOTE AND MIDI-TO-PITCH SWITCH IS ON... 
		kratio	=	icps/cpsoct(8)		;MAP TO MIDI NOTE VALUE TO RATIO (CONVERT TO RATIO: MIDDLE C IS POINT OF UNISON)
		kcps	=	icps			;MAP TO MIDI NOTE VALUE TO CPS
	else					;OTHERWISE...
		kratio		portk	gkratio, kporttime	;USE THE FLTK SLIDER VALUE
		kcps		portk	gkcps, kporttime	;USE THE FLTK SLIDER VALUE
	endif					;END OF THIS CONDITIONAL BRANCH

	if iMIDIflag=1&&gkMIDIToDens=1 then		;IF THIS IS A MIDI ACTIVATED NOTE AND MIDI-TO-PITCH SWITCH IS ON... 
		gkovrlp	=	icps		;MAP TO MIDI NOTE VALUE TO GRAIN DENSITY
	endif					;END OF THIS CONDITIONAL BRANCH

	kSwitch		changed	gkseedL, gkseedR, gkoptions1, gkoptions2, gkoptions3, gkoptions4, gkwfn, gksfn, gkfrpow, gkseedL, gkseedR, gkovrlp
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	START			;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif

	START:
	imode	=	i(gkoptions1)+i(gkoptions2)+i(gkoptions3)+i(gkoptions4)	;SUM THE MODE BUTTON OUTPUTS

	isfnL 		= 	gifile1L + i(gksfn) - 1	;SOURCE SOUND/WAVEFORM FUNCTION TABLE
	isfnR 		= 	gifile1R + i(gksfn) - 1	;SOURCE SOUND/WAVEFORM FUNCTION TABLE
	if i(gksfn)=4 then
	  isfnL = gisine
	  isfnR = isfnL
	elseif i(gksfn)=5 then
	  isfnL = gibuzz
	  isfnR = isfnL
	endif

	if gksfn<=3 then	;IF INPUT TABLE FOR GRAINS IS A SOUND FILE...
	  kpitch 		= 	(sr*kratio)/ftlen(isfnL)
	  kfmd		=	gkfmd
	else			;OTHERWISE (WAVEFORM)...
	  kpitch 	= 	kcps
	  kfmd		=	gkfmd * kcps
	endif

	iwfn		=	giwfn1 + i(gkwfn) - 1

	aSigL	grain2	kpitch, kfmd, gkdur, i(gkovrlp), isfnL, iwfn , i(gkfrpow), i(gkseedL), imode
	aSigR	grain2	kpitch, kfmd, gkdur, i(gkovrlp), isfnL, iwfn , i(gkfrpow), i(gkseedR), imode

	rireturn	;RETURN TO PERFORMANCE TIME PASSES
	aenv	expsegr	0.0001,i(gkAtt),1,i(gkRel),0.0001	;CLOUD AMPLITUDE ENVELOPE
	aSigL	=	aSigL  * gkamp * aenv			;SCALE AUDIO SIGNAL WITH FLTK AMPLITUDE SLIDER AND GRAIN CLOUD ENVELOPE
	aSigR	=	aSigR  * gkamp * aenv			;SCALE AUDIO SIGNAL WITH FLTK AMPLITUDE SLIDER AND GRAIN CLOUD ENVELOPE
	garecL	=	garecL + aSigL				;ADD GRANULAR SYNTHESIS SIGNAL TO GLOBAL AUDIO RECORD SIGNAL VARIABLE
	garecR	=	garecR + aSigR				;ADD GRANULAR SYNTHESIS SIGNAL TO GLOBAL AUDIO RECORD SIGNAL VARIABLE
	outs 		aSigL, aSigR				;SEND AUDIO TO OUTPUTS
endin

/*
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
*/

instr	99	;RECORDING INSTRUMENT
	if gkrecord=1	then						;IF 'Record' SWITCH IS ON...
	;	OPCODE	FILENAME         | FORMAT | OUT1  | OUT2 etc...
		fout	"grain2.wav",     8,    garecL, garecR	;AUDIO FILE OUTPUT FORMAT IS 24 BIT. CHANGE IF REQUIRED
	endif								;END OF THIS CONDITIONAL BRANCH
	clear	garecL, garecR						;CLEAR GLOBAL AUDIO RECORD VARIABLES
endin

</CsInstruments>

<CsScore>
;i 2 0 3600	;UPDATE FLTK SLIDERS FROM MIDI CONTROLLER VALUES
f 0 3600
</CsScore>

</CsoundSynthesizer>