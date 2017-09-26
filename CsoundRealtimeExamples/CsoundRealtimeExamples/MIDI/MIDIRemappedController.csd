MIDIRemappedController.csd
Written by Iain McCurdy 2006. Updated 2011.

<CsoundSynthesizer>

<CsOptions>
-odac -Ma -m0
</CsOptions>    

<CsInstruments>

sr 	= 	44100	;SAMPLE RATE
ksmps 	= 	4	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 	= 	1	;NUMBER OF CHANNELS (1=MONO)
0dbfs	=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
		FLpanel	"Rescaled Controller", 300, 110, 0, 0                   

;FLCOUNTERS						MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkTabNum, ihTabNum 	FLcount  "Table Number",	1,     5,    1,      1,      2,    100,     25,    100, 10,   -1

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idporttime			FLvalue	"",        50,    17,     5,  85

;SLIDERS						MIN | MAX | EXP | TYPE |   DISP    | WIDTH | HEIGHT | X | Y
gkporttime, ihporttime	FLslider "Portamento Time",	0,    0.1,   0,    23,  idporttime,   290,     15,    5,  70

;INITIALISE VALUATORS		VALUE | HANDLE
		FLsetVal_i	 1, 	ihTabNum
		FLsetVal_i	 0.01, 	ihporttime                                                                                                   
				FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 515,     600,   315, 0
				FLscroll     515,     600,    0,  0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"    Remap a ctrl7 derived variable using a function table    ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"ctrl7's fourth input parameter (which is optional) can be    ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"used to reference a function table that will remap the       ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"default linear output of ctrl7 in the manner of a transfer   ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"function.                                                    ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"The function table used can use any GEN routine and can be   ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"any shape but this example provides five table options which ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"should allude to some of the possibilities.                  ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"Note that tables sizes need to be a power-of-2 + 1.          ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"The MIDI keyboard plays a tone, the frequency of which can   ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"then be modulated by moving controller 1.                    ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"The influence that controller 1 has over pitch across its    ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"travel is defined by the 'Table Number' chosen.              ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"If you have Csound displays enabled (i.e. don't use -d flag) ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"you can also view these function tables.                     ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"Here are brief descriptions of the five function tables:     ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"1. Size Gen val dur val dur val                              ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"   129   7   0   64  1   64  -1                              ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"   GEN07, linear envelope, transposition rises from unison to", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"   +1 octave over the first half of the controller's travel  ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"   then for the second half of its travel drops to -1 octave.", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"2. Size Gen Type Level                                       ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"   9     21   1    1                                         ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"   Sparse uniform random distribution. Because of the very   ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"   small table size (8+1) remapping will be done in 8 equal  ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"   blocks, each stretching for 16 MIDI values. Range +-1 oct.", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"3. Size Gen Type Level                                       ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"   129   21   1   1                                          ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"   A Dense uniform random with a new random value for each   ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"   MIDI controller value. Again range is +/-1 octave.        ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"4. Size Gen val dur shape val dur shape val                  ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"   129  16   0  64    4   0.5 64    -4   1                   ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"   'S'-shape curve. Transposition rises from unison to +1 oct", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"   but not in a linear fashion. Rate of increase rises       ", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"   gradually, reaching a maximum rate halfway through the    ", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"   controllers travel. Rate of increase thereafter decreases ", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"   until the controller finally settles on a transposition of", 	1,      5,     14,    490,    20,     5, 820
ih		 	FLbox  	"   +1 octave at the end of its travel.                       ", 	1,      5,     14,    490,    20,     5, 840
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 860
ih		 	FLbox  	"5. Size Gen loc val loc val  loc  val   loc  val             ", 	1,      5,     14,    490,    20,     5, 880
ih		 	FLbox  	"   129  17   0   0  32  4/12 64   7/12  96    1              ", 	1,      5,     14,    490,    20,     5, 900
ih		 	FLbox  	"   Stepped function that plays through an arpeggio-like      ", 	1,      5,     14,    490,    20,     5, 920
ih		 	FLbox  	"   sequence of transpositions when the controller is moved.  ", 	1,      5,     14,    490,    20,     5, 940
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 960
ih		 	FLbox  	"'Portamento Time' determines the amount of smoothing applied ", 	1,      5,     14,    490,    20,     5, 980
ih		 	FLbox  	"to movements of the controller. Setting this to zero removes ", 	1,      5,     14,    490,    20,     5,1000
ih		 	FLbox  	"the effect altogether.                                       ", 	1,      5,     14,    490,    20,     5,1020
				FLscroll_end
				FLpanel_end
				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

