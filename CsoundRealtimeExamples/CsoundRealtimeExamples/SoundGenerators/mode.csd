mode.csd
Written by Iain McCurdy, 2010. Updated 2011.

<CsoundSynthesizer>

<CsOptions>
;virtual midi device
-odac -M0 -+rtmidi=virtual -dm0

;external midi keyboard (recommended)
;-odac -Ma -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	512	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1

gisine		ftgen	0,0,4096,10,1
seed	0	;SEED RANDOM NUMBER GENERATORS FROM SYSTEM CLOCK

;FLTK INTERFACE CODE==============================================================================================================================================================
FLcolor	255, 255, 255, 0, 0, 0
;	LABEL     | WIDTH | HEIGHT | X | Y
FLpanel	"mode",      500,    760,    0,  0
	;TEXT BOXES(BLANK PANELS)		TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
	ih		 	FLbox  	"", 	6,       6,    14,     240,     140,   5,  210	;DOPPLER
	ih		 	FLbox  	"", 	6,       6,    14,     240,     140, 255,  210	;REVERB
	;SWITCHES                                			ON | OFF | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE | INS | STARTTIM | DUR
	gkDopOn,ihDopOn		FLbutton	"Doppler On/Off",	1,    0,   22,     120,     25,    10, 220,   -1
	gkMIDIsus,gihMIDIsus	FLbutton	"MIDI Sustain",		1,    0,   22,      90,     18,   305,  70,   -1
	FLsetTextSize	10, gihMIDIsus
	FLsetColor2	255, 255, 50, ihDopOn		;SET SECONDARY COLOUR TO YELLOW
	FLsetColor2	255, 255, 50, gihMIDIsus	;SET SECONDARY COLOUR TO YELLOW

	;VALUE DISPLAY BOXES					WIDTH | HEIGHT |  X  |  Y
	idbase			FLvalue	"",     		60,       20,     5,   130
	idQ			FLvalue	"",     		60,       20,     5,   180

	;VALUE INPUT BOXES						MIN | MAX | STEP | TYPE | WIDTH | HEIGHT |  X  | Y
	gkmodes, gihmodes		FLtext		"No. of Modes", 0,     50,    0,     1,   100,     25,     120,  35

	;MODAL FREQUENCY RATIO INPUT BOXES FOR USER DEFINABLE ALGORITHM (ALGORITHM 23)
#define	MODE_RATIO(N)
	#
	gkrto$N, ihrto$N		FLtext		"$N", 		0,     50,  0.01,     1,    38,     20,      ix, iy
	FLsetVal_i	$N, ihrto$N
	ix = ix + 38
	#
	iy = 680
	ix = 40
	$MODE_RATIO(1) 
	$MODE_RATIO(2) 
	$MODE_RATIO(3) 
	$MODE_RATIO(4) 
	$MODE_RATIO(5) 
	$MODE_RATIO(6) 
	$MODE_RATIO(7) 
	$MODE_RATIO(8) 
	$MODE_RATIO(9) 
	$MODE_RATIO(10)
	$MODE_RATIO(11)
	$MODE_RATIO(12)
	iy = iy + 40
	ix = 40
	$MODE_RATIO(13)
	$MODE_RATIO(14)
	$MODE_RATIO(15)
	$MODE_RATIO(16)
	$MODE_RATIO(17)
	$MODE_RATIO(18)
	$MODE_RATIO(19)
	$MODE_RATIO(20)
	$MODE_RATIO(21)
	$MODE_RATIO(22)
	$MODE_RATIO(23)
	$MODE_RATIO(24)

	;TEXT BOXES										TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
	ih		 	FLbox  	"User Definable Modal Ratios (Sound Algorithm 22)", 	1,       6,    12,    350,      20,   0,  660

	;TEXT BOXES     		TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
	gihSoundName FLbox "Single", 	1,      1,     14,    150,     25,   35, 5

	;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
				FLlabel		13,      4,      1,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)
	
	;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
	gkinput, ihinput		FLbutBank	14,     1,     3,     18,      60,   300,10,    0,      4,      0,       0
	
	;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
				FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

	;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
	ih		 	FLbox  	"Input:", 	1,       6,    14,     60,      20,  240,  10
	ih		 	FLbox  	"Impulses  ", 	1,       5,    14,     80,      20,  320,  10
	ih		 	FLbox  	"Pink Noise", 	1,       5,    14,     80,      20,  320,  30
	ih		 	FLbox  	"MIDI only ", 	1,       5,    14,     80,      20,  320,  50

	;SLIDERS				            			MIN  | MAX | EXP | TYPE |   DISP  | WIDTH | HEIGHT | X | Y
	gkbase, gihbase		FLslider 	"Base Frequency (Hertz)",	20,    5000,  -1,   23,   idbase,    490,    25,     5, 100
	gkQ, gihQ		FLslider 	"Q",				10,   10000,  -1,   23,   idQ,       490,    25,     5, 150
	gkImplsDur, ihImplsDur	FLslider 	"Impls.Dur.",			0.001,    1,   0,   23,   -1,         95,    10,   400,   0
	gkImplsMix, ihImplsMix	FLslider 	"Impls.Mix",			0,        5,   0,   23,   -1,         95,    10,   400,  20
	gkdensity, ihdensity	FLslider 	"Density",			0.0625,  10,   0,   23,   -1,         95,    10,   400,  40
	gkLPF, ihLPF		FLslider 	"LPF",			        20,   20000,  -1,   23,   -1,         95,    10,   400,  60
	gkHPF, ihHPF		FLslider 	"HPF",			        20,   20000,  -1,   23,   -1,         95,    10,   400,  80
	gkDopRate, ihDopRate	FLslider 	"Rate",				0,       10,   0,   23,   -1,        230,    15,    10, 250
	gkDopDep, ihDopDep	FLslider 	"Doppler Depth",		0.0001,0.005,  0,   23,   -1,        230,    15,    10, 280
	gkPanDep, ihPanDep	FLslider 	"Pan Depth",			0,      0.5,   0,   23,   -1,        230,    15,    10, 310
	gkRvbSnd, ihRvbSnd	FLslider 	"Reverb Send",			0,        1,   0,   23,   -1,        230,    15,   260, 220
	gkRvbSze, ihRvbSze	FLslider 	"Reverb Size",			0,        1,   0,   23,   -1,        230,    15,   260, 250
	gkOutGain, ihOutGain	FLslider 	"Output Gain",			0,        1,   0,   23,   -1,        490,    25,     5, 360
	FLsetTextSize	10, ihImplsDur
	FLsetTextSize	10, ihdensity
	FLsetTextSize	10, ihLPF
	FLsetTextSize	10, ihHPF
	FLsetTextSize	10, ihImplsMix
	
	;TEXT BOXES				TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
	ih		 	FLbox  	"Qs", 	1,       6,    14,     40,      20,   0,  490
	ih		 	FLbox  	"Amps", 1,       6,    14,     40,      20,   0,  610

