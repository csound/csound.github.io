FormantFilter.csd
Written by Iain McCurdy, 2008

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>
sr	=	44100	
ksmps	=	32
nchnls	=	2
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
		FLpanel	"Formant Filter", 500, 700, 0, 0

;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,    0,    22,    140,     25,    5,  5,    -1;0,      1,      0,      -1
gkdisplay,ihdisplay	FLbutton	"Values Update",	1,    0,     2,     70,     20,    5, 580,   -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihdisplay		;SET SECONDARY COLOUR TO YELLOW
FLsetTextSize	9, ihdisplay
FLsetVal_i	1, ihdisplay

;VALUE DISPLAY BOXES		LABEL | WIDTH | HEIGHT | X  | Y
idBWMlt			FLvalue	"",	 50,      16,    5,  145
idFrqMlt		FLvalue	"",	 50,      16,    5,  195
idgain			FLvalue	"",	 50,      16,    5,  295

;SLIDERS				            		MIN   |  MAX | EXP | TYPE |   DISP   | WIDTH | HEIGHT | X  | Y
gkBWMlt, ihBWMlt	FLslider 	"Bandwidths Multiply",	0.01,     4,   -1,   23,    idBWMlt,    490,     25,    5,  120
gkFrqMlt, ihFrqMlt	FLslider 	"Frequencies Multiply",	0.25,     4,   -1,   23,    idFrqMlt,   490,     25,    5,  170
gkmix, ihmix		FLslider 	"Dry/Wet Mix",		0,        1,    0,   23,        -1,     490,     25,    5,  220
gkgain, ihgain		FLslider 	"Global Gain",		0,        4,    0,   23,    idgain,     490,     25,    5,  270
gkInGain, ihInGain	FLslider 	"Gain",			0,        1,    0,   23,        -1,      75,     10,   70,   40
gkBuzFrq, ihBuzFrq	FLslider 	"Freq.",		20,     500,   -1,   23,        -1,      75,     10,   70,   65
FLsetTextSize 11, ihInGain
FLsetTextSize 11, ihBuzFrq

gkf1, ihf1		FLslider 	"f1",			0,        1,    0,   24,        -1,      15,     90,  375,    5
gkf2, ihf2		FLslider 	"f2",			0,        1,    0,   24,        -1,      15,     90,  400,    5
gkf3, ihf3		FLslider 	"f3",			0,        1,    0,   24,        -1,      15,     90,  425,    5
gkf4, ihf4		FLslider 	"f4",			0,        1,    0,   24,        -1,      15,     90,  450,    5
gkf5, ihf5		FLslider 	"f5",			0,        1,    0,   24,        -1,      15,     90,  475,    5

;XY PANELS					MINX | MAXX | MINY | MAXY | EXPX | EXPY | DISPX | DISPY | WIDTH | HEIGHT | X | Y
gkx, gky, ihx, ihy	FLjoy	"Vowel",	0,       1,    0,     1,      0,     0,    -1,     -1,     480,    230,   10, 330

;						 MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  |  Y
gkfreq1, gihfreq1	FLtext		"",	20,   20000,   0,     1,     65,     20,    75,  600
gkdb1, gihdb1		FLtext		"",  	-100,     0,   0,     1,     65,     20,    75,  620
gkbw1, gihbw1		FLtext		"",    	0,    20000,   0,     1,     65,     20,    75,  640
gkfreq2, gihfreq2	FLtext		"",	20,   20000,   0,     1,     65,     20,   150,  600
gkdb2, gihdb2		FLtext		"",  	-100,     0,   0,     1,     65,     20,   150,  620
gkbw2, gihbw2		FLtext		"",    	0,    20000,   0,     1,     65,     20,   150,  640
gkfreq3, gihfreq3	FLtext		"",	20,   20000,   0,     1,     65,     20,   225,  600
gkdb3, gihdb3		FLtext		"",  	-100,     0,   0,     1,     65,     20,   225,  620
gkbw3, gihbw3		FLtext		"",    	0,    20000,   0,     1,     65,     20,   225,  640
gkfreq4, gihfreq4	FLtext		"",	20,   20000,   0,     1,     65,     20,   300,  600
gkdb4, gihdb4		FLtext		"",  	-100,     0,   0,     1,     65,     20,   300,  620
gkbw4, gihbw4		FLtext		"",    	0,    20000,   0,     1,     65,     20,   300,  640
gkfreq5, gihfreq5	FLtext		"",	20,   20000,   0,     1,     65,     20,   375,  600
gkdb5, gihdb5		FLtext		"",  	-100,     0,   0,     1,     65,     20,   375,  620
gkbw5, gihbw5		FLtext		"",    	0,    20000,   0,     1,     65,     20,   375,  640

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,    255,   255,   255	;VALUATOR LABELS MADE INVISIBLE

