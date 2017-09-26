grain.csd
Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-odac -M0 -+rtmidi=virtual -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM SOUND INTENSITY LEVEL REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;		LABEL   | WIDTH | HEIGHT | X | Y
	FLpanel	"grain",   500,    800,   0,  0
;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ihCloudEnv	 	FLbox  	"", 	6,        9,    15,   496,    70,    2, 630	;GRAIN CLOUD ENVELOPE
ihReverb	 	FLbox  	"", 	6,        9,    15,   496,    70,    2, 700	;REVERB

;SWITCHES                       							ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff			FLbutton	"On/Off(MIDI)",				1,    0,    22,    140,     25,    5,  5,    0,      1,      0,      -1
gkgrnd,ihgrnd			FLbutton	"Pointer Random/Static",		1,    0,    22,    180,     25,  315,  5,   -1
gkMIDIToPch, ihMIDIToPch	FLbutton	"MIDI to Pitch",			1,    0,     2,    170,     20,  290,555,   -1
gkMIDIToDens, ihMIDIToDens	FLbutton	"MIDI to Density",			1,    0,     2,    170,     20,  290,575,   -1
FLsetColor2	100, 100, 255, ihMIDIToPch	;SET SECONDARY COLOUR TO BLUE
FLsetColor2	100, 100, 255, ihMIDIToDens	;SET SECONDARY COLOUR TO BLUE
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihgrnd		;SET SECONDARY COLOUR TO YELLOW

;NUMBER DISPLAY BOXES		WIDTH | HEIGHT | X | Y
idamp	  FLvalue   " ",     	80,       20,    5,  75
iddur	  FLvalue   " ",     	80,       20,    5, 125
idratio	  FLvalue   " ",     	80,       20,    5, 175
idcps	  FLvalue   " ",     	80,       20,    5, 225
idfmd	  FLvalue   " ",     	80,       20,    5, 275
iddens	  FLvalue   " ",     	80,       20,    5, 325
idampoff  FLvalue   " ",     	80,       20,    5, 425
idAtt	  FLvalue   " ",     	60,       20,    5, 675
idRel	  FLvalue   " ",     	60,       20,  255, 675

;SLIDERS									MIN     |  MAX  | EXP | TYPE |   DISP   | WIDTH | HEIGHT | X   | Y
gkamp, ihamp		FLslider	"Amplitude",    			0,           1,    0,    23,     idamp,     490,     25,    5,    50
gkdur, gihdur		FLslider	"Grain Duration (ms.) CC#1",		0.001,       1,    0,    23,     iddur,     490,     25,    5,   100
gkratio, gihratio	FLslider	"Pitch Ratio (SOUND FILE INPUT) CC#2",	0.125,      4,    0,    23,     idratio,   490,     25,    5,   150
gkcps, gihcps		FLslider	"Pitch CPS (WAVEFORM INPUT) CC#3",	1,        5000,    0,    23,     idcps,     490,     25,    5,   200
gkfmd, ihfmd		FLslider	"Pitch Randomization",			0,          .3,    0,    23,     idfmd,     490,     25,    5,   250
gkdens, gihdens		FLslider	"Density CC#4",				1,         500,    0,    23,     iddens,    490,     25,    5,   300
gkDensRnd,ihDensRnd	FLslider	"Density Randomize Amount",		0,          10,    0,    23,     -1,        490,     25,    5,   350
gkampoff,ihampoff	FLslider	"Amplitude Offset",			0,           1,    0,    23,     idampoff,  490,     25,    5,   400
gkAtt,ihAtt		FLslider	"Attack Time",				0.05,       10,    0,    23,     idAtt,     240,     25,    5,   650
gkRel,ihRel		FLslider	"Release",				0.05,       10,    0,    23,     idRel,     240,     25,  255,   650
gkRvbAmt,ihRvbAmt	FLslider	"Level",				0,           1,    0,    23,     -1,        240,     25,    5,   720
gkRvbSize,ihRvbSize	FLslider	"Size",					0,           1,    0,    23,     -1,        240,     25,  255,   720


;COUNTERS				     		MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkwfn, ihwfn		FLcount  "Grain Envelope", 	1,      6,    1,     100,     2,    166,     25,   166,455,   -1 
gksfn, ihsfn		FLcount  "Sound File Input", 	1,      5,    1,     100,     2,    150,     25,    50,555,   -1 

