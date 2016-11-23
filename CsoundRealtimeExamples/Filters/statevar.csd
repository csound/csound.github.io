Written by Iain McCurdy, 2006
statevar.csd

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	16	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;					LABEL     | WIDTH | HEIGHT | X | Y
				FLpanel	"statevar",  500,    350,    0,  0

;SWITCHES                       			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    150,     25,    5,  5,   -1; 0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idcf				FLvalue	" ",       70,    20,     5,  75
idq				FLvalue	" ",       70,    20,     5, 125
idhpamp				FLvalue	" ",       70,    20,     5, 175
idlpamp				FLvalue	" ",       70,    20,     5, 225
idbpamp				FLvalue	" ",       70,    20,     5, 275
idbramp				FLvalue	" ",       70,    20,     5, 325

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkstor, ihstor 			FLcount  "Initialisation 0-On 1-Off", 	0,     1,     1,      1,      2,    150,     25,   324, 5,   -1
gkosamps, ihosamps 		FLcount  "Oversampling", 		1,    50,     1,      1,      2,    150,     25,   162, 5,   -1

;SLIDERS					            		MIN | MAX | EXP | TYPE | DISP  | WIDTH | HEIGHT | X | Y
gkcf,ihcf			FLslider 	"Filter Cutoff",	20,  19000, -1,    23,  idcf,     490,     25,    5,  50
gkq,ihq				FLslider 	"Resonance",		0.0001,      20, -1,    23,  idq,      490,     25,    5, 100
gkhpamp,ihhpamp			FLslider 	"High Pass Amplitude",	0,       1,  0,    23,  idhpamp,  490,     25,    5, 150
gklpamp,ihlpamp			FLslider 	"Low Pass Amplitude",	0,       1,  0,    23,  idlpamp,  490,     25,    5, 200
gkbpamp,ihbpamp			FLslider 	"Band Pass Amplitude",	0,       1,  0,    23,  idbpamp,  490,     25,    5, 250
gkbramp,ihbramp			FLslider 	"Band Reject Amplitude",0,       1,  0,    23,  idbramp,  490,     25,    5, 300

;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	1600, 	ihcf
				FLsetVal_i	1, 	ihq
				FLsetVal_i	-1, 	ihOnOff
				FLsetVal_i	1, 	ihhpamp
				FLsetVal_i	0, 	ihlpamp
				FLsetVal_i	0, 	ihbpamp
				FLsetVal_i	0, 	ihbramp
				FLsetVal_i	0, 	ihstor
				FLsetVal_i	3, 	ihosamps

			
				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 340, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           statevar                          ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Statevar is a digital implmentation of an analogue state     ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"variable filter. The user is able to select the number of    ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"oversampling routines employed. Employing more oversampling  ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"will sharpen the cutoff slope.                               ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"The opcode produces four output signals, a highpass filtered ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"signal, a lowpass filtered signal, a bandpass filtered signal", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"and a band reject filtered signal.                           ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"Rather than send all four signals to the outputs             ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"simultaneously it would be more typical for the user to      ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"select one or perhaps two of the outputs either by switches  ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"or, as in this example, by sliders.                          ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"The user is also offered control of the Q or resonance of the", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"filter.                                                      ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"A built in resonance limiter prevents the filter from        ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"becoming unstable.                                           ", 	1,      5,     14,    490,    15,     5, 320

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
	endif
	kporttime	linseg	0,0.001,0.005,1,0.005	;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A SET VALUE	
	kcf	portk	gkcf, kporttime	;SMOOTH MOVEMENT OF SLIDER VARIABLE
	;OUTPUTS	OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
	asigL, asigR	diskin2	"Seashore.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)
	kSwitch		changed	gkstor, gkosamps	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	START			;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif
	START:
	ahpL,alpL,abpL,abrL statevar asigL, kcf, gkq, i(gkosamps), i(gkstor)	;APPLY STATEVAR FILTER TO AUDIO SIGNAL CREATED IN INSTRUMENT 1, DEAL WITH EACH CHANNEL OF THE STEREO SIGNAL SEPARATELY
	ahpR,alpR,abpR,abrR statevar asigR, kcf, gkq, i(gkosamps), i(gkstor)	;APPLY STATEVAR FILTER TO AUDIO SIGNAL CREATED IN INSTRUMENT 1, DEAL WITH EACH CHANNEL OF THE STEREO SIGNAL SEPARATELY
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
	
	;SUM THE FOUR OUTPUTS OF STATEVAR BUT APPLY SLIDER AMPLITUDE CONTROLS AT THE SAME TIME
	amixL		sum	ahpL * gkhpamp, alpL * gklpamp, abpL * gkbpamp, abrL * gkbramp 	
	amixR		sum	ahpR * gkhpamp, alpR * gklpamp, abpR * gkbpamp, abrR * gkbramp 	

		outs	amixL, amixR	;SEND FILTER OUTPUT TO THE AUDIO OUTPUTS
endin
  	
</CsInstruments>

<CsScore>
i 1       0       3600
</CsScore>

</CsoundSynthesizer>