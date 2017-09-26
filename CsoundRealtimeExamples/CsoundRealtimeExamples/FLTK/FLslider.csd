FLslider
Written by Iain McCurdy, 2006.

<CsoundSynthesizer>

<CsOptions>
-odac -d
</CsOptions>

<CsInstruments>

;A SINE WAVE OSCILLATOR WITH FL-SLIDER CONTROLLED FREQUENCY

sr		=		44100
ksmps		=		64
nchnls		=		2
0dbfs		=		1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH
seed	0	;SEED RANDOM NUMBER GENERATOR FROM SYSTEM CLOCK




;		OPCODE	LABEL              | WIDTH | HEIGHT | X | Y
		FLpanel	"Frequency Slider",   500,    200,    0,  0

imin		=		200	;MINIMUM VALUE OUTPUT BY THE SLIDER
imax		=		5000	;MAXIMUM VALUE OUTPUT BY THE SLIDER
iexp		=		-1	;LOGARITHMIC TYPE SLIDER SELECTED
itype		=		5	;SLIDER GRAPHIC TYPE (5='NICE' SLIDER)
idisp		=		-1	;DISPLAY HANDLE (-1=NOT USED)
iwidth		=		480	;WIDTH OF THE SLIDER IN PIXELS
iheight		=		30	;HEIGHT OF THE SLIDER IN PIXELS
ix		=		10	;DISTANCE OF THE LEFT EDGE OF THE SLIDER FROM THE LEFT EDGE OF THE PANEL IN PIXELS
iy		=		50	;DISTANCE OF THE UPPER EDGE OF THE SLIDER FROM THE TOP EDGE OF THE PANEL IN PIXELS
gkfreq, ihandle	FLslider	"Frequency", imin, imax, iexp, itype, idisp, iwidth, iheight, ix, iy

;SET INITIAL VALUES FOR VALUATORS
			FLsetVal_i   	600, 	ihandle

		FLpanel_end	;END OF PANEL CONTENTS





		
;PANEL DISPLAYING ALL TYPES OF FLTK HORIZONATAL SLIDERS
;       OPCODE |         "LABEL"          | WIDTH | HEIGHT | X | Y
	FLpanel	"Horizontal Slider Types",   500,    420,   515, 0
