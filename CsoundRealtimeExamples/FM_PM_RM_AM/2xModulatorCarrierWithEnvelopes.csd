2xModulatorCarrierWithEnvelopes.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
;YOU MAY NEED TO CHANGE THE DEVICE NUMBER AFTER THE MIDI INPUT FLAG (-M)
;-odac -M0 -dm0
-odac -M0 -+rtmidi=virtual -dm0
</CsOptions>

<CsInstruments>

sr	=	44100
ksmps	=	8
nchnls	=	2

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;			LABEL                        | WIDTH | HEIGHT | X | Y
	FLpanel	"Carrier -> Modulator, with envelopes", 500,     550,   0,  0

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	6,        9,    15,    300,    70,   100, 160	;RATIOS

;				FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkFLTK_MIDI, ihFLTK_MIDI	FLbutBank	4,      1,     2,     20,      40,    5,  5,     0,     2,    0, -1
;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"MIDI", 	1,      6,     17,     50,     20,   23,   4
ih		 	FLbox  	"FLTK", 	1,      6,     17,     50,     20,   23,  24

;GENERAL_TEXT_SETTINGS		SIZE | FONT | ALIGN | RED | GREEN | BLUE
		FLlabel		13,     1,      3,     0,     0,      0

;VALUE DISPLAY BOXES					WIDTH | HEIGHT | X |  Y
idbasefreq			FLvalue	" ",     	60,       18,    5,   75
idindex				FLvalue	" ",     	60,       18,    5,  125
idindex2			FLvalue	" ",     	60,       18,  252,  125
idCarAmp			FLvalue	" ",     	60,       18,    5,  275
idndxatt			FLvalue	" ",     	50,       18,    0,  360
idndxdec			FLvalue	" ",     	50,       18,   50,  360
idndxslev			FLvalue	" ",     	50,       18,  100,  360
idndxrel			FLvalue	" ",     	50,       18,  150,  360
idndxdel			FLvalue	" ",     	50,       18,  200,  360
idndxatt2			FLvalue	" ",     	50,       18,    0,  440
idndxdec2			FLvalue	" ",     	50,       18,   50,  440
idndxslev2			FLvalue	" ",     	50,       18,  100,  440
idndxrel2			FLvalue	" ",     	50,       18,  150,  440
idndxdel2			FLvalue	" ",     	50,       18,  200,  440
idampatt			FLvalue	" ",     	50,       18,    0,  520
idampdec			FLvalue	" ",     	50,       18,   50,  520
idampslev			FLvalue	" ",     	50,       18,  100,  520
idamprel			FLvalue	" ",     	50,       18,  150,  520
idampdel			FLvalue	" ",     	50,       18,  200,  520

;SLIDERS				            				MIN  |   MAX | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X | Y
gkbasefreq,gihbasefreq		FLslider 	"Base Frequency",		20,    20000,  -1,   23,   idbasefreq,    490,    25,     5,  50
gkindex,gihindex		FLslider 	"Modulation Index 1",		0,        20,   0,   23,   idindex,       238,    25,     5, 100
gkindex2,gihindex2		FLslider 	"Modulation Index 2",		0,        20,   0,   23,   idindex2,      238,    25,   255, 100
gkCarAmp, ihCarAmp		FLslider 	"Carrier Amplitude",		0,     30000,   0,   23,   idCarAmp,      490,    25,     5, 250

