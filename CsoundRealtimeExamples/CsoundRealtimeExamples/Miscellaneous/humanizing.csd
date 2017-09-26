humanizing.csd
Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE (MAY NEED TO BE LOW WHEN WORKING WITH SHORT DELAY TIMES DEFINED INITIALLY AT KRATE)
nchnls 		= 	1	;NUMBER OF CHANNELS (1=MONO)
0dbfs		=	1	;MAXIMUM AMPITUDE VALUE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 255, 255, 0
;			LABEL          | WIDTH | HEIGHT | X | Y
		FLpanel	"Humanizing",    1000,    285,    0,  0

;                                                      		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff			FLbutton	"Tone On/Off",	1,    0,    22,    120,     25,    5,  5,    0,      1,      0,      -1
gkvibrOnOff,ihvibrOnOff		FLbutton	"vibr",		1,    0,    22,     70,     25,  370,  5,   -1
gkvibratoOnOff,ihvibratoOnOff	FLbutton	"vibrato",	1,    0,    22,     70,     25,  445,  5,   -1
gkjitterOnOff,ihjitterOnOff	FLbutton	"jitter",	1,    0,    22,     70,     25,  520,  5,   -1
gkjitter2OnOff,ihjitter2OnOff	FLbutton	"jitter2",	1,    0,    22,     70,     25,  595,  5,   -1
gkjsplineOnOff,ihjsplineOnOff	FLbutton	"jspline",	1,    0,    22,     70,     25,  670,  5,   -1
gkgaussOnOff,ihgaussOnOff	FLbutton	"gauss",	1,    0,    22,     70,     25,  745,  5,   -1
gkgaussiOnOff,ihgaussiOnOff	FLbutton	"gaussi",	1,    0,    22,     70,     25,  820,  5,   -1
;FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW

;VALUE_DISPLAY_BOXES			 		WIDTH | HEIGHT | X | Y
idToneFrq				FLvalue	" ",      40,     18,   130, 25

;SLIDERS				            	MIN | MAX | EXP | TYPE | DISP     | WIDTH | HEIGHT | X | Y
gkToneFrq,ihToneFrq	FLslider 	"Freq.",	100,  5000, -1,    23,  idToneFrq,   120,     20,   130, 5
gkToneAmp,ihToneAmp	FLslider 	"Amp.",		0,       1,  0,    23,  -1,          120,     20,   250, 5

;FLTABS	TABSWIDTH | TABSHEIGHT | X | Y
FLtabs	  996,        230,       2,  50

;FLGROUP	LABEL | TAB_WIDTH | TAB_HEIGHT | TAB_X | TAB_Y
FLgroup	        "vibr",    996,        200,        5,     70
	;VALUE_DISPLAY_BOXES			 WIDTH | HEIGHT | X | Y
	idvibrAmp		FLvalue	" ",      60,     18,     5, 100
	idvibrFrq		FLvalue	" ",      60,     18,     5, 150
	;SLIDERS				            		MIN | MAX | EXP | TYPE | DISP     | WIDTH | HEIGHT | X | Y
	gkvibrAmp,ihvibrAmp	FLslider 	"Average Amplitude",	0,    0.2,   0,    23,  idvibrAmp,   490,     25,    5,  75
	gkvibrFrq,ihvibrFrq	FLslider 	"Average Frequency",	0,     20,   0,    23,  idvibrFrq,   490,     25,    5, 125
	;SET_INITIAL_VALUES		VALUE | HANDLE
	FLsetVal_i	0.01, 	ihvibrAmp
	FLsetVal_i	4, 	ihvibrFrq
FLgroupEnd

