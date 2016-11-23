HarmonicAdditiveSynthesis2.csd
Written by Iain McCurdy, 2008

<CsoundSynthesizer>

<CsOptions>
-odac -M0 -+rtmidi=virtual -d -m0
;DISABLE VIRTUAL MIDI FOR EXTERNAL MIDI CONTROL
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	8	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM SOUND INTENSITY LEVEL

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL                 | WIDTH | HEIGHT | X | Y
		FLpanel	"Additive Synthesis 2",  515,    670,    0,  0

;SWITCHES                                            			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR	p4	p5	p6	p7	p8	p9	p10	p11	p12	p13	p14	p15	p16	p17	p18	p19	p20	p21	p22	p23	p24	p25	p26	p27	p28	p29	p30	p31	p32	p33
gkFLTK_MIDI,ihFLTK_MIDI	FLbutton	"On (FLTK) / Off (MIDI)",	1,    0,    22,    200,     25,    5,  5,    0,      1,      0,      3600
FLsetColor2	255, 255, 50, ihFLTK_MIDI	;SET SECONDARY COLOUR TO YELLOW
gkviolin,ih		FLbutton	"Violin",			1,    0,    21,     62,     20,    2,  50,   0,      3,      0,       .001,  1-.55,	1-.55,	1-.9, 	1-.45,	1-.5,	1-.5,	1-.8,	1-.3,	1-.3,	1-.3,	1-.07,	1-.06,	1-.26,	1-.16,	1-.05,	1-.05,	1-.05,	1-.05,	1-.05,	1-.05,	1-.05,	1-.04,	1-.04,	1-.04,	1-.023,	1-.022,	1-.015,	1-.01,	1-.009,	1-.008
gktrumpet,ih		FLbutton	"Trumpet",			1,    0,    21,     62,     20,    2,  75,   0,      3,      0,       .001,  1-.4, 	1-.47, 	1-.56,	1-1.3, 	1-.8, 	1-.7, 	1-.6, 	1-.25, 	1-.2, 	1-.13, 	1-.07, 	1-.04,	1-.03,	1-.023, 1-.013,	1-.01,	1-.008,	1-.0075,1-.007,	1-.0065,1-0,	1-0,	1-0,	1-0,	1-0,	1-0,	1-0,	1-0,	1-0,	1-0
gkclarinet,ih		FLbutton	"Clarinet",			1,    0,    21,     62,     20,    2, 100,   0,	     3,      0,       .001,  1-1.3, 	1-.025, 1-.8, 	1-.15, 	1-.18, 	1-.15, 	1-.08, 	1-.035, 1-.025, 1-.004, 1-.004, 1-.008,	1-.0035,1-0, 	1-.0042,1-0,	1-0,	1-0,	1-0,	1-0,	1-0,	1-0,	1-0,	1-0,	1-0,	1-0,	1-0,	1-0,	1-0,	1-0
gkbuzz,ih		FLbutton	"Buzz",				1,    0,    21,     62,     20,    2, 125,   0,      3,      0,       .001,  1- .5,	1-.5,	1-.5,	1-.5,	1-.5,	1-.5,	1-.5,	1-.5,	1-.5,	1-.5,	1-.5,	1-.5,	1-.5,	1-.5,	1-.5,	1-.5,	1-.5,	1-.5,	1-.5,	1-.5,	1-.5,	1-.5,	1-.5,	1-.5,	1-.5,	1-.5,	1-.5,	1-.5,	1-.5,	1-.5
gkflat,ih		FLbutton	"Flat",				1,    0,    21,     62,     20,    2, 150,   0,      3,      0,       .001,  1,		1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1,	1

;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
idfund				FLvalue	" ",     50,     15,     0, 320
idamp				FLvalue	" ",     50,     15,     0, 370
idstr				FLvalue	" ",     62,     20,     2, 260

;GENERAL_TEXT_SETTINGS			ISIZE, IFONT, IALIGN, IRED, IGREEN, IBLUE
			FLlabel		10,      1,      3,     0,     0,      0

