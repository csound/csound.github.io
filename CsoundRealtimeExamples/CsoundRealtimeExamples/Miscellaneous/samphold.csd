samphold.csd
Written by Iain McCurdy 2010

<CsoundSynthesizer>
<CsOptions>
-odac -dm0
</CsOptions>
<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

FLcolor	255, 255, 255, 0, 0, 0	;SET COLOURS
;			LABEL               | WIDTH | HEIGHT | X | Y
		FLpanel	"Sample And Hold",     500,    460,    0,  0

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	6,        9,    15,    490,    95,     5, 255	;BORDER AROUND ENVELOPE CONTROLS

;SWITCHES                                			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"Note On/Off",		1,    0,    22,    120,     25,    5,  5,    0,      1,      0,      -1
gkEnvOnOff,ihEnvOnOff	FLbutton	"Envelope On/Off",	1,    0,     3,    150,     25,   10, 260,  -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES	LABEL  | WIDTH | HEIGHT | X |  Y
idSHrate	FLvalue	" ",      50,     20,     5,   75
idLFOrate	FLvalue	" ",      50,     20,     5,  125
idLFOrange	FLvalue	" ",      50,     20,     5,  175
idLFOoffset	FLvalue	" ",      50,     20,     5,  225
idEnvDur	FLvalue	" ",      50,     20,    10,  325

;SLIDERS				            				MIN | MAX | EXP | TYPE |   DISP   | WIDTH | HEIGHT | X  | Y
gkgain, ihgain			FLslider	"Output Gain",			0,     1,    0,   23,          -1,    360,    20,  130,    5
gkSHrate, ihSHrate		FLslider	"Sample and Hold Trigger Rate",	0.1,  50,   -1,   23,    idSHrate,    490,    25,    5,   50
gkLFOrate, ihLFOrate		FLslider	"LFO Rate",			0.01, 10,   -1,   23,   idLFOrate,    490,    25,    5,  100
gkLFOrange, ihLFOrange		FLslider	"LFO Range",			0.01,  4,    0,   23,   idLFOrange,   490,    25,    5,  150
gkLFOoffset, ihLFOoffset	FLslider	"LFO Offset",			5,    11,    0,   23,   idLFOoffset,  490,    25,    5,  200
gkEnvDur, ihEnvDur		FLslider	"Envelope Duration",		0.05,  3,   -1,   23,   idEnvDur,     480,    25,   10,  290

			FLlabel		13,     1,      1,    255,   255,   255		;NUMBERS MADE INVISIBLE
;				FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkSourceType, ihSourceType	FLbutBank	3,     1,     5,     20,    100,     75, 355,   -1
gkSound, ihSound		FLbutBank	3,     1,     2,     20,     40,    300, 355,   -1
;GENERAL_TEXT_SETTINGS			SIZE | FONT | ALIGN | RED | GREEN | BLUE
			FLlabel		13,      5,      4,   0,      0,     0		;LABELS MADE VISIBLE AGAIN

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X  | Y
ih		 	FLbox  	"LFO Type:", 	1,       5,    12,    65,     20,      5, 355
ih		 	FLbox  	"Sine    ", 	1,       5,    12,    70,     20,    105, 355
ih		 	FLbox  	"Triangle", 	1,       5,    12,    70,     20,    105, 375
ih		 	FLbox  	"Saw Down", 	1,       5,    12,    70,     20,    105, 395
ih		 	FLbox  	"Saw Up  ", 	1,       5,    12,    70,     20,    105, 415
ih		 	FLbox  	"Noise   ", 	1,       5,    12,    70,     20,    105, 435
ih		 	FLbox  	"Sound:", 	1,       5,    12,    50,     20,    250, 355
ih		 	FLbox  	"Simple Sine",  1,       5,    12,    90,     20,    320, 355
ih		 	FLbox  	"Synth Saw  ",  1,       5,    12,    90,     20,    320, 375

