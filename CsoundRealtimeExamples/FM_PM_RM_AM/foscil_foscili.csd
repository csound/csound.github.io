;Written by Iain McCurdy, 2009. 

<CsoundSynthesizer>

<CsOptions>
-odevaudio -Ma -+rtmidi=virtual -b400
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps		=	100	;SIZE OF k-PERIOD IN SAMPLES
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;					LABEL             | WIDTH | HEIGHT | X | Y
				FLpanel	"foscil/foscili",    500,    370,    0,  0

;BUTTONS						ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"On/Off(MIDI)",		1,    0,    22,    140,     25,    5,  5,    0,      2,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	6,        9,    15,    220,    70,   140, 210

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idamp				FLvalue	"",       70,    18,     5,  75
idcps				FLvalue	"",       70,    18,     5, 125
idndx				FLvalue	"",       70,    18,     5, 175

;SLIDERS					            			MIN   |  MAX  | EXP | TYPE |  DISP | WIDTH | HEIGHT | X  |  Y
gkamp,ihamp			FLslider 	"Amplitude",			0,          1,   0,    23,   idamp,   490,     25,    5,   50	;VALUE DISPLAY FOR THIS VARIABLE IS UPDATED FROM WITHIN THE MAIN ORCHESTRA (INSTR 2)
gkcps,ihcps			FLslider 	"Base Frequency",		20,     20000,  -1,    23,   idcps,   490,     25,    5,  100
gkndx,ihndx			FLslider 	"Index",			0,         20,   0,    23,   idndx,   490,     25,    5,  150

;VALUE BOXES					 			MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkcar, ihcar			FLtext		"", 			.125,   8,  .0001,  1,     50,     20,   190, 220
gkmod, ihmod			FLtext		"", 			.125,   8,  .0001,  1,     50,     20,   260, 220

;TEXT BOXES										TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	":", 							1,      5,     14,     5,    15,    248,  222
ih		 	FLbox  	"Carrier Frequency", 					1,      5,     12,    90,    15,    170,  250
ih		 	FLbox  	"Modulator Frequency", 					1,      5,     12,    90,    15,    245,  250

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS			 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkopcode, ihopcode	FLbutBank	3,     1,     3,     18,      75,     60,290,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES							TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"OPCODE:",			1,       6,    14,    60,      25,     0, 290
ih		 	FLbox  	"foscil          ",		1,       5,    12,   120,      25,    80, 290
ih		 	FLbox  	"foscili         ", 		1,       5,    12,   120,      25,    80, 315
ih		 	FLbox  	"first principles", 		1,       5,    12,   120,      25,    80, 340

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	0.2, 	ihamp
				FLsetVal_i	200, 	ihcps
				FLsetVal_i	5, 	ihndx
				FLsetVal_i	1, 	ihcar
				FLsetVal_i	1, 	ihmod
				FLsetVal_i	1, 	ihopcode
			
				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 512, 340, 512, 0

;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                      foscil/foscili                         ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"The opcodes foscil and foscili implement the classic         ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"Chowning modulator-oscillator pairing used in basic FM       ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"synthesis. The difference between foscil and foscili is that ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"foscil reads from the function table without interpolation   ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"whereas foscili reads from the function table with linear    ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"interpolation. Therefore foscili can perform satisfactorily  ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"with a small function table whereas foscil will really need  ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"a larger function table to preovide similarly high quality   ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"results. foscil demands more RAM, foscili demands more CPU.  ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"In general foscili will provide smoother results. In this    ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"example the table used is rather small (64 points) so as to  ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"clearly highlight the difference.                            ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"It is not difficult to implement this FM algorithm from      ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"first principles using individual oscillators and the third  ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"option from the list of tick boxes chooses this bit of code. ", 	1,      5,     14,    490,    15,     5, 320
				FLpanel_end                                                                                                       
                                                                                                                                                  
				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine		ftgen	0, 0, 64, 10, 1		;SINE WAVE FUNCTION TABLE (SIZE:64 FOR NON-INTERPOLATING OPCODES)
gisinei		ftgen	0, 0, 65, 10, 1		;SINE WAVE FUNCTION TABLE (SIZE:65 FOR INTERPOLATING OPCODES)

0dbfs	=	1	;MAXIMUM AMPLITUDE IS SET AT A VALUE OF 1

instr	1	;MIDI INPUT INSTRUMENT
	if	gkOnOff=1	then	;IF FLTK/MIDI SWITCH IS SET TO 'FLTK'...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	icps	cpsmidi			;READ CYCLES PER SECOND VALUE FROM MIDI INPUT
	iamp	ampmidi	1		;READ IN A NOTE VELOCITY VALUE FROM THE MIDI INPUT
	;				P1 | P4 | P5
	aoutL, aoutR	subinstr	2,  icps, iamp	;ACTIVATE A SUB-INSTRUMENT
		outs	aoutL, aoutR	;SEND AUDIO TO SPEAKERS
endin

