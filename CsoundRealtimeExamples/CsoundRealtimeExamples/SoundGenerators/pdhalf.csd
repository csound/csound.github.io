pdhalf.csd
Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
;COMMENT/UNCOMMENT AS REQUIRED
;-odac -dm0			;NO MIDI
;-odac -dm0 -Ma			;EXTERNAL MIDI
-odac -dm0 -M0 -+rtmidi=virtual	;VIRTUAL MIDI KEYBOARD
</CsOptions>

<CsInstruments>

sr	=	44100
ksmps	=	32
nchnls	=	2
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL    | WIDTH | HEIGHT | X | Y
	FLpanel	"pdhalf",   500,    645,    0,  0

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	6,        9,    15,    480,   115,    10, 275	;BORDER AROUND SHAPE-AMOUNT ENVELOPE
ih		 	FLbox  	" ", 	6,        9,    15,    480,   115,    10, 400	;BORDER AROUND AMPLITUDE ENVELOPE
ih		 	FLbox  	" ", 	6,        9,    15,    480,   115,    10, 525	;BORDER AROUND SHAPE-AMOUNT LFO

;							ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"On / Off-MIDI",	1,   0,     22,    120,     25,    5,  5,    0,      2,      0,       -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES				WIDTH | HEIGHT | X |  Y
idamp			FLvalue	" ",     	60,       20,    5,   75
idfreq			FLvalue	" ",     	60,       20,    5,  125
idShapeAmount		FLvalue	" ",     	60,       20,    5,  175

idstrlevS		FLvalue	" ",     	50,       18,   40-25,  360
idatttimS		FLvalue	" ",     	50,       18,  100-25,  360
idattlevS		FLvalue	" ",     	50,       18,  160-25,  360
iddectimS		FLvalue	" ",     	50,       18,  220-25,  360
idsuslevS		FLvalue	" ",     	50,       18,  280-25,  360
idreltimS		FLvalue	" ",     	50,       18,  340-25,  360
idrellevS		FLvalue	" ",     	50,       18,  400-25,  360

idstrlevA		FLvalue	" ",     	50,       18,   40,  485
idatttimA		FLvalue	" ",     	50,       18,  100,  485
idattlevA		FLvalue	" ",     	50,       18,  160,  485
iddectimA		FLvalue	" ",     	50,       18,  220,  485
idsuslevA		FLvalue	" ",     	50,       18,  280,  485
idreltimA		FLvalue	" ",     	50,       18,  340,  485
idrellevA		FLvalue	" ",     	50,       18,  400,  485

idLFOdepS		FLvalue	" ",     	50,       18,  135,  610
idLFOratS		FLvalue	" ",     	50,       18,  195,  610
idLFOdelS		FLvalue	" ",     	50,       18,  255,  610
idLFOrisS		FLvalue	" ",     	50,       18,  315,  610

;SLIDERS				            					MIN  |   MAX | EXP | TYPE |  DISP        | WIDTH | HEIGHT | X | Y
gkamp, ihamp			FLslider 	"Amplitude",				0,         1,   0,    23,   idamp,          490,     25,    5,  50
gkfreq, ihfreq			FLslider 	"Frequency (FLTK mode)",		1,     2000,  -1,    23,  idfreq,          490,     25,    5, 100   
gkShapeAmount, gihShapeAmount	FLslider 	"Phase Distortion Amount (FLTK mode)",	-1,        1,   0,    23,  idShapeAmount,   490,     25,    5, 150

;KNOBS							MIN  | MAX | EXP | TYPE |   DISP   | WIDTH | X | Y
gkstrlevS, ihstrlevS	FLknob 		"Level",	-1,     1,    0,    1,   idstrlevS,    40,    45-25, 302
gkatttimS, ihatttimS	FLknob 		"Attack",	.001,   8,    0,    1,   idatttimS,    40,   105-25, 302
gkattlevS, ihattlevS	FLknob 		"Level",	-1,     1,    0,    1,   idattlevS,    40,   165-25, 302
gkdectimS, ihdectimS	FLknob 		"Decay",	.001,   8,    0,    1,   iddectimS,    40,   225-25, 302
gksuslevS, ihsuslevS	FLknob 		"Sustain",	-1,     1,    0,    1,   idsuslevS,    40,   285-25, 302
gkreltimS, ihreltimS	FLknob 		"Release",	0,      8,    0,    1,   idreltimS,    40,   345-25, 302
gkrellevS, ihrellevS	FLknob 		"Level",	-1,     1,    0,    1,   idrellevS,    40,   405-25, 302
gkvel, ihvel		FLknob 		"Velocity",	0,      1,    0,    1,   -1,           40,   465-25, 302

