;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-odevaudio -b400
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	2	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;					LABEL  | WIDTH | HEIGHT | X | Y
				FLpanel	"bqrez",  500,    350,    0,  0

;////SOUND GENERATOR SECTION////
;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,      9,     15,    496,     98,    2,  2	;BORDER AROUND SOUND GENERATION PANEL
;SWITCHES                       			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    140,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)
;BUTTON BANKS				TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkinput, ihinput	FLbutBank	14,     1,     2,     18,      40,   160, 5,  -1   
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN   
;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idOscFrq			FLvalue	" ",      70,      20,    5,  75
;SLIDERS				            			MIN | MAX | EXP | TYPE |     DISP   | WIDTH | HEIGHT | X   | Y
gkOscFrq, ihOscFrq		FLslider 	"Oscillator Frequency",	1,    5000, -1,    23,   idOscFrq,     490,      25,   5,    50
;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 FLbox  	"Sound File         ",	1,       5,    12,    140,     20,   180,  5
ih		 FLbox  	"Sawtooth Oscillator",	1,       5,    12,    140,     20,   180, 25
;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	200, 	ihOscFrq

;///FILTER SECTION///
;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idfco				FLvalue	" ",       70,    20,     5, 125
idres				FLvalue	" ",       70,    20,     5, 175
idamp				FLvalue	" ",       70,    20,     5, 325

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkmode, ihmode 			FLcount  "Type", 			0,     4,     1,      1,      2,    150,     25,     0, 200,   -1
gkskip, ihskip 			FLcount  "Initialisation 0-On 1-Off", 	0,     1,     1,      1,      2,    150,     25,   345, 200,   -1

;SLIDERS					            			MIN | MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gkfco,ihfco			FLslider 	"Filter Cutoff",		20,  20000, -1,    23,  idfco,   490,     25,    5, 100
gkres,ihres			FLslider 	"Resonance",			1,     100,  0,    23,  idres,   490,     25,    5, 150
gkamp,ihamp			FLslider 	"Output Amplitude Scaling",	0,       1,  0,    23,  idamp,   490,     25,    5, 300

;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	20000, 	ihfco
				FLsetVal_i	1, 	ihres
				FLsetVal_i	0.5, 	ihamp

;TEXT BOXES												ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	"0-Low-pass   1-High-pass   2-Band-pass   3-Band-reject   4-All-pass", 	1,        9,    12,    400,    30,     0, 250
			
				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 240, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                              bqrez                          ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"bqrez is an implementation of a second-order multi-mode      ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"filter. Its input arguments are for filter cutoff frequency, ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"amount of resonance, a five-way switch selecting filter mode ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"and a 2-way switch selecting whether the data space for      ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"feedback within the filter is initially cleared or allowed   ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"to retain previously held information.                       ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"Use of resonance can create large increases in amplitude in  ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"the output signal. In may be necessary, therefore, to rescale", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"the amplitude of the output signal. In this example a slider ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"has been provided to achieve this.                           ", 	1,      5,     14,    490,    15,     5, 220

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


instr	1
	if	gkOnOff=0	then	;IF On/Off SWITCH IS SET TO 'OFF'...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	kporttime	linseg	0,0.001,0.005,1,0.005	;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A SET VALUE	
	kfco	portk	gkfco, kporttime	;SMOOTH MOVEMENT OF SLIDER VARIABLE
	kOscFrq	portk	gkOscFrq, kporttime	;SMOOTH MOVEMENT OF SLIDER VARIABLE

	if gkinput=0 then	;IF FIRST INPUT OPTIONS HAS BEEN CHOSEN...
	  ;OUTPUTS	OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
	  asigL, asigR	diskin2	"Seashore.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)
	else			;OTHERWISE...
	  asigL	vco2	0.2,gkOscFrq	;GENERATE A SAWTOOTH WAVEFORM
	  asigR	=	asigL		;COPY THE SAWTOOTH INTO THE RIGHT CHANNEL
	endif				;END OF THIS CONDITIONAL BRANCH
	;OUTPUTS	OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)

	kSwitch		changed	gkmode, gkskip	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	START			;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif
	START:
	aresL 		bqrez 	asigL, kfco, gkres , i(gkmode), i(gkskip)
	aresR 		bqrez 	asigR, kfco, gkres , i(gkmode), i(gkskip)
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
			outs	aresL * gkamp, aresR * gkamp	;SEND FILTER OUTPUT TO THE AUDIO OUTPUTS AND SCALE USING THE FLTK SLIDER DERIVED VARIABLE gkamp 
endin
  	
</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT ALLOWS REAL-TIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>



























