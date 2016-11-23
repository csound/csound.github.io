PhaseModulationSynthesisMCf.csd
Written by Iain McCurdy, 2008

<CsoundSynthesizer>

<CsOptions>
-odac -M0 -dm0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>

sr	=	44100
ksmps	=	128
nchnls	=	2

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL                                                        | WIDTH | HEIGHT | X | Y
	FLpanel	"Phase Modulation Synthesis: Simple Carrier->Modulator(with feedback)", 500,    350,    0,  0

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
gkbasefreq, ihbasefreq		FLslider 	"Base Frequency",		 			20,    20000,  -1,    23,   idbasefreq,    490,    25,    5,  50
gkindex, ihindex		FLslider 	"Modulation Index",					0,       100,   0,    23,   idindex,       490,    25,    5, 100
gkCarAmp, ihCarAmp		FLslider 	"Carrier Amplitude",					0,     30000,   0,    23,   idCarAmp,      490,    25,    5, 250
gkFBRatio, ihFBRatio		FLslider 	"Feedback Ratio",					0,         1,   0,    23,   idFBRatio,     490,    25,    5, 300

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	6,        9,    15,    220,    70,   140, 160

;						 			MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkCarRatio, ihCarRatio		FLtext		" ", 			.125,   8,  .001,   1,     50,     20,   190, 170
gkModRatio, ihModRatio		FLtext		" ", 			.125,   8,  .001,   1,     50,     20,   260, 170

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
				FLpanel	" ", 500, 420, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Phase Modulation Synthesis: Modulator->Carrier(with feedback)", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"This example implements phase modulation synthesis with a    ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"modulator->carrier pairing and with a feedback loop on the   ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"modulator->carrier pairing.                                  ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"                            +------+                         ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"                            V      |                         ", 	1,      5,     14,    490,    20,     5, 120
ih	  	 	FLbox  	"                         +--+--+   |                         ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"                         |MOD.1|   |                         ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"                         +--+--+   |                         ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"                            |      |                         ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"                            |      |(feedback)               ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"                            |      |                         ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"                         +--+--+   |                         ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"                         |CAR.1|   |                         ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"                         +--+--+   |                         ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"                            |      |                         ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"                            +-->---+                         ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"                            |                                ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"                            V                                ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"                           OUT                               ", 	1,      5,     14,    490,    20,     5, 400

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
		kindex = gkindex			;SET INDEX TO FLTK SLIDER gkindex
	else						;OTHERWISE...
		kbasefreq = p4				;SET FUNDEMENTAL TO RECEIVED p4 RECEIVED FROM INSTR 1. I.E. MIDI PITCH
		kCarAmp = p5 * gkCarAmp			;SET AMPLITUDE TO RECEIVED p5 RECEIVED FROM INSTR 1 (I.E. MIDI VELOCITY) MULTIPLIED BY FLTK SLIDER gkamp.
		kindex = p5 * gkindex			;SET INDEX TO FLTK SLIDER gkindex MULTIPLIED BY AMPLITUDE VALUES RECEIVED FROM CALLING INSTRUMENT
	endif						;END OF CONDITIONAL BRANCHING
	
	iporttime	=	.02				;PORTAMENTO FUNCTION (WILL BE USED TO SMOOTH PARAMETER MOVED BY FLTK WIDGETS)
	kporttime	linseg	0,.001,iporttime,1,iporttime	;PORTAMENTO FUNCTION (WILL BE USED TO SMOOTH PARAMETER MOVED BY FLTK WIDGETS)
	
	kindex		portk	kindex, kporttime		;APPLY SMOOTHING PORTAMENTO TO THE VARIABLE 'kindex'
	kbasefreq	portk	kbasefreq, kporttime		;APPLY SMOOTHING PORTAMENTO TO THE VARIABLE 'kbasefreq'
	kFBRatio	portk	gkFBRatio, kporttime		;APPLY SMOOTHING PORTAMENTO TO THE VARIABLE 'kFBratio'
	kCarAmp		portk	kCarAmp, kporttime			;APPLY SMOOTHING PORTAMENTO TO THE VARIABLE 'gkCarAmp'

	aFB		init	0	;CREATE AN INITIAL VALUE FOR THE FEEDBACK SIGNAL
	aModPhase	phasor	kbasefreq * gkModRatio		;CREATE A MOVING PHASE VALUE THAT WILL BE USED TO READ CREATE THE MODULATOR
	aModulator	tablei	aModPhase+aFB,gisine,1,0,1	;MODULATOR OSCILLATOR IS CREATED. NOTE THAT FEEDBACK SIGNAL IS ADDED TO THE POINTER VARIABLE
	aModulator	=	aModulator * (kindex*.17)	;MODULATOR RESCALED
	aCarrPhase	phasor	kbasefreq * gkCarRatio		;CREATE A MOVING PHASE VALUE THAT WILL BE USED TO READ CREATE THE CARRIER
	aCarrPhase	=	aCarrPhase + aModulator		;MODULATOR SIGNAL IS ADDED TO CARRIER PHASE VARIABLE
	aCarrier	tablei	aCarrPhase,gisine,1,0,1		;MODULATOR OSCILLATOR IS CREATED. NOTE THAT FEEDBACK SIGNAL IS ADDED TO THE POINTER VARIABLE
	aFB		=	aCarrier * kFBRatio		;FEEDBACK SIGNAL UPDATED FOR THE NEXT PASS
	aAntiClick	linsegr	0,0.001,1,0.01,0	;ANTI CLICK ENVELOPE
	aCarrier	=	aCarrier*kCarAmp*aAntiClick	;CARRIER AMPLITUDE IS RESCALED
	outs	aCarrier, aCarrier	;SEND THE AUDIO OUTPUT OF THE CARRIER WAVEFORM *ONLY* TO THE OUTPUTS 
endin
	
instr	999	;QUIT
	exitnow
endin

</CsInstruments>


<CsScore>
f 0 3600	;DUMMY SCORE EVENT - KEEPS REALTIME PERFORMANCE GOING FOR ONE HOUR
</CsScore>

</CsoundSynthesizer>