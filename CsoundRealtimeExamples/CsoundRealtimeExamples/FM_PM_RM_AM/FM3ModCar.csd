FM3ModCar.csd
Written by Iain McCurdy, 2008

<CsoundSynthesizer>

<CsOptions>
-odac -M0 -+rtmidi=virtual -dm0
</CsOptions>

<CsInstruments>

sr	=	44100
ksmps	=	128
nchnls	=	2

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL                             | WIDTH | HEIGHT | X | Y
	FLpanel	"FM Synthesis: 3 Modulators -> 1 Carrier",   500,    500,    0,  0

;                                               ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"On/Off(MIDI)",	1,    0,    22,    150,     25,    5,  5,    0,      2,      0,      -1
gkExit,ihExit	FLbutton	"Exit",		1,    0,    21,    140,     25,  355,  5,    0,    999,      0,       0.001
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES					WIDTH | HEIGHT | X |  Y
idbasefreq			FLvalue	" ",     	60,       20,    5,   75
idindex1			FLvalue	" ",     	60,       20,    5,  125
idindex2			FLvalue	" ",     	60,       20,    5,  175
idindex3			FLvalue	" ",     	60,       20,    5,  225
idCarAmp			FLvalue	" ",     	60,       20,    5,  375

;					            							MIN  |   MAX | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X | Y
gkbasefreq, gihbasefreq		FLslider 	"Base Frequency",		 			20,    20000,  -1,    23,  idbasefreq,    490,    25,     5, 50
gkindex1, gihindex1		FLslider 	"Modulation Index 1",					0,        50,   0,    23,  idindex1,      295,    25,     5, 100
gkindex2, gihindex2		FLslider 	"Modulation Index 2",					0,        50,   0,    23,  idindex2,      295,    25,     5, 150
gkindex3, gihindex3		FLslider 	"Modulation Index 3",					0,        50,   0,    23,  idindex3,      295,    25,     5, 200
gkCarAmp, gihCarAmp		FLslider 	"Carrier Amplitude",					0,     30000,   0,    23,  idCarAmp,      490,    25,     5, 350

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	6,        9,    15,    400,    70,    50, 260

;						 			MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkCarRatio, gihCarRatio		FLtext		" ", 			.125,  20,  .0001,  1,     60,     20,    95, 270
gkMod1Ratio, gihMod1Ratio	FLtext		" ", 			.125,  20,  .0001,  1,     60,     20,   175, 270
gkMod2Ratio, gihMod2Ratio	FLtext		" ", 			.125,  20,  .0001,  1,     60,     20,   255, 270
gkMod3Ratio, gihMod3Ratio	FLtext		" ", 			.125,  20,  .0001,  1,     60,     20,   335, 270
gkPeakDev1, gihPeakDev1		FLtext		"P. Dev. 1", 		0,  10000,     0,   1,     80,     20,   410, 115 ;DISPLAY ONLY!
gkPeakDev2, gihPeakDev2		FLtext		"P. Dev. 2", 		0,  10000,     0,   1,     80,     20,   410, 165 ;DISPLAY ONLY!
gkPeakDev3, gihPeakDev3		FLtext		"P. Dev. 3", 		0,  10000,     0,   1,     80,     20,   410, 215 ;DISPLAY ONLY!