;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkvoice,   ihvoice	FLbutBank	4,      1,     5,     25,    100,    150, 8,   -1
FLcolor2	50, 255, 255
gkinput,   ihinput	FLbutBank	12,     1,     3,     25,     75,      5,40,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,     0,     0,     0		;VALUATOR LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Bass         ", 	1,       5,    12,     95,     25,  170,   5
ih		 	FLbox  	"Tenor        ", 	1,       5,    12,     95,     25,  170,  25
ih		 	FLbox  	"Counter Tenor", 	1,       5,    12,     95,     25,  170,  45
ih		 	FLbox  	"Alto         ", 	1,       5,    12,     95,     25,  170,  65
ih		 	FLbox  	"Soprano      ", 	1,       5,    12,     95,     25,  170,  85
ih		 	FLbox  	"Formant Gain:", 	1,       5,    11,     95,     15,  280,  96
ih		 	FLbox  	"A", 			1,       6,    16,     10,     15,    8, 315
ih		 	FLbox  	"E", 			1,       6,    16,     10,     15,  250, 315
ih		 	FLbox  	"I", 			1,       6,    16,     10,     15,  484, 315
ih		 	FLbox  	"0", 			1,       6,    16,     10,     15,  484, 560
ih		 	FLbox  	"U", 			1,       6,    16,     10,     15,    8, 560
ih		 	FLbox  	"    Freq.:", 		1,       5,    12,     75,     20,    0, 600
ih		 	FLbox  	"      dB.:",	 	1,       5,    12,     75,     20,    0, 620
ih		 	FLbox  	"Bandwidth:",		1,       5,    12,     75,     20,    0, 640
ih		 	FLbox  	"Formant 1",		1,       5,    12,     65,     20,   75, 580
ih		 	FLbox  	"Formant 2",		1,       5,    12,     65,     20,  150, 580
ih		 	FLbox  	"Formant 3",		1,       5,    12,     65,     20,  225, 580
ih		 	FLbox  	"Formant 4",		1,       5,    12,     65,     20,  300, 580
ih		 	FLbox  	"Formant 5",		1,       5,    12,     65,     20,  375, 580
ih		 	FLbox  	"Live",			1,       5,    11,     40,     25,   30,  40
ih		 	FLbox  	"Buzz",			1,       5,    11,     40,     25,   30,  65
ih		 	FLbox  	"File",			1,       5,    11,     40,     25,   30,  90

;SET INITIAL VALUES FOR VALUATORS 	VALUE | HANDLE
			FLsetVal_i	1, 	ihBWMlt
			FLsetVal_i	1, 	ihgain
			FLsetVal_i	1, 	ihmix
			FLsetVal_i	1, 	ihFrqMlt
			FLsetVal_i	0, 	ihx
			FLsetVal_i	1, 	ihy
			FLsetVal_i	2, 	ihinput
			FLsetVal_i	50, 	ihBuzFrq

		FLpanel_end	; END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 700, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                       Formant Filter                        ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"This example uses five 'reson' bandpass filters to imitate   ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"the filtering effect of the human mouth when expressing      ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"various vowel sounds.                                        ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"These five resonant peaks are referred to as 'formants'.     ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"Each formant consists of data for frequency, intensity (in   ", 	1,      5,     14,    490,    15,     5, 120
