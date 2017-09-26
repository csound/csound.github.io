ptrack.csd
Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr 	= 	44100	;SAMPLE RATE
ksmps 	= 	16	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 	= 	1	;NUMBER OF CHANNELS (1=MONO)
0dbfs	=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL		WIDTH | HEIGHT | X | Y
	FLpanel		"ptrack", 	500,      260,   0,  0

;SWITCHES	  	             				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff, ihOnOff	FLbutton	"On/Off",		1,    0,    22,    140,     25,   10,  5,    0,      1,      0,       -1
gkmeters, ihmeters	FLbutton	"Meters On/Off",	1,    0,    22,    140,     25,   10, 60,   -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihmeters		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			LABEL | WIDTH | HEIGHT | X | Y
idrms				FLvalue	" ",	 80,      20,   10, 115
idcps				FLvalue	" ",	 80,      20,   10, 165
idthresh			FLvalue	" ",	 50,      18,  385,  47

;SLIDERS				            					MIN   | MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X  | Y
gkInGain, ihInGain		FLslider 	"Input Gain",				0,         5,  0,    23,        -1,   160,    25,   160,    5
gkGateThresh, ihGateThresh	FLslider 	"Gate Threshold",			-90,       0,  0,    23,  idthresh,   160,    25,   330,    5
gkrms, gihrms			FLslider 	"rms",					0,         1,  0,    21,     idrms,   480,    25,    10,   90
gkcps, gihcps			FLslider 	"cps",					20,    10000, -1,    21,     idcps,   480,    25,    10,  140

;COUNTERS					     				MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkhopsize, gihhopsize	FLcount  	"Hop Size", 				64,   4096,   1,       1,     2,     120,     25,   10, 190,   -1 
gkpeaks, ihpeaks	FLcount  	"Num. Peaks", 				1,     80,   1,      10,     1,     140,     25,  150, 190,   -1 

FLsetColor2	220,100,100,gihrms	;ADD A BIT OF COLOUR TO METERS
FLsetColor2	100,220,100,gihcps      ;ADD A BIT OF COLOUR TO METERS

