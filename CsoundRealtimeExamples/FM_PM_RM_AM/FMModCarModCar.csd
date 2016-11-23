FMModCarModcar.csd
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
;			LABEL                                 | WIDTH | HEIGHT | X | Y
	FLpanel	"FM Synthesis: Modulator->Modulator->Carrier",   500,    550,    0,  0

;                                               	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"On/Off(MIDI)",		1,    0,    22,    140,     25,    5,  5,    0,      2,      0,      -1
gkExit,ihExit	FLbutton	"Exit",			1,    0,    21,    140,     25,  355,  5,    0,    999,      0,       0.001
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	6,        9,    15,    220,    70,    15, 260
ih		 	FLbox  	" ", 	6,        9,    15,    220,    70,   265, 260
ih		 	FLbox  	" ", 	5,        9,    15,    248,   310,     1,  90
ih		 	FLbox  	" ", 	5,        9,    15,    248,   310,   251,  90

;VALUE DISPLAY BOXES					WIDTH | HEIGHT | X |  Y
idbasefreq			FLvalue	" ",     	50,       20,    5,   60
idFTune1			FLvalue	" ",     	50,       20,    5,  125
idFTune2			FLvalue	" ",     	50,       20,  255,  125
idindex1			FLvalue	" ",     	50,       20,    5,  175
idindex2			FLvalue	" ",     	50,       20,  255,  175
idCar1Amp			FLvalue	" ",     	50,       20,    5,  375
idCar2Amp			FLvalue	" ",     	50,       20,  255,  375
idGain				FLvalue	" ",     	50,       20,    5,  435

;					            				MIN  |   MAX | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X | Y
gkbasefreq, gihbasefreq		FLslider 	"Base Frequency",		1,     20000,  -1,    23,  idbasefreq,    490,    25,     5, 35
gkFTune1, gihFTune1		FLslider 	"Fine Tune (Cents) 1",		-100,    100,   0,    23,    idFTune1,    240,    25,     5, 100
gkFTune2, gihFTune2		FLslider 	"Fine Tune (Cents) 2",		-100,    100,   0,    23,    idFTune2,    240,    25,   255, 100
gkindex1, gihindex1		FLslider 	"Modulation Index 1",		0,        50,   0,    23,    idindex1,    240,    25,     5, 150
gkindex2, gihindex2		FLslider 	"Modulation Index 2",		0,        50,   0,    23,    idindex2,    240,    25,   255, 150
gkCar1Amp, gihCar1Amp		FLslider 	"Carrier Amplitude 1",		0,     30000,   0,    23,   idCar1Amp,    240,    25,     5, 350
gkCar2Amp, gihCar2Amp		FLslider 	"Carrier Amplitude 2",		0,     30000,   0,    23,   idCar2Amp,    240,    25,   255, 350
gkGain, ihGain			FLslider 	"Master Gain",		 	0,         1,   0,    23,      idGain,    490,    25,     5, 410

;						 			MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkCar1Ratio, gihCar1Ratio	FLtext		" ", 			.125,  12,  .0001,  1,     60,     20,    55, 270
gkMod1Ratio, gihMod1Ratio	FLtext		" ", 			.125,  12,  .0001,  1,     60,     20,   130, 270
gkCar2Ratio, gihCar2Ratio	FLtext		" ", 			.125,  12,  .0001,  1,     60,     20,   305, 270
gkMod2Ratio, gihMod2Ratio	FLtext		" ", 			.125,  12,  .0001,  1,     60,     20,   380, 270
gkPeakDev1, gihPeakDev1		FLtext		"P. Dev. 1", 		0,  10000,     0,   1,     80,     20,    85, 215 ;DISPLAY ONLY!
gkPeakDev2, gihPeakDev2		FLtext		"P. Dev. 2", 		0,  10000,     0,   1,     80,     20,   335, 215 ;DISPLAY ONLY!

