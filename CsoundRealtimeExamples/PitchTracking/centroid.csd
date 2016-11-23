; centroid.csd
; Written by Iain McCurdy, 2015

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr	= 	44100
ksmps	= 	32
nchnls	= 	1
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL      | WIDTH | HEIGHT | X | Y
	FLpanel	"centroid",    500,   330,    0,  0

;SWITCHES  	                         		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    100,     25,    5,  5,    0,      1,      0,      -1
gkmeters, ihmeters	FLbutton	"Meters On/Off",1,    0,    22,    120,     25,    5,155,   -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihmeters		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES		LABEL | WIDTH | HEIGHT | X | Y
idGateThresh		FLvalue	"",	 80,      20,  110,  20
idInGain		FLvalue	"",	 80,      20,    5,  75
idSmooth		FLvalue	"",	 80,      20,    5, 125
idcent			FLvalue	"",	 80,      20,    5, 205
idTrigRate		FLvalue	"",	 80,      20,    5, 255
idOutGain		FLvalue	"",	 80,      20,    5, 305

;SLIDERS								MIN   | MAX | EXP | TYPE |     DISP      | WIDTH | HEIGHT | X  | Y
gkGateThresh, ihGateThresh	FLslider 	"Gate Threshold",	0.001, 0.1,   -1,    23,    idGateThresh,   385,     15,  110,    5
gkInGain, ihInGain		FLslider 	"Input Gain",		0,       3,    0,    23,    idInGain,       490,     25,    5,   50
gkSmooth, ihSmooth		FLslider 	"Smoothing",		0,     0.5,    0,    23,    idSmooth,       490,     25,    5,  100
gkcent, gihcent			FLslider 	"Cent Output",		50,  10000,   -1,    21,    idcent,         490,     25,    5,  180
gkTrigRate, ihTrigRate		FLslider 	"Trigger Rate",		0,      10,    0,    23,    idTrigRate,     365,     25,    5,  230
gkOutGain, ihOutGain		FLslider 	"Output Gain",		0,       1,    0,    23,    idOutGain,      490,     25,    5,  280

;COUNTERS					     				MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkFFTsize, gihFFTsize	FLcount  	"FFT Size", 				64,   4096,   1,       1,     2,     120,     25,  375,230,   -1 

;SET INITIAL VALUES FOR VALUATORS	VALUE | HANDLE
			FLsetVal_i	0.02, 	ihGateThresh
			FLsetVal_i	1, 	ihInGain
			FLsetVal_i	0.05, 	ihSmooth
			FLsetVal_i	1, 	ihmeters
			FLsetVal_i	0, 	ihTrigRate
			FLsetVal_i	0.7, 	ihOutGain
			FLsetVal_i	4, 	gihFFTsize

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     500,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          centroid                           ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"centroid calculates the spectral centroid of an audio signal ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"using FFT. It appears to be quite similar to the pvscent     ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"except that it directly uses an audio signal as input (as    ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"opposed to an f-signal) and it also features a trigger input ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"which allows us to turn tracking on and off. When this       ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"trigger is off/zero then the opcode simply outputs the last  ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"centroid value calculated. This could be used to select when ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"to output a tracked centroid, for example during the sustain ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"portion of a sound, ignored the attack portion.              ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"'Smoothing' simply applies a defined amount of portamento to ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"the output signal.                                           ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"'Trigger Rate' controls the rate of a metronomic trigger that", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"triggers updates of the centroid tracker. (You will hear this", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"most clearly when 'Trigger Rate' is low and 'Smoothing' is   ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"zero.) If 'Trigger Rate' is zero the metronome is bypassed   ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"and the trigger value is always '1'.                         ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"Increasing 'FFT Size' should improve tracking accuracy,      ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"particularly for low frequencies, at the expense of some     ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"response speed. A rule of thumb is that 'FFT size' should be ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"as low as possible that will still produce accurate tracking.", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"The tracking signal is sonofied usig a simple tone. The      ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"output can also be displayed using a meter. If real-time     ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"audio is interrupted deactivate the meters.                  ", 	1,      5,     14,    490,    15,     5, 480
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

giWave	ftgen	0, 0, 1024, 10, 1, 0.2, 0.15, 0.1, 0.2, 0.1, 0.05, 0.02, .01	;A RICH TONE - USED BY THE PITCH TRACKING SYNTHESIZER

instr	FFTSizes
	ivals	ftgentmp	0,0,-7,-2, 64,128,256,512,1024,2048,4096	;TABLE THAT STORES THE NON-SEQUENTIAL VALUES
	indx	init	i(gkFFTsize)					;INDEX USED TO REFERENCE VALUES IN THE ABOVE TABLE
	ival	table	indx,ivals					;INITIAL VALUE FOR THE COUNTER AT START-UP
	
	kup	trigger	gkFFTsize,ival,0				;TRIGGER GENERATED WHEN COUNTER IS INCREASED
	kdn	trigger	gkFFTsize,ival,1				;TRIGGER GENERATED WHEN COUNTER IS DECREASED
	
	if kup==1 then							;IF STEPPING UP...
	 reinit UPDATE1							;REINITIALISE STARTING FROM THE NEXT LINE
	 UPDATE1:							
	 indx = indx + 1						;INCREMENT INDEX
	 ival	table	indx,ivals					;READ NEW VALUE FROM NON SEQUENTIAL LIST TABLE
	 FLsetVal_i	ival,gihFFTsize					;WRITE VALUE TO COUNTER
	 rireturn							;RETURN FROM REINITIALISATION
	elseif kdn==1 then						;SIMILAR PROCEDURE FOR WHENEVER COUNTER IS STEPPING DOWN
	 reinit UPDATE2
	 UPDATE2:
	 indx = indx - 1
	 ival	table	indx,ivals
	 FLsetVal_i	ival,gihFFTsize	
	 rireturn
	endif
endin

instr	1
	/* TURN THIS INSTRUMENT ON OR OFF */
	if	gkOnOff=0	then			;IF On/Off SWITCH IS SET TO 'Off'
		turnoff					;TURN THIS INSTRUMENT
	endif						;END OF CONDITIONAL BRANCHING

	/* INPUT */
	asig	inch	1				;READ LIVE AUDIO FROM COMPUTER'S 1ST INPUT CHANNEL

	/* NOISE GATE */
	krms	rms	asig
	kgate	init	1
	kgate	=	krms<gkGateThresh ? 0 : 1
	agate	interp	kgate
	asig	=	asig * agate

	/* CENTROID TRIGGER */
	if gkTrigRate==0 then
	 ktrig	=	1
	else
	 ktrig	metro	1;gkTrigRate
	endif
	
	/* CENTROID */
	kcent 	centroid asig, ktrig, i(gkFFTsize)
	kporttime	linseg	0, 0.001, 1
	kcent		portk	kcent, kporttime * gkSmooth

	/* METERS */
	if gkmeters==1 then
	 kmetro	metro	16
	 if kmetro==1 then
	  FLsetVal	1,kcent,gihcent
	 endif
	endif
	
	/* SONICFICATION */
	aFollow		follow2	asig,0.05,0.05
	aout		poscil		aFollow, kcent, giWave
			out		aout * gkOutGain	;SEND THE RESCALED, RESYNTHESIZED SIGNAL TO THE AUDIO OUTPUTS
endin

</CsInstruments>

<CsScore>
i "FFTSizes" 0 3600
</CsScore>

</CsoundSynthesizer>