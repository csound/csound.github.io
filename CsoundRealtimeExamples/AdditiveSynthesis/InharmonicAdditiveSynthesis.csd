InharmonicAdditiveSynthesis.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-odac -M0 -+rtmidi=virtual -dm0
;DISABLE VIRTUAL MIDI FOR EXTERNAL MIDI CONTROL
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	16	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE (MAY NEED TO BE LOW WHEN WORKING WITH SHORT DELAY TIMES DEFINED INITIALLY AT KRATE)
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM SOUND INTENSITY LEVEL

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL                           | WIDTH | HEIGHT | X | Y
		FLpanel	"Inharmonic Additive Synthesis",   500,    600,    0,  0

;SWITCHES                                            		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkFLTK_MIDI,ihFLTK_MIDI		FLbutton	"FLTK/MIDI",	1,    0,    22,    120,     25,    5,  5,    0,      1,      0,     3600
FLsetColor2	255, 255, 50, ihFLTK_MIDI	;SET SECONDARY COLOUR TO YELLOW

;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
idfund				FLvalue	" ",     50,     15,     5, 320
idamp				FLvalue	" ",     50,     15,     5, 370

;GENERAL_TEXT_SETTINGS			ISIZE, IFONT, IALIGN, IRED, IGREEN, IBLUE
			FLlabel		10,      1,      3,     0,     0,      0

;SLIDERS					            		MIN | MAX | EXP | TYPE | DISP  | WIDTH | HEIGHT | X  | Y
gkPartAmp1, ihPartAmp1		FLslider 	"1",			0,     1,    0,    24,    -1,      25,    245,   120,  35
gkPartAmp2, ihPartAmp2		FLslider 	"2",			0,     1,    0,    24,    -1,      25,    245,   145,  35
gkPartAmp3, ihPartAmp3		FLslider 	"3",			0,     1,    0,    24,    -1,      25,    245,   170,  35
gkPartAmp4, ihPartAmp4		FLslider 	"4",			0,     1,    0,    24,    -1,      25,    245,   195,  35
gkPartAmp5, ihPartAmp5		FLslider 	"5",			0,     1,    0,    24,    -1,      25,    245,   220,  35
gkPartAmp6, ihPartAmp6		FLslider 	"6",			0,     1,    0,    24,    -1,      25,    245,   245,  35
gkPartAmp7, ihPartAmp7		FLslider 	"7",			0,     1,    0,    24,    -1,      25,    245,   270,  35
gkPartAmp8, ihPartAmp8		FLslider 	"8",			0,     1,    0,    24,    -1,      25,    245,   295,  35
gkPartAmp9, ihPartAmp9		FLslider 	"9",			0,     1,    0,    24,    -1,      25,    245,   320,  35
gkPartAmp10,ihPartAmp10		FLslider 	"10",			0,     1,    0,    24,    -1,      25,    245,   345,  35

;TEXT BOXES              			TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y 
ih		 FLbox  "Partial Strength:", 	1,      9,     12,    90,     10,    25, 281

;SLIDERS					            		MIN | MAX  | EXP | TYPE | DISP  | WIDTH | HEIGHT | X | Y
gkfund, ihfund			FLslider 	"Fundemental (Hertz)",	20,   10000, -1,    23,  idfund,   490,     20,    5, 300
gkamp,  ihamp			FLslider 	"Global Amplitude",	0,        1,  0,    23,  idamp,    490,     20,    5, 350

;VALUE BOXES					 			MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkratio1,  ihratio1		FLtext		"Ratio 1", 		.125,   8,  .0001,  1,     50,     20,     0,  400
gkratio2,  ihratio2		FLtext		"Ratio 2", 		.125,   8,  .0001,  1,     50,     20,    50,  400
gkratio3,  ihratio3		FLtext		"Ratio 3", 		.125,   8,  .0001,  1,     50,     20,   100,  400
gkratio4,  ihratio4		FLtext		"Ratio 4", 		.125,   8,  .0001,  1,     50,     20,   150,  400
gkratio5,  ihratio5		FLtext		"Ratio 5", 		.125,   8,  .0001,  1,     50,     20,   200,  400
gkratio6,  ihratio6		FLtext		"Ratio 6", 		.125,   8,  .0001,  1,     50,     20,   250,  400
gkratio7,  ihratio7		FLtext		"Ratio 7", 		.125,   8,  .0001,  1,     50,     20,   300,  400
gkratio8,  ihratio8		FLtext		"Ratio 8", 		.125,   8,  .0001,  1,     50,     20,   350,  400
gkratio9,  ihratio9		FLtext		"Ratio 9", 		.125,   8,  .0001,  1,     50,     20,   400,  400
gkratio10, ihratio10		FLtext		"Ratio 10", 		.125,   8,  .0001,  1,     50,     20,   450,  400