;SLIDERS					            		MIN | MAX | EXP | TYPE | DISP  | WIDTH | HEIGHT | X    | Y
gkPartAmp1, gihPartAmp1		FLslider 	"1",			0,     1,    0,     4,  idstr,     15,    245,   50+15,  35
gkPartAmp2, gihPartAmp2		FLslider 	"2",			0,     1,    0,     4,  idstr,     15,    245,   65+15,  35
gkPartAmp3, gihPartAmp3		FLslider 	"3",			0,     1,    0,     4,  idstr,     15,    245,   80+15,  35
gkPartAmp4, gihPartAmp4		FLslider 	"4",			0,     1,    0,     4,  idstr,     15,    245,   95+15,  35
gkPartAmp5, gihPartAmp5		FLslider 	"5",			0,     1,    0,     4,  idstr,     15,    245,  110+15,  35
gkPartAmp6, gihPartAmp6		FLslider 	"6",			0,     1,    0,     4,  idstr,     15,    245,  125+15,  35
gkPartAmp7, gihPartAmp7		FLslider 	"7",			0,     1,    0,     4,  idstr,     15,    245,  140+15,  35
gkPartAmp8, gihPartAmp8		FLslider 	"8",			0,     1,    0,     4,  idstr,     15,    245,  155+15,  35
gkPartAmp9, gihPartAmp9		FLslider 	"9",			0,     1,    0,     4,  idstr,     15,    245,  170+15,  35
gkPartAmp10,gihPartAmp10	FLslider 	"10",			0,     1,    0,     4,  idstr,     15,    245,  185+15,  35
gkPartAmp11,gihPartAmp11	FLslider 	"11",			0,     1,    0,     4,  idstr,     15,    245,  200+15,  35
gkPartAmp12,gihPartAmp12	FLslider 	"12",			0,     1,    0,     4,  idstr,     15,    245,  215+15,  35
gkPartAmp13,gihPartAmp13	FLslider 	"13",			0,     1,    0,     4,  idstr,     15,    245,  230+15,  35
gkPartAmp14,gihPartAmp14	FLslider 	"14",			0,     1,    0,     4,  idstr,     15,    245,  245+15,  35
gkPartAmp15,gihPartAmp15	FLslider 	"15",			0,     1,    0,     4,  idstr,     15,    245,  260+15,  35
gkPartAmp16,gihPartAmp16	FLslider 	"16",			0,     1,    0,     4,  idstr,     15,    245,  275+15,  35
gkPartAmp17,gihPartAmp17	FLslider 	"17",			0,     1,    0,     4,  idstr,     15,    245,  290+15,  35
gkPartAmp18,gihPartAmp18	FLslider 	"18",			0,     1,    0,     4,  idstr,     15,    245,  305+15,  35
gkPartAmp19,gihPartAmp19	FLslider 	"19",			0,     1,    0,     4,  idstr,     15,    245,  320+15,  35
gkPartAmp20,gihPartAmp20	FLslider 	"20",			0,     1,    0,     4,  idstr,     15,    245,  335+15,  35
gkPartAmp21,gihPartAmp21	FLslider 	"21",			0,     1,    0,     4,  idstr,     15,    245,  350+15,  35
gkPartAmp22,gihPartAmp22	FLslider 	"22",			0,     1,    0,     4,  idstr,     15,    245,  365+15,  35
gkPartAmp23,gihPartAmp23	FLslider 	"23",			0,     1,    0,     4,  idstr,     15,    245,  380+15,  35
gkPartAmp24,gihPartAmp24	FLslider 	"24",			0,     1,    0,     4,  idstr,     15,    245,  395+15,  35
gkPartAmp25,gihPartAmp25	FLslider 	"25",			0,     1,    0,     4,  idstr,     15,    245,  410+15,  35
gkPartAmp26,gihPartAmp26	FLslider 	"26",			0,     1,    0,     4,  idstr,     15,    245,  425+15,  35
gkPartAmp27,gihPartAmp27	FLslider 	"27",			0,     1,    0,     4,  idstr,     15,    245,  440+15,  35
gkPartAmp28,gihPartAmp28	FLslider 	"28",			0,     1,    0,     4,  idstr,     15,    245,  455+15,  35
gkPartAmp29,gihPartAmp29	FLslider 	"29",			0,     1,    0,     4,  idstr,     15,    245,  470+15,  35
gkPartAmp30,gihPartAmp30	FLslider 	"30",			0,     1,    0,     4,  idstr,     15,    245,  485+15,  35
;GENERAL_TEXT_SETTINGS			SIZE | FONT | ALIGN | RED | GREEN | BLUE
			FLlabel		12,      1,      3,    0,     0,      0