;TEXT BOXES              																																TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y 
ih		 FLbox  "Grain Envelopes: 1 - Hanning . 2 - Percussive (straight segments) . 3 - Percussive (exponential segments) . 4 - Gate (with anti click ramp up and ramp down) . 5 - Reverse Percussive (straight segments) . 6 - Reverse Percussive (exponential segments)", 	1,      1,      12,    500,     30,    0, 505
ih		 FLbox  "Wave Input: 1-Voice . 2-Drum Loop . 3-Classical Guitar . 4-Sine . 5-Buzz", 																							1,      1,      12,    250,     30,    0, 595
ih		 FLbox  "Grain Cloud Envelope", 																													1,      3,      12,    130,     15,    5, 631
ih		 FLbox  "Reverb", 																															1,      3,      12,     45,     15,    5, 701

;INITIAL VALUES OF SLIDERS
;OPCODE		VALUE | HANDLE
FLsetVal_i   	0.05, 	ihamp
FLsetVal_i   	.25, 	gihdur
FLsetVal_i   	1, 	gihratio
FLsetVal_i   	cpsoct(8),gihcps
FLsetVal_i   	0, 	ihfmd
FLsetVal_i   	20, 	gihdens
FLsetVal_i   	0, 	ihampoff
FLsetVal_i   	1, 	ihwfn
FLsetVal_i   	1, 	ihsfn
FLsetVal_i   	0.05, 	ihAtt
FLsetVal_i   	0.05, 	ihRel
FLsetVal_i   	0.1, 	ihRvbAmt
FLsetVal_i   	0.85, 	ihRvbSize

	FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 500, 512, 0

