; plltrack.csd
; Written by Iain McCurdy, 2011

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
	FLpanel		"plltrack", 	500,      500,   0,  0

;SWITCHES	  	             				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff, ihOnOff	FLbutton	"On/Off",		1,    0,    22,    140,     25,   10,  5,    0,      1,      0,       -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES		LABEL | WIDTH | HEIGHT | X | Y
idGthresh		FLvalue	"",	 50,      18,  385,  47
idd			FLvalue	"",	 50,      18,    5, 100
idloopf			FLvalue	"",	 50,      18,    5, 150
idloopq			FLvalue	"",	 50,      18,    5, 200
idlf			FLvalue	"",	 50,      18,    5, 250
idhf			FLvalue	"",	 50,      18,    5, 300
idthresh		FLvalue	"",	 50,      18,    5, 350

;SLIDERS				            					MIN   | MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X  | Y
gkInGain, ihInGain		FLslider 	"Input Gain",				0,         5,  0,    23,        -1,   160,    25,    160,    5
gkGateThresh, ihGateThresh	FLslider 	"Gate Threshold",			-90,       0,  0,    23,  idGthresh,   160,    25,    330,    5
gkd, ihd			FLslider 	"Feedback",				0,         1,  0,    23,  idd,        490,    25,      5,   75
gkloopf, ihloopf		FLslider 	"LPF CF: Freq. Range",			20,    20000, -1,    23,  idloopf,    490,    25,      5,  125
gkloopq, ihloopq		FLslider 	"LPF Q: Rise Time of FO",		0.001,     1, -1,    23,  idloopq,    490,    25,      5,  175
gklf, ihlf			FLslider 	"Lowest Frequency",			20,     5000, -1,    23,  idlf,       490,    25,      5,  225
gkhf, ihhf			FLslider 	"Highest Frequency",			20,     5000, -1,    23,  idhf,       490,    25,      5,  275
gkthresh, ihthresh		FLslider 	"Threshold",				0.0001,   0.1,-1,    23,  idthresh,   490,    25,      5,  325


;SET INITIAL VALUES FOR SLIDERS 	VALUE | HANDLE
			FLsetVal_i	1,	ihInGain
			FLsetVal_i	-20,	ihGateThresh
			FLsetVal_i	0.1,	ihd
			FLsetVal_i	20,	ihloopf
			FLsetVal_i	1/3,	ihloopq
			FLsetVal_i	20,	ihlf
			FLsetVal_i	1500,	ihhf
			FLsetVal_i	0.001,	ihthresh

;SWITCHES	  	             				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkmeters, ihmeters	FLbutton	"Meter On/Off",		1,    0,    22,    140,     25,    5, 375,   -1
FLsetColor2	255, 255, 50, ihmeters		;SET SECONDARY COLOUR TO YELLOW
;VALUE DISPLAY BOXES			LABEL | WIDTH | HEIGHT | X | Y
idcps				FLvalue	" ",	 80,      20,    5, 425
idlock				FLvalue	" ",	 80,      20,    5, 475
;SLIDERS				            		MIN   | MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X  | Y
gkcps, gihcps	 FLslider 	"CPS",				20,    10000, -1,    21,   idcps,    490,    25,     5,  400
gklocks, gihlock FLslider 	"Lock",				0,         1,  0,    21,   idlock,   490,    25,     5,  450

FLsetColor2	100,220,100,gihcps      ;ADD A BIT OF COLOUR TO METERS

;SET INITIAL VALUES FOR SLIDERS 	VALUE | HANDLE
			FLsetVal_i	1,	ihmeters

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                     WIDTH | HEIGHT | X | Y
				FLpanel	"info.",  515,    360,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           plltrack                          ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"plltrack is a pitch tracker based on a phase-locked loop.    ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"The only required inputs are the audio signal and 'Feedback' ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"but I have added controls for all optional input arguments   ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"for experimentation.                                         ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"'Feedback' controls the frequency range of the tracker.      ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"'LPF CF' also affects the frequency range of the tracker.    ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"'LPF Q' controls the rise time of the tracker.               ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"There are controls for setting the output limits of the      ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"tracker and a threshold setting for an internal noise gate.  ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"I have also added the external noise gate that I have        ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"employed in the other pitch tracking examples.               ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"Applied to a monophonic input signal, plltrack should be very", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"fast to respond. It outputs tracked frequency at a-rate.     ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"The 'Lock' meter provides a measure of how successfully      ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"plltrack is currently tracking. 0=no success, 1=complete     ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"success.                                                     ", 	1,      5,     14,    490,    15,     5, 340

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

giWave	ftgen	0, 0, 1024, 10, 1, 0.2, 0.15, 0.1, 0.2, 0.1, 0.05, 0.02, .01	;A RICH TONE - USED BY THE PITCH TRACKING SYNTHESIZER


instr 		1
	if	gkOnOff=0	then			;IF FLTK ON/OFF SWITCH IS OFF...
		turnoff					;...TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif						;END OF THIS CONDITIONAL BRANCH
	aL		inch	1			;READ FIRST/LEFT AUDIO INPUT TO THE COMPUTER
	krms		rms	aL			;CREATE AN RMS READINGS OF AUDIO SIGNAL
	kgate		=	(krms<gkGateThresh?0:1)	;IF RMS READING DROPS BELOW GATE THRESHOLD, GATE FLIPS TO ZERO, OTHERWISE IT IS '1'
	agate		interp	kgate
	aL		=	aL*agate		;APPLY GATE TO THE AUDIO SIGNAL	
	acps, alock 	plltrack aL, gkd, gkloopf, gkloopq, gklf, gkhf, gkthresh	
	klock	downsamp	alock			;DOWNSAMPLE A-RATE TO K-RATE	
	aEnv	linsegr	0,0.05,1,0.05,0 
	aFollow		follow2	aL,0.05,0.05
	asig	poscil	agate*aFollow*aEnv,acps,giWave	;CREATE AN AUDIO OSCILLATOR (TRIANGLE WAVE) USING SCANNED PITCH AND AMPLITUDE
		out	asig				;SEND AUDIO TO OUTPUT
	if gkmeters==1 then				;IF DISPLAY METERS BUTTON IS ACTIVE...
	  kmetro	metro	10			;METERS UPDATE TRIGGER - 10 TIMES A SECOND
	  kcps	downsamp	acps			;DOWNSAMPLE A-RATE TO K-RATE
	  FLsetVal	kmetro,kcps,gihcps		;UPDATE PITCH METER
	  FLsetVal	kmetro,klock,gihlock		;UPDATE 'LOCK' METER
	endif						;END OF CONDITIONAL BRANCH
endin

</CsInstruments>

<CsScore>
f 0 3600
</CsScore>

</CsoundSynthesizer>