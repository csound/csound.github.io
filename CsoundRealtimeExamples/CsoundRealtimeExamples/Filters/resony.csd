resony.csd
Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
-odac -dm0 -M0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
kr 		= 	441	;CONTROL RATE
ksmps 		= 	100	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;					LABEL    | WIDTH | HEIGHT | X | Y
				FLpanel	"resony",   500,    450,    0,  0

;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On (FLTK) / Off (MIDI)",	1,    0,    22,    170,     25,    5,  5,    0,      1,      0,      -1
FLsetFont 2, ihOnOff
FLsetTextSize 13, ihOnOff

FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			LABEL     | WIDTH | HEIGHT | X | Y
idbf				FLvalue	" ",          80,     20,    5,  75
idbw				FLvalue	" ",          80,     20,    5, 125
idamp				FLvalue	" ",          80,     20,    5, 270
idsep				FLvalue	"octaves",    80,     20,    5, 405

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT |  X  | Y | OPCODE | INS | STARTTIM | IDUR
gkscl, ihscl 			FLcount	"Scaling Mode", 		0,      2,    1,      1,      2,    150,     25,    175, 155,     -1
gkskip, ihskip 			FLcount	"Initialisation 0-On 1-Off", 	0,      1,    1,      1,      2,    150,     25,    345,   5,     -1
gknum, ihnum 			FLcount	"Number of Filters", 		1,     80,    1,      1,      2,    130,     25,      5, 300,     -1
gksep2, gihsep2			FLcount	"Semitones", 			-48,   48, 0.01,      1,      1,    100,     20,    390, 410,     -1

;SLIDERS					            			MIN | MAX | EXP | TYPE |  DISP | WIDTH | HEIGHT | X   | Y
gkbf,ihbf			FLslider 	"Base Frequency",		20,  20000, -1,    23,   idbf,    490,     25,    5,    50
gkbw,ihbw			FLslider 	"Bandwidth",			.01, 10000, -1,    23,   idbw,    490,     25,    5,   100
gkgain,ihgain			FLslider 	"Output Gain",			0.0001, 5,  -1,    23,  idamp,    490,     25,    5,   245
gksep,gihsep1			FLslider 	"Separation (ignored in 'hertz' mode)",	        	-11,    11,  0,    23,  idsep,    490,     25,    5,   380

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	6,        9,    15,    330,    60,   150, 295

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)
;BUTTON BANKS			 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gksepmode,   ihsepmode	FLbutBank	13,     1,     3,     18,     45,   280, 300,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Separation Mode:",	1,       6,    12,   120,      15,   155,  300
ih		 	FLbox  	"octaves (total)   ", 	1,       5,    12,   130,      15,   300,  299
ih		 	FLbox  	"hertz             ", 	1,       5,    12,   130,      15,   300,  314
ih		 	FLbox  	"octaves (adjacent)", 	1,       5,    12,   130,      15,   300,  329

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	1000, 	ihbf
				FLsetVal_i	30, 	ihbw
				FLsetVal_i	1, 	ihscl
				FLsetVal_i	1, 	ihgain
				FLsetVal_i	10, 	ihnum
				FLsetVal_i	1, 	gihsep1
				FLsetVal_i	12, 	gihsep2

;TEXT BOXES																ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	"Scaling Modes:    0-None    1-Peak Response Factor of 1    2-Overall RMS Response Factor equals 1", 	1,        9,    12,    500,    10,     0, 203
			
				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 	515, 500, 512, 0
				FLscroll	515, 500, 0,   0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          resony                             ", 	1,      6,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      6,     14,    490,    20,     5,  20
