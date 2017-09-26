;Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-odevaudio -b400 -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
kr 		= 	441	;CONTROL RATE
ksmps 		= 	100	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;		LABEL   | WIDTH | HEIGHT | X | Y
	FLpanel	"ATSadd",  500,     350,   0,  0

;SWITCHES                                		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    150,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;NUMBER DISPLAY BOXES		WIDTH | HEIGHT | X | Y
idptr	  	FLvalue   "",	80,       20,    5,  75
idfmod	  	FLvalue   "",	80,       20,    5, 125
idspeed	  	FLvalue   "",	80,       20,    5, 225
idporttime  	FLvalue   "",	80,       20,    5, 275

;SLIDERS							MIN | MAX | EXP | TYPE | DISP    |  WIDTH | HEIGHT | X |  Y
gkptr, ihptr		FLslider	"Pointer",		0,     1,    0,    23,  idptr,       490,     25,    5,   50
gkfmod, ihfmod		FLslider	"Pitch Modulation",	0.25,  4,   -1,    23,  idfmod,      490,     25,    5,  100
gkspeed, ihspeed	FLslider	"Speed",		-2,    2,    0,    23,  idspeed,     490,     25,    5,  200
gkporttime, ihporttime	FLslider	"Portamento Time",	0,     1,    0,    23,  idporttime,  490,     25,    5,  250
gkRvbAmt, ihRvbAmt	FLslider	"Reverb Amount",	0,     1,    0,    23,  -1,          490,     25,    5,  300

;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | POS_X | POS_Y | OPCODE
gkpartials,ihpartials 		FLcount		"Partials",	1,    317,    1,     10,     21,   150,     25,       10,    150,     -1
gkpartialoffset,ihpartialoffset FLcount		"P. Offset",	0,    200,    1,     10,     21,   150,     25,      170,    150,     -1
gkpartialincr,ihpartialincr	FLcount		"P. Incr.",	1,    200,    1,     10,     21,   150,     25,      330,    150,     -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkptrmode, ihptrmode		FLbutBank	14,     1,     2,     18,      40,  290,  2,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"POINTER MODE:",1,       6,    14,    130,      20,  160,   0
ih		 	FLbox  	"Pointer",	1,       5,    12,     50,      20,  320,   0
ih		 	FLbox  	"Speed  ", 	1,       5,    12,     50,      20,  320,  20

;INITIAL VALUES OF SLIDERS
;OPCODE		VALUE | HANDLE
FLsetVal_i   	0.5, 	ihptr
FLsetVal_i   	0.5, 	ihfmod
FLsetVal_i   	30, 	ihpartials
FLsetVal_i   	8, 	ihpartialoffset
FLsetVal_i   	7, 	ihpartialincr
FLsetVal_i   	1, 	ihptrmode
FLsetVal_i   	0.1, 	ihspeed
FLsetVal_i   	0.01, 	ihporttime

FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 600, 512, 0

;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          ATSadd                             ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"ATSadd performs additive synthesis based on analysis data    ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"stored in a file that has been pre-analysed using Juan       ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"Pampin's ATS (Analysis - Transformation - Synthesis).        ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"The design of this opcode bears simularities to the pvadd    ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"opcode and the results are comparable.                       ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"'Partials' defines the number of partials that will be used  ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"in the resysnthesis. Reducing this value significantly will  ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"limit the number of higher frequencies that can be reproduced", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"and will therefore function as a lowpass filter.             ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"'P.Offset' raises a threshold below which partials will not  ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"be reproduced. This will have the effect of removing lower   ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"frequencies and the effect will be that of a highpass filter.", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"The time domain of the resynthesis is controlled using a time", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"pointer. In this implementation the user can choose between  ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"manual manipulation of the time pointer or control of the    ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"speed of an automated moving pointer.                        ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"'P.Incr' defines the counter increment between subsequent    ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"partials that will be resynthesized. In a straight           ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"resynthesis this value should be 1 so that all partials are  ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"included. Values greater than 1 will result in partials being", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"omitted in the resynthesis.                                  ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"The maximum partial number that can be with this example is  ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"311. Certain combinations of 'Partials', 'P.Offset' and      ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"'P.Incr' will demand partial numbers beyond this limit. These", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"will not be reproduced so the user should anticipate this    ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"situation by observing warnings given in the console output. ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"Crashes can also occur if combinations of values are demanded", 	1,      5,     14,    490,    20,     5, 560                                                              
ih		 	FLbox  	"that the opcode is not happy with.                           ", 	1,      5,     14,    490,    20,     5, 580                                                              
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
   
gisine	ftgen	0,0,65536,10,1

instr	1
#define ATS_FILE #"AndItsAll.ats"#
	if gkOnOff=0 then				;IF ON/OFF SWITCH IS OFF
		turnoff					;TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif						;END OF THIS CONDITIONAL BRANCH
	kporttime	linseg	0,0.001,1               ;RAMPING UP FUNCTION CONTRIBUTING TO PORTAMENTO TIME VARIABLE
	ifilelen	filelen	$ATS_FILE		;READ FILE LENGTH OF INPUT ATS ANALYSIS FILE
	if gkptrmode=0 then				;IF POINTER MODE SELECTION IS TO 'Pointer'...
		kptr	portk	gkptr*ifilelen, kporttime*gkporttime	;DEFINE TIME POINTER VALUE AND APPLY PORTAMENTO SMOOTHING	
	else						;OTHERWISE... (SPEED MODE SELECTED)
		kptr	phasor	gkspeed/ifilelen	;POINTER CREATED USING A PHASOR
		kptr	=	kptr*ifilelen		;PHASOR (0-1) RESCALED ACCORDING TO LENGTH OF ORIGINAL FILE
	endif						;END OF THIS CONDITIONAL BRANCH
	kfmod		portk	gkfmod, kporttime*gkporttime	;APPLY PORTAMENTO SMOOTHING TO PITCH RATIO VARIABLE
	ktrig		changed	gkpartials, gkpartialoffset, gkpartialincr	;IF ANY OF THE INPUT VARIABLES CHANGES GENERATE A MOMENTARY '1' AT THE OUTPUT
	if ktrig=1 then					;IF AN I-RATE SLIDER VARIABLE HAS BEEN CHANGED...
		reinit	UPDATE				;...BEGIN A RE-INITIALIZATION PASS FROM THE LABEL 'UPDATE'
	endif						;END OF THIS CONDITIONAL BRANCH
	UPDATE:						;LABEL 'UPDATE'
	asig		ATSadd	kptr, kfmod, $ATS_FILE, gisine, i(gkpartials), i(gkpartialoffset), i(gkpartialincr)	;PERFORM ATS RESYNTHESIS
	rireturn
	aRvbL, aRvbR	reverbsc	asig,asig,0.9,8000	;REVERB SIGNAL CREATED USING reverbsc
			outs	asig+aRvbL*gkRvbAmt, asig+aRvbR*gkRvbAmt
endin

</CsInstruments>

<CsScore>
f 0 3600
</CsScore>

</CsoundSynthesizer>