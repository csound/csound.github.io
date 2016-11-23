MultitapDelay.csd
Written by Iain McCurdy, 2008

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	8	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE (MAY NEED TO BE LOW WHEN WORKING WITH SHORT DELAY TIMES DEFINED INITIALLY AT KRATE)
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

giMaxDelay	=	5	;MAXIMUM DELAY TIME - A VARIABLE USED BY BOTH THE FLTK CODE AND THE ORCHESTRA (WHICH IS WHY IT APPEARS UP HERE)

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SETUP BASIC COLOURS
;			LABEL       		        | WIDTH | HEIGHT | X | Y
		FLpanel	" 4 Tap Delay with Feedback",      500,    430,    0,  0

;                                                      				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkImpulse,ihImpulse		FLbutton	"Short Impulse Sound",		1,    0,    21,    200,     35,    5,  5,    0,      1,      0,      0.1

;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
idInGain			FLvalue	" ",      50,    16,   210,  25
iddlt1				FLvalue	"%",      50,    20,     5,  90
iddlt2				FLvalue	"%",      50,    20,    55,  90
iddlt3				FLvalue	"%",      50,    20,   395,  90
iddlt4				FLvalue	"secs.",  50,    20,   445,  90
idgain1				FLvalue	" ",      50,    20,     5, 170
idgain2				FLvalue	" ",      50,    20,    55, 170
idgain3				FLvalue	" ",      50,    20,   395, 170
idgain4				FLvalue	" ",      50,    20,   445, 170
idpan1				FLvalue	" ",      50,    20,     5, 250
idpan2				FLvalue	" ",      50,    20,    55, 250
idpan3				FLvalue	" ",      50,    20,   395, 250
idpan4				FLvalue	" ",      50,    20,   445, 250
idmix				FLvalue	" ",     100,    20,     5, 295
idfeedbackamt			FLvalue	" ",     100,    20,     5, 345
idMgain				FLvalue	" ",     100,    20,     5, 395

;SLIDERS					            			MIN |      MAX    | EXP | TYPE |      DISP    | WIDTH | HEIGHT | X | Y
gkInGain,ihInGain		FLslider 	"Live Input Gain",		0,              1,   0,    23,        idInGain,   285,     20,  210,   5
gkdlt1,ihdlt1			FLslider 	"",				1,            100,   0,    23,          iddlt1,   490,     10,    5,  50
gkdlt2,ihdlt2			FLslider 	"",				1,            100,   0,    23,          iddlt2,   490,     10,    5,  60
gkdlt3,ihdlt3			FLslider 	"",				1,            100,   0,    23,          iddlt3,   490,     10,    5,  70
gkdlt4,ihdlt4			FLslider 	"Delay Times (sec)",		.0001, giMaxDelay,   0,    23,          iddlt4,   490,     10,    5,  80
gkgain1,ihgain1			FLslider 	"",				0,              1,   0,    23,         idgain1,   490,     10,    5, 130
gkgain2,ihgain2			FLslider 	"",				0,              1,   0,    23,         idgain2,   490,     10,    5, 140
gkgain3,ihgain3			FLslider 	"",				0,              1,   0,    23,         idgain3,   490,     10,    5, 150
gkgain4,ihgain4			FLslider 	"Tap Gains",			0,              1,   0,    23,         idgain4,   490,     10,    5, 160
gkpan1,ihpan1			FLslider 	"",				0,              1,   0,    23,          idpan1,   490,     10,    5, 210
gkpan2,ihpan2			FLslider 	"",				0,              1,   0,    23,          idpan2,   490,     10,    5, 220
gkpan3,ihpan3			FLslider 	"",				0,              1,   0,    23,          idpan3,   490,     10,    5, 230
gkpan4,ihpan4			FLslider 	"Tap Pans",			0,              1,   0,    23,          idpan4,   490,     10,    5, 240
gkmix,ihmix			FLslider 	"Dry/Wet Ratio",		0,              1,   0,    23,           idmix,   490,     25,    5, 270
gkfeedamt,ihfeedamt		FLslider 	"Feedback Ratio",		0,              1,   0,    23,   idfeedbackamt,   490,     25,    5, 320
gkMgain,ihMgain			FLslider 	"Master Gain",			0,              1,   0,    23,         idMgain,   490,     25,    5, 370

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	0, 	ihInGain
		FLsetVal_i	31, 	ihdlt1	;PERCENTAGE
		FLsetVal_i	67, 	ihdlt2	;PERCENTAGE
		FLsetVal_i	83, 	ihdlt3	;PERCENTAGE
		FLsetVal_i	1.789, 	ihdlt4	;SECONDS
		FLsetVal_i	.1, 	ihgain1
		FLsetVal_i	.5, 	ihgain2
		FLsetVal_i	.2, 	ihgain3
		FLsetVal_i	.9, 	ihgain4
		FLsetVal_i	.1, 	ihpan1
		FLsetVal_i	.9, 	ihpan2
		FLsetVal_i	.2, 	ihpan3
		FLsetVal_i	.8, 	ihpan4
		FLsetVal_i	0.5, 	ihmix
		FLsetVal_i	0.5, 	ihfeedamt
		FLsetVal_i	.7, 	ihMgain

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 320, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"        Multitap Delay (using delayw, delayr & deltap3)      ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"This example is an implementation of a typical multitap      ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"delay. This is a four-tap delay but as it is stereo there are", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"actually two separate delay buffers, one for each channel    ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"with four taps on each.                                      ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"Input for this example can be either the computers live input", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"(raise the input gain control) or a short noise impulse sound", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"triggered by clicking the on-screen button.                  ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"The feedback signal for the feedback loop is taken from the  ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"fourth delay tap. For this reason the delay time for the     ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"fourth tap must be longest. In the design of this GUI, the   ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"fourth tap is the only one where the user specifies a delay  ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"time in seconds, the other three are expressed as percentages", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"of the fourth, thus ensuring that they can not exceed the    ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"fourth.                                                      ", 	1,      5,     14,    490,    15,     5, 300

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gasig	init	0