;FLGROUP	LABEL | TAB_WIDTH | TAB_HEIGHT | TAB_X | TAB_Y
FLgroup	        "vibrato",    990,        200,        5,     70
	;VALUE_DISPLAY_BOXES			 WIDTH | HEIGHT | X | Y
	idvibratoAvAmp		FLvalue	" ",      60,     18,     5, 100
	idvibratoAvFrq		FLvalue	" ",      60,     18,     5, 150
	idvibratoRndAmp		FLvalue	" ",      60,     18,     5, 200
	idvibratoRndFrq		FLvalue	" ",      60,     18,     5, 250
	idvibratoAmpMinRate	FLvalue	" ",      60,     18,   505, 100
	idvibratoAmpMaxRate	FLvalue	" ",      60,     18,   505, 150
	idvibratocpsMinRate	FLvalue	" ",      60,     18,   505, 200
	idvibratocpsMaxRate	FLvalue	" ",      60,     18,   505, 250
	;SLIDERS				            			MIN | MAX | EXP | TYPE |     DISP          | WIDTH | HEIGHT | X | Y
	gkvibratoAvAmp,ihvibratoAvAmp		FLslider 	"Average Amplitude",	0,    0.2,   0,    23,  idvibratoAvAmp,       490,     25,    5,  75
	gkvibratoAvFrq,ihvibratoAvFrq		FLslider 	"Average Frequency",	0,     20,   0,    23,  idvibratoAvFrq,       490,     25,    5, 125
	gkvibratoRndAmp,ihvibratoRndAmp		FLslider 	"Random Amp Amount",	0,      5,   0,    23,  idvibratoRndAmp,      490,     25,    5, 175
	gkvibratoRndFrq,ihvibratoRndFrq		FLslider 	"Random Freq Amount",	0,      2,   0,    23,  idvibratoRndFrq,      490,     25,    5, 225
	gkvibratoAmpMinRate,ihvibratoAmpMinRate	FLslider 	"Amp Minimum Rate",	0,     20,   0,    23,  idvibratoAmpMinRate,  490,     25,  505,  75
	gkvibratoAmpMaxRate,ihvibratoAmpMaxRate	FLslider 	"Amp Maximum Rate",	0,     20,   0,    23,  idvibratoAmpMaxRate,  490,     25,  505, 125
	gkvibratocpsMinRate,ihvibratocpsMinRate	FLslider 	"CPS Minimum Rate",	0,     20,   0,    23,  idvibratocpsMinRate,  490,     25,  505, 175
	gkvibratocpsMaxRate,ihvibratocpsMaxRate	FLslider 	"CPS Maximum Rate",	0,     20,   0,    23,  idvibratocpsMaxRate,  490,     25,  505, 225
	;SET_INITIAL_VALUES	VALUE | HANDLE
	FLsetVal_i		0.01,	ihvibratoAvAmp		
	FLsetVal_i		4,	ihvibratoAvFrq		
	FLsetVal_i		1,	ihvibratoRndAmp		
	FLsetVal_i		0.2,	ihvibratoRndFrq		
	FLsetVal_i		0.5,	ihvibratoAmpMinRate	
	FLsetVal_i		1,	ihvibratoAmpMaxRate	
	FLsetVal_i		0.5,	ihvibratocpsMinRate	
	FLsetVal_i		1,	ihvibratocpsMaxRate	
FLgroupEnd

;FLGROUP	LABEL    | TAB_WIDTH | TAB_HEIGHT | TAB_X | TAB_Y
FLgroup	        "jitter",     990,        200,        5,     70
	;VALUE_DISPLAY_BOXES		 WIDTH | HEIGHT | X | Y
	idjitterAmp	FLvalue	" ",      60,     18,     5, 100
	idjitterCpsmin	FLvalue	" ",      60,     18,     5, 150
	idjitterCpsmax	FLvalue	" ",      60,     18,     5, 200
	;SLIDERS				            			MIN | MAX | EXP | TYPE |     DISP      | WIDTH | HEIGHT | X | Y
	gkjitterAmp,ihjitterAmp			FLslider 	"Amplitude",	0,    0.2,   0,    23,  idjitterAmp,       490,    25,    5,  75
	gkjitterCpsmin,ihjitterCpsmin		FLslider 	"CPS Minimum",	0,     20,   0,    23,  idjitterCpsmin,    490,    25,    5, 125
	gkjitterCpsmax,ihjitterCpsmax		FLslider 	"CPS Maximum",	0,     20,   0,    23,  idjitterCpsmax,    490,    25,    5, 175
	;SET_INITIAL_VALUES	VALUE | HANDLE
	FLsetVal_i		0.01,	ihjitterAmp			
	FLsetVal_i		4,	ihjitterCpsmin		
	FLsetVal_i		8,	ihjitterCpsmax		