;TEXT BOXES										TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	":", 							1,      5,     14,     5,    15,    163,  272
ih		 	FLbox  	":", 							1,      5,     14,     5,    15,    243,  272
ih		 	FLbox  	":", 							1,      5,     14,     5,    15,    323,  272
ih		 	FLbox  	"Carrier Frequency", 					1,      5,     12,    90,    15,     80,  300
ih		 	FLbox  	"Mod. 1 Frequency", 					1,      5,     12,    90,    15,    160,  300
ih		 	FLbox  	"Mod. 2 Frequency", 					1,      5,     12,    90,    15,    240,  300
ih		 	FLbox  	"Mod. 3 Frequency", 					1,      5,     12,    90,    15,    320,  300

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	3,        9,    15,    480,    70,    10, 410
;                                               ON | OFF | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE | INS | STARTTIM | IDUR | p4(BASE FREQ) | p5(INDEX 1) | p6(INDEX 2) | p7(INDEX 3) | p8(CAR_1_RATIO) | p9(MOD_1_RATIO) | p10(MOD_2_RATIO)| p11(MOD_2_RATIO)
gkPreset,ih		FLbutton	"1",	1,    0,    21,     30,     25,    90, 432,    0,     3,      0,      0,          50,          10.5,         3.5,         5.78,                1,             1.005,              .995,             1.0323 
gkPreset,ih		FLbutton	"2",	1,    0,    21,     30,     25,   140, 432,    0,     3,      0,      0,          30,             9,          10,            8,               18,                20,                19,            17                                                  
gkPreset,ih		FLbutton	"3",	1,    0,    21,     30,     25,   190, 432,    0,     3,      0,      0,          42,          11.7,        11.7,          2.2,                8,            1.9991,            2.0009,          .493      
gkPreset,ih		FLbutton	"4",	1,    0,    21,     30,     25,   240, 432,    0,     3,      0,      0,         161,           1.8,         3.5,          2.1,                1,             1.302,               1.3,        2.7125      
gkPreset,ih		FLbutton	"5",	1,    0,    21,     30,     25,   290, 432,    0,     3,      0,      0,         135,           2.1,         2.2,          3.9,                5,                20,               0.5,            13                                                  
gkPreset,ih		FLbutton	"6",	1,    0,    21,     30,     25,   340, 432,    0,     3,      0,      0,         260,             4,           2,            1,               .5,                20,                 5,             1                                                  
gkPreset,ih		FLbutton	"7",	1,    0,    21,     30,     25,   390, 432,    0,     3,      0,      0,         103,             3,           5,            8,               18,                20,                 5,        6.0001
gkPreset,ih		FLbutton	"8",	1,    0,    21,     30,     25,   440, 432,    0,     3,      0,      0,          70,           2.3,         2.3,            8,                8,              1.01,              2.99,             1                                                  
;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Presets:", 		1,     11,     16,    70,    15,     15,  435

			FLsetVal_i	100, 	gihbasefreq
			FLsetVal_i	3, 	gihindex1
			FLsetVal_i	3, 	gihindex2
			FLsetVal_i	3, 	gihindex3
			FLsetVal_i	1, 	gihCarRatio
			FLsetVal_i	1, 	gihMod1Ratio
			FLsetVal_i	1, 	gihMod2Ratio
			FLsetVal_i	1, 	gihMod3Ratio
			FLsetVal_i	5000, 	gihCarAmp

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 360, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"          FM Synthesis: 3 Modulators -> 1 Carrier            ", 	1,      5,     14,    490,     20,    5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,     20,    5,  20
ih		 	FLbox  	"             +-----+      +-----+     +-----+                ", 	1,      5,     14,    490,     20,    5,  40
ih		 	FLbox  	"             |MOD.1|      |MOD.2|     |MOD.3|                ", 	1,      5,     14,    490,     20,    5,  60
ih		 	FLbox  	"             +--+--+      +--+--+     +--+--+                ", 	1,      5,     14,    490,     20,    5,  80
ih		 	FLbox  	"                |            |           |                   ", 	1,      5,     14,    490,     20,    5, 100
ih		 	FLbox  	"                +------------+-----------+                   ", 	1,      5,     14,    490,     20,    5, 120
ih	  	 	FLbox  	"                             |                               ", 	1,      5,     14,    490,     20,    5, 140
ih		 	FLbox  	"                          +--+--+                            ", 	1,      5,     14,    490,     20,    5, 160
ih		 	FLbox  	"                          |CAR. |                            ", 	1,      5,     14,    490,     20,    5, 180
ih		 	FLbox  	"                          +--+--+                            ", 	1,      5,     14,    490,     20,    5, 200
ih		 	FLbox  	"                             |                               ", 	1,      5,     14,    490,     20,    5, 220
ih		 	FLbox  	"                             V                               ", 	1,      5,     14,    490,     20,    5, 240
ih		 	FLbox  	"                            OUT                              ", 	1,      5,     14,    490,     20,    5, 260
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,     20,    5, 280
ih		 	FLbox  	"This four oscillator algorithm has the frequency of a        ", 	1,      5,     14,    490,     20,    5, 300
ih		 	FLbox  	"carrier oscillator modulated by the combined audio outputs of", 	1,      5,     14,    490,     20,    5, 320
ih		 	FLbox  	"three parallel modulator oscillators.                        ", 	1,      5,     14,    490,     20,    5, 340

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

