FMMod2Car.csd
Written by Iain McCurdy, 2008

<CsoundSynthesizer>

<CsOptions>
-odac -M0 -dm0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>

sr	=	44100
ksmps	=	128
nchnls	=	2

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL                             | WIDTH | HEIGHT | X | Y
	FLpanel	"FM Synthesis: Modulator -> 2 Carriers",     500,    450,    0,  0

;                                               ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"On/Off(MIDI)",	1,    0,    22,    150,     25,    5,  5,    0,      2,      0,      -1
gkExit,ihExit	FLbutton	"Exit",		1,    0,    21,    140,     25,  355,  5,    0,    999,      0,       0.001
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES					WIDTH | HEIGHT | X |  Y
idbasefreq			FLvalue	" ",     	60,       20,    5,   75
idindex				FLvalue	" ",     	60,       20,    5,  125
idCar1Amp			FLvalue	" ",     	50,       20,    5,  175
idCar2Amp			FLvalue	" ",     	50,       20,  255,  175
idGain				FLvalue	" ",     	60,       20,    5,  325

;					            							MIN  |   MAX | EXP | TYPE |   DISP     | WIDTH | HEIGHT |  X | Y
gkbasefreq, gihbasefreq		FLslider 	"Base Frequency",		 			20,    20000,  -1,    23,  idbasefreq,    490,     25,     5, 50
gkindex, gihindex		FLslider 	"Modulation Index",					0,        50,   0,    23,  idindex,       395,     25,     5, 100
gkCar1Amp, gihCar1Amp		FLslider 	"Carrier 1 Amplitude",					0,     30000,   0,    23,  idCar1Amp,     240,     25,     5, 150
gkCar2Amp, gihCar2Amp		FLslider 	"Carrier 2 Amplitude",					0,     30000,   0,    23,  idCar2Amp,     240,     25,   255, 150
gkGain, ihGain			FLslider 	"Master Gain",		 				0,         1,   0,    23,  idGain,        490,     25,     5, 300

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	3,        9,    15,    480,    70,    10, 360
;                                               ON | OFF | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE | INS | STARTTIM | IDUR | p4(BASE FREQ) | p5(INDEX) | p6(CAR_1_RATIO) | p7(CAR_2_RATIO) | p8(MOD_RATIO) | p9(CAR_1_AMP)| p10(CAR_2_AMP)
gkPreset,ih		FLbutton	"1",	1,    0,   21,      30,     25,    90, 382,    0,     3,      0,      0,          50,          10.5,            1,                1,             1.005,         10000,         10000                                          
gkPreset,ih		FLbutton	"2",	1,    0,   21,      30,     25,   140, 382,    0,     3,      0,      0,          30,             9,           18,               18,                20,         10000,         10000                                          
gkPreset,ih		FLbutton	"3",	1,    0,   21,      30,     25,   190, 382,    0,     3,      0,      0,          42,          11.7,            8,                8,            1.9991,         10000,         10000
gkPreset,ih		FLbutton	"4",	1,    0,   21,      30,     25,   240, 382,    0,     3,      0,      0,         312,           1.8,            1,                1,             1.305,         10000,         10000
gkPreset,ih		FLbutton	"5",	1,    0,   21,      30,     25,   290, 382,    0,     3,      0,      0,         278,           2.1,            5,                5,                20,         10000,         10000                                          
gkPreset,ih		FLbutton	"6",	1,    0,   21,      30,     25,   340, 382,    0,     3,      0,      0,         260,             4,           .5,               .5,                20,         10000,         10000                                          
gkPreset,ih		FLbutton	"7",	1,    0,   21,      30,     25,   390, 382,    0,     3,      0,      0,         103,             3,           18,               18,                20,         10000,         10000                                          
gkPreset,ih		FLbutton	"8",	1,    0,   21,      30,     25,   440, 382,    0,     3,      0,      0,          70,           2.3,            8,                8,              1.01,         10000,         10000                                          
;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Presets:", 		1,     11,     16,    70,    15,     15,  385