;SET INITIAL VALUES FOR SLIDERS 	VALUE | HANDLE
			FLsetVal_i	1,	ihInGain
			FLsetVal_i	-20,	ihGateThresh
			FLsetVal_i	1,	ihmeters
			FLsetVal_i	6,	gihhopsize
			FLsetVal_i	20,	ihpeaks

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                     WIDTH | HEIGHT | X | Y
				FLpanel	"info.",  515,    400,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                            ptrack                           ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"The opcode 'ptrack' tracks pitch and amplitude using short-  ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"-time Fourier transform.                                     ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"The rate at which readings are taken can be modified using   ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"the hopsize parameter. The FLTK counter setting is the value ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"to which 2 is raised to create the hopsize. Therefore a      ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"counter value of 6 will produce a hopsize of 64.             ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"In this implementation hopsize defaults to its maximum       ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"setting (in order to declare the maximum space needed for    ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"storage and prevent segmentation fault crashes) but it is    ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"advised to reduce this for more responsive results.          ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"'Num. Peaks' defines the number of spectral peaks used in the", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"analysis.                                                    ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"In this example the live audio input is scanned and analysed ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"and the resulting pitch and amplitude readings are used in   ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"the synthesis of a triangle wave tone.                       ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"A simple noise gate, the threshold of which can be adjusted, ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"has been inserted before the ptrack pitch tracker in order to", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"block extraneous noise between notes.                        ", 	1,      5,     14,    490,    15,     5, 380

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

giWave	ftgen	0, 0, 1024, 10, 1, 0.2, 0.15, 0.1, 0.2, 0.1, 0.05, 0.02, .01	;A RICH TONE - USED BY THE PITCH TRACKING SYNTHESIZER

instr	HopSizes
	ivals	ftgentmp	0,0,-7,-2, 64,128,256,512,1024,2048,4096	;TABLE THAT STORES THE NON-SEQUENTIAL VALUES
	indx	init	i(gkhopsize)					;INDEX USED TO REFERENCE VALUES IN THE ABOVE TABLE
	ival	table	indx,ivals					;INITIAL VALUE FOR THE COUNTER AT START-UP
	
	kup	trigger	gkhopsize,ival,0				;TRIGGER GENERATED WHEN COUNTER IS INCREASED
	kdn	trigger	gkhopsize,ival,1				;TRIGGER GENERATED WHEN COUNTER IS DECREASED
	
	if kup==1 then							;IF STEPPING UP...
	 reinit UPDATE1							;REINITIALISE STARTING FROM THE NEXT LINE
	 UPDATE1:							
	 indx = indx + 1						;INCREMENT INDEX
	 ival	table	indx,ivals					;READ NEW VALUE FROM NON SEQUENTIAL LIST TABLE
	 FLsetVal_i	ival,gihhopsize					;WRITE VALUE TO COUNTER
	 rireturn							;RETURN FROM REINITIALISATION
	elseif kdn==1 then						;SIMILAR PROCEDURE FOR WHENEVER COUNTER IS STEPPING DOWN
	 reinit UPDATE2
	 UPDATE2:
	 indx = indx - 1
	 ival	table	indx,ivals
	 FLsetVal_i	ival,gihhopsize	
	 rireturn
	endif
endin

instr 		1
	if	gkOnOff=0	then			;IF FLTK ON/OFF SWITCH IS OFF...
		turnoff					;...TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif						;END OF THIS CONDITIONAL BRANCH
	aL		inch	1			;READ FIRST/LEFT AUDIO INPUT TO THE COMPUTER
	krms		rms	aL			;CREATE AN RMS READINGS OF AUDIO SIGNAL
	kdb		=	dbamp(krms)		;CONVERT RMS READINGS TO DECIBEL
	kgate		=	(kdb<gkGateThresh?0:1)	;IF DECIBEL READING DROPS BELOW GATE THRESHOLD, GATE FLIPS TO ZERO, OTHERWISE IT IS '1'
	kgate		port	kgate,0.05		;SMOOTH THE OPENING AND CLOSING OF THE GATE
	agate		interp	kgate
	aL		=	aL*agate		;APPLY GATE TO THE AUDIO SIGNAL
	kupdatetrig	changed	gkhopsize,gkpeaks	;IF HOPSIZE OR PEAKS COUNTER IS CHANGED GENERATE A MOMENTARY 1 IN THE OUTPUT
	if kupdatetrig==1 then				;IF HOPSIZE OR PEAKS HAS BEEN CHANGED...
	  reinit UPDATE					;...BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE'
	endif						;END OF CONDITIONAL BRANCH
	UPDATE:						;LABEL 'UPDATE'. REINITIALISATION BEGINS FROM HERE.
	kcps,kdb	ptrack	aL,i(gkhopsize),i(gkpeaks)	;SCAN AMPLITUDE AND PITCH USING ptrack
	rireturn					;RETURN FROM REINITIALISATION
	kdb	portk	kdb,0.01			;SMOOTH DB READING SIGNAL
	kenv	linsegr	0,0.05,1,0.05,0
	asig	poscil	ampdb(kdb)*kenv,kcps,giWave	;CREATE AN AUDIO OSCILLATOR (TRIANGLE WAVE) USING SCANNED PITCH AND AMPLITUDE
		out	asig				;SEND AUDIO TO OUTPUT
	if gkmeters==1 then				;IF DISPLAY METERS BUTTON IS ACTIVE...
	  kmetro	metro	10			;METERS UPDATE TRIGGER - 10 TIMES A SECOND
	  FLsetVal	kmetro,krms,gihrms		;UPDATE RMS METER
	  FLsetVal	kmetro,kcps,gihcps		;UPDATE PITCH METER
	endif						;END OF CONDITIONAL BRANCH
endin

</CsInstruments>

<CsScore>
i "HopSizes" 0 3600
</CsScore>

</CsoundSynthesizer>