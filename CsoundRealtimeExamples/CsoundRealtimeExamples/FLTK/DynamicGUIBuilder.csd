DynamicGUIBuilder.csd
Written by Iain McCurdy 2011

<CsoundSynthesizer>

<CsOptions>
-odac -dm0 -M0 -+rtmidi=virtual

;-odac -dm0 -Ma
</CsOptions>                                                                                                                                                   

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	128	;K-RATE MAY NEED TO BE QUITE HIGH
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM SOUND INTENSITY LEVEL REGARDLESS OF BIT DEPTH
zakinit	4,1;	DECLARE ZAK SPACE (USED TO ACCUMULATE AUDIO FROM INDIVIDUAL LAYERS WHICH ARE THEN RETRIVED ABD SENT TO THE MAIN OUTPUT)

;-----------------------------
;CREATE THE MAIN CONTROL PANEL
;-----------------------------
FLcolor	255, 255, 255, 0, 0, 0
;	LABEL    | WIDTH | HEIGHT |  X  | Y
FLpanel	"Main",    920,    100,     0,   0
;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE
gklayers, ihlayers		FLcount  "Number of Layers", 	0,    100,    1,     10,      2,    100,     25,    5,   5,   -1
gknote, ihnote			FLcount  "Base Note (No MIDI)", 1,    126,    1,     10,      2,    100,     25,  110,  38,   -1
;SWITCHES                                  			ON | OFF | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE
gkNoMIDI,ihNoMIDI		FLbutton	"No MIDI",	1,    0,     2,    100,    25,    110,  5,    0, 1, 0, -1
FLsetColor2	255,255,50,ihNoMIDI
;SUB PANELS						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih			FLbox  	"", 			6,      9,     15,    170,    94,    216, 4
ih			FLbox  	"Amplitude Envelope", 	1,     10,     14,    160,    20,    221, 5
;KNOBS						MIN | MAX | EXP|  TYPE | DISP | WIDTH | X | Y
gkAmpA, ihAmpA			FLknob	"Att.",	0.005,15,   -1,    1,     -1,    40,   220, 28
gkAmpD, ihAmpD			FLknob	"Dec.",	0.005,15,   -1,    1,     -1,    40,   260, 28
gkAmpS, ihAmpS			FLknob	"Sus.",	    0, 1,    0,    1,     -1,    40,   300, 28
gkAmpR, ihAmpR			FLknob	"Rel.",	0.005,15,   -1,    1,     -1,    40,   340, 28
;SUB PANELS						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih			FLbox  	"", 			6,      9,     15,    275,    94,    391, 4
ih			FLbox  	"Filter", 		1,     10,     14,    265,    20,    396, 5
;KNOBS						MIN | MAX | EXP|  TYPE | DISP | WIDTH | X | Y
gkFiltA, ihFiltA		FLknob	"Att.",	0.005,15,   -1,    1,     -1,    40,   395, 28
gkFiltD, ihFiltD		FLknob	"Dec.",	0.005,15,   -1,    1,     -1,    40,   435, 28
gkFiltS, ihFiltS		FLknob	"Sus.",	    0, 1,    0,    1,     -1,    40,   475, 28
gkFiltR, ihFiltR		FLknob	"Rel.",	0.005,15,   -1,    1,     -1,    40,   515, 28
gkFiltE, ihFiltE		FLknob	"Env.",	    0, 1,    0,    1,     -1,    40,   565, 28
gkFiltRes, ihFiltRes		FLknob	"Res.",	    0,0.95,  0,    1,     -1,    40,   615, 28                                                                        
;SUB PANELS						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y                                                                                  
ih			FLbox  	"", 			6,      9,     15,    90,    94,    671, 4
ih			FLbox  	"Reverb", 		1,     10,     14,    80,    20,    676, 5
;KNOBS						MIN | MAX | EXP|  TYPE | DISP | WIDTH | X | Y
gkRvbSnd, ihRvbSnd		FLknob	"Level",0,     1,    0,    1,     -1,    40,   675, 28
gkRvbTim, ihRvbTim		FLknob	"Time",	0.3,   1,    0,    1,     -1,    40,   715, 28
gkOutGain, ihOutGain		FLknob	"Gain", 0,     5,    0,    1,     -1,    40,   765, 28
;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE
gkPBRange, ihPBRange		FLcount  "Pitch Bend Range", 	-24,   24,    1,     10,      2,    100,     25,   810,   5,   -1
;SET INITIAL VALUES OF FL_VALUATORS
FLsetVal_i	7,ihlayers
FLsetVal_i	36,ihnote
FLsetVal_i	0.01,ihAmpA
FLsetVal_i	0.01,ihAmpD
FLsetVal_i	1,ihAmpS
FLsetVal_i	1,ihAmpR
FLsetVal_i	0.15,ihFiltA
FLsetVal_i	1,ihFiltD
FLsetVal_i	1,ihFiltS
FLsetVal_i	1,ihFiltR
FLsetVal_i	1,ihFiltE
FLsetVal_i	0.1,ihFiltRes
FLsetVal_i	0.25,ihRvbSnd
FLsetVal_i	0.9,ihRvbTim
FLsetVal_i	1,ihOutGain
FLsetVal_i	2,ihPBRange
FLpanel_end	;END OF PANEL CONTENTS