instr	2	;FM INSTRUMENT
	kactive1	active	1	;SENSE NUMBER OF ACTIVE INSTANCES OF INSTRUMENT 1 (I.E. MIDI ACTIVATED INSTRUMENT) 
	if	gkOnOff=0&&kactive1=0	then	;IF FLTK/MIDI SWITCH IS SET TO 'MIDI' AND NO MIDI NOTES ARE ACTIVE...
		turnoff					;TURN THIS INSTRUMENT
	endif						;END OF CONDITIONAL BRANCHING
	if	gkOnOff = 1	then			;IF FLTK/MIDI SWITCH IS SET TO 'FLTK'...
		kCarAmp = gkCarAmp			;SET kamp TO FLTK SLIDER VALUE gkamp
		kbasefreq = gkbasefreq			;
		kindex1 = gkindex1			;
		kindex2 = gkindex2			;
	else						;OTHERWISE...
		kbasefreq = p4				;SET FUNDEMENTAL TO RECEIVED p4 RECEIVED FROM INSTR 1. I.E. MIDI PITCH
		kCarAmp = p5 * gkCarAmp			;SET AMPLITUDE TO RECEIVED p5 RECEIVED FROM INSTR 1 (I.E. MIDI VELOCITY) MULTIPLIED BY FLTK SLIDER gkamp.
		kindex1 = p5 * gkindex1			;
		kindex2 = p5 * gkindex2			;
	endif						;END OF CONDITIONAL BRANCHING
	
	iporttime	=	.02					;PORTAMENTO TIME (TO BE APPLIED TO K-RATE VARIABLES IN ORDER TO IMPLEMENT DAMPING)
	kporttime	linseg	0, .001, iporttime, 1, iporttime	;FINAL VARIABLE WILL RAMP UP
	
	kbasefreq	portk	kbasefreq, kporttime	;PORTAMENTO APPLIED
	kindex1		portk	gkindex1, kporttime	;PORTAMENTO APPLIED
	kindex2		portk	gkindex2, kporttime	;PORTAMENTO APPLIED
	kindex3		portk	gkindex3, kporttime	;PORTAMENTO APPLIED
	kCarAmp		portk	kCarAmp, kporttime	;PORTAMENTO APPLIED
	
	
	kpeakdeviation1	=	kbasefreq * kindex1	;CALCUALATE THE PEAK DEVIATION OF THE MODULATOR FROM THE VALUES GIVEN FOR BASE FREQUENCY AND THE INDEX OF MODULATION
	kpeakdeviation2	=	kbasefreq * kindex2	;CALCUALATE THE PEAK DEVIATION OF THE MODULATOR FROM THE VALUES GIVEN FOR BASE FREQUENCY AND THE INDEX OF MODULATION
	kpeakdeviation3	=	kbasefreq * kindex3	;CALCUALATE THE PEAK DEVIATION OF THE MODULATOR FROM THE VALUES GIVEN FOR BASE FREQUENCY AND THE INDEX OF MODULATION

	aAntiClick	linsegr	0,0.001,1,0.01,0	;ANTI CLICK ENVELOPE

	;OUTPUT		OPCODE	AMPLITUDE         |     FREQUENCY                         		             | FUNCTION_TABLE
	aModulator1	oscili	kpeakdeviation1,   kbasefreq * gkMod1Ratio,                     	                  gisine		;DEFINE THE MODULATOR WAVEFORM
	aModulator2	oscili	kpeakdeviation2,   kbasefreq * gkMod2Ratio,                     	                  gisine		;DEFINE THE MODULATOR WAVEFORM
	aModulator3	oscili	kpeakdeviation3,   kbasefreq * gkMod3Ratio,                     	                  gisine		;DEFINE THE MODULATOR WAVEFORM
	aCarrier	oscili	kCarAmp*aAntiClick,(kbasefreq * gkCarRatio) + aModulator1 + aModulator2 + aModulator3,    gisine		;DEFINE THE CARRIER WAVEFORM (NOTE HOW ITS FREQUENCY IS MODULATED (THROUGH ADDITION) BY THE AUDIO OUTPUT OF THE MODULATOR WAVEFORM)
			outs	aCarrier, aCarrier	;SEND THE AUDIO OUTPUT OF THE CARRIER WAVEFORM *ONLY* TO THE OUTPUTS 
	ktrig	  	metro	10	;CREATE A REPEATING TRIGGER SIGNAL
			FLsetVal 	ktrig, kpeakdeviation1, gihPeakDev1	;UPDATE VALUE BOX 'gihPeakDev' WITH THE VALUE kpeakdeviation WHENEVER A TRIGGER PULSE IS RECEIVED
			FLsetVal 	ktrig, kpeakdeviation2, gihPeakDev2	;UPDATE VALUE BOX 'gihPeakDev' WITH THE VALUE kpeakdeviation WHENEVER A TRIGGER PULSE IS RECEIVED
			FLsetVal 	ktrig, kpeakdeviation3, gihPeakDev3	;UPDATE VALUE BOX 'gihPeakDev' WITH THE VALUE kpeakdeviation WHENEVER A TRIGGER PULSE IS RECEIVED	
endin

instr	3	;PRESETS
	FLsetVal_i	p4, gihbasefreq
	FLsetVal_i	p5, gihindex1
	FLsetVal_i	p6, gihindex2
	FLsetVal_i	p7, gihindex3
	FLsetVal_i	p8, gihCarRatio
	FLsetVal_i	p9, gihMod1Ratio
	FLsetVal_i	p10, gihMod2Ratio
	FLsetVal_i	p11, gihMod3Ratio
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