;Written by Iain McCurdy, 2006

;CAREFUL MONITORING OF THE OUTPUT AMPLITUDE IS NEEDED TO PREVENT DISTORTION

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
;					LABEL    | WIDTH | HEIGHT | X | Y
				FLpanel	"vlowres",  500,     250,   0,  0

;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,    0,    22,    150,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idfco				FLvalue	" ",       80,     20,    5,  75
idres				FLvalue	" ",       80,     20,    5, 125
idsep				FLvalue	" ",       80,     20,    5, 175
idamp				FLvalue	" ",       80,     20,    5, 225

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkord, ihord 			FLcount  "Number of Ordinates", 	1,    10,     1,      1,     2,     150,     25,   345, 5,    -1

;SLIDERS				            				MIN | MAX | EXP | TYPE | DISP   | WIDTH | HEIGHT | X  | Y
gkfco,ihfco			FLslider 	"Filter Cutoff (Not in Hertz!)",0.01,5000,  -1,    23,   idfco,    490,     25,    5,   50
gkres,ihres			FLslider 	"Resonance",			.01,  500,  -1,    23,   idres,    490,     25,    5,  100
gksep,ihsep			FLslider 	"Separation (in oct)",		0,    100,   0,    23,   idsep,    490,     25,    5,  150
gkamp,ihamp			FLslider 	"Output Amplitude Scaling",	0,       1,  0,    23,   idamp,    490,     25,    5,  200

;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	60, 	ihfco
				FLsetVal_i	1, 	ihres
				FLsetVal_i	50, 	ihsep
				FLsetVal_i	0.5, 	ihamp
				FLsetVal_i	10, 	ihord
			
				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 400, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          vlowres                            ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"vlowres is an implementation of a resonant low-pass filter.  ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"Its input arguments are for filter cutoff frequency,         ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"resonance, number of parallel iterations of the filter       ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"(1 to 10) and cutoff frequency separation between the first  ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"and last filters. Cutoff frequency is not in hertz and       ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"resonance is not in decibels so experimentation is needed.   ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"Use of high levels of resonance can cause significant        ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"increases in the overall output amplitude. It may be desired ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"to make use of the balance opcode to control these           ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"fluctuations in amplitude. Alternatively a control to scale  ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"the output amplitude can be implemented (as has been done in ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"this example).                                               ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"vlowres is equivalent to multiple iterations of the lowres   ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"opcode connected in parallel with cutoff frequencies spaced  ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"according to a combination of the Separation and the Number  ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"of Ordinates arguments. Separation defines the interval in   ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"hertz between the first and last filters, intervening filter ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"cutoff frequencies are spaced evenly.                        ", 	1,      5,     14,    490,    15,     5, 380

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1
	if	gkOnOff=0	then	;IF On/Off SWITCH IS SET TO 'OFF'...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	kporttime	linseg	0,0.001,0.005,1,0.005	;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A SET VALUE	
	kfco	portk	gkfco, kporttime	;SMOOTH MOVEMENT OF SLIDER VARIABLE
	ksep	portk	gksep, kporttime	;SMOOTH MOVEMENT OF SLIDER VARIABLE
	;OUTPUTS	OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
	asigL, asigR	diskin2	"Seashore.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)
	kSwitch		changed	gkord	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	START			;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif
	START:
	aresL 		vlowres 	asigL, kfco, gkres, i(gkord), ksep	;FILTER BOTH CHANNELS SEPARATELY
	aresR 		vlowres 	asigR, kfco, gkres, i(gkord), ksep	;FILTER BOTH CHANNELS SEPARATELY
		outs		aresL * gkamp, aresR * gkamp	;SEND FILTER OUTPUT TO THE AUDIO OUTPUTS AND SCALE USING THE FLTK SLIDER VARIABLE gkamp
endin
  	
</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT ALLOWS REAL-TIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>



























