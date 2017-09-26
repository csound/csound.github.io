wgpluck.csd
Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
-odevaudio -M0 -+rtmidi=virtual	-dm0	;VIRTUAL MIDI KEYBOARD
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE = 1, REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL       | WIDTH | HEIGHT | X | Y
		FLpanel	"wgpluck",     500,    500,    0,  0

;BUTTONS							ON | OFF | TYPE | WIDTH | HEIGHT |  X | Y | OPCODE | INS | STARTTIM | DUR
gkInput,gihInput1		FLbutton	"Noise Burst",	1,    1,    21,    150,     30,    10,  10,    0,     2,      0,      -1
gkInput,gihInput2		FLbutton	"Sound File",	2,    0,    22,    150,     30,   170,  10,    0,     2,      0,      -1
gkInput,gihInput3		FLbutton	"Sine Burst",	3,    3,    21,    150,     30,   330,  10,    0,     2,      0,      -1
gkInput,gihInput4		FLbutton	"Sine Tone",	4,    0,    22,    150,     30,   170,  40,    0,     2,      0,      -1
FLsetColor2	255, 255, 50, gihInput2	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, gihInput4	;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES	LABEL  | WIDTH | HEIGHT | X |  Y
idplk		FLvalue	" ",      100,     18,    5,  125
idpick		FLvalue	" ",      100,     18,    5,  175
iddamp		FLvalue	" ",      100,     18,    5,  225
idcps		FLvalue	" ",      100,     18,    5,  275
idamp		FLvalue	" ",      100,     18,    5,  325
idfilt		FLvalue	" ",      100,     18,    5,  375
idImplsGain	FLvalue	" ",      100,     18,    5,  425
idOutGain	FLvalue	" ",      100,     18,    5,  475

;SLIDERS				            				MIN |   MAX   | EXP | TYPE |   DISP      | WIDTH | HEIGHT | X  | Y
gkNseDur, gihNseDur		FLslider	"Duration",			0.1,      2,     0,    23,      -1,         150,    12,    10,    40
gkSineDur, gihSineDur		FLslider	"Duration",			0.1,      2,     0,    23,      -1,         150,    12,   330,    40
gkSineFrq, gihSineFrq		FLslider	"Frequency",			20,    8000,    -1,    23,      -1,         150,    12,   330,    70
gkSineTFrq, gihSineTFrq		FLslider	"Frequency",			20,    8000,    -1,    23,      -1,         150,    12,   170,    70
gkplk, gihplk			FLslider	"Pluck Position (i-rate)",	0,        1,     0,    23,   idplk,         490,    25,     5,   100
gkpick, gihpick			FLslider	"Pick-up Position (k-rate)",	0,   .99999,     0,    23,   idpick,        490,    25,     5,   150
gkdamp, gihdamp			FLslider	"Damping",			0,     1000,     0,    23,   iddamp,        490,    25,     5,   200
gkcps, gihcps			FLslider	"Pitch in CPS",			5,     7000,    -1,    23,   idcps,         490,    25,     5,   250
gkamp, gihamp			FLslider	"Amplitude",			0,        1,     0,    23,   idamp,         490,    25,     5,   300
gkfilt, gihfilt			FLslider	"Filter",			0,     2000,     0,    23,   idfilt,        490,    25,     5,   350
gkImplsGain, gihImplsGain	FLslider	"Impulse Gain",			0,        1,     0,    23,   idImplsGain,   490,    25,     5,   400
gkOutGain, gihOutGain		FLslider	"Output Gain",			0,        1,     0,    23,   idOutGain,     490,    25,     5,   450

