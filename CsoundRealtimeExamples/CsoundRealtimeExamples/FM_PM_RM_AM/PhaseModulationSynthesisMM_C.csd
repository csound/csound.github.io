PhaseModulationSynthesisMM_C.csd
Written by Iain McCurdy, 2009
2 parallel modulators - 1 carrier

<CsoundSynthesizer>

<CsOptions>
-odac -M0 -dm0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>

sr	=	44100
ksmps	=	16
nchnls	=	2
0dbfs	=	1	;MAXIMUM AMPLITUDE = 1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL                                                          | WIDTH | HEIGHT | X | Y
	FLpanel	"Phase Modulation Synthesis: 2 parallel modulators -> carrier",   500,    330,    0,  0

;                                               	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"On/Off(MIDI)",		1,    0,    22,    140,     25,    5,  5,    0,      2,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES					WIDTH | HEIGHT | X |  Y
idbasefreq			FLvalue	" ",     	60,       20,    5,   75
idindex1			FLvalue	" ",     	60,       20,    5,  125
idindex2			FLvalue	" ",     	60,       20,    5,  175
idCarAmp			FLvalue	" ",     	60,       20,    5,  305

;					            							MIN  |   MAX | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X | Y
gkbasefreq, ihbasefreq		FLslider 	"Base Frequency",		 			20,    20000,  -1,    23,  idbasefreq,    490,     25,    5,  50
gkindex1, ihindex1		FLslider 	"Modulation Index 1",					0,         5,   0,    23,  idindex1,      490,     25,    5, 100
gkindex2, ihindex2		FLslider 	"Modulation Index 2",					0,         5,   0,    23,  idindex2,      490,     25,    5, 150
gkCarAmp, ihCarAmp		FLslider 	"Carrier Amplitude",					0,         1,   0,    23,  idCarAmp,      490,     25,    5, 280

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT |  X | Y
ih		 	FLbox  	" ", 	6,       9,    15,    420,     70,    40, 205

;						 		MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkModRatio1, ihModRatio1	FLtext		"", 		.125,   8,  .001,   1,     50,     20,   160, 220
gkModRatio2, ihModRatio2	FLtext		"", 		.125,   8,  .001,   1,     50,     20,   230, 220
gkCarRatio, ihCarRatio		FLtext		"", 		.125,   8,  .001,   1,     50,     20,   300, 220

