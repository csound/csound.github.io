FM3ModModCarEnvelopes.csd
Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
-odac -M0 -dm0 -+rtmidi=virtual
</CsOptions>


<CsInstruments>

sr	=	44100
ksmps	=	8
nchnls	=	2

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL                                 | WIDTH | HEIGHT | X | Y
	FLpanel	"FM Synthesis: Modulator->Modulator->Carrier",   500,    560,    0,  0

;SWITCHES  	                                  	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off(MIDI)",	1,    0,    22,    150,     25,    5,  5,    0,      2,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES					WIDTH | HEIGHT | X |  Y
idbasefreq			FLvalue	" ",     	60,       20,    5,   75
;idindex1			FLvalue	" ",     	60,       20,    5,  125
idindex2			FLvalue	" ",     	60,       20,    5,  175
idCarAmp			FLvalue	" ",     	60,       20,    5,  325

;SLIDERS				            				MIN  |   MAX | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X | Y
gkbasefreq, gihbasefreq		FLslider 	"Base Frequency",		20,    20000,  -1,    23,   idbasefreq,   490,     25,    5,  50
gkindex1, gihindex1S		FLslider 	"Modulation Index 1",		0,       100,   0,    23,      -1,        390,     25,    5, 100
gkindex2, gihindex2		FLslider 	"Modulation Index 2",		0,       100,   0,    23,   idindex2,     390,     25,    5, 150
gkCarAmp, gihCarAmp		FLslider 	"Carrier Amplitude",		0,     30000,   0,    23,   idCarAmp,     490,     25,    5, 300

;						 	MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkindex1, gihindex1T		FLtext		" ", 	0,     60, .0001,    1,    60,     20,     5, 125
FLsetColor	200, 200, 255, gihindex1T		;SET SECONDARY COLOUR TO RED

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	6,        9,    15,    300,    70,   100, 210

;						 			MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkCarRatio, gihCarRatio		FLtext		" ", 			.125,  20,  .0001,  1,     60,     20,   140, 220
gkMod1Ratio, gihMod1Ratio	FLtext		" ", 			.125,  20,  .0001,  1,     60,     20,   220, 220
gkMod2Ratio, gihMod2Ratio	FLtext		" ", 			.125,  20,  .0001,  1,     60,     20,   300, 220
gkPeakDev1, gihPeakDev1		FLtext		"P. Dev. 1", 		0,  10000,     0,   1,     80,     20,   410, 115 ;DISPLAY ONLY!
gkPeakDev2, gihPeakDev2		FLtext		"P. Dev. 2", 		0,  10000,     0,   1,     80,     20,   410, 165 ;DISPLAY ONLY!

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	3,        9,    15,    220,    70,    10, 370	;INDEX 1 ENVELOPE
;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Index 1 Envelope",	1,      1,     13,   200,    15,     20, 375
;TEXT INPUT				 			MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkNdxAtt, gihNdxAtt		FLtext		"Att.",		.0001,  2,  .0001,  1,     50,     20,    20, 400
gkNdxDec, gihNdxDec		FLtext		"Dec.",		.0001,  2,  .0001,  1,     50,     20,    70, 400
gkNdxSL, gihNdxSL		FLtext		"Sus.",		0,      1,  .0001,  1,     50,     20,   120, 400
gkNdxRel, gihNdxRel		FLtext		"Rel.",		.0001,  2,  .0001,  1,     50,     20,   170, 400

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	3,        9,    15,    220,    70,   260, 370	;INDEX 2 ENVELOPE
;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Index 2 Envelope",	1,      1,     13,   200,    15,     270, 375
;TEXT INPUT				 			MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkAmpAtt, gihAmpAtt		FLtext		"Att.",		.0001,  2,  .0001,  1,     50,     20,   270, 400
gkAmpDec, gihAmpDec		FLtext		"Dec.",		.0001,  2,  .0001,  1,     50,     20,   320, 400
gkAmpSL,  gihAmpSL		FLtext		"Sus.",		0,      1,  .0001,  1,     50,     20,   370, 400
gkAmpRel, gihAmpRel		FLtext		"Rel.",		.0001,  2,  .0001,  1,     50,     20,   420, 400

FLsetVal_i	.003, 	gihNdxAtt
FLsetVal_i	1, 	gihNdxDec
FLsetVal_i	0, 	gihNdxSL
FLsetVal_i	.1, 	gihNdxRel
FLsetVal_i	.003, 	gihAmpAtt
FLsetVal_i	1, 	gihAmpDec
FLsetVal_i	0, 	gihAmpSL
FLsetVal_i	.1, 	gihAmpRel