;SET INITIAL VALUES OF FLTK VALUATORS
;				VALUE | HANDLE                                    
		FLsetVal_i	5, 	ihSHrate
		FLsetVal_i	0.5, 	ihLFOrate
		FLsetVal_i	2, 	ihLFOrange
		FLsetVal_i	7, 	ihLFOoffset
		FLsetVal_i	0.8, 	ihEnvDur
		FLsetVal_i	1, 	ihEnvOnOff                                           
		FLsetVal_i	2, 	ihSourceType
		FLsetVal_i	0.7, 	ihgain
		FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 512, 520, 510, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"           Sample and Hold (samphold opcode)                 ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"Sample and hold is a technique whereby the instantaneous     ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"value of a continuously varying signal is held for a defined ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"period of time before the signal is sampled again and the    ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"process is repeated. Analog to digital conversion involves   ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"the technique of sample and hold but, when used with a much  ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"slower rate of resampling, it is also used frequently in     ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"synthesis.                                                   ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"The 'samphold' opcode take an a or k-rate signal and allows  ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"it to pass through unaffected while its gate input is        ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"non-zero but holds the instantaneous value whenever its gate ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"input is zero.                                               ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"In this example the frequency of an audio oscillator is      ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"modulated by an LFO but the signal from the LFO is first     ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"passed through 'samphold'. The user can choose between a     ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"a variety of LFO waveform shapes including random.           ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"The trigger for the sample and hold gate is a simple         ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"metronome (metro opcode). The rate of both the gate trigger  ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"and the source LFO can be varied. The relationship between   ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"these two should be explored to discover how different       ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"motivic patterns can be created. An envelope can be applied  ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"to each 'hold' period to further articulate each step.       ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"For sonification of the sample and hold data, the user can   ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"choose between a simple sine wave oscillator or a more       ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"complex lowpass filtered and processed synth sound.          ", 	1,      5,     14,    490,    20,     5, 500

FLpanel_end                                                                                       

		FLrun	;RUN THE FLTK WIDGET THREAD


gisine	ftgen	0,0,65536,10,1