;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	6,        9,    15,    370,    70,    30, 220
;						 			MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkCar1Ratio, gihCar1Ratio	FLtext		" ", 			.125,  20,  .0001,  1,     60,     20,   140, 230
gkCar2Ratio, gihCar2Ratio	FLtext		" ", 			.125,  20,  .0001,  1,     60,     20,   220, 230
gkModRatio, gihModRatio		FLtext		" ", 			.125,  20,  .0001,  1,     60,     20,   300, 230
gkPeakDev, gihPeakDev		FLtext		"P. Dev.", 		0,  10000,     0,   1,     80,     20,   405, 105 ;DISPLAY ONLY!
;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Freq. Ratios:",	1,      5,     12,   100,    15,     40,  232
ih		 	FLbox  	":", 			1,      5,     14,     5,    15,    208,  232
ih		 	FLbox  	":", 			1,      5,     14,     5,    15,    288,  232
ih		 	FLbox  	"Car. 1 Frequency", 	1,      5,     12,    90,    15,    125,  260
ih		 	FLbox  	"Car. 2 Frequency", 	1,      5,     12,    90,    15,    205,  260
ih		 	FLbox  	"Mod. Frequency", 	1,      5,     12,    90,    15,    285,  260

			FLsetVal_i	100, 	gihbasefreq
			FLsetVal_i	3, 	gihindex
			FLsetVal_i	1, 	gihCar1Ratio
			FLsetVal_i	1, 	gihCar2Ratio
			FLsetVal_i	1, 	gihModRatio
			FLsetVal_i	4000, 	gihCar1Amp
			FLsetVal_i	4000, 	gihCar2Amp
			FLsetVal_i	.7, 	ihGain

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 400, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"           FM Synthesis: Modulator -> 2 Carriers             ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"                           +-----+                           ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"                           |MOD. |                           ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"                           +--+--+                           ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"                              |                              ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"                       +------+-----+                        ", 	1,      5,     14,    490,    20,     5, 120
ih	  	 	FLbox  	"                       |            |                        ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"                    +--+--+      +--+--+                     ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"                    |CAR.1|      |CAR.2|                     ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"                    +--+--+      +--+--+                     ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"                       |            |                        ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"                       +------+-----+                        ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"                              |                              ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"                              V                              ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"                             OUT                             ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"This three oscillator example demonstrates a single modulator", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"simultaneously modulating the frequency parameter of a single", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"carrier.                                                     ", 	1,      5,     14,    490,    20,     5, 380

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen	0,0,4096,10,1	;A SINE WAVE

instr	1	;MIDI INPUT INSTRUMENT
	if	gkOnOff=1	then	;IF FLTK/MIDI SWITCH IS SET TO 'FLTK'...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	icps	cpsmidi			;READ CYCLES PER SECOND VALUE FROM MIDI INPUT
	iamp	ampmidi	1		;READ IN A NOTE VELOCITY VALUE FROM THE MIDI INPUT
	;				P1 | P4 | P5
	aoutL, aoutR	subinstr	2,  icps, iamp	;ACTIVATE A SUB-INSTRUMENT
		outs	aoutL, aoutR	;SEND AUDIO TO SPEAKERS
endin

