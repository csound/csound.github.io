delayThruZeroFlanger.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	1	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE (MAY NEED TO BE LOW WHEN WORKING WITH SHORT DELAY TIMES DEFINED INITIALLY AT KRATE)
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE


;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL                                 | WIDTH | HEIGHT | X | Y
		FLpanel	"Through Zero Flanger Implementation",   500,    350,    0,  0

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
idfeedbackamt			FLvalue	" ",      80,    20,     5, 175
idamp				FLvalue	" ",      80,    20,     5, 225
idFlaDepth			FLvalue	" ",      80,    20,     5, 275
idFlaRate			FLvalue	" ",      80,    20,     5, 325

;SLIDERS					            				MIN |  MAX | EXP | TYPE |      DISP    | WIDTH | HEIGHT | X | Y
gkdlt,ihdlt			FLslider 	"Delay Time (sec)",			.0001,   1,  -1,    23,           iddlt,   490,     25,    5,  50
gkmix,ihmix			FLslider 	"Dry/Wet Mix",				0,       1,   0,    23,           idmix,   490,     25,    5, 100
gkfeedamt,ihfeedamt		FLslider 	"Feedback Amount",			-.99,  .99,   0,    23,   idfeedbackamt,   490,     25,    5, 150
gkamp,ihamp			FLslider 	"Output Amplitude Rescaling",		0,       1,   0,    23,           idamp,   490,     25,    5, 200
gkFlaDepth,ihFlaDepth		FLslider 	"Flanger Modulation Depth (sec)",	0,     .01,   0,    23,      idFlaDepth,   490,     25,    5, 250
gkFlaRate,ihFlaRate		FLslider 	"Flanger Modulation Rate",		-1,      1,   0,    23,       idFlaRate,   490,     25,    5, 300
gkingain,ihingain		FLslider 	"Live Input Gain",		0,      1,    0,    23,             -1,   140,     20,  350,   5

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	.0001, 	ihdlt
		FLsetVal_i	.5, 	ihmix
		FLsetVal_i	0, 	ihfeedamt
		FLsetVal_i	.7, 	ihamp
		FLsetVal_i	.005, 	ihFlaDepth
		FLsetVal_i	.05, 	ihFlaRate

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 360, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"        delayr delayw deltap3 - Through the zero flanger     ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"This example is very similar to the previous flanger example ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"but with two modifications made to implement what is referred", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"to as a 'through the zero' flanger.                          ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"At the minimum point of its modulation, when the time        ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"difference between the dry signal and the delayed signal is  ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"zero, the sound is completely cancelled out by the flanger.  ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"In order for this to happen the delayed signal must also be  ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"inverted. Delay opcodes will not allow setting a delay time  ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"of zero so the way round this is to delay the dry signal by  ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"an amount of time equal to the minimum delay time of the     ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"flanger modulations.                                         ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"For the through the zero flanger cancelling effect to work   ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"feedback should be kept at zero.                             ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"In this example the user can choose between a drum loop sound", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"file as input or the computer's live input. A gain control is", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"is provided to control the gain of the live input.           ", 	1,      5,     14,    490,    15,     5, 340

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gilfoshape	ftgen	0, 0, 131072, 19, 0.5, 1, 180, 1	;U-SHAPE PARABOLA

instr	1	;PLAYS FILE
	if gkOnOff=0	then	;SENSE FLTK ON/OFF SWITCH
			turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif
	if	gkinput==0	then	;IF INPUT 'Loop.wav' IS SELECTED...
		gasigL	diskin2	"Loop.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)		
		gasigR	=	gasigL
	else				;OTHERWISE
		asigL, asigR	ins	;TAKE INPUT FROM COMPUTER'S AUDIO INPUT
		gasigL	=	asigL * gkingain	;SCALE USING 'Input Gain' SLIDER
		gasigR	=	asigR * gkingain	;SCALE USING 'Input Gain' SLIDER
	endif						;END OF CONDITIONAL BRANCHING
endin