instr	2		;FOSCIL/FOSCILI INSTRUMENT
	kactive1	active	1	;SENSE NUMBER OF ACTIVE INSTANCES OF INSTRUMENT 1 (I.E. MIDI ACTIVATED INSTRUMENT) 
	if	gkOnOff=0&&kactive1=0	then	;IF FLTK/MIDI SWITCH IS SET TO 'MIDI' AND NO MIDI NOTES ARE ACTIVE...
		turnoff					;TURN THIS INSTRUMENT
	endif						;END OF CONDITIONAL BRANCHING
	if	gkOnOff = 1	then			;IF FLTK/MIDI SWITCH IS SET TO 'FLTK'...
		kamp = gkamp				;SET kamp TO FLTK SLIDER VALUE gkamp
		kcps = gkcps				;SET FUNDEMENTAL TO FLTK SLIDER gkcps
		kndx = gkndx				;SET INDEX TO FLTK SLIDER gkndx
	else						;OTHERWISE...
		kcps = p4				;SET FUNDEMENTAL TO RECEIVED p4 RECEIVED FROM INSTR 1. I.E. MIDI PITCH
		kamp = p5 * gkamp			;SET AMPLITUDE TO RECEIVED p5 RECEIVED FROM INSTR 1 (I.E. MIDI VELOCITY) MULTIPLIED BY FLTK SLIDER gkamp.
		kndx = p5 * gkndx			;SET INDEX TO FLTK SLIDER gkndx MULTIPLIED BY AMPLITUDE VALUES RECEIVED FROM CALLING INSTRUMENT
	endif						;END OF CONDITIONAL BRANCHING

	iporttime	=	.05				;PORTAMENTO FUNCTION (WILL BE USED TO SMOOTH PARAMETER MOVED BY FLTK WIDGETS)
	kporttime	linseg	0,.001,iporttime,1,iporttime	;PORTAMENTO FUNCTION (WILL BE USED TO SMOOTH PARAMETER MOVED BY FLTK WIDGETS)

	aAntiClick	linsegr	0,0.001,1,0.01,0		;ANTI CLICK ENVELOPE

	kndx		portk	kndx, kporttime			;APPLY SMOOTHING PORTAMENTO TO THE VARIABLE 'kndx'
	kcps		portk	kcps, kporttime			;APPLY SMOOTHING PORTAMENTO TO THE VARIABLE 'kcps'
	kamp		portk	kamp, kporttime			;APPLY SMOOTHING PORTAMENTO TO THE VARIABLE 'kamp'
	aAntiClick	linsegr	0,0.001,1,0.01,0		;ANTI CLICK ENVELOPE

	;SELECT THE APPRORIATE FM OPCODE ACCORDING TO THE SETTING OF THE 'TYPE' TICK BOX SELECTER 
	if	gkopcode==0	then				;IF FIRST TICK BOX IS SELECTED...
		;FOSCIL
		ares	foscil	kamp, kcps, gkcar, gkmod, kndx, gisine	;FM SYNTHESIS USING FOSCIL
	elseif	gkopcode==1	then				;IF SECOND TICK BOX IS SELECTED...
		;FOSCILI
		ares	foscili	kamp, kcps, gkcar, gkmod, kndx, gisinei	;FM SYNTHESIS USING FOSCILI
	elseif	gkopcode==2	then				;IF THIRD TICK BOX IS SELECTED...
		;;FIRST PRINCIPLES
		;FM SYNTHESIS FROM FIRST PRINCIPLES
		kpeakdeviation	=	kcps * kndx	;CALCUALATE THE PEAK DEVIATION OF THE MODULATOR FROM THE VALUES GIVEN FOR BASE FREQUENCY AND THE INDEX OF MODULATION
		;OUTPUT		OPCODE	AMPLITUDE         |     FREQUENCY                  | FUNCTION_TABLE
		amod		oscili	kpeakdeviation,     kcps * gkmod,                       gisinei		;DEFINE THE MODULATOR WAVEFORM
		ares		oscili	kamp,               (kcps * gkcar) + amod,              gisinei		;DEFINE THE CARRIER WAVEFORM (NOTE HOW ITS FREQUENCY IS MODULATED (THROUGH ADDITION) BY THE AUDIO OUTPUT OF THE MODULATOR WAVEFORM)
		;PM
		;aModPhase	phasor	kcps * gkmod		;CREATE A MOVING PHASE VALUE THAT WILL BE USED TO READ CREATE THE MODULATOR
		;aModulator	tablei	aModPhase,gisinei,1,0,1	;MODULATOR OSCILLATOR IS CREATED. NOTE THAT FEEDBACK SIGNAL IS ADDED TO THE POINTER VARIABLE
		;aModulator	=	aModulator * kndx		;MODULATOR RESCALED
		;aCarrPhase	phasor	kcps * gkcar		;CREATE A MOVING PHASE VALUE THAT WILL BE USED TO READ CREATE THE CARRIER
		;aCarrPhase	=	aCarrPhase + aModulator		;MODULATOR SIGNAL IS ADDED TO CARRIER PHASE VARIABLE
		;aCarrier	tablei	aCarrPhase,gisinei,1,0,1		;MODULATOR OSCILLATOR IS CREATED. NOTE THAT FEEDBACK SIGNAL IS ADDED TO THE POINTER VARIABLE
		;ares	=	aCarrier*kamp		;CARRIER AMPLITUDE IS RESCALED
	endif		;END OF CONDITIONAL BRANCHING
	outs	ares * aAntiClick, ares * aAntiClick	;SEND AUDIO TO OUTPUTS
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT KEEPS PERFORMANCE GOING FOR 1 HOUR 
</CsScore>

</CsoundSynthesizer>