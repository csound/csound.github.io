MIDITapTempo.csd
Written by Iain McCurdy 2008. Updated 2011.

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -Ma -dm0
</CsOptions>

<CsInstruments>

sr	= 	44100
ksmps	= 	8
nchnls	= 	1
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 50, 0, 0
;		LABEL		 	| WIDTH | HEIGHT | X | Y
	FLpanel	"MIDI Tap Tempo",   	   300,    125,    0,  0

;KOUT | HANDLE		FLTEXT	 "LABEL"        | MIN | MAX | STEP | TYPE | WIDTH | HEIGHT |  X | Y
gkBeatDur, gihBeatDur	FLtext	"Beat Duration",   0,     20,    0,   1,     100,     25,    25, 25
gkTempo, gihTempo	FLtext	"Tempo",   	   0,  10000, 0.01,   1,     100,     25,   175, 25

;BUTTONS                                     		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | I | STARTTIM | IDUR
gkMetronome,ihMetronome	FLbutton	"Metronome",	1,    0,    22,    100,     25,   25, 75,   0,      3,     0,      -1
gkDelay,ihDelay		FLbutton	"Delay",	1,    0,    22,    100,     25,  175, 75,   0,      5,     0,      -1
FLsetColor2	255, 255, 50, ihMetronome	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihDelay	;SET SECONDARY COLOUR TO YELLOW

	FLsetVal_i	60,gihTempo
	FLsetVal_i	1,gihBeatDur

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                   WIDTH | HEIGHT | X | Y
				FLpanel	"info", 500,     220,   312, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                      MIDI Tap Tempo                         ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"This example demonstrates a method for defining a tempo by   ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"tapping notes on a MIDI keyboard. The time gap between notes ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"is averaged across a number of taps, from this a tempo value ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"is derived and this result can be used to define the tempo of", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"a metronome or the delay time of a simple delay effect that  ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"is applied to the live audio input of the computer.          ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"The average of the previous two time gap readings is taken,  ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"A minimum of four note taps will normally be required to     ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"derive an accurate tempo.                                    ", 	1,      5,     14,    490,    20,     5, 200

		FLpanel_end
		FLrun

gisine		ftgen	0,0,4096,10,1	;A SINE WAVE
gkDlyTim	init	1		;INITIALISE DELAY TIME VARIABLE USED IN THE DELAY EFFECT IN INSTR 4
gkTimer		init	1		;TIMER THAT MEASURES THE TIME GAP BETWEEN ADJACENT NOTES
giTimeGap	init	1		;MOST RECENT TIME GAP
gkBeatDur	init	1		;AVERAGE OF ALL TIME GAPS STORED IN TABLE
gkTempo		init	60		;CURRENT TEMPO
giTimes		ftgen	0,0,-2,-2,1,1	;TABLE TO STORE TIME GAPS
giTabLoc	init	0		;TABLE LOCATION COUNTER
gkNoteOnFlag	init	0		;TRIGGER IMPULSE WHENEVER A MIDI NOTE IS PLAYED (USED IN METRONOME INSTRUMENT)

instr	timer	;RUNS TIMER
	gkTimer	timeinsts	;TIMER READS THE TIME SINCE THIS NOTE BEGAN
endin

