<CsoundSynthesizer>

<CsOptions>
-odac -M0 -+rtmidi=virtual -dm0
;DISABLE VIRTUAL MIDI FOR EXTERNAL MIDI CONTROL
</CsOptions>

<CsInstruments>
sr 	= 	44100
ksmps 	= 	10
nchnls 	= 	2
0dbfs	=	1	;MAXIMUM SOUND INTENSITY LEVEL

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
FLpanel	"Additive Synthesis Spectrum Sketching", 1300, 800, 0, 0

;SWITCHES                                            				ON | OFF | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE | INS | STARTTIM | DUR	p4	p5	p6	p7	p8	p9	p10	p11	p12	p13	p14	p15	p16	p17	p18	p19	p20	p21	p22	p23	p24	p25	p26	p27	p28	p29	p30	p31	p32	p33
gkFLTK_MIDI,ihFLTK_MIDI		FLbutton	"ON (FLTK) / OFF (MIDI)",	1,    0,    22,    340,    130,   900, 660,    0,      3,      0,     3600
FLsetColor2	255, 255, 50, ihFLTK_MIDI	;SET SECONDARY COLOUR TO YELLOW

ix	=	50

;XY PANELS				MINX | MAXX | MINY | MAXY | EXPX | EXPY | DISPX | DISPY | WIDTH | HEIGHT | X | Y
gkx, gky, ihx, ihy	FLjoy	"",	0,      30,    1,     0,      0,    0,     -1,     -1,   1200,    300,    ix,  0

;SLIDERS											MIN | MAX | EXP | TYPE | DISP  | WIDTH | HEIGHT | X | Y
iwidth	=	40
itype	=	2
iRatio	=	1

;COLOURS
iblue	=	250
ired	=	0
#define	FLTK_FOR_PARTIAL(COUNT) 
#
FLcolor	255,255,iblue, ired, 255,255
gkPartAmp$COUNT,  gihPartAmp$COUNT	FLslider 	"$COUNT",0,    1,    0,  itype,    -1,   iwidth,    245,   ix, 300
gkRatio$COUNT, gihRatio$COUNT		FLtext		"",     .125, 20,  .01,  1,              iwidth,     20,   ix, 560
FLsetVal_i	1, 	gihPartAmp$COUNT
FLsetVal_i	iRatio, gihRatio$COUNT 
iRatio	=	iRatio + 1
iblue=iblue-8
ired=ired+8
ix	=	ix+iwidth
#

$FLTK_FOR_PARTIAL(1)
$FLTK_FOR_PARTIAL(2)
$FLTK_FOR_PARTIAL(3)
$FLTK_FOR_PARTIAL(4)
$FLTK_FOR_PARTIAL(5)
$FLTK_FOR_PARTIAL(6)
$FLTK_FOR_PARTIAL(7)
$FLTK_FOR_PARTIAL(8)
$FLTK_FOR_PARTIAL(9)
$FLTK_FOR_PARTIAL(10)
$FLTK_FOR_PARTIAL(11)
$FLTK_FOR_PARTIAL(12)
$FLTK_FOR_PARTIAL(13)
$FLTK_FOR_PARTIAL(14)
$FLTK_FOR_PARTIAL(15)
$FLTK_FOR_PARTIAL(16)
$FLTK_FOR_PARTIAL(17)
$FLTK_FOR_PARTIAL(18)
$FLTK_FOR_PARTIAL(19)
$FLTK_FOR_PARTIAL(20)
$FLTK_FOR_PARTIAL(21)
$FLTK_FOR_PARTIAL(22)
$FLTK_FOR_PARTIAL(23)
$FLTK_FOR_PARTIAL(24)
$FLTK_FOR_PARTIAL(25)
$FLTK_FOR_PARTIAL(26)
$FLTK_FOR_PARTIAL(27)
$FLTK_FOR_PARTIAL(28)
$FLTK_FOR_PARTIAL(29)
$FLTK_FOR_PARTIAL(30)

FLcolor	255, 255, 255, 0, 0, 0

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Freq. Ratios",	1,       5,    12,     50,     30,   0,  560