gkstrlevA, ihstrlevA	FLknob 		"Level",	0,      1,    0,    1,   idstrlevA,    40,    45, 427
gkatttimA, ihatttimA	FLknob 		"Attack",	.001,   8,    0,    1,   idatttimA,    40,   105, 427
gkattlevA, ihattlevA	FLknob 		"Level",	0,      1,    0,    1,   idattlevA,    40,   165, 427
gkdectimA, ihdectimA	FLknob 		"Decay",	.001,   8,    0,    1,   iddectimA,    40,   225, 427
gksuslevA, ihsuslevA	FLknob 		"Sustain",	0,      1,    0,    1,   idsuslevA,    40,   285, 427
gkreltimA, ihreltimA	FLknob 		"Release",	0,      8,    0,    1,   idreltimA,    40,   345, 427
gkrellevA, ihrellevA	FLknob 		"Level",	0,      1,    0,    1,   idrellevA,    40,   405, 427

gkLFOdepS, ihLFOdepS	FLknob 		"Depth",	0,      1,    0,    1,   idLFOdepS,    40,   140, 552
gkLFOratS, ihLFOratS	FLknob 		"Rate",		0,     16,    0,    1,   idLFOratS,    40,   200, 552
gkLFOdelS, ihLFOdelS	FLknob 		"Delay",	0,      5,    0,    1,   idLFOdelS,    40,   260, 552
gkLFOrisS, ihLFOrisS	FLknob 		"Rise",		0,      5,    0,    1,   idLFOrisS,    40,   320, 552
 
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS				TYPE | NUMX | NUMY | WIDTH | HEIGHT | X |  Y | OPCODE
gkfn, ihfn		FLbutBank	 13,     2,     3,      318,    60,   70, 210,   -1
gktype, ihtype		FLbutBank	 13,     1,     2,       18,    40,  300,   0,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES								TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Waveform:",				1,       6,    12,    50,      25,    12, 207
ih		 	FLbox  	"Cosine          ", 			1,       5,    12,   115,      25,    90, 207
ih		 	FLbox  	"Odd Partials    ", 			1,       5,    12,   115,      25,    90, 227
ih		 	FLbox  	"Octaves Partials", 			1,       5,    12,   115,      25,    90, 247
ih		 	FLbox  	"Square Wave     ", 			1,       5,    12,   115,      25,   250, 207
ih		 	FLbox  	"Buzz            ", 			1,       5,    12,   115,      25,   250, 227
ih		 	FLbox  	"Harms:3,7,13    ", 			1,       5,    12,   115,      25,   250, 247
ih		 	FLbox  	"Shape Amount Envelope (MIDI mode)",	1,       6,    12,   250,      25,   125, 277
ih		 	FLbox  	"Amplitude Envelope (MIDI mode)",	1,       6,    12,   250,      25,   125, 402
ih		 	FLbox  	"Shape Amount LFO",			1,       6,    12,   250,      25,   125, 527
ih		 	FLbox  	"x-axis distortion",			1,       5,    12,   120,      18,   320,   0
ih		 	FLbox  	"y-axis distortion",			1,       5,    12,   120,      18,   320,  20

