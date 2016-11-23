;Written by Iain McCurdy, 2006

;MAKE ADJUSTMENTS CAUTIOUSLY - VERY UNPLEASANT SOUNDS ARE POSSIBLE WITH THIS OPCODE - PROTECT YOUR EARS!

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
				FLpanel	"lowresx",    500,    200,    0,  0

;SWITCHES                       			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    140,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idcutoff			FLvalue	" ",       70,    20,     5,  75
idresonance			FLvalue	" ",       70,    20,     5, 125
idamp				FLvalue	" ",       70,    20,     5, 175

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gknumlayer, ihnumlayer 		FLcount  "Number of Layers", 		1,     10,    1,     10,      1,    140,     25,  175,  5,    -1
gkskip, ihskip 			FLcount  "Initialisation 0-On 1-Off", 	0,      1,    1,      1,      2,    150,     25,  345,  5,    -1

;SLIDERS				            				MIN | MAX | EXP | TYPE |     DISP   | WIDTH | HEIGHT | X  | Y
gkcutoff,ihcutoff		FLslider 	"Filter Cutoff (Not in Hertz!)",1,   5000,  -1,   23,    idcutoff,     490,     25,    5,   50
gkresonance,ihresonance		FLslider 	"Resonance",			.001, 500,  -1,   23,    idresonance,  490,     25,    5,  100
gkamp,ihamp			FLslider 	"Output Amplitude Scaling",	.001,    1, -1,   23,    idamp,        490,     25,    5,  150

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	5000, 	ihcutoff
				FLsetVal_i	1, 	ihresonance
				FLsetVal_i	0.5, 	ihamp
				FLsetVal_i	1, 	ihnumlayer
			
				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 420, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           lowresx                           ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"lowresx is an implementation of a resonant low-pass filter.  ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"Its input arguments are for filter cutoff frequency,         ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"resonance, number of iterations of the filter (optional,     ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"default=4) and an optional 2-way switch (default=0) to select", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"whether the data space for feedback within the filter is     ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"initially cleared or allowed to retain previously held       ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"information.                                                 ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"Cutoff frequency is not in hertz and resonance is not in     ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"decibels so experimentation is recommended.                  ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"Use of high levels of resonance can cause significant        ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"increases in the overall output amplitude. It may be desired ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"to make use of the balance opcode to control these           ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"fluctuations in amplitude. Alternatively a control to scale  ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"the output amplitude can be implemented (as has been done in ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"this example).                                               ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"lowresx is equivalent to multiple iterations of the lowres   ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"opcode connected in series. Extremely loud and piercing tones", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"are possible with this opcode so use with care and protect   ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"your ears and speakers!                                      ", 	1,      5,     14,    490,    15,     5, 400

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1
	if	gkOnOff=0	then	;IF On/Off SWITCH IS SET TO 'OFF'...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	kporttime	linseg	0,0.001,0.005,1,0.005	;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A SET VALUE	
	kcutoff	portk	gkcutoff, kporttime	;SMOOTH MOVEMENT OF SLIDER VARIABLE
	;OUTPUTS	OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
	asigL, asigR	diskin2	"Seashore.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)
	kSwitch		changed	gkskip, gknumlayer	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	START			;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif
	START:
	aresL 		lowresx asigL, kcutoff, gkresonance, i(gknumlayer), i(gkskip)	;FILTER EACH CHANNEL SEPARATELY
	aresR 		lowresx asigR, kcutoff, gkresonance, i(gknumlayer), i(gkskip)	;FILTER EACH CHANNEL SEPARATELY
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
		outs		aresL * gkamp, aresR * gkamp	;SEND FILTER OUTPUT TO THE AUDIO OUTPUTS AND SCALE USING THE FLTK SLIDER VARIABLE gkamp
endin
  	
</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT ALLOWS REAL-TIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>