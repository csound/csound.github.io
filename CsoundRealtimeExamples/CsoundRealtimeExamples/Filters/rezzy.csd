Written by Iain McCurdy, 2009
rezzy.csd

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	16	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;					LABEL  | WIDTH | HEIGHT | X | Y
				FLpanel	"rezzy",  500,    300,    0,  0

;SWITCHES                       			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    140,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idfco				FLvalue	" ",       80,     20,    5,  75
idres				FLvalue	" ",       80,     20,    5, 125
idamp				FLvalue	" ",       80,     20,    5, 275

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE
gkmode, ihmode 			FLcount  "Type", 			0,     1,     1,      1,      2,    150,     25,     5, 150,   -1
gkskip, ihskip 			FLcount  "Initialisation 0-On 1-Off", 	0,     1,     1,      1,      2,    150,     25,   345,   5,   -1

;SLIDERS					            		MIN | MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gkfco,ihfco			FLslider 	"Filter Cutoff",	20,  20000, -1,    23,  idfco,   490,     25,    5,  50
gkres,ihres			FLslider 	"Resonance",		1,     100,  0,    23,  idres,   490,     25,    5, 100
gkamp,ihamp			FLslider 	"Amplitude Rescaling",	0,       1,  0,    23,  idamp,   490,     25,    5, 250

;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	20000, 	ihfco
				FLsetVal_i	1, 	ihres
				FLsetVal_i	0, 	ihmode
				FLsetVal_i	-1, 	ihOnOff
				FLsetVal_i	1, 	ihamp
				FLsetVal_i	0, 	ihskip

;TEXT BOXES							ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	"0-Low-pass   1-High-pass", 	1,        9,    12,    150,    30,     0, 200
			
				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 240, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          rezzy                              ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"rezzy is an implementation of a resonant low or high-pass    ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"filter. Its input arguments are for filter cutoff frequency, ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"amount of resonance, a two-way switch selecting filter mode  ", 	1,      5,     14,    490,    15,     5,  80
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
	ktrig	changed	gkOnOff
	if ktrig==1&&gkOnOff==1 then
	 schedkwhen	ktrig,0,0,2,0,-1
	endif
endin

instr	2
	if	gkOnOff=0	then	;IF On/Off SWITCH IS SET TO 'OFF'...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	kporttime	linseg	0,0.001,0.005,1,0.005	;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A SET VALUE	
	kfco	portk	gkfco, kporttime	;SMOOTH MOVEMENT OF SLIDER VARIABLE
	;OUTPUTS	OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
	asigL, asigR	diskin2	"Seashore.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)
	kSwitch		changed	gkmode, gkskip	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	START			;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif
	START:
	aresL		rezzy 	asigL, kfco, gkres , i(gkmode), i(gkskip)
	aresR		rezzy 	asigR, kfco, gkres , i(gkmode), i(gkskip)
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
		outs	aresL * gkamp, aresR * gkamp	;SEND FILTER OUTPUT TO THE AUDIO OUTPUTS AND SCALE USING THE FLTK SLIDER DERIVED VARIABLE gkamp 
endin
  	
</CsInstruments>

<CsScore>
i 1 0 3600
</CsScore>

</CsoundSynthesizer>