;TEXT BOXES              			TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y 
ih		 FLbox  "Partial Strength:", 	1,      9,     10,    70,     10,     0, 280

;SLIDERS					            		MIN | MAX  | EXP | TYPE | DISP  | WIDTH | HEIGHT | X  | Y
gkfund, gihfund			FLslider 	"Fundemental (Hertz)",	20,  10000,  -1,     3,  idfund,  500,     20,     0,  300
gkamp,  gihamp			FLslider 	"Global Amplitude",	0,       1,   0,     3,  idamp,   500,     20,     0,  350

;WIDGET GROUP				     WIDTH | HEIGHT | X | Y | BORDER 
		FLgroup "Amplitude Envelope", 360,    110,    5, 390 , 6
;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
idampatt			FLvalue	" ",     50,       18,   10,470
idampattlev			FLvalue	" ",     50,       18,   60,470
idampdec			FLvalue	" ",     50,       18,  110,470
idampdeclev			FLvalue	" ",     50,       18,  160,470
idampdec2			FLvalue	" ",     50,       18,  210,470
idampslev			FLvalue	" ",     50,       18,  260,470
idamprel			FLvalue	" ",     50,       18,  310,470
;KNOBS								MIN  | MAX | EXP | TYPE | DISP    | WIDTH |  X | Y
gkampatt, gihampatt		FLknob 		"Attack",	.001,   8,    0,    1,  idampatt,    40,    15, 400
gkampattlev, gihampattlev	FLknob 		"Att. Lev",	0,      1,    0,    1,  idampattlev, 40,    65, 400
gkampdec, gihampdec		FLknob 		"Decay",	0,     15,    0,    1,  idampdec,    40,   115, 400
gkampdeclev, gihampdeclev	FLknob 		"Dec. Lev.",	0,      1,    0,    1,  idampdeclev, 40,   165, 400
gkampdec2, gihampdec2		FLknob 		"Decay 2",	0,     15,    0,    1,  idampdec2,   40,   215, 400
gkampslev,gihampslev		FLknob 		"Sustain",	0,      1,    0,    1,  idampslev,   40,   265, 400
gkamprel, gihamprel		FLknob 		"Release",	0,     15,    0,    1,  idamprel,    40,   315, 400
;SET_INITIAL_VALUES		VALUE 	       | HANDLE
		FLsetVal_i	.075, 		gihampatt
		FLsetVal_i	1, 		gihampattlev
		FLsetVal_i	.231, 		gihampdec
		FLsetVal_i	.31, 		gihampdeclev
		FLsetVal_i	1.007, 		gihampdec2
		FLsetVal_i	.632, 		gihampslev
		FLsetVal_i	.1, 		gihamprel
				FLgroupEnd	;END OF WIDGET GROUP

;WIDGET GROUP				WIDTH | HEIGHT | X | Y | BORDER 
		FLgroup "Modulation", 	260,     110,    5, 530,   6
;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
idmodrate			FLvalue	" ",     50,       18,   10,610
idvibdep			FLvalue	" ",     50,       18,   60,610
idtremdep			FLvalue	" ",     50,       18,  110,610
idmoddel			FLvalue	" ",     50,       18,  160,610
idmodrise			FLvalue	" ",     50,       18,  210,610
;KNOBS									MIN  | MAX | EXP | TYPE | DISP    | WIDTH |  X | Y
gkmodrate, gihmodrate		FLknob 		"Mod. Rate",		.001,  20,    0,    1,  idmodrate,   40,    15, 540
gkvibdep, gihvibdep		FLknob 		"Vib. Depth",		0,     .1,    0,    1,  idvibdep,    40,    65, 540
gktremdep, gihtremdep		FLknob 		"Trem. Depth",		0,     .5,    0,    1,  idtremdep,   40,   115, 540
gkmoddel, gihmoddel		FLknob 		"Delay Time",	0,      3,    0,    1,  idmoddel,    40,   165, 540
gkmodrise, gihmodrise		FLknob 		"Rise Time",	0,      5,    0,    1,  idmodrise,   40,   215, 540
;SET_INITIAL_VALUES		VALUE 	       | HANDLE
		FLsetVal_i	4.2, 		gihmodrate
		FLsetVal_i	.004, 		gihvibdep
		FLsetVal_i	.17, 		gihtremdep
		FLsetVal_i	.5, 		gihmoddel
		FLsetVal_i	.87, 		gihmodrise
				FLgroupEnd	;END OF WIDGET GROUP