instr	2   	;FM INSTRUMENT
	kactive1	active	1	;SENSE NUMBER OF ACTIVE INSTANCES OF INSTRUMENT 1 (I.E. MIDI ACTIVATED INSTRUMENT) 
	if	gkOnOff=0&&kactive1=0	then	;IF FLTK/MIDI SWITCH IS SET TO 'MIDI' AND NO MIDI NOTES ARE ACTIVE...
		turnoff					;TURN THIS INSTRUMENT
	endif						;END OF CONDITIONAL BRANCHING
	if	gkOnOff = 1	then			;IF FLTK/MIDI SWITCH IS SET TO 'FLTK'...
		kCar1Amp = gkCar1Amp			;SET kamp TO FLTK SLIDER VALUE gkamp
		kCar2Amp = gkCar2Amp			;SET kamp TO FLTK SLIDER VALUE gkamp
		kbasefreq = gkbasefreq			;
		kindex = gkindex			;
	else						;OTHERWISE...
		kbasefreq = p4				;SET FUNDEMENTAL TO RECEIVED p4 RECEIVED FROM INSTR 1. I.E. MIDI PITCH
		kCar1Amp = p5 * gkCar1Amp		;SET AMPLITUDE TO RECEIVED p5 RECEIVED FROM INSTR 1 (I.E. MIDI VELOCITY) MULTIPLIED BY FLTK SLIDER gkamp.
		kCar2Amp = p5 * gkCar2Amp		;SET AMPLITUDE TO RECEIVED p5 RECEIVED FROM INSTR 1 (I.E. MIDI VELOCITY) MULTIPLIED BY FLTK SLIDER gkamp.
		kindex = p5 * gkindex			;
	endif						;END OF CONDITIONAL BRANCHING
	
	iporttime	=	.02					;PORTAMENTO TIME (TO BE APPLIED TO K-RATE VARIABLES IN ORDER TO IMPLEMENT DAMPING)
	kporttime	linseg	0, .001, iporttime, 1, iporttime	;FINAL VARIABLE WILL RAMP UP
	
	kbasefreq	portk	kbasefreq, kporttime	;PORTAMENTO APPLIED
	kindex		portk	kindex, kporttime	;PORTAMENTO APPLIED
	kCar1Amp	portk	kCar1Amp, kporttime	;PORTAMENTO APPLIED
	kCar2Amp	portk	kCar2Amp, kporttime	;PORTAMENTO APPLIED
	kGain		portk	gkGain, kporttime	;PORTAMENTO APPLIED
	
	kpeakdeviation	=	kbasefreq * kindex	;CALCUALATE THE PEAK DEVIATION OF THE MODULATOR FROM THE VALUES GIVEN FOR BASE FREQUENCY AND THE INDEX OF MODULATION

	aAntiClick	linsegr	0,0.001,1,0.01,0	;ANTI CLICK ENVELOPE
	
	;OUTPUT		OPCODE	AMPLITUDE           |     FREQUENCY                          | FUNCTION_TABLE
	aModulator	oscili	kpeakdeviation,       kbasefreq * gkModRatio,                     gisine		;DEFINE THE MODULATOR WAVEFORM
	aCarrier1	oscili	kCar1Amp*aAntiClick, (kbasefreq * gkCar1Ratio) + aModulator,      gisine		;DEFINE THE CARRIER WAVEFORM (NOTE HOW ITS FREQUENCY IS MODULATED (THROUGH ADDITION) BY THE AUDIO OUTPUT OF THE MODULATOR WAVEFORM)
	aCarrier2	oscili	kCar2Amp*aAntiClick, (kbasefreq * gkCar2Ratio) + aModulator,      gisine		;DEFINE THE CARRIER WAVEFORM (NOTE HOW ITS FREQUENCY IS MODULATED (THROUGH ADDITION) BY THE AUDIO OUTPUT OF THE MODULATOR WAVEFORM)
	aMix		sum	aCarrier1, aCarrier2
			outs	aMix*kGain, aMix*kGain		;SEND THE MIXED AUDIO OUTPUT OF THE CARRIER WAVEFORMS TO THE OUTPUTS 
	ktrig	  	metro	10	;CREATE A REPEATING TRIGGER SIGNAL
			FLsetVal 	ktrig, kpeakdeviation, gihPeakDev	;UPDATE VALUE BOX 'gihPeakDev' WITH THE VALUE kpeakdeviation WHENEVER A TRIGGER PULSE IS RECEIVED
endin

instr	3	;PRESETS
	FLsetVal_i	p4, gihbasefreq
	FLsetVal_i	p5, gihindex
	FLsetVal_i	p6, gihModRatio
	FLsetVal_i	p7, gihCar1Ratio
	FLsetVal_i	p8, gihCar2Ratio
	FLsetVal_i	p9, gihCar1Amp
	FLsetVal_i	p10, gihCar2Amp
endin

instr	999
	exitnow
endin

</CsInstruments>

<CsScore>
f 1 0 129 10 1	;A SINE WAVE (INTERPOLATING OSCILLATOR OPCODES ARE USED THEREFORE A SMALL TABLE SIZE (+1) CAN BE USED)
f 0 3600	;DUMMY SCORE EVENT - KEEPS REALTIME PERFORMANCE GOING FOR ONE HOUR
</CsScore>

</CsoundSynthesizer>