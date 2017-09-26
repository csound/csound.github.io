;Written by Iain McCurdy, 2006

;THE screverb OPCODE IS PLACED IN A SEPARATE, ALWAYS ON, INSTRUMENT FROM THE SOURCE SOUND PRODUCING INSTRUMENT.
;THE IS A COMMONLY USED TECHNIQUE WITH TIME SMEARING OPCODES AND EFFECTS LIKE REVERBS AND DELAYS.

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	100	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;			LABEL    | WIDTH | HEIGHT | X | Y
FLcolor	255, 255, 255, 0, 0, 0
		FLpanel	"screverb", 500,    350,    0,  0

;                                                      		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,    0,    22,    120,     25,    5,  5,    0,      1,      0,       -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkinput, ihinput		FLbutBank	14,     1,     2,     18,      40,   230, 0,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Input", 		1,       5,    14,     50,      20, 180,   0
ih		 	FLbox  	"Drum Loop", 		1,       5,    14,     75,      20, 250,   0
ih		 	FLbox  	"Live     ", 		1,       5,    14,     75,      20, 250,  20

;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
idfblvl				FLvalue	" ",      80,    20,     5,  75
idfco				FLvalue	" ",      80,    20,     5, 125
idpitchm			FLvalue	" ",      80,    20,     5, 175
idmix				FLvalue	" ",      80,    20,     5, 225
idamp				FLvalue	" ",      80,    20,     5, 275

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkskip, ihskip 			FLcount  "Initialisation 0-On 1-Off", 	0,     1,     1,      1,      2,    150,     25,   345,300,   -1

;SLIDERS					            		MIN |  MAX  | EXP | TYPE | DISP   | WIDTH | HEIGHT | X | Y
gkfblvl, ihfblvl	FLslider 	"Feedback Level",		0,       1,    0,    23,   idfblvl,   490,     25,    5,  50
gkfco, ihfco		FLslider 	"Cutoff Frequency",		20,  20000,   -1,    23,   idfco,     490,     25,    5, 100
gkpitchm, ihpitchm	FLslider 	"Delay Time Modulation",	0,      20,    0,    23,   idpitchm,  490,     25,    5, 150
gkmix, ihmix		FLslider 	"Dry/Wet Mix",			0,       1,    0,    23,   idmix,     490,     25,    5, 200
gkamp, ihamp		FLslider 	"Amplitude",			0,       1,    0,    23,   idamp,     490,     25,    5, 250
gkingain,ihingain	FLslider 	"Live Input Gain",		0,       1,  0,    23,      -1,         140,      20, 350,     5

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	.7, 	ihfblvl
		FLsetVal_i	10000, 	ihfco
		FLsetVal_i	.6, 	ihamp
		FLsetVal_i	1, 	ihpitchm
		FLsetVal_i	.5, 	ihmix

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 560, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           screverb                          ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"screverb is an implementation of an 8 delay line stereo FDN  ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"reverb, with feedback matrix based upon physical modeling    ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"scattering junction of 8 lossless waveguides of equal        ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"characteristic impedance. This opcode is based on a Csound   ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"orchestra version of the described algorithm by Sean         ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"Costello.                                                    ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"Rather than explicity define reverb time, the length of the  ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"reverb tail is defined by a feedback control (range 0 to 1). ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"A value of of 0 here removes the reverb effect and a value of", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"1 creates a reverb effect of infinite duration. The author   ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"of the opcode suggests 0.6 for a small live room sound, 0.8  ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"for a small hall and 0.9 for a large hall.                   ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"First order lowpass filters are placed in the feedback loops ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"of the 8 delays lines, the cutoff frequencies of these are   ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"controllable from a single input argument here represented   ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"by the 'cutoff frequency' slider.                            ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"Optional arguments are for a value defining the expected     ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"sample rate (default=44100), a value defining the amount of  ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"delay time modulation employed (default=1).                  ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"An optional 2-way switch (default=0) is provided, if non-zero", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"initialisation will, whenever possible, be skipped.          ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"In this example a dry/wet crossfader is included.            ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"High settings for feedback can create amplitude build ups so ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"a slider for rescaling amplitude is also included.           ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"In this example the user can choose between a sound file     ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"input or the computer's live input. An input gain control on ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"the live input is also provided.                             ", 	1,      5,     14,    490,    15,     5, 540

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1	;PLAYS FILE AND OUTPUTS GLOBAL VARIABLES
	if gkOnOff=0	then
		turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif
	if	gkinput==0	then	;IF INPUT 'Drum Loop' IS SELECTED...
		gaSigL, gaSigR	diskin2	"808loop.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)		
	else				;OTHERWISE
		aSigL, aSigR	ins	;TAKE INPUT FROM COMPUTER'S AUDIO INPUT
		gaSigL	=	aSigL * gkingain	;SCALE USING 'Input Gain' SLIDER
		gaSigR	=	aSigR * gkingain	;SCALE USING 'Input Gain' SLIDER
	endif						;END OF CONDITIONAL BRANCHING
endin

instr 		2
	denorm		gaSigL, gaSigR	;DENORMALIZE BOTH CHANNELS OF AUDIO SIGNAL
	kSwitch		changed		gkpitchm, gkskip	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then	;IF kSwitch=1 THEN
		reinit	UPDATE		;BEGIN A REINITIALIZATION PASS FROM LABEL 'UPDATE'
	endif				;END OF CONDITIONAL BRANCHING
	UPDATE:				;A LABEL
	arvbL, arvbR 	reverbsc 	gaSigL, gaSigR, gkfblvl, gkfco, sr, i(gkpitchm), i(gkskip) 
	rireturn			;RETURN TO PERFORMANCE TIME PASSES
	amixL		ntrpol		gaSigL, arvbL, gkmix	;CREATE A DRY/WET MIX BETWEEN THE DRY AND THE REVERBERATED SIGNAL
	amixR		ntrpol		gaSigR, arvbR, gkmix	;CREATE A DRY/WET MIX BETWEEN THE DRY AND THE REVERBERATED SIGNAL
			outs		amixL * gkamp, amixR * gkamp
	clear	gaSigL, gaSigR	;CLEAR GLOBAL AUDIO VARIABLES
endin

</CsInstruments>

<CsScore>
;INSTR | START | DURATION
i  2       0       3600	;INSTRUMENT 2 PLAYS A HELD NOTE AND KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>