;VALUE DISPLAY BOXES					WIDTH | HEIGHT | X |  Y
idamp				FLvalue	" ",     	60,       20,   55,  625
idFundFrq			FLvalue	" ",     	60,       20,   55,  675
idAmpPort			FLvalue	" ",     	60,       20,   55,  725 
idRatiosPort			FLvalue	" ",     	60,       20,   55,  750 

;SLIDERS				            					MIN  | MAX  | EXP | TYPE |   DISP      | WIDTH | HEIGHT | X  | Y
gkamp, ihamp			FLslider 	"Amplitude",				0,        1,   0,    23,   idamp,         490,     25,    55, 600
gkFundFrq, ihFundFrq		FLslider 	"Fundemental Frequency",		4,     8000,  -1,    23,   idFundFrq,     490,     25,    55, 650
gkAmpPort, ihAmpPort		FLslider 	"Amplitude/Fundemental Portamento",	0.01,     5,  -1,    23,   idAmpPort,     490,     25,    55, 700
gkRatiosPort, ihRatiosPort	FLslider 	"Ratios Portamento",			0.01,    20,  -1,    23,   idRatiosPort,  490,     25,    55, 750
gkAttTim, ihAttTim		FLslider 	"Attack Time",				0.001,    4,   0,    23,   -1,            125,     15,   600, 670
gkRelTim, ihRelTim		FLslider 	"Release Time",				0.001,    4,   0,    23,   -1,            125,     15,   725, 670
gkRvbMix, ihRvbMix		FLslider 	"Reverb Mix",				0,        1,   0,    23,   -1,            250,     15,   600, 700
gkRvbFbl, ihRvbFbl		FLslider 	"Reverb Time",				0.01,     1,  -1,    23,   -1,            250,     15,   600, 730
gkRvbLPF, ihRvbLPF		FLslider 	"Reverb LPF",				20,   20000,  -1,    23,   -1,            250,     15,   600, 760

;SWITCHES                                            				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkHarmonicRatios,ihHarmonicRatios	FLbutton	"Harmonic Ratios",	1,    0,    21,    150,     30,   600,600,   0,      5,      0,      0.01
gkRandRatios,ihRandRatios		FLbutton	"Randomize Ratios",	1,    0,    21,    150,     30,   800,600,   0,      6,      0,      0.01
gkZeroAmps,ihZeroAmps			FLbutton	"Zero Amplitudes",	1,    0,    21,    150,     30,  1000,600,   0,      7,      0,      0.01

;SET INITIAL VALUES OF FLTK VALUATORS
FLsetVal_i	0.3, 	ihamp
FLsetVal_i	100, 	ihFundFrq
FLsetVal_i	0.02, 	ihAmpPort
FLsetVal_i	0.2, 	ihRatiosPort
FLsetVal_i	0, 	ihx
FLsetVal_i	0, 	ihy
FLsetVal_i	0.2, 	ihRvbMix
FLsetVal_i	0.8, 	ihRvbFbl
FLsetVal_i	8000, 	ihRvbLPF
FLsetVal_i	0.01, 	ihAttTim
FLsetVal_i	0.01, 	ihRelTim

FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 420, 100, 100
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"       additive synthesis - partial strength sketching       ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"One of the drawbacks of additive synthesis is the vast number", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"parameters that must be defined in the synthesis of a sound  ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"of any complexity. This can be a slow and unspontaneous      ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"process.                                                     ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"This example suggests a method in which slider values for    ", 	1,      5,     14,    490,    15,     5, 120
ih	  	 	FLbox  	"partial amplitudes can be sketched in sweeping movements of  ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"the mouse rather than having to be dragged up or down one by ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"one.                                                         ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"Sketching is done on the FLjoy panel at the top of the GUI.  ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"The sliders below this, display the current values for all   ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"partials but adjusting these sliders themselves will have no ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"effect.                                                      ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"This example makes extensive use of macros in order to       ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"avoid lengthy repetitions of code.                           ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"Reverb is added and is adjustable and also portamento is     ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"independently adjustable for partial amplitudes, fundemental ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"and frequency ratios.                                        ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"Frequency ratios can be randomized using the on-screen       ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"button.                                                      ", 	1,      5,     14,    490,    15,     5, 400

				FLpanel_end

