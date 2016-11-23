PhaseModulationSynthesisCf.csd
Written by Iain McCurdy, 2008

<CsoundSynthesizer>

<CsOptions>
-odac -M0 -dm0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>

sr	=	44100
ksmps	=	64
nchnls	=	2

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL                                       | WIDTH | HEIGHT | X | Y
	FLpanel	"Phase Modulation Synthesis: Carrier(with feedback)",  500,    200,    0,  0

;                                               	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"On/Off(MIDI)",		1,    0,    22,    140,     25,    5,  5,    0,      2,      0,      -1
gkExit,ihExit	FLbutton	"Exit",			1,    0,    21,    140,     25,  355,  5,    0,    999,      0,       0.001
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES					WIDTH | HEIGHT | X |  Y
idfreq				FLvalue	" ",     	60,       20,    5,   75
idAmp				FLvalue	" ",     	60,       20,    5,  125
idFBRatio			FLvalue	" ",     	60,       20,    5,  175

;					            			MIN  |   MAX | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X | Y
gkfreq, ihfreq			FLslider 	"Base Frequency",	20,    20000,  -1,    23,   idfreq,       490,     25,    5,  50
gkAmp, ihAmp			FLslider 	"Amplitude",		0,     30000,   0,    23,   idAmp,        490,     25,    5, 100
gkFBRatio, ihFBRatio		FLslider 	"Feedback Ratio",	0,         1,   0,    23,   idFBRatio,    490,     25,    5, 150

			FLsetVal_i	100, 	ihfreq
			FLsetVal_i	6000, 	ihAmp
			FLsetVal_i	0.1, 	ihFBRatio

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 300, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"     Phase Modulation Synthesis: Carrier (with feedback)     ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"This example implements phase modulation synthesis with a    ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"single oscillator self-modulating via a feedback loop.       ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"modulator.                                                   ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"                            +------+                         ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"                            V      |                         ", 	1,      5,     14,    490,    15,     5, 120
ih	  	 	FLbox  	"                         +--+--+   |                         ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"                         |CAR.1|   |(feedback)               ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"                         +--+--+   |                         ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"                            |      |                         ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"                            +------+                         ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"                            |                                ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"                            V                                ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"                           OUT                               ", 	1,      5,     14,    490,    15,     5, 280

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

instr	2   	;FM INSTRUMENT
	kactive1	active	1	;SENSE NUMBER OF ACTIVE INSTANCES OF INSTRUMENT 1 (I.E. MIDI ACTIVATED INSTRUMENT) 
	if	gkOnOff=0&&kactive1=0	then			;IF FLTK/MIDI SWITCH IS SET TO 'MIDI' AND NO MIDI NOTES ARE ACTIVE...
		turnoff						;TURN THIS INSTRUMENT
	endif							;END OF CONDITIONAL BRANCHING
	if	gkOnOff = 1	then				;IF FLTK/MIDI SWITCH IS SET TO 'FLTK'...
		kAmp = gkAmp					;SET kamp TO FLTK SLIDER VALUE gkamp
		kfreq = gkfreq					;
	else							;OTHERWISE...
		kfreq = p4					;SET FUNDEMENTAL TO RECEIVED p4 RECEIVED FROM INSTR 1. I.E. MIDI PITCH
		kAmp = p5 * gkAmp				;SET AMPLITUDE TO RECEIVED p5 RECEIVED FROM INSTR 1 (I.E. MIDI VELOCITY) MULTIPLIED BY FLTK SLIDER gkamp.
	endif							;END OF CONDITIONAL BRANCHING

	iporttime	=	.02				;PORTAMENTO FUNCTION (WILL BE USED TO SMOOTH PARAMETER MOVED BY FLTK WIDGETS)
	kporttime	linseg	0,.001,iporttime,1,iporttime	;PORTAMENTO FUNCTION (WILL BE USED TO SMOOTH PARAMETER MOVED BY FLTK WIDGETS)
	
	kfreq		portk	kfreq, kporttime		;APPLY SMOOTHING PORTAMENTO TO THE VARIABLE 'kbasefreq'
	kFBRatio	portk	gkFBRatio, kporttime		;APPLY SMOOTHING PORTAMENTO TO THE VARIABLE 'kFBratio'
	kAmp		portk	kAmp, kporttime			;APPLY SMOOTHING PORTAMENTO TO THE VARIABLE 'gkAmp'

	aFB		init	0				;CREATE AN INITIAL VALUE FOR THE FEEDBACK SIGNAL
	aCarPhase	phasor	kfreq				;CREATE A MOVING PHASE VALUE THAT WILL BE USED TO READ CREATE THE CARRIER
	aCarrier	tablei	aCarPhase+aFB,gisine,1,0,1	;CARRIER OSCILLATOR IS CREATED. NOTE THAT FEEDBACK SIGNAL IS ADDED TO THE POINTER VARIABLE
	aFB		=	aCarrier * kFBRatio		;FEEDBACK SIGNAL UPDATED FOR THE NEXT PASS
	aAntiClick	linsegr	0,0.001,1,0.01,0	;ANTI CLICK ENVELOPE
	outs	aCarrier*kAmp*aAntiClick, aCarrier*kAmp*aAntiClick			;SEND THE AUDIO OUTPUT OF THE CARRIER WAVEFORM TO THE OUTPUTS - RESCALE WITH 'gkAmp' VARIABLE
endin

instr	999
	exitnow
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT - KEEPS REALTIME PERFORMANCE GOING FOR ONE HOUR
</CsScore>

</CsoundSynthesizer>