seed	0	;SEED RANDOM NUMBER GENERATORS FROM SYSTEM CLOCK: ENSURE THAT CONTENTS OF RANDOM DISTRIBUTION TABLES WILL BE DIFFERENT FOR EACH PERFORMANCE

giRemapFunc1	ftgen 	1,0,129,-7,0,64,1,64,-1			;LINEAR BREAK-POINT FUNCTION
giRemapFunc2	ftgen 	2,0,9,21,1,1				;SPARSE UNIFORM RANDOM DISTRIBUTION (ONLY 8 VALUES)
giRemapFunc3	ftgen 	3,0,129,21,1,1				;DENSE UNIFORM RANDOM DISTRIBUTION (128 VALUES)
giRemapFunc4	ftgen 	4,0,129,-16,0,64,4,0.5,64,-4,1		;S-SHAPE SPLINE. CONCAVE FOR THE FIRST HALF THEN CONVEX FOR THE SECOND HALF
giRemapFunc5	ftgen 	5,0,129,-17,0,0,32,4/12,64,7/12,96,1	;STEPPED FUNCTION. FOUR STEPS OF EQUAL WIDTH.

instr	1
	icps	cpsmidi		;READ IN MIDI NOTE NUMBER AND CONVERT TO CYCLES PER SECOND VALUE

	ktrig	changed	gkTabNum	;IF TABLE NUMBER FLTK COUNTER IS CHANGED GENERATE A TRIGGER IMPULSE
	if ktrig=1 then			;IF TABLE NUMBER FLTK COUNTER HAS BEEN CHANGED...
	  reinit	UPDATE		;...BEGIN A REINITIALISATION PASS FOR LABEL 'UPDATE'
	endif				;END OF CONDITIONAL BRANCH
	UPDATE:				;LABEL CALLED 'UPDATE'. REINITIALISATION PASS BEGINS FROM HERE
	;OUTPUT		OPCODE	CHANNEL | CTRLNUMBER | MINIMUM | MAXIMUM | F.N._USED_TO_REMAP_SLIDER_VALUES
	koct		ctrl7	1,            1,          0,        1,      i(gkTabNum) 			;READ CONTROLLER INFORMATION FROM CONTINUOUS CONTROLLER NUMBER 1 ON MIDI CHANNEL 1, RESCALE TO BE WITHIN THE RANGE 0 - 1 THEN REMAP AGAIN ACCORDING TO FUNCTION TABLE NO. 2
	rireturn			;RETURN FROM REINITILISATION PASS

	if gkporttime>0 then				;I.E. IF PORTAMENTO TIME IS ZERO DO NOT EXECUTE THE FOLLOWING BLOCK OF CODE
	  kporttime	linseg	0,0.01,1		;A FUNCTION THAT QUICKLY RAMPS UP FROM ZERO TO A HELD VALUE THAT WILL BE USED AS PORTAMENTO TIME
	  kporttime	=	kporttime*gkporttime	;SCALE PORTAMENTO FUNCTION WITH VALUE OF FLTK SLIDER
	  koct	portk	koct,kporttime			;APPLY PORTAMENTO SMOOTHING TO VARIABLE
	endif
	
	;OUTPUT	OPCODE	AMPLITUDE |      FREQ.        | WAVEFORM(TRIANGLE) | PULSE WIDTH
	asig	vco2	0.2,        icps*octave(koct),         4 ,              0.5
	aenv	linsegr	0,0.01,1,0.1,0		;ANTI-CLICK AMPLITUDE ENVELOPE
		out	asig*aenv		;SEND AUDIO SIGNAL TO THE OUTPUT
endin

</CsInstruments>

<CsScore>
f 0 3600
</CsScore>

</CsoundSynthesizer>