FLrun		;RUN THE WIDGET THREAD!

gisine			ftgen		0,0,4096,10,1	;SINE WAVE
giwaveform		ftgen		0,0,32,-2,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1	;TABLE THAT CONTAINS PARTIAL STRENGTHS. THIS WILL BE UPDATED BY MOVEMENTS ON THE X-Y PANEL
gasend			init		0


instr	1	;SOUND GENERATING INSTRUMENT (MIDI)
	ioct	octmidi			;READ OCT VALUE FROM MIDI INPUT
	iamp	ampmidi	0.1		;READ IN A NOTE VELOCITY VALUE FROM THE MIDI INPUT

	kamp = iamp * gkamp		;SET kamp TO MIDI KEY VELOCITY MULTIPLIED BY FLTK SLIDER VALUE gkamp

	;PITCH BEND===========================================================================================================================================================
	iSemitoneBendRange = 2		;PITCH BEND RANGE IN SEMITONES (WILL BE DEFINED FURTHER LATER) - SUGGESTION - THIS COULD BE CONTROLLED BY AN FLTK COUNTER
	imin = 0			;EQUILIBRIUM POSITION
	imax = iSemitoneBendRange * .0833333	;MAX PITCH DISPLACEMENT (IN oct FORMAT)
	kbend	pchbend	imin, imax	;PITCH BEND VARIABLE (IN oct FORMAT)
	kFundFrq	=	cpsoct(ioct + kbend)
	;=====================================================================================================================================================================

	kporttime		linseg		0, 0.001, 1, 1, 1	;CREATE A RAMPING UP VARIABLE TO PREVENT PORTAMENTO GLIDE UPON NOTE ONSET
	kAmpPort		=		kporttime * gkAmpPort	;VARIABLE THAT WILL BE USED FOR AMPLITUDE (AND FUNDEMENTAL) PORTAMENTO
	kRatiosPort		=		kporttime * gkRatiosPort;VARIABLE THAT WILL BE USED FOR AMPLITUDE (AND FUNDEMENTAL) PORTAMENTO
	kfund			portk		kFundFrq, kAmpPort	;APPLY PORTAMENTO TO FUNDEMENTAL SLIDER OUTPUT
	amix			init		0			;
#define	OSCILLATOR(COUNT)	
	#
	kPartAmp$COUNT	table	$COUNT-1, giwaveform							;READ RELEVANT PARTIAL AMPLITUDE FROM TABLE
	kPartAmp$COUNT 		portk		kPartAmp$COUNT , kAmpPort				;APPLY PORTAMENTO SMOOTHING TO CHANGES IN PARTIAL AMPLITUDE
	kRatio$COUNT		portk		gkRatio$COUNT, kRatiosPort				;READ RELEVANT PARTIAL RATIO
	apart$COUNT	oscil	kamp*(1-kPartAmp$COUNT),  kfund+(kfund*(kRatio$COUNT-1)), gisine	;GENERATE AUDIO FOR PARTIAL
	amix		=	amix + apart$COUNT#							;ADD PARTIAL AUDIO TO CUMULATIVE AUDIO VARIABLE
	$OSCILLATOR(1) 
	$OSCILLATOR(2) 
	$OSCILLATOR(3) 
	$OSCILLATOR(4) 
	$OSCILLATOR(5) 
	$OSCILLATOR(6) 
	$OSCILLATOR(7) 
	$OSCILLATOR(8) 
	$OSCILLATOR(9) 
	$OSCILLATOR(10)
	$OSCILLATOR(11)
	$OSCILLATOR(12)
	$OSCILLATOR(13)
	$OSCILLATOR(14)
	$OSCILLATOR(15)
	$OSCILLATOR(16)
	$OSCILLATOR(17)
	$OSCILLATOR(18)
	$OSCILLATOR(19)
	$OSCILLATOR(20)
	$OSCILLATOR(21)
	$OSCILLATOR(22)
	$OSCILLATOR(23)
	$OSCILLATOR(24)
	$OSCILLATOR(25)
	$OSCILLATOR(26)
	$OSCILLATOR(27)
	$OSCILLATOR(28)
	$OSCILLATOR(29)
	$OSCILLATOR(30)
	
	aenv	linsegr	0, i(gkAttTim), 1, i(gkRelTim), 0	;AMPLITUDE ENVELOPE
	amix	=	amix * aenv	;ANTI-CLICK ENVELOPE

	gasend	=	gasend +  (amix * gkRvbMix)
	
	outs	amix * (1 - gkRvbMix), amix * (1 - gkRvbMix)	;SEND DRY SIGNAL TO OUTPUTS
	clear	amix