;TEXT BOXES										TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	":", 							1,      5,     14,     5,    15,    208,  222
ih		 	FLbox  	":", 							1,      5,     14,     5,    15,    288,  222
ih		 	FLbox  	"Carrier Frequency", 					1,      5,     12,    90,    15,    115,  250
ih		 	FLbox  	"Mod. 1 Frequency", 					1,      5,     12,    90,    15,    205,  250
ih		 	FLbox  	"Mod. 2 Frequency", 					1,      5,     12,    90,    15,    285,  250

			FLsetVal_i	100, 	gihbasefreq
			FLsetVal_i	3, 	gihindex1S
			FLsetVal_i	3, 	gihindex1T
			FLsetVal_i	3, 	gihindex2
			FLsetVal_i	1, 	gihCarRatio
			FLsetVal_i	1, 	gihMod1Ratio
			FLsetVal_i	1, 	gihMod2Ratio
			FLsetVal_i	5000, 	gihCarAmp

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	3,        9,    15,    480,    70,    10, 460
;                                               ON | OFF | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE | INS | STARTTIM | IDUR | p4(BASE FREQ) | p5(INDEX 1) | p6(INDEX 2) | p7(CAR_RATIO) | p8(MOD_1_RATIO) | p9(MOD_2_RATIO) | p10(NDX_ATT) | p11(NDX_DEC) | p12(NDX_SL) | p13(NDX_REL) | p14(AMP_ATT) | p15(AMP_DEC) | p16(AMP_SL) | p17(AMP_REL)
gkPreset,ih		FLbutton	"1",	1,    0,   21,      30,     25,    90, 482,    0,     3,      0,      0,         100,             3,           3,              1,                 1,               1,            0.003,          1,            0,            0.1,             0.003,        1,            0,           0.1
gkPreset,ih		FLbutton	"2",	1,    0,   21,      30,     25,   140, 482,    0,     3,      0,      0,         122,            18,      4.6753,              1,            8.9852,          1.0036,            0.003,         10,            0,            0.1,             0.003,       10,            0,           0.1
gkPreset,ih		FLbutton	"3",	1,    0,   21,      30,     25,   190, 482,    0,     3,      0,      0,          70,         0.007,      17.143,              1,            0.9992,               1,                4,          4,            0,            0.1,                 6,        3,            0,           0.1
gkPreset,ih		FLbutton	"4",	1,    0,   21,      30,     25,   240, 482,    0,     3,      0,      0,          74,       74.8052,        74.8,              1,                 1,               2,                2,         15,            0,            0.1,                 3,       20,            0,           0.1
gkPreset,ih		FLbutton	"5",	1,    0,   21,      30,     25,   290, 482,    0,     3,      0,      0,          86,             8,           8,              1,                 4,           1.001,            0.003,        0.1,            0,            0.1,             0.003,        8,            0,           0.1
gkPreset,ih		FLbutton	"6",	1,    0,   21,      30,     25,   340, 482,    0,     3,      0,      0,         271,           1.3,           4,              1,            1.3001,             1.3,            0.003,          1,            0,            0.1,             0.003,        2,            0,           0.1
gkPreset,ih		FLbutton	"7",	1,    0,   21,      30,     25,   390, 482,    0,     3,      0,      0,          69,            31,      3.1169,             15,                14,              13,            0.003,          1,            0,            0.1,             0.003,        3,            0,           0.1
gkPreset,ih		FLbutton	"8",	1,    0,   21,      30,     25,   440, 482,    0,     3,      0,      0,          93,        1.2987,      4.1558,             15,           12.9723,              13,            0.003,          2,            0,            0.1,             0.003,        2,            0,           0.1
;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Presets:", 		1,     11,     16,    70,    15,     15, 485

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 700, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"        FM Synthesis: Modulator->Modulator->Carrier          ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"                          +-----+                            ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"                          |MOD.1|                            ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"                          +--+--+                            ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"                             |                               ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"                          +--+--+                            ", 	1,      5,     14,    490,    15,     5, 120
ih	  	 	FLbox  	"                          |MOD.2|                            ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"                          +--+--+                            ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"                             |                               ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"                          +--+--+                            ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"                          |CAR. |                            ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"                          +--+--+                            ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"                             |                               ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"                             V                               ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"                            OUT                              ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"This three oscillator algorithm has the audio output of a    ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"modulator modulating the frequency of a second modulator,    ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"the audio output of which modulates the frequency of a       ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"carrier.                                                     ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"The modulation index control for modulator 2, as well as     ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"controlling the amount of influence modulator 2 has on the   ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"carrier, inevitably also governs the influence modulator 1   ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"has on the carrier.                                          ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"This type of arrangement is capable of generating extremely  ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"complex and sometimes chaotic spectra therefore care and     ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"subtlety are probably needed.                                ", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"Note that 'Modulation Index 1' is also controllable from the ", 	1,      5,     14,    490,    15,     5, 560
ih		 	FLbox  	"number box beneath the slider. This is included to permit    ", 	1,      5,     14,    490,    15,     5, 580
ih		 	FLbox  	"fine and precise control of this parameter.                  ", 	1,      5,     14,    490,    15,     5, 600
ih		 	FLbox  	"Some of the presets in this example demonstrate the more     ", 	1,      5,     14,    490,    15,     5, 620
ih		 	FLbox  	"extreme and strident spectra possible with this FM algorithm.", 	1,      5,     14,    490,    15,     5, 640
ih		 	FLbox  	"When the 'On/Off' switch is off the instrument can be played ", 	1,      5,     14,    490,    15,     5, 660
ih		 	FLbox  	"from MIDI.                                                   ", 	1,      5,     14,    490,    15,     5, 680

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