ih		 	FLbox  	"Resony is an implementation of a stack of second-order band- ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"-pass filters whose centre frequencies are arithmetically    ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"related.                                                     ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"The 'bandwidth', 'scaling mode' and 'skip initialisation'    ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"parameters are as they are in the reson opcode.              ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"'inum' (number of filters) defines the number of filters in  ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"the stack.                                                   ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"'ksep' (separation) normally defines the separation between  ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"the lowest and highest filter in the stack in octaves. How   ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"this relates to what the actual centre frequencies of filters", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"will be differs depending upon which separation mode has been", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"selected. This is explained below. Note that in this example ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"the operation of 'ksep' has been modified slightly to allow  ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"the opcode to be better controlled from the GUI. These       ", 	1,      5,     14,    490,    20,     5, 300 
ih		 	FLbox  	"modifications are claified below. Separation can be defined  ", 	1,      5,     14,    490,    20,     5, 320 
ih		 	FLbox  	"using the slider (in octaves) or the slider or the counter   ", 	1,      5,     14,    490,    20,     5, 340 
ih		 	FLbox  	"(in semitones). 'kbf' (base frequency) defines the centre    ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"frequency of the first filter.                               ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"In 'octave' separation mode the pitch interval between the   ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"base frequency and (base frequency + separation) is divided  ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"into equal intervals according to the number of filters that ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"have been selected. Note that no filter is created at the    ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"frequency of (base frequency + separation). For example: if  ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"separation=1 and num.filters=2 filters will be created at    ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"the base frequency and a tritone above the base frequency    ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"(i.e. a interval of 1/2 and octave). I suspect this is a     ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"mistake in the opcode implementation so in this example I    ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"rescale the separation interval before passing it to the     ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"resony opcode so that the interval between the lowest and    ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"highest filter in this mode will always be the interval      ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"defined in the GUI. A further option I have provided allows  ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"the defined interval to be the interval between adjacent     ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"filters rather than the interval from lowest to highest.     ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"If 'hertz' separation mode is selected behaviour is somewhat ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"curious. I have made some modifications to the values passed ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"to the opcode to make this mode more controllable. Without   ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"these modifications, if number of filters is '1' no filters  ", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"would be created. The frequency relationship between filters ", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"in the stack always follows the harmonic series. Both 'Base  ", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"Frequency' and 'Separation' normally shift this harmonic     ", 	1,      5,     14,    490,    20,     5, 820
ih		 	FLbox  	"stack of filters up or down, for this reason I have disabled ", 	1,      5,     14,    490,    20,     5, 840
ih		 	FLbox  	"user control of 'Separation' in this example, instead a value", 	1,      5,     14,    490,    20,     5, 860
ih		 	FLbox  	"equal to the 'Number of Filters' will always be used for     ", 	1,      5,     14,    490,    20,     5, 880
ih		 	FLbox  	"'Separation'. This ensures that a harmonic stack will always ", 	1,      5,     14,    490,    20,     5, 900
ih		 	FLbox  	"be created built upon 'Base Frequency' as the fundamental.   ", 	1,      5,     14,    490,    20,     5, 920
ih		 	FLbox  	"Negative values for 'separation' are allowed whenever        ", 	1,      5,     14,    490,    20,     5, 940
ih		 	FLbox  	"'separation mode' is 'octaves' (if this is the case, the     ", 	1,      5,     14,    490,    20,     5, 960
ih		 	FLbox  	"stack of frequencies will extend below the base frequency).  ", 	1,      5,     14,    490,    20,     5, 980
ih		 	FLbox  	"Negative values for 'separation' when 'separation mode' is   ", 	1,      5,     14,    490,    20,     5,1000
ih		 	FLbox  	"'hertz' will cause filters to 'explode'. As 'Separation'     ", 	1,      5,     14,    490,    20,     5,1020
ih		 	FLbox  	"is fixed at 'Number of Filters' in this example this         ", 	1,      5,     14,    490,    20,     5,1040
ih		 	FLbox  	"explosion will not occur.                                    ", 	1,      5,     14,    490,    20,     5,1060
ih		 	FLbox  	"This example can also be played using a MIDI keyboard in     ", 	1,      5,     14,    490,    20,     5,1080
ih		 	FLbox  	"which case MIDI note will be interpreted as 'Base Frequency'.", 	1,      5,     14,    490,    20,     5,1100

				FLscroll_end
				FLpanel_end                                                                   

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;A UDO IS CREATED WHICH ENCAPSULATES THE MODIFICATIONS TO THE resony OPCODE DISCUSSED IN THIS EXAMPLE 
opcode	resony2,a,akkikiii
	ain, kbf, kbw, inum, ksep , isepmode, iscl, iskip	xin

	;IF 'Octaves (Total)' MODE SELECTED...
	if isepmode==0 then
	 irescale	divz	inum,inum-1,1	;PREVENT ERROR IS NUMBER OF FILTERS = ZERO
	 ksep = ksep * irescale			;RESCALE SEPARATION
	
	;IF 'Hertz' MODE SELECTED...	
	elseif isepmode==1 then
	 inum	=	inum + 1
	 ksep	=	inum

	;IF 'Octaves (Adjacent)' MODE SELECTED...
	elseif isepmode==2 then 
	 irescale	divz	inum,inum-1,1	;PREVENT ERROR IS NUMBER OF FILTERS = ZERO
	 ksep = ksep * irescale			;RESCALE SEPARATION
	 ksep = ksep * (inum-1)			;RESCALE SEPARATION INTERVAL ACCORDING TO THE NUMBER OF FILTERS CHOSEN
	 isepmode	=	0
	endif

	aout 		resony 	ain, kbf, kbw, inum, ksep , isepmode, iscl, iskip
			xout	aout