endin



instr	2	;UPDATE SLIDERS
	kx			=		int(gkx)	;CONVERT X-AXIS VALUES TO INTEGERS 
	ktrigger		changed		kx, gky		;GENERATE A TRIGGER (MOMENTARY '1') IF X OR Y AXIS VALUES CHANGE
	
	;	SCHEDKWHEN KTRIGGER, KMINTIM, KMAXNUM, KINSNUM, KWHEN, KDUR, p4,  p5
		schedkwhen ktrigger,    0,       0,       4,     0,    0,   gkx, gky	;TRIGGER INSTRUMENT THAT UPDATES THE TABLE
#define	UPDATE_SLIDER(COUNT)	
	#kPartAmp$COUNT 	table		$COUNT-1, giwaveform				;READ RELEVANT PARTIAL AMPLITUDE FROM TABLE (DEPENDENT UPON Y LOCATION OF POINTER)
				FLsetVal	ktrigger, kPartAmp$COUNT, gihPartAmp$COUNT
	#
	$UPDATE_SLIDER(1) 
	$UPDATE_SLIDER(2) 
	$UPDATE_SLIDER(3) 
	$UPDATE_SLIDER(4) 
	$UPDATE_SLIDER(5) 
	$UPDATE_SLIDER(6) 
	$UPDATE_SLIDER(7) 
	$UPDATE_SLIDER(8) 
	$UPDATE_SLIDER(9) 
	$UPDATE_SLIDER(10)
	$UPDATE_SLIDER(11)
	$UPDATE_SLIDER(12)
	$UPDATE_SLIDER(13)
	$UPDATE_SLIDER(14)
	$UPDATE_SLIDER(15)
	$UPDATE_SLIDER(16)
	$UPDATE_SLIDER(17)
	$UPDATE_SLIDER(18)
	$UPDATE_SLIDER(19)
	$UPDATE_SLIDER(20)
	$UPDATE_SLIDER(21)
	$UPDATE_SLIDER(22)
	$UPDATE_SLIDER(23)
	$UPDATE_SLIDER(24)
	$UPDATE_SLIDER(25)
	$UPDATE_SLIDER(26)
	$UPDATE_SLIDER(27)
	$UPDATE_SLIDER(28)
	$UPDATE_SLIDER(29)
	$UPDATE_SLIDER(30)
endin

instr		3	;SOUND GENERATING INSTRUMENT (FLTK)
	if	gkFLTK_MIDI=0	then	;IF ON/OFF SWITCH IS OFF...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	kamp = gkamp * 0.1			;SET kamp TO FLTK SLIDER VALUE gkamp
	kFundFrq = gkFundFrq			;SET FUNDEMENTAL TO FLTK SLIDER gkfund

	kporttime		linseg		0, 0.001, 1, 1, 1	;CREATE A RAMPING UP VARIABLE TO PREVENT PORTAMENTO GLIDE UPON NOTE ONSET
	kAmpPort		=		kporttime * gkAmpPort	;VARIABLE THAT WILL BE USED FOR AMPLITUDE (AND FUNDEMENTAL) PORTAMENTO
	kRatiosPort		=		kporttime * gkRatiosPort;VARIABLE THAT WILL BE USED FOR AMPLITUDE (AND FUNDEMENTAL) PORTAMENTO
	kfund			portk		kFundFrq, kAmpPort	;APPLY PORTAMENTO TO FUNDEMENTAL SLIDER OUTPUT
	amix			init		0			;