ih	  	 	FLbox  	"decibels) and bandwith for each of the five filters.         ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"The user can morph between different vowel sounds by dragging", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"the cross-hairs of an X-Y panel. The locations of specific   ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"vowel sounds are indicated around the edge of the panel.     ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"Data-sets for five different voice types are selectable using", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"a button-bank selecter.                                      ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"Individual gain controls are provided for each formant.      ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"Normally these are left at their maximum setting (gain=1,    ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"therefore no attenuation). Attenuating all formants except   ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"the first two will reveal that the character of the formant  ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"is chiefly defined by just these two formants. An economic   ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"formant filter could be created with just two reson filters. ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"Frequencies can be warped using a global multiplier control. ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"Normally this is set to '1' - no warping.                    ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"Bandwidths can be warped in a similar fashion with the       ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"'Bandwidths Multiply' control.                               ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"The user can choose between three different input sources:   ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"the computer's live input, a 'buzz' tone and a soundfile.    ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"The 'buzz' tone provides a good imitation of the tone        ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"provided by the human vocal chords. When unpitched noise-like", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"sounds (like the soundfile option) are used the resulting    ", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"output resembles a whisper.                                  ", 	1,      5,     14,    490,    15,     5, 560
ih		 	FLbox  	"The live audio input is stereo, reading from both channels.  ", 	1,      5,     14,    490,    15,     5, 580
ih		 	FLbox  	"A matrix of 15 values boxes at the bottom of the GUI provides", 	1,      5,     14,    490,    15,     5, 580
ih		 	FLbox  	"the user with information about current frequency, intensity ", 	1,      5,     14,    490,    15,     5, 600
ih		 	FLbox  	"and bandwidth values for the five formants. These boxes are  ", 	1,      5,     14,    490,    15,     5, 620
ih		 	FLbox  	"for displaying values only. Updating of these boxes can      ", 	1,      5,     14,    490,    15,     5, 640
ih		 	FLbox  	"cause performance issues on MacOS in which case this feature ", 	1,      5,     14,    490,    15,     5, 660
ih		 	FLbox  	"can be turned off using the 'Values Update' button.          ", 	1,      5,     14,    490,    15,     5, 680

				FLpanel_end

		FLrun		;RUN THE WIDGET THREAD

gicos	ftgen	0,0,131072,11,1	;COSINE WAVE (NEEDED BY gbuzz)		

;FUNCTION TABLES STORING DATA FOR VARIOUS VOICE FORMANTS
;BASS
giBFA		ftgentmp	0,  0, 8, -2,	600,	400,	250,	400,	350	;FREQ
giBFE		ftgentmp	0,  0, 8, -2,	1040,	1620,	1750,	750,	600	;FREQ
giBFI		ftgentmp	0,  0, 8, -2,	2250,	2400,	2600,	2400,	2400	;FREQ
giBFO		ftgentmp	0,  0, 8, -2,	2450,	2800,	3050,	2600,	2675	;FREQ
giBFU		ftgentmp	0,  0, 8, -2,	2750,	3100,	3340,	2900,	2950	;FREQ
        	
giBDbA		ftgentmp	0, 0, 8, -2,	0,	0,	0,	0,	0	;dB
giBDbE		ftgentmp	0, 0, 8, -2,	-7,	-12,	-30,	-11,	-20	;dB
giBDbI		ftgentmp	0, 0, 8, -2,	-9,	-9,	-16,	-21,	-32	;dB
giBDbO		ftgentmp	0, 0, 8, -2,	-9,	-12,	-22,	-20,	-28	;dB
giBDbU		ftgentmp	0, 0, 8, -2,	-20,	-18,	-28,	-40,	-36	;dB
        	
giBBWA		ftgentmp	0, 0, 8, -2,	60,	40,	60,	40,	40	;BAND WIDTH
giBBWE		ftgentmp	0, 0, 8, -2,	70,	80,	90,	80,	80	;BAND WIDTH
giBBWI		ftgentmp	0, 0, 8, -2,	110,	100,	100,	100,	100	;BAND WIDTH
giBBWO		ftgentmp	0, 0, 8, -2,	120,	120,	120,	120,	120	;BAND WIDTH
giBBWU		ftgentmp	0, 0, 8, -2,	130,	120,	120,	120,	120	;BAND WIDTH
;TENOR  	
giTFA		ftgentmp	0, 0, 8, -2,	650, 	400,	290,	400,	350	;FREQ
giTFE		ftgentmp	0, 0, 8, -2,	1080, 	1700,   1870,	800,	600	;FREQ
giTFI		ftgentmp	0, 0, 8, -2,	2650,	2600,   2800,	2600,	2700	;FREQ
giTFO		ftgentmp	0, 0, 8, -2,	2900,	3200,   3250,	2800,	2900	;FREQ
giTFU		ftgentmp	0, 0, 8, -2,	3250,	3580,   3540,	3000,	3300	;FREQ
        	
giTDbA		ftgentmp	0, 0, 8, -2,	0,	0,	0,	0,	0	;dB
giTDbE		ftgentmp	0, 0, 8, -2,	-6,	-14,	-15,	-10,	-20	;dB
giTDbI		ftgentmp	0, 0, 8, -2,	-7,	-12,	-18,	-12,	-17	;dB
giTDbO		ftgentmp	0, 0, 8, -2,	-8,	-14,	-20,	-12,	-14	;dB
giTDbU		ftgentmp	0, 0, 8, -2,	-22,	-20,	-30,	-26,	-26	;dB
        	
giTBWA		ftgentmp	0, 0, 8, -2,	80,	70,	40,	40,	40	;BAND WIDTH
giTBWE		ftgentmp	0, 0, 8, -2,	90,	80,	90,	80,	60	;BAND WIDTH
giTBWI		ftgentmp	0, 0, 8, -2,	120,	100,	100,	100,	100	;BAND WIDTH
giTBWO		ftgentmp	0, 0, 8, -2,	130,	120,	120,	120,	120	;BAND WIDTH                                         
giTBWU		ftgentmp	0, 0, 8, -2,	140,	120,	120,	120,	120	;BAND WIDTH
;COUNTER TENOR
giCTFA		ftgentmp	0, 0, 8, -2,	660,	440,	270,	430,	370	;FREQ
giCTFE		ftgentmp	0, 0, 8, -2,	1120,	1800,	1850,	820,	630	;FREQ
giCTFI		ftgentmp	0, 0, 8, -2,	2750,	2700,	2900,	2700,	2750	;FREQ
giCTFO		ftgentmp	0, 0, 8, -2,	3000,	3000,	3350,	3000,	3000	;FREQ
giCTFU		ftgentmp	0, 0, 8, -2,	3350,	3300,	3590,	3300,	3400	;FREQ
        	
giTBDbA		ftgentmp	0, 0, 8, -2,	0,	0,	0,	0,	0	;dB
giTBDbE		ftgentmp	0, 0, 8, -2,	-6,	-14,	-24,	-10,	-20	;dB
giTBDbI		ftgentmp	0, 0, 8, -2,	-23,	-18,	-24,	-26,	-23	;dB
giTBDbO		ftgentmp	0, 0, 8, -2,	-24,	-20,	-36,	-22,	-30	;dB
giTBDbU		ftgentmp	0, 0, 8, -2,	-38,	-20,	-36,	-34,	-30	;dB
        	
giTBWA		ftgentmp	0, 0, 8, -2,	80,	70,	40,	40,	40	;BAND WIDTH
giTBWE		ftgentmp	0, 0, 8, -2,	90,	80,	90,	80,	60	;BAND WIDTH
giTBWI		ftgentmp	0, 0, 8, -2,	120,	100,	100,	100,	100	;BAND WIDTH
giTBWO		ftgentmp	0, 0, 8, -2,	130,	120,	120,	120,	120	;BAND WIDTH
giTBWU		ftgentmp	0, 0, 8, -2,	140,	120,	120,	120,	120	;BAND WIDTH
;ALTO   	
giAFA		ftgentmp	0, 0, 8, -2,	800,	400,	350,	450,	325	;FREQ
giAFE		ftgentmp	0, 0, 8, -2,	1150,	1600,	1700,	800,	700	;FREQ
giAFI		ftgentmp	0, 0, 8, -2,	2800,	2700,	2700,	2830,	2530	;FREQ
giAFO		ftgentmp	0, 0, 8, -2,	3500,	3300,	3700,	3500,	2500	;FREQ
giAFU		ftgentmp	0, 0, 8, -2,	4950,	4950,	4950,	4950,	4950	;FREQ
        	
giADbA		ftgentmp	0, 0, 8, -2,	0,	0,	0,	0,	0	;dB
giADbE		ftgentmp	0, 0, 8, -2,	-4,	-24,	-20,	-9,	-12	;dB
giADbI		ftgentmp	0, 0, 8, -2,	-20,	-30,	-30,	-16,	-30	;dB
giADbO		ftgentmp	0, 0, 8, -2,	-36,	-35,	-36,	-28,	-40	;dB
giADbU		ftgentmp	0, 0, 8, -2,	-60,	-60,	-60,	-55,	-64	;dB
        	
giABWA		ftgentmp	0, 0, 8, -2,	50,	60,	50,	70,	50	;BAND WIDTH
giABWE		ftgentmp	0, 0, 8, -2,	60,	80,	100,	80,	60	;BAND WIDTH
giABWI		ftgentmp	0, 0, 8, -2,	170,	120,	120,	100,	170	;BAND WIDTH
giABWO		ftgentmp	0, 0, 8, -2,	180,	150,	150,	130,	180	;BAND WIDTH
giABWU		ftgentmp	0, 0, 8, -2,	200,	200,	200,	135,	200	;BAND WIDTH
;SOPRANO
giSFA		ftgentmp	0, 0, 8, -2,	800,	350,	270,	450,	325	;FREQ
giSFE		ftgentmp	0, 0, 8, -2,	1150,	2000,	2140,	800,	700	;FREQ
giSFI		ftgentmp	0, 0, 8, -2,	2900,	2800,	2950,	2830,	2700	;FREQ
giSFO		ftgentmp	0, 0, 8, -2,	3900,	3600,	3900,	3800,	3800	;FREQ
giSFU		ftgentmp	0, 0, 8, -2,	4950,	4950,	4950,	4950,	4950	;FREQ
        	
giSDbA		ftgentmp	0, 0, 8, -2,	0,	0,	0,	0,	0	;dB
giSDbE		ftgentmp	0, 0, 8, -2,	-6,	-20,	-12,	-11,	-16	;dB
giSDbI		ftgentmp	0, 0, 8, -2,	-32,	-15,	-26,	-22,	-35	;dB
giSDbO		ftgentmp	0, 0, 8, -2,	-20,	-40,	-26,	-22,	-40	;dB
giSDbU		ftgentmp	0, 0, 8, -2,	-50,	-56,	-44,	-50,	-60	;dB
        	
giSBWA		ftgentmp	0, 0, 8, -2,	80,	60,	60,	70,	50	;BAND WIDTH
giSBWE		ftgentmp	0, 0, 8, -2,	90,	90,	90,	80,	60	;BAND WIDTH
giSBWI		ftgentmp	0, 0, 8, -2,	120,	100,	100,	100,	170	;BAND WIDTH
giSBWO		ftgentmp	0, 0, 8, -2,	130,	150,	120,	130,	180	;BAND WIDTH
giSBWU		ftgentmp	0, 0, 8, -2,	140,	200,	120,	135,	200	;BAND WIDTH

instr	1
	ktrig	changed	gkOnOff
	if ktrig==1&&gkOnOff==1 then
	 schedkwhen	ktrig,0,0,2,0,-1
	endif
endin

instr	2
	if gkOnOff=0	then					;IF FLTK 'On/Off' SWITCH IS OFF... 
		turnoff         				;TURN THIS INSTRMENT OFF IMEDIATELY
	endif                   				;END OF CONDITIONAL BRANCHING      
	
	iporttime	=	.1
	kporttime	linseg	0,.001,iporttime,1,iporttime	;PORTAMENTO TIME                                                      
	kBuzFrq	portk	gkBuzFrq, kporttime                     ;K-RATE PORTAMENTO TIME - RISES QUICKLY TO DESIRED VALUE THEN HOLDS IT
	if	gkinput=0	then				;IF 'Live' IS SELECTED FOR INPUT
		asigL	inch	1				;READ AUDIO FROM CHANNEL 1 (LEFT)
		asigL	=	asigL * gkInGain		;ATTENUATE AUDIO FROM CHANNEL 1 USING 'gkInGain' CONTROL
		asigR	inch	2                               ;READ AUDIO FROM CHANNEL 2 (RIGHT)                       
		asigR	=	asigR * gkInGain                ;ATTENUATE AUDIO FROM CHANNEL 2 USING 'gkInGain' CONTROL
	elseif	gkinput=1	then				;IF 'Buzz' IS SELECTED FOR INPUT
		asigL		buzz	1,kBuzFrq,(sr/3)/kBuzFrq,gicos	;CREATE BUZZ TONE
		asigR		=	asigL							;SET asigR TO BE IDENTICAL TO asigL (THE 'BUZZING' TONE) 
	else							;IF NEITHER OF THE FIRST 2 OPTIONS FOR INPUT ARE USED... (ONLY ONE OPTION REMAINS)
		;OUTPUTS	OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
		asigL, asigR	diskin2	"Seashore.wav",    1,      0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE
	endif
	
	kx	portk	gkx,kporttime
	ky	portk	gky,kporttime	

	kSwitch		changed	gkvoice	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	START			;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif
	START:		
	;A TEXT MACRO IS DEFINED THAT WILL BE THE CODE FOR DERIVING DATA FOR EACH FORMANT. A MACRO IS USED TO AVOID HAVING TO USING CODE REPETITION AND TO EASIER FACICLITATE CODE MODIFICATION
#define	FORMANT_DATA(N)	
	#
	kfreq$N._U	tablei		kx*2, giBFA+(i(gkvoice)*15)+$N-1			;READ DATA FOR FREQUENCY (UPPER EDGE OF PANEL)
	kfreq$N._L	tablei		(1-kx) + 3, giBFA+(i(gkvoice)*15)+$N-1				;READ DATA FOR FREQUENCY (LOWER EDGE OF PANEL)
	kfreq$N		ntrpol		kfreq$N._L, kfreq$N._U, ky					;INTERPOLATE BETWEEN UPPER VALUE AND LOWER VALUE (DETERMINED BY Y-LOCATION ON PANEL)                          
	kdbamp$N._U	tablei		kx*2, giBDbA+(i(gkvoice)*15)+$N-1			;READ DATA FOR INTENSITY (UPPER EDGE OF PANEL)                                      
	kdbamp$N._L	tablei		(1-kx) + 3, giBDbA+(i(gkvoice)*15)+$N-1				;READ DATA FOR INTENSITY (LOWER EDGE OF PANEL)                                      
	kdbamp$N	ntrpol		kdbamp$N._L, kdbamp$N._U, ky                   			;INTERPOLATE BETWEEN UPPER VALUE AND LOWER VALUE (DETERMINED BY Y-LOCATION ON PANEL)
	kbw$N._U	tablei		kx*2, giBBWA+(i(gkvoice)*15)+$N-1			;READ DATA FOR BANDWIDTH (UPPER EDGE OF PANEL)                                      
	kbw$N._L	tablei		(1-kx) + 3, giBBWA+(i(gkvoice)*15)+$N-1				;READ DATA FOR BANDWIDTH (LOWER EDGE OF PANEL)                                      
	kbw$N		ntrpol		kbw$N._L, kbw$N._U, ky						;INTERPOLATE BETWEEN UPPER VALUE AND LOWER VALUE (DETERMINED BY Y-LOCATION ON PANEL)
	kfreq$N		=		kfreq$N * gkFrqMlt						;MULTIPLY FREQUENCY VALUE BY VALUE FROM 'Frequency Multiply' SLIDER
	kbw$N		=		kbw$N * gkBWMlt							;MULTIPLY BANDWIDTH VALUE BY VALUE FROM 'Bandwidth Multiply' SLIDER
	FLsetVal	kDisplayTrigger*gkdisplay, kfreq$N, gihfreq$N					;UPDATE DISPLAY OF FREQUENCY VALUE IN THE ON-SCREEN VALUATOR BOX                                                          
	FLsetVal	kDisplayTrigger*gkdisplay, kdbamp$N, gihdb$N					;UPDATE DISPLAY OF INTENSITY VALUE IN THE ON-SCREEN VALUATOR BOX                                                          
	FLsetVal	kDisplayTrigger*gkdisplay, kbw$N, gihbw$N					;UPDATE DISPLAY OF BANDWIDTH VALUE IN THE ON-SCREEN VALUATOR BOX                                                          
	#												;END OF MACRO!

	kDisplayTrigger	metro	15									;CREATE A TRIGGER METRONOME (USED TO UPDATE VALUATOR BOX DISPLAYS

;READING DATA FOR FORMANTS (MACROS IMPLEMENTED)
	$FORMANT_DATA(1)
	$FORMANT_DATA(2)
	$FORMANT_DATA(3)
	$FORMANT_DATA(4)
	$FORMANT_DATA(5)

	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
	
	aBPF1L	reson	asigL, kfreq1, kbw1, 1			;FORMANT 1
	aBPF1R	reson	asigR, kfreq1, kbw1, 1			;FORMANT 1
	;                                                        
	aBPF2L	reson	asigL, kfreq2, kbw2, 1			;FORMANT 2
	aBPF2R	reson	asigR, kfreq2, kbw2, 1			;FORMANT 2
	;                                                       
	aBPF3L	reson	asigL, kfreq3, kbw3, 1			;FORMANT 3
	aBPF3R	reson	asigR, kfreq3, kbw3, 1			;FORMANT 3
	;                                                        
	aBPF4L	reson	asigL, kfreq4, kbw4, 1			;FORMANT 4
	aBPF4R	reson	asigR, kfreq4, kbw4, 1			;FORMANT 4
	;                                                       
	aBPF5L	reson	asigL, kfreq5, kbw5, 1			;FORMANT 5
	aBPF5R	reson	asigR, kfreq5, kbw5, 1			;FORMANT 5
	
	;FORMANTS ARE MIXED AND MULTIPLIED BOTH BY INTENSITY VALUES DERIVED FROM TABLES AND BY THE ON-SCREEN GAIN CONTROLS FOR EACH FORMANT 
	aMixL	sum	aBPF1L*(ampdbfs(kdbamp1))*(1-gkf1), aBPF2L*(ampdbfs(kdbamp2))*(1-gkf2), aBPF3L*(ampdbfs(kdbamp3))*(1-gkf3), aBPF4L*(ampdbfs(kdbamp4))*(1-gkf4), aBPF5L*(ampdbfs(kdbamp5))*(1-gkf5)
	aMixR	sum	aBPF1R*(ampdbfs(kdbamp1))*(1-gkf1), aBPF2R*(ampdbfs(kdbamp2))*(1-gkf2), aBPF3R*(ampdbfs(kdbamp3))*(1-gkf3), aBPF4R*(ampdbfs(kdbamp4))*(1-gkf4), aBPF5R*(ampdbfs(kdbamp5))*(1-gkf5)

	aOutMixL	ntrpol	asigL, aMixL*gkgain, gkmix	;MIX BETWEEN DRY AND WET SIGNALS
	aOutMixR	ntrpol	asigR, aMixR*gkgain, gkmix	;MIX BETWEEN DRY AND WET SIGNALS

		outs	aOutMixL, aOutMixR				;SEND AUDIO TO OUTPUTS
endin

</CsInstruments>

<CsScore>
i 1  0 3600
</CsScore>

</CsoundSynthesizer>