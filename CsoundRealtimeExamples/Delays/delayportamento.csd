delayportamento.csd
Written by Iain McCurdy, 2006

THE delay OPCODE IS PLACED IN A SEPARATE, ALWAYS ON, INSTRUMENT FROM THE SOURCE SOUND PRODUCING INSTRUMENT.
THE IS A COMMONLY USED TECHNIQUE WITH TIME SMEARING OPCODES AND EFFECTS LIKE REVERBS AND DELAYS.

ksmps MAY NEED TO BE LOW (AND kr THEREFORE HIGH) WHEN WORKING WITH SHORT DELAY TIMES DEFINED INITIALLY AT KRATE

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	4	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE (MAY NEED TO BE LOW WHEN WORKING WITH SHORT DELAY TIMES DEFINED INITIALLY AT KRATE)
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE


;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL                     | WIDTH | HEIGHT | X | Y
		FLpanel	"Delay with Portamento",     500,    250,    0,  0

;                                                      	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"Input On/Off",	1,    0,    22,    180,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkinput, ihinput		FLbutBank	14,     1,     2,     18,      40,   250, 0,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Input", 		1,       5,    14,     50,      16, 200,   0
ih		 	FLbox  	"Drum Loop", 		1,       5,    14,     75,      16, 270,   0
ih		 	FLbox  	"Live     ", 		1,       5,    14,     75,      16, 270,  20

;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
iddlt				FLvalue	" ",      80,    20,     5,  75
idmix				FLvalue	" ",      80,    20,     5, 125
idgain				FLvalue	" ",      80,    20,     5, 175
idporttime			FLvalue	" ",      80,    20,     5, 225

;SLIDERS					            		MIN | MAX | EXP | TYPE | DISP       | WIDTH | HEIGHT | X | Y
gkdlt,ihdlt			FLslider 	"Delay Time (sec)",	.001,  5,    0,    23,   iddlt,        490,     25,    5,  50
gkmix,ihmix			FLslider 	"Dry/Wet Mix",		0,     1,    0,    23,   idmix,        490,     25,    5, 100
gkgain,ihgain			FLslider 	"Output Gain",		0,     1,    0,    23,   idgain,       490,     25,    5, 150
gkporttime,ihporttime		FLslider 	"Portamento Time",	0,     2,    0,    23,   idporttime,   490,     25,    5, 200
gkingain,ihingain		FLslider 	"Live Input Gain",	0,     1,    0,    23,   -1,           140,     20,  350,   5

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	0.5, 	ihdlt
		FLsetVal_i	0.5, 	ihmix
		FLsetVal_i	1, 	ihgain
		FLsetVal_i	0.1, 	ihporttime

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 300, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"  delayr delayw deltap3 - portamento applied to delay time   ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"This example is very similar to the previous example with    ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"the addition of portamento being applied to the delay time   ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"parameter. As the delay time slider is moved pitch bending   ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"effects are created.                                         ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"For better quality results the deltap3 opcode is used in     ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"place of the deltap opcode. Also for higher fidelity results ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"the delay time is expressed to the deltap3 opcode as an      ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"a-rate variable. This necessitates the use of the 'interp'   ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"opcode for rate conversion as FLTK sliders only output values", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"at k-rate.                                                   ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"In this example the user can choose between a drum loop sound", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"file as input or the computer's live input. A gain control is", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"is provided to control the gain of the live input.           ", 	1,      5,     14,    490,    15,     5, 280

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1	;PLAYS FILE
	if gkOnOff=0	then	;SENSE FLTK ON/OFF SWITCH
			turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif
	if	gkinput==0	then	;IF INPUT '808loop.wav' IS SELECTED...
		gasigL, gasigR	diskin2	"808loop.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)		
	else				;OTHERWISE
		asigL, asigR	ins	;TAKE INPUT FROM COMPUTER'S AUDIO INPUT
		gasigL	=	asigL * gkingain	;SCALE USING 'Input Gain' SLIDER
		gasigR	=	asigR * gkingain	;SCALE USING 'Input Gain' SLIDER
	endif						;END OF CONDITIONAL BRANCHING
endin

instr	2	;DELAY INSTRUMENT
	kporttime	linseg		0, .001, 1, 1, 1 ;USE OF AN ENVELOPE VALUE THAT QUICKLY RAMPS UP FROM ZERO TO 1. THIS PREVENTS VARIABLES GLIDING TO THEIR REQUIRED VALUES EACH TIME THE INSTRUMENT IS STARTED.
	kporttime	=	kporttime * gkporttime	;SCALE PORTAMENTO FUNCTION WITH FLTK SLIDER VALUE
	kdlt		portk		gkdlt, kporttime ;PORTAMENTO IS APPLIED TO THE VARIABLE 'gkdlt'. A NEW VARIABLE 'kdlt' IS CREATED.
	adlt		interp		kdlt	;A NEW A-RATE VARIABLE 'adlt' IS CREATED BY INTERPOLATING THE K-RATE VARIABLE 'kdlt' 
	
	;;;LEFT CHANNEL DELAY;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	abufferL	delayr	5	;CREATE A DELAY BUFFER OF 5 SECONDS DURATION (EQUIVALENT TO THE MAXIMUM DELAY TIME POSSIBLE USING THIS EXAMPLE)
	adelsigL 	deltap3	adlt	;TAP THE DELAY LINE AT gkdlt SECONDS
			delayw	gasigL	;WRITE AUDIO INTO THE BEGINNING OF THE BUFFER

	;;;RIGHT CHANNEL DELAY;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		
	abufferR	delayr	5	;CREATE A DELAY BUFFER OF 5 SECONDS DURATION (EQUIVALENT TO THE MAXIMUM DELAY TIME POSSIBLE USING THIS EXAMPLE)
	adelsigR 	deltap3	adlt	;TAP THE DELAY LINE AT gkdlt SECONDS
			delayw	gasigR	;WRITE AUDIO INTO THE BEGINNING OF THE BUFFER
	
			aL	ntrpol	gasigL, adelsigL, gkmix
			aR	ntrpol	gasigR, adelsigR, gkmix
			outs		aL * gkgain, aR * gkgain	;CREATE A MIX BETWEEN THE WET AND THE DRY SIGNALS AT THE OUTPUT
	clear	gasigL, gasigR	;CLEAR THE GLOBAL AUDIO SEND VARIABLES
endin

</CsInstruments>

<CsScore>
;INSTR | START | DURATION
i  2       0       -1	;INSTRUMENT 2 PLAYS A HELD NOTE

f 0 3600	;'DUMMY' SCORE EVENT KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>


</CsoundSynthesizer>



