#define	OSCILLATOR(COUNT)	
	#
	kPartAmp$COUNT	table	$COUNT-1, giwaveform							;READ RELEVANT PARTIAL AMPLITUDE FROM TABLE
	kPartAmp$COUNT 		portk		kPartAmp$COUNT , kAmpPort				;APPLY PORTAMENTO SMOOTHING TO CHANGES IN PARTIAL AMPLITUDE
	kRatio$COUNT		portk		gkRatio$COUNT, kRatiosPort				;READ RELEVANT PARTIAL RATIO
	apart$COUNT	oscil	kamp*(1-kPartAmp$COUNT),  kfund+(kfund*(kRatio$COUNT-1)), gisine	;GENERATE AUDIO FOR PARTIAL
	amix		=	amix + apart$COUNT#							;ADD PARTIAL AUDIO TO CUMULATIVE AUDIO VARIABLE
	$OSCILLATOR(1) 
	$OSCILLATOR(2) 
	$OSCILLATOR(3) 
	$OSCILLATOR(4) 
	$OSCILLATOR(5) 
	$OSCILLATOR(6) 
	$OSCILLATOR(7) 
	$OSCILLATOR(8) 
	$OSCILLATOR(9) 
	$OSCILLATOR(10)
	$OSCILLATOR(11)
	$OSCILLATOR(12)
	$OSCILLATOR(13)
	$OSCILLATOR(14)
	$OSCILLATOR(15)
	$OSCILLATOR(16)
	$OSCILLATOR(17)
	$OSCILLATOR(18)
	$OSCILLATOR(19)
	$OSCILLATOR(20)
	$OSCILLATOR(21)
	$OSCILLATOR(22)
	$OSCILLATOR(23)
	$OSCILLATOR(24)
	$OSCILLATOR(25)
	$OSCILLATOR(26)
	$OSCILLATOR(27)
	$OSCILLATOR(28)
	$OSCILLATOR(29)
	$OSCILLATOR(30)
	
	aenv	linsegr	0, i(gkAttTim), 1, i(gkRelTim), 0	;AMPLITUDE ENVELOPE
	amix	=	amix * aenv	;ANTI-CLICK ENVELOPE

	gasend	=	gasend +  (amix * gkRvbMix)
	
	outs	amix * (1 - gkRvbMix), amix * (1 - gkRvbMix)	;SEND DRY SIGNAL TO OUTPUTS
	clear	amix
endin

instr	4	;UPDATE PARTIAL VALUE
	tableiw	p5, p4, giwaveform	;UPDATE AMPLITUDE VALUE IN TABLE
endin

instr	5	;HARMONIC RATIOS
	FLsetVal_i	1 , gihRatio1 
	FLsetVal_i	2 , gihRatio2 
	FLsetVal_i	3 , gihRatio3 
	FLsetVal_i	4 , gihRatio4 
	FLsetVal_i	5 , gihRatio5 
	FLsetVal_i	6 , gihRatio6 
	FLsetVal_i	7 , gihRatio7 
	FLsetVal_i	8 , gihRatio8 
	FLsetVal_i	9 , gihRatio9 
	FLsetVal_i	10, gihRatio10
	FLsetVal_i	11, gihRatio11
	FLsetVal_i	12, gihRatio12
	FLsetVal_i	13, gihRatio13
	FLsetVal_i	14, gihRatio14
	FLsetVal_i	15, gihRatio15
	FLsetVal_i	16, gihRatio16
	FLsetVal_i	17, gihRatio17
	FLsetVal_i	18, gihRatio18
	FLsetVal_i	19, gihRatio19
	FLsetVal_i	20, gihRatio20
	FLsetVal_i	21, gihRatio21
	FLsetVal_i	22, gihRatio22
	FLsetVal_i	23, gihRatio23
	FLsetVal_i	24, gihRatio24
	FLsetVal_i	25, gihRatio25
	FLsetVal_i	26, gihRatio26
	FLsetVal_i	27, gihRatio27
	FLsetVal_i	28, gihRatio28
	FLsetVal_i	29, gihRatio29
	FLsetVal_i	30, gihRatio30
endin

