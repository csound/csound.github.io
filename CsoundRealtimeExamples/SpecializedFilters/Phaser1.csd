phaser1.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -M0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	100	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1
massign		1,3	;ASSIGN MIDI EVENTS ON CHANNEL 1 TO INSTRUMENT 3

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL      | WIDTH | HEIGHT | X | Y
		FLpanel	"phaser1",    500,    250,    0,  0

;SWITCHES						ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"On/Off(MIDI)",		1,    0,    22,   120,     25,     5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW
gkbal,ihbal	FLbutton	"Balance",		1,    0,    22,    120,     25,  375,150,   -1
FLsetColor2	255, 255, 50, ihbal	;SET SECONDARY COLOUR TO YELLOW

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkinput, ihinput		FLbutBank	14,     1,     3,     18,      45,   250, 0,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Input", 		1,       5,    14,     50,      20, 200,   0
ih		 	FLbox  	"Seashore", 		1,       5,    11,     60,      13, 270,   0
ih		 	FLbox  	"Live    ", 		1,       5,    11,     60,      13, 270,  15
ih		 	FLbox  	"Impulses", 		1,       5,    11,     60,      13, 270,  30

;VALUE_DISPLAY_BOXES			WIDTH | HEIGHT | X | Y
idfreq			FLvalue	" ",      80,     20,    5,  75
idfeedback		FLvalue	" ",      80,     20,    5, 125
idoutgain		FLvalue	" ",      80,     20,    5, 225

;COUNTERS						MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkord, ihord	FLcount  "No. of Ordinates (i-rate)",	1,    4999,   1,     10,     1,     150,     25,    5, 150,   -1

;SLIDERS							MIN  |  MAX  | EXP | TYPE |   DISP    | WIDTH | HEIGHT | X | Y
gkfreq, ihfreq		FLslider	"Frequency",  		20,    20000,  -1,    23,   idfreq,      490,     25,    5,  50
gkfeedback, ihfeedback	FLslider	"Feedback",   		-0.999,0.999,   0,    23,   idfeedback,  490,     25,    5, 100
gkoutgain, ihoutgain	FLslider	"Output Gain", 		0.01,      2,  -1,    23,   idoutgain,   490,     25,    5, 200
gkingain,ihingain	FLslider 	"Live Input Gain",	0,         1,   0,    23,   -1,          140,     20,  350,   5

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	550, 	ihfreq
		FLsetVal_i	50,   	ihord
		FLsetVal_i	.5,  	ihfeedback
		FLsetVal_i	1,  	ihoutgain

		FLpanel_end	; END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 620, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          phaser1                            ", 	1,      6,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      6,     14,    490,    20,     5,  20
ih		 	FLbox  	"The phaser1 opcode is an implementation of an algorithm      ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"consisting of a user definable number of first order allpass ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"filters arranged in series.                                  ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"Frequency (kfreq) (in Hz) controls the frequency at which    ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"each filter shifts the phase of its output by 90 degrees.    ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"No. of Ordinates (kord) allows the user to define the number ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"of allpass filter stages present in the algorithm (range: 1 -", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"4999).                                                       ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"Feedback (kfeedback) controls the amount of the signal which ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"is fed back from the output back into the input of the chain ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"of filters. This value should be less than 1 and more than   ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"-1.                                                          ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"To create a 'classic' phaser effect the number of ordinates  ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"should be less than about 8 and the frequency should be      ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"modulated by an LFO.                                         ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"In this example the user can choose between a sound file     ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"input, the computer's live input or a stream of click        ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"impulses. The risk of feedback is greatly increased through  ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"the use of phaser1 processing so for this reason a gain      ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"control on the live input, which is initially zero, is       ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"included. Use with caution! It might actually be better to   ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"monitor through headphones to further reduce the risk of     ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"feedback when using the live input.                          ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"This instrument can also be triggered via MIDI in which case ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"the basic frequency value is dictated by the MIDI ket played.", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"In MIDI mode multiple instances of phaser1 can be triggered  ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"to create chords.                                            ", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"Activating the 'Balance' switch will balance the RMS of the  ", 	1,      5,     14,    490,    15,     5, 560
ih		 	FLbox  	"output with the RMS of the input and can therefore control   ", 	1,      5,     14,    490,    15,     5, 580
ih		 	FLbox  	"unpredictable output amplitude levels.                       ", 	1,      5,     14,    490,    15,     5, 600
				FLpanel_end                                                                                                       

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



