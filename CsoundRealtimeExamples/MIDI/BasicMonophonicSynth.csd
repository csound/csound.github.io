BasicMonophonicSynth.csd
Written by Iain McCurdy 2006. Updated 2011

<CsoundSynthesizer>

<CsOptions>
;-odac -Ma -dm0
-odac -M0 -+rtmidi=virtual -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100
ksmps 		= 	16
nchnls 		= 	1
0dbfs		=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH
maxalloc	2,1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 100, 200, 200
;			LABEL                        | WIDTH | HEIGHT | X | Y
	FLpanel	"Basic Monophonic MIDI Synthesizer",    500,     60,    0,  0

;VALUE DISPLAY BOXES					WIDTH | HEIGHT | X |  Y
idporttime			FLvalue	" ",     	60,       18,    5,   35

;SLIDERS				            				MIN  |   MAX | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X | Y
gkporttime,ihporttime		FLslider 	"Portamento Time",		0,        1,    0,    23,  idporttime,    490,    25,     5, 10


;SET INITIAL VALUES			VALUE | HANDLE
			FLsetVal_i	 .01,	ihporttime

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 760, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"         Basic Monophonic MIDI controlled Synthesizer        ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"NOTE: THIS IS A RE-WRITTEN VERSION OF AN OLDER EXAMPLE. THE  ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"OLD METHOD WOULD RESULT IN NON-SOUNDING NOTES IF A NEW PHRASE", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"WAS BEGUN OVER THE RELEASE STAGE OF A PREVIOUS PHRASE.       ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"You will need to have a midi keyboard connected to the       ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"computer for this to work.                                   ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"Monosynths can be implemented using 2 separate instruments.  ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"The first instrument is triggered by notes played on a MIDI  ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"keyboard, is polyphonic but does not produce any sound. This ", 	1,      5,     14,    490,    20,     5, 200
ih	  	 	FLbox  	"instrument tracks the most recent MIDI pitch value played and", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"is also crucial in being able to inform Csound how many notes", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"are being held. It also generates a flag (a momentary '1'    ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"value) whenever a new note has been played.                  ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"The second instrument is the one that actually produces      ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"sound. It plays just a single held note and is effectively   ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"on all the time. When no notes are played its amplitude      ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"envelope returns to zero thereby creating the impression that", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"it has stopped playing.                                      ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"A mechanism could be created to turn this instrument off when", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"no notes are playing and envelope release stages have        ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"returned to zero but in this example it is not really        ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"necessary.                                                   ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"Portamento (portk) is used in the second instrument to       ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"implement glisandi between overlapping notes.                ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"There are two ways in which envelopes can be triggered in    ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"monophonic synths:                                           ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"1 - triggered only once, at the beginning of a sequence of   ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"overlapping notes (legato phrase).                           ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"2 - triggered with each new note that is pressed whether     ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"overlapping or not.                                          ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"The three different envelopes used by the synth exemplify    ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"these two ways in which envelopes can be triggered.          ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"1 - The amplitude and filter envelopes will be triggered only", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"once per legato phrase.                                      ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"2 - A vibrato depth envelope is triggered each time a new    ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"note is is pressed whether it overlaps another note or not.  ", 	1,      5,     14,    490,    20,     5, 740

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gkcps		init	0       ;INITIALISE GLOBAL VARIABLES
gisine	ftgen	0,0,4096,10,1	

instr	1	;NOTE ON/OFF AND PITCH REGISERING INSTRUMENT. THIS INSTRUMENT WILL BE TRIGGERED BY NOTE PLAYED ON THE MIDI KEYBOARD
	icps		cpsmidi		;READ IN MIDI PITCH VALUES
	gkcps	=	icps		;CREATE A K-RATE GLOBAL VARIABLE VERSION OF MIDI PITCH THAT WILL BE USED IN INSTRUMENT 2.
	gkNoteOn	init	1	;A FLAG TO INDICATE WHEN A NEW NOTE HAS BEEN PLAYED. THIS FLAG IS CLEARED (RESET TO ZERO) AT THE BOTTOM OF INSTR 2.
	event_i	"i",2,0,-1		;THE VERY FIRST MIDI NOTE PLAYED WILL TRIGGER AN INFINITELY HELD NOTE IN INSTR 2. THE maxalloc SETTING IN THE ORCHESTRA HEADER WILL PREVENT ANY FURTHER TRIGGERINGS. 
