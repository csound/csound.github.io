PhaseModulationSynthesisMMC.csd
Written by Iain McCurdy, 2009
modulator -> modulator -> carrier

<CsoundSynthesizer>

<CsOptions>
-odac -Ma -+rtmidi=virtual -dm0
</CsOptions>

<CsInstruments>

sr	=	44100
ksmps	=	10
nchnls	=	2
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL                                  | WIDTH | HEIGHT | X | Y
	FLpanel	"Phase Modulation Synthesis: M->M->C",    500,    500,    0,  0

;                                               	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"On/Off(MIDI)",		1,    0,    22,    140,     25,    5,  5,    0,      2,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES					WIDTH | HEIGHT | X |  Y
idbasefreq			FLvalue	" ",     	60,       20,    5,   75
idindex1			FLvalue	" ",     	60,       20,    5,  125
idindex2			FLvalue	" ",     	60,       20,    5,  175
idCarAmp			FLvalue	" ",     	60,       20,    5,  325
idChoDep			FLvalue	" ",     	60,       20,    5,  375
idChoRte			FLvalue	" ",     	60,       20,    5,  425
idChoMix			FLvalue	" ",     	60,       20,    5,  475

;SLIDERS				            			MIN  |   MAX | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X | Y
gkbasefreq, ihbasefreq		FLslider 	"Base Frequency",	20,    20000,  -1,    23,  idbasefreq,    490,     25,    5,  50
gkindex1, ihindex1		FLslider 	"Modulation Index 1",	0,         1,   0,    23,  idindex1,      490,     25,    5, 100
gkindex2, ihindex2		FLslider 	"Modulation Index 2",	0,         1,   0,    23,  idindex2,      490,     25,    5, 150
gkCarAmp, ihCarAmp		FLslider 	"Carrier Amplitude",	0,         1,   0,    23,  idCarAmp,      490,     25,    5, 300
gkChoDep, ihChoDep		FLslider 	"Chorus Depth",		0,       0.1,   0,    23,  idChoDep,      490,     25,    5, 350
gkChoRte, ihChoRte		FLslider 	"Chorus Rate",		0,        10,   0,    23,  idChoRte,      490,     25,    5, 400
gkChoMix, ihChoMix		FLslider 	"Chorus Dry/Wet Mix",	0,         1,   0,    23,  idChoMix,      490,     25,    5, 450

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT |  X | Y
ih		 	FLbox  	" ", 	6,       9,    15,    420,     70,    40, 205

;TEXT BOXES					 	MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkModRatio1, ihModRatio1	FLtext		"", 	.125,   8,  .001,   1,     50,     20,   160, 220
gkModRatio2, ihModRatio2	FLtext		"", 	.125,   8,  .001,   1,     50,     20,   230, 220
gkCarRatio, ihCarRatio		FLtext		"", 	.125,   8,  .001,   1,     50,     20,   300, 220

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Freq. Ratios:",	1,      5,     14,   110,    15,    50,  222
ih		 	FLbox  	":", 			1,      5,     14,     5,    15,    218,  222
ih		 	FLbox  	":", 			1,      5,     14,     5,    15,    288,  222
ih		 	FLbox  	"Mod. 1", 		1,      5,     12,    60,    15,    155,  245
ih		 	FLbox  	"Mod. 2", 		1,      5,     12,    60,    15,    225,  245
ih		 	FLbox  	"Car.", 		1,      5,     12,    60,    15,    295,  245

			FLsetVal_i	50, 	ihbasefreq
			FLsetVal_i	0.25, 	ihindex1
			FLsetVal_i	0.25, 	ihindex2
			FLsetVal_i	1, 	ihCarRatio
			FLsetVal_i	3.001, 	ihModRatio1
			FLsetVal_i	5.001, 	ihModRatio2
			FLsetVal_i	0.15, 	ihCarAmp
			FLsetVal_i	0.003, 	ihChoDep
			FLsetVal_i	1, 	ihChoRte
			FLsetVal_i	0.5, 	ihChoMix

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 480, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Phase Modulation Synthesis: modulator->modulator->carrier    ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"An implementation of phase modulation synthesis in which a   ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"modulator modulates another modulator which in turn modulates", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"a carrier.                                                   ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"                      +---------+                            ", 	1,      5,     14,    490,    15,     5, 120
ih	  	 	FLbox  	"                      | MOD. 1  |                            ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"                      +----+----+                            ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"                           |                                 ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"                      +----+----+                            ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"                      | MOD. 2  |                            ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"                      +----+----+                            ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"                           |                                 ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"                      +----+----+                            ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"                      | CARRIER |                            ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"                      +----+----+                            ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"                           |                                 ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"                           V                                 ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"                          OUT                                ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"Additionally the output of the synthesizer is passed through ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"a chorus effect. To bypass this effect set 'Chorus Dry/Wet   ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"Mix' to zero.                                                ", 	1,      5,     14,    490,    15,     5, 460

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen	0,0,65537,10,1	;A SINE WAVE THAT CAN BE REFERENCED BY THE GLOBAL VARIABLE 'gisine'
zakinit	2,2

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

	iporttime	=	.01				;PORTAMENTO FUNCTION (WILL BE USED TO SMOOTH PARAMETER MOVED BY FLTK WIDGETS)
	kporttime	linseg	0,.001,iporttime,1,iporttime	;PORTAMENTO FUNCTION (WILL BE USED TO SMOOTH PARAMETER MOVED BY FLTK WIDGETS)
	
	kindex1		portk	kindex1, kporttime		;APPLY SMOOTHING PORTAMENTO TO THE VARIABLE 'kindex1'
	kindex2		portk	kindex2, kporttime		;APPLY SMOOTHING PORTAMENTO TO THE VARIABLE 'kindex2'
	kbasefreq	portk	kbasefreq, kporttime		;APPLY SMOOTHING PORTAMENTO TO THE VARIABLE 'kbasefreq'
	kCarAmp		portk	kCarAmp, kporttime		;APPLY SMOOTHING PORTAMENTO TO THE VARIABLE 'kCarAmp'

	aModPhase1	phasor	kbasefreq * gkModRatio1		;CREATE A MOVING PHASE VALUE THAT WILL BE USED TO READ CREATE MODULATOR 1
	aModulator1	tablei	aModPhase1,gisine,1,0,1		;MODULATOR 1 IS CREATED                                                  
	aModulator1	=	aModulator1*kindex1		;MODULATOR 1 AMPLITUDE RESCALED                                          

	aModPhase2	phasor	kbasefreq * gkModRatio2		;CREATE A MOVING PHASE VALUE THAT WILL BE USED TO READ CREATE MODULATOR 2
	aModPhase2	=	aModPhase2 + aModulator1	;MODULATOR 1 SIGNAL IS ADDED TO MODULATOR 2 PHASE VARIABLE
	aModulator2	tablei	aModPhase2,gisine,1,0,1		;MODULATOR 2 OSCILLATOR IS CREATED
	aModulator2	=	aModulator2 * kindex2		;MODULATOR 2 AMPLITUDE RESCALED

	aCarrPhase	phasor	kbasefreq * gkCarRatio		;CREATE A MOVING PHASE VALUE THAT WILL BE USED TO READ CREATE THE CARRIER
	aCarrPhase	=	aCarrPhase + aModulator2	;MODULATOR 2 SIGNAL IS ADDED TO CARRIER PHASE VARIABLE
	aCarrier	tablei	aCarrPhase,gisine,1,0,1		;MODULATOR OSCILLATOR IS CREATED
	aAntiClick	linsegr	0,0.001,1,0.01,0		;ANTI CLICK ENVELOPE
	aCarrier	=	aCarrier*kCarAmp*aAntiClick	;CARRIER AMPLITUDE IS RESCALED

	zawm		aCarrier, 1	;MIX PM SYNTHESIZED TONES INTO ZAK AUDIO CHANNEL 1