FLgroupEnd

;FLGROUP	LABEL     | TAB_WIDTH | TAB_HEIGHT | TAB_X | TAB_Y
FLgroup	        "jitter2",     990,        200,        5,     70
	;VALUE_DISPLAY_BOXES		 WIDTH | HEIGHT | X | Y
	idjitter2Totamp	FLvalue	" ",      60,     18,     5, 100
	idjitter2Amp1	FLvalue	" ",      60,     18,     5, 150
	idjitter2Cps1	FLvalue	" ",      60,     18,     5, 200
	idjitter2Amp2	FLvalue	" ",      60,     18,   505, 100
	idjitter2Cps2	FLvalue	" ",      60,     18,   505, 150
	idjitter2Amp3	FLvalue	" ",      60,     18,   505, 200
	idjitter2Cps3	FLvalue	" ",      60,     18,   505, 250
	;SLIDERS				            				MIN | MAX | EXP | TYPE |     DISP       | WIDTH | HEIGHT |  X | Y
	gkjitter2Totamp,ihjitter2Totamp		FLslider 	"Total Amplitude",	0,    0.5,   0,    23,  idjitter2Totamp,   490,     25,     5,  75
	gkjitter2Amp1,ihjitter2Amp1		FLslider 	"Amplitude 1",		0,      1,   0,    23,  idjitter2Amp1,     490,     25,     5, 125
	gkjitter2Cps1,ihjitter2Cps1		FLslider 	"CPS 1",		0.01, 100,  -1,    23,  idjitter2Cps1,     490,     25,     5, 175
	gkjitter2Amp2,ihjitter2Amp2		FLslider 	"Amplitude 2",		0,      1,   0,    23,  idjitter2Amp2,     490,     25,   505,  75
	gkjitter2Cps2,ihjitter2Cps2		FLslider 	"CPS 2",		0.01, 100,  -1,    23,  idjitter2Cps2,     490,     25,   505, 125
	gkjitter2Amp3,ihjitter2Amp3		FLslider 	"Amplitude 3",		0,      1,   0,    23,  idjitter2Amp3,     490,     25,   505, 175
	gkjitter2Cps3,ihjitter2Cps3		FLslider 	"CPS 3",		0.01, 100,  -1,    23,  idjitter2Cps3,     490,     25,   505, 225
	;SET_INITIAL_VALUES	VALUE | HANDLE
	FLsetVal_i		0.04,	ihjitter2Totamp			
	FLsetVal_i		0.2,	ihjitter2Amp1	        	
	FLsetVal_i		8,	ihjitter2Cps1	        	
	FLsetVal_i		0.25,	ihjitter2Amp2	        	
	FLsetVal_i		0.24,	ihjitter2Cps2	        	
	FLsetVal_i		1,	ihjitter2Amp3	        	
	FLsetVal_i		0.1,	ihjitter2Cps3	        	
FLgroupEnd

;FLGROUP	LABEL     | TAB_WIDTH | TAB_HEIGHT | TAB_X | TAB_Y
FLgroup	        "jspline",     990,        200,        5,     70
	;VALUE_DISPLAY_BOXES			 WIDTH | HEIGHT | X | Y
	idjsplineAmp		FLvalue	" ",      60,     18,     5, 100
	idjsplineCpsMin		FLvalue	" ",      60,     18,     5, 150
	idjsplineCpsMax		FLvalue	" ",      60,     18,     5, 200
	;SLIDERS				            			MIN | MAX | EXP | TYPE |     DISP        | WIDTH | HEIGHT |  X | Y
	gkjsplineAmp, ihjsplineAmp		FLslider 	"Amplitude",	0,    0.5,   0,    23,  idjsplineAmp,       490,     25,     5,  75
	gkjsplineCpsMin, ihjsplineCpsMin	FLslider 	"CPS Minimum",	0.01, 100,  -1,    23,  idjsplineCpsMin,    490,     25,     5, 125
	gkjsplineCpsMax, ihjsplineCpsMax	FLslider 	"CPS Maximum",	0.01, 100,  -1,    23,  idjsplineCpsMax,    490,     25,     5, 175
	;SET_INITIAL_VALUES	VALUE | HANDLE
	FLsetVal_i		0.01,	ihjsplineAmp
	FLsetVal_i		4,	ihjsplineCpsMin	                	
	FLsetVal_i		8,	ihjsplineCpsMax	                	
