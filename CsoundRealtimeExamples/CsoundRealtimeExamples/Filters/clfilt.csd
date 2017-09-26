clfilt.csd
Written by Iain McCurdy, 2006

;ELLIPTICAL FILTER DESIGN NOT IMPLEMENTED YET!

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
;					LABEL   | WIDTH | HEIGHT | X | Y
				FLpanel	"clfilt",  500,    400,    0,  0
FLcolor	225, 255, 255, 0, 0, 0	;TURQUOISE

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

;////FILTER SECTION////
FLcolor	255, 225, 255, 0, 0, 0	;LILAC
ih		 	FLbox  	" ", 	6,      9,     15,    496,    296,    2,102	;BORDER AROUND SOUND FILTER PANEL


;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idfreq				FLvalue	" ",      70,      20,    5, 225
idamp				FLvalue	" ",      70,      20,    5, 275
idpbr				FLvalue	" ",      70,      20,    5, 325
idsba				FLvalue	" ",      70,      20,    5, 375

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE
gktype, ihtype 			FLcount  "Type", 			0,      1,    1,      1,      2,    140,     25,    10, 105,   -1
gknpol, ihnpol 			FLcount  "Number of Poles", 		2,     80,    2,     10,      1,    140,     25,   180, 105,   -1
gkkind, ihkind 			FLcount  "Filter Design", 		0,      3,    1,      1,      2,    140,     25,   350, 105,   -1
gkskip, ihskip 			FLcount  "Initialisation 0-On 1-Off", 	0,      1,    1,      1,      2,    150,     25,   175, 150,   -1

;SLIDERS				            								MIN | MAX | EXP | TYPE |     DISP   | WIDTH | HEIGHT | X   | Y
gkfreq, ihfreq			FLslider 	"Filter Cutoff",						20,  20000, -1,    23,     idfreq,     490,      25,   5,   200
gkamp, ihamp			FLslider 	"Output Amplitude Rescaling",					0,      10,  0,    23,      idamp,     490,      25,   5,   250
gkpbr, ihpbr			FLslider 	"Pass Band Ripple (Chebyshev Type I and Elliptical)",		0.1,    50,  0,    23,      idpbr,     490,      25,   5,   300
gksba, ihsba			FLslider 	"Stop Band Attenuation (Chebyshev Type II and Elliptical)",	-120,   -1,  0,    23,      idsba,     490,      25,   5,   350

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	200, 	ihOscFrq
				FLsetVal_i	7000, 	ihfreq
				FLsetVal_i	2, 	ihnpol
				FLsetVal_i	1, 	ihamp
				FLsetVal_i	1, 	ihpbr
				FLsetVal_i	-60, 	ihsba

;TEXT BOXES								TYPE | FONT | SIZE | WIDTH | HEIGHT | X  | Y
ih		 	FLbox  	"0-Low-pass 1-High-pass", 		1,      1,     12,    120,    20,     20, 150
ih		 	FLbox  	"0-Butterworth  1-Chebyshev I ", 	1,      1,     11,    150,    18,    350, 150
ih		 	FLbox  	"2-Chebyshev II   3-Elliptical", 	1,      1,     11,    150,    18,    350, 170
			
				FLpanel_end

FLcolor	255, 255, 255, 0, 0, 0	;WHITE
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 500, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          clfilt                             ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"clfilt implements low and high-pass filters of various types.", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"Experimentation is needed and care must be taken as certain  ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"combinations of setting can crash Csound.                    ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"The number of poles (an even number between 2 and 80)        ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"directly relates to the steepness of the cutoff slope.       ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"Four types of filter are offered: Butterworth, Chebyshev Type", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"I, Chebyshev Type II and Elliptical (not implemented yet but ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"included in this example for the future).                    ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"The filter type argument is optional and defaults to         ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"Butterworth.                                                 ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"Pass band ripple (optional, defaults to 1dB) controls the    ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"amplitude of the ripple at the cutoff frequency. (This is    ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"heard as a resonance at the cutoff frequency.) The pass band ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"ripple control is ignored by Butterworth and Chebyshev Type  ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"II.                                                          ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"Stop Band Attenuation (optional, default -60dB) controls the ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"amount of attenuation (in dBs) that is imposed beyond the    ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"cutoff frequency. Stop Band Attenuation is ignored by        ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"Butterworth and Chebyshev Type I.                            ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"An optional 2-way switch (default=0) is used to select       ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"whether the data space for feedback within the filter is     ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"initially cleared or allowed to retain previously held       ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"information.                                                 ", 	1,      5,     14,    490,    15,     5, 480

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1
	if	gkOnOff=0	then	;IF On/Off SWITCH IS SET TO 'OFF'...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	kporttime	linseg	0,0.001,0.005	;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A SET VALUE	
	kfreq	portk	gkfreq, kporttime	;SMOOTH MOVEMENT OF SLIDER VARIABLE
	kOscFrq	portk	gkOscFrq, kporttime	;SMOOTH MOVEMENT OF SLIDER VARIABLE

	if gkinput=0 then	;IF FIRST INPUT OPTIONS HAS BEEN CHOSEN...
	  ;OUTPUTS	OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
	  asigL, asigR	diskin2	"Seashore.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)
	else			;OTHERWISE...
	  asigL	vco2	0.2,gkOscFrq	;GENERATE A SAWTOOTH WAVEFORM
	  asigR	=	asigL		;COPY THE SAWTOOTH INTO THE RIGHT CHANNEL
	endif				;END OF THIS CONDITIONAL BRANCH
	
	kSwitch		changed	gktype, gknpol, gkkind, gkpbr, gksba, gkskip	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	START			;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif
	START:
	aresL 		clfilt 	asigL, kfreq, i(gktype), i(gknpol) , i(gkkind) , i(gkpbr), i(gksba), i(gkskip)	;FILTER EACH CHANNEL SEPARATELY
	aresR 		clfilt 	asigR, kfreq, i(gktype), i(gknpol) , i(gkkind) , i(gkpbr), i(gksba), i(gkskip)	;FILTER EACH CHANNEL SEPARATELY
			rireturn										;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
		outs	aresL * gkamp, aresR * gkamp;SEND FILTER OUTPUT TO THE AUDIO OUTPUTS AND SCALE USING THE FLTK SLIDER VARIABLE gkamp
endin
  	
</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT ALLOWS REAL-TIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>