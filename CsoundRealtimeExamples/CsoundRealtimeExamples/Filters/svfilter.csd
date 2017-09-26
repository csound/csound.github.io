;Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
-odevaudio -b400
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
kr 		= 	441	;CONTROL RATE
ksmps 		= 	100	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;					LABEL      | WIDTH | HEIGHT | X | Y
				FLpanel	"svfilter",   500,    330,    0,  0

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	6,        9,    15,    490,   120,     5, 150	;BORDER AROUND FILTER OUTPUT GAIN CONTROLS

;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,    0,    22,    150,     25,    5,  5,    0,      1,      0,      -1
gkscl,ihscl		FLbutton	"Scaling On/Off",	1,    0,    22,    150,     25,  345,  5,    -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihscl		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idcf				FLvalue	" ",       80,    20,     5,  75
idq				FLvalue	" ",       80,    20,     5, 125
idLowGain			FLvalue	" ",       80,    25,   400, 180
idHighGain			FLvalue	" ",       80,    25,   400, 205
idBandGain			FLvalue	" ",       80,    25,   400, 230
idGlobalGain			FLvalue	" ",       80,    20,     5, 305

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"FILTER OUTPUT GAINS",	1,       6,    14,    160,     25,   10, 155

;SLIDERS					            			MIN | MAX | EXP | TYPE |    DISP      | WIDTH | HEIGHT | X  | Y
gkcf,ihcf			FLslider 	"Filter Cutoff",		20,  20000, -1,    23,           idcf,    490,     25,     5,  50
gkq,ihq				FLslider 	"Q",				1,     500, -1,    23,            idq,    490,     25,     5, 100
gkLowGain,ihLowGain		FLslider 	"Low",				0,       1,  0,    23,      idLowGain,    350,     25,    50, 180
gkHighGain,ihHighGain		FLslider 	"High",				0,       1,  0,    23,     idHighGain,    350,     25,    50, 205
gkBandGain,ihBandGain		FLslider 	"Band",				0,       1,  0,    23,     idBandGain,    350,     25,    50, 230
gkGlobalGain,ihGlobalGain	FLslider 	"Global Amplitude Rescale",	0,       1,  0,    23,   idGlobalGain,    490,     25,     5, 280

FLsetAlign 4, ihLowGain
FLsetAlign 4, ihHighGain
FLsetAlign 4, ihBandGain

;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	1000, 	ihcf
				FLsetVal_i	6, 	ihq
				FLsetVal_i	0.5, 	ihLowGain
				FLsetVal_i	0, 	ihHighGain
				FLsetVal_i	0, 	ihBandGain
				FLsetVal_i	0.2, 	ihGlobalGain
			
				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 240, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                        svfilter                             ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"svfilter is an implementation of a resonant second order     ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"filter, with simultaneous lowpass, highpass and bandpass     ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"outputs.                                                     ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"In addition to the expected parameters for cutoff frequency  ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"and Q (resonance) there is a switch for response scaling.    ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"This can be useful in preventing overloading.                ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"**WARNING** AT THE TIME OF WRITING SVFILTER APPEARS TO BE    ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"RATHER UNSTABLE AND HAS A TENDENCY TO 'BLOW UP' WITH HIGHER  ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"CUTOFF FREQUENCY (STILL BELOW THE NYQUIST FREQUENCY). THIS   ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"PROBLEM IS WORSE WHEN LOWER Q VALUES ARE EMPLOYED.           ", 	1,      5,     14,    490,    15,     5, 220

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1
	if	gkOnOff=0	then	;IF On/Off SWITCH IS SET TO 'OFF'...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	kporttime	linseg	0,0.001,0.005,1,0.005	;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A SET VALUE
	kcf	portk	gkcf, kporttime	;SMOOTH MOVEMENT OF SLIDER VARIABLE
	;OUTPUTS	OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
	asigL, asigR	diskin2	"Seashore.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)
	kSwitch		changed	gkscl	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	START			;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif
	START:
	alowL, ahighL, abandL 	svfilter  asigL, kcf, gkq , i(gkscl)	;FILTER EACH CHANNEL SEPARATELY USING svfilter 
	alowR, ahighR, abandR 	svfilter  asigR, kcf, gkq , i(gkscl)	;FILTER EACH CHANNEL SEPARATELY USING svfilter 
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
	aOutL		sum	alowL * gkLowGain, ahighL * gkHighGain, abandL * gkBandGain	;CREATE A MIX FOR THE LEFT AND RIGHT OUTPUT SIGNALS
	aOutR		sum	alowR * gkLowGain, ahighR * gkHighGain, abandR * gkBandGain	;CREATE A MIX FOR THE LEFT AND RIGHT OUTPUT SIGNALS
		outs	aOutL * gkGlobalGain, aOutR * gkGlobalGain	;SEND FILTER OUTPUT TO THE AUDIO OUTPUTS AND SCALE USING THE FLTK SLIDER DERIVED VARIABLE gkGlobalGain
endin
  	
</CsInstruments>

<CsScore>
;INSTR | START | DURATION
i  1       0       3600	;INSTRUMENT 1 PLAYS FOR 1 HOUR
</CsScore>
</CsoundSynthesizer>

