;KNOBS								MIN  | MAX | EXP | TYPE |  DISP    | WIDTH | X  | Y
gkndxatt, gihndxatt		FLknob 		"Attack",	.001,   8,    0,    1,   idndxatt,    40,     5, 302
gkndxdec, gihndxdec		FLknob 		"Decay",	0,     15,    0,    1,   idndxdec,    40,    55, 302
gkndxslev,gihndxslev		FLknob 		"Sustain",	0,      1,    0,    1,   idndxslev,   40,   105, 302
gkndxrel, gihndxrel		FLknob 		"Release",	0,     15,    0,    1,   idndxrel,    40,   155, 302
gkndxdel, gihndxdel		FLknob 		"Delay",	0,      8,    0,    1,   idndxdel,    40,   205, 302
gkndxatt2, gihndxatt2		FLknob 		"Attack",	.001,   8,    0,    1,   idndxatt2,   40,     5, 382
gkndxdec2, gihndxdec2		FLknob 		"Decay",	0,     15,    0,    1,   idndxdec2,   40,    55, 382
gkndxslev2,gihndxslev2		FLknob 		"Sustain",	0,      1,    0,    1,   idndxslev2,  40,   105, 382
gkndxrel2, gihndxrel2		FLknob 		"Release",	0,     15,    0,    1,   idndxrel2,   40,   155, 382
gkndxdel2, gihndxdel2		FLknob 		"Delay",	0,      8,    0,    1,   idndxdel2,   40,   205, 382
gkampatt, gihampatt		FLknob 		"Attack",	.001,   8,    0,    1,   idampatt,    40,     5, 462
gkampdec, gihampdec		FLknob 		"Decay",	0,     15,    0,    1,   idampdec,    40,    55, 462
gkampslev,gihampslev		FLknob 		"Sustain",	0,      1,    0,    1,   idampslev,   40,   105, 462
gkamprel, gihamprel		FLknob 		"Release",	0,     15,    0,    1,   idamprel,    40,   155, 462
gkampdel, gihampdel		FLknob 		"Delay",	0,      8,    0,    1,   idampdel,    40,   205, 462

;VALUE BOXES					 			MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkCarRatio, gihCarRatio		FLtext		" ", 			.125,   8,  .0001,  1,     50,     20,   130, 170
gkModRatio, gihModRatio		FLtext		" ", 			.125,   8,  .0001,  1,     50,     20,   225, 170
gkModRatio2, gihModRatio2	FLtext		" ", 			.125,   8,  .0001,  1,     50,     20,   320, 170

;TEXT BOXES										TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	":", 							1,      5,     14,     5,    15,    200,  172
ih		 	FLbox  	":", 							1,      5,     14,     5,    15,    295,  172
ih		 	FLbox  	"Carrier Frequency", 					1,      5,     12,    80,    15,    115,  200
ih		 	FLbox  	"Modulator 1 Frequency", 				1,      5,     12,    80,    15,    210,  200
ih		 	FLbox  	"Modulator 2 Frequency", 				1,      5,     12,    80,    15,    305,  200
ih		 	FLbox  	"INDEX 1 ENVELOPE  ", 					1,       1,    14,    170,    30,   250, 310
ih		 	FLbox  	"INDEX 2 ENVELOPE  ", 					1,       1,    14,    170,    30,   250, 390
ih		 	FLbox  	"AMPLITUDE ENVELOPE", 					1,       1,    14,    170,    30,   250, 470

;SET INITIAL VALUES			VALUE | HANDLE
			FLsetVal_i	325,	gihbasefreq
			FLsetVal_i	5,	gihindex
			FLsetVal_i	.702,	gihindex2
			FLsetVal_i	1, 	gihCarRatio
			FLsetVal_i	1.377, 	gihModRatio
			FLsetVal_i	1.3853,	gihModRatio2
			FLsetVal_i	20000, 	ihCarAmp
			FLsetVal_i	.002, 	gihndxatt
			FLsetVal_i	3, 	gihndxdec
			FLsetVal_i	0, 	gihndxslev
			FLsetVal_i	.5, 	gihndxrel
			FLsetVal_i	0, 	gihndxdel
			FLsetVal_i	.002, 	gihndxatt2
			FLsetVal_i	3, 	gihndxdec2
			FLsetVal_i	0, 	gihndxslev2
			FLsetVal_i	.5, 	gihndxrel2
			FLsetVal_i	0, 	gihndxdel2
			FLsetVal_i	.002, 	gihampatt
			FLsetVal_i	7, 	gihampdec
			FLsetVal_i	0, 	gihampslev
			FLsetVal_i	.5, 	gihamprel
			FLsetVal_i	0, 	gihampdel

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 700, 512, 0
				FLscroll     515, 700, 0, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"     FM Synthesis: 2 Modulators->Carrier with envelopes      ", 	1,      5,     14,    490,     20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,     20,     5,  20
