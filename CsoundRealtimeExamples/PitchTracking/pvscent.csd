; pvscent.csd
; Written by Iain McCurdy, 2015

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>


<CsInstruments>

sr	= 	44100
ksmps	= 	32
nchnls	= 	1
0dbfs	=	1	;MAXIMUM SOUND INTENSITY LEVEL REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL      | WIDTH | HEIGHT | X | Y
	FLpanel	"pvscent",    500,    280,    0,  0

;SWITCHES  	                         		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    100,     25,    5,  5,    0,      1,      0,      -1
gkmeters, ihmeters	FLbutton	"Meters On/Off",1,    0,    22,    120,     25,    5,155,   -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihmeters		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES		LABEL | WIDTH | HEIGHT | X | Y
idGateThresh		FLvalue	" ",	 80,      20,  110,  20
idInGain		FLvalue	" ",	 80,      20,    5,  75
idSmooth		FLvalue	" ",	 80,      20,    5, 125
idcent			FLvalue	" ",	 80,      20,    5, 205
idOutGain		FLvalue	" ",	 80,      20,    5, 255

;SLIDERS								MIN   | MAX | EXP | TYPE |     DISP      | WIDTH | HEIGHT | X  | Y
gkGateThresh, ihGateThresh	FLslider 	"Gate Threshold",	0.001, 0.1,   -1,    23,    idGateThresh,   385,     15,  110,    5
gkInGain, ihInGain		FLslider 	"Input Gain",		0,       3,    0,    23,    idInGain,       490,     25,    5,   50
gkSmooth, ihSmooth		FLslider 	"Smoothing",		0,     0.5,    0,    23,    idSmooth,       490,     25,    5,  100
gkcent, gihcent			FLslider 	"Cent Output",		50,   1000,   -1,    21,    idcent,         490,     25,    5,  180
gkOutGain, ihOutGain		FLslider 	"Output Gain",		0,       1,    0,    23,    idOutGain,      490,     25,    5,  230

;SET INITIAL VALUES FOR VALUATORS	VALUE | HANDLE
			FLsetVal_i	0.02, 	ihGateThresh
			FLsetVal_i	1, 	ihInGain
			FLsetVal_i	0.05, 	ihSmooth
			FLsetVal_i	1, 	ihmeters
			FLsetVal_i	0.7, 	ihOutGain

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     420,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          pvscent                            ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"pvscent detects the spectral centroid of an audio signal so  ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"rather than trying to detect the fundemental of a harmonic   ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"input it will output the centre of gravity of a spectrum. In ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"this example it is probably best to experiment with various  ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"sibalent sounds, 'shhh' etc. in order to get an sense of its ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"abilities. Normal singing can also be tracked but the tracked", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"value is not the fundemental but is rather dependent upon    ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"both the fundemental (note sung) and the vowel expressed. For", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"example, 'eee' sounds will produce a higher spectral centroid", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"than a vowel sound at the same pitch with softer overtones   ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"such as 'ooh'.                                               ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"The output reading is likely to jitter quite a lot so for    ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"this reason I have added portamento smoothing to the output. ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"Experiment with different 'Smoothing' values (portamento     ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"time) to achieve best results.                               ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"This opcode doesn't track amplitude but I have added this for", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"use by the output tone using the 'follow2' opcode.           ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"A noise gate can be used to block background noise when the  ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"main sound is silent.                                        ", 	1,      5,     14,    490,    15,     5, 400
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

giWave	ftgen	0, 0, 1024, 10, 1, 0.2, 0.15, 0.1, 0.2, 0.1, 0.05, 0.02, .01	;A RICH TONE - USED BY THE PITCH TRACKING SYNTHESIZER

instr	1	;
	if	gkOnOff=0	then			;IF On/Off SWITCH IS SET TO 'Off'
		turnoff					;TURN THIS INSTRUMENT
	endif						;END OF CONDITIONAL BRANCHING

	asig	inch	1				;READ LIVE AUDIO FROM COMPUTER'S 1ST INPUT CHANNEL
	krms	rms	asig
	kgate	init	1
	kgate	=	krms<gkGateThresh ? 0 : 1
	agate	interp	kgate
	asig	=	asig * agate	 
	fsig  		pvsanal		asig*gkInGain, 1024, 256, 1024, 1	;ANALYSE THE AUDIO SIGNAL. OUTPUT AN F-SIGNAL.      	
	kcent		pvscent		fsig					;ANALYSE THE FSIG
	kporttime	linseg	0,0.001,1
	kcent		portk	kcent,kporttime*gkSmooth

	/* METERS */
	if gkmeters==1 then
	 kmetro	metro	16
	 if kmetro==1 then
	  FLsetVal	1,kcent,gihcent
	 endif
	endif

	aFollow		follow2	asig,0.05,0.05
	aout		poscil		aFollow,kcent,giWave
			out		aout * gkOutGain	;SEND THE RESCALED, RESYNTHESIZED SIGNAL TO THE AUDIO OUTPUTS
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT ALLOWS REALTIME PLAYING FOR UP TO 1 HOUR
</CsScore>

</CsoundSynthesizer>