FLcolor	-2,-2,-2	;RANDOMIZE COLOURS                                         
;SLIDERS                                                                                                                     
;OUTPUT | O.P.HANDLE |    OPCODE       |    "LABEL"                                   | MIN | MAX | EXP | TYPE | DISPLAY_HANDLE | WIDTH | HEIGHT | POS_X | POS_Y
gkoutput,    ihandle      FLslider	     "Type 1 - Horizontal Fill Slider",         0,     1,    0,     1,        -1,          490,     30,       5,     10
FLsetVal_i	rnd(1),ihandle	;SET SLIDER TO A RANDOM POSITION BETWEEN 0 AND 1
gkoutput,    ihandle      FLslider	     "Fill Slider (1) min/max inverted",        1,     0,    0,     1,        -1,          490,     30,       5,     60
FLsetVal_i	rnd(1),ihandle	;SET SLIDER TO A RANDOM POSITION BETWEEN 0 AND 1
gkoutput,    ihandle      FLslider	     "Type 3 - Horizontal Engraved Slider",     0,     1,    0,     3,        -1,          490,     30,       5,    110
FLsetVal_i	rnd(1),ihandle	;SET SLIDER TO A RANDOM POSITION BETWEEN 0 AND 1
gkoutput,    ihandle      FLslider	     "Type 5 - Horizontal 'Nice' Slider",       0,     1,    0,     5,        -1,          490,     30,       5,    160
FLsetVal_i	rnd(1),ihandle	;SET SLIDER TO A RANDOM POSITION BETWEEN 0 AND 1
gkoutput,    ihandle      FLslider	     "Type 21 - Horizontal Fill Slider",        0,     1,    0,    21,        -1,          490,     30,       5,    210
FLsetVal_i	rnd(1),ihandle	;SET SLIDER TO A RANDOM POSITION BETWEEN 0 AND 1
gkoutput,    ihandle      FLslider	     "Fill Slider (21) min/max inverted",       1,     0,    0,    21,        -1,          490,     30,       5,    260
FLsetVal_i	rnd(1),ihandle	;SET SLIDER TO A RANDOM POSITION BETWEEN 0 AND 1
gkoutput,    ihandle      FLslider	     "Type 23 - Horizontal Engraved Slider",    0,     1,    0,    23,        -1,          490,     30,       5,    310
FLsetVal_i	rnd(1),ihandle	;SET SLIDER TO A RANDOM POSITION BETWEEN 0 AND 1
gkoutput,    ihandle      FLslider	     "Type 25 - Horizontal 'Nice' Slider",      0,     1,    0,    25,        -1,          490,     30,       5,    360
FLsetVal_i	rnd(1),ihandle	;SET SLIDER TO A RANDOM POSITION BETWEEN 0 AND 1

	;'OUTPUT' MUST BE A GLOBAL VARIABLE (G PREFIX) AND K-RATE (K PREFIX)
	;'O.P.HANDLE' OUTPUT HANDLE (USED FOR INITIALISING THE SLIDER)
	;'LABEL' IS A TEXT STRING THAT WILL BE DISPLAYED IMMEDIATELY BENEATH THE SLIDER
	;'MIN' MINIMUM VALUE OF SLIDER
	;'MAX' MAXIMUM VALUE OF SLIDER
	;'EXP' DEFINES BEHAVIOUR OF THE SLIDER: 0 = LINEAR
	;					-1 = EXPONENTIAL
	;ANY OTHER POSITIVE VALUES INDICATES THE NUMBER OF A FUNCTION TABLE TO WHICH THE SLIDER WILL BE RESCALED
	;'TYPE' GRAPHICAL APPEARANCE OF SLIDER:
	;	1 - shows a horizontal fill slider 
	;	3 - a horizontal engraved slider 
	;	5 - a horizontal nice slider 
	;	7 - a horizontal up-box nice slider *NOT USED - DOESN'T SEEM TO BE IMPLEMENTED IN CSOUND 5*
	;'DISP_HANDLE' HANDLE USED FOR ANY WIDGET THAT DISPLAYS SLIDER VALUE -1=NOT USED
	;'WIDTH' WIDTH OF THE CREATED WIDGET IN PIXELS                                                       
	;'HEIGHT' HEIGHT OF THE CREATED WIDGET IN PIXELS
	;'POS_X' HORIZONTAL DISTANCE FROM THE LEFT EDGE OF THE PANEL IN PIXELS
	;'POS_Y' VERTICAL DISTANCE FROM THE TOP EDGE OF THE PANEL IN PIXELS

	FLpanel_end
	
	

	
	
	
	


	
;PANEL DISPLAYING ALL TYPES OF FLTK VERTICAL SLIDERS
;       OPCODE |      "LABEL"           | WIDTH | HEIGHT | X | Y
	FLpanel	"Vertical Slider Types",  1000,    300,    0, 500

;SLIDERS
;OUTPUT | O.P.HANDLE	OPCODE		"LABEL"                               | MIN | MAX | EXP | TYPE | DISPLAY_HANDLE | WIDTH | HEIGHT | POS_X | POS_Y
gkoutput, ihandle	FLslider	"Type 2 - Vertical Fill Slider",         0,    1,    0,     2,        -1,           30,    100,      80,    10
FLsetVal_i	rnd(1),ihandle	;SET SLIDER TO A RANDOM POSITION BETWEEN 0 AND 1
gkoutput, ihandle	FLslider	"Fill Slider (2) min/max inverted",      1,    0,    0,     2,        -1,           30,    100,     300,    10
FLsetVal_i	rnd(1),ihandle	;SET SLIDER TO A RANDOM POSITION BETWEEN 0 AND 1
gkoutput, ihandle	FLslider	"Type 4 - Vertical Engraved Slider",     0,    1,    0,     4,        -1,           30,    100,     520,    10
FLsetVal_i	rnd(1),ihandle	;SET SLIDER TO A RANDOM POSITION BETWEEN 0 AND 1
gkoutput, ihandle	FLslider	"Type 6 - Vertical Nice Slider",         0,    1,    0,     6,        -1,           30,    100,     740,    10
FLsetVal_i	rnd(1),ihandle	;SET SLIDER TO A RANDOM POSITION BETWEEN 0 AND 1
gkoutput, ihandle	FLslider	"Type 22 - Vertical Fill Slider",        0,    1,    0,    22,        -1,           30,    100,      80,   150
FLsetVal_i	rnd(1),ihandle	;SET SLIDER TO A RANDOM POSITION BETWEEN 0 AND 1
gkoutput, ihandle	FLslider	"Fill Slider (22) min/max inverted",     1,    0,    0,    22,        -1,           30,    100,     300,   150
FLsetVal_i	rnd(1),ihandle	;SET SLIDER TO A RANDOM POSITION BETWEEN 0 AND 1
gkoutput, ihandle	FLslider	"Type 24 - Vertical Engraved Slider",    0,    1,    0,    24,        -1,           30,    100,     520,   150
FLsetVal_i	rnd(1),ihandle	;SET SLIDER TO A RANDOM POSITION BETWEEN 0 AND 1
gkoutput, ihandle	FLslider	"Type 26 - Vertical Nice Slider",        0,    1,    0,    26,        -1,           30,    100,     740,   150
FLsetVal_i	rnd(1),ihandle	;SET SLIDER TO A RANDOM POSITION BETWEEN 0 AND 1