#define	SLIDERS(N)
	#
	gkQ$N, gihQ$N		FLslider 	"$N",				0,   0.9999,   0,   24,   -1,         19,   100,    ix, 410
	gkAmp$N, gihAmp$N	FLslider 	"$N",				0,   0.9999,   0,   24,   -1,         19,   100,    ix, 530
	FLsetVal_i	0, gihQ$N
	FLsetVal_i	0, gihAmp$N
	ix = ix + 19
	#
	ix = 40
	$SLIDERS(1)
	$SLIDERS(2)
	$SLIDERS(3)
	$SLIDERS(4)
	$SLIDERS(5)
	$SLIDERS(6)
	$SLIDERS(7)
	$SLIDERS(8)
	$SLIDERS(9)
	$SLIDERS(10)
	$SLIDERS(11)
	$SLIDERS(12)
	$SLIDERS(13)
	$SLIDERS(14)
	$SLIDERS(15)
	$SLIDERS(16)
	$SLIDERS(17)
	$SLIDERS(18)
	$SLIDERS(19)
	$SLIDERS(20)
	$SLIDERS(21)
	$SLIDERS(22)
	$SLIDERS(23)
	$SLIDERS(24)

	;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE
	gksound, ihsound 			FLcount  "Sound", 	1,     23,     1,      1,      2,   100,     25,    5,  35,   -1
	
	;SET INITIAL VALUES
	FLsetVal_i	330, gihbase
	FLsetVal_i	2000, gihQ
	FLsetVal_i	5, ihsound
	FLsetVal_i	1, ihdensity
	FLsetVal_i	0.5, ihDopRate
	FLsetVal_i	0.0001, ihDopDep
	FLsetVal_i	0.1, ihPanDep
	FLsetVal_i	0.3, ihRvbSnd
	FLsetVal_i	0.8, ihRvbSze
	FLsetVal_i	0.5, ihOutGain
	FLsetVal_i	0.001, ihImplsDur
	FLsetVal_i	0, ihImplsMix
	FLsetVal_i	20000, ihLPF
	FLsetVal_i	20, ihHPF
	FLsetVal_i	1,gihMIDIsus
	
FLpanel_end
	;INSTRUCTIONS AND INFO PANEL
	FLpanel	" ", 500, 800, 512, 0
	;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
	ih		 	FLbox  	"                            mode                             ", 	1,      5,     14,    490,    20,     5,    0
	ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,   20
	ih		 	FLbox  	"Mode is a filtering opcode which is intended to be used as a ", 	1,      5,     14,    490,    20,     5,   40
	ih		 	FLbox  	"resonator for modal synthesis. An imitation of an acoustic   ", 	1,      5,     14,    490,    20,     5,   60
	ih		 	FLbox  	"sound will normally employ five or more instances of mode    ", 	1,      5,     14,    490,    20,     5,   80
	ih		 	FLbox  	"resonating at different frequencies to represent the         ", 	1,      5,     14,    490,    20,     5,  100
	ih		 	FLbox  	"different partials of the sound. In this example, as the user", 	1,      5,     14,    490,    20,     5,  120
	ih		 	FLbox  	"selects different presets using the counter, an instrument is", 	1,      5,     14,    490,    20,     5,  140
	ih		 	FLbox  	"is created with the appropriate number of mode resonators for", 	1,      5,     14,    490,    20,     5,  160
	ih		 	FLbox  	"that sound. The number of instances of mode employed is also ", 	1,      5,     14,    490,    20,     5,  180
	ih		 	FLbox  	"displayed. (For more information on coding dynamic iteration ", 	1,      5,     14,    490,    20,     5,  200
	ih		 	FLbox  	"of opcodes see Steven Yi's article 'Control Flow - Part II'  ", 	1,      5,     14,    490,    20,     5,  220
	ih		 	FLbox  	"in the summer 2006 issue of the Csound Journal.)             ", 	1,      5,     14,    490,    20,     5,  240
	ih		 	FLbox  	"The frequency ratios needed for each preset are stored in    ", 	1,      5,     14,    490,    20,     5,  260
	ih		 	FLbox  	"function tables. 'Q' or resonance of the resonators is       ", 	1,      5,     14,    490,    20,     5,  280
	ih		 	FLbox  	"controlled globally using a single slider but Q for each mode", 	1,      5,     14,    490,    20,     5,  300
	ih		 	FLbox  	"can also be scaled using the mini sliders. The base frequency", 	1,      5,     14,    490,    20,     5,  320
	ih		 	FLbox  	"to which all mode resonators relate is also controlled by a  ", 	1,      5,     14,    490,    20,     5,  340
	ih		 	FLbox  	"single slider.                                               ", 	1,      5,     14,    490,    20,     5,  360
	ih		 	FLbox  	"These resonators need to be agitated by some sort of         ", 	1,      5,     14,    490,    20,     5,  380
	ih		 	FLbox  	"excitation signal, in this example the first option          ", 	1,      5,     14,    490,    20,     5,  400
	ih		 	FLbox  	"'Impulses' sends an aleatoric stream of filtered clicks into ", 	1,      5,     14,    490,    20,     5,  420
	ih		 	FLbox  	"the resonators - this suggests that the object is being      ", 	1,      5,     14,    490,    20,     5,  440
	ih		 	FLbox  	"struck with a hard beater. If 'Impls.Dur' is increased, these", 	1,      5,     14,    490,    20,     5,  460
	ih		 	FLbox  	"clicks become noise impulses of increasing duaration. When   ", 	1,      5,     14,    490,    20,     5,  480
	ih		 	FLbox  	"using MIDI mode and when 'Impls.Dur' is maximum the impulse  ", 	1,      5,     14,    490,    20,     5,  500
	ih		 	FLbox  	"becomes sustained noise.                                     ", 	1,      5,     14,    490,    20,     5,  520
	ih		 	FLbox  	"The second option 'Pink Noise' imitates the object being     ", 	1,      5,     14,    490,    20,     5,  540
	ih		 	FLbox  	"blown or scraped. With imagination it is possible to imitate ", 	1,      5,     14,    490,    20,     5,  560
	ih		 	FLbox  	" the object being hit with softer beaters, being bowed etc.  ", 	1,      5,     14,    490,    20,     5,  580
	ih		 	FLbox  	"The density of the impulses can be varied using the 'Density'", 	1,      5,     14,    490,    20,     5,  600
	ih		 	FLbox  	"slider. The impulses and pink noise signals can be filtered  ", 	1,      5,     14,    490,    20,     5,  620
	ih		 	FLbox  	"before entering the resonators using the LPF (lowpass filter)", 	1,      5,     14,    490,    20,     5,  640
	ih		 	FLbox  	"and HPF (highpass filter) controls.                          ", 	1,      5,     14,    490,    20,     5,  660
	ih		 	FLbox  	"In MIDI mode the instrument responds to MIDI note, velocity  ", 	1,      5,     14,    490,    20,     5,  680
	ih		 	FLbox  	"and pitch bend. 'MIDI Sustain' imitates the action of a MIDI ", 	1,      5,     14,    490,    20,     5,  600
	ih		 	FLbox  	"sustain pedal.                                               ", 	1,      5,     14,    490,    20,     5,  600
	ih		 	FLbox  	"Additionally the sound can be processed through a doppler    ", 	1,      5,     14,    490,    20,     5,  620
	ih		 	FLbox  	"effect and a reverb.                                         ", 	1,      5,     14,    490,    20,     5,  640
	ih		 	FLbox  	"Most of the tables of modal frequencies have been taken from ", 	1,      5,     14,    490,    20,     5,  660
	ih		 	FLbox  	"the appendix of the Csound Manual.                           ", 	1,      5,     14,    490,    20,     5,  680
	ih		 	FLbox  	"As well as the global control of Q and amplitude for all     ", 	1,      5,     14,    490,    20,     5,  700
	ih		 	FLbox  	"modes in a sound algorithm, individual controls for each     ", 	1,      5,     14,    490,    20,     5,  720
	ih		 	FLbox  	"mode are also provided by the two banks of small vertical    ", 	1,      5,     14,    490,    20,     5,  740
	ih		 	FLbox  	"sliders. These act as multipliers (within the range 0-1) upon", 	1,      5,     14,    490,    20,     5,  760
	ih		 	FLbox  	"the global value. In the case of Q a value of zero is not    ", 	1,      5,     14,    490,    20,     5,  780
	ih		 	FLbox  	"allowed so the minimum is slightly above zero.               ", 	1,      5,     14,    490,    20,     5,  800
	ih		 	FLbox  	"Sound algorithm 23 is a user definable algorithm, the modal  ", 	1,      5,     14,    490,    20,     5,  820
	ih		 	FLbox  	"frequency ratios of which can be set by the two rows of value", 	1,      5,     14,    490,    20,     5,  840
	ih		 	FLbox  	"input boxes at the lower end of the GUI.                     ", 	1,      5,     14,    490,    20,     5,  860