endin

instr	2	;SOUND PRODUCING INSTRUMENT
	;VIBRATO ENVELOPE CHARACTERISTICS 
	ivibamp		init	0.05
	ivibdelayTim	init	0.3
	ivibRiseTim	init	1.2
	kvibfreq	init	6

	;AMPLITUDE ENVELOPE CHARACTERISTICS
	iAmpAttTim	init	0.01
	iAmpRelTim	init	1
	
	;RESONANT LOWPASS FILTER ENVELOPE CHARACTERISTICS (ADSR TYPE)
	iFiltAttTim	init	0.01			;FILTER ENVELOPE ATTACK TIME
	iFiltAttLev	init	1			;ATTACK LEVEL FOR THE FILTER ENVELOPE (RANGE 0 - 1)
	iFiltDecTim	init	2			;FILTER ENVELOPE DECAY TIME 
	iFiltRelTim	init	1			;FILTER ENVELOPE RELEASE TIME 
	iFiltSusLev	init	0.7			;SUSTAIN LEVEL FOR THE FILTER ENVELOPE (RANGE 0 - 1)
	iFiltBase	init	4			;BASIC FILTER CUTOFF OFFSET IN OCT FORMAT. ENVELOPE WILL BE ADDED TO THIS VALUE.
	iFiltEnvRange	init	10			;RANGE OF THE ENVELOPE'S INFLUENCE IN OCT FORMAT
	kres		init	0.9			;FILTER RESONANCE

	kactive1	active	1						;CONTINUALLY TRACK THE NUMBER OF ACTIVE INSTANCES OF INSTRUMENT 1. I.E. THE NUMBER OF MIDI NOTES HELD.
	
	;CREATE PORTAMENTO ON PITCH PARAMETER
	kporttime	linseg	0,0.01,1					;PORTAMENTO TIME RISES QUICKLY TO A HELD VALUE OF '1'
	kporttime	=	kporttime*gkporttime				;PORTAMENTO TIME FUNCTION SCALED BY VALUE OUTPUT BY FLTK SLIDER
	kcps		portk	gkcps, kporttime				;APPLY PORTAMENTO TO PITCH CHANGES

	;SENSE WHEN TO RE-TRIGGER THE VIBRATO ENVELOPE...
	if	gkNoteOn=1 then							;IF A NEW NOTE HAS BEGUN...
	  reinit	RestartVibEnv						;RESTART THE VIBRATO ENVELOPE FROM LABEL 'RestartVibEnv'
	endif									;END OF THIS CONDITIONAL BRANCH
	;CREATE A VIBRATO FUNCTION - THIS ENVELOPE WILL BE TRIGGERED WITH EACH NEW NEW THAT IS PRESSED WHETHER LEGATO OR NOT
	RestartVibEnv:								;REINITIALISE FROM HERE IF A NEW NOTE HAS BEGUN - THIS WILL RESTART THE VIBRATO ENVELOPE
	kvibenv		transeg	0,ivibdelayTim,0,0,ivibRiseTim,2,ivibamp	;SLIGHTLY CONCAVE BUILD-UP (shape=2)
	rireturn								;RETURN FROM REINITIALISATION PASS
	kvib		oscil	kvibenv, kvibfreq, gisine			;CREATE VIBRATO FUNCTION
	kvib		=	kvib+1						;SHIFT VIBRATO FUNCTION UP THE Y-AXIS SO THAT IT OSCILLATES ABOUT 1
	
	;CREATE A SAWTOOTH OSCILLATOR USING THE vco2 OPCODE
	asig		vco2	0.3,kcps*kvib
	
	kAmpEnv		init	0						;INITIAL ENVELOPE STATE
	kFiltEnv	init	0						;INITIAL ENVELOPE STATE
	if gkNoteOn=1&&kactive1=1 then						;IF A NEW LEGATO PHRASE IS BEGUN (I.E. A NEW NOTE HAS BEEN PRESSED AND NO OTHER PREVIOUS NOTES ARE BEING HELD)...
	  reinit	RestartLegEnvs						;RESTART THE 'LEGATO PHRASE' ENVELOPES (IN THIS CASE AMPLITUDE AND FILTER)
	endif									;END OF THIS CONDITIONAL BRANCH
	RestartLegEnvs:								;A LABEL: BEGIN A REINITIALISATION PASS FROM HERE TO RESTART THE LEGATO PHRASE ENVELOPES
	
	if	kactive1>0 then							;IF A NEW LEGATO PHRASE IS BEGINNING...
	  kAmpEnv	transeg	i(kAmpEnv),iAmpAttTim,-2,1			;MOVE THROUGH AMPLITUDE ATTACK (NOTE ON) ENVELOPE. IT WILL HOLD THE FINAL VALUE
	  kAmpSus		=	kAmpEnv					;REGISTER OF THE FINAL VALUE OF THE ATTACK-SUSTAIN ENVELOPE - USED BY THE RELEASE STAGE OF THE ENVELOPE
	  kFiltEnv	transeg	i(kFiltEnv),iFiltAttTim,-2,iFiltAttLev,iFiltDecTim,-2,iFiltSusLev;MOVE THROUGH FILTER ATTACK (NOTE ON) ENVELOPE. IT WILL HOLD THE FINAL VALUE
	  kFiltSus		=	kFiltEnv				;REGISTER OF THE FINAL VALUE OF THE ATTACK-SUSTAIN ENVELOPE - USED BY THE RELEASE STAGE OF THE ENVELOPE
	elseif	kactive1=0 then							;OR IF A LEGATO PHRASE HAS FINISHED (NO NOTE ARE BEGIN HELD)...
	  kAmpEnv	transeg	1,iAmpRelTim,-2,0                     		;MOVE THROUGH AMPLITUDE RELEASE ENVELOPE (FINAL VALUE WILL BE HELD)
	  kAmpEnv	=	kAmpEnv*kAmpSus					;RELEASE ENVELOPE RESCALED ACCORDING TO THE FINAL VALUE OF THE ATTACK SUSTAIN PORTION OF THE ENVELOPE BEFORE THE NOTE OFF WAS RECEIVED
	  kFiltEnv	transeg	iFiltSusLev,iFiltRelTim,-2,0			;MOVE THROUGH FILTER RELEASE ENVELOPE (FINAL VALUE WILL BE HELD)
	  kFiltEnv	=	kFiltEnv*kFiltSus				;RELEASE ENVELOPE RESCALED ACCORDING TO THE FINAL VALUE OF THE ATTACK SUSTAIN PORTION OF THE ENVELOPE BEFORE THE NOTE OFF WAS RECEIVED
	endif									;END OF THIS CONDITIONAL BRANCH
	rireturn								;RETURN FROM REINITIALISATION PASS
	
	aAmpEnv		interp	kAmpEnv						;SMOOTHER A-RATE AMPLITUDE ENVELOPE - MAY PROVE BENEFICIAL IF THERE ARE FAST CHANGING ENVELOPE SEGMENTS 
	kFiltEnvScl	=	cpsoct((kFiltEnv*iFiltEnvRange)+iFiltBase)	;FILTER ENVELOPE RESCALED AND CONVERTED FROM OCT FORMAT TO CPS
	
	;CREATE A FILTERED VERSION OF THE OSCILLATOR SIGNAL
	asig		moogladder	asig,kFiltEnvScl,kres			;MOOG LOWPASS FILTER SIGNAL
	
			out	asig*aAmpEnv					;SEND AUDIO TO OUTPUT
	gkNoteOn	=	0						;CLEAR NOTE ON FLAG
endin


</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT - REAL TIME PERFORMANCE FOR 1 HOUR
;i 2 0 3600	;SOUND PRODUCING INSTRUMENT IS ALWAYS ON
</CsScore>

</CsoundSynthesizer>