gkampatt1,  ihampatt1		FLtext		"Attack 1", 		.0001,  8,  .0001,  1,     50,     20,     0,  450
gkampatt2,  ihampatt2		FLtext		"Attack 2", 		.0001,  8,  .0001,  1,     50,     20,    50,  450
gkampatt3,  ihampatt3		FLtext		"Attack 3", 		.0001,  8,  .0001,  1,     50,     20,   100,  450
gkampatt4,  ihampatt4		FLtext		"Attack 4", 		.0001,  8,  .0001,  1,     50,     20,   150,  450
gkampatt5,  ihampatt5		FLtext		"Attack 5", 		.0001,  8,  .0001,  1,     50,     20,   200,  450
gkampatt6,  ihampatt6		FLtext		"Attack 6", 		.0001,  8,  .0001,  1,     50,     20,   250,  450
gkampatt7,  ihampatt7		FLtext		"Attack 7", 		.0001,  8,  .0001,  1,     50,     20,   300,  450
gkampatt8,  ihampatt8		FLtext		"Attack 8", 		.0001,  8,  .0001,  1,     50,     20,   350,  450
gkampatt9,  ihampatt9		FLtext		"Attack 9", 		.0001,  8,  .0001,  1,     50,     20,   400,  450
gkampatt10, ihampatt10		FLtext		"Attack 10", 		.0001,  8,  .0001,  1,     50,     20,   450,  450

gkampdec1,  ihampdec1		FLtext		"Decay 1", 		.001,  30,  .0001,  1,     50,     20,     0,  500
gkampdec2,  ihampdec2		FLtext		"Decay 2", 		.001,  30,  .0001,  1,     50,     20,    50,  500
gkampdec3,  ihampdec3		FLtext		"Decay 3", 		.001,  30,  .0001,  1,     50,     20,   100,  500
gkampdec4,  ihampdec4		FLtext		"Decay 4", 		.001,  30,  .0001,  1,     50,     20,   150,  500
gkampdec5,  ihampdec5		FLtext		"Decay 5", 		.001,  30,  .0001,  1,     50,     20,   200,  500
gkampdec6,  ihampdec6		FLtext		"Decay 6", 		.001,  30,  .0001,  1,     50,     20,   250,  500
gkampdec7,  ihampdec7		FLtext		"Decay 7", 		.001,  30,  .0001,  1,     50,     20,   300,  500
gkampdec8,  ihampdec8		FLtext		"Decay 8", 		.001,  30,  .0001,  1,     50,     20,   350,  500
gkampdec9,  ihampdec9		FLtext		"Decay 9", 		.001,  30,  .0001,  1,     50,     20,   400,  500
gkampdec10, ihampdec10		FLtext		"Decay 10", 		.001,  30,  .0001,  1,     50,     20,   450,  500

gkamprel1,  ihamprel1		FLtext		"Release 1", 		.001,   8,  .0001,  1,     50,     20,     0,  550
gkamprel2,  ihamprel2		FLtext		"Release 2", 		.001,   8,  .0001,  1,     50,     20,    50,  550
gkamprel3,  ihamprel3		FLtext		"Release 3", 		.001,   8,  .0001,  1,     50,     20,   100,  550
gkamprel4,  ihamprel4		FLtext		"Release 4", 		.001,   8,  .0001,  1,     50,     20,   150,  550
gkamprel5,  ihamprel5		FLtext		"Release 5", 		.001,   8,  .0001,  1,     50,     20,   200,  550
gkamprel6,  ihamprel6		FLtext		"Release 6", 		.001,   8,  .0001,  1,     50,     20,   250,  550
gkamprel7,  ihamprel7		FLtext		"Release 7", 		.001,   8,  .0001,  1,     50,     20,   300,  550
gkamprel8,  ihamprel8		FLtext		"Release 8", 		.001,   8,  .0001,  1,     50,     20,   350,  550
gkamprel9,  ihamprel9		FLtext		"Release 9", 		.001,   8,  .0001,  1,     50,     20,   400,  550
gkamprel10, ihamprel10		FLtext		"Release 10", 		.001,   8,  .0001,  1,     50,     20,   450,  550