;SET_INITIAL_VALUES		VALUE 	       | HANDLE
		FLsetVal_i	1-.55, 		gihPartAmp1	;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.55, 		gihPartAmp2	;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.9, 		gihPartAmp3	;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.45, 		gihPartAmp4	;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.5,		gihPartAmp5	;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.5, 		gihPartAmp6	;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.8, 		gihPartAmp7	;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.3, 		gihPartAmp8	;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.3, 		gihPartAmp9	;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.3, 		gihPartAmp10    ;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.07, 		gihPartAmp11    ;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.06, 		gihPartAmp12    ;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.26, 		gihPartAmp13    ;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.16, 		gihPartAmp14    ;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.05, 		gihPartAmp15    ;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.05, 		gihPartAmp16    ;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.05, 		gihPartAmp17    ;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.05, 		gihPartAmp18    ;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.05, 		gihPartAmp19    ;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.05, 		gihPartAmp20    ;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.05, 		gihPartAmp21    ;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.04, 		gihPartAmp22    ;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.04, 		gihPartAmp23    ;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.04, 		gihPartAmp24    ;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.023, 	gihPartAmp25    ;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.04, 		gihPartAmp26    ;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.015, 	gihPartAmp27    ;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.01, 		gihPartAmp28    ;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.009, 	gihPartAmp29    ;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	1-.008, 	gihPartAmp30    ;NOTE THAT RANGE HAS BEEN INVERTERTED FOR ALL VERTICAL SLIDER AS THEY ONLY SEEM TO WORK PROPERLY WHEN THE MAXIMUM VALUE IS AT THE TOP
		FLsetVal_i	440, 		gihfund
		FLsetVal_i	0.1, 		gihamp     

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 700, 527, 0
				FLscroll     515, 700, 0, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"       Harmonic Additive Synthesis 2 - 30 HARMONICS          ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"In this example a lot more harmonics have been added in      ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"addition to an amplitude envelope, tremolo and vibrato. These", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"additions enhance the fusion of the various partials.        ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"Some presets are provided (only the partial strengths are    ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"contained in the presets) which provide only general         ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"approximations of the sounds they attempt to imitate.        ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"Notice how the upper haromics are only used in very small    ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"amounts (their presence is nonetheless crucial in creating   ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"the tone of the instrument). The 'Buzz' preset that employs  ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"all harmonics equally sounds rather shrill and unnatural.    ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"Also the fundemental (partial 1) is not always the strongest ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"partial. In the 'Trumpet' preset the 4th partial is the      ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"strongest.                                                   ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"In the clarinet timbre, the odd numbered partials            ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"predominate. This is what gives the clarinet timbre its      ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"'hollow' characteristic.                                     ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"The main problem in this example is that the spectrum is not ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"dynamic. In order to create a dynamic spectrum it would be   ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"necessary to be able to control the strength of each partial ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"with its own envelope. Implementing this would result in a   ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"vast number of controls that would require setting up.       ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"Another problem with this example is that the harmonics are  ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"always perfectly tuned whereas in the real world even        ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"harmonic sounds exhibit small distortions in pitch in their  ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"harmonics which imbue them with a slight inharmonicity,      ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"crucial to their character.                                  ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"Additionally control over the initial phase of each of the   ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"partials would be needed to be able to control the nature of ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"interference between partials.                               ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"If all the suggested improvements were added we would have an", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"extremely flexible instrument but it would have an rather    ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"unwieldy number on controls and herein lies the main problem ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"with designing an additive synthesis interface. In contrast  ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"FM synthesis allows the creation of rich, dynamic spectra by ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"using just a small number of controls (but it lacks the      ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"ability to modify independent partials).                     ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"Perhaps an alternative approach would be to borrow aspects of", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"subtractive synthesis and employ filters to create dynamic   ", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"spectra.                                                     ", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"This example also allows control from a MIDI keyboard        ", 	1,      5,     14,    490,    20,     5, 820
ih		 	FLbox  	"by setting the 'On (FLTK) / Off (MIDI)' switch to Off (MIDI).", 	1,      5,     14,    490,    20,     5, 840
ih		 	FLbox  	"The instrument will respond to note number, velocity and     ", 	1,      5,     14,    490,    20,     5, 860
ih		 	FLbox  	"pitch bend.                                                  ", 	1,      5,     14,    490,    20,     5, 880

				FLscrollEnd
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen	0, 0, 4096, 10, 1	;A SINE WAVE

instr 	1	;SYNTHESIS INSTRUMENT (FLTK ANF MIDI)
	kporttime	linseg	0,0.01,0.05		;PORTAMENTO TIME RAMPS UP QUICKLY FROM ZERO
	iMIDIActiveValue	=	1		;IF MIDI ACTIVATED
	iMIDIflag		=	0		;IF FLTK ACTIVATED
	mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 

	icps	cpsmidi				;READ MIDI PITCH VALUES - THIS VALUE CAN BE MAPPED TO GRAIN DENSITY AND/OR PITCH DEPENDING ON THE SETTING OF THE MIDI MAPPING SWITCHES
	ivel	veloc		0,1		;READ NOTE VELOCITY. WILL BE WITHIN THE RANGE 0 AND 1
	kbend	pchbend		0,2		;PITCH BEND VARIABLE (IN oct FORMAT)

	if gkFLTK_MIDI==0&&iMIDIflag==0 then 	;SENSE FLTK ON/OFF SWITCH & WHETHER THIS IS A MIDI NOTE ITS STATUS WILL BE IGNORED
	 turnoff				;TURN OFF THIS INSTRUMENT IMMEDIATELY
	endif					;END OF THIS CONDITIONAL BRANCH

	if iMIDIflag==1 then				;IF THIS IS A MIDI ACTIVATED NOTE...
		kfund	=	icps*semitone(kbend)	;MAP MIDI NOTE VALUE TO WGUIDE1 FREQUENCY
		kamp	=	gkamp * ivel
	else						;OTHERWISE...
		kfund		portk	gkfund, kporttime		;SMOOTH VARIABLE CHANGES WITH PORTK
		kamp		portk	gkamp, kporttime		;APPLY PORTAMENTO SMOOTHING
	endif						;END OF THIS CONDITIONAL BRANCH

	;AMPLITUDE ENVELOPE (WITH MIDI RELEASE SEGMENT)
	aenv		linsegr	0,i(gkampatt),i(gkampattlev),i(gkampdec),i(gkampdeclev),i(gkampdec2),i(gkampslev),i(gkamprel),0
	
	;AMPLITUDE MODULATION (TREMOLO) AND VIBRATO
	gkTremPhase	=	.5	;PHASE OF THE TREMOLO LFO WAVEFORM (IN RADIANS) WITH RESPECT TO THE PHASE OF THE VIBRATO WAVEFORM WHICH IS AT ZERO RADIANS (N.B. .5 RADIANS=180 DEGREES)
	kmodenv		linseg	0, i(gkmoddel), 0, i(gkmodrise), 1, (1), 1 ;ENVELOPE WHICH ALLOWS THE MODULATION FUNCTIONS TO RISE GRADUALLY AFTER THE NOTE HAS BEGUN
	kvib		oscili	gkvibdep*kmodenv, gkmodrate, gisine	;VIBRATO LFO
	kvib		=	kvib + 1			;VIBRATO FUNCTION OSCILLATES ABOUT 1
	ktrem		oscili	gktremdep*kmodenv, gkmodrate, gisine, i(gkTremPhase)	;TREMOLO LFO
	ktrem		=	1-(ktrem+gktremdep)	;TREMOLO OSCILLATES DOWN FROM A MAXIMUM VALUE OF 1
	kfund		=	kfund*kvib		;APPLY VIBRATO MODULATION TO THE FUNDEMENTAL (WHICH WILL IN TURN BE PASSED ON TO EACH OF THE PARTIALS)
	kamp		=	kamp*ktrem		;APPLY TREMOLO MODULATION TO THE AMPLITUDE VARIABLE THAT WILL BE APPLIED TO EACH OF THE PARTIALS
	
	;SEPARATE OSCILLATORS CREATE EACH OF THE PARTIALS
	;OUTPUT		OPCODE	AMPLITUDE	    | FREQUENCY | FUNCTION_TABLE
	apart1		oscili	kamp*(1-gkPartAmp1),  kfund, 		gisine
	apart2		oscili	kamp*(1-gkPartAmp2),  kfund+(kfund), 	gisine
	apart3		oscili	kamp*(1-gkPartAmp3),  kfund+(kfund*2), 	gisine
	apart4		oscili	kamp*(1-gkPartAmp4),  kfund+(kfund*3), 	gisine
	apart5		oscili	kamp*(1-gkPartAmp5),  kfund+(kfund*4), 	gisine
	apart6		oscili	kamp*(1-gkPartAmp6),  kfund+(kfund*5), 	gisine
	apart7		oscili	kamp*(1-gkPartAmp7),  kfund+(kfund*6), 	gisine
	apart8		oscili	kamp*(1-gkPartAmp8),  kfund+(kfund*7), 	gisine
	apart9		oscili	kamp*(1-gkPartAmp9),  kfund+(kfund*8), 	gisine
	apart10      	oscili	kamp*(1-gkPartAmp10), kfund+(kfund*9), 	gisine
	apart11      	oscili	kamp*(1-gkPartAmp11), kfund+(kfund*10), gisine
	apart12      	oscili	kamp*(1-gkPartAmp12), kfund+(kfund*11), gisine
	apart13      	oscili	kamp*(1-gkPartAmp13), kfund+(kfund*12), gisine
	apart14      	oscili	kamp*(1-gkPartAmp14), kfund+(kfund*13), gisine
	apart15      	oscili	kamp*(1-gkPartAmp15), kfund+(kfund*14), gisine
	apart16      	oscili	kamp*(1-gkPartAmp16), kfund+(kfund*15), gisine
	apart17      	oscili	kamp*(1-gkPartAmp17), kfund+(kfund*16), gisine
	apart18      	oscili	kamp*(1-gkPartAmp18), kfund+(kfund*17), gisine
	apart19      	oscili	kamp*(1-gkPartAmp19), kfund+(kfund*18), gisine
	apart20      	oscili	kamp*(1-gkPartAmp20), kfund+(kfund*19), gisine
	apart21      	oscili	kamp*(1-gkPartAmp21), kfund+(kfund*20), gisine
	apart22      	oscili	kamp*(1-gkPartAmp22), kfund+(kfund*21), gisine
	apart23      	oscili	kamp*(1-gkPartAmp23), kfund+(kfund*22), gisine
	apart24      	oscili	kamp*(1-gkPartAmp24), kfund+(kfund*23), gisine
	apart25      	oscili	kamp*(1-gkPartAmp25), kfund+(kfund*24), gisine
	apart26      	oscili	kamp*(1-gkPartAmp26), kfund+(kfund*25), gisine
	apart27      	oscili	kamp*(1-gkPartAmp27), kfund+(kfund*26), gisine
	apart28      	oscili	kamp*(1-gkPartAmp28), kfund+(kfund*27), gisine
	apart29      	oscili	kamp*(1-gkPartAmp29), kfund+(kfund*28), gisine
	apart30      	oscili	kamp*(1-gkPartAmp30), kfund+(kfund*29), gisine
	
	;SUM THE 30 OSCILLATORS:
	amix		sum	apart1,\
				apart2,\
				apart3,\
				apart4,\
				apart5,\
				apart6,\
				apart7,\
				apart8,\
				apart9,\
				apart10,\
				apart11,\
				apart12,\
				apart13,\
				apart14,\
				apart15,\
				apart16,\
				apart17,\
				apart18,\
				apart19,\
				apart20,\
				apart21,\
				apart22,\
				apart23,\
				apart24,\
				apart25,\
				apart26,\
				apart27,\
				apart28,\
				apart29,\
				apart30
		outs	amix * aenv, amix * aenv	;SEND MIXED SIGNAL TOaTHE OUTPUTS aND APPLY THE AMPLITUDE ENVELOPE
endin		
	
instr	3	;PRESETS
	;	OPCODE		TRIGGER | VALUE | DESTINATION_HANDLE
		FLsetVal 	1,          p4,    gihPartAmp1		;SEND VALUE TO FLTK WIDGET
		FLsetVal 	1,          p5,    gihPartAmp2		;SEND VALUE TO FLTK WIDGET
		FLsetVal 	1,          p6,    gihPartAmp3		;SEND VALUE TO FLTK WIDGET
		FLsetVal 	1,          p7,    gihPartAmp4		;SEND VALUE TO FLTK WIDGET
		FLsetVal 	1,          p8,    gihPartAmp5		;SEND VALUE TO FLTK WIDGET
		FLsetVal 	1,          p9,    gihPartAmp6		;SEND VALUE TO FLTK WIDGET
		FLsetVal 	1,          p10,   gihPartAmp7		;SEND VALUE TO FLTK WIDGET
		FLsetVal 	1,          p11,   gihPartAmp8		;SEND VALUE TO FLTK WIDGET
		FLsetVal 	1,          p12,   gihPartAmp9		;SEND VALUE TO FLTK WIDGET
		FLsetVal 	1,          p13,   gihPartAmp10    	;SEND VALUE TO FLTK WIDGET
		FLsetVal 	1,          p14,   gihPartAmp11    	;SEND VALUE TO FLTK WIDGET
		FLsetVal 	1,          p15,   gihPartAmp12    	;SEND VALUE TO FLTK WIDGET
		FLsetVal 	1,          p16,   gihPartAmp13    	;SEND VALUE TO FLTK WIDGET
		FLsetVal 	1,          p17,   gihPartAmp14    	;SEND VALUE TO FLTK WIDGET
		FLsetVal 	1,          p18,   gihPartAmp15    	;SEND VALUE TO FLTK WIDGET
		FLsetVal 	1,          p19,   gihPartAmp16    	;SEND VALUE TO FLTK WIDGET
		FLsetVal 	1,          p20,   gihPartAmp17    	;SEND VALUE TO FLTK WIDGET
		FLsetVal 	1,          p21,   gihPartAmp18    	;SEND VALUE TO FLTK WIDGET
		FLsetVal 	1,          p22,   gihPartAmp19    	;SEND VALUE TO FLTK WIDGET
		FLsetVal 	1,          p23,   gihPartAmp20    	;SEND VALUE TO FLTK WIDGET
		FLsetVal 	1,          p24,   gihPartAmp21    	;SEND VALUE TO FLTK WIDGET
		FLsetVal 	1,          p25,   gihPartAmp22    	;SEND VALUE TO FLTK WIDGET
		FLsetVal 	1,          p26,   gihPartAmp23    	;SEND VALUE TO FLTK WIDGET
		FLsetVal 	1,          p27,   gihPartAmp24    	;SEND VALUE TO FLTK WIDGET
		FLsetVal 	1,          p28,   gihPartAmp25    	;SEND VALUE TO FLTK WIDGET
		FLsetVal 	1,          p29,   gihPartAmp26    	;SEND VALUE TO FLTK WIDGET
		FLsetVal 	1,          p30,   gihPartAmp27    	;SEND VALUE TO FLTK WIDGET
		FLsetVal 	1,          p31,   gihPartAmp28    	;SEND VALUE TO FLTK WIDGET
		FLsetVal 	1,          p32,   gihPartAmp29    	;SEND VALUE TO FLTK WIDGET
		FLsetVal 	1,          p33,   gihPartAmp30	        ;SEND VALUE TO FLTK WIDGET
endin

</CsInstruments>

<CsScore>
f 0 3600
</CsScore>

</CsoundSynthesizer>