endop


instr	1	
	kporttime	linseg	0,0.001,0.005,1,0.005	;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A SET VALUE	

	iMIDIActiveValue	=	1		;IF MIDI ACTIVATED
	iMIDIflag		=	0		;IF FLTK ACTIVATED
	mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 

	icps	cpsmidi		;READ MIDI PITCH VALUES - THIS VALUE CAN BE MAPPED TO GRAIN DENSITY AND/OR PITCH DEPENDING ON THE SETTING OF THE MIDI MAPPING SWITCHES

	kMIDIflag	init	iMIDIflag

	if	gkOnOff=0&&kMIDIflag=0	then 	;SENSE FLTK ON/OFF SWITCH & WHETHER THIS IS A MIDI NOTE ITS STATUS WILL BE IGNORED
		turnoff				;TURNOFF THIS INSTRUMENT IMMEDIATELY
	endif					;END OF THIS CONDITIONAL BRANCH

	if kMIDIflag=1 then			;IF THIS IS A MIDI ACTIVATED NOTE...
	 kbf	=	icps			;MAP MIDI NOTE VALUE TO BASE FREQUENCY
	else					;OTHERWISE...
	 kbf	portk	gkbf, kporttime		;SMOOTH MOVEMENT OF SLIDER VARIABLE TO CREATE BASE FREQUENCY
	endif					;END OF THIS CONDITIONAL BRANCH

	ksep	portk	gksep, kporttime	;SMOOTH MOVEMENT OF SLIDER VARIABLE

	;OUTPUTS	OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
	asigL, asigR	diskin2	"Seashore.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)
	kSwitch		changed	gkscl, gkskip, gknum, gksepmode		;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	START			;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif
	START:
	
	isepmode	init	i(gksepmode)
	inum		init	i(gknum)	
	iscl		init	i(gkscl)
	iskip		init	i(gkskip)
	
	;CALL resony2 UDO
	aresL 		resony2 asigL, kbf, gkbw, inum, ksep , isepmode, iscl, iskip
	aresR 		resony2	asigR, kbf, gkbw, inum, ksep , isepmode, iscl, iskip

	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
			outs	aresL * gkgain, aresR * gkgain	;SEND FILTER OUTPUT TO THE AUDIO OUTPUTS AND SCALE USING THE FLTK SLIDER VARIABLE gkgain
endin

instr	UpdateWidgets
	ktrig1	changed	gksep
	FLsetVal	ktrig1, gksep*12, gihsep2
	ktrig2	changed	gksep2
	FLsetVal	ktrig2, gksep2/12, gihsep1
endin

</CsInstruments>

<CsScore>
i "UpdateWidgets" 0 3600	;UPDATE SEPARATION DISPLAY BOX
</CsScore>

</CsoundSynthesizer>