FLpanel_end
FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE=======================================================================================================================================================

;FUNCTION TABLES STORING MODAL FREQUENCY RATIOS===================================================================================================================================
;single
girtos1		ftgen	0,0,2, -2,	1,1

;dahina
girtos2		ftgen	0,0,-6,-2,	1,	2.89,	4.95,	6.99,	8.01,	9.02

;banyan
girtos3		ftgen	0,0,-6,-2,	1, 	2.0, 	3.01, 	4.01, 	4.69, 	5.63

;xylophone
girtos4		ftgen	0,0,-6,-2,	1, 	3.932, 	9.538,	16.688,	24.566,	31.147

;tibetan bowl (180mm)
girtos5		ftgen	0,0,-7,-2,	1, 	2.77828,	5.18099, 	8.16289,	11.66063,	15.63801,	19.99

;spinel sphere with diameter of 3.6675mm
girtos6		ftgen	0,0,-24,-2,	1,	1.026513174725,	1.4224916858532,	1.4478690202098,	1.4661959580455,	1.499452545408,	1.7891839345101,	1.8768994627782,	1.9645945254541,	1.9786543873113,	2.0334612432847,	2.1452852391916,	2.1561524686621,	2.2533435661294,	2.2905090816065,	2.3331798413917,	2.4567715528268,	2.4925556408289,	2.5661806088514,	2.6055768738808,	2.6692760296751,	2.7140956766436,	2.7543617293425,	2.7710411870043 

;pot lid
girtos7		ftgen	0,0,-6,-2,	1, 	3.2, 	6.23, 	6.27, 	9.92, 	14.15

;red cedar wood plate
girtos8		ftgen	0,0,-4,-2,	1, 	1.47, 	2.09, 	2.56

;tubular bell
girtos9		ftgen	0,0,-10,-2,	272/437,	538/437,	874/437,	1281/437,	1755/437,	2264/437,	2813/437,	3389/437,	4822/437,	5255/437

;redwood wood plate
girtos10	ftgen	0,0,-4,-2,	1, 1.47, 2.11, 2.57

;douglas fir wood plate
girtos11	ftgen	0,0,-4,-2,	1, 1.42, 2.11, 2.47

;uniform wooden bar
girtos12	ftgen	0,0,-6,-2,	1, 2.572, 4.644, 6.984, 9.723, 12

;uniform aluminum bar
girtos13	ftgen	0,0,-6,-2,	1, 2.756, 5.423, 8.988, 13.448, 18.680

;vibraphone 1
girtos14	ftgen	0,0,-6,-2,	1, 3.984, 10.668, 17.979, 23.679, 33.642

;vibraphone 2
girtos15	ftgen	0,0,-6,-2,	1, 3.997, 9.469, 15.566, 20.863, 29.440

;Chalandi plates
girtos16	ftgen	0,0,-5,-2,	1, 1.72581, 5.80645, 7.41935, 13.91935

;tibetan bowl (152 mm)
girtos17	ftgen	0,0,-7,-2,	1, 2.66242, 4.83757, 7.51592, 10.64012, 14.21019, 18.14027

;tibetan bowl (140 mm)
girtos18	ftgen	0,0,-5,-2,	1, 2.76515, 5.12121, 7.80681, 10.78409

;wine glass
girtos19	ftgen	0,0,-5,-2,	1, 2.32, 4.25, 6.63, 9.38