FLgroupEnd

;FLGROUP	LABEL     | TAB_WIDTH | TAB_HEIGHT | TAB_X | TAB_Y
FLgroup	        "gauss",     990,        200,        5,     70
	;VALUE_DISPLAY_BOXES			 WIDTH | HEIGHT | X | Y
	idgaussAmp		FLvalue	" ",      60,     18,     5, 100
	idgaussCPS		FLvalue	" ",      60,     18,     5, 150
	;SLIDERS				            					MIN | MAX | EXP | TYPE |     DISP   | WIDTH | HEIGHT |  X | Y
	gkgaussAmp, ihgaussAmp		FLslider 	"Amplitude",				0,    0.5,   0,    23,  idgaussAmp,    490,     25,     5,  75
	gkgaussCPS, ihgaussCPS		FLslider 	"CPS",					0.01, kr/2, -1,    23,  idgaussCPS,    490,     25,     5, 125
	;SET_INITIAL_VALUES	VALUE | HANDLE
	FLsetVal_i		0.015,	ihgaussAmp
	FLsetVal_i		10,	ihgaussCPS	                	
FLgroupEnd

;FLGROUP	LABEL    | TAB_WIDTH | TAB_HEIGHT | TAB_X | TAB_Y
FLgroup	        "gaussi",     990,        200,        5,     70

	;VALUE_DISPLAY_BOXES			 WIDTH | HEIGHT | X | Y
	idgaussiRange		FLvalue	" ",      60,     18,     5, 100
	idgaussiAmp		FLvalue	" ",      60,     18,     5, 150
	idgaussiCPS		FLvalue	" ",      60,     18,     5, 200
	;SLIDERS				            					MIN | MAX | EXP | TYPE |     DISP   | WIDTH | HEIGHT |  X | Y
	gkgaussiRange, ihgaussiRange	FLslider 	"Range",				0,      1,   0,    23,  idgaussiRange, 490,     25,     5,  75
	gkgaussiAmp, ihgaussiAmp	FLslider 	"Amplitude",				0,      1,   0,    23,  idgaussiAmp,   490,     25,     5, 125
	gkgaussiCPS, ihgaussiCPS	FLslider 	"CPS",					0.01, kr/2, -1,    23,  idgaussiCPS,   490,     25,     5, 175
	;SET_INITIAL_VALUES	VALUE | HANDLE
	FLsetVal_i		1,	ihgaussiRange
	FLsetVal_i		0.03,	ihgaussiAmp
	FLsetVal_i		20,	ihgaussiCPS
FLgroupEnd

FLtabsEnd


;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	500, 	ihToneFrq
		FLsetVal_i	1, 	ihToneAmp

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ",1012, 200, 0,335
				FLscroll    1012, 200, 0,0