ih		 	FLbox  	"As we introduce more oscillators into the FM algorithm       ", 	1,      5,     14,    490,     20,     5,  40
ih		 	FLbox  	"(either as modulators or carriers) more complex modulations  ", 	1,      5,     14,    490,     20,     5,  60
ih		 	FLbox  	"are possible. Spectral possibilties also increase although   ", 	1,      5,     14,    490,     20,     5,  80
ih		 	FLbox  	"control of discord in the timbre becomes more of an issue.   ", 	1,      5,     14,    490,     20,     5, 100
ih		 	FLbox  	"A simple algorithm using three oscillators is that of a      ", 	1,      5,     14,    490,     20,     5, 120
ih	  	 	FLbox  	"carrier's frequency being modulated by the audio output of   ", 	1,      5,     14,    490,     20,     5, 140
ih		 	FLbox  	"two modulators simulataneously. (See diagram below.)         ", 	1,      5,     14,    490,     20,     5, 160
ih		 	FLbox  	"If the ratios of the two modulators are offset slightly a    ", 	1,      5,     14,    490,     20,     5, 180
ih		 	FLbox  	"dramatic spectral modulation is heard simular to the effect  ", 	1,      5,     14,    490,     20,     5, 200
ih		 	FLbox  	"of lowpass filter with its cutoff modulated by an LFO.       ", 	1,      5,     14,    490,     20,     5, 220
ih		 	FLbox  	"Another approach is to give the envelope of one of modulators", 	1,      5,     14,    490,     20,     5, 240
ih		 	FLbox  	"a very short percussive nature in order that it reflects     ", 	1,      5,     14,    490,     20,     5, 260
ih		 	FLbox  	"the immediate attack of a sound such as the sound of a mallet", 	1,      5,     14,    490,     20,     5, 280
ih		 	FLbox  	"striking a resonating object the 2nd modulator can be used to", 	1,      5,     14,    490,     20,     5, 300
ih		 	FLbox  	"create the spectrum of the sustain portion or the main body  ", 	1,      5,     14,    490,     20,     5, 320
ih		 	FLbox  	"of the sound.                                                ", 	1,      5,     14,    490,     20,     5, 340
ih		 	FLbox  	"This example is also playable from a MIDI keyboard if 'MIDI' ", 	1,      5,     14,    490,     20,     5, 360
ih		 	FLbox  	"is chosen.                                                   ", 	1,      5,     14,    490,     20,     5, 380
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,     20,     5, 400
ih		 	FLbox  	"       2 MODULATORS AND A CARRIER FM SYNTHESIS ALGORITHM     ", 	1,      5,     14,    490,     20,     5, 420
ih		 	FLbox  	" ----------------------------------------------------------  ", 	1,      5,     14,    490,     20,     5, 440
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,     20,     5, 460
ih		 	FLbox  	"               +-------------+   +-------------+             ", 	1,      5,     14,    490,     20,     5, 480
ih		 	FLbox  	"               |    oscil    |   |    oscil    |             ", 	1,      5,     14,    490,     20,     5, 500
ih		 	FLbox  	"               |(modulator 1)|   |(modulator 2)|             ", 	1,      5,     14,    490,     20,     5, 520
ih		 	FLbox  	"               +-----+-------+   +-----+-------+             ", 	1,      5,     14,    490,     20,     5, 540
ih		 	FLbox  	"                     |                 |                     ", 	1,      5,     14,    490,     20,     5, 560
ih		 	FLbox  	"                     |                 |                     ", 	1,      5,     14,    490,     20,     5, 580
ih		 	FLbox  	"                     +---------+-------+                     ", 	1,      5,     14,    490,     20,     5, 600
ih		 	FLbox  	"                               |                             ", 	1,      5,     14,    490,     20,     5, 620
ih		 	FLbox  	"                               |                             ", 	1,      5,     14,    490,     20,     5, 640
ih		 	FLbox  	"                         +-----+-----+                       ", 	1,      5,     14,    490,     20,     5, 660
ih		 	FLbox  	"                         |   oscil   |                       ", 	1,      5,     14,    490,     20,     5, 680
ih		 	FLbox  	"                         | (carrier) |                       ", 	1,      5,     14,    490,     20,     5, 700
ih		 	FLbox  	"                         +-----+-----+                       ", 	1,      5,     14,    490,     20,     5, 720
ih		 	FLbox  	"                               |                             ", 	1,      5,     14,    490,     20,     5, 740
ih		 	FLbox  	"                               |                             ", 	1,      5,     14,    490,     20,     5, 760
ih		 	FLbox  	"                              OUT                            ", 	1,      5,     14,    490,     20,     5, 780
                                                            
				FLscrollEnd
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