;small handbell
girtos20	ftgen	0,0,-22,-2,	1, 1.0019054878049, 1.7936737804878, 1.8009908536585, 2.5201981707317, 2.5224085365854, 2.9907012195122, 2.9940548780488, 3.7855182926829, 3.8061737804878, 4.5689024390244, 4.5754573170732, 5.0296493902439, 5.0455030487805, 6.0759908536585, 5.9094512195122, 6.4124237804878, 6.4430640243902, 7.0826219512195, 7.0923780487805, 7.3188262195122, 7.5551829268293 

;albert clock bell belfast
girtos21	ftgen	0,0,-22,-2, 2.043260,1.482916,1.000000,3.328848,4.761811,1.477056,0.612007,2.661295,1.002793,4.023776,0.254139,2.043916,4.032463,2.659438,4.775560,5.500494,3.331014,0.809697,2.391301, 0.254098,1.901476,2.366563    ;,0.614968,2.046543,1.814887,3.130744,2.484426,0.558874,0.801697,0.070870,3.617036,2.782656

;wood block
girtos22	ftgen	0,0,4,-2,	915/915,1540/915,1863/915,3112/915

;user definable
girtos23	ftgen	0,0,-24,-2,	1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25


;TABLE OF SCALING FACTORS FOR INDIVIDUAL Q VALUES
giQs		ftgen	0,0,32,-2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1
;TABLE OF SCALING FACTORS FOR INDIVIDUAL AMP VALUES
giAmps		ftgen	0,0,32,-2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1

gisine		ftgen	0,0,131072,10,1		;A SINE WAVE
gidecay		ftgen	0,0,4096,16,1,4096,-8,0	;DECAY SHAPE FOR NOISE IMPULSES
gaRvbSndL	init	0	;REVERB SEND SIGNAL (LEFT CHANNEL)
gaRvbSndR	init	0	;REVERB SEND SIGNAL (RIGHT CHANNEL)

;=================================================================================================================================================================================

;TECHNIQUE OF ITERATION WITHIN A UDO WAS INSPIRED BY STEVEN YI'S ARTICLE IN SUMMER 2006 CSOUND JOURNAL
;USER DEFINED OPCODES=============================================================================================================================================================

opcode modemodule, a, akkiii						;MODE UDO (K-RATE BASE FREQUENCY) - USED FOR NON-MIDI MODE 
	ain, kbase, kGlobalQ, icount, ialgfn, imodes  xin		;NAME INPUT VARIABLES
	krto	table	icount-1, ialgfn				;READ FREQUENCY RATIO FOR CURRENT MODE ACCORDING TO ITERATION COUNTER
	kfrq	=	krto * kbase					;DERIVE MODAL FREQUENCY FROM PRODUCT OF RATIO AND BASE FREQUENCY
	amix	init	0
	asig	init	0
	if sr/kfrq>=$M_PI then						;LIMIT MODAL FREQUENCY UPPER LIMIT TO PREVENT EXPLOSIONS BY SKIPPING CODE IF MAXIMUM VALUE IS EXCEEDED (WITH A LITTLE HEADROOM)
	 kLocalQ	table	icount-1, giQs
	 kAmp	table	icount-1, giAmps
	 asig	mode	ain, kfrq, kGlobalQ*kLocalQ			;CREATE MODE SIGNAL
	 icount	=	icount + 1					;INCREMENT COUNTER IN PREPARTION FOR NEXT MODE
	 if	icount <= imodes	then				;IF ALL THE MODES IN THIS CURRENT INSTRUMENT HAVE NOT YET BEEN CREATED...
	 amix	modemodule	ain, kbase, kGlobalQ, icount, ialgfn, imodes	;...CALL modemodule UDO AGAIN WITH INCREMENTED COUNTER
	 endif								;END OF CONDITIONAL BRANCHING
	endif
		xout	(asig*kAmp) + amix				;SEND ALL AUDIO BACK TO CALLER INSTRUMENT
endop									;END OF UDO

opcode dopplerUDO, aa, akkk						;DOPPLER UDO
	ain, krate, kDopDep, kPanDep  xin				;NAME INPUT VARIABLES
	setksmps	1						;CONTROL RATE WITHIN UDO IS 1
	ioffset	init	ksmps/sr					;DELAY OFFSET TIME
	adlt	oscil	kDopDep,krate,gisine				;MODULATING DELAY TIME
	kpan	oscil	kPanDep,krate,gisine				;MODULATING PANNING VARIABLE
	abuf	delayr	(0.01)+ioffset					;SET FOR MAXIMUM POSSIBLE DELAY TIME
	atap	deltap3	adlt+kDopDep+ioffset				;TAP THE DELAY BUFFER
		delayw	ain						;WRITE AUDIO INTO DELAY BUFFER
	a1,a2	pan2	atap, kpan + 0.5 + kPanDep			;PAN AUDIO FROM DELAY TAP
		xout	a1, a2						;SEND AUDIO TO CALLER INSTRUMENT
endop									;END OF UDO

;=================================================================================================================================================================================









opcode	FreqShifterSimple,a,aki					; SIMPLE FREQUENCY SHIFTER
	asig,kfshift,ifn	xin				; READ IN INPUT ARGUMENTS
	areal, aimag hilbert asig				; HILBERT OPCODE OUTPUTS TWO PHASE SHIFTED SIGNALS, EACH 90 OUT OF PHASE WITH EACH OTHER
	asin 	oscili       1,    kfshift,     ifn,          0
	acos 	oscili       1,    kfshift,     ifn,          0.25	
	;RING MODULATE EACH SIGNAL USING THE QUADRATURE OSCILLATORS AS MODULATORS
	amod1	=		areal * acos
	amod2	=		aimag * asin	
	;UPSHIFTING OUTPUT
	ares	= (amod1 - amod2)				; MIX OUTPUTS (INVERTED WITH RESPECT TO EACH OTHER)
		xout	ares					; SEND AUDIO BACK TO CALLER INSTRUMENT
endop