;SET INITIAL VALUES OF FLTK VALUATORS
;				VALUE | HANDLE
		FLsetVal_i	.98, 	gihplk
		FLsetVal_i	.1, 	gihpick
		FLsetVal_i	20, 	gihdamp
		FLsetVal_i	300, 	gihcps
		FLsetVal_i	0.5, 	gihamp
		FLsetVal_i	1000, 	gihfilt
		FLsetVal_i	0.15, 	gihImplsGain
		FLsetVal_i	0.15, 	gihOutGain
		FLsetVal_i	0.3, 	gihNseDur
		FLsetVal_i	0.3, 	gihSineDur
		FLsetVal_i	300, 	gihSineFrq
		FLsetVal_i	300, 	gihSineTFrq

		FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 640, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                         wgpluck                             ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"wgpluck produces a simulation of a plucked string using      ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"interpolating delay lines and is based on the Karpluss-Strong", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"plucked string model.                                        ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"It takes an audio signal as an input with which to excite the", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"string although even if this exitation signal is silence a   ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"plucked string sound is still produced. Nonetheless, the     ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"exitation signal does still influence the sound produced.    ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"'Damping' and 'Filter' both have an impact on the tone       ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"produced. 'Damping' has a more marked influence on the sound ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"produced and also has the effect of shorting the duration of ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"the note.                                                    ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"'Pick-up Position' is the only parameter that can be         ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"modulated at k-rate.                                         ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"I have included gain controls on the exitation signal and on ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"the output signal of the opcode.                             ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"A variety of short burst and sustained signals are offered.  ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"A short burst of pink noise, a short sine tone burst whose   ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"frequency can be modulated, a sound file and a sustained sine", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"tone.                                                        ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"'Amplitude' controls the amplitude of the sound of the       ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"plucked string. Low values will not result in silence at the ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"output but instead a greater predominance of the exitation   ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"signal.                                                      ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"'Pick-up Position' allows the user to vary the location of   ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"the pick-up along the length of the string. A value of 0.5   ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"here represents the half-way point along the string, zero and", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"1 represent either end of the string. Zero and 1 will        ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"accentuate the higher harmonics (as the output is a harmonic ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"sound) and 0.5 will favour the odd numbered harmonics,       ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"producing a clarinet-like tone.                              ", 	1,      5,     14,    490,    20,     5, 620

		FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen	0,0,1024,10,1	;A SINE WAVE

instr	1	;MIDI INPUT INSTRUMENT
	icps	cpsmidi			;READ CYCLES PER SECOND VALUE FROM MIDI INPUT
	iamp	ampmidi	1	;AMPLITUDE IS READ FROM INCOMING MIDI NOTE

	iporttime	=	0.1				;PORTAMENTO TIME
	kporttime	linseg	0,0.01,iporttime,1,iporttime	;PORTAMENTO TIME VARIABLE THAT RAMPS UP FROM ZERO
	kpick		portk	gkpick, kporttime		;APPLY PORTAMENTO TO 'PICK-UP POSITION' VARIABLE (PREVENTS 'ZIP' NOISE)
	kSineTFrq	portk	gkSineTFrq, kporttime		;APPLY PORTAMENTO TO 'SINE TONE FREQUENCY' VARIABLE (MAKES MODULATION SMOOTHER)

	if	gkInput==1	then					;IF gkinput=1, I.E. IF 'NOISE BURST' IS SELECTED...
		kenv	expseg		1,i(gkNseDur),.00001,1,.00001	;CREATE AN AMPLITUDE ENVELOPE FOR THE NOISE BURST
		axcite	pinkish		kenv			;CREATE A PINK NOISE SIGNAL
	elseif	gkInput==2	then					;IF gkinput=2, I.E. IF 'SOUND FILE' IS SELECTED...
		axcite, aR	diskin2		"Songpan.wav",1,0,1	;CREATE AN AUDIO SIGNAL FROM A FILE STORED ON DISK. RIGHT CHANNEL WILL BE IGNORED. SOUND WILL PLAY FROM THE BEGINNING AND WILL LOOP CONTINUOUSLY
	elseif	gkInput==3	then					;IF gkinput=3, I.E. IF 'SINE TONE' IS SELECTED...
		kenv	expseg		1,i(gkSineDur),.00001,1,.00001	;CREATE AN AMPLITUDE ENVELOPE FOR THE SINE BURST
		axcite		oscili	kenv, gkSineFrq, gisine	;CREATE A SINE TONE, FREQUENCY TAKEN FROM FLTK SLIDER
	elseif	gkInput==4	then					;IF gkinput=4, I.E. IF 'SINE BURST' IS SELECTED...
		axcite		oscili	1, kSineTFrq, gisine	;CREATE A SINE TONE
	endif

	kSwitch	changed	gkamp, gkplk, gkdamp, gkfilt	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	UPDATE
	endif

	UPDATE:
	ares	wgpluck 	icps, i(gkamp), kpick, i(gkplk), i(gkdamp), i(gkfilt), axcite * gkImplsGain	
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
	outs 		ares * gkOutGain, ares * gkOutGain	;SEND AUDIO TO OUTPUTS, SCALE OUTPUT BY gkOutGain WHICH IS CREATED BY AN FLTK SLIDER
endin

instr	2		;FLTK INSTRUMENT
	if	gkInput==0	then	;IF gkInput=0, I.E. ALL ON/OFF BUTTONS ARE OFF...
		turnoff			;...TURN OFF THIS INSTRUMENT IMMEDIATELY
	endif				;END OF CONDITIONAL BRANCH

	iporttime	=	0.1				;PORTAMENTO TIME
	kporttime	linseg	0,0.01,iporttime,1,iporttime	;PORTAMENTO TIME VARIABLE THAT RAMPS UP FROM ZERO
	kpick		portk	gkpick, kporttime		;APPLY PORTAMENTO TO 'PICK-UP POSITION' VARIABLE (PREVENTS 'ZIP' NOISE)
	kSineTFrq	portk	gkSineTFrq, kporttime		;APPLY PORTAMENTO TO 'SINE TONE FREQUENCY' VARIABLE (MAKES MODULATION SMOOTHER)

	if	gkInput==1	then					;IF gkinput=1, I.E. IF 'NOISE BURST' IS SELECTED...
		kenv	expseg		1,i(gkNseDur),.00001,1,.00001	;CREATE AN AMPLITUDE ENVELOPE FOR THE NOISE BURST
		axcite	pinkish		kenv			;CREATE A PINK NOISE SIGNAL
	elseif	gkInput==2	then					;IF gkinput=2, I.E. IF 'SOUND FILE' IS SELECTED...
		axcite, aR	diskin2		"Songpan.wav",1,0,1	;CREATE AN AUDIO SIGNAL FROM A FILE STORED ON DISK. RIGHT CHANNEL WILL BE IGNORED. SOUND WILL PLAY FROM THE BEGINNING AND WILL LOOP CONTINUOUSLY
	elseif	gkInput==3	then					;IF gkinput=3, I.E. IF 'SINE TONE' IS SELECTED...
		kenv	expseg		1,i(gkSineDur),.00001,1,.00001	;CREATE AN AMPLITUDE ENVELOPE FOR THE SINE BURST
		axcite		oscili	kenv, gkSineFrq, gisine	;CREATE A SINE TONE, FREQUENCY TAKEN FROM FLTK SLIDER
	elseif	gkInput==4	then					;IF gkinput=4, I.E. IF 'SINE BURST' IS SELECTED...
		axcite		oscili	1, kSineTFrq, gisine	;CREATE A SINE TONE
	endif

	kSwitch	changed	gkcps, gkamp, gkplk, gkdamp, gkfilt	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	UPDATE
	endif

	UPDATE:
	ares	wgpluck 	i(gkcps), i(gkamp), kpick, i(gkplk), i(gkdamp), i(gkfilt), axcite * gkImplsGain	
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
	outs 		ares * gkOutGain, ares * gkOutGain	;SEND AUDIO TO OUTPUTS, SCALE OUTPUT BY gkOutGain WHICH IS CREATED BY AN FLTK SLIDER
endin

</CsInstruments>

<CsScore>
f 0 3600		;DUMMY SCORE EVENT - ALLOW REALTIME PERFORMANCE FOR UP TO 1 HOUR 
</CsScore>

</CsoundSynthesizer>