instr	3	;INPUT
	if	gkinput==0	then	;IF INPUT 'Seashore' IS SELECTED...
		gasigL, gasigR	diskin2	"Seashore.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)		
	elseif	gkinput==1	then	;IF INPUT 'Live' IS SELECTED...
		asigL, asigR	ins	;TAKE INPUT FROM COMPUTER'S AUDIO INPUT
		gasigL	=	asigL * gkingain	;SCALE USING 'Input Gain' SLIDER
		gasigR	=	asigR * gkingain	;SCALE USING 'Input Gain' SLIDER						;END OF CONDITIONAL BRANCHING
	else	;OTHERWISE...
		kint	rspline	0.01,0.2,0.1,0.5	;INTERVAL BETWEEN IMPULSES IS RANDOMISED SLIGHTLY
		asig	mpulse	4,kint	;GENERATE IMPULSES
		kcfoct	randomi	6,12,2	;GENERATE RANDOM VALUES FOR FILTER CUTOFF FREQUENCY (OCT FORMAT)
		asig	butlp	asig, cpsoct(kcfoct)	;LOWPASS FILTER STREAM OF CLICKS
		kpan	rspline	0,1,0.1,0.3		;RANDOM AUTO-PANNING VALUE
	 	gasigL,gasigR	pan2	asig,kpan	;CREATE STEREO PANNED VERSION
	endif
endin

instr	1	;phaser 1 (MIDI or FLTK) AND OUTPUT
	kporttime	linseg	0,0.01,0.01	; CREATE A VARIABLE THAT WILL BE USED FOR PORTAMENTO TIME
	
	iMIDIActiveValue	=	1		;IF MIDI ACTIVATED
	iMIDIflag		=	0		;IF FLTK ACTIVATED
	mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 

	icps	cpsmidi		;READ MIDI PITCH VALUES - THIS VALUE CAN BE MAPPED TO GRAIN DENSITY AND/OR PITCH DEPENDING ON THE SETTING OF THE MIDI MAPPING SWITCHES

	kMIDIflag	init	iMIDIflag

	if	gkOnOff=0&&kMIDIflag=0	then 	;SENSE FLTK ON/OFF SWITCH & WHETHER THIS IS A MIDI NOTE ITS STATUS WILL BE IGNORED
		turnoff				;TURNOFF THIS INSTRUMENT IMMEDIATELY
	endif					;END OF THIS CONDITIONAL BRANCH

	if kMIDIflag=1 then			;IF THIS IS A MIDI ACTIVATED NOTE...
	 kfreq	=	icps			;MAP MIDI NOTE VALUE TO FREQUENCY
	else					;OTHERWISE...
	 kfreq	portk	gkfreq, kporttime	;SMOOTH MOVEMENT OF SLIDER VARIABLE TO CREATE FREQUENCY
	endif					;END OF THIS CONDITIONAL BRANCH

	if kMIDIflag=1&&gkinput==2 then		;IF THIS IS A MIDI ACTIVATED NOTE AND IMPULSES IS CHOSEN AS THE INPUT SOUND
	 kint	rspline	0.01,0.2,0.1,0.5	;INTERVAL BETWEEN IMPULSES IS RANDOMISED SLIGHTLY
	 asig	mpulse	4,kint			;GENERATE IMPULSES
	 kcfoct	randomi	6,12,2			;GENERATE RANDOM VALUES FOR FILTER CUTOFF FREQUENCY (OCT FORMAT)
	 asig	butlp	asig, cpsoct(kcfoct)	;LOWPASS FILTER STREAM OF CLICKS
	 kpan	rspline	0,1,0.1,0.3		;RANDOM AUTO-PANNING VALUE   
	 asigL,asigR	pan2	asig,kpan	;CREATE STEREO PANNED VERSION
	else					;OTHERWISE USE AUDIO FROM INSTR 3
	 asigL	=	gasigL
	 asigR	=	gasigR
	endif

	kSwitch		changed	gkord	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	UPDATE			;BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE'
	endif
	UPDATE:
	aphaserl	phaser1		asigL, kfreq, gkord, gkfeedback	; PHASER1 IS APPLIED TO THE LEFT CHANNEL
	aphaserr	phaser1		asigR, kfreq, gkord, gkfeedback	; PHASER1 IS APPLIED TO THE RIGHT CHANNEL
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES

	;IF 'Balance' IS ACTIVATED, BALANCE THE OUTPUT SIGNAL WITH THE RMS OF THE INPUT SIGNAL
	if gkbal==1 then
	 aphaserl	balance	aphaserl,asigL
	 aphaserr	balance	aphaserr,asigR
	endif
			outs	aphaserl*gkoutgain, aphaserr*gkoutgain	; PHASER OUTPUT ARE SENT TO THE SPEAKERS
endin
		
</CsInstruments>

<CsScore>
i 3 0 3600	;INSTRUMENT 3 (AUDIO INPUT) PLAYS FOR 1 HOUR AND ALLOWS REAL-TIME PERFORMANCE FOR 1 HOUR
f 0 3600
</CsScore>

</CsoundSynthesizer>