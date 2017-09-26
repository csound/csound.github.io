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
;					LABEL  | WIDTH | HEIGHT | X | Y
				FLpanel	"atone",  500,     150,   0,  0

;SWITCHES                       			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    140,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idhp				FLvalue	" ",       70,    20,     5,  75
idgain				FLvalue	" ",       70,    20,     5, 125

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkskip, ihskip 			FLcount  "Initialisation 0-On 1-Off", 	0,     1,     1,      1,      2,    150,    25,    345, 5,    -1

;SLIDERS					            			MIN | MAX | EXP | TYPE |  DISP | WIDTH | HEIGHT | X | Y
gkhp, ihhp			FLslider 	"Filter Cutoff",		20,  20000, -1,    23,    idhp,   490,     25,    5,  50
gkgain, ihgain			FLslider 	"Output Amplitude Scaling",	0,       1,  0,    23,  idgain,   490,     25,    5, 100

;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	20, 	ihhp
				FLsetVal_i	1, 	ihgain
			
				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 180, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                              atone                          ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"atone is an implementation of a first-order recursive high-  ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"pass filter. Its input arguments are for cutoff frequency    ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"(half-power point) and a 2-way switch selecting whether the  ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"data space for feedback within the filter is initially       ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"cleared or allowed to retain previously held information.    ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"Multiple iterations of the atone opcode applied to the signal", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"path in series can be used to create a sharper cutoff slope. ", 	1,      5,     14,    490,    15,     5, 160

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1
	if	gkOnOff=0	then	;IF On/Off SWITCH IS SET TO 'OFF'...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	kporttime	linseg	0,0.001,0.005,1,0.005	;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A SET VALUE	
	khp	portk	gkhp, kporttime	;SMOOTH MOVEMENT OF SLIDER VARIABLE
	;OUTPUTS	OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
	asigL, asigR	diskin2	"Seashore.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE
	kSwitch		changed	gkskip	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	START			;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif
	START:
	;				ITRIGGER | IMINTIM | IMAXNUM | IINSNUM | IWHEN | IDUR (-1 MEANS A NOTE OF INFINITE DURATION)
			schedkwhen	kSwitch,      0,        0,        2,        0,    -1	;RESTART INSTRUMENT 2 WITH A SUSTAINED (HELD) NOTE WHENEVER kSwitch=1
	aresL 		atone 	asigL, khp, i(gkskip)
	aresR 		atone 	asigR, khp, i(gkskip)
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
			outs	aresL * gkgain, aresR * gkgain	;SEND FILTER OUTPUT TO THE AUDIO OUTPUTS, RESCALE USING SLIDER VARIABLE gkgain
endin
  	
</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT ALLOWS REAL-TIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>



























