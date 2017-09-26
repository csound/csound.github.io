;Written by Iain McCurdy, 2006

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
FLcolor	255, 255, 255, 0, 0, 0
;					LABEL      | WIDTH | HEIGHT | X | Y
				FLpanel	"lowpass2",   500,    200,    0,  0

;SWITCHES                       			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    140,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idcf				FLvalue	" ",       70,     20,    5,  75
idq				FLvalue	" ",       70,     20,    5, 125
idamp				FLvalue	" ",       70,     20,    5, 175

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkskip, ihskip 			FLcount  "Initialisation 0-On 1-Off", 	0,     1,    1,       1,      2,    150,     25,   345, 5,    -1

;SLIDERS				            				MIN | MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X  | Y
gkcf,ihcf			FLslider 	"Filter Cutoff",		20,  20000, -1,    23,    idcf,     490,     25,    5,    50
gkq,ihq				FLslider 	"Q (resonance)",		1,     500, -1,    23,    idq,      490,     25,    5,   100
gkamp,ihamp			FLslider 	"Output Amplitude Scaling",	0,       1,  0,    23,    idamp,    490,     25,    5,   150

;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	10000, 	ihcf
				FLsetVal_i	1, 	ihq
				FLsetVal_i	0.5, 	ihamp
			
				FLpanel_end
				
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 300, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          lowpass2                           ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Lowpass2 is an implementation of a second-order resonant IIR ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"low-pass filter. Its input arguments are for filter cutoff   ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"frequency (in hertz), Q or resonance (a value in the range 1 ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"to 500) and an optional 2-way switch (default=0) to select   ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"whether the data space for feedback within the filter is     ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"initially cleared or allowed to retain previously held       ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"information.                                                 ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"Use of high levels of resonance can cause significant        ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"increases in the overall output amplitude. It may be desired ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"to make use of the balance opcode to control these           ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"fluctuations in amplitude. Alternatively a control to scale  ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"the output amplitude can be implemented (as has been done in ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"this example).                                               ", 	1,      5,     14,    490,    15,     5, 280

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
	kSwitch		changed	gkskip	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	START			;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif
	START:
	aresL 		lowpass2	asigL, kcf, gkq , i(gkskip)	;FILTER EACH CHANNEL SEPARATELY
	aresR 		lowpass2	asigR, kcf, gkq , i(gkskip)	;FILTER EACH CHANNEL SEPARATELY
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
		outs	aresL * gkamp, aresR * gkamp	;SEND FILTER OUTPUT TO THE AUDIO OUTPUTS AND SCALE USING THE FLTK SLIDER VARIABLE gkamp
endin
  	
</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT ALLOWS REAL-TIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>