;TEXT BOXES																			TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                                                          Humanizing                                                      ", 	1,      5,     14,    990,    20,     5,  0
ih		 	FLbox  	"--------------------------------------------------------------------------------------------------------------------------", 	1,      5,     14,    990,    20,     5,  20
ih		 	FLbox  	"'Humanizing' refers to the practice of adding a random, varying or jitter element to an otherwise static or predictable   ", 	1,      5,     14,    990,    20,     5,  40
ih		 	FLbox  	"function in an attempt to render the performance of that function to better resemble that of a human musician.            ", 	1,      5,     14,    990,    20,     5,  60
ih		 	FLbox  	"A number of opcodes are introduced which can be used for this purpose. In all cases the output of each of these opcodes   ", 	1,      5,     14,    990,    20,     5,  80
ih		 	FLbox  	"ia applied to the frequency parameter of a sine tone oscillator so that its performance can be assessed. The input        ", 	1,      5,     14,    990,    20,     5, 100
ih		 	FLbox  	"parameters for each opcode are accesed using the FL tabs in the lower half of the interface. Each opcode can be activated ", 	1,      5,     14,    990,    20,     5, 120
ih		 	FLbox  	"or deactivated using its own switch. Any number of modulation sources can be combined simultaneously.                     ", 	1,      5,     14,    990,    20,     5, 140
ih		 	FLbox  	"'vibrato' is an opcode intended to emulate expressive pitch modulation better than a simple sine wave LFO. It makes use of", 	1,      5,     14,    990,    20,     5, 160
ih		 	FLbox  	"many input parameters so a simplified version 'vibr' was created which uses hardwired settings for most of vibrato's      ", 	1,      5,     14,    990,    20,     5, 180
ih		 	FLbox  	"parameters. 'jitter' and 'jitter2' generate random straight line functions. 'Jitter2' is more complex than 'Jitter' and   ", 	1,      5,     14,    990,    20,     5, 200
ih		 	FLbox  	"demands a greater number of input arguments. 'jspline' generates a random function based on spline curves, this can       ", 	1,      5,     14,    990,    20,     5, 220
ih		 	FLbox  	"provide more natural sounding results than those possible with 'jitter' or 'jitter2' (see also 'rspline'). The final two  ", 	1,      5,     14,    990,    20,     5, 240
ih		 	FLbox  	"options are based upon gaussian noise - 'gauss' generates gaussian noise at the current k-rate, 'gaussi' generates noise  ", 	1,      5,     14,    990,    20,     5, 260
ih		 	FLbox  	"at a user defined frequency with linear interpolation between generated values.                                           ", 	1,      5,     14,    990,    20,     5, 280
ih		 	FLbox  	"For greater detail of the operation of each of the opcodes covered refer to the Csound Manual:                            ", 	1,      5,     14,    990,    20,     5, 300
ih		 	FLbox  	"http://www.csounds.com/manual/html/index.html                                                                             ", 	1,      5,     14,    990,    20,     5, 320

FLscroll_end
FLpanel_end
 
FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen	0,0,65536,10,1