;SET_INITIAL_VALUES		VALUE 	       | HANDLE
		FLsetVal_i	1-.05, 		ihPartAmp1	;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.1, 		ihPartAmp2	;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.23, 		ihPartAmp3	;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-1, 		ihPartAmp4	;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.2,		ihPartAmp5	;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.18, 		ihPartAmp6	;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.1, 		ihPartAmp7	;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.067,		ihPartAmp8	;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.05, 		ihPartAmp9	;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.3, 		ihPartAmp10    	;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP

		FLsetVal_i	272/437,	ihratio1
		FLsetVal_i	538/437,	ihratio2
		FLsetVal_i	874/437,	ihratio3
		FLsetVal_i	1281/437,	ihratio4
		FLsetVal_i	1755/437,	ihratio5
		FLsetVal_i	2264/437,	ihratio6
		FLsetVal_i	2813/437,	ihratio7
		FLsetVal_i	3389/437,	ihratio8
		FLsetVal_i	4822/437,	ihratio9
		FLsetVal_i	5255/437,	ihratio10

		FLsetVal_i	.003,	ihampatt1
		FLsetVal_i	.003,	ihampatt2
		FLsetVal_i	.003,	ihampatt3
		FLsetVal_i	.003,	ihampatt4
		FLsetVal_i	.003,	ihampatt5
		FLsetVal_i	.003,	ihampatt6
		FLsetVal_i	.003,	ihampatt7
		FLsetVal_i	.003,	ihampatt8
		FLsetVal_i	.003,	ihampatt9
		FLsetVal_i	.003,	ihampatt10

		FLsetVal_i	4.5,	ihampdec1
		FLsetVal_i	7.22,	ihampdec2
		FLsetVal_i	9.26,	ihampdec3
		FLsetVal_i	9.42,	ihampdec4
		FLsetVal_i	8.7,	ihampdec5
		FLsetVal_i	4.98,	ihampdec6
		FLsetVal_i	4.5,	ihampdec7
		FLsetVal_i	2.22,	ihampdec8
		FLsetVal_i	2.42,	ihampdec9
		FLsetVal_i	1.34,	ihampdec10

		FLsetVal_i	.3,	ihamprel1
		FLsetVal_i	.4,	ihamprel2
		FLsetVal_i	.5,	ihamprel3
		FLsetVal_i	.32,	ihamprel4
		FLsetVal_i	.25,	ihamprel5
		FLsetVal_i	.1,	ihamprel6
		FLsetVal_i	.04,	ihamprel7
		FLsetVal_i	.02,	ihamprel8
		FLsetVal_i	.01,	ihamprel9
		FLsetVal_i	.005,	ihamprel10

		FLsetVal_i	437, 		ihfund
		FLsetVal_i	0.3, 		ihamp     

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 560, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"               Inharmonic Additive Synthesis                 ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"In inharmonic additive synthesis the partial spacings do not ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"follow the harmonic series and so in this example each of the", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"partials is individually tunable.                            ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"The fundemental is defined using the 'Fundemental' slider.   ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"(Note that the lowest partial is not necessarily the         ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"perceived fundemental of the tone. Curiously in the default  ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"timbre produced by this example, which is that of a tubular  ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"bell, the perceived fundemental of 437 Hz is not present at  ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"all! The fundemental is actually 1 octave below the 3rd      ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"partial.) The frequencies of subsequent partials are derived ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"using ratios.                                                ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"A simple ADR envelope is implemented independently for each  ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"partial in order to permit the creation of dynamic spectra.  ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"This example is designed for producing percussive sounds only", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"and therefore has no sustain portion in any of the amplitude ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"envelopes. Setting 'decay' values very high will give the    ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"the impression of a sustaining instrument.                   ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"Notice how, in general, the higher partials tend to decay    ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"quicker.                                                     ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"Also when damped, i.e. if the envelopes enter their release  ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"stages, the higher partials tend to decay quicker.           ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"The data for the default sound in this example was derived   ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"from a sonogram sound analysis program.                      ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"This example also allow pitch control from a MIDI keyboard by", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"first activating the 'MIDI switch in the interface. In this  ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"mode the instrument will also respond to key velocity.       ", 	1,      5,     14,    490,    15,     5, 540

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen 0, 0, 4096, 10, 1	;A SINE WAVE

