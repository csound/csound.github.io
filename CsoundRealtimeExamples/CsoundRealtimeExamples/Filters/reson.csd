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
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;					LABEL  | WIDTH | HEIGHT | X | Y
				FLpanel	"reson",  500,    300,    0,  0

;SWITCHES                       			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    140,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idcf				FLvalue	" ",       70,    20,     5,  75
idbw				FLvalue	" ",       70,    20,     5, 125
idamp				FLvalue	" ",       70,    20,     5, 275

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT |  X  |  Y | OPCODE
gkscl, ihscl 			FLcount  "Scaling Mode", 		0,      2,    1,      1,      2,    150,     25,     5,  160,     -1
gkskip, ihskip 			FLcount  "Initialisation 0-On 1-Off", 	0,      1,    1,      1,      2,    150,     25,   345,    5,     -1

;SLIDERS					            			MIN | MAX | EXP | TYPE |  DISP | WIDTH | HEIGHT | X   | Y
gkcf,ihcf			FLslider 	"Filter Cutoff",		20,  20000, -1,    23,    idcf,    490,     25,    5,    50
gkbw,ihbw			FLslider 	"Bandwidth",			.1,  10000, -1,    23,    idbw,    490,     25,    5,   100
gkamp,ihamp			FLslider 	"Output Amplitude Scaling",	0,       1,  0,    23,    idamp,   490,     25,    5,   250

;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	10000, 	ihcf
				FLsetVal_i	1000, 	ihbw
				FLsetVal_i	1, 	ihscl
				FLsetVal_i	1, 	ihamp

;TEXT BOXES																ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	"Scaling Modes:    0-None    1-Peak Response Factor of 1    2-Overall RMS Response Factor equals 1", 	1,        9,    12,    500,    15,     0, 203
			
				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 380, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                              reson                          ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"reson is an implementation of a resonant second-order band-  ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"-pass filter.                                                ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"Its input arguments are for filter centre frequency (in      ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"hertz), bandwidth of the notch (also in hertz) a 3-way switch", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"offering a choice 3 modes by which the output amplitude will ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"be dynamically scaled and a 2-way switch selecting whether   ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"the data space for feedback within the filter is initially   ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"cleared or allowed to retain previously held information.    ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"The audible results of the reson filter are similar to those ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"of a sweepable parametric EQ.                                ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"Setting 'Scaling Mode' to 0 will provide the mose dynamically", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"transparent effect but some manual rescaling of the amplitude", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"of the output signal may be necessary. In this example this  ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"can be performed using the 'Output Amplitude Scaling' slider.", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"Settings for 'Scaling Mode' of 1 or 2 force dynamic          ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"containment of the output signal similar to the effect of a  ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"compressor.                                                  ", 	1,      5,     14,    490,    15,     5, 360

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
	kSwitch		changed	gkscl, gkskip	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	START			;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif
	START:
	aresL 		reson 	asigL, kcf, gkbw , i(gkscl), i(gkskip)
	aresR 		reson 	asigR, kcf, gkbw , i(gkscl), i(gkskip)
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
		outs	aresL * gkamp, aresR * gkamp	;SEND FILTER OUTPUT TO THE AUDIO OUTPUTS AND SCALE USING THE FLTK SLIDER VARIABLE gkamp
endin
  	
</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT ALLOWS REAL-TIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>