;TEXT BOXES										TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	":", 							1,      5,     14,     5,    15,    120,  272
ih		 	FLbox  	":", 							1,      5,     14,     5,    15,    370,  272
ih		 	FLbox  	"Car. 1 Frequency", 					1,      5,     12,    90,    15,     40,  300
ih		 	FLbox  	"Mod. 1 Frequency", 					1,      5,     12,    90,    15,    115,  300
ih		 	FLbox  	"Car. 2 Frequency", 					1,      5,     12,    90,    15,    290,  300
ih		 	FLbox  	"Mod. 2 Frequency", 					1,      5,     12,    90,    15,    365,  300

			FLsetVal_i	100, 	gihbasefreq
			FLsetVal_i	0, 	gihFTune1
			FLsetVal_i	0, 	gihFTune2
			FLsetVal_i	3, 	gihindex1
			FLsetVal_i	3, 	gihindex2
			FLsetVal_i	1, 	gihCar1Ratio
			FLsetVal_i	1, 	gihMod1Ratio
			FLsetVal_i	1, 	gihCar2Ratio
			FLsetVal_i	1, 	gihMod2Ratio
			FLsetVal_i	6000, 	gihCar1Amp
			FLsetVal_i	6000, 	gihCar2Amp
			FLsetVal_i	.8, 	ihGain

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	3,        9,    15,    480,    70,    10, 460
;                                               ON | OFF | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE | INS | STARTTIM | IDUR | p4(BASE FREQ) | p5(INDEX 1) | p6(INDEX 2) | p7(CAR_1_RATIO)| p8(MOD_1_RATIO) | p9(CAR_2_RATIO) | p10(MOD_2_RATIO)  | p11(F.Tune_1) | p12(F.Tune_2)
gkPreset,ih		FLbutton	"1",	1,    0,    21,     30,     25,    90, 482,    0,     3,      0,      0,          99,             3,           3,                1,            1.300,                 1,           1.302,              -4,           1.33
gkPreset,ih		FLbutton	"2",	1,    0,    21,     30,     25,   140, 482,    0,     3,      0,      0,         202,           5.3,         3.3,                1,            1.976,                 1,           1.302,         -17.333,         0.4444
gkPreset,ih		FLbutton	"3",	1,    0,    21,     30,     25,   190, 482,    0,     3,      0,      0,         100,             3,           3,                1,                1,                 1,               1,               0,              0
gkPreset,ih		FLbutton	"4",	1,    0,    21,     30,     25,   240, 482,    0,     3,      0,      0,          67,         7.333,           4,                5,                4,                 3,               2,         -0.4444,         17.333
gkPreset,ih		FLbutton	"5",	1,    0,    21,     30,     25,   290, 482,    0,     3,      0,      0,          94,            26,          16,                7,                4,                 9,               5,              -4,         -1.333
gkPreset,ih		FLbutton	"6",	1,    0,    21,     30,     25,   340, 482,    0,     3,      0,      0,         109,            26,          16,                1,                2,                 1,               4,          -9.333,         0.4444
gkPreset,ih		FLbutton	"7",	1,    0,    21,     30,     25,   390, 482,    0,     3,      0,      0,         777,        2.6667,      3.7778,                1,              .75,                 1,              .5,          -2.222,         0.4444
gkPreset,ih		FLbutton	"8",	1,    0,    21,     30,     25,   440, 482,    0,     3,      0,      0,      365.46,        1.7778,      2.2222,             3.17,              2.3,             1.175,            4.37,          -0.444,         0.4444
;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Presets:", 		1,     11,     16,    70,    15,     15,  485

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 420, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"   FM Synthesis: Modulator->Carrier / Modulator->Carrier     ", 	1,      5,     14,    490,     20,    5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,     20,    5,  20
ih		 	FLbox  	"               +-----+      +-----+                          ", 	1,      5,     14,    490,     20,    5,  40
ih		 	FLbox  	"               |MOD.1|      |MOD.2|                          ", 	1,      5,     14,    490,     20,    5,  60
ih		 	FLbox  	"               +--+--+      +--+--+                          ", 	1,      5,     14,    490,     20,    5,  80
ih		 	FLbox  	"                  |            |                             ", 	1,      5,     14,    490,     20,    5, 100
ih		 	FLbox  	"               +--+--+      +--+--+                          ", 	1,      5,     14,    490,     20,    5, 120
ih	  	 	FLbox  	"               |CAR.1|      |CAR.2|                          ", 	1,      5,     14,    490,     20,    5, 140
ih		 	FLbox  	"               +--+--+      +--+--+                          ", 	1,      5,     14,    490,     20,    5, 160
ih		 	FLbox  	"                  |            |                             ", 	1,      5,     14,    490,     20,    5, 180
ih		 	FLbox  	"                  +------+-----+                             ", 	1,      5,     14,    490,     20,    5, 200
ih		 	FLbox  	"                         |                                   ", 	1,      5,     14,    490,     20,    5, 220
ih		 	FLbox  	"                         V                                   ", 	1,      5,     14,    490,     20,    5, 240
ih		 	FLbox  	"                        OUT                                  ", 	1,      5,     14,    490,     20,    5, 260
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,     20,    5, 280
ih		 	FLbox  	"This example demonstrates a four oscillator algorithm that   ", 	1,      5,     14,    490,     20,    5, 300
ih		 	FLbox  	"combines the audio outputs of two modulator-carrier pairs.   ", 	1,      5,     14,    490,     20,    5, 320
ih		 	FLbox  	"Each carrier-modulator pair has a fine tune control which    ", 	1,      5,     14,    490,     20,    5, 340
ih		 	FLbox  	"facilitates detuning of both the modulator and the carrier   ", 	1,      5,     14,    490,     20,    5, 360
ih		 	FLbox  	"of that pair. This function facilitates the introduction of  ", 	1,      5,     14,    490,     20,    5, 380
ih		 	FLbox  	"beating effects between the two oscillator pairs.            ", 	1,      5,     14,    490,     20,    5, 400

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
		kindex1 = gkindex1			;
		kindex2 = gkindex2			;
	else						;OTHERWISE...
		kbasefreq = p4				;SET FUNDEMENTAL TO RECEIVED p4 RECEIVED FROM INSTR 1. I.E. MIDI PITCH
		kCar1Amp = p5 * gkCar1Amp		;SET AMPLITUDE TO RECEIVED p5 RECEIVED FROM INSTR 1 (I.E. MIDI VELOCITY) MULTIPLIED BY FLTK SLIDER gkamp.
		kCar2Amp = p5 * gkCar2Amp		;SET AMPLITUDE TO RECEIVED p5 RECEIVED FROM INSTR 1 (I.E. MIDI VELOCITY) MULTIPLIED BY FLTK SLIDER gkamp.
		kindex1 = p5 * gkindex1			;
		kindex2 = p5 * gkindex2			;
	endif						;END OF CONDITIONAL BRANCHING

	iporttime	=	.02					;PORTAMENTO TIME (TO BE APPLIED TO K-RATE VARIABLES IN ORDER TO IMPLEMENT DAMPING)
	kporttime	linseg	0, .001, iporttime, 1, iporttime	;FINAL VARIABLE WILL RAMP UP
	
	kbasefreq	portk	kbasefreq, kporttime	;PORTAMENTO APPLIED
	kindex1		portk	kindex1, kporttime	;PORTAMENTO APPLIED
	kindex2		portk	kindex2, kporttime	;PORTAMENTO APPLIED
	kCar1Amp	portk	kCar1Amp, kporttime	;PORTAMENTO APPLIED
	kCar2Amp	portk	kCar2Amp, kporttime	;PORTAMENTO APPLIED
	kFTune1		portk	gkFTune1,  kporttime	;PORTAMENTO APPLIED
	kFTune2		portk	gkFTune2,  kporttime	;PORTAMENTO APPLIED
	kGain		portk	gkGain,  kporttime	;PORTAMENTO APPLIED
	
	kMltplier1	=	cpsoct(8+(kFTune1*.001*(5/6)))/cpsoct(8)
	kMltplier2	=	cpsoct(8+(kFTune2*.001*(5/6)))/cpsoct(8)
	
	kpeakdeviation1	=	kbasefreq * kindex1	;CALCUALATE THE PEAK DEVIATION OF THE MODULATOR FROM THE VALUES GIVEN FOR BASE FREQUENCY AND THE INDEX OF MODULATION
	kpeakdeviation2	=	kbasefreq * kindex2	;CALCUALATE THE PEAK DEVIATION OF THE MODULATOR FROM THE VALUES GIVEN FOR BASE FREQUENCY AND THE INDEX OF MODULATION

	aAntiClick	linsegr	0,0.001,1,0.01,0	;ANTI CLICK ENVELOPE
	
	;OUTPUT		OPCODE	AMPLITUDE            |     FREQUENCY                         		      | FUNCTION_TABLE
	aModulator1	oscili	kpeakdeviation1,      kbasefreq * gkMod1Ratio * kMltplier1,                         gisine		;DEFINE THE MODULATOR WAVEFORM
	aCarrier1	oscili	kCar1Amp*aAntiClick,  ((kbasefreq * gkCar1Ratio) + aModulator1) * kMltplier1,       gisine		;DEFINE THE CARRIER WAVEFORM (NOTE HOW ITS FREQUENCY IS MODULATED (THROUGH ADDITION) BY THE AUDIO OUTPUT OF THE MODULATOR WAVEFORM)
	aModulator2	oscili	kpeakdeviation2,      (kbasefreq * gkMod2Ratio) * kMltplier2,                       gisine		;DEFINE THE MODULATOR WAVEFORM
	aCarrier2	oscili	kCar2Amp*aAntiClick,  ((kbasefreq * gkCar2Ratio) + aModulator2) * kMltplier2,       gisine		;DEFINE THE CARRIER WAVEFORM (NOTE HOW ITS FREQUENCY IS MODULATED (THROUGH ADDITION) BY THE AUDIO OUTPUT OF THE MODULATOR WAVEFORM)
	aMix		sum	aCarrier1, aCarrier2
			outs	aMix*.5*kGain, aMix*.5*kGain	;SEND THE AUDIO OUTPUT OF THE CARRIERS TO THE OUTPUTS 
	ktrig	  	metro	10	;CREATE A REPEATING TRIGGER SIGNAL
			FLsetVal 	ktrig, kpeakdeviation1, gihPeakDev1	;UPDATE VALUE BOX 'gihPeakDev' WITH THE VALUE kpeakdeviation WHENEVER A TRIGGER PULSE IS RECEIVED
			FLsetVal 	ktrig, kpeakdeviation2, gihPeakDev2	;UPDATE VALUE BOX 'gihPeakDev' WITH THE VALUE kpeakdeviation WHENEVER A TRIGGER PULSE IS RECEIVED	
endin

instr	3	;PRESETS
	FLsetVal_i	p4, gihbasefreq
	FLsetVal_i	p5, gihindex1
	FLsetVal_i	p6, gihindex2
	FLsetVal_i	p7, gihCar1Ratio
	FLsetVal_i	p8, gihMod1Ratio
	FLsetVal_i	p9, gihCar2Ratio
	FLsetVal_i	p10, gihMod2Ratio
	FLsetVal_i	p11, gihFTune1
	FLsetVal_i	p12, gihFTune2
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