instr	1	;PLAYS FILE
	if gkOnOff=0	then	;SENSE FLTK ON/OFF SWITCH
			turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif			;ENDI OF THIS CONDITIONAL BRANCH
	kporttime	linseg	0,0.001,0.03	;A FUNCTION THAT RAMPS UP FROM ZERO THAT WILL BE USED TO DEFINE PORTAMENTO TIME
	kToneFrq	portk	gkToneFrq, kporttime	;PORTAMENTO SMOOTHING APPLIED TO THE TONE GENERATOR FREQUENCY CONTROL 

	;vibr
	if gkvibrOnOff=1 then	;IF 'vibr' BUTTON IS 'ON'...
		;KOUT	VIBR	KAVERAGEAMP | KAVERAGEFREQ | IFNFLGROUPEND
		kvibr	vibr	gkvibrAmp,     gkvibrFrq,       gisine	;CREATE A RANDOM FUNCTION USING vibr
		kToneFrq	=	kToneFrq * (1+kvibr)		;OFFSET FUNCTION BY +1 AND MULTIPLY TO TONE GENERATOR FREQUENCY CONTROL
	endif
	
	;vibrato
	if gkvibratoOnOff=1 then	;IF 'vibrato' BUTTON IS 'ON'...
		;KOUT		VIBRATO	KAVERAGEAMP    | KAVERAGEFREQ | KRANDAMOUNTAMP | KRANDAMOUNTFREQ |     KAMPMINRATE    |   KAMPMAXRATE       |     KCPSMINRATE    |   KCPSMAXRATE      |IFN
		kvibrato	vibrato	gkvibratoAvAmp, gkvibratoAvFrq, gkvibratoRndAmp, gkvibratoRndFrq, gkvibratoAmpMinRate,  gkvibratoAmpMaxRate, gkvibratocpsMinRate, gkvibratocpsMaxRate, 	gisine	;CREATE A RANDOM FUNCTION USING vibrato                                  
		kToneFrq	=	kToneFrq * (1+kvibrato)	;OFFSET FUNCTION BY +1 AND MULTIPLY TO TONE GENERATOR FREQUENCY CONTROL
	endif

	;jitter
	if gkjitterOnOff=1 then	;IF 'jitter' BUTTON IS 'ON'...
		;KOUT	JITTER KAMP        |    KCPSMIN    |   KCPSMAX
		kjitter	jitter gkjitterAmp, gkjitterCpsmin, gkjitterCpsmax	;CREATE A RANDOM FUNCTION USING jitter                                  
		kToneFrq	=	kToneFrq * (1+kjitter)            	;OFFSET FUNCTION BY +1 AND MULTIPLY TO TONE GENERATOR FREQUENCY CONTROL
	endif

	;jitter2
	if gkjitter2OnOff=1 then	;IF 'jitter2' BUTTON IS 'ON'...
		;KOUT		JITTER2	KTOTAMP         |    KAMP1     |    KCPS1     |   KAMP2      |   KCPS2      |    KAMP3     |   KCPS3
		kjitter2	jitter2 gkjitter2Totamp, gkjitter2Amp1, gkjitter2Cps1, gkjitter2Amp2, gkjitter2Cps2, gkjitter2Amp3, gkjitter2Cps3	;CREATE A RANDOM FUNCTION USING jitter2                                   
		kToneFrq	=	kToneFrq * (1+kjitter2)	;OFFSET FUNCTION BY +1 AND MULTIPLY TO TONE GENERATOR FREQUENCY CONTROL
	endif

	;jspline
	if gkjsplineOnOff=1 then	;IF 'jspline' BUTTON IS 'ON'...
		;KOUT		JSPLINE	AMPLITUDE    |    KCPSMIN     |   KCPSMAX
		kjspline	jspline gkjsplineAmp, gkjsplineCpsMin, gkjsplineCpsMax	;CREATE A RANDOM FUNCTION USING jspline                                   
		kToneFrq	=	kToneFrq * (1+kjspline)                         ;OFFSET FUNCTION BY +1 AND MULTIPLY TO TONE GENERATOR FREQUENCY CONTROL
	endif

	;gauss
	if gkgaussOnOff=1 then	;IF 'gauss' BUTTON IS 'ON'...
		kgauss		gauss		gkgaussAmp	;GENERATE GAUSSIAN NOISE (FREQUENCY IS EQUAL TO kr/CONTROL RATE)
		kmetro		metro		gkgaussCPS	;CREATE A METRONOME THAT WILL BE USED TO DOWNSAMPLE GAUSSIAN NOISE FUNCTION
		kgaussSH	samphold	kgauss, kmetro	;SAMPLE AND HOLD GAUSSIAN NOISE FUNCTION
		kToneFrq	=	kToneFrq * (1+kgaussSH)	;OFFSET FUNCTION BY +1 AND MULTIPLY TO TONE GENERATOR FREQUENCY CONTROL 
	endif		;END OF THIS CONDITIONAL BRANCH

	;gaussi
	if gkgaussiOnOff=1 then	;IF 'gaussi' BUTTON IS 'ON'...
		kgaussi		gaussi		gkgaussiRange,gkgaussiAmp,gkgaussiCPS	;GENERATE INTERPOLATING GAUSSIAN NOISE
		kToneFrq	=	kToneFrq * (1+kgaussi)	;OFFSET FUNCTION BY +1 AND MULTIPLY TO TONE GENERATOR FREQUENCY CONTROL 
	endif		;END OF THIS CONDITIONAL BRANCH
	
	aenv	linsegr	0,0.02,0.3,0.02,0	;CREATE AN AMPLITUDE ENVELOPE THAT WILL BE USED TO PREVENT CLICKS AT THE BEGINNING AND THE END OF NOTES
	a1	poscil	gkToneAmp*aenv, kToneFrq, gisine	;CREATE AN AUDIO SINE TONE USING CSOUND'S PRECISION OSCILLATOR
		outs	a1			;SEND AUDIO TO OUTPUTS
endin

</CsInstruments>

<CsScore>
f 0 3600	;'DUMMY' SCORE EVENT KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>