instr	1	;MIDI INPUT INSTRUMENT
	if	gkFLTK_MIDI=1	then	;IF FLTK/MIDI SWITCH IS SET TO 'FLTK'...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	icps	cpsmidi			;READ CYCLES PER SECOND VALUE FROM MIDI INPUT
	iamp	ampmidi	1		;READ IN A NOTE VELOCITY VALUE FROM THE MIDI INPUT
	;				P1 | P4 | P5
	aoutL, aoutR	subinstr	2,  icps, iamp	;ACTIVATE A SUB-INSTRUMENT
		outs	aoutL, aoutR	;SEND AUDIO TO SPEAKERS
endin

instr 2		;FM INSTRUMENT
	kactive1	active	1	;SENSE NUMBER OF ACTIVE INSTANCES OF INSTRUMENT 1 (I.E. MIDI ACTIVATED INSTRUMENT) 
	if	gkFLTK_MIDI=0&&kactive1=0	then	;IF FLTK/MIDI SWITCH IS SET TO 'MIDI' AND NO MIDI NOTES ARE ACTIVE...
		turnoff					;TURN THIS INSTRUMENT
	endif						;END OF CONDITIONAL BRANCHING
	if	gkFLTK_MIDI = 1	then			;IF FLTK/MIDI SWITCH IS SET TO 'FLTK'...
		kbasefreq	=	gkbasefreq	;SET kbasefreq (BASE FREQUENCY) TO SLIDER VARIABLE gkbasefreq
		kCarAmp		=	gkCarAmp	;SET kCarAmp (CARRIER AMPLITUDE) TO SLIDER VARIABLE gkCarAmp 
	else						;OTHERWISE...
		kbasefreq = p4				;SET FUNDEMENTAL TO RECEIVED p4 RECEIVED FROM INSTR 1. I.E. MIDI PITCH
		kCarAmp = p5 * gkCarAmp			;SET AMPLITUDE TO RECEIVED p5 RECEIVED FROM INSTR 1 (I.E. MIDI VELOCITY) MULTIPLIED BY FLTK SLIDER gkamp.
	endif						;END OF CONDITIONAL BRANCHING
		
	kndxenv 	madsr 	i(gkndxatt), i(gkndxdec), i(gkndxslev) + .0000001, i(gkndxrel) , i(gkndxdel)		;LINE SEGMENT ENVELOPE WITH MIDI RELEASE MECHANISM
	kndxenv2 	madsr 	i(gkndxatt2), i(gkndxdec2), i(gkndxslev2) + .0000001, i(gkndxrel2) , i(gkndxdel2)	;LINE SEGMENT ENVELOPE WITH MIDI RELEASE MECHANISM
	kpeakdeviation	=	kbasefreq * gkindex * kndxenv								;DERIVE PEAK DEVIATION FOR MODULATOR 1 
	kpeakdeviation2	=	kbasefreq * gkindex2 * kndxenv2                                                         ;DERIVE PEAK DEVIATION FOR MODULATOR 1
	aModulator	oscili	kpeakdeviation, kbasefreq * gkModRatio,1						;CREATE MODULATOR 1
	aModulator2	oscili	kpeakdeviation2, kbasefreq * gkModRatio2,1						;CREATE MODULATOR 2
	aampenv 	mxadsr 	i(gkampatt), i(gkampdec), i(gkampslev) + .0000001, i(gkamprel) , i(gkampdel)	;EXPONENTIAL SEGMENT ENVELOPE WITH MIDI RELEASE MECHANISM
	aCarrier	oscili	kCarAmp * aampenv, (kbasefreq * gkCarRatio) + aModulator + aModulator2, 1	;CREATE CARRIER (ADD MODULATOR OUTPUTS TO FREQUENCY INPUT)
		outs	aCarrier, aCarrier	;SEND AUDIO TO OUTPUTS
endin

</CsInstruments>

<CsScore>
f 1 0 129 10 1	;A SINE WAVE
f 0 3600	;DUMMY SCORE EVENT
</CsScore>

</CsoundSynthesizer>