;SET INITIAL VALUES FOR SLIDERS 	|VALUE | HANDLE
			FLsetVal_i	0.15, 	ihamp
			FLsetVal_i	400, 	ihfreq
			FLsetVal_i	0, 	gihShapeAmount
			FLsetVal_i	0, 	ihstrlevS
			FLsetVal_i	.005, 	ihatttimS
			FLsetVal_i	1, 	ihattlevS
			FLsetVal_i	1, 	ihdectimS
			FLsetVal_i	0, 	ihsuslevS
			FLsetVal_i	.5, 	ihreltimS
			FLsetVal_i	0, 	ihrellevS
			FLsetVal_i	0, 	ihstrlevA
			FLsetVal_i	.005, 	ihatttimA
			FLsetVal_i	1, 	ihattlevA
			FLsetVal_i	1, 	ihdectimA
			FLsetVal_i	1, 	ihsuslevA
			FLsetVal_i	.5, 	ihreltimA
			FLsetVal_i	0, 	ihrellevA
			FLsetVal_i	0, 	ihLFOdepS
			FLsetVal_i	1, 	ihLFOratS
			FLsetVal_i	0, 	ihLFOdelS
			FLsetVal_i	0, 	ihLFOrisS
			FLsetVal_i	1, 	ihvel

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 520, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"        pdhalf (pdhalfy): Phase Distortion Synthesis         ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"'pdhalf' (and 'pdhalfy') can be used to warp the movement of ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"a phase pointer that can be then used to implement phase     ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"distortion synthesis as used in Casio's CZ series of         ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"synthsizers.                                                 ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"For a description of exactly how this works I would direct   ", 	1,      5,     14,    490,    15,     5, 120
ih	  	 	FLbox  	"the reader to Anthony Kozar's excellent decription of his    ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"opcodes in the entries in the Csound Manual for 'pdhalf' and ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"'pdhalfy'.                                                   ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"The difference between 'pdhalf' and 'pdhalfy' is that the    ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"distortion node is defined on the x-axis or on the y-axis    ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"respectively. In this example the user can choose between    ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"these two opcodes using the two tick boxes in the upper right", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"of the interface.                                            ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"'Shape Amount' (the amount of phase distortion) is normally  ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"defined as a value between -1 and 1. A value of zero         ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"specifies no phase distortion.                               ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"In this example 'Shape Amount' can be modulated be the       ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"dedicated slider, when activating the instrument using the   ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"on-screen switch, or via the 'Shape Amount Envelope' when a  ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"note has been triggered by a MIDI keyboard. 'Shape Amount'   ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"can also be modulated by the LFO in either mode.             ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"In this example a choice of 6 waveforms to be phase distorted", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"are offered. The user is encouraged to explore the phase     ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"distortion of other waveforms.                               ", 	1,      5,     14,    490,    15,     5, 500

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

0dbfs	=	1




giwave1		ftgen	1, 0, 131072, 11, 1						;COSINE
giwave2		ftgen	2, 0, 131072, 10, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0	;ODD PARTIALS
giwave3		ftgen	3, 0, 131072, 9,   1, 1, 270,   2, 1, 270,   4, 1, 270,   8, 1, 270,   16, 1, 270,   32, 1, 270	; OCTAVES PARTIALS
gisqu		ftgen	0, 0, 131072, 7, 1, 65536, 1, 0, -1, 65537, -1			;SQUARE WAVE
giwave4		ftgen	4, 0, 131072, 30, gisqu, 1, 20,sr,0				;BANDLIMITED SQUARE WAVE
giwave5		ftgen	5, 0, 131072, 11, 40, 1, 1.1					;BUZZ WAVEFORM
giwave6		ftgen	6, 0, 131072, 19,    3,1,0,0,    7,0.5,0,0,	13,0.1,0,0	;SELECTED HARMONICS WAVEFORM

