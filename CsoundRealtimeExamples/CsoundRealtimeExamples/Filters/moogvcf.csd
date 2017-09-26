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
0dbfs		=	1	;MAXIMUM SOUND INTENSITY LEVEL REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;					LABEL     | WIDTH | HEIGHT | X | Y
				FLpanel	"moogvcf",   500,    250,    0,  0

;SWITCHES                       			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    140,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idfco				FLvalue	" ",      70,     20,     5,  75
idres				FLvalue	" ",      70,     20,     5, 125
idfrq				FLvalue	" ",      70,     20,     5, 175
idgain				FLvalue	" ",      70,     20,     5, 225

;SLIDERS				            				MIN | MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X   | Y
gkfco,ihfco			FLslider 	"Filter Cutoff",		20,  20000, -1,    23,   idfco,      490,     25,   5,    50
gkres,ihres			FLslider 	"Resonance",			0,       1,  0,    23,   idres,      490,     25,   5,   100
gkfrq,ihfrq			FLslider 	"Oscillator Frequency",		20,  20000, -1,    23,   idfrq,      490,     25,   5,   150
gkgain,ihgain			FLslider 	"Output Amplitude Scaling",	0,       1,  0,    23,   idgain,     490,     25,   5,   200

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkskip, ihskip 			FLcount  "Initialisation 0-On 1-Off", 	0,     1,     1,      1,      2,    150,     25,   345, 5,    -1

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	19000, 	ihfco
				FLsetVal_i	100, 	ihfrq
				FLsetVal_i	0, 	ihres
				FLsetVal_i	0.5, 	ihgain
		
				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 260, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                        moogvcf                              ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"moogvcf is an emulation of the moog ladder diode resonant    ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"low-pass filter.                                             ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"The opcode's input arguments include cutoff frequency and    ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"resonance.                                                   ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"An optional 2-way switch (default=0) is provided to select   ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"whether the data space for feedback within the filter is     ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"initially cleared or allowed to retain previously held       ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"information.                                                 ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"The input signal used in this example is a triangle waveform,", 	1,      5,     14,    490,    15,     5, 200
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
	asig		vco 		1, kfrq, 1, 0	;GENERATE A TRIANGLE WAVE AUDIO SIGNAL (NOTE THAT lpf18 EXPECTS A SIGNAL WITHIN THE RANGE -1 TO 1)
	kSwitch		changed		gkskip
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	START			;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif
	START:
	asig		vco 		1, kfrq, 1, 0	;GENERATE A TRIANGLE WAVE AUDIO SIGNAL (NOTE THAT lpf18 EXPECTS A SIGNAL WITHIN THE RANGE -1 TO 1)
	iscale		=		1
	ares 		moogvcf 	asig, kfco, gkres, iscale, i(gkskip)
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
		outs	ares  * gkgain, ares * gkgain	;FILTER OUTPUT IS SENT TO THE AUDIO OUTPUTS AND RESCALED USING gkgain SLIDER VARIABLE
endin
  	
</CsInstruments>

<CsScore>
f 0 3600	;'DUMMY' SCORE EVENT - KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>



