instr	6	;RANDOMIZE RATIOS
#define	RANDOMIZE_RATIO(COUNT)
	#
	iratio	random	1,30
	FLsetVal_i	iratio, gihRatio$COUNT
	#
	$RANDOMIZE_RATIO(1) 
	$RANDOMIZE_RATIO(2) 
	$RANDOMIZE_RATIO(3) 
	$RANDOMIZE_RATIO(4) 
	$RANDOMIZE_RATIO(5) 
	$RANDOMIZE_RATIO(6) 
	$RANDOMIZE_RATIO(7) 
	$RANDOMIZE_RATIO(8) 
	$RANDOMIZE_RATIO(9) 
	$RANDOMIZE_RATIO(10)
	$RANDOMIZE_RATIO(11)
	$RANDOMIZE_RATIO(12)
	$RANDOMIZE_RATIO(13)
	$RANDOMIZE_RATIO(14)
	$RANDOMIZE_RATIO(15)
	$RANDOMIZE_RATIO(16)
	$RANDOMIZE_RATIO(17)
	$RANDOMIZE_RATIO(18)
	$RANDOMIZE_RATIO(19)
	$RANDOMIZE_RATIO(20)
	$RANDOMIZE_RATIO(21)
	$RANDOMIZE_RATIO(22)
	$RANDOMIZE_RATIO(23)
	$RANDOMIZE_RATIO(24)
	$RANDOMIZE_RATIO(25)
	$RANDOMIZE_RATIO(26)
	$RANDOMIZE_RATIO(27)
	$RANDOMIZE_RATIO(28)
	$RANDOMIZE_RATIO(29)
	$RANDOMIZE_RATIO(30)
endin

instr	7	;ZERO PARTIAL AMPLITUDES
#define	ZERO_AMPLITUDE(COUNT)
	#
	FLsetVal_i	1, gihPartAmp$COUNT
	tableiw		1, $COUNT, giwaveform	;UPDATE AMPLITUDE VALUE IN TABLE
	#
	$ZERO_AMPLITUDE(1) 
	$ZERO_AMPLITUDE(2) 
	$ZERO_AMPLITUDE(3) 
	$ZERO_AMPLITUDE(4) 
	$ZERO_AMPLITUDE(5) 
	$ZERO_AMPLITUDE(6) 
	$ZERO_AMPLITUDE(7) 
	$ZERO_AMPLITUDE(8) 
	$ZERO_AMPLITUDE(9) 
	$ZERO_AMPLITUDE(10)
	$ZERO_AMPLITUDE(11)
	$ZERO_AMPLITUDE(12)
	$ZERO_AMPLITUDE(13)
	$ZERO_AMPLITUDE(14)
	$ZERO_AMPLITUDE(15)
	$ZERO_AMPLITUDE(16)
	$ZERO_AMPLITUDE(17)
	$ZERO_AMPLITUDE(18)
	$ZERO_AMPLITUDE(19)
	$ZERO_AMPLITUDE(20)
	$ZERO_AMPLITUDE(21)
	$ZERO_AMPLITUDE(22)
	$ZERO_AMPLITUDE(23)
	$ZERO_AMPLITUDE(24)
	$ZERO_AMPLITUDE(25)
	$ZERO_AMPLITUDE(26)
	$ZERO_AMPLITUDE(27)
	$ZERO_AMPLITUDE(28)
	$ZERO_AMPLITUDE(29)
	$ZERO_AMPLITUDE(30)
endin

instr	8	;REVERB
	;OUTPUTS	OPCODE		INPUTS         |FEEDBACK|LPF_CUTPFF
	arvbL,arvbR	reverbsc	gasend, gasend, gkRvbFbl,gkRvbLPF	;CREATE A REVERBERATED SIGNAL
	outs	arvbL, arvbR	;SEND AUDIO SIGNAL TO THE OUTPUTS
	clear	gasend
endin
	
</CsInstruments>

<CsScore>
i 2 0 3600	;INSTRUMENT 2 PLAYS FOR 1 HOUR
i 8 0 3600	;INSTRUMENT 8 PLAYS FOR 1 HOUR	(REVERB)
;f 0 3600
</CsScore>

</CsoundSynthesizer>