instr	1	;MIDI ACTIVATED INSTRUMENT
	ktrig		changed	gkfn			;TEST WHETHER INPUT ARGUMENTS HAVE CHANGED. IF ANY OF THEM HAVE, OUTPUT A '1' OTHERWISE OUTPUT ZERO.
	if		ktrig=1	then			;IF 'ktrig' IS '1'...
			reinit	UPDATE			;BEGIN A REINITIALIZATION PASS AT LABEL 'UPDATE'
	endif						;END OF CONDITIONALIZATION PASS
	ibipolar	=	0		;UNIPOLAR/BIPOLAR SWITCH (0=UNIPOLAR 1=BIPOLAR)
	ifullscale	=	1		;FULLSCALE VALUE
	icps	cpsmidi
	;PITCH BEND INFORMATION IS READ
	iSemitoneBendRange = 2				;PITCH BEND RANGE IN SEMITONES (WILL BE DEFINED FURTHER LATER) - SUGGESTION - THIS COULD BE CONTROLLED BY AN FLTK COUNTER
	kbend	pchbend	0, iSemitoneBendRange*2		;PITCH BEND VARIABLE (IN oct FORMAT)
	kfreq	=	icps * semitone(kbend)
	aosc        	phasor	kfreq			;DEFINE A PHASOR
    	kShapeEnv	cossegr	i(gkstrlevS), i(gkatttimS), i(gkattlevS), i(gkdectimS), i(gksuslevS), 36000, i(gksuslevS), i(gkreltimS), i(gkrellevS)	;ENVELOPE USED TO MODULATE 'SHAPE AMOUNT'
    	ivel		veloc	0,1
    	kShapeEnv	=	kShapeEnv * (gkvel * ivel)
    	kLFOenv		linseg	0,i(gkLFOdelS)+0.00001,0,i(gkLFOrisS)+0.00001,1,1,1
    	kShapeLFO	lfo	gkLFOdepS*kLFOenv, gkLFOratS, 1	;TRIANGLE WAVEFORM
    	kShapeAmount	limit	kShapeEnv+kShapeLFO, -1, 1
    	aAmpEnv		linsegr	i(gkstrlevA), i(gkatttimA), i(gkattlevA), i(gkdectimA), i(gksuslevA), i(gkreltimA), i(gkrellevA)	;ENVELOPE USED TO MODULATE AMPLITUDE
    	apd1         	pdhalf	aosc, kShapeAmount, ibipolar, ifullscale	;PHASE DISTORT THE PHASOR (aosc) CREATED 4 LINES ABOVE
    	apd2         	pdhalfy	aosc, kShapeAmount, ibipolar, ifullscale	;PHASE DISTORT THE PHASOR (aosc) CREATED 4 LINES ABOVE
	if	gktype=0	then
		apd=apd1
	elseif	gktype=1	then
		apd=apd2
	endif
	UPDATE:									;LABEL FOR WHERE TO BEGIN REINITIALISATION PASS
    	aout        	tablei	apd, i(gkfn)+1, 1				;READ WAVEFORM USING PHASE DISTORTED WAVEFORM
    	rireturn								;RETURN TO PERFORMANCE
			outs	aout * gkamp * aAmpEnv, aout * gkamp * aAmpEnv	;SEND AUDIO TO OUTPUTS
endin   

instr	2	;FLTK TRIGGERED INSTRUMENT
	kporttime	linseg	0,0.001,0.05
	kfreq		portk	gkfreq,kporttime
	kShapeAmount	portk	gkShapeAmount,kporttime
	ktrig		changed	gkfn			;TEST WHETHER INPUT ARGUMENTS HAVE CHANGED. IF ANY OF THEM HAVE, OUTPUT A '1' OTHERWISE OUTPUT ZERO.
	if		ktrig=1	then			;IF 'ktrig' IS '1'...
			reinit	UPDATE			;BEGIN A REINITIALISATION PASS AT LABEL 'UPDATE'
	endif						;END OF CONDITIONAL PASS
	if	gkOnOff!=0	kgoto	CONTINUE	;SENSE IF FLTK INSTRUMENT ON/OFF SWITCH IS NOT OFF (IN WHICH CASE SKIP THE NEXT LINE)
	turnoff						;TURN THIS INSTRUMENT OFF IMMEDIATELY
	CONTINUE:					;A LABEL
	ibipolar	=	0		;UNIPOLAR/BIPOLAR SWITCH (0=UNIPOLAR 1=BIPOLAR)
	ifullscale	=	1		;FULLSCALE VALUE
	aosc        	phasor	kfreq		;DEFINE A PHASOR
    	kLFOenv		linseg	0,i(gkLFOdelS)+0.00001,0,i(gkLFOrisS)+0.00001,1,1,1
    	kShapeLFO	lfo	gkLFOdepS*kLFOenv, gkLFOratS, 1	;TRIANGLE WAVEFORM
    	kShapeAmount	limit	kShapeAmount+kShapeLFO, -1, 1
    	apd1         	pdhalf	aosc, kShapeAmount, ibipolar, ifullscale	;PHASE DISTORT THE PHASOR (aosc) CREATED 4 LINES ABOVE
    	apd2         	pdhalfy	aosc, kShapeAmount, ibipolar, ifullscale	;PHASE DISTORT THE PHASOR (aosc) CREATED 4 LINES ABOVE
	if	gktype=0	then
		apd=apd1
	elseif	gktype=1	then
		apd=apd2
	endif
	UPDATE:									;LABEL FOR WHERE TO BEGIN REINITIALISATION PASS
    	aout        	tablei	apd, i(gkfn)+1, 1				;READ WAVEFORM USING PHASE DISTORTED WAVEFORM    	
    	rireturn								;RETURN TO PERFORMANCE
			outs	aout * gkamp, aout * gkamp	;SEND AUDIO TO OUTPUTS
endin   

	
</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT. SUSTAINS REALTIME PERFORMANCE FOR 1 HOUR.
</CsScore>

</CsoundSynthesizer>