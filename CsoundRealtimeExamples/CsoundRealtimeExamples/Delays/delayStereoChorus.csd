delayStereoChorus.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	8	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE (MAY NEED TO BE LOW WHEN WORKING WITH SHORT DELAY TIMES DEFINED INITIALLY AT KRATE)
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;			LABEL           | WIDTH | HEIGHT | X | Y
FLcolor	255, 255, 255, 0, 0, 0
		FLpanel	"Stereo Chorus",   500,    300,    0,  0
;                                                   		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,    0,    22,    100,     80,    5,  5,    0,      1,      0,      3600
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW


;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
idmix				FLvalue	" ",      80,    20,     5, 125
idChoDepth			FLvalue	" ",      80,    20,     5, 175
idChoRate			FLvalue	" ",      80,    20,     5, 225
idphs				FLvalue	" ",      80,    20,     5, 275

;SLIDERS					            					MIN |  MAX | EXP | TYPE |    DISP    | WIDTH | HEIGHT | X | Y
gkOscGain,ihOscGain		FLslider 	"Oscillator Gain",				0,      1,    0,    23,          -1,    370,     15,  120,   5
gkOscFrq,ihOscFrq		FLslider 	"Oscillator Freq.",				20,  3000,   -1,    23,          -1,    370,     15,  120,  35
gkOscLPF,ihOscLPF		FLslider 	"Tone",						20, 20000,   -1,    23,          -1,    182,     15,  120,  65
gkOscRes,ihOscRes		FLslider 	"Resonance",					0,      1,    0,    23,          -1,    182,     15,  308,  65
gkmix,ihmix			FLslider 	"Dry/Wet Mix",					0,      1,    0,    23,       idmix,    490,     25,    5, 100
gkChoDepth,ihChoDepth		FLslider 	"Chorus Modulation Depth (sec)",		0,    .05,    0,    23,  idChoDepth,    490,     25,    5, 150
gkChoRate,ihChoRate		FLslider 	"Chorus Modulation Rate",			.001,  14,    0,    23,   idChoRate,    490,     25,    5, 200
gkphs,ihphs			FLslider 	"Right Channel Phase (fraction of a cycle)",	0,      1,    0,    23,       idphs,    490,     25,    5, 250

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	.3, 	ihOscGain
		FLsetVal_i	100, 	ihOscFrq
		FLsetVal_i	4000, 	ihOscLPF
		FLsetVal_i	0.4, 	ihOscRes
		FLsetVal_i	.5, 	ihmix
		FLsetVal_i	.001, 	ihChoDepth
		FLsetVal_i	.8, 	ihChoRate
		FLsetVal_i	.5, 	ihphs

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 380, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"            delayr delayw deltap3 - Stereo Chorus            ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Using the same basic algorithm as the flanger implementation ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"a chorus effect is implemented.                              ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"A chorus effect uses the pitch bending effect of a modulating", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"delay to create an imitation of an ensemble of voices from a ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"single voice source sound.                                   ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"Typically the delay time offset is larger than in a flanger  ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"implementation and a sine wave LFO (low frequency oscillator)", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"shape is used in the delay time modulation.                  ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"This example uses independent LFOs on the left and right     ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"channels. The user can change the phase of the right hand    ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"side LFO (the left is permanently set at 0 radians).         ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"Offsetting the phase of the right hand LFO creates a broad   ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"stereo effect. Giving it a value of 0 radians will render the", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"effect monophonic.                                           ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"If the Dry/Wet control is set at 100% wet, and the phase of  ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"right hand channel LFO is set at 0 radians then a simple     ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"vibrato effect results.                                      ", 	1,      5,     14,    490,    15,     5, 360

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gilfoshape	ftgen	0, 0, 131072, 19, 0.5, 1, 180, 1	;U-SHAPE PARABOLA
gisine		ftgen	0, 0, 131072, 10, 1			;A SINE WAVE

instr	1	;GENERATES AUDIO SIGNAL
	if gkOnOff=0	then	;SENSE FLTK ON/OFF SWITCH
			turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif			;END OF CONDITIONAL BRANCHING
	asig		vco 		gkOscGain, gkOscFrq, 1, 0, gisine	;GENERATE A SAWTOOTH WAVE AUDIO SIGNAL
	gasig		moogladder	asig, gkOscLPF, gkOscRes		;LOW-PASS FILTER AUDIO SIGNAL (CREATE A GLOBAL VARIABLE OUTPUT TO BE USED IN INSTRUMENT 2)
endin
	
instr 	2	;CHORUS-DELAY INSTRUMENT
	iporttime	=	0.01				;I-RATE VARIABLE DEFINITION OF PORTAMENTO TIME
	kporttime	linseg	0,0.01,iporttime,1,iporttime	;RAMPING UP FROM ZERO VERSION OF PORTAMENTO TIME VARIABLE
	kChoDepth	portk	gkChoDepth, kporttime		;SMOOTH VARIABLE CHANGES WITH PORTK
	aChoDepth	interp	kChoDepth			;INTERPOLATE TO CREATE A-RATE VERSION OF K-RATE VARIABLE

	amodL 		osciliktp 	gkChoRate, gilfoshape, 0	;LFO SHAPE IS A U-SHAPE PARABOLA
	amodL		=		(amodL*aChoDepth)+.01
	
	amodR 		osciliktp 	gkChoRate, gilfoshape, gkphs	;THE PHASE OF THE RIGHT CHANNEL IS ADJUSTABLE
	amodR		=		(amodR*aChoDepth)+.01
	
	;REMEMBER THAT THE LENGTH OF THE DELAY BUFFER DEFINED WILL HAVE TO TAKE ACCOUNT OF THE SUMMED MAXIMUM OF THE STATIC CONSTANT VALUE AND MODULATING DELAY TIME
	
	;;;LEFT CHANNEL DELAY;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	abufferL	delayr	1.2	;CREATE A DELAY BUFFER OF 1.2 SECONDS DURATION (EQUIVALENT TO THE MAXIMUM DELAY TIME POSSIBLE USING THIS EXAMPLE)
	adelsigL 	deltap3	amodL	;TAP THE DELAY LINE AT gkdlt SECONDS
			delayw	gasig	;WRITE AUDIO SOURCE INTO THE BEGINNING OF THE BUFFER

	;;;RIGHT CHANNEL DELAY;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		                                                                                              	
	abufferR	delayr	1.2	;CREATE A DELAY BUFFER OF 1.2 SECONDS DURATION (EQUIVALENT TO THE MAXIMUM DELAY TIME POSSIBLE USING THIS EXAMPLE)
	adelsigR 	deltap3	amodR	;TAP THE DELAY LINE AT gkdlt SECONDS
			delayw	gasig	;WRITE AUDIO SOURCE INTO THE BEGINNING OF THE BUFFER

	aL		ntrpol	gasig, adelsigL, gkmix		;CREATE DRY/WET MIX
	aR		ntrpol	gasig, adelsigR, gkmix        	;CREATE DRY/WET MIX

			outs	aL,aR	;CREATE A MIX BETWEEN THE WET AND THE DRY SIGNALS AT THE OUTPUT
	
			clear	gasig	;CLEAR THE GLOBAL AUDIO SEND VARIABLE
endin

</CsInstruments>

<CsScore>
;INSTR | START | DURATION
i  2       0       -1	;INSTRUMENT 2 PLAYS A HELD NOTE

f 0 3600	;'DUMMY' SCORE EVENT KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>