instr	1	;MIDI ACTIVATED INSTRUMENT
	icps	cpsmidi					;READ IN MIDI PITCH IN CYCLES PER SECOND
	ivel	veloc	6,13				;READ IN MIDI NOTE VELOCITY. RE-RANGE TO LIE BETWEEN 8 AND 13: THIS WILL BE USED TO CONTROL A FILTER CUTOFF IN OCT FORMAT.

	if i(gkMIDIsus)==0||i(gkImplsDur)==1 then	;NO SUSTAIN UPON KEY RELEASE OR A SUSTAINED INPUT SOUND SELECTED
	 aL,aR	subinstr	3,icps,ivel		;CALL INSTR 3 AS A SUB-INSTRUMENT. INSTRUMENT 3 WILL RECEIVE INSTRUMENT 1'S RELEASE INSTRUCTION
	 aenv	linsegr	1,0.1,0				;CREATE A SHORT RELEASE ENVELOPE	 
	 aL	=	aL * aenv
	 aR	=	aR * aenv
	  	outs	aL,aR				;SEND AUDIO RECEIVED BACK FROM INSTRUMENT 3 TO THE OUTPUTS
	else						;SUSTAIN NOTE UPON KEY RELEASE
		event_i	"i",4,0,300,icps,ivel		;TRIGGER A LONG NOTE IN INSTR 4. IT WILL TURN ITSELF OFF WHEN ITS SOUND HAS DECAYED TO AN INAUDIBLE LEVEL
	endif						;END OF NESTED CONDITIONAL BRANCH
endin

instr	2	;SCAN PITCH BEND
	kstatus, kchan, kdata1, kdata2 midiin			;SCAN ALL MIDI DATA INPUT
	iPBrange	=	2				;PITCH BEND RANGE IN SEMITONES
	if kstatus==224 then					;IF MIDI EVENT IS A PITCH BEND EVENT... 
	  kbend	=	((kdata2 - 64) / 32)*iPBrange		;...CREATE A NEW PITCH BEND VALUE
	endif
	gkbend	port	kbend,0.01				;SMOOTH PITCH BEND CHANGES
endin

instr	3	;TRIGGERED FROM INSTRUMENT 1 AS A SUB INSTRUMENT USING subinstr (NON-SUSTAINING MIDI MODE)
	if i(gkImplsDur)==0.001 then				;IF IMPULSE DURATION SLIDER IS AT MINIMUM JUST USE A SINGLE CLICK IMPULSE
	  apulse	mpulse 1, 0				;CLICK IMPULSE
	elseif	i(gkImplsDur)==1 then				;IF IMPULSE DURATION SLIDER IS AT MAXIMUM USE SUSTAINED NOISE
	  apulse	noise	0.05,0				;CREATE A NOISE IMPULSE
	else							;OTHERWISE...
	  aenv	osciln	0.05, 1/i(gkImplsDur), gidecay, 1	;DECAY ENVELOPE FOR NOISE INPULSE
	  apulse	noise	aenv,0				;CREATE A NOISE IMPULSE
	endif							;END OF CONDITIONAL IF/ELSE...
	apulse	butlp	apulse,cpsoct(p5)			;FILTER STRIKE IMPULSE ACCORDING TO NOTE VELOCITY (VIA P5 FROM INSTR 1)
		outs	apulse*i(gkImplsMix),apulse*i(gkImplsMix)	;SEND SOME OF THE DRY IMPULSE SIGNAL TO THE OUTPUTS

	ibase	=	p4					;BASE FREQUENCY FOR MODE RESONATORS DERIVED FROM MIDI NOTE NUMBER VIA p4 FROM INSTR 1
	ialgfn	init	girtos1+i(gksound) - 1			;MODAL ALGORITHM FUNCTION TABLE NUMBER
	imodes	init	ftlen(ialgfn)				;FIND THE NUMBER OF MODES IN CURRENT INSTRUMENT FROM FUNCTION TABLE
	
	kbase	=	ibase * semitone(gkbend)		;COMBINE BASE PITCH AND PITCH BEND TO CREATE A CPS VALUE FOR FUNDEMENTAL FREQUENCY FOR THE MODE FILTER STACK
	icount	init	1					;INITIALIZE COUNTER USED INB COUNTING OUT THE REQUIRED NUMBER OF MODES
	aout	modemodule	apulse, kbase, gkQ, icount, ialgfn, imodes	;CALL modemodule USER DEFINED OPCODE
	aout	=	(aout*gkOutGain)/(imodes)
	if	gkDopOn=1	then				;IF 'Doppler' SWITCH IS 'ON'... 
		a1,a2	dopplerUDO	aout, gkDopRate, gkDopDep, gkPanDep	;CALL 'dopplerUDO' UDO
		outs	a1,a2					;SEND AUDIO TO OUTPUTS                                                
		gaRvbSndL	=	gaRvbSndL + (a1*gkRvbSnd)	;ADD SOME SIGNAL TO THE REVERB SEND GLOBAL AUDIO VARIABLE (LEFT CHANNEL)
		gaRvbSndR	=	gaRvbSndR + (a2*gkRvbSnd)	;ADD SOME SIGNAL TO THE REVERB SEND GLOBAL AUDIO VARIABLE (RIGHT CHANNEL)
	else                                                    ;OTHERWISE...                                                         
		outs	aout, aout                              ;SEND AUDIO TO OUTPUTS
		gaRvbSndL	=	gaRvbSndL + (aout*gkRvbSnd)	;ADD SOME SIGNAL TO THE REVERB SEND GLOBAL AUDIO VARIABLE (LEFT CHANNEL)
		gaRvbSndR	=	gaRvbSndR + (aout*gkRvbSnd)	;ADD SOME SIGNAL TO THE REVERB SEND GLOBAL AUDIO VARIABLE (RIGHT CHANNEL)
	endif		                                        ;END OF CONDITIONAL BRANCH
	apulse	=	0					;CLEAR IMPULSE AUDIO SIGNAL
endin


