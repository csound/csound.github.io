;pvspitch.csd
;Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-idevaudio -odevaudio -b1024 -dm0
</CsOptions>


<CsInstruments>

sr	= 	44100
ksmps	= 	32
nchnls	= 	1
0dbfs	=	1	;MAXIMUM SOUND INTENSITY LEVEL REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL      | WIDTH | HEIGHT | X | Y
	FLpanel	"pvspitch",   500,    200,    0,  0

;SWITCHES  	                         		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    100,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES		LABEL | WIDTH | HEIGHT | X | Y
idInGain		FLvalue	" ",	 80,      20,    5,  75
idthresh		FLvalue	" ",	 80,      20,    5, 125
idOutGain		FLvalue	" ",	 80,      20,    5, 175

;SLIDERS							MIN   | MAX | EXP | TYPE |     DISP   | WIDTH | HEIGHT | X  | Y
gkInGain, ihInGain	FLslider 	"Input Gain",		0,       3,    0,    23,    idInGain,    490,     25,    5,   50
gkthresh, ihthresh	FLslider 	"Threshold",		0.001,   1,    0,    23,    idthresh,    490,     25,    5,  100
gkOutGain, ihOutGain	FLslider 	"Output Gain",		0,       1,    0,    23,    idOutGain,   490,     25,    5,  150

;SET INITIAL VALUES FOR VALUATORS	VALUE | HANDLE
			FLsetVal_i	1, 	ihInGain
			FLsetVal_i	0.2, 	ihthresh
			FLsetVal_i	0.7, 	ihOutGain

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     180,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          pvspitch                           ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"'pvspitch' analyses a fsig and generates k-rate estimates of ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"fundemental frequency and amplitude. In this example the live", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"audio input is analysed and the analysed data is used to     ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"define the frequency and amplitude of a synthesized tone.    ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"Threshold can be used to define a threshold beneath which    ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"sound components will be ignored. This can be used to filter ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"out ambient noise between notes from the analysis.           ", 	1,      5,     14,    490,    15,     5, 160
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

giwaveform	ftgen	0,0,4096,10,1,1/4,1/16,1/32,1/64	;SINGLE CYCLE OF A HARMONIC TONE

instr	1	;
	if	gkOnOff=0	then			;IF On/Off SWITCH IS SET TO 'Off'
		turnoff					;TURN THIS INSTRUMENT
	endif						;END OF CONDITIONAL BRANCHING

	asig	inch	1				;READ LIVE AUDIO FROM COMPUTER'S 1ST INPUT CHANNEL
	fsig  		pvsanal		asig*gkInGain, 1024, 256, 1024, 1	;ANALYSE THE AUDIO SIGNAL. OUTPUT AN F-SIGNAL.      	
	kfr, kamp	pvspitch	fsig, gkthresh				;ANALYSE THE FSIG AND OUTPUT ESTIMATIONS OF FUNDEMENTAL FREQUENCY AND AMPLITUDE 
	aout		oscili		kamp, kfr, giwaveform			;CREATE AN OSCILLATOR, THE FREQUENCY AND AMPLITUDE OF WHICH ARE BASED ON DATA DERIVED FROM THE LIVE INPUT AUDIO STREAM
			out		aout*gkOutGain	;SEND THE RESCALED, RESYNTHESIZED SIGNAL TO THE AUDIO OUTPUTS
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT ALLOWS REALTIME PLAYING FOR UP TO 1 HOUR
</CsScore>

</CsoundSynthesizer>