;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           grain                             ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"'grain' is an opcode for the creation of granular synthesis  ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"clouds of sound. 'grain' does not offer precise control of   ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"where grains are read from in the source function table as   ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"other opcodes do so it is less suited to time stretching or  ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"or time compression tasks. Instead the grain pointer is      ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"either static or random across the duration of the input     ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"table - this option can be defined using the on-screen FLTK  ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"button.                                                      ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"'grain' works well for granular synthesis based on a single  ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"cycle waveforms and in fact 'grain' offers some options not  ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"available with 'grain2' or 'grain3' such as amplitude        ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"randomness offset. (grain has a different author to grain2   ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"and grain3.)                                                 ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"This example implements many of the feature of the grain3    ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"example, the key difference is the inclusion of single cycle ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"waveforms as source inputs (4 = a sine wave, 5 = a 'buzz'    ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"waveform). If a sound file is chosen as input grain's pitch  ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"input is defined using the 'Pitch CPS' slider (or MIDI note  ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"if this option has been selected). If a single cycle waveform", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"has been chosen then pitch is define using the 'Pitch Ratio' ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"slider.                                                      ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"Some FLTK sliders are also controllable using MIDI           ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"controllers. Details are given on the GUI labels.            ", 	1,      5,     14,    490,    20,     5, 480
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
;              		NUM | INIT_TIME | SIZE | GEN_ROUTINE | FILE_PATH          | IN_SKIP | FORMAT | CHANNEL
gifile1L 	ftgen 	0,        0,     524288,       1,    "AndItsAll.wav",          0,        4,        1 
gifile2L	ftgen 	0,        0,     524288,       1,    "loop.wav",               0,        4,        1 
gifile3L	ftgen 	0,        0,     1048576,      1,    "ClassicalGuitar.wav",    0,        4,        1 

gifile1R	ftgen	0,        0,     524288,       1,    "AndItsAll.wav",          0,        4,        1 ;MONO FILE SO USE LEFT CHANNEL AGAIN
gifile2R	ftgen	0,        0,     524288,       1,    "loop.wav",               0,        4,        1 ;MONO FILE SO USE LEFT CHANNEL AGAIN
gifile3R	ftgen	0,        0,     1048576,      1,    "ClassicalGuitar.wav",    0,        4,        2 ;STEREO FILE SO USE RIGHT CHANNEL

gisine		ftgen	0,        0,     4096,         10,    1			;SINE WAVE
gibuzz		ftgen	0,        0,     2048,         11,    30, 1, 0.8	;BUZZ WAVEFORM

giratio		ftgen	0,        0,     4096,         -16,   0.125, 1024, 4, 4
gicps		ftgen	0,        0,     4096,         -16,   50,    1024, 4, 2000

;GRAIN ENVELOPE WINDOW FUNCTION TABLES:
giwfn1	ftgen	0,  0, 512,  20, 2				; HANNING WINDOW
giwfn2	ftgen	0,  0, 512,  7, 0, 12, 1, 500, 0		; PERCUSSIVE - STRAIGHT SEGMENTS
giwfn3	ftgen	0,  0, 512,  5, 0.001, 12, 1, 500, 0.001	; PERCUSSIVE - EXPONENTIAL SEGMENTS
giwfn4	ftgen	0,  0, 512,  7, 0, 6, 1, 500, 1, 6, 0		; GATE - WITH ANTI-CLICK RAMP UP AND RAMP DOWN SEGMENTS
giwfn5	ftgen	0,  0, 512,  7, 0, 500, 1, 12, 0		; REVERSE PERCUSSIVE - STRAIGHT SEGMENTS
giwfn6	ftgen	0,  0, 512,  5, 0.001, 500, 1, 12, 0.001	; REVERSE PERCUSSIVE - EXPONENTIAL SEGMENTS

gaRvbSendL	init	0
gaRvbSendR	init	0

instr	1
	kporttime	linseg	0,0.001,0.1			;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A SET VALUE	

	iMIDIActiveValue	=	1		;IF MIDI ACTIVATED
	iMIDIflag		=	0		;IF FLTK ACTIVATED
	mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 
	icps	cpsmidi					;READ MIDI PITCH VALUES - THIS VALUE CAN BE MAPPED TO GRAIN DENSITY AND/OR PITCH DEPENDING ON THE SETTING OF THE MIDI MAPPING SWITCHES

	if	gkOnOff=0&&iMIDIflag=0	then 	;SENSE FLTK ON/OFF SWITCH & CHECK THIS ISN'T A MIDI NOTE
				turnoff		;TURNOFF THIS INSTRUMENT IMMEDIATELY
	endif					;END OF THIS CONDITIONAL BRANCH
	
	if iMIDIflag=1&&gkMIDIToPch=1 then	;IF THIS IS A MIDI ACTIVATED NOTE AND MIDI-TO-PITCH SWITCH IS ON... 
		kratio	=	icps/cpsoct(8)	;MAP TO MIDI NOTE VALUE TO RATIO VALUE (CONVERT TO RATIO: MIDDLE C IS POINT OF UNISON)
		kcps	=	icps		;MAP MIDI NOTE VALUE TO CPS VALUE
	else					;OTHERWISE...
		kratio	portk	gkratio, kporttime	;RATIO VALUE TAKEN FROM FLTK SLIDER
		kcps	portk	gkcps, kporttime	;CPS VALUE TAKEN FROM FLTK SLIDER
	endif					;END OF THIS CONDITIONAL BRANCH

	if iMIDIflag=1&&gkMIDIToDens=1 then	;IF THIS IS A MIDI ACTIVATED NOTE AND MIDI-TO-DENSITY SWITCH IS ON... 
		kdens	=	icps		;MAP TO MIDI NOTE VALUE TO GRAIN DENSITY
	else					;OTHERWISE...
		kdens	portk	gkdens, kporttime	;PORTAMENTO IS APPLIED TO SMOOTH VALUE CHANGES VIA THE FLTK SLIDERS
	endif					;END OF THIS CONDITIONAL BRANCH

	kSwitch		changed	gkwfn, gksfn, gkgrnd
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	START			;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif
	START:

	isfnL 		= 	gifile1L + i(gksfn) - 1	;SOURCE SOUND/WAVEFORM FUNCTION TABLE
	isfnR 		= 	gifile1R + i(gksfn) - 1	;SOURCE SOUND/WAVEFORM FUNCTION TABLE
	if i(gksfn)=4 then
	  isfnL = gisine
	  isfnR = isfnL
	elseif i(gksfn)=5 then
	  isfnL = gibuzz
	  isfnR = isfnL
	endif
	iwfn		=	giwfn1 + i(gkwfn) - 1

	kDensRnd 	exprand gkDensRnd			;CREATE A RANDOM OFFSET FACTOR THAT WILL BE APPLIED TO FOR DENSITY
	kdens		=	kdens * (1 + kDensRnd)		;DENSITY VALUE IS OFFSET BY RANDOM FACTOR
	imgdur	=	1	;MAXIMUM GRAIN DURATION

	if gksfn<=3 then	;IF INPUT TABLE FOR GRAINS IS A SOUND FILE...
	  kpitch 		= 	(sr*kratio)/ftlen(isfnL)
	else			;OTHERWISE (WAVEFORM)...
	  kpitch 	= 	kcps
	endif

	;THE AMPLITUDE OFFSET PARAMETER IS MODIFIED TO WHAT I THINK IS A SLIGHTLY MORE USEFUL ARRANGEMENT 
	aSigL	grain 	gkamp, kpitch, kdens, -(gkampoff*gkamp), gkfmd, gkdur, isfnL, iwfn, imgdur , i(gkgrnd)
	aSigR	grain 	gkamp, kpitch, kdens, -(gkampoff*gkamp), gkfmd, gkdur, isfnR, iwfn, imgdur , i(gkgrnd)

	rireturn	;RETURN TO PERFORMANCE TIME PASSES
	aenv	expsegr	0.0001,i(gkAtt),1,i(gkRel),0.0001	;CLOUD AMPLITUDE ENVELOPE
	aSigL	=	aSigL * aenv				;SCALE AUDIO SIGNAL WITH FLTK AMPLITUDE SLIDER AND GRAIN CLOUD ENVELOPE
	aSigR	=	aSigR * aenv				;SCALE AUDIO SIGNAL WITH FLTK AMPLITUDE SLIDER AND GRAIN CLOUD ENVELOPE
	garecL	=	garecL + aSigL				;ADD GRANULAR SYNTHESIS SIGNAL TO GLOBAL AUDIO RECORD SIGNAL VARIABLE
	garecR	=	garecR + aSigR				;ADD GRANULAR SYNTHESIS SIGNAL TO GLOBAL AUDIO RECORD SIGNAL VARIABLE
	gaRvbSendL	=	gaRvbSendL + (aSigL*gkRvbAmt)	;ADD TO REVERB SEND VARIABLE (LEFT CHANNEL)
	gaRvbSendR	=	gaRvbSendR + (aSigR*gkRvbAmt)	;ADD TO REVERB SEND VARIABLE (RIGHT CHANNEL)
	outs 		aSigL, aSigR				;SEND AUDIO TO OUTPUTS
endin

instr	2	;REVERB
	aRvbL,aRvbR	reverbsc	gaRvbSendL, gaRvbSendR, gkRvbSize, 10000
			outs		aRvbL, aRvbR
			clear		gaRvbSendL, gaRvbSendR
endin

instr	3	;UPDATE FLTK SLIDERS FROM MIDI CONTROLLER VALUES
        ;MIDI CONTROLLER SYNCHRONISATION
#define CONTROLLER(NAME'NUMBER'MIN'MAX)
        #
        k$NAME          ctrl7           1,$NUMBER,0,1           ;READ MIDI CONTROLLER
        ktrig$NAME      changed         k$NAME                  ;CREATE A TRIGGER PULSE IF MIDI CONTROLLER IS MOVED
        k$NAME          scale           k$NAME, $MAX, $MIN      ;VARIBALE HAS TO BE RESCALED HERE, DOING IT IN THE ctrl7 LINE UPSETS THE WORKING OF THE changed OPCODE ABOVE
        FLsetVal        ktrig$NAME,     k$NAME, gih$NAME                ;UPDATE FLTK VALUATOR IF MIDI CONTROLLER HAS BEEN MOVED
        #
        ;           NAME    NUM  MIN  MAX
        $CONTROLLER(dur  '   1 '0.001' 1)
        $CONTROLLER(ratio'   2 '0.125' 4)
        $CONTROLLER(cps  '   3 '1    '5000)
        $CONTROLLER(dens '   4 '1    '500)
endin

instr	99	;RECORDING INSTRUMENT
	if gkrecord=1	then						;IF 'Record' SWITCH IS ON...
	;	OPCODE	FILENAME         | FORMAT | OUT1  | OUT2 etc...
		fout	"GrainOutput.wav",   8,    garecL, garecR	;AUDIO FILE OUTPUT FORMAT IS 24 BIT. CHANGE IF REQUIRED
	endif								;END OF THIS CONDITIONAL BRANCH
	clear	garecL, garecR						;CLEAR GLOBAL AUDIO RECORD VARIABLES
endin

</CsInstruments>

<CsScore>
i 2 0 3600	;REVERB
i 3 0 3600	;SYNC MIDI AND FLTK
</CsScore>

</CsoundSynthesizer>