instr	4	;TRIGGERED FROM INSTRUMENT 1 USING event_i (SUSTAINING MIDI MODE)
	if i(gkImplsDur)==0.001 then				;IF IMPULSE DURATION SLIDER IS AT MINIMUM JUST USE A SINGLE CLICK IMPULSE
	  apulse	mpulse 1, 0				;CLICK IMPULSE
	else							;OTHERWISE...
	  aenv	osciln	0.05, 1/i(gkImplsDur), gidecay, 1	;DECAY ENVELOPE FOR NOISE INPULSE
	  apulse	noise	aenv,0				;CREATE A NOISE IMPULSE
	endif							;END OF CONDITIONAL IF/ELSE...
	apulse	butlp	apulse,cpsoct(p5)			;FILTER STRIKE IMPULSE ACCORDING TO NOTE VELOCITY (VIA P5 FROM INSTR 1)
		outs	apulse*i(gkImplsMix),apulse*i(gkImplsMix)	;SEND SOME OF THE DRY IMPULSE SIGNAL TO THE OUTPUTS

	ibase	=	p4					;BASE FREQUENCY FOR MODE RESONATORS DERIVED FROM MIDI NOTE NUMBER VIA p4 FROM INSTR 1
	ialgfn	init	girtos1+i(gksound) - 1			;MODAL ALGORITHM FUNCTION TABLE NUMBER
	imodes	init	ftlen(ialgfn)				;FIND THE NUMBER OF MODES IN CURRENT INSTRUMENT FROM FUNCTION TABLE
	
	kbase	=	ibase * semitone(gkbend)		;COMBINE BASE PITCH AND PITCH BEND TO CREATE A CPS VALUE FOR FUNDEMENTAL FREQUENCY FOR THE MODE FILTER STACK
	icount	init	1					;INITIALIZE COUNTER USED INB COUNTING OUT THE REQUIRED NUMBER OF MODES
	aout	modemodule	apulse, kbase, gkQ, icount, ialgfn, imodes	;CALL modemodule USER DEFINED OPCODE
	aout	=	(aout*gkOutGain)/(imodes)

	timout	0, 0.2, skip					;TO PREVENT LOSING NOTES ALTOGETHER SKIP AMPLITUDE TESTING FOR THE FIRST 0.2 OF A SECOND
	;WHEN AMPLITUDE DROPS BENEATH A VERY LOW LEVEL, TURN THIS INSTRUMENT OFF
	krms	rms	aout					;CREATE AN RMS VALUE OF AUDIO SIGNAL
	if	krms<0.0001 then				;IF RMS IS BENEATH 1/10000 OF MAXIMUM AMPLITUDE...
		turnoff						;TURN THIS INSTRUMENT OFF
	endif
	skip:

	if	gkDopOn=1	then				;IF 'Doppler' SWITCH IS 'ON'... 
		a1,a2	dopplerUDO	aout, gkDopRate, gkDopDep, gkPanDep	;CALL 'dopplerUDO' UDO
		outs	a1,a2					;SEND AUDIO TO OUTPUTS                                                
		gaRvbSndL	=	gaRvbSndL + (a1*gkRvbSnd)	;ADD SOME SIGNAL TO THE REVERB SEND GLOBAL AUDIO VARIABLE (LEFT CHANNEL)
		gaRvbSndR	=	gaRvbSndR + (a2*gkRvbSnd)	;ADD SOME SIGNAL TO THE REVERB SEND GLOBAL AUDIO VARIABLE (RIGHT CHANNEL)
	else                                                    ;OTHERWISE...                                                         
		outs	aout, aout                              ;SEND AUDIO TO OUTPUTS                                                
		gaRvbSndL	=	gaRvbSndL + (aout*gkRvbSnd)	;ADD SOME SIGNAL TO THE REVERB SEND GLOBAL AUDIO VARIABLE (LEFT CHANNEL)
		gaRvbSndR	=	gaRvbSndR + (aout*gkRvbSnd)	;ADD SOME SIGNAL TO THE REVERB SEND GLOBAL AUDIO VARIABLE (RIGHT CHANNEL)
	endif		                                        ;END OF CONDITIONAL BRANCH
	apulse	=	0					;CLEAR IMPULSE AUDIO SIGNAL
endin

instr	5							;TURNS INSTR 6 ON AND OFF ACCORDINGLY
	if i(gkinput)!=2 then					;IF INPUT IS *NOT* 'MIDI ONLY'...
	 event_i	"i",6,0,-1				;TURN INSTR 6 ON
	else							;OTHERWISE (INPUT IS MIDI)
	 event_i	"i",-6,0,0				;TURN INSTR 6 OFF
	endif							;END OF IF/ELSE BRANCHING
endin

