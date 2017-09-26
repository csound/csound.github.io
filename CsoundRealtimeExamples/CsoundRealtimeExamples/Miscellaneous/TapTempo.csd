TapTempo.csd
Written by Iain McCurdy 2011.

This example uses tapping of the computer's space bar to derive a tempo.
The tempo deduced and beat duration are printed to the computer terminal each time the space bar is struck.
An audio metronome provides audible confirmation of the current tempo value.
Tempo is calculated by measuring the time gap between successive tappings of the space bar 
and by then regarding this measurement as a beat duration.
Beat duration is actually calculated by averaging the previous two time gaps.  
It is necessary to tap the space bar at least four times at a particular tempo to arrive at an accurate calculation of that tempo.
Because the 'sensekey' opcode is used, it is necessary for the terminal window to be in focus for this example to work - 
- for this reason no FLTK GUI is used.
If you want to sense computer keyboard tappings when an FLTK GUI panel is used and in focus you could use the FLkeyIn opcode.

Tempo and beat duration are provided as global variables so that the code for this instrument could easily be transplanted into another
orchestra. Encapsulating all code within a single instrument block assists in this end also.

<CsoundSynthesizer>

<CsOptions>
-odac -dm0                                          
</CsOptions>
                                                       
<CsInstruments>

sr	= 	44100
ksmps	= 	8
nchnls	= 	1	;MONO
0dbfs	=	1	;MAXIMUM AMPLITUDE


instr	taptempo
			prints		"Tap the space bar repeatedly...%n" ;PRINT INSTRUCTION TO THE TERMINAL
	;SET SOME INITIAL VALUES AND CREATE FUNCTION TABLES                  
	kTimer		init		1			;TIMER THAT MEASURES THE TIME GAP BETWEEN ADJACENT NOTES
	gkBeatDur	init		1			;AVERAGE OF ALL TIME GAPS STORED IN TABLE
	gkTempo		init		60			;CURRENT TEMPO
	iTabLoc		init		0			;TABLE LOCATION COUNTER
	iTimes		ftgentmp	0,0,-2,-2,1,1		;TABLE TO STORE TIME GAPS
	isine		ftgentmp	0,0,4096,10,1		;A SINE WAVE

	;SENSE TEMPO
	kkey		sensekey						;SENSE ACTIVITY ON THE COMPUTER KEYBOARD
	ktrig		changed		kkey					;IF THERE IS A CHANGE ON THE COMPUTER KEYBOARD GENERATE AN IMPULSE
 	if ktrig=1&&kkey=32 then						;IF THERE HAS BEEN A CHANGE ON THE KEYBOARD AND IT IS THE SPACE BAR 
 	  		reinit		SPACEBAR				;BEGIN A REINITIALISATION PAS FROM LABEL 'SPACEBAR'
 	endif									;END OF CONDITIONAL BRANCH
 	SPACEBAR:								;LABEL CALLED 'SPACEBAR'. REINITIALISATION BEGINS FROM HERE AFTER THE SPACE BAR IS STRUCK.
	kNoteOnFlag	init		1					;NOTE ON FLAG IS SET TO ON (WILL BE RESET TO ZERO IN INSTR 3)
 	iTimeGap	init		i(kTimer)				;READ TIME GAP BETWEEN PREVIOUS NOTE AND THIS ONE
	iTimeGap	=		(iTimeGap>2?i(gkBeatDur):iTimeGap)	;DON'T ALLOW EXCESSIVELY LONG TIME GAPS - I.E. AFTER A LONG WAIT WHICH IS PROBABLY NOT INTENDED AS AN INDICATION OF TEMPO - INSTEAD REPLACE READING WITH THE CURRENT TEMPO
			tablew		iTimeGap,iTabLoc,iTimes			;WRITE TIME GAP READING TO FUNCTION TABLE
	iNumVals	=		ftlen(iTimes)				;DEDUCE NUMBER OF TIMER READING LOCATIONS IN THE TABLE
	iTabLoc		wrap		iTabLoc+1,0,iNumVals			;INCREMENT THE TABLE LOCATION COUNTER. WRAP AROUN BACK TO ZERO IF REQUIRED
	iSumVals	init		0					;INITIALISE AND CLEAR SUM OF ALL TIME GAP READINGS STORED IN giTimes TABLE
	iLoopCount	init		0					;INITIALISE LOOP COUNTER
	LOOP_BEGIN:								;LABEL. LOOP BEGINS HERE
	ival		table		iLoopCount,iTimes			;READ TIME GAP READING FROM TABLE
	iSumVals	=		iSumVals+ival				;ADD TIME GAP READING FROM TABLE TO THE ACCUMULATING VARIABLE iSumVals
			loop_lt  	iLoopCount,1,iNumVals,LOOP_BEGIN	;LOOP BACK TO THE BEGINNING OF THE LOOP IF THERE ARE STILL MORE TIME GAP READINGS TO BE READ
	gkBeatDur	init		iSumVals/iNumVals			;FIND THE AVERAGE OF THE TABLE
	gkTempo		init		60/i(gkBeatDur)				;DEDUCE TEMPO
			prints 		"tempo:%5.2f%tbeat duration:%5.3f%n",gkTempo,gkBeatDur	;PRINT TEMPO AND BEAT DURATION TO THE TERMINAL
	kTimer		timeinsts						;TIMER READS THE TIME SINCE THIS NOTE BEGAN
			rireturn
	;AUDIO METRONOME
	kmetro		metro		gkTempo/60			;CREATE A TRAIN OF METRONOME TRIGGER ACCORDING TO CURRENT TEMPO
	if kmetro=1 then						;IF A METRONOME BEAT HAS BEEN RECEIVED
	  		  reinit	RESTART_CLICK			;REINITIALISE THE METRONOME
	endif								;END OF CONDITIONAL BRANCH
	RESTART_CLICK:							;A LABEL. REINTIALISATION OF THE METRONOME ENVELOPES (AMPLITUDE AND PITCH) BEGINS HERE.
	aenv		linseg		0,0.001,1,0.005-0.001,0		;PERCUSSIVE AMPLITUDE ENVELOPE
	afreq		expseg		4000,0.005,200,1,200		;PITCH OF TONE (VERY FAST GLISS DOWN TO A HELD VALUE)
			rireturn					;RETURN FROM REINITIALISATION PASS
	asig		oscili		0.5*aenv,afreq,isine		;CREATE AUDIO FOR METRONOME 'CLICK'
			out		asig				;SEND AUDIO TO OUPUT
endin

</CsInstruments>

<CsScore>
i "taptempo" 0 3600 
</CsScore>

</CsoundSynthesizer>