endin

instr	3	;CHORUS
	iporttime	=	0.05					;DEFINE A RAMPING UP VARIABLE THAT WILL BE USED FOR PORTAMENTO TIME
	kporttime	linseg	0,0.01,iporttime,1,iporttime    	;DEFINE A RAMPING UP VARIABLE THAT WILL BE USED FOR PORTAMENTO TIME
	kChoDep		portk	gkChoDep, kporttime             	;APPLY PORTAMENTO SMOOTHING TO SLIDER VARIABLE gkChoDep
	ain		zar	1					;READ AUDIO FROM ZAK CHANNEL 1
	ichooffset	init	0.001					;OFFSET TIME FOR CHORUSING DELAY
	achodepth	interp	kChoDep					;CONVERT kChoDep TO A-RATE
	kchofrq		randomi	-gkChoRte, gkChoRte, 1			;CREATE CHORUS RATE VARIABLE AS RANDOMLY MOVING VARIABLE THE RANGE OF WHICH IS DEFINED BY SLIDER 'Chorus Rate'
	adlt		oscili	kChoDep * 0.5, kchofrq*gkChoRte, gisine	;CREATE DELAY TIME VARIABLE
	adlt		=	adlt + (achodepth * 0.5) + ichooffset	;OFFSET DELAY TIME VARIABLE
	
	imaxdlt		init	1					;DEFINE MAXIMUM DELAY TIME
	abuffer		delayr	1					;SET UP DELAY BUFFER
	atap		deltap3	adlt					;READ A DELAY TAP FROM THE BUFFER
			delayw	ain					;WRITE AUDIO INTO BUFFER
	zawm		atap, 2						;MIX CHORUSED TONES INTO ZAK CHANNEL 2
endin

instr	4	;AUDIO OUTPUT
	adry	zar	1			;READ DRY SIGNAL FROM ZAK CHANNEL 1
	acho	zar	2			;READ CHORUSED AUDIO FROM ZAK CHANNEL 2
	amix	ntrpol	adry, acho, gkChoMix	;MIX DRY AND CHORUSED AND AUDIO
	outs	amix, amix			;SEND AUDIO TO OUTPUTS
	zacl	0,2				;CLEAR ZAK VARIABLES
endin

</CsInstruments>


<CsScore>
i 3 0 3600	;CHORUS VOICES
i 3 0 3600	;CHORUS VOICES
i 3 0 3600	;CHORUS VOICES
i 3 0 3600	;CHORUS VOICES
i 3 0 3600	;CHORUS VOICES
i 3 0 3600	;CHORUS VOICES
i 3 0 3600	;CHORUS VOICES
i 3 0 3600	;CHORUS VOICES
i 3 0 3600	;CHORUS VOICES
i 4 0 3600	;AUDIO OUTPUT
</CsScore>

</CsoundSynthesizer>