instr	6	;FLTK MODE INSTRUMENT
	kporttime	linseg	0,0.01,0.01			;CREATE A RAMPING UP ENVELOPE
	if gkinput==0	then					;IF 'IMPULSE' INPUT HAS BEEN CHOSEN... 
	 ;GENERATE AN IMPULSE SIGNAL===============================================================================================================================================
	 kintvl	random	0.05, 0.3			;RANDOMISED INTERVAL BETWEEN STRIKES
	 apulse	mpulse	1, kintvl/gkdensity		;STRIKE IMPULSE
	 if gkImplsDur>0.001 then			;IF IMPULSE DURATION IS GREATER THAT MINIMUM SETTING
	  kTrigRate	random	0.05, 0.3		;RATE OF TRIGGER
	  ktrig	metro	gkdensity/kTrigRate		;TRIGGER FOR REINITIALISATION OF ENVELOPE
	  if ktrig==1 then				;IF TRIGGER IS '1'
	   reinit	RestartImpulse			;BEGIN A REINITIALISATION PASS FROM LABEL 'RestartImpulse'
	  endif						;
	  RestartImpulse:				;BEGIN REINIT FROM HERE
	  aenv	osciln	0.05, 1/i(gkImplsDur), gidecay,1;DECAY ENVELOPE FOR NOISE INPULSE
	  rireturn					;RETURN FROM REINITIALISATION PASS
	  apulse	noise	aenv,0			;CREATE A NOISE IMPULSE
	 endif
	 kcfoct	randomi	4,12,5				;RANDOMIZE CUTOFF FREQUENCY FOR FILTERING STRIKE IMPULSE
	 kcfcps	limit	cpsoct(kcfoct),gkHPF,gkLPF
	 apulse	butlp	apulse,kcfcps		;FILTER STRIKE IMPULSE
	;=========================================================================================================================================================================
	elseif gkinput==1	then
	 apulse	pinkish	0.1				;A PINK NOISE SIGNAL
	 kLPF	portk	gkLPF, kporttime		;SMOOTH FLTK SLIDER VARIABLE
	 kHPF	portk	gkHPF, kporttime		;SMOOTH FLTK SLIDER VARIABLE
	 apulse	butlp	apulse, kLPF			;APPLY FILTER TO PINK NOISE SIGNAL
	 apulse	buthp	apulse, kHPF			;APPLY FILTER TO PINK NOISE SIGNAL
	endif
		outs	apulse*gkImplsMix,apulse*gkImplsMix	;SEND SOME OF THE DRY IMPULSE SIGNAL TO THE OUTPUTS
	
	kbase	portk	gkbase, kporttime			;APPLY PORTAMENTO SMOOTHING TO FLTK SLIDER VARIABLE
	kbase	init	i(gkbase)
	ktrig	changed	gksound					;IF SOUND CHOICE CHANGES GENERATE A MOMENTARY '1' (BANG)
	if	ktrig=1	then					;IF A TRIGGER HAS BEEN GENERATED...
		reinit	RESTART					;BEGIN A REINITIALIZATION PASS FROM LABEL RESTART
	endif							;END OF CONDITIONAL BRANCHING
	RESTART:						;LABEL 'RESTART'
	ialgfn	=	girtos1+i(gksound) - 1			;MODAL ALGORITHM FUNCTION TABLE NUMBER
	imodes	=	ftlen(ialgfn)				;FIND THE NUMBER OF MODES IN CURRENT INSTRUMENT FROM FUNCTION TABLE
	FLsetVal_i	imodes, gihmodes			;UPDATE DISPLAY OF NUMBER OF MODES
	icount	=	1					;INITIALIZE COUNTER USED INB COUNTING OUT THE REQUIRED NUMBER OF MODES
	aout	modemodule	apulse, kbase, gkQ, icount, ialgfn, imodes	;CALL modemodule USER DEFINED OPCODE
	aout	=	(aout * gkOutGain) / imodes		;RESCALE AMPLITUDE OF AUDIO SIGNAL ACCORDING TO NUMBER OF MODES PRESENT AND RESCALE ALSO ACCORDING TO 'Output Gain' SLIDER





	aFS	FreqShifterSimple	aout,kbase*1.7,gisine
	aout	+=			aFS



	rireturn						;RETURN FROM REINITIALIZATION PASS
	if	gkDopOn=1	then				;IF 'Doppler' SWITCH IS 'ON'...                                       
		a1,a2	dopplerUDO	aout, gkDopRate, gkDopDep, gkPanDep	;CALL 'dopplerUDO' UDO                                           
		outs	a1,a2					;SEND AUDIO TO OUTPUTS                                                
		gaRvbSndL	=	gaRvbSndL + (a1*gkRvbSnd)	;ADD SOME SIGNAL TO THE REVERB SEND GLOBAL AUDIO VARIABLE (LEFT CHANNEL)
		gaRvbSndR	=	gaRvbSndR + (a2*gkRvbSnd)	;ADD SOME SIGNAL TO THE REVERB SEND GLOBAL AUDIO VARIABLE (RIGHT CHANNEL)
	else							;OTHERWISE...                                                         
		outs	aout, aout				;SEND AUDIO TO OUTPUTS                                                
		gaRvbSndL	=	gaRvbSndL + (aout*gkRvbSnd)	;ADD SOME SIGNAL TO THE REVERB SEND GLOBAL AUDIO VARIABLE (LEFT CHANNEL)
		gaRvbSndR	=	gaRvbSndR + (aout*gkRvbSnd)	;ADD SOME SIGNAL TO THE REVERB SEND GLOBAL AUDIO VARIABLE (RIGHT CHANNEL)
	endif							;END OF CONDITIONAL BRANCH                                            
	apulse	=	0					;CLEAR IMPULSE AUDIO SIGNAL
endin

instr	99	;WRITE VALUES TO TABLES
	;DEFINE MACRO CONTAINING CODE FOR WRITING FLTK VARIABLES INTO TABLE 
#define	WRITE_TO_TABLE(N)
	#
	tablew	1 - gkQ$N, $N-1, giQs		;WRITE FLTK SLIDER VARIABLE INTO TABLE
	tablew	1 - gkAmp$N, $N-1, giAmps	;WRITE FLTK SLIDER VARIABLE INTO TABLE
	tablew	gkrto$N, $N-1, girtos23		;WRITE FLTK SLIDER VARIABLE INTO TABLE
	#
	$WRITE_TO_TABLE(1) 
	$WRITE_TO_TABLE(2) 
	$WRITE_TO_TABLE(3) 
	$WRITE_TO_TABLE(4) 
	$WRITE_TO_TABLE(5) 
	$WRITE_TO_TABLE(6) 
	$WRITE_TO_TABLE(7) 
	$WRITE_TO_TABLE(8) 
	$WRITE_TO_TABLE(9) 
	$WRITE_TO_TABLE(10)
	$WRITE_TO_TABLE(11)
	$WRITE_TO_TABLE(12)
	$WRITE_TO_TABLE(13)
	$WRITE_TO_TABLE(14)
	$WRITE_TO_TABLE(15)
	$WRITE_TO_TABLE(16)
	$WRITE_TO_TABLE(17)
	$WRITE_TO_TABLE(18)
	$WRITE_TO_TABLE(19)
	$WRITE_TO_TABLE(20)
	$WRITE_TO_TABLE(21)
	$WRITE_TO_TABLE(22)
	$WRITE_TO_TABLE(23)
	$WRITE_TO_TABLE(24)
endin

instr	100
	ktrig	changed	gksound		;IF SOUND CHOICE CHANGES GENERATE A MOMENTARY '1' (BANG)
	if	ktrig=1	then		;IF A TRIGGER HAS BEEN GENERATED...
		reinit	RESTART		;BEGIN A REINITIALIZATION PASS FROM LABEL RESTART
	endif				;END OF CONDITIONAL BRANCHING
	RESTART:			;LABEL 'RESTART'
	
#define	Init1QandAmp(N)
	#
	FLsetVal_i	0,gihQ$N
	FLsetVal_i	0,gihAmp$N
	#
	
