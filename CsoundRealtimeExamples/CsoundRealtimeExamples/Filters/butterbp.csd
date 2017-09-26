;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-odevaudio -b400
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	2	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;					LABEL           | WIDTH | HEIGHT | X | Y
				FLpanel	"butterbp/butbp",  500,    200,    0,  0

;SWITCHES                       			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    140,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idfreq				FLvalue	" ",       70,    20,     5,   75
idband				FLvalue	" ",       70,    20,     5,  125
idgain				FLvalue	" ",       70,    20,     5,  175

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkskip, ihskip 			FLcount  "Initialisation 0-On 1-Off", 	0,     1,     1,      1,      2,    150,     25,   345, 5,    -1

;					            				MIN | MAX | EXP | TYPE |   DISP  | WIDTH | HEIGHT | X   | Y
gkfreq,ihfreq			FLslider 	"Filter Cutoff",		20,  20000, -1,    23,    idfreq,    490,     25,    5,    50
gkband,ihband			FLslider 	"Bandwidth",			1,   10000, -1,    23,    idband,    490,     25,    5,   100
gkgain, ihgain			FLslider 	"Output Amplitude Scaling",	0,       2,  0,    23,    idgain,    490,     25,    5,   150

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	900, 	ihfreq
				FLsetVal_i	10000, 	ihband
				FLsetVal_i	1, 	ihgain

				FLpanel_end
				
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 320, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                       butterbp/butbp                        ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"butterbp/butbp is an implementation of a second-order IIR    ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"Butterworth band-pass filter. Its input arguments are for    ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"filter cutoff frequency (in hertz), and bandwidth (also in   ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"hertz) of the spectral band that is allowed to pass through  ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"the filter. An optional 2-way switch (default=0) is provided ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"to select whether the data space for feedback within the     ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"filter is initially cleared or allowed to retain previously  ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"held information.                                            ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"butterbp/butbp is slower than the original filters in Csound ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"but provides an almost flat passband (particularly when      ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"compared to the reson filter).                               ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"Multiple iterations of the butterbp/butbp opcode applied to  ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"the signal path in series can be used to create a sharper    ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"cutoff slope.                                                ", 	1,      5,     14,    490,    15,     5, 300

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1
	if	gkOnOff=0	then	;IF On/Off SWITCH IS SET TO 'OFF'...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	kporttime	linseg	0,0.001,0.005,1,0.005	;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A SET VALUE	
	kfreq	portk	gkfreq, kporttime	;SMOOTH MOVEMENT OF SLIDER VARIABLE
	kband	portk	gkband, kporttime	;SMOOTH MOVEMENT OF SLIDER VARIABLE
	;OUTPUTS	OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
	asigL, asigR	diskin2	"Seashore.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)
	kSwitch		changed	gkskip	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	START			;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif
	START:
	aresL 		butbp 	asigL, kfreq, kband, i(gkskip)	;FILTER EACH CHANNEL SEPARATELY
	aresR 		butbp 	asigR, kfreq, kband, i(gkskip)	;FILTER EACH CHANNEL SEPARATELY
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
			outs	aresL * gkgain, aresR * gkgain	;SEND FILTER OUTPUT TO THE AUDIO OUTPUTS, RESCALE USING SLIDER VARIABLE gkgain
endin
  	
</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT ALLOWS REAL-TIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>



