instr	1	;MIDI TRIGGERED INSTRUMENT - RECEIVES 'TAPS'
	;SENSE TEMPO
	iTimeGap	init	i(gkTimer)			;READ TIME GAP BETWEEN PREVIOUS NOTE AND THIS ONE
	iTimeGap	=	(iTimeGap>2?i(gkBeatDur):iTimeGap);DON'T ALLOW EXCESSIVELY LONG TIME GAPS - I.E. AFTER A LONG WAIT WHICH IS PROBABLY NOT INTENDED AS AN INDICATION OF TEMPO - INSTEAD REPLACE READING WITH THE CURRENT TEMPO
			tablew	iTimeGap,giTabLoc,giTimes	;WRITE TIME GAP READING TO FUNCTION TABLE
	iNumVals	=	ftlen(giTimes)			;DEDUCE NUMBER OF TIMER READING LOCATIONS IN THE TABLE
	giTabLoc	wrap	giTabLoc+1,0,iNumVals		;INCREMENT THE TABLE LOCATION COUNTER. WRAP AROUN BACK TO ZERO IF REQUIRED
	iSumVals	init	0				;INITIALISE AND CLEAR SUM OF ALL TIME GAP READINGS STORED IN giTimes TABLE
	iLoopCount	init	0				;INITIALISE LOOP COUNTER
	LOOP_BEGIN:						;LABEL. LOOP BEGINS HERE
	ival		table	iLoopCount,giTimes		;READ TIME GAP READING FROM TABLE
	iSumVals	=	iSumVals+ival			;ADD TIME GAP READING FROM TABLE TO THE ACCUMULATING VARIABLE iSumVals
	loop_lt  iLoopCount, 1, iNumVals, LOOP_BEGIN		;LOOP BACK TO THE BEGINNING OF THE LOOP IF THERE ARE STILL MORE TIME GAP READINGS TO BE READ
	gkBeatDur	init	iSumVals/iNumVals		;FIND THE AVERAGE OF THE TABLE
			FLsetVal_i	i(gkBeatDur),gihBeatDur	;WRITE THE AVERAGE TO FLTK NUMBER BOX
	gkTempo		init	60/i(gkBeatDur)			;DEDUCE TEMPO
			FLsetVal_i	i(gkTempo),gihTempo	;WRITE TEMPO VALUE TO FLTK NUMBER BO
	event_i	"i","timer",0,-1				;START TIMER TO READ TIME GAP UNTIL THE NEXT NOTE
endin


instr	3	;METRONOME
	if gkMetronome=0 then		;IF METRONOME SWITCH IS OFF...
	  turnoff			;...TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCH

	if gkNoteOnFlag=1 then		;IF A MIDI NOTE HAS JUST BEEN STRUCK...
	  reinit	RESTART_METRO	;REINITIALISE THE METRONOME IN ORDER TO SYNC UP WITH MIDI KEY TAPS
	endif				;END OF CONDITIONAL BRANCH
	RESTART_METRO:			;A LABEL. REINTILISATION OF THE METRONOME BEGINS HERE.
	kmetro	metro	gkTempo/60	;CREATE A TRAIN OF METRONOME TRIGGER ACCORDING TO CURRENT TEMPO
	rireturn			;RETURN FROM REINITIALISATION PASS
	if kmetro=1 then			;IF A METRONOME BEAT HAS BEEN RECEIVED
	  reinit	RESTART_CLICK		;RESTART THE METRONOME CLICK ENVELOPES
	endif					;END OF CONDITIONAL BRANCH
	RESTART_CLICK:				;A LABEL. REINTIALISATION OF THE METRONOME ENVELOPES (AMPLITUDE AND PITCH) BEGINS HERE.
	aenv	linseg	0,0.001,1,0.005-0.001,0	;PERCUSSIVE ENVELOPE
	afreq	expseg	4000,0.005,200,1,200	;PITCH OF TONE (VERY FAST GLISS)
	asig	oscili	0.5*aenv,afreq,gisine	;CREATE AUDIO FOR METRONOME 'CLICK'
	rireturn				;RETURN FROM REINITIALISATION PASS
		out	asig			;SEND AUDIO TO OUPUT
	gkNoteOnFlag	=	0	;CLEAR NOTE ON FLAG	
endin

instr	5	;DELAY
	if gkDelay=0 then
	  turnoff
	endif
	ain		inch	1			;READ AUDIO FROM FIRST AUDIO INPUT CHANNEL
	kBeatDur	limit	gkBeatDur,0.001,8	;LIMIT BEAT-DURATION VARIABLE TO BE WITHIN SENSIBLE LIMITS (NEEDED TO PROTECT AGAINST DELAY TIMES EXCEEDING BUFFER)
	aBeatDur	interp	kBeatDur		;CREATE A-RATE VERSION OF BEAT DURATION VARIABLE
	abuf		delayr	8			;DECLARE DELAY BUFFER
	aTap		deltap3	aBeatDur		;READ AUDIO FROM A DELAY TAP WITHIN THE BUFFER
			delayw	ain+(aTap*0.7)		;WRITE AUDIO INTO THE BUFFER (ADD A LITTLE BIT OF FEEDBACK FROM THE DELAY TAP ALSO)
			out	ain+aTap		;SEND AUDIO TO OUTPUT (MIX OF DRY AND DELAYED AUDIO)
endin

</CsInstruments>

<CsScore>
f 0 3600
</CsScore>

</CsoundSynthesizer>