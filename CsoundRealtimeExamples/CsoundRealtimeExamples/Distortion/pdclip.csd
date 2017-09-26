pdclip.csd
Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	16	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	1	;NUMBER OF CHANNELS (1=MONO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SETUP BASIC COLOURS
;			LABEL    | WIDTH | HEIGHT | X | Y
		FLpanel	"pdclip",   500,    370,    0,  0

;SWITCHES  	                                  		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff			FLbutton	"On/Off",	1,    0,    22,    100,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES	LABEL | WIDTH | HEIGHT | X | Y
idfrq      	FLvalue	" ",	 70,      20,    5, 125
idWidth      	FLvalue	" ",	 70,      20,    5, 175
idCenter	FLvalue	" ",	 70,      20,    5, 225
idpostgain	FLvalue	" ",	 70,      20,    5, 340

;            				LABEL           	MIN    | MAX | EXP | TYPE |  DISP      | WIDTH | HEIGHT | X  | Y
gkfrq, ihfrq		FLslider	"Oscillator Freq.",     1,       5000,  -1,    23,   idfrq,        490,    25,     5, 100
gkWidth, ihWidth	FLslider	"Width",        	0,          1,   0,    23,   idWidth,      490,    25,     5, 150
gkCenter,ihCenter	FLslider	"Center",		-1,         1,   0,    23,   idCenter,     490,    25,     5, 200
gkpostgain,ihpostgain	FLslider	"Post Gain",    	0,          5,   0,    23,   idpostgain,   490,    25,     5, 315

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS				 TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkbipolar, ihbipolar	FLbutBank	 13,     1,     2,      18,     40,    5, 256,   -1
gkinput, ihinput	FLbutBank	 13,     1,     4,      18,     80,  250,   6,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Unipolar", 		1,       5,    12,    75,      20,    20, 255
ih		 	FLbox  	"Bipolar ", 		1,       5,    12,    75,      20,    20, 275
ih		 	FLbox  	"Sound File   ", 	1,       5,    12,   100,      20,   270,   5
ih		 	FLbox  	"Sine Wave    ", 	1,       5,    12,   100,      20,   270,  25
ih		 	FLbox  	"Sawtooth Wave", 	1,       5,    12,   100,      20,   270,  45
ih		 	FLbox  	"Triangle     ", 	1,       5,    12,   100,      20,   270,  65

;SET INITIAL VALUES FOR SLIDERS |VALUE | HANDLE
		FLsetVal_i	150,	ihfrq
		FLsetVal_i	0,	ihWidth
		FLsetVal_i	0,	ihCenter
		FLsetVal_i	1,	ihbipolar		
		FLsetVal_i	1,	ihpostgain

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     220,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           pdclip                            ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"'pdclip' clips an audio signal and simultaneously rescales   ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"the signal to maintain the amplitude maximum of the input.   ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"Clipping can be applied in both the positive and negative    ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"domains (bipolar) or in just the positive domain (unipolar). ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"In addition the input signal can be DC offset before clipping", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"('Center' paramter) to produce assymmetric clipping.         ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"Besides its use as simple distortion of an audio signal,     ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"'pdclip' can be used to modify simple waveforms as well as to", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"warp phase pointers for use in phase distortion synthesis.   ", 	1,      5,     14,    490,    15,     5, 200

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen	0,0,4096,10,1

instr	1
	if gkOnOff==0 then			;IF ON/OFF SWIRCH IS OFF...
	 turnoff				;TURN THIS INSTRUMENT OFF
	endif					;END OF CONDITIONAL BRANCH
	kporttime	linseg	0,0.001,0.05	;CREATE A FUNCTION THAT RISES QUICKLY TO A FIXED VALUE THAT WILL BE USED FOR PORTAMENTO TIME
	kfrq	portk	gkfrq,kporttime		;APPLY PORTAMENTO SMOOTHING TO THE FLTK PRODUCED VARIABLE
	kWidth	portk	gkWidth,kporttime	;APPLY PORTAMENTO SMOOTHING TO THE FLTK PRODUCED VARIABLE
	kCenter	portk	gkCenter,kporttime	;APPLY PORTAMENTO SMOOTHING TO THE FLTK PRODUCED VARIABLE
	if gkinput=0 then			;IF 'SOUND FILE' INPUT HAD BEEN CHOSEN...
	  asig		diskin2		"808loopMono.wav", 1, 0, 1	;AUDIO GENERATED FROM A SOUND FILE
	elseif gkinput=1 then			;OR IF 'SINE WAVE' HAS BEEN CHOSEN
	  asig	oscili	1,kfrq,gisine		;AUDIO GENERATED BY A SINE TONE OSCILLATOR
	elseif gkinput=2 then			;OR IF 'SAWTOOTH WAVE' HAS BEEN CHOSEN
	  asig	vco2	1,kfrq			;AUDIO GENERATED BY A SINE TONE OSCILLATOR
	else					;OTHERWISE ('TRIANGLE WAVE' HAS BEEN CHOSEN)
	  asig	vco2	1,kfrq,4,0.5		;AUDIO GENERATED BY A SINE TONE OSCILLATOR
	endif					;END OF THIS CONDITIONAL BRANCH
	kSwitch		changed		gkbipolar	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then	;IF A VARIABLE CHANGE INDICATOR IS RECEIVED...
		reinit	START		;...BEGIN A REINITIALISATION PASS FROM LABEL 'START' 
	endif				;END OF CONDITIONAL BRANCHING
	START:				;LABEL
	;CLIP THE AUDIO SIGNAL USING pdclip
	ares		pdclip		asig, kWidth, kCenter, i(gkbipolar)	; [, ifullscale]]
	rireturn			;RETURN TO PERFORMANCE PASSES FROM INITIALISATION PASS
			out		ares*gkpostgain	;SEND AUDIO TO OUTPUT AND RESCALE
endin
		
</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT
</CsScore>

</CsoundSynthesizer>