instr 		2	;FLANGER-DELAY INSTRUMENT
	iporttime	=		.1	;PORTAMENTO TIME
	kporttime	linseg		0, .001, iporttime, 1, iporttime ;USE OF AN ENVELOPE VALUE THAT QUICKLY RAMPS UP FROM ZERON TO THE REQUIRED VALUE PREVENTS VARIABLES GLIDING TO THEIR REQUIRED VALUES EACH TIME THE INSTRUMENT IS STARTED
	kdlt		portk		gkdlt, kporttime ;PORTAMENTO IS APPLIED TO THE VARIABLE 'gkdlt'. A NEW VARIABLE 'kdlt' IS CREATED.
	adlt		interp		kdlt	;A NEW A-RATE VARIABLE 'adlt' IS CREATED BY INTERPOLATING THE K-RATE VARIABLE 'kdlt' 
	
	amod		oscil		gkFlaDepth, gkFlaRate, gilfoshape	;OSCILLATOR THAT MAKES USE OF THE POSITIVE DOMAIN ONLY U-SHAPE PARABOLA WITH FUNCTION TABLE NUMBER gilfoshape
	
	adlt		sum		adlt, amod	;STATIC DELAY TIME AND MODULATING DELAY TIME ARE SUMMED
	;REMEMBER THAT THE LENGTH OF THE DELAY BUFFER DEFINED WILL HAVE TO TAKE ACCOUNT OF THE SUMMED MAXIMUM OF THE STATIC DELAY TIME AND MODULATING DELAY TIME
	
	;;;LEFT CHANNEL DELAY;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	abufferL	delayr	1.2	;CREATE A DELAY BUFFER OF 1.2 SECONDS DURATION (EQUIVALENT TO THE MAXIMUM DELAY TIME POSSIBLE USING THIS EXAMPLE)
	adelsigL 	deltap3	adlt	;TAP THE DELAY LINE AT gkdlt SECONDS
			delayw	gasigL + (adelsigL*gkfeedamt)	;WRITE AUDIO SOURCE AND FEEDBACK SIGNAL INTO THE BEGINNING OF THE BUFFER
	
	;;;RIGHT CHANNEL DELAY;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		                                                                                              
	abufferR	delayr	1.2	;CREATE A DELAY BUFFER OF 1.2 SECONDS DURATION (EQUIVALENT TO THE MAXIMUM DELAY TIME POSSIBLE USING THIS EXAMPLE)
	adelsigR 	deltap3	adlt	;TAP THE DELAY LINE AT gkdlt SECONDS
			delayw	gasigR + (adelsigR*gkfeedamt)	;WRITE AUDIO SOURCE AND FEEDBACK SIGNAL INTO THE BEGINNING OF THE BUFFER
	
	asigL		delay	gasigL, 0.0001	;DELAY THE DRY SIGNAL BY AN AMOUNT OF TIME EQUAL TO THE MINIMUM TIME DELAY OFFSET OF THE FLANGER MODULATIONS
	asigR		delay	gasigR, 0.0001	;DELAY THE DRY SIGNAL BY AN AMOUNT OF TIME EQUAL TO THE MINIMUM TIME DELAY OFFSET OF THE FLANGER MODULATIONS

	aL		ntrpol	asigL, -adelsigL, gkmix	;CREATE DRY/WET MIX
	aR		ntrpol	asigR, -adelsigR, gkmix        ;CREATE DRY/WET MIX

			outs		aL * gkamp, aR * gkamp	;CREATE A MIX BETWEEN THE WET AND THE DRY SIGNALS AT THE OUTPUT

	clear	gasigL, gasigR	;CLEAR THE GLOBAL AUDIO SEND VARIABLES
endin

</CsInstruments>

<CsScore>
;INSTR | START | DURATION
i  2       0       -1	;INSTRUMENT 2 PLAYS A HELD NOTE

f 1 0 131072 7 0 65536 1 65536 0	;POSITIVE DOMAIN TRIANGLE WAVE

f 0 3600	;'DUMMY' SCORE EVENT KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>


</CsoundSynthesizer>