instr	2		;FM INSTRUMENT
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
	kindex1		portk	kindex1, kporttime	;PORTAMENTO APPLIED
	kindex2		portk	kindex2, kporttime	;PORTAMENTO APPLIED
	kCarAmp		portk	kCarAmp, kporttime	;PORTAMENTO APPLIED
	
	kNdxEnv 	madsr 	i(gkNdxAtt), i(gkNdxDec), i(gkNdxSL), i(gkNdxRel)		;LINE SEGMENT ENVELOPE WITH MIDI RELEASE MECHANISM
	kAmpEnv 	madsr 	i(gkAmpAtt), i(gkAmpDec), i(gkAmpSL), i(gkAmpRel)		;LINE SEGMENT ENVELOPE WITH MIDI RELEASE MECHANISM
	
	kpeakdeviation1	=	kbasefreq * kindex1 * kNdxEnv	;CALCUALATE THE PEAK DEVIATION OF THE MODULATOR FROM THE VALUES GIVEN FOR BASE FREQUENCY AND THE INDEX OF MODULATION
	kpeakdeviation2	=	kbasefreq * kindex2 * kNdxEnv	;CALCUALATE THE PEAK DEVIATION OF THE MODULATOR FROM THE VALUES GIVEN FOR BASE FREQUENCY AND THE INDEX OF MODULATION
	
	;OUTPUT		OPCODE	AMPLITUDE         |     FREQUENCY                         		| FUNCTION_TABLE
	aModulator1	oscili	kpeakdeviation1,   kbasefreq * gkMod1Ratio,                     	      gisine		;DEFINE THE MODULATOR WAVEFORM
	aModulator2	oscili	kpeakdeviation2,  (kbasefreq * gkMod2Ratio) + aModulator1,                    gisine		;DEFINE THE MODULATOR WAVEFORM
	aCarrier	oscili	kCarAmp * kAmpEnv,(kbasefreq * gkCarRatio) + aModulator2,                     gisine		;DEFINE THE CARRIER WAVEFORM (NOTE HOW ITS FREQUENCY IS MODULATED (THROUGH ADDITION) BY THE AUDIO OUTPUT OF THE MODULATOR WAVEFORM)
			outs	aCarrier, aCarrier	;SEND THE AUDIO OUTPUT OF THE CARRIER WAVEFORM *ONLY* TO THE OUTPUTS 
	ktrig	  	metro	10	;CREATE A REPEATING TRIGGER SIGNAL
			FLsetVal 	ktrig, kpeakdeviation1, gihPeakDev1	;UPDATE VALUE BOX 'gihPeakDev' WITH THE VALUE kpeakdeviation WHENEVER A TRIGGER PULSE IS RECEIVED
			FLsetVal 	ktrig, kpeakdeviation2, gihPeakDev2	;UPDATE VALUE BOX 'gihPeakDev' WITH THE VALUE kpeakdeviation WHENEVER A TRIGGER PULSE IS RECEIVED
			FLsetVal 	ktrig, gkindex1, gihindex1S		;UPDATE VALUE BOX 'gihPeakDev' WITH THE VALUE kpeakdeviation WHENEVER A TRIGGER PULSE IS RECEIVED
			FLsetVal 	ktrig, gkindex1, gihindex1T		;UPDATE VALUE BOX 'gihPeakDev' WITH THE VALUE kpeakdeviation WHENEVER A TRIGGER PULSE IS RECEIVED
endin

instr	3	;PRESETS
	FLsetVal_i	p4, gihbasefreq
	FLsetVal_i	p5, gihindex1S
	FLsetVal_i	p5, gihindex1T
	FLsetVal_i	p6, gihindex2
	FLsetVal_i	p7, gihCarRatio
	FLsetVal_i	p8, gihMod1Ratio
	FLsetVal_i	p9, gihMod2Ratio
	FLsetVal_i	p10,gihNdxAtt
	FLsetVal_i	p11,gihNdxDec
	FLsetVal_i	p12,gihNdxSL
	FLsetVal_i	p13,gihNdxRel
	FLsetVal_i	p14,gihAmpAtt
	FLsetVal_i	p15,gihAmpDec
	FLsetVal_i	p16,gihAmpSL
	FLsetVal_i	p17,gihAmpRel
endin

</CsInstruments>


<CsScore>
f 1 0 129 10 1	;A SINE WAVE (INTERPOLATING OSCILLATOR OPCODES ARE USED THEREFORE A SMALL TABLE SIZE (+1) CAN BE USED)
f 0 3600	;DUMMY SCORE EVENT - KEEPS REALTIME PERFORMANCE GOING FOR ONE HOUR
</CsScore>


</CsoundSynthesizer>



