;---------------------------
;INSTRUCTIONS AND INFO PANEL
;---------------------------
				FLpanel	"info.", 515, 700, 560, 180
				FLscroll         515, 700, 0, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                     Dynamic GUI Builder                     ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"This example demonstrates a technique for building (or       ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"destroying) a GUI during a Csound performance.               ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"This can be useful in a application thay employs multiple and", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"a variable number of layers. The code mechanisms used to     ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"implement this have been optimised to minimize code          ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"repetition and to facilitate expansion or transplantation to ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"another project.                                             ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"The key technique used is recursion using UDOs, a technique  ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"introduced by Steven Yi in the Csound journal.               ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"The panel within which GUI element can be added or removed   ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"dynamically is created within the orchestra (and not in the  ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"header / instrument 0 as is normal).                         ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"In reality all 100 possible layers are created at the        ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"beginning of performance but it is dynamically reflected     ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"whether that layer should be shown or hidden whenever the    ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"'Num.Layers' counter is modified.                            ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"The value outputs of all dynamically created widgets are     ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"written to function tables, referenced by the layer number.  ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"This is done so that all widget values can also be referenced", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"by a separate instrument that actually synthesizes sound     ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"without the need of using widget output variable names and   ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"global variables.                                            ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"The dynamic GUI and synthesizer parts of this example are in ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"different instruments because the GUI part will be activated ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"only once at the beginning of performance and will be always ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"on whereas the synthesizer part can be activated multiple    ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"times via midi. Re-draws of the GUI when 'Num.Layers' changes", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"are implemented using a reinitialisation pass of part of the ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"GUI building instrument. If MIDI activation of the           ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"synthesizer part of the example was not required then the    ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"synth part could be included in the GUI builder instrument.  ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"The code could then be simplified further as the writing and ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"reading from tables would no longer be required as the widget", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"values used by the synthesizer layers would be avaliable     ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"locally.                                                     ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"In this example each layer is a 'gbuzz' derived tone.        ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"Each layer can be independently transposed (in semitones or  ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"fractions thereof) and its spectral characteristics set.     ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"LFOs can modulate the amplitude coefficient multipliers and  ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"pan positions to create textures with internal movement.     ", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"There are global envelopes for control of amplitude and the  ", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"cutoff frequency of a resonant lowpass filter. Pitch bend    ", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"and velocity are available on MIDI activated notes.          ", 	1,      5,     14,    490,    20,     5, 820
				FLscroll_end                                                                                     
				FLpanel_end

instr	tables
ginotes		ftgen	0,0,128,-2,0	;TABLE TO STORE NOTE NUMBERS
gicos		ftgen	0,0,131072,11,1	;COSINE WAVE