#define	InitAllQandAmp
	#
	$Init1QandAmp(1)
	$Init1QandAmp(2)
	$Init1QandAmp(3)
	$Init1QandAmp(4)
	$Init1QandAmp(5)
	$Init1QandAmp(6)
	$Init1QandAmp(7)
	$Init1QandAmp(8)
	$Init1QandAmp(9)
	$Init1QandAmp(10)
	$Init1QandAmp(11)
	$Init1QandAmp(12)
	$Init1QandAmp(13)
	$Init1QandAmp(14)
	$Init1QandAmp(15)
	$Init1QandAmp(16)
	$Init1QandAmp(17)
	$Init1QandAmp(18)
	$Init1QandAmp(19)
	$Init1QandAmp(20)
	$Init1QandAmp(21)
	$Init1QandAmp(22)
	$Init1QandAmp(23)
	$Init1QandAmp(24)
	#

	;UPDATE ALGORITHM NAME=================================================================================================================================================
	if	i(gksound)==1	then
		FLsetText "Single", gihSoundName
		FLsetVal_i	330, gihbase
		FLsetVal_i	1000, gihQ
		$InitAllQandAmp
	elseif	i(gksound)==2	then
		FLsetText "Dahina", gihSoundName
		FLsetVal_i	150, gihbase
		FLsetVal_i	50, gihQ
		$InitAllQandAmp
	elseif	i(gksound)==3	then
		FLsetText "Banyan", gihSoundName
		FLsetVal_i	350, gihbase
		FLsetVal_i	444, gihQ
		$InitAllQandAmp
	elseif	i(gksound)==4	then
		FLsetText "Xylophone", gihSoundName
		FLsetVal_i	160, gihbase
		FLsetVal_i	200, gihQ
		$InitAllQandAmp
	elseif	i(gksound)==5	then
		FLsetText "Tibetan Bowl (180mm)", gihSoundName
		FLsetVal_i	221, gihbase
		FLsetVal_i	2200, gihQ
		$InitAllQandAmp
	elseif	i(gksound)==6	then
		FLsetText "Spinel Sphere", gihSoundName
		FLsetVal_i	997.25, gihbase
		FLsetVal_i	80, gihQ
		$InitAllQandAmp
	elseif	i(gksound)==7	then
		FLsetText "Pot Lid", gihSoundName
		FLsetVal_i	250, gihbase
		FLsetVal_i	1500, gihQ
		$InitAllQandAmp
	elseif	i(gksound)==8	then
		FLsetText "Red Cedar Wood Plate", gihSoundName
		FLsetVal_i	700, gihbase
		FLsetVal_i	100, gihQ
		$InitAllQandAmp
	elseif	i(gksound)==9	then
		FLsetText "Tubular Bell", gihSoundName
		FLsetVal_i	437, gihbase
		FLsetVal_i	2000, gihQ
		$InitAllQandAmp
	elseif	i(gksound)==10	then
		FLsetText "Redwood Wood Plate", gihSoundName
		FLsetVal_i	1000, gihbase
		FLsetVal_i	100, gihQ
		$InitAllQandAmp
	elseif	i(gksound)==11	then
		FLsetText "Douglas Fir Wood Plate", gihSoundName
		FLsetVal_i	1200, gihbase
		FLsetVal_i	150, gihQ
		$InitAllQandAmp
	elseif	i(gksound)==12	then
		FLsetText "Uniform Wooden Bar", gihSoundName
		FLsetVal_i	700, gihbase
		FLsetVal_i	300, gihQ
		$InitAllQandAmp
	elseif	i(gksound)==13	then
		FLsetText "Uniform Aluminium Bar", gihSoundName
		FLsetVal_i	327, gihbase
		FLsetVal_i	1000, gihQ
		$InitAllQandAmp
	elseif	i(gksound)==14	then
		FLsetText "Vibraphone 1", gihSoundName
		FLsetVal_i	440, gihbase
		FLsetVal_i	2000, gihQ
		$InitAllQandAmp
	elseif	i(gksound)==15	then
		FLsetText "Vibraphone 2", gihSoundName
		FLsetVal_i	440, gihbase
		FLsetVal_i	2000, gihQ
		$InitAllQandAmp
	elseif	i(gksound)==16	then
		FLsetText "Chalandi Plates", gihSoundName
		FLsetVal_i	62, gihbase
		FLsetVal_i	500, gihQ
		$InitAllQandAmp
	elseif	i(gksound)==17	then
		FLsetText "Tibetan Bowl (152mm)", gihSoundName
		FLsetVal_i	314, gihbase
		FLsetVal_i	2200, gihQ
		$InitAllQandAmp
	elseif	i(gksound)==18	then
		FLsetText "Tibetan Bowl (140mm)", gihSoundName
		FLsetVal_i	528, gihbase
		FLsetVal_i	2200, gihQ
		$InitAllQandAmp
	elseif	i(gksound)==19	then
		FLsetText "Wine Glass", gihSoundName
		FLsetVal_i	980, gihbase
		FLsetVal_i	1500, gihQ
		$InitAllQandAmp
	elseif	i(gksound)==20	then
		FLsetText "Small Hand Bell", gihSoundName
		FLsetVal_i	1312, gihbase
		FLsetVal_i	2500, gihQ
		$InitAllQandAmp
	elseif	i(gksound)==21	then
		FLsetText "Albert Clock Bell", gihSoundName
		FLsetVal_i	570, gihbase
		FLsetVal_i	2400, gihQ
		$InitAllQandAmp
	elseif	i(gksound)==22	then
		FLsetText "Wood Block", gihSoundName
		FLsetVal_i	915, gihbase
		FLsetVal_i	60, gihQ
		FLsetVal_i	1-1, gihQ1
		FLsetVal_i	1-0.5, gihQ2
		FLsetVal_i	1-0.4, gihQ3
		FLsetVal_i	1-0.3, gihQ4
		FLsetVal_i	1-1, gihAmp1
		FLsetVal_i	1-0.1, gihAmp2
		FLsetVal_i	1-0.1, gihAmp3
		FLsetVal_i	1-0.3, gihAmp4		
	elseif	i(gksound)==23	then
		FLsetText "User", gihSoundName
		$InitAllQandAmp
	endif
	;======================================================================================================================================================================
endin

instr	1000	;REVERB	
	arvbL, arvbR 	reverbsc gaRvbSndL, gaRvbSndL, gkRvbSze, 10000	;CREATE REVERBERATED SIGNAL (USING UDO DEFINED ABOVE)
			outs	arvbL, arvbR			;SEND AUDIO TO OUTPUTS
			clear	gaRvbSndL,gaRvbSndR		;CLEAR GLOBAL AUDIO SEND VARIABLES
endin

</CsInstruments>

<CsScore>
i 2 0 3600	;SCAN PITCH BEND
i 99 0 3600	;UPDATE FUNCTION TABLES FOR INDIVIDUAL Q CONTROL AND AMPLITUDE CONTROL
i 100 0 3600	;UPDATE SOUND DESCRIPTION AND PRESET VALUES
i 6 0 3600	;MODE RESONATORS INSTRUMENT (CALLS A UDO MULTIPLE TIMES ACCORDING TO THE NUMBER OF MODES IN THE SELECTED MODE ALGORITHM)
i 1000 0 3600	;REVERB
</CsScore>

</CsoundSynthesizer>