instr	1	;GENERATES A SHORT SYNTHESISED IMPULSE SOUND                                                                                                     
	aenv		expseg	0.0001, 0.01, 1, p3-0.01, 0.0001	;PERCUSSIVE-TYPE AMPLITUDE ENVELOPE
	asig1		noise	0.3 * aenv, 0				;GENERATE A 'WHITE NOISE' SIGNAL
	iCutoff_Oct	random	6,14					;CREATE A RANDOM VALUE FOR CUTOFF FREQUENCY (IN OCT FORMAT)
	asig2		butlp	asig1, cpsoct(iCutoff_Oct)		;LOWPASS FILTER WHITE NOISE
	gasig		balance	asig2, asig1				;BALANCE FILTERED SIGNAL WITH UNFILTERED WHITE NOISE SIGNAL TO COMPENSATE FOR AMPLITUDE LOSS
endin

instr 		2	;DELAY INSTRUMENT
	ain		inch		1				;READ LIVE AUDIO FROM INPUT CHANNEL 1 (LEFT)
	ain		=		(ain * gkInGain) + gasig	;SCALE LIVE INPUT WITH ON-SCREEN GAIN SLIDER, ADD ANY SOUND IMPULSE SIGNAL FROM INSTR 1
	afeedbacksigL	init		0	;LEFT AND RIGHT CHANNELS OF THE FEEDBACK SIGNAL ARE INITIALISED TO ZERO
	afeedbacksigR	init		0	;LEFT AND RIGHT CHANNELS OF THE FEEDBACK SIGNAL ARE INITIALISED TO ZERO
	iporttime	=		.1	;PORTAMENTO TIME
	kporttime	linseg		0, .001, iporttime, 1, iporttime ;USE OF AN ENVELOPE VALUE THAT QUICKLY RAMPS UP FROM ZERON TO THE REQUIRED VALUE PREVENTS VARIABLES GLIDING TO THEIR REQUIRED VALUES EACH TIME THE INSTRUMENT IS STARTED
	
	kdlt1		=		gkdlt4 * gkdlt1 * 0.01	;DELAY TIME 1 WILL BE A RATIO OF DELAY TIME 4
	kdlt2		=		gkdlt4 * gkdlt2 * 0.01	;DELAY TIME 2 WILL BE A RATIO OF DELAY TIME 4
	kdlt3		=		gkdlt4 * gkdlt3 * 0.01	;DELAY TIME 3 WILL BE A RATIO OF DELAY TIME 4
	kdlt1		portk		kdlt1, kporttime 	;PORTAMENTO IS APPLIED TO kdlt1
	kdlt2		portk		kdlt2, kporttime 	;PORTAMENTO IS APPLIED TO kdlt2
	kdlt3		portk		kdlt3, kporttime 	;PORTAMENTO IS APPLIED TO kdlt3
	kdlt4		portk		gkdlt4,kporttime 	;PORTAMENTO IS APPLIED TO kdlt4
	adlt1		interp		kdlt1	;A NEW A-RATE VARIABLE 'adlt' IS CREATED BY INTERPOLATING THE K-RATE VARIABLE 'kdlt' 
	adlt2		interp		kdlt2	;A NEW A-RATE VARIABLE 'adlt' IS CREATED BY INTERPOLATING THE K-RATE VARIABLE 'kdlt' 
	adlt3		interp		kdlt3	;A NEW A-RATE VARIABLE 'adlt' IS CREATED BY INTERPOLATING THE K-RATE VARIABLE 'kdlt' 
	adlt4		interp		kdlt4	;A NEW A-RATE VARIABLE 'adlt' IS CREATED BY INTERPOLATING THE K-RATE VARIABLE 'kdlt' 
	
	abufferL	delayr		giMaxDelay	;CREATE A DELAY BUFFER OF giMaxDelay (5) SECONDS DURATION (EQUIVALENT TO THE MAXIMUM DELAY TIME POSSIBLE USING THIS EXAMPLE)
	atap1L 		deltap3		adlt1	;TAP THE DELAY LINE AT gkdlt SECONDS
	atap2L 		deltap3		adlt2	;TAP THE DELAY LINE AT gkdlt SECONDS
	atap3L 		deltap3		adlt3	;TAP THE DELAY LINE AT gkdlt SECONDS
	atap4L 		deltap3		adlt4	;TAP THE DELAY LINE AT gkdlt SECONDS
			delayw		ain + afeedbacksigL	;WRITE AUDIO SOURCE AND FEEDBACK SIGNAL INTO THE BEGINNING OF THE BUFFER
	afeedbacksigL	=		atap4L * gkfeedamt	;CREATE FEEDBACK SIGNAL (AN ATTENUATED PROPORTION OF THE DELAY OUTPUT SIGNAL)
	atap1L		=		atap1L*gkpan1
	atap2L		=		atap2L*gkpan2
	atap3L		=		atap3L*gkpan3
	atap4L		=		atap4L*gkpan4
	
	abufferR	delayr		giMaxDelay	;CREATE A DELAY BUFFER OF giMaxDelay (5) SECONDS DURATION (EQUIVALENT TO THE MAXIMUM DELAY TIME POSSIBLE USING THIS EXAMPLE)
	atap1R 		deltap3		adlt1	;TAP THE DELAY LINE AT gkdlt SECONDS
	atap2R 		deltap3		adlt2	;TAP THE DELAY LINE AT gkdlt SECONDS
	atap3R 		deltap3		adlt3	;TAP THE DELAY LINE AT gkdlt SECONDS
	atap4R 		deltap3		adlt4	;TAP THE DELAY LINE AT gkdlt SECONDS
			delayw		ain + afeedbacksigR	;WRITE AUDIO SOURCE AND FEEDBACK SIGNAL INTO THE BEGINNING OF THE BUFFER
	afeedbacksigR	=		atap4R * gkfeedamt	;CREATE FEEDBACK SIGNAL (AN ATTENUATED PROPORTION OF THE DELAY OUTPUT SIGNAL)
	atap1R		=		atap1R*(1-gkpan1)
	atap2R		=		atap2R*(1-gkpan2)
	atap3R		=		atap3R*(1-gkpan3)
	atap4R		=		atap4R*(1-gkpan4)
	
	aoutL		=		(((atap1L+atap2L+atap3L+atap4L) * gkmix) + (ain * (1-gkmix))) * gkMgain
	aoutR		=		(((atap1R+atap2R+atap3R+atap4R) * gkmix) + (ain * (1-gkmix))) * gkMgain
	
			outs		aoutL, aoutR
	gasig		=		0	;CLEAR THE GLOBAL AUDIO SEND VARIABLES
endin

</CsInstruments>

<CsScore>
;INSTR | START | DURATION
i  2       0       -1	;INSTRUMENT 10 (MULTITAP DELAY) PLAYS A HELD NOTE

f 0 3600	;'DUMMY' SCORE EVENT KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>