;FLTK_VALUATORS_TABLES
;DYNAMICALLY CREATED WIDGETS VALUES ARE WRITTEN TO THESE TABLES, TABLE LOCATIONS ARE DETERMINED BY THE LAYER NUMBER
;THE REASON THIS IS DONE IS SO THAT THE VALUES CAN BE RETRIEVED IN A SEPARATE INSTRUMENT AGAIN USING THE LAYER COUNTER AND WITHOUT THE NEED TO USE THE VARIABLE NAME
gitrans	ftgen	0,0,128,-2,0
ginh	ftgen	0,0,128,-2,0
gilh	ftgen	0,0,128,-2,0
gimul	ftgen	0,0,128,-2,0
gimulLD	ftgen	0,0,128,-2,0
gimulLR	ftgen	0,0,128,-2,0
gipan	ftgen	0,0,128,-2,0
gipanLD	ftgen	0,0,128,-2,0
gipanLR	ftgen	0,0,128,-2,0
giAmp	ftgen	0,0,128,-2,0
gisolo	ftgen	0,0,128,-2,0
gkSoloSum	init	0
gasendL	init	0
gasendR	init	0
endin

;--------------------------------------------------------------------------
;UDOS (USER DEFINED OPCODES) - USED IN THIS EXAMPLE TO FACILITATE RECURSION
;--------------------------------------------------------------------------
;UDO FOR CREATING A SINGLE LAYER OF GUI. NO OUTPUT ARGS. 2 I-RATE INPUT ARGS.
;NOTE THAT ALL Y-POSITION VALUES FOR WIDGETS ARE RELATED TO THE LAYER COUNT INDEX VALUE - THIS ENSURES THE CORRECT POSITIONING OF THE WIDGETS FOR EACH LAYER
opcode	GUIlayer,0,ii															
	icount,imax	xin														;READ IN INPUT ARGUMENTS

	;---BUILD THE GUI WIDGETS FOR THIS LAYER (GLOBAL VARIABLES ARE NOT USED AS OUTPUTS AS VALUES ARE LOCAL TO THIS LAYER---
	;SUB PANELS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
	ihborder		FLbox  	"", 	1,      9,     15,    530,    96,    2, 2+(100*(icount-1))				;CREATE A BORDER AROUND THE LAYER
	ired	random	150,255.99													;GENERATE RANDOM COLOR VALUES FOR THIS LAYER
	igreen	random	150,255.99
	iblue	random	150,255.99
			FLsetColor	ired,igreen,iblue,ihborder									;COLOURIZE THE PANEL
	;VALUE INPUT BOXES				 	MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X |         Y
	ktrans, ihtrans		FLtext		"Trans", 	-127, 127,  0.01,   1,      50,     25,   25, 5+(100*(icount-1))	;TRANSPOSITION COUNTER
	;SWITCHES                                  	ON | OFF | TYPE | WIDTH | HEIGHT | X  |        Y          | OPCODE
	ksolo,ihsolo		FLbutton	"solo",	1,    0,     2,     50,      28,   25,  48+(100*(icount-1)),    0,3,0.01,0.01	;SOLO BUTTON
	FLsetColor2	255,55,55,ihsolo												;SET 'ON' COLOUR FOR SOLO BUTTON (RED)
	;COUNTERS				MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X  |        Y          | OPCODE	
	knh, ihnh 	FLcount  "Num.Harms.", 	1,   500,      1,    10,     11,    140,     25,   80,   5+(100*(icount-1)),   -1	;NUMBER OF GBUZZ HARMONICS COUNTER
	klh, ihlh 	FLcount  "Lowest Harm.",1,   500,      1,    10,     11,    140,     25,   80,  50+(100*(icount-1)),   -1	;LOWEST GBUZZ HARMONIC COUNTER
	;SUB PANELS					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
	ih1		FLbox  	"", 			6,      9,     15,    128,    94,    266, 4+(100*(icount-1))			;CREATE PANEL AROUND AMPLITUDE MULTIPLER CONTROLS
	ih2		FLbox  	"Amp. Multiplier", 	1,     10,     14,    118,    20,    271, 5+(100*(icount-1))			;CREATE AMPLITUDE MULTIPLER PANEL LABEL
	Scount		sprintf	"%d", icount
	ihcount		FLbox  	"", 			1,     10,     14,     20,    20,      1, 5+(100*(icount-1))			;CREATE AMPLITUDE MULTIPLER PANEL LABEL
			FLsetText Scount, ihcount
			FLsetColor	ired,igreen,iblue,ihcount									;COLOURIZE THE PANEL
	;KNOBS					MIN | MAX | EXP|  TYPE | DISP | WIDTH | X | Y
	kmul, ihmul	FLknob	"Base",		0,   1.5,    0,    1,     -1,    40,   270,22+(100*(icount-1))				;AMPLITUDE MULTIPLIER CONTROL KNOB
	kmulLD, ihmulLD	FLknob	"LFO Dep.",	0,  0.75,    0,    1,     -1,    40,   310,22+(100*(icount-1))				;AMPLITUDE MULTIPLIER LFO DEPTH CONTROL KNOB
	kmulLR, ihmulLR	FLknob	"LFO Rate",	0.001,20,   -1,    1,     -1,    40,   350,22+(100*(icount-1))				;AMPLITUDE MULTIPLER LFO RATE CONTROL KNOB
	;SUB PANELS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
	ih3		FLbox  	"", 		6,      9,     15,    128,    94,    396, 4+(100*(icount-1))				;CREATE PANEL AROUND PANNING CONTROLS
	ih4		FLbox  	"Panning", 	1,     10,     14,    118,    20,    401, 5+(100*(icount-1))				;CREATE PANNING PANEL LABEL
	;KNOBS					MIN | MAX | EXP|  TYPE | DISP | WIDTH | X | Y
	kpan, ihpan	FLknob	"Pan",		0,     1,    0,     1,    -1,    40,   400,22+(100*(icount-1))				;PAN POSITION CONTROL KNOB
	kpanLD, ihpanLD	FLknob	"LFO Dep.",	0,     1,    0,     1,    -1,    40,   440,22+(100*(icount-1))				;PAN POSITION LFO DEPTH CONTROL KNOB
	kpanLR, ihpanLR	FLknob	"LFO Rate",	0.001,20,   -1,     1,    -1,    40,   480,22+(100*(icount-1))				;PAN POSITION LFO RATE CONTROL KNOB
	kAmp, ihAmp	FLknob	"Amp.",		0,     1,    0,     1,    -1,    40,   225,22+(100*(icount-1))				;AMPLITUDE CONTROL KNOB

	;---SET INITIAL VALUES FOR FLTK CONTROLS (ALL VALUES ARE RANDOMIZED SO THAT EACH LAYER WILL HAVE DIFFERENT CHARACTERISTICS)---
	FLsetVal_i	(int(rnd(5))*12)-24+rnd(0.1)-0.05,ihtrans									;SET INITIAL VALUE FOR TRANSPOSITION (A RANDOM OCTAVE WITH A LITTLE BIT OF DETUNING)
	FLsetVal_i	int(rnd(30)),ihnh												;SET INITIAL VALUE FOR GBUZZ NUMBER OF HARMONICS
	FLsetVal_i	int(rnd(6)),ihlh												;SET INITIAL VALUE FOR GBUZZ LOWEST HARMONIC
	FLsetVal_i	(rnd(0.7)),ihmul												;SET INITIAL VALUE FOR AMPLITUDE MULTIPLIER
	FLsetVal_i	rnd(0.6),ihmulLD												;SET INITIAL VALUE FOR AMPLITUDE MULTIPLIER LFO DEPTH
	FLsetVal_i	rnd(0.6),ihmulLR												;SET INITIAL VALUE FOR AMPLITUDE MULTIPLIER LFO RATE 
	FLsetVal_i	rnd(1),ihpan													;SET INITIAL VALUE FOR PAN POSITION
	FLsetVal_i	rnd(1),ihpanLD													;SET INITIAL VALUE FOR PAN LFO DEPTH
	FLsetVal_i	rnd(1),ihpanLR													;SET INITIAL VALUE FOR PAN LFO RATE 
	FLsetVal_i	rnd(0.5)+0.5,ihAmp												;SET INITIAL VALUE FOR AMPLITUDE

	;---WRITE GUI WIDGET OUTPUTS FOR THIS LAYER TO FUNCTION TABLES. TABLE LOCATIONS ARE REFERENCED USING THE LAYER COUNTER. 
	;---'tabw' IS USED, AS OPPOSED TO 'tablew' FOR INCREASED EFFICIENCY---
	tabw	ktrans	,icount,gitrans
	tabw	knh	,icount,ginh	
	tabw	klh	,icount,gilh	
	tabw	kmul	,icount,gimul	
	tabw	kmulLD	,icount,gimulLD	
	tabw	kmulLR	,icount,gimulLR	
	tabw	kpan	,icount,gipan	
	tabw	kpanLD	,icount,gipanLD	
	tabw	kpanLR	,icount,gipanLR
	tabw	kAmp	,icount,giAmp
	tabw	ksolo	,icount,gisolo
	
	;I-RATE CHECK TO SEE WHETHER THIS LAYER SHOULD EXIST
	ktrig	changed	gklayers				;CREATE A TRIGGER IF THE NUMBER OF LAYERS COUNTER HAS BEEN CHANGED
	if ktrig==1 then					;IF NUMBER OF LAYERS COUNTER HAS BEEN CHANGED...
	  reinit	ShowOrHide				;BEGIN A REINIT. PASS TO CHECK WHETHER TO SHOW OR HIDE THIS LAYER
	endif							;END OF CONDITIONAL BRANCH
	ShowOrHide:						;REINIT. PASS BEGINS HERE...
	ilayers	init	i(gklayers)				;CREATE I-TIME READING OF NUMBER OF LAYERS
	if icount>ilayers+1 then				;IF COUNTER FOR THIS LAYER IS ABOVE LAYERS LIMIT...
	  FLhide 	ihtrans					;HIDE ALL WIDGETS FOR THIS LAYER...
	  FLhide 	ihnh
	  FLhide	ihlh
	  FLhide	ihborder
	  FLhide	ihmul
	  FLhide	ihmulLD
	  FLhide	ihmulLR
	  FLhide	ihpan
	  FLhide	ihpanLD
	  FLhide	ihpanLR
	  FLhide	ihAmp
	  FLhide	ih1
	  FLhide	ih2
	  FLhide	ih3
	  FLhide	ih4
	  FLhide	ihsolo
	  FLhide	ihcount
	  ;FLsetVal_i	0,ihsolo				;DISABLE A LAYER'S 'SOLO' IF IT IS REMOVED (THIS LINE SEEMS TO CREATE PROBLEMS ON WINDOWS, OTHER PLATFORMS OKAY)
	else							;OTHERWISE...
	  FLshow	ihtrans					;SHOW ALL WIDGETS FOR THIS LAYER...
	  FLshow	ihnh
	  FLshow	ihlh
	  FLshow	ihborder
	  FLshow	ihmul
	  FLshow	ihmulLD
	  FLshow	ihmulLR
	  FLshow	ihpan
	  FLshow	ihpanLD
	  FLshow	ihpanLR
	  FLshow	ihAmp
	  FLshow	ih1
	  FLshow	ih2
	  FLshow	ih3
	  FLshow	ih4
	  FLshow	ihsolo
	  FLshow	ihcount
	endif	  						;END OF 'SHOW OR HIDE' CONDITIONAL
	rireturn						;RETURN FROM REINIT. PASS

	;---CONTINUE TO CREATE *ALL* LAYERS UP TO MAXIMUM. DECIDE WITHIN THE LAYER WHETHER IT SHOULD BE HIDDEN OR SHOWN.---
	if icount<=imax then		;IF COUNTER IS STILL BELOW MAXIMUM POSSIBLE LAYERS LIMIT
	  icount=icount+1		;INCREMENT LAYER COUNTER
	  GUIlayer icount,imax		;RECURSIVELY CALL THIS UDO AGAIN
	endif				;END OF 'CREATE ANOTHER LAYER?' CONDITIONAL
endop

opcode	AudioLayer, 0, kii				;UDO THAT CREATES A SINGLE AUDIO LAYER. WILL BE CALLED RECURSIVELY FOR EACH ACTIVE LAYER
	knum,icount,ilayers	xin			;READ IN INPUT ARGS. 'NOTE NUMBER', LAYER COUNTER', 'NUMBER OF LAYERS'

	;---READ IN SOUND CREATION PARAMETERS FROM FLTK WIDGETS FOR THIS LAYER FUNCTION TABLES. WIDGET PARAMETERS FOR THIS LAYER ARE REFERENCED BY THE LAYER COUNTER. 'tab' IS USED FOR SPEED---
	ktrans		tab	icount,gitrans
	knh		tab	icount,ginh	
	klh		tab	icount,gilh	
	kmul		tab	icount,gimul	
	kmulLD		tab	icount,gimulLD	
	kmulLR		tab	icount,gimulLR	
	kpan		tab	icount,gipan	
	kpanLD		tab	icount,gipanLD	
	kpanLR		tab	icount,gipanLR	
	kAmp		tab	icount,giAmp
	ksolo		tab	icount,gisolo

	;---CREATE AUDIO---
	if gkSoloSum=0||ksolo=1 then								;ONLY CREATE AUDIO FOR LAYER AND ADD IT TO THE STACK IF ALL SOLOS ARE OFF OR IF THIS SOLO IS ON
	  kMulLFO	lfo	kmulLD,kmulLR,0							;CREATE LFO FOR AMPLITUDE COEFFICIENT MULTIPLER
	  asig	gbuzz	0.1*kAmp,cpsmidinn(knum+ktrans),knh,klh,kmul+kMulLFO,gicos		;CREATE GBUZZ ADDITIVE SYNTHESIS TONE
	  kPanLFO	lfo	0.5,kpanLR,0							;CREATE PANNING LFO
	  kpan	ntrpol	kpan,kPanLFO,kpanLD							;CROSS FADE BETWEEN STATIC PAN AND LFO PAN ACCORDING TO 'PANNING LFO DEPTH'
	  aL,aR	pan2	asig,kpan								;CREATE STEREO PANNED SIGNAL
		zawm	aL,1									;WRITE LEFT AND RIGHT CHANNELS OF AUDIO TO CONSECUTIVE ZAK CHANNELS 
		zawm	aR,2
	endif
	
	;---CONTINUE TO CREATE *ALL* LAYERS and DECIDE WITHIN THE LAYER WHETHER IT SHOULD BE HIDDEN OR NOT---
	if icount<=ilayers then			;IF LAYER COUNTER IS STILL BELOW NUMBER OF LAYERS COUNTER VALUE...
	  icount=icount+1			;INCREMENT COUNTER -
	  AudioLayer knum,icount,ilayers	;- AND RECURSIVELY CALL THIS UDO AGAIN TO CREATE ANOTHER AUDIO LAYER
	endif					;END OF 'CREATE ANOTHER LAYER?' CONDITIONAL 
endop

instr	1	;MIDI (OR FLTK BUTTON) ACTIVATED INSTRUMENT---
	;---CREATE A FLAG THAT WILL INFORM WHETHER THIS IS A MIDI ACTIVATED NOTE OR NOT
	iMIDIActiveValue	=	1		;IF MIDI ACTIVATED
	iMIDIflag		=	0		;IF FLTK ACTIVATED
	mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 
	
	;---SET NOTE NUMBER AND VELOCITY VALUES ACCORDING TO WHETHER THIS IS A MIDI ACTIVATED NOTE OR NOT
	if iMIDIflag=0 then		;IF NON-MIDI... (I.E. IF FLTK BUTTON ACTIVATED)
	  knum	=	gknote		;NOTE NUMBER FROM FLTK COUNTER
	  ivel	=	0.5		;VELOCITY PRESET VALUE
  	  if gkNoMIDI==0 then		;IF FLTK NOTE ACTIVATION BUTTON IS TURNED OFF...
	    turnoff			;TURN THIS INSTRUMENT OFF
	  endif

	else					;OTHERWISE... (I.E. MIDI ACTIVATED NOTE)
	  inum	notnum				;READ IN MIDI NOTE NUMBER
	  ivel	veloc	0,1			;READ IN MIDI VELOCITY
	  kbend	pchbend	0,2			;READ IN PITCH BEND, RANGE -2 SEMITONES TO +2 SEMITONES	  
	  knum	=	inum+(kbend*gkPBRange)	;KRATE VERSION OF NOTE NUMBER. ADD PITCH BEND.
	endif
	
		
	ktrig	changed	gklayers			;IF NUMBER OF LAYERS COUNTER HAS BEEN CHANGED GENERATE A TRIGGER IMPULSE
	if ktrig=1 then					;IF LAYER COUNTER HAS BEEN CHANGED...
	  reinit	UPDATE				;BEGIN A REINIT. PASS FROM LABEL 'UPDATE'
	endif
	UPDATE:						;BEGIN REINIT. PASS FROM HERE IF NUMBER OF LAYERS COUNTER HAS BEEN CHANGED
	icount	init	1				;INITIALISE LAYER COUNTER
	ilayers	init	i(gklayers)			;CREATE INIT. TIME READING OF NUMBER OF LAYERS
		AudioLayer	knum,icount,ilayers	;CALL AUDIO LAYER GENERATOR
	rireturn					;RETURN FROM REINIT. PASS TRIGGERED BY CHANGING NUMBER OF LAYERS COUNTER
	
	;READ THE ACCCUMULATED AUDIO AND SEND TO THE OUTPUTS
	aL	zar	1								;READ STEREO SIGNAL FROM CONSECUTIVE ZAK CHANNELS
	aR	zar	2
	kFenv	linsegr	0,i(gkFiltA),1,i(gkFiltD),i(gkFiltS)+0.0001,i(gkFiltR),0	;FILTER ENVELOPE (MAXIMUM RANGE 0 - 1)
	kcpsCF	=	cpsoct((kFenv*gkFiltE*10)+4)					;RESCALE ENVELOPE TO BE WITHIN THE MAXIMUM RANGE 4 - 14 (I.E. OCT FORMAT AUDIBLE RANGE), AND THEN CONVERT TO CPS FORMAT
	acpsCF	interp	kcpsCF								;CREATE A-RATE VERSION. THIS WILL SOUND SMOOTHER, PARTICULARLY IN AN ENVELOPE WITH FAST MOVING SEGMENTS. (NOTE THAT K-RATE IS LOW - ksmps IS HIGH)
	aL	moogvcf2	aL,acpsCF,gkFiltRes					;FILTER STEREO SIGNAL
	aR	moogvcf2	aR,acpsCF,gkFiltRes					
	aenv	expsegr	0.001,i(gkAmpA),1,i(gkAmpD),i(gkAmpS)+0.0001,i(gkAmpR),0.001	;CREATE AMPLITUDE ENVELOPE
	aL	=	aL*aenv*ivel*gkOutGain						;RESCALE AMPLITUDE OF STEREO AUDIO SIGNAL WITH AMP. ENVELOPE, NOTE VELOCITY, AND FLTK GAIN KNOB
	aR	=	aR*aenv*ivel*gkOutGain
		outs	aL,aR								;SEND STEREO AUDIO TO OUTPUTS
	gasendL	=	gasendL+(aL*gkRvbSnd)						;SEND A PROPORTION OF THE STEREO AUDIO TO THE REVERB EFFECT
	gasendR	=	gasendR+(aR*gkRvbSnd)
	zacl	0,4									;CLEAR ZAK AUDIO CHANNELS
endin

instr	2							;CREATE DYNAMIC GUI PANEL AND WIDGETS (ONLY ONE INSTANCE IF THIS INTRUMENT WILL EXIST)
	;---OPEN PANEL---
	;	LABEL           | WIDTH | HEIGHT | X | Y
	FLpanel	"Dynamic GUI",     550,    700,    0,  175	;CREATE PANEL                          
	FLscroll        	   550,    700,    0,    0			;MAKE THIS PANEL A SCROLL PANEL

	;---CALL FIRST LAYER OF THE GUI LAYER CREATION UDO---
	icount	init 1						;SET INITIAL VALUE FOR LAYER COUNTER
	imax	init 100					;SET MAXIMUM NUMBER OF LAYERS (ALL GUI LAYERS ARE CREATED INITIALLY, HOWEVER MOST WILL BE HIDDEN)
		GUIlayer	icount,imax			;CREATE GUI LAYER CREATION UDO
	
	;---CLOSE PANEL---
	FLscroll_end						;CLOSE THE SCROLL AREA AND THE PANEL
	FLpanel_end
	FLrun							;RUN THE FLTK WIDGET THREAD

endin

;SUM ALL SOLO BUTTONS INSTRUMENT 
;THIS IS DONE ON A SEPARATE INSTRUMENT SO THAT A NEW GLOBAL VARIABLE FOR THE SUM OF ALL SOLO BUTTONS WILL BE CREATED WHENEVER -
;- A SOLO BUTTON IS INTERACTED WITH (THIS INSTRUMENT IS TRIGGERED BY THE SOLO BUTTONS)
instr	3 
	ilayers		init	i(gklayers)		;CREATE I-TIME READING OF NUMBER OF LAYERS. (SOLO BUTTONS FOR INACTIVE LAYERS WILL NOT BE INCLUDED IN THE SUMMATION.)
	iSoloSum	init 	0			;INITIALISE THE SUMMATION VALUE
	iLoopCount	init 	1			;INITIALISE THE LOOP COUNTER
	LoopBegin:					;SEQUENTIAL SUMMATION LOOP BEGINS HERE
	isolo		tab_i	iLoopCount,gisolo	;READ SOLO ON/OFF VALUE FROM TABLE (REFERENCED USING THE LOOP COUNTER)
	iSoloSum	= 	iSoloSum + isolo	;ADD READ VALUE TO THE SUMMATION VALUE
	loop_le	iLoopCount,1,ilayers+1,LoopBegin	;REDO LOOP IF NOT ALL ACTIVE LAYERS HAVE BEEN INCLUDED YET
	gkSoloSum	=	iSoloSum		;WRITE SUMMATION VALUE TO K-RATE VARIABLE
			turnoff				;TURN OFF THIS INSTRUMENT
endin

instr	4								;REVERB (ALWAYS ON)
	aRvbL,aRvbR	reverbsc	gasendL,gasendR,gkRvbTim,10000	;CREATE A STEREO REVERB SIGNAL
			outs		aRvbL,aRvbR			;SEND REVERB SIGNAL TO THE OUTPUTS
			clear		gasendL,gasendR			;CLEAR GLOBAL AUDIO REVERB SEND VARIABLES
endin

</CsInstruments>

<CsScore>
i "tables" 0 3600
i 2 0.01 3600	;CREATE DYNAMIC GUI PANEL
i 4 0.01 3600	;REVERB
</CsScore>

</CsoundSynthesizer>