instr 	1
	kporttime	linseg	0,0.01,0.05		;PORTAMENTO TIME RAMPS UP QUICKLY FROM ZERO
	iMIDIActiveValue	=	1		;IF MIDI ACTIVATED
	iMIDIflag		=	0		;IF FLTK ACTIVATED
	mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 

	icps	cpsmidi				;READ MIDI PITCH VALUES - THIS VALUE CAN BE MAPPED TO GRAIN DENSITY AND/OR PITCH DEPENDING ON THE SETTING OF THE MIDI MAPPING SWITCHES
	ivel	veloc		0,1		;READ NOTE VELOCITY. WILL BE WITHIN THE RANGE 0 AND 1

	if gkFLTK_MIDI==0&&iMIDIflag==0 then 	;SENSE FLTK ON/OFF SWITCH & WHETHER THIS IS A MIDI NOTE ITS STATUS WILL BE IGNORED
	 turnoff				;TURN OFF THIS INSTRUMENT IMMEDIATELY
	endif					;END OF THIS CONDITIONAL BRANCH

	if iMIDIflag==1 then				;IF THIS IS A MIDI ACTIVATED NOTE...
		kfund	=	icps			;MAP MIDI NOTE VALUE TO WGUIDE1 FREQUENCY
		kamp	=	gkamp * ivel
	else						;OTHERWISE...
		kfund		portk	gkfund, kporttime		;SMOOTH VARIABLE CHANGES WITH PORTK
		kamp	=	gkamp
	endif						;END OF THIS CONDITIONAL BRANCH

	;AMPLITUDE ENVELOPES (WITH MIDI RELEASE SEGMENT)
	aenv1		expsegr	.001, i(gkampatt1), 1.001, i(gkampdec1), .001, i(gkamprel1), .001
	aenv2		expsegr	.001, i(gkampatt2), 1.001, i(gkampdec2), .001, i(gkamprel2), .001
	aenv3		expsegr	.001, i(gkampatt3), 1.001, i(gkampdec3), .001, i(gkamprel3), .001
	aenv4		expsegr	.001, i(gkampatt4), 1.001, i(gkampdec4), .001, i(gkamprel4), .001
	aenv5		expsegr	.001, i(gkampatt5), 1.001, i(gkampdec5), .001, i(gkamprel5), .001
	aenv6		expsegr	.001, i(gkampatt6), 1.001, i(gkampdec6), .001, i(gkamprel6), .001
	aenv7		expsegr	.001, i(gkampatt7), 1.001, i(gkampdec7), .001, i(gkamprel7), .001
	aenv8		expsegr	.001, i(gkampatt8), 1.001, i(gkampdec8), .001, i(gkamprel8), .001
	aenv9		expsegr	.001, i(gkampatt9), 1.001, i(gkampdec9), .001, i(gkamprel9), .001
	aenv10		expsegr	.001, i(gkampatt10),1.001, i(gkampdec10),.001, i(gkamprel10), .001
	
	;SEPARATE OSCILLATORS CREATE EACH OF THE PARTIALS (NOTE THAT FLTK VERTICAL SLIDERS ARE INVERTED TO ALLOW MINIMUM VALUES TO BE LOWEST ON THE SCREEN)
	;OUTPUT		OPCODE	AMPLITUDE	                        | FREQUENCY    | FUNCTION_TABLE
	apart1		oscili	kamp*(aenv1  - 0.001) * (1-gkPartAmp1),  kfund*gkratio1, 	gisine
	apart2		oscili	kamp*(aenv2  - 0.001) * (1-gkPartAmp2),  kfund*gkratio2, 	gisine
	apart3		oscili	kamp*(aenv3  - 0.001) * (1-gkPartAmp3),  kfund*gkratio3, 	gisine
	apart4		oscili	kamp*(aenv4  - 0.001) * (1-gkPartAmp4),  kfund*gkratio4, 	gisine
	apart5		oscili	kamp*(aenv5  - 0.001) * (1-gkPartAmp5),  kfund*gkratio5, 	gisine
	apart6		oscili	kamp*(aenv6  - 0.001) * (1-gkPartAmp6),  kfund*gkratio6, 	gisine
	apart7		oscili	kamp*(aenv7  - 0.001) * (1-gkPartAmp7),  kfund*gkratio7, 	gisine
	apart8		oscili	kamp*(aenv8  - 0.001) * (1-gkPartAmp8),  kfund*gkratio8, 	gisine
	apart9		oscili	kamp*(aenv9  - 0.001) * (1-gkPartAmp9),  kfund*gkratio9, 	gisine
	apart10      	oscili	kamp*(aenv10 - 0.001) * (1-gkPartAmp10), kfund*gkratio10, 	gisine
	                                                          
	;SUM THE 10 OSCILLATORS:
	amix		sum	apart1,\
				apart2,\
				apart3,\
				apart4,\
				apart5,\
				apart6,\
				apart7,\
				apart8,\
				apart9,\
				apart10
				
		outs	amix, amix	;SEND MIXED SIGNAL TO THE OUTPUTS
endin		

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT ALLOWS REALTIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>