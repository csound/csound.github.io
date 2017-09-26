;Written by Iain McCurdy, 2006

;THE BABO OPCODE IS PLACED IN A SEPARATE, ALWAYS ON, INSTRUMENT FROM THE SOURCE SOUND PRODUCING INSTRUMENT.
;THE IS A COMMONLY USED TECHNIQUE WITH TIME SMEARING OPCODES AND EFFECTS LIKE REVERBS AND DELAYS.

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	100	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;				LABEL    | WIDTH | HEIGHT | X | Y
			FLpanel	"Babo",     1000,   450,    0,  0

;SWITCHES						ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    120,     25,    5,  5,    0,      1,      0,       -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkinput, ihinput		FLbutBank	14,     1,     2,     18,      40,   230, 0,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Input", 		1,       5,    14,     50,      20, 180,   0
ih		 	FLbox  	"Drum Loop", 		1,       5,    14,     75,      20, 250,   0
ih		 	FLbox  	"Live     ", 		1,       5,    14,     75,      20, 250,  20

;VALUE_DISPLAY_BOXES				WIDTH | HEIGHT | X | Y
idmix				FLvalue	"",     80,       18,    5,  75
idrx				FLvalue	"",     80,       18,    5, 125
idry				FLvalue	"",     80,       18,    5, 175
idrz				FLvalue	"",     80,       18,    5, 225
idsrcx				FLvalue	"",     80,       18,    5, 275
idsrcy				FLvalue	"",     80,       18,    5, 325
idsrcz				FLvalue	"",     80,       18,    5, 375
iddiff				FLvalue	"",     80,       18,    5, 425
iddecay				FLvalue	"",     80,       18,  505,  75
idrdistance			FLvalue	"",     80,       18,  505, 125
idhydecay			FLvalue	"",     80,       18,  505, 175
iddirect			FLvalue	"",     80,       18,  505, 225
idearly_diff			FLvalue	"",     80,       18,  505, 275
idrcvx				FLvalue	"",     80,       18,  505, 325
idrcvy				FLvalue	"",     80,       18,  505, 375
idrcvz				FLvalue	"",     80,       18,  505, 425

