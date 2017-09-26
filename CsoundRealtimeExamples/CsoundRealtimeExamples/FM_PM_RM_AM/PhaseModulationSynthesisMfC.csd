PhaseModulationSynthesisMfC.csd
Written by Iain McCurdy, 2008

<CsoundSynthesizer>

<CsOptions>
-odac -M0 -dm0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>

sr	=	44100
ksmps	=	16
nchnls	=	2

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL                                                        | WIDTH | HEIGHT | X | Y
	FLpanel	"Phase Modulation Synthesis: Simple Carrier->Modulator(with feedback)", 500,    400,    0,  0

;                                               	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"On/Off(MIDI)",		1,    0,    22,    140,     25,    5,  5,    0,      2,      0,      -1
gkExit,ihExit	FLbutton	"Exit",			1,    0,    21,    140,     25,  355,  5,    0,    999,      0,       0.001
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES					WIDTH | HEIGHT | X |  Y
idbasefreq			FLvalue	" ",     	60,       20,    5,   75
idindex				FLvalue	" ",     	60,       20,    5,  125
idCarAmp			FLvalue	" ",     	60,       20,    5,  275
idFBRatio			FLvalue	" ",     	60,       20,    5,  325

;					            							MIN  |   MAX | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X | Y
gkbasefreq, ihbasefreq		FLslider 	"Base Frequency",		 			20,    20000,  -1,    23,  idbasefreq,    395,     25,    5,  50
gkindex, ihindex		FLslider 	"Modulation Index",					0,       100,   0,    23,  idindex,       395,     25,    5, 100
gkCarAmp, ihCarAmp		FLslider 	"Carrier Amplitude",					0,     30000,   0,    23,  idCarAmp,      490,     25,    5, 250
gkFBRatio, ihFBRatio		FLslider 	"Feedback Ratio",					0,         1,   0,    23,  idFBRatio,     490,     25,    5, 300

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	6,        9,    15,    220,    70,   140, 160

;						 			MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkCarRatio, ihCarRatio		FLtext		" ", 			.125,   8,  .001,   1,     50,     20,   190, 170
gkModRatio, ihModRatio		FLtext		" ", 			.125,   8,  .001,   1,     50,     20,   260, 170
gkPeakDev, gihPeakDev		FLtext		"Peak Deviation", 	0,  10000,     0,   1,     80,     20,   410,  65 ;DISPLAY ONLY!

;		FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkmode, ihmode	FLbutBank	3,     1,     2,     15,      50,    0, 350,   -1
;TEXT BOXES							TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Phase Modulation Synthesis", 	1,      5,     14,    225,     15,   15, 355
ih		 	FLbox  	"FM Synthesis              ", 	1,      5,     14,    225,     15,   15, 380

;TEXT BOXES										TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	":", 							1,      5,     14,     5,    15,    248,  172
ih		 	FLbox  	"Carrier Frequency", 					1,      5,     12,    90,    15,    170,  200
ih		 	FLbox  	"Modulator Frequency", 					1,      5,     12,    90,    15,    245,  200

			FLsetVal_i	100, 	ihbasefreq
			FLsetVal_i	3, 	ihindex
			FLsetVal_i	1, 	ihCarRatio
			FLsetVal_i	1, 	ihModRatio
			FLsetVal_i	6000, 	ihCarAmp
			FLsetVal_i	0, 	ihFBRatio

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 500, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Phase Modulation Synthesis: Modulator(with feedback)->Carrier", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"This example implements phase modulation synthesis with a    ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"modulator->carrier pairing and with a feedback loop on the   ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"modulator.                                                   ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"There is a switch that allows the user to switch between FM  ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"synthesis and phase modulation synthesis to allow the user to", 	1,      5,     14,    490,    15,     5, 120
ih	  	 	FLbox  	"hear the difference between the two techniques. All controls ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"are common to both methods except 'Feedback Ratio' which is  ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"not used in the FM synthesis version.                        ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"                            +------+                         ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"                            V      |                         ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"                         +--+--+   |                         ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"                         |MOD.1|   |(feedback)               ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"                         +--+--+   |                         ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"                            |      |                         ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"                            +------+                         ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"                            |                                ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"                         +--+--+                             ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"                         |CAR.1|                             ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"                         +--+--+                             ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"                            |                                ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"                            V                                ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"                           OUT                               ", 	1,      5,     14,    490,    15,     5, 480

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen	0,0,65537,10,1	;A SINE WAVE THAT CAN BE REFERENCED BY THE GLOBAL VARIABLE 'gisine'

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