;gkoutput, ihandle	FLslider	"Type 8 = Vertical Up-Box Nice Slider",  20, 20000,  0,     8,        -1,           30,    250,     790,    50;NOT USED - DOESN'T SEEM TO BE IMPLEMENTED IN CSOUND5 

	;'OUTPUT' MUST BE A GLOBAL VARIABLE (G PREFIX) AND K-RATE (K PREFIX)
	;'O.P.HANDLE' OUTPUT HANDLE (USED FOR INITIALISING THE SLIDER)
	;'LABEL' IS A TEXT STRING THAT WILL BE DISPLAYED IMMEDIATELY BENEATH THE SLIDER
	;'MIN' MINIMUM VALUE OF SLIDER
	;'MAX' MAXIMUM VALUE OF SLIDER
	;'EXP' DEFINES BEHAVIOUR OF THE SLIDER: 0 = LINEAR
	;					-1 = EXPONENTIAL
	;ANY OTHER POSITIVE VALUES INDICATES THE NUMBER OF A FUNCTION TABLE TO WHICH THE SLIDER WILL BE RESCALED
	;'TYPE' GRAPHICAL APPEARANCE OF SLIDER:
	;	2 - a vertical fill slider
	;	4 - a vertical engraved slider
	;	6 - a vertical nice slider
	;	8 - a vertical up-box nice slider	;NOT USED - DOESN'T SEEM TO BE IMPLEMENTED IN CSOUND5 
	;'DISP_HANDLE' HANDLE USED FOR ANY WIDGET THAT DISPLAYS SLIDER VALUE. -1=NOT_USED
	;'WIDTH' WIDTH OF THE CREATED WIDGET IN PIXELS
	;'HEIGHT' HEIGHT OF THE CREATED WIDGET IN PIXELS
	;'POS_X' HORIZONTAL DISTANCE FROM THE LEFT EDGE OF THE PANEL IN PIXELS
	;'POS_Y' VERTICAL DISTANCE FROM THE TOP EDGE OF THE PANEL IN PIXELS
	
	FLpanel_end

	
	
	

	FLrun		;RUN THE WIDGET THREAD

gisine	ftgen	0, 0, 131072, 10, 1		;FUNCTION TABLE THAT DEFINES A SINGLE CYCLE OF A SINE WAVE

instr 		1
	kporttime	linseg	0,0.001,0.005	;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A HELD VALUE	
	kfreq	portk	gkfreq, kporttime	;SMOOTH CHANGES USING PORTAMENTO
	afreq	interp	kfreq			;INTERPOLATE BETWEEN K-CYCLES TO PRODUCE AN A-RATE VECTOR SIGNAL. THIS IS PARTICULARLY BENEFICIAL WHEN K-RATE IS LOW (ksmps IS HIGH)
	;OUTPUT		OPCODE		AMPLITUDE | FREQUENCY | FUNCTION_TABLE
	asig		oscil		0.02,         afreq,       gisine
			outs		asig, asig
endin

</CsInstruments>

<CsScore>
i 1 0 3600		;INSTRUMENT 1 WILL PLAY A NOTE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>