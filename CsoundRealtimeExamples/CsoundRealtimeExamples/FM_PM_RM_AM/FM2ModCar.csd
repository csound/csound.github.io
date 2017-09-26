;Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
-odevaudio -M0 -+rtmidi=virtual -b400
</CsOptions>

<CsInstruments>

sr	=	44100
kr	=	100
nchnls	=	2

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL                             | WIDTH | HEIGHT | X | Y
	FLpanel	"FM Synthesis: 2 Modulators -> 1 Carrier",   500,    450,    0,  0

;SWITCHES  	                                  	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off(MIDI)",	1,    0,    22,    150,     25,    5,  5,    0,      2,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES					WIDTH | HEIGHT | X |  Y
idbasefreq			FLvalue	" ",     	60,       20,    5,   75
idindex1			FLvalue	" ",     	60,       20,    5,  125
idindex2			FLvalue	" ",     	60,       20,    5,  175
idCarAmp			FLvalue	" ",     	60,       20,    5,  325

;					            							MIN  |   MAX | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X | Y
gkbasefreq, gihbasefreq		FLslider 	"Base Frequency",		 			20,    20000,  -1,    23,  idbasefreq,    490,     25,    5,  50
gkindex1, gihindex1		FLslider 	"Modulation Index 1",					0,        50,   0,    23,  idindex1,      390,     25,    5, 100
gkindex2, gihindex2		FLslider 	"Modulation Index 2",					0,        50,   0,    23,  idindex2,      390,     25,    5, 150
gkCarAmp, gihCarAmp		FLslider 	"Carrier Amplitude",					0,     30000,   0,    23,  idCarAmp,      490,     25,    5, 300

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	6,        9,    15,    370,    70,    30, 210

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	3,        9,    15,    480,    70,    10, 360
;                                               ON | OFF | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE | INS | STARTTIM | IDUR | p4(BASE FREQ) | p5(INDEX 1) | p6(INDEX 2 | p7(CAR_1_RATIO) | p8(MOD_1_RATIO) | p9(MOD_2_RATIO)
gkPreset,ih		FLbutton	"1",	1,    0,    21,     30,     25,    90, 382,    0,     3,      0,      0,          50,          10.5,         3.5,              1,             1.005,              .995                                                  
gkPreset,ih		FLbutton	"2",	1,    0,    21,     30,     25,   140, 382,    0,     3,      0,      0,          30,             9,          10,             18,                20,                19                                                  
gkPreset,ih		FLbutton	"3",	1,    0,    21,     30,     25,   190, 382,    0,     3,      0,      0,          42,          11.7,        11.7,              8,            1.9991,            2.0009      
gkPreset,ih		FLbutton	"4",	1,    0,    21,     30,     25,   240, 382,    0,     3,      0,      0,         312,           1.8,         3.5,              1,             1.305,               1.3      
gkPreset,ih		FLbutton	"5",	1,    0,    21,     30,     25,   290, 382,    0,     3,      0,      0,         278,           2.1,         2.2,              5,                20,               0.5                                                  
gkPreset,ih		FLbutton	"6",	1,    0,    21,     30,     25,   340, 382,    0,     3,      0,      0,         260,             4,           2,             .5,                20,                 5                                                  
gkPreset,ih		FLbutton	"7",	1,    0,    21,     30,     25,   390, 382,    0,     3,      0,      0,         103,             3,           5,             18,                20,                 5                                                  
gkPreset,ih		FLbutton	"8",	1,    0,    21,     30,     25,   440, 382,    0,     3,      0,      0,          70,           2.3,         2.3,              8,              1.01,           2.99                                                  
;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Presets:", 		1,     11,     16,    70,    15,     15,  385

;						 			MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkCarRatio, gihCarRatio		FLtext		" ", 			.125,  20,  .0001,  1,     60,     20,   140, 220
gkMod1Ratio, gihMod1Ratio	FLtext		" ", 			.125,  20,  .0001,  1,     60,     20,   220, 220
gkMod2Ratio, gihMod2Ratio	FLtext		" ", 			.125,  20,  .0001,  1,     60,     20,   300, 220
gkPeakDev1, gihPeakDev1		FLtext		"P. Dev. 1", 		0,  10000,     0,   1,     80,     20,   410, 115 ;DISPLAY ONLY!
gkPeakDev2, gihPeakDev2		FLtext		"P. Dev. 2", 		0,  10000,     0,   1,     80,     20,   410, 165 ;DISPLAY ONLY!

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Freq. Ratios:",	1,      5,     12,   100,    15,     40,  222
ih		 	FLbox  	":", 			1,      5,     14,     5,    15,    208,  222
ih		 	FLbox  	":", 			1,      5,     14,     5,    15,    288,  222
ih		 	FLbox  	"Carrier Frequency", 	1,      5,     12,    90,    15,    125,  250
ih		 	FLbox  	"Mod. 1 Frequency", 	1,      5,     12,    90,    15,    205,  250
ih		 	FLbox  	"Mod. 2 Frequency", 	1,      5,     12,    90,    15,    285,  250

			FLsetVal_i	100, 	gihbasefreq
			FLsetVal_i	3, 	gihindex1
			FLsetVal_i	3, 	gihindex2
			FLsetVal_i	1, 	gihCarRatio
			FLsetVal_i	1, 	gihMod1Ratio
			FLsetVal_i	1, 	gihMod2Ratio
			FLsetVal_i	5000, 	gihCarAmp

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 560, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"           FM Synthesis: 2 Modulators->1 Carrier             ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"                    +-----+     +-----+                      ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"                    |MOD 1|     |MOD 2|                      ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"                    +--+--+     +--+--+                      ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"                       |           |                         ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"                       +-----+-----+                         ", 	1,      5,     14,    490,    15,     5, 120
ih	  	 	FLbox  	"                             |                               ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"                          +--+--+                            ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"                          |CAR. |                            ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"                          +--+--+                            ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"                             |                               ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"                             V                               ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"                            OUT                              ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"This examples implements an FM synthesis algorithm than      ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"employs three oscillators as shown in the above algorithm:   ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"The frequency input of a carrier oscillator is modulated by  ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"the audio outputs of two independent modulator oscillators.  ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"The frequencies of all three oscillators can be changed using", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"the 'Base Frequency' control. Their frequencies can be       ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"changed independently using the 'Freq. Ratios' number boxes  ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"These values rescale the actual frequencies of the           ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"oscillators in relation to the base frequency. A ratio value ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"of '2' along with a base frequency of 200Hz will result in an", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"actual frequency of 400Hz for that oscillator.               ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"Peak deviation readouts for Mod. 1 and Car. and for Mod. 2   ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"and Car are provided for information purposes only.          ", 	1,      5,     14,    490,    15,     5, 540

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
	
	
	kpeakdeviation1	=	kbasefreq * kindex1	;CALCUALATE THE PEAK DEVIATION OF THE MODULATOR FROM THE VALUES GIVEN FOR BASE FREQUENCY AND THE INDEX OF MODULATION
	kpeakdeviation2	=	kbasefreq * kindex2	;CALCUALATE THE PEAK DEVIATION OF THE MODULATOR FROM THE VALUES GIVEN FOR BASE FREQUENCY AND THE INDEX OF MODULATION
	
	aAntiClick	linsegr	0,0.001,1,0.01,0	;ANTI CLICK ENVELOPE

	;OUTPUT		OPCODE	AMPLITUDE         |     FREQUENCY                         		| FUNCTION_TABLE
	aModulator1	oscili	kpeakdeviation1,   kbasefreq * gkMod1Ratio,                     	      gisine		;DEFINE THE MODULATOR WAVEFORM
	aModulator2	oscili	kpeakdeviation2,   kbasefreq * gkMod2Ratio,                     	      gisine		;DEFINE THE MODULATOR WAVEFORM
	aCarrier	oscili	kCarAmp*aAntiClick,(kbasefreq * gkCarRatio) + aModulator1 + aModulator2,      gisine		;DEFINE THE CARRIER WAVEFORM (NOTE HOW ITS FREQUENCY IS MODULATED (THROUGH ADDITION) BY THE AUDIO OUTPUT OF THE MODULATOR WAVEFORM)
			outs	aCarrier, aCarrier	;SEND THE AUDIO OUTPUT OF THE CARRIER WAVEFORM *ONLY* TO THE OUTPUTS 
	ktrig	  	metro	10	;CREATE A REPEATING TRIGGER SIGNAL
			FLsetVal 	ktrig, kpeakdeviation1, gihPeakDev1	;UPDATE VALUE BOX 'gihPeakDev' WITH THE VALUE kpeakdeviation WHENEVER A TRIGGER PULSE IS RECEIVED
			FLsetVal 	ktrig, kpeakdeviation2, gihPeakDev2	;UPDATE VALUE BOX 'gihPeakDev' WITH THE VALUE kpeakdeviation WHENEVER A TRIGGER PULSE IS RECEIVED
endin

instr	3	;PRESETS
	FLsetVal_i	p4, gihbasefreq
	FLsetVal_i	p5, gihindex1
	FLsetVal_i	p6, gihindex2
	FLsetVal_i	p7, gihCarRatio
	FLsetVal_i	p8, gihMod1Ratio
	FLsetVal_i	p9, gihMod2Ratio
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT - KEEPS REALTIME PERFORMANCE GOING FOR ONE HOUR
</CsScore>

</CsoundSynthesizer>