instr	2		;FM INSTRUMENT
	kactive1	active	1	;SENSE NUMBER OF ACTIVE INSTANCES OF INSTRUMENT 1 (I.E. MIDI ACTIVATED INSTRUMENT) 
	if	gkOnOff=0&&kactive1=0	then	;IF FLTK/MIDI SWITCH IS SET TO 'MIDI' AND NO MIDI NOTES ARE ACTIVE...
		turnoff					;TURN THIS INSTRUMENT
	endif						;END OF CONDITIONAL BRANCHING
	if	gkOnOff = 1	then			;IF FLTK/MIDI SWITCH IS SET TO 'FLTK'...
		kCarAmp = gkCarAmp			;SET kamp TO FLTK SLIDER VALUE gkamp
		kbasefreq = gkbasefreq			;SET FUNDEMENTAL TO FLTK SLIDER gkfund
	else						;OTHERWISE...
		kbasefreq = p4				;SET FUNDEMENTAL TO RECEIVED p4 RECEIVED FROM INSTR 1. I.E. MIDI PITCH
		kCarAmp = p5 * gkCarAmp			;SET AMPLITUDE TO RECEIVED p5 RECEIVED FROM INSTR 1 (I.E. MIDI VELOCITY) MULTIPLIED BY FLTK SLIDER gkamp.
	endif						;END OF CONDITIONAL BRANCHING
	
	kpeakdeviation	=	gkbasefreq * gkindex	;CALCUALATE THE PEAK DEVIATION OF THE MODULATOR FROM THE VALUES GIVEN FOR BASE FREQUENCY AND THE INDEX OF MODULATION
	
	
	iporttime	=	.02				;PORTAMENTO FUNCTION (WILL BE USED TO SMOOTH PARAMETER MOVED BY FLTK WIDGETS)
	kporttime	linseg	0,.001,iporttime,1,iporttime	;PORTAMENTO FUNCTION (WILL BE USED TO SMOOTH PARAMETER MOVED BY FLTK WIDGETS)
	
	kpeakdeviation	portk	kpeakdeviation, kporttime	;APPLY SMOOTHING PORTAMENTO TO THE VARIABLE 'kpeakdeviation'
	kindex		portk	gkindex, kporttime		;APPLY SMOOTHING PORTAMENTO TO THE VARIABLE 'kindex'
	kbasefreq	portk	kbasefreq, kporttime		;APPLY SMOOTHING PORTAMENTO TO THE VARIABLE 'kbasefreq'
	kFBRatio	portk	gkFBRatio, kporttime		;APPLY SMOOTHING PORTAMENTO TO THE VARIABLE 'kFBratio'
	kCarAmp		portk	gkCarAmp, kporttime		;APPLY SMOOTHING PORTAMENTO TO THE VARIABLE 'gkCarAmp'
	aAntiClick	linsegr	0,0.001,1,0.01,0	;ANTI CLICK ENVELOPE

	if	gkmode=0	then	;gkmode=0 ZERO SELECTS PHASE MODULATION SYNTHESIS 
		aFB		init	0	;CREATE AN INITIAL VALUE FOR THE FEEDBACK SIGNAL
		aModPhase	phasor	kbasefreq * gkModRatio		;CREATE A MOVING PHASE VALUE THAT WILL BE USED TO READ CREATE THE MODULATOR
		aModulator	tablei	aModPhase+aFB,gisine,1,0,1	;MODULATOR OSCILLATOR IS CREATED. NOTE THAT FEEDBACK SIGNAL IS ADDED TO THE POINTER VARIABLE
		aFB		=	aModulator * kFBRatio		;FEEDBACK SIGNAL UPDATED FOR THE NEXT PASS
		aModulator	=	aModulator * (kindex*.17)		;MODULATOR RESCALED
		aCarrPhase	phasor	kbasefreq * gkCarRatio		;CREATE A MOVING PHASE VALUE THAT WILL BE USED TO READ CREATE THE CARRIER
		aCarrPhase	=	aCarrPhase + aModulator		;MODULATOR SIGNAL IS ADDED TO CARRIER PHASE VARIABLE
		aCarrier	tablei	aCarrPhase,gisine,1,0,1		;MODULATOR OSCILLATOR IS CREATED. NOTE THAT FEEDBACK SIGNAL IS ADDED TO THE POINTER VARIABLE
		aCarrier	=	aCarrier*kCarAmp*aAntiClick	;CARRIER AMPLITUDE IS RESCALED
	elseif	gkmode=1	then	;gkmode=1 ZERO SELECTS FM SYNTHESIS 
		;OUTPUT		OPCODE	AMPLITUDE          |     FREQUENCY                         | FUNCTION_TABLE
		aModulator	oscili	kpeakdeviation,      kbasefreq * gkModRatio,                    gisine		;DEFINE THE MODULATOR WAVEFORM
		aCarrier	oscili	kCarAmp*aAntiClick,(kbasefreq * gkCarRatio) + aModulator,       gisine		;DEFINE THE CARRIER WAVEFORM (NOTE HOW ITS FREQUENCY IS MODULATED (THROUGH ADDITION) BY THE AUDIO OUTPUT OF THE MODULATOR WAVEFORM)
	endif
		outs	aCarrier, aCarrier	;SEND THE AUDIO OUTPUT OF THE CARRIER WAVEFORM *ONLY* TO THE OUTPUTS 
	ktrig	metro	10	;CREATE A REPEATING TRIGGER SIGNAL
		FLsetVal 	ktrig, kpeakdeviation, gihPeakDev	;UPDATE VALUE BOX 'gihPeakDev' WITH THE VALUE kpeakdeviation WHENEVER A TRIGGER PULSE IS RECEIVED
endin
	
instr	999	;QUIT
	exitnow
endin

</CsInstruments>


<CsScore>
f 0 3600	;DUMMY SCORE EVENT - KEEPS REALTIME PERFORMANCE GOING FOR ONE HOUR
</CsScore>

</CsoundSynthesizer>