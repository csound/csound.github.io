repluck.csd
Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
-odac -dm0 -M0 -+rtmidi=virtual	;VIRTUAL MIDI KEYBOARD
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	1	;NUMBER OF CHANNELS
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL       | WIDTH | HEIGHT | X | Y
		FLpanel	"repluck",     500,    450,    0,  0

;BUTTONS						ON | OFF | TYPE | WIDTH | HEIGHT |  X | Y | OPCODE | INS | STARTTIM | DUR
gkInput,ihInput1	FLbutton	"Noise Burst",	1,    1,    21,    150,     30,    10,  10,    0,     1,      0,      -1
gkInput,ihInput2	FLbutton	"Sound File",	2,    0,    22,    150,     30,   170,  10,    0,     1,      0,      -1
gkInput,ihInput3	FLbutton	"Sine Burst",	3,    3,    21,    150,     30,   330,  10,    0,     1,      0,      -1
gkInput,ihInput4	FLbutton	"Sine Tone",	4,    0,    22,    150,     30,   170,  40,    0,     1,      0,      -1
FLsetColor2	255, 255, 50, ihInput2		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihInput4		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES	LABEL  | WIDTH | HEIGHT | X |  Y
idplk		FLvalue	" ",      100,     18,    5,  125
idpick		FLvalue	" ",      100,     18,    5,  175
idrefl		FLvalue	" ",      100,     18,    5,  225
idcps		FLvalue	" ",      100,     18,    5,  275
idamp		FLvalue	" ",      100,     18,    5,  325
idImplsGain	FLvalue	" ",      100,     18,    5,  375
idOutGain	FLvalue	" ",      100,     18,    5,  425

;SLIDERS				            				MIN |   MAX   | EXP | TYPE |   DISP         | WIDTH | HEIGHT | X  | Y
gkNseDur, ihNseDur		FLslider	"Duration",			0.1,      8,     0,    23,       -1,            150,    12,    10,    40
gkSineDur, ihSineDur		FLslider	"Duration",			0.1,      2,     0,    23,       -1,            150,    12,   330,    40
gkSineFrq, ihSineFrq		FLslider	"Frequency",			20,    8000,    -1,    23,       -1,            150,    12,   330,    70
gkSineTFrq, ihSineTFrq		FLslider	"Frequency",			20,    8000,    -1,    23,       -1,            150,    12,   170,    70
gkplk, ihplk			FLslider	"Pluck Position (i-rate)",	0,        1,     0,    23,    idplk,            490,    25,     5,   100
gkpick, ihpick			FLslider	"Pick-up Position (k-rate)",	0,   .99999,     0,    23,    idpick,           490,    25,     5,   150
gkrefl, ihrefl			FLslider	"Reflection",			0.0001,.9999,    0,    23,    idrefl,           490,    25,     5,   200
gkcps, gihcps			FLslider	"Pitch in CPS",			5,     7000,    -1,    23,    idcps,            490,    25,     5,   250
gkamp, ihamp			FLslider	"Amplitude",			0,        1,     0,    23,    idamp,            490,    25,     5,   300
gkImplsGain, ihImplsGain	FLslider	"Impulse Gain",			0,        1,     0,    23,    idImplsGain,      490,    25,     5,   350
gkOutGain, ihOutGain		FLslider	"Output Gain",			0,        1,     0,    23,    idOutGain,        490,    25,     5,   400

;SET INITIAL VALUES OF FLTK VALUATORS
;				VALUE | HANDLE
		FLsetVal_i	.98, 	ihplk
		FLsetVal_i	.1, 	ihpick
		FLsetVal_i	0.5, 	ihrefl
		FLsetVal_i	300, 	gihcps
		FLsetVal_i	0.1, 	ihamp
		FLsetVal_i	0.15, 	ihImplsGain
		FLsetVal_i	0.7, 	ihOutGain
		FLsetVal_i	0.3, 	ihNseDur
		FLsetVal_i	0.3, 	ihSineDur
		FLsetVal_i	300, 	ihSineFrq
		FLsetVal_i	300, 	ihSineTFrq

		FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 340, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                         repluck                             ", 	1,       5,    14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,       5,    14,    490,    20,     5,  20
ih		 	FLbox  	"repluck is an implementation of the Karpluss-Strong plucked  ", 	1,       5,    14,    490,    20,     5,  40
ih		 	FLbox  	"string algorithm.                                            ", 	1,       5,    14,    490,    20,     5,  60
ih		 	FLbox  	"It is rather similar in design to wgpluck in that it also    ", 	1,       5,    14,    490,    20,     5,  80
ih		 	FLbox  	"takes an exitation signal as input but its internal filtering", 	1,       5,    14,    490,    20,     5, 100
ih		 	FLbox  	"works slightly differently.                                  ", 	1,       5,    14,    490,    20,     5, 120
ih		 	FLbox  	"Filtering or damping is controlled using 'Reflection'. This  ", 	1,       5,    14,    490,    20,     5, 140
ih		 	FLbox  	"can be though of as the reflectiveness (or the amount of     ", 	1,       5,    14,    490,    20,     5, 160
ih		 	FLbox  	"damping action) of the 2 points of fixture at either end of  ", 	1,       5,    14,    490,    20,     5, 180
ih		 	FLbox  	"the string.                                                  ", 	1,       5,    14,    490,    20,     5, 200
ih		 	FLbox  	"The 'Amplitude' control seems to be more effective in        ", 	1,       5,    14,    490,    20,     5, 220
ih		 	FLbox  	"repluck. Again, low values here allow greater predominance   ", 	1,       5,    14,    490,    20,     5, 240
ih		 	FLbox  	"of the exitation signal in the output.                       ", 	1,       5,    14,    490,    20,     5, 260
ih		 	FLbox  	"Some of the other aspects of this example are explained more ", 	1,       5,    14,    490,    20,     5, 280
ih		 	FLbox  	"fully in the example 'wgpluck.csd'.                          ", 	1,       5,    14,    490,    20,     5, 300
ih		 	FLbox  	"This example can also be played from a MIDI keyboard.        ", 	1,       5,    14,    490,    20,     5, 320
		FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen	0,0,1024,10,1	;A SINE WAVE