;SLIDERS					            			MIN | MAX  | EXP | TYPE | DISP      |  WIDTH | HEIGHT | X | Y
gkmix,ihmix			FLslider 	"Dry/Wet Mix",			0,      1,    0,    23,   idmix,        490,    25,     5,  50
gkrx,ihrx			FLslider 	"Room Size X",			.1,    20,    0,    23,   idrx,         490,    25,     5, 100
gkry,ihry			FLslider 	"Room Size Y",			.1,    20,    0,    23,   idry,         490,    25,     5, 150
gkrz,ihrz			FLslider 	"Room Size Z",			.1,    20,    0,    23,   idrz,         490,    25,     5, 200
gksrcx,ihsrcx			FLslider 	"Source Location X",		0,      1,    0,    23,   idsrcx,       490,    25,     5, 250
gksrcy,ihsrcy			FLslider 	"Source Location Y",		0,      1,    0,    23,   idsrcy,       490,    25,     5, 300
gksrcz,ihsrcz			FLslider 	"Source Location Z",		0,      1,    0,    23,   idsrcz,       490,    25,     5, 350
gkdiff,ihdiff			FLslider 	"HF Diffusion",			0,      1,    0,    23,   iddiff,       490,    25,     5, 400
gkingain,ihingain		FLslider 	"Live Input Gain",		0,      1,    0,    23,   -1,           140,    20,   350,   5
gkdecay,ihdecay			FLslider 	"Reverb Decay",			0.01,   1,    0,    23,   iddecay,      490,    25,   505,  50
gkrdistance,ihrdistance		FLslider 	"Pick-up Separation",		0.001, 10,   -1,    23,   idrdistance,  490,    25,   505, 100
gkhydecay,ihhydecay		FLslider 	"H.F. Decay",			0.001,  1,    0,    23,   idhydecay,    490,    25,   505, 150
gkdirect,ihdirect		FLslider 	"Direct Signal Attenuation",	0,      1,    0,    23,   iddirect,     490,    25,   505, 200
gkearly_diff,ihearly_diff	FLslider 	"Early Reflection Diffusion",	0,      1,    0,    23,   idearly_diff, 490,    25,   505, 250
gkrcvx,ihrcvx			FLslider 	"Receiver Location X",		-10,   10,    0,    23,   idrcvx,       490,    25,   505, 300
gkrcvy,ihrcvy			FLslider 	"Receiver Location Y",		-10,   10,    0,    23,   idrcvy,       490,    25,   505, 350
gkrcvz,ihrcvz			FLslider 	"Receiver Location Z",		-10,   10,    0,    23,   idrcvz,       490,    25,   505, 400

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	0.5, 	ihmix
		FLsetVal_i	5, 	ihrx
		FLsetVal_i	6, 	ihry
		FLsetVal_i	4, 	ihrz
		FLsetVal_i	0.5, 	ihsrcx
		FLsetVal_i	0.5, 	ihsrcy
		FLsetVal_i	0.5, 	ihsrcz
		FLsetVal_i	1, 	ihdiff
		FLsetVal_i	0.99, 	ihdecay
		FLsetVal_i	0.3, 	ihrdistance
		FLsetVal_i	0.1, 	ihhydecay
		FLsetVal_i	0.5, 	ihdirect
		FLsetVal_i	0.8, 	ihearly_diff
		FLsetVal_i	0, 	ihrcvx
		FLsetVal_i	0, 	ihrcvy
		FLsetVal_i	0, 	ihrcvz

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 580, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"               babo - 'Ball within the Box'                  ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"babo is a physically modelled reverberator (babo is short for", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"'ball within the box') It works quite differently from       ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"Csound's traditional reverberators in that instead of        ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"defining the duration of the reverb effect the user defines  ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"the dimensions of the resonating space and the location of   ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"the sound source. The acoustic reflectiveness of the         ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"room boundaries is controlled by a parameter for high        ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"frequency diffusion.                                         ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"The room size parameters are in metres. The source location  ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"parameters are also in metres but in this example they are   ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"given as ratios (0 to 1) of the room's X, Y and Z dimensions.", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"The opcode also offers a variety of optional 'expert'        ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"parameters that are accessible through via stored values     ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"in a function table. This example implements direct GUI      ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"interaction with these parameter and their sliders are found ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"on the right hand side of the GUI. There are parameters for  ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"reverb decay, pick-up separation (i.e. the distance between  ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"your ears) in metres, high frequency decay, direct signal    ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"attenuation, early reflection diffusion and X Y Z            ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"co-ordinates in metres (from the centre of the space) of the ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"receiver. Certain settings for the receiver co-ordinates in  ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"conjunction with settings for the size of the room and       ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"location of the source sound cause Csound to crash. Future   ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"updates to this example will attempt to protect against this.", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"In this example the user can choose between a sound file     ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"input or the computer's live input. An input gain control on ", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"the live input is also provided.                             ", 	1,      5,     14,    490,    15,     5, 560

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	tables
;FUNCTION TABLE WHICH STORES ADDITIONAL (AND OPTIONAL) INPUT PARAMETERS FOR THE BABO OPCODE
giBaboVals	ftgentmp	0, 0, 8, -2, i(gkdecay), i(gkhydecay), i(gkrcvx), i(gkrcvy), i(gkrcvz), i(gkrdistance), i(gkdirect), i(gkearly_diff)
endin

instr	1	;PLAYS FILE AND OUTPUTS GLOBAL VARIABLES
	if gkOnOff=0	then
		turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif
	if	gkinput==0	then	;IF INPUT 'Drum Loop' IS SELECTED...
		gasigL, gasigR	diskin2	"808loop.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)		
	else				;OTHERWISE
		asigL, asigR	ins	;TAKE INPUT FROM COMPUTER'S AUDIO INPUT
		gasigL	=	asigL * gkingain	;SCALE USING 'Input Gain' SLIDER
		gasigR	=	asigR * gkingain	;SCALE USING 'Input Gain' SLIDER
	endif						;END OF CONDITIONAL BRANCHING
endin

instr	2	;REVERB - ALWAYS ON
	aL	=	gasigL
	aR	=	gasigR
	kSwitch		changed		gkrx, gkry, gkrz, gksrcx, gksrcy, gksrcz, gkdiff, gkdecay, gkrdistance, gkhydecay, gkdirect, gkearly_diff, gkrcvx, gkrcvy, gkrcvz	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then	;IF kSwitch=1 THEN
		reinit	UPDATE		;BEGIN A REINITIALIZATION PASS FROM LABEL 'UPDATE'
	endif				;END OF CONDITIONAL BRANCHING
	UPDATE:				;A LABEL
	irx		init	i(gkrx)	;CREATE I-RATE VARIABLES FROM K-RATE VARIABLES
	iry		init	i(gkry) ;CREATE I-RATE VARIABLES FROM K-RATE VARIABLES
	irz		init	i(gkrz) ;CREATE I-RATE VARIABLES FROM K-RATE VARIABLES
	ksrcx		init	i(gksrcx) * irx	;THE ACTUAL LOCATION OF THE SOURCE SOUND IS DEFINED RELATIVE TO THE SIZE OF THE ROOM
	ksrcy		init	i(gksrcy) * iry	;THE ACTUAL LOCATION OF THE SOURCE SOUND IS DEFINED RELATIVE TO THE SIZE OF THE ROOM
	ksrcz		init	i(gksrcz) * irz	;THE ACTUAL LOCATION OF THE SOURCE SOUND IS DEFINED RELATIVE TO THE SIZE OF THE ROOM
	idiff		init	i(gkdiff) ;CREATE I-RATE VARIABLES FROM K-RATE VARIABLES
	tablew	i(gkdecay),     0, giBaboVals	;UPDATE TABLE VALUES
	tablew	i(gkhydecay),   1, giBaboVals	;UPDATE TABLE VALUES
	tablew	i(gkrcvx),      2, giBaboVals	;UPDATE TABLE VALUES
	tablew	i(gkrcvy),      3, giBaboVals	;UPDATE TABLE VALUES
	tablew	i(gkrcvz),      4, giBaboVals	;UPDATE TABLE VALUES
	tablew	i(gkrdistance), 5, giBaboVals	;UPDATE TABLE VALUES
	tablew	i(gkdirect),    6, giBaboVals	;UPDATE TABLE VALUES
	tablew	i(gkearly_diff),7, giBaboVals	;UPDATE TABLE VALUES
	aRvbL, aRvbR	babo	aL + aR, ksrcx, ksrcy, ksrcz, irx, iry, irz, idiff, giBaboVals	;BABO REVERBERATOR
	rireturn			;RETURN TO PERFORMANCE TIME PASSES
		outs	(aRvbL * gkmix) + (aL * (1 - gkmix)), (aRvbR * gkmix) + (aR * (1 - gkmix))	;CREATE THE WET DRY MIX AT THE OUTPUTS
endin
	
</CsInstruments>

<CsScore>
i "tables" 0 3600
i 2 0.01 3600	;REVERB INSTRUMENT PLAYS FOR 1 HOUR (AND KEEPS PERFORMANCE GOING)
</CsScore>

</CsoundSynthesizer>