instr	1	;SAMPLE AND HOLD NOTE SEQUENCER
	if	gkOnOff=0	then	;IF ON/OFF SWITCH IS 'OFF'...
		turnoff			;TURN OFF THIS INSTRUMENT
	endif  				;END OF CONDITIONAL BRANCH
	;MAKE VARIOUS SETTINGS BASED ON LFO TYPE CHOICE
	if gkSourceType=0 then
		kLFOtype=0	;SINE WAVE
	elseif gkSourceType=1 then
		kLFOtype=1	;TRIANGLE
	elseif gkSourceType=2 then
		kLFOtype=5	;SAWTOOTH DOWN (UNIPOLAR)
	elseif gkSourceType=3 then
		kLFOtype=4	;SAWTOOTH UP (UNIPOLAR)
	endif
	if gkSourceType=4 then
		aoct	noise		gkLFOrange, 0	;NOISE WAVEFORM
	else
		ktrig	changed	kLFOtype	;GENERATE A 'BANG' TRIGGER (MOMENTARY '1') IF LFO TYPE SELECTION IS CHANGED
		if ktrig=1 then			;IF 'BANG' IS RECEIVED...
			reinit	RESTART_LFO	;BEGIN A REINITIALISATION PASS BEGINNING FROM LABEL 'RESTART_LFO'
		endif				;END OF CONDITIONAL BRANCH
		RESTART_LFO:			;LABEL
		aoct	lfo		gkLFOrange, gkLFOrate, i(kLFOtype)	;LFO GENERATES FREQUENCY VALUES FOR OSCILLATOR
		rireturn			;RETURN FROM REINITIALISATION PASS
		if gkSourceType=2||gkSourceType=3 then	;SAWTOOTH WAVEFORMS WITH lfo OPCODE ARE UNIPOLAR. WE WILL RE-RANGE LFO OUTPUT SO THAT IT IS BI-POLAR IF EITHER OF THESE TYPES HAS BEEN SELECTED
			aoct = (aoct * 2) - gkLFOrange	;RE-RANGE LFO
		endif					;END OF CONDITIONAL BRANCH
	endif					;END OF CONDITIONAL BRANCH
	kgate	metro		gkSHrate	;TRAIN OF GATE TRIGGERS TO BE USED BY SAMPLE AND HOLD MECHANISM
	if gkEnvOnOff=1 then	;IF 'ENVELOPE' OPTION HAS BEEN SELECTED...
		;ALSO RESTART A PERCUSSIVE ENVELOPE WHENEVER A GATE TRIGGER IS RECEIVED TO ARTICULATE CHANGES IN PITCH IN THE OSCILLATOR
		if kgate=1 then				;IF TRIGGER IS RECEIVED (I.E. = 1)...
			reinit	RESTART_ENVELOPE	;RE-INITIALISE FROM LABEL 'RESTART_ENVELOPE'
		endif					;END OF CONDITIONAL BRANCH
		RESTART_ENVELOPE:			;A LABEL
		aenv	expseg		0.001,0.01,1,i(gkEnvDur),0.0001	;PERCUSSIVE TYPE AMPLITUDE ENVELOPE
		rireturn					;RETURN FROM RE-INITIALISATION PASS TO NORMAL PERFORMANCE PASSES
		aenv	tone		aenv, 500		;SMOOTH AMPLITUDE ENVELOPE A LITTLE (TO REMOVE CLICKS WHENEVER AN ENVELOPE IS INTERRUPTED BY A RE-INITIALISATION)
	else				;OTHERWISE...
		aenv	=	1	;AMPLITUDE IS A CONSTANT (NO ENVELOPE)
	endif				;END OF CONDITIONAL BRANCH
	aoct	samphold	aoct + gkLFOoffset, kgate		;APPLY SAMPLE-AND-HOLD TO THE LFO GENERATED FREQUENCY VALUES (AND ADD AN OFFSET)

	;----------------------------------------------------------------------------------------------------------------------------------
	; A SIMPLE SINE WAVE SONIFICATION	
	;----------------------------------------------------------------------------------------------------------------------------------
	if gkSound==0 then
	  asig	poscil		0.7*aenv*gkgain, cpsoct(aoct), gisine	;AUDIO OSCILLATOR
	  	outs		asig,asig				;SEND AUDIO TO OUTPUTS

	;----------------------------------------------------------------------------------------------------------------------------------
	; A MORE COMPLEX SYNTH SONIFICATION	
	;----------------------------------------------------------------------------------------------------------------------------------
	else
	  koct	downsamp	aoct					;NEED TO DOWNSAMPLE TO K-RATE FOR vco2
	  asig	vco2		0.4*gkgain, cpsoct(koct)		;CREATE A VCO SAWTOOTH OSCILLATOR
	  kcfbas	rspline		7,12,0.05,0.2			;FILTER FREQ. BASE VALUE
	  kenvdep	rspline		0,2,0.1,0.5			;FILTER FREQ. ENVELOPE DEPTH
	  kcfenv	loopseg		gkSHrate, 0, 0, kenvdep , 1, 0	;FILTER FREQ. ENVELOPE
	  kres	rspline		0.4,0.85,0.05,0.2			;FILTER RESONANCE
	  kdist	rspline		0,10,0.1,0.2				;FILTER DISTORTION
	  afilt	lpf18		asig,cpsoct(kcfenv+kcfbas),kres,kdist	;FILTER THE SAWTOOTH AUDIO
	  asig	balance		afilt,asig				;BALANCE THE SIGNAL TO PREVENT LARGE VARIATIONS IN AMPLITUDE WHEN DISTORTION OR RESONANCE ARE HIGH
	  asig	=	asig* aenv					;APPLY THE AMPLITUDE ENVELOPE
	  atimL	rspline	10,100,0.01,0.1					;LEFT CHANNEL DELAY TIME 
	  atimR	rspline	10,100,0.01,0.1					;RIGHT CHANNEL DELAY TIME
	  aL	vdelay	asig,atimL,1000					;CREATE LEFT CHANNEL DELAY
	  aR	vdelay	asig,atimR,1000					;CREATE RIGHT CHANNEL DELAY
	  kRvTim	rspline	0.5,0.9,0.05,0.2			;REVERB TIME
	  kRvMix	rspline	0,1,0.03,0.09				;REVERB MIX
	  aRvL,aRvR	reverbsc	aL,aR,0.5,8000			;STEREO REVERB SIGNAL CREATED
	  outs		aL+aRvL*kRvMix,aR+aRvR*kRvMix			;SEND AUDIO TO OUPUT
	endif
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT -  KEEPS PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>