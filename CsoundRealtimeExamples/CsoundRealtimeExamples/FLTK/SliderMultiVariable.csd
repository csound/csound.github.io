SliderMultiVariable.csd
Written by Iain McCurdy, 2008

A single slider is use to control 3 different variables.
The output of this slider moving within the range 0 -1 will be rescaled in 3 different ways to create 3 different variables 
which are used to define the note numbers of 3 different oscillators.

The note numbers of these oscillators will be displayed in FLTK valuator boxes.
			
<CsoundSynthesizer>

<CsOptions>
-odac -d
</CsOptions>

<CsInstruments>

sr	=	44100
ksmps	=	8
nchnls	=	2
0dbfs	=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET PRIMARY AND SECONDARY INTERFACE COLOURS
;       OPCODE |             "LABEL"          | WIDTH | HEIGHT | X | Y
	FLpanel	"SINGLE SLIDER MULTI-VARIABLE",  900,    500,    0,  0

;VALUE DISPLAY BOX TO DISPLAY THE OUTPUT OF THE SLIDER
;HANDLE        | OPCODE | "LABEL"          | WIDTH | HEIGHT | POS_X | POS_Y
 idval	    	FLvalue    "Slider Val.",      100,     30,      25,     50

;CREATE A SLIDER, RANGE 0 TO 1   
;OUTPUT | O.P.HANDLE |    OPCODE       |    "LABEL"   | MIN | MAX | EXP | TYPE | DISPLAY_HANDLE | WIDTH | HEIGHT | POS_X | POS_Y
gkval,    ihval         FLslider	"Range: 0-1",    0,    1,    0,    23,      idval,         750,    30,     125,     50

;CREATE 3 VALUATORS THAT WILL ALLOW US TO DISPLAY THE 3 NOTE NUMBER VALUES CALCULATED IN INSTRUMENT 1
;						MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X | Y
gk, gihnum1	FLtext		"Note Num.1",	0,    127,   0,     1,     80,      20,    9, 105
gk, gihnum2	FLtext		"Note Num.2",	0,    127,   0,     1,     80,      20,    9, 155
gk, gihnum3	FLtext		"Note Num.3",	0,    127,   0,     1,     80,      20,    9, 205

;INITIALISE THE SLIDER POSITION
;       OPCODE     | INITIAL_VALUE | DESTINATION_HANDLE
	FLsetVal_i       0,              ihval

;SOME TEXT BOXES ARE CREATED TO DESCRIBE WHAT WILL HAPPEN
;                                       					               		       TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ihCC	FLbox  "3 OSCILLATORS ARE CREATED. THEIR NOTE NUMBERS ARE ALL CONTROLLED FROM A SINGLE SLIDER.      ",   1,     5,    13,    800,     25,    5,  250
ihCC	FLbox  "OSCILLATOR 1 MOVES FROM 60 TO 52 TO 61                                                      ",   1,     5,    13,    800,     25,    5,  275
ihCC	FLbox  "OSCILLATOR 2 MOVES FROM 54 TO 54 TO 37                                                      ",   1,     5,    13,    800,     25,    5,  300
ihCC	FLbox  "OSCILLATOR 3 MOVES FROM 57 TO 53 TO 49                                                      ",   1,     5,    13,    800,     25,    5,  325
ihCC	FLbox  "The slider itself only outputs values within the range 0 to 1. The values it outputs are    ",   1,     5,    13,    800,     25,    5,  350
ihCC	FLbox  "mathematically tranformed within the code to provide the ranges of values required by the   ",   1,     5,    13,    800,     25,    5,  375
ihCC	FLbox  "three oscillators.                                                                          ",   1,     5,    13,    800,     25,    5,  400

	FLpanel_end
	FLrun

;THE THREE NOTE NUMBER MAPPINGS
;GEN 8 IS USED WHICH CREATES A SMOOTH SPLINE THROUGH THE BREAK POINTS PRESCRIBED
giNoteMap0	ftgen	0,0,4096,-8, 60,2048, 52, 2048, 61
giNoteMap1	ftgen	0,0,4096,-8, 54,2048, 54, 2048, 37
giNoteMap2	ftgen	0,0,4096,-8, 57,2048, 53, 2048, 49

giwave		ftgen	0, 0, 4096, 10, 1,1/2,1/4,1/8,1/16,1/32,1/64,1/128,1/256,1/512,1/1024	;A RICH HARMONIC WAVEFORM

instr 1
	;TRANSLATE SLIDER VALUE INTO A NOTE NUMBER USING THE APPROPRIATE MAPPING TABLE
	knum	table	gkval,giNoteMap0+p4,1
	
	kfreq	=	cpsmidinn(knum)
		
	;THE FOLLOWING 6 LINES OF CODE ARE USED TO DISPLAY THE VARIABLES kfreq1, kfreq2 & kfreq3  IN FLTK VALUATOR BOXES
	kmetro		metro	20			;CREATE A METRONOME OF PULSES THAT WILL BE USED TO LIMIT THE MAXIMUM RATE OF WIDGET UPDATE
	if kmetro==1 then				;IF A METRONOME CLICK IS RECEIVED...
	  ktrig		changed	gkval			;...IF kfreq1 GENERATE A TRIGGER IMPULSE                              
	  FLsetVal 	ktrig, knum, gihnum1+p4		;IF A TRIGGER IMPULSE (trig) HAS BEEN GENERATED UPDATE SLIDER gihnum1(+p4) WITH THE VALUE knum
	endif
	
	;CREATE THE OSCILLATOR
	asig		vco2	0.04,  kfreq		;GENERATE A SAWTOOTH TONE
	asig		tone	asig,1000		;SOFTEN IT A LITTLE WITH A LOWPASS FILTER
	asig 		pareq	asig, 100, 6, 0.5	;FATTEN THE BASS END
	adelL	rspline	0.01,0.05,0.05,0.1		;DELAY TIMES RANDOM SPLINE FUNCTION
	adelR	rspline	0.01,0.05,0.05,0.1		;
	aL	vdelay3	asig,(adelL+0.001)*1000,1000	;DELAY THE SIGNAL IN TWO WAYS TO GENERATE A STEREO SIGNAL	
	aR	vdelay3	asig,(adelR+0.001)*1000,1000
		outs	aL+asig,aR+asig			;SEND AUDIO TO OUTPUTS MIX THE DRY,UNDELAYED AUDIO WITH THE DELAYED AUDIO FOR EACH CHANNEL
endin

</CsInstruments>

<CsScore>
;          p4
i 1 0 3600 0
i 1 0 3600 1
i 1 0 3600 2
;p4 DEFINES THE MAPPING TABLE TO BE USED IN TRANSLATING SLIDER VALUE TO NOTE NUMBER VALUE
</CsScore>

</CsoundSynthesizer>