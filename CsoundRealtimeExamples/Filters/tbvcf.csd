;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-odevaudio -b400
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	100	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM SOUND INTENSITY LEVEL REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;					LABEL   | WIDTH | HEIGHT | X | Y
				FLpanel	"tbvcf",   500,    350,    0,  0

;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,    0,    22,    150,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idfco				FLvalue	" ",      100,    20,     5,  75
idq				FLvalue	" ",      100,    20,     5, 125
iddist				FLvalue	" ",      100,    20,     5, 175
idasym				FLvalue	" ",      100,    20,     5, 225
idfrq				FLvalue	" ",      100,    20,     5, 275
idgain				FLvalue	" ",      100,    20,     5, 325

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkskip, ihskip 			FLcount  "Initialisation 0-On 1-Off", 	0,     1,     1,      1,      2,    150,    25,    345, 5,    -1

;SLIDERS				            				MIN | MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X  | Y
gkfco,ihfco			FLslider 	"Filter Cutoff",		20,  20000, -1,    23,  idfco,   490,     25,    5,   50
gkres,ihres			FLslider 	"Resonance",			0,       2,  0,    23,  idq,     490,     25,    5,  100
gkdist,ihdist			FLslider 	"Distortion",			0,       2,  0,    23,  iddist,  490,     25,    5,  150
gkasym,ihasym			FLslider 	"Asymmetry",			0,       1,  0,    23,  idasym,  490,     25,    5,  200
gkfrq,ihfrq			FLslider 	"Oscillator Frequency",		20,  20000, -1,    23,  idfrq,   490,     25,    5,  250
gkgain,ihgain			FLslider 	"Amplitude Rescaling",		0,       1,  0,    23,  idgain,  490,     25,    5,  300

;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	11000, 	ihfco
				FLsetVal_i	0, 	ihres
				FLsetVal_i	2, 	ihdist
				FLsetVal_i	.5, 	ihasym
				FLsetVal_i	100, 	ihfrq
				FLsetVal_i	0.5, 	ihgain			
				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 260, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          tbvcf                              ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"tbvcf attempts to emulate the resonant low-pass filter on the", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"Roland TB-303 Bassline ® synthesiser.                        ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"The opcode includes input arguments for cutoff frequency,    ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"resonance, distortion and asymmetry of the resonance.        ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"THIS OPCODE HAS A BUG WHICH MANIFESTS AS A TENDENCY TO       ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"EXPLODE WHEN FILTER CUTOFF IS SET LOW OR HIGH (THIS IS ALSO  ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"DEPENDENT UPON THE SETTING FOR 'DISTORTION'. PROTECT YOUR    ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"EARS AND YOUR SPEAKERS!                                      ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"The input signal used in this example is a sawtooth waveform,", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"the frequency of which is adjustable using an on-screen      ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"slider.                                                      ", 	1,      5,     14,    490,    15,     5, 240

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gir 	ftgen 	1, 0, 131072, 10, 1	;SINE WAVE FUNCTION TABLE

instr	1
	if	gkOnOff=0	then	;IF On/Off SWITCH IS SET TO 'OFF'...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	kporttime	linseg	0,0.001,0.005,1,0.005	;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A SET VALUE	
	kfrq	portk	gkfrq, kporttime	;SMOOTH MOVEMENT OF SLIDER VARIABLE
	kfco	portk	gkfco, kporttime	;SMOOTH MOVEMENT OF SLIDER VARIABLE
	asig		vco 		1, kfrq, 1, 0	;GENERATE A TRIANGLE WAVE AUDIO SIGNAL (NOTE THAT tbvcf EXPECTS A SIGNAL WITHIN THE RANGE -1 TO 1)
	kSwitch		changed	gkskip	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	START			;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif
	START:
	kporttime	linseg	0,.01,.01,1,.01	;kporttime ramps up to a held value of .01 in .01 of a second
	kfco		portk	gkfco, kporttime	;PORTAMENTO IS APPLIED TO THE SLIDER VARIABLE gkfco IN ORDER TO SMOOTH ITS MOVEMENT SLIGHTLY
	ares 		tbvcf 		asig, kfco, gkres, gkdist, gkasym, i(gkskip)
			outs	ares * gkgain, ares * gkgain	;FILTER OUTPUT IS SENT TO THE AUDIO OUTPUTS AND SCALED UP IN ORDER TO BE AUDIBLE
endin
  	
</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT ALLOWS REAL-TIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>