instr	1
	kporttime	linseg	0,0.01,0.05		;PORTAMENTO TIME RAMPS UP QUICKLY FROM ZERO

	iMIDIActiveValue	=	1		;IF MIDI ACTIVATED
	iMIDIflag		=	0		;IF FLTK ACTIVATED
	mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 

	if gkInput==0&&iMIDIflag==0 then 	;SENSE FLTK ON/OFF SWITCH & WHETHER THIS IS A MIDI NOTE ITS STATUS WILL BE IGNORED
	 turnoff				;TURN OFF THIS INSTRUMENT IMMEDIATELY
	endif					;END OF THIS CONDITIONAL BRANCH
	
	if iMIDIflag==1 then				;IF THIS IS A MIDI ACTIVATED NOTE...
	 icps	cpsmidi				;READ MIDI PITCH VALUES - THIS VALUE CAN BE MAPPED TO GRAIN DENSITY AND/OR PITCH DEPENDING ON THE SETTING OF THE MIDI MAPPING SWITCHES
	 kcps	=	icps
	 ivel	veloc		0,1		;READ NOTE VELOCITY. WILL BE WITHIN THE RANGE 0 AND 1
	 kamp	=	gkamp * ivel
	else						;OTHERWISE...
	 kcps		portk	gkcps, kporttime		;SMOOTH VARIABLE CHANGES WITH PORTK
	 kamp		portk	gkamp, kporttime		;APPLY PORTAMENTO SMOOTHING
	endif						;END OF THIS CONDITIONAL BRANCH

	kpick		portk	gkpick, kporttime		;APPLY PORTAMENTO TO 'PICK-UP POSITION' VARIABLE (PREVENTS 'ZIP' NOISE)
	kSineTFrq	portk	gkSineTFrq, kporttime		;APPLY PORTAMENTO TO 'SINE TONE FREQUENCY' VARIABLE (MAKES MODULATION SMOOTHER)

	if	i(gkInput)==2	then					;IF gkinput=2, I.E. IF 'SOUND FILE' IS SELECTED...
		axcite, aR	diskin2		"Songpan.wav",1,0,1	;CREATE AN AUDIO SIGNAL FROM A FILE STORED ON DISK. RIGHT CHANNEL WILL BE IGNORED. SOUND WILL PLAY FROM THE BEGINNING AND WILL LOOP CONTINUOUSLY
	elseif	i(gkInput)==3	then					;IF gkinput=3, I.E. IF 'SINE TONE' IS SELECTED...
		kenv	expseg		1,i(gkSineDur),.00001,1,.00001	;CREATE AN AMPLITUDE ENVELOPE FOR THE SINE BURST
		axcite		oscili	kenv, gkSineFrq, gisine		;CREATE A SINE TONE, FREQUENCY TAKEN FROM FLTK SLIDER
	elseif	i(gkInput)==4	then					;IF gkinput=4, I.E. IF 'SINE BURST' IS SELECTED...
		axcite		oscili	1, kSineTFrq, gisine		;CREATE A SINE TONE
	elseif	i(gkInput)==5	then					;IF gkinput=4, I.E. IF 'SINE BURST' IS SELECTED...
		kenv	expseg		1,i(gkNseDur),.00001,1,.00001	;CREATE AN AMPLITUDE ENVELOPE FOR THE NOISE BURST
		axcite	pinkish		kenv				;CREATE A PINK NOISE SIGNAL
	else	
		kenv	expseg		1,i(gkNseDur),.00001,1,.00001	;CREATE AN AMPLITUDE ENVELOPE FOR THE NOISE BURST
		axcite	pinkish		kenv				;CREATE A PINK NOISE SIGNAL
	endif
	
	kSwitch	changed	gkcps, gkplk	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if 	kSwitch=1	then
		reinit	START
	endif
	START:	

	ares 	repluck 	i(gkplk), kamp, icps, kpick, gkrefl, axcite * gkImplsGain	;REPLUCK. NOTE EXCITATION SIGNAL SCALED BY gkImplsGain WHICH IS CREATED BY AN FLTK SLIDER
	rireturn
	aenv	linsegr	1,0.1,0	;CREATE AN AMPLITUDE ENVELOPE. THIS WILL BE USED TO PREVENT CLICKS.
		out 		ares * aenv * gkOutGain	;SEND AUDIO TO OUTPUTS, SCALE OUTPUT BY gkOutGain WHICH IS CREATED BY AN FLTK SLIDER
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT
</CsScore>

</CsoundSynthesizer>