;TEXT BOXES									TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Freq. Ratios:", 				1,      5,     14,   110,    15,    50,  222
ih		 	FLbox  	":", 						1,      5,     14,     5,    15,    218,  222
ih		 	FLbox  	":", 						1,      5,     14,     5,    15,    288,  222
ih		 	FLbox  	"Mod. 1", 					1,      5,     12,    60,    15,    155,  245
ih		 	FLbox  	"Mod. 2", 					1,      5,     12,    60,    15,    225,  245
ih		 	FLbox  	"Car.", 					1,      5,     12,    60,    15,    295,  245

			FLsetVal_i	100, 	ihbasefreq
			FLsetVal_i	1, 	ihindex1
			FLsetVal_i	1, 	ihindex2
			FLsetVal_i	1, 	ihCarRatio
			FLsetVal_i	1.5, 	ihModRatio1
			FLsetVal_i	2, 	ihModRatio2
			FLsetVal_i	0.2, 	ihCarAmp

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 340, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Phase Modulation Synthesis: 2 parallel modulators -> carrier ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"An implementation of phase modulation synthesis with two     ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"parallel modulators modulating a single carrier.             ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"            +---------+           +---------+                ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"            | MOD. 1  |           | MOD. 2  |                ", 	1,      5,     14,    490,    15,     5, 120
ih	  	 	FLbox  	"            +----+----+           +----+----+                ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"                 |                     |                     ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"                 +----------+----------+                     ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"                            |                                ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"                       +----+----+                           ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"                       | CARRIER |                           ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"                       +----+----+                           ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"                            |                                ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"                            V                                ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"                           OUT                               ", 	1,      5,     14,    490,    15,     5, 320

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
		kindex1 = gkindex1			;SET INDEX TO FLTK SLIDER gkindex
		kindex2 = gkindex2			;SET INDEX TO FLTK SLIDER gkindex
	else						;OTHERWISE...
		kbasefreq = p4				;SET FUNDEMENTAL TO RECEIVED p4 RECEIVED FROM INSTR 1. I.E. MIDI PITCH
		kCarAmp = p5 * gkCarAmp			;SET AMPLITUDE TO RECEIVED p5 RECEIVED FROM INSTR 1 (I.E. MIDI VELOCITY) MULTIPLIED BY FLTK SLIDER gkamp.
		kindex1 = p5 * gkindex1			;SET INDEX TO FLTK SLIDER gkindex MULTIPLIED BY AMPLITUDE VALUES RECEIVED FROM CALLING INSTRUMENT
		kindex2 = p5 * gkindex2			;SET INDEX TO FLTK SLIDER gkindex MULTIPLIED BY AMPLITUDE VALUES RECEIVED FROM CALLING INSTRUMENT
	endif						;END OF CONDITIONAL BRANCHING

	iporttime	=	.025				;PORTAMENTO FUNCTION (WILL BE USED TO SMOOTH PARAMETER MOVED BY FLTK WIDGETS)
	kporttime	linseg	0,.001,iporttime,1,iporttime	;PORTAMENTO FUNCTION (WILL BE USED TO SMOOTH PARAMETER MOVED BY FLTK WIDGETS)
	
	kindex1		portk	kindex1, kporttime		;APPLY SMOOTHING PORTAMENTO TO THE VARIABLE 'kindex'
	kindex2		portk	kindex2, kporttime		;APPLY SMOOTHING PORTAMENTO TO THE VARIABLE 'kindex'
	kbasefreq	portk	kbasefreq, kporttime		;APPLY SMOOTHING PORTAMENTO TO THE VARIABLE 'kbasefreq'
	kCarAmp		portk	kCarAmp, kporttime		;APPLY SMOOTHING PORTAMENTO TO THE VARIABLE 'kCarAmp'

	aModPhase1	phasor	kbasefreq * gkModRatio1		;CREATE A MOVING PHASE VALUE THAT WILL BE USED TO CREATE MODULATOR 1
	aModulator1	tablei	aModPhase1,gisine,1,0,1		;MODULATOR OSCILLATOR IS CREATED.
	aModulator1	=	aModulator1*kindex1		;MODULATOR AMPLITUDE RESCALED

	aModPhase2	phasor	kbasefreq * gkModRatio2		;CREATE A MOVING PHASE VALUE THAT WILL BE USED TO CREATE MODULATOR 2
	aModulator2	tablei	aModPhase2,gisine,1,0,1		;MODULATOR OSCILLATOR IS CREATED.
	aModulator2	=	aModulator2 * kindex2		;MODULATOR AMPLITUDE RESCALED

	aCarrPhase	phasor	kbasefreq * gkCarRatio		;CREATE A MOVING PHASE VALUE THAT WILL BE USED TO READ CREATE THE CARRIER
	aCarrPhase	=	aCarrPhase + aModulator1 +aModulator2		;MODULATORS 1 & 2 ARE ADDED TO CARRIER PHASE VARIABLE
	aCarrier	tablei	aCarrPhase,gisine,1,0,1		;CARRIER OSCILLATOR IS CREATED.
	aAntiClick	linsegr	0,0.001,1,0.01,0		;ANTI CLICK ENVELOPE
	aCarrier	=	aCarrier*kCarAmp*aAntiClick	;CARRIER AMPLITUDE IS RESCALED

	outs	aCarrier, aCarrier	;SEND THE AUDIO OUTPUT OF THE CARRIER WAVEFORM *ONLY* TO THE OUTPUTS 
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT - KEEPS REALTIME PERFORMANCE GOING FOR ONE HOUR
</CsScore>

</CsoundSynthesizer>