DynamicTriggeredRecord.csd
Written by Iain McCurdy 2006. Updated 2011.

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0 -M0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>

sr 	= 	44100	
ksmps 	= 	1
nchnls 	= 	1
0dbfs	=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
		FLpanel	" ", 500, 350, 0, 0
;SWITCHES                         	             				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkRecReady,gihRecReady			FLbutton	"Rec. Ready",		1,    0,    22,    100,     30,    10, 10,    0,      3,      0,      -1
FLsetColor2	255, 0, 0, gihRecReady	;SET SECONDARY COLOUR TO RED
gkPlayOnce,gihPlayOnce			FLbutton	"Play (Once)",		1,    0,    22,    150,     50,   120, 10,    0,      5,      0,      -1
gkLoopPlay,gihLoopPlay			FLbutton	"Play (Looped)",	1,    0,    22,    150,     50,   120, 60,    0,      6,      0,      -1
FLsetColor2	0, 255, 0, gihPlayOnce	;SET SECONDARY COLOUR TO GREEN
FLsetColor2	0, 255, 0, gihLoopPlay	;SET SECONDARY COLOUR TO GREEN
gkAutoPlayOnce,ihAutoPlayOnce		FLbutton	"Auto Play Once",	1,    0,    22,    150,     50,   280, 10,   -1
gkAutoLoopPlay,ihAutoLoopPlay		FLbutton	"Auto Play Looped",	1,    0,    22,    150,     50,   280, 60,   -1
gkResetRecReady,gihResetRecReady	FLbutton	"Reset Rec. Ready",	1,    0,    22,    100,     50,    10, 60,   -1
FLsetColor2	255, 150, 0, gihResetRecReady	;SET SECONDARY COLOUR TO RED
FLsetColor2	255, 255, 50, ihAutoPlayOnce	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihAutoLoopPlay	;SET SECONDARY COLOUR TO YELLOW

;HANDLE		OPCODE	"LABEL"    		WIDTH | HEIGHT | POS_X | POS_Y
idOnThresh	FLvalue	" ",        		 60,      25,    430,    150
idOffThresh	FLvalue	" ",        		 60,      25,    430,    175
idSpeed		FLvalue	" ",        		 60,      18,     10,    275
idGain		FLvalue	" ",        		 60,      18,     10,    325

;FLLABEL  SIZE | FONT | ALIGN | RED | GREEN | BLUE
FLlabel   12,       5,    4,     0,     0,      0	;WIDGET LABELS ALIGNED TO THE LEFT
FLcolor  255, 255, 255, 0, 255, 0	;GREEN
;SLIDERS			            			MIN   | MAX | EXP | TYPE |  DISP        | WIDTH | HEIGHT | X  | Y
gkmeter, gihmeter		FLslider 	"        Meter",0,      0.1,  0,   1,       -1,         390,     25,   100,  125
FLcolor  255, 255, 255, 200, 200, 240	;LIGHT GREY
gkOnThresh, ihOnThresh		FLslider 	" On Threshold",0,      0.1,  0,   1,   idOnThresh,     330,     25,   100,  150
gkOffThresh, ihOffThresh	FLslider 	"Off Threshold",0,      0.1,  0,   1,   idOffThresh,    330,     25,   100,  175
;FLLABEL  SIZE | FONT | ALIGN | RED | GREEN | BLUE
FLlabel   14,      1,     3,     0,     0,      0	;WIDGET LABELS ALIGNED TO THE BOTTOM, BLACK, HELVETICA/ARIAL, 12 pt.
;SLIDERS			            			MIN   | MAX | EXP | TYPE |  DISP        | WIDTH | HEIGHT | X  | Y
gkSpeed, ihSpeed		FLslider 	"Speed",	-2,      2,    0,     3,   idSpeed,        480,     25,    10,  250
gkGain, ihGain			FLslider 	"Output Gain",	 0,      1,    0,     3,   idGain,         480,     25,    10,  300

FLcolor 255, 255, 255, 255, 0, 0	;RED

;SLIDERS					MIN   | MAX | EXP | TYPE |  DISP | WIDTH | HEIGHT | X  | Y
gkRec, gihRec		FLslider 	"",	0,       1,     0,    1,  -1,      100,     20,    10,  40	;RECORDING RED LIGHT

		FLsetVal_i	0.03, ihOnThresh
		FLsetVal_i	0.01, ihOffThresh
		FLsetVal_i	0, gihRec
		FLsetVal_i	0, gihRecReady
		FLsetVal_i	0, gihLoopPlay
		FLsetVal_i	0, ihAutoLoopPlay
		FLsetVal_i	1, ihSpeed
		FLsetVal_i	0.7, ihGain

		FLpanel_end	; END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 500, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                Dynamic Triggered Recording                  ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"This example tracks the dynamics of the live incoming audio  ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"and triggers a recording function (writing to a function     ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"table) when the signal rises above a user defined amplitude  ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"threshold. When the signal subsequently drops below another  ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"user defined threshold recording ceases. What is stored in   ", 	1,      5,     14,    490,    15,     5, 120
ih	  	 	FLbox  	"in the function table is a topped and tailed sound fragment  ", 	1,      5,     14,    490,    15,     5, 140
ih	  	 	FLbox  	"without silence at the begging or end of the recording.      ", 	1,      5,     14,    490,    15,     5, 160
ih	  	 	FLbox  	"The 'Rec. Ready' button must be on to begin scanning the     ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"input signal amplitude for threshold crossing.               ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"The user then has the option of playing back the recording   ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"either once ('Play (Once)') or looped  ('Play (Looped)').    ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"If 'Auto Play Once' is selected the recording begins playing ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"immediately the recording process ceases. 'Auto Play Looped' ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"acts in a similar fashion but on the 'Play (Looped)'         ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"function.                                                    ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"If 'Reset Rec. Ready' is selected the 'Rec. Ready' button    ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"is automatically switched on again as soon as recording has  ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"completed.                                                   ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"The user can also modulate the speed of playback. Negative   ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"values here result in reverse direction playback.            ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"Recorded material can also be played back via a MIDI         ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"keyboard. MIDI pitch and velocity are interpretted           ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"appropriately.                                               ", 	1,      5,     14,    490,    15,     5, 480

				FLpanel_end
		FLrun		; RUN THE WIDGET THREAD!

giaudio		ftgen 		0, 0, 1048576, -7, 0	;AUDIO DATA STORAGE
gkrecdur	init		0			;GLOBAL VARIABLE CONTAINING THE DURATION OF THE LAST MADE RECORDING

instr	1	;MIDI PLAYBACK INSTRUMENT
	icps	cpsmidi						;READ MIDI PITHC DATA FROM MIDI INPUT
	imlt	=	icps/cpsoct(8)				;CREATE A PLAYBACK RATIO FROM MIDI NOTE. MIDDLE C IS UNISON POINT.
	iamp	ampmidi	1					;READ MIDI KEY VELOCITY
	andx	line	0,1,1					;INFINITELY RISING LINE USED AS STARTING POINT FOR FILE POINTER
	if	gkSpeed>=0	then				;IF skSpeed IS POSITIVE (OR ZERO), I.E. FORWARDS PLAYBACK
		andx	=	andx*sr*imlt			;RESCALE POINTER ACCORDING TO SPEED
		kndx	downsamp	andx			;CREATE kndx, A K-RATE VERSION OF andx
		if	kndx>=gkrecdur	then			;IF END OF RECORDING IS REACHED...
			FLsetVal	1, 0, gihPlayOnce	;...DEACTIVATE PLAY BUTTON &
			turnoff					;TURN OFF THIS INSTRUMENT IMMEDIATELY.
		endif						;END OF CONDITIONAL BRANCH
	else							;OTHERWISE (I.E. SPEED IS NEGATIVE: BACKWARDS PLAYBACK)...
		andx		=	(andx*sr*imlt)+i(gkrecdur);RESCALE POINTER ACCORDING TO SPEED
		kndx	downsamp	andx			;CREATE kndx, A K-RATE VERSION OF andx
		if	kndx<0		then			;IF END OF RECORDING IS REACHED...
			FLsetVal	1, 0, gihPlayOnce	;...DEACTIVATE PLAY BUTTON &
			turnoff					;TURN OFF THIS INSTRUMENT IMMEDIATELY.
		endif						;END OF CONDITIONAL BRANCH
	endif							;END OF CONDITIONAL BRANCH
	;OUT 	OPCODE 		INDEX | FUNCTION_TABLE
	asig	table3		andx,      giaudio	;READ AUDIO FROM AUDIO STORAGE FUNCTION TABLE
	aenv	linsegr	0,0.001,1,0.01,0		;ANTI-CLICK AMPLITUDE ENVELOPE WITH RELEASE STAGE 
		out	asig*gkGain*aenv*iamp		;SEND AUDIO TO OUTPUT
endin

instr	2	;READ RT AUDIO IN AND CREATE FOLLOW SIGNAL
	gasig 		inch		1		;READ CHANNEL 1 (LEFT CHANNEL IF STEREO)
	gkrms 		rms 		gasig		;CREATE A AMPLITUDE FOLLOWING UNIPOLAR SIGNAL
	kmetertrig	metro		30		;METRONOMIC TRIGGER (USED TO CONTROL THE RATE OF METER UPDATES) - 30 PER SECOND
	FLsetVal	kmetertrig, gkrms, gihmeter	;UPDATE METER
endin

instr	3	;RECORD_READY
	if	gkRecReady=0	then			;IF FLTK 'Rec. Ready' BUTTON IS IN THE OFF POSITION...
		turnoff					;...TURN OFF THIS INSTRUMENT IMMEDIATELY
	endif						;END OF CONDITIONAL BRANCH
	if	gkrms	>gkOnThresh	then		;IF AMPLITUDE FOLLOWING SIGNAL IS ABOVE 'ON THRESHOLD'...
		FLsetVal	1,1, gihRec		;...TURN ON 'RECORDING' RED LIGHT...
		FLsetVal	1,0, gihRecReady	;...TURN OFF 'RECORD READY' BUTTON
		;SCHEDKWHEN 	KTRIGGER, KMINTIM, KMAXNUM, KINSNUM, KWHEN, KDUR
		schedkwhen    	1, 	     0,       1,       4,      0,    -1	;AND TRIGGER RECORD
		turnoff					;TURN OFF THIS INSTRUMENT IMMEDIATELY (WE DON'T WANT TO RETRIGGER RECORDING UNTIL THE CURRENT ONE HAS COMPLETED) 
	endif						;END OF CONDITIONAL BRANCH
endin

instr	4	;RECORD
	itablen	tableng	giaudio					;INTERROGATE FUNCTION TABLE USED FOR AUDIO RECORDING TO DETERMINE ITS LENGTH - THIS WILL BE USED TO CONTROL THE MOVEMENT OF THE WRITE POINTER
	andx	phasor	sr / itablen				;CREATE A WRITE POINTER USING phasor. FREQUENCY WILL BE DEPENDENT UPON SAMPLING RATE (sr) AND THE LENGTH OF THE TABLE USED FOR STORAGE
	andx	=	andx * itablen				;RESCALE THE SCOPE OF THE POINTER
	gkrecdur	downsamp	andx			;CREATE A GLOBAL K-RATE VERSION OF THE WRITE POINTER
	aenv	linsegr	0, .005, 1, .005, 0			;CREATE 'ANTI-CLICK' AMPLITUDE ENVELOPE FOR AUDIO THAT IS WRITTEN TO THE FUNCTION TABLE
	asig	=	gasig * aenv				;'ANTI-CLICK' AMPLITUDE ENVELOPE IS APPLIED TO AUDIO BEFORE IT IS WRITTEN TO THE TABLE
	tablew	asig, andx, giaudio				;WRITE AUDIO TO AUDIO STORAGE TABLE
	if	gkrms < gkOffThresh	then			;IF OUR AMPLITUDE FOLLOWING VARIABLE HAS DROPPED BELOW THE 'OFF THRESHOLD'...
		FLsetVal	1, 0, gihRec			;...TURN OFF 'RECORDING' RED LIGHT		
		if	gkAutoLoopPlay = 1	then		;IF 'Auto Play Looped' IS ON...
			FLsetVal	1, 1, gihLoopPlay	;TURN ON PLAY LOOPED BUTTON
		elseif	gkAutoPlayOnce = 1	then		;IF 'Auto Play Once' IS ON...
			FLsetVal	1, 1, gihPlayOnce	;...TURN ON 'Play Once' BUTTON
		endif						;END OF CURRENT CONDITIONAL BRANCH
		if	gkResetRecReady	= 1	then		;IF 'Reset Rec. Ready' IS ON...
			FLsetVal	1, 1, gihRecReady	;...TURN ON 'Rec. Ready' BUTTON
		endif						;END OF CURRENT CONDITIONAL BRANCH
		turnoff						;TURNOFF THIS INSTRUMENT IMMEDIATELY
	endif							;END OF CONDITIONAL BRANCHING
endin

instr	5	;PLAY ONCE INSTRUMENT
	if	gkPlayOnce=0	then				;IF PLAY BUTTON IS DEACTIVATED THEN...
		turnoff						;...TURNOFF THIS INSTRUMENT IMMEDIATELY
	endif							;END OF CONDITIONAL BRANCHING
	andx	line	0,1,1					;INFINITELY RISING LINE USED AS STARTING POINT FOR FILE POINTER
	if	gkSpeed>=0	then				;IF skSpeed is POSITIVE (OR ZERO), I.E. FORWARDS PLAYBACK
		andx	=	andx*sr*gkSpeed			;RESCALE POINTER ACCORDING TO SPEED
		kndx	downsamp	andx			;CREATE kndx, A K-RATE VERSION OF andx
		if	kndx>=gkrecdur	then			;IF END OF RECORDING IS REACHED...
			FLsetVal	1, 0, gihPlayOnce	;...DEACTIVATE PLAY BUTTON &
			turnoff					;TURN OFF THIS INSTRUMENT IMMEDIATELY.
		endif
	else
		andx	=		(andx*sr*gkSpeed)+i(gkrecdur)	;RESCALE POINTER ACCORDING TO SPEED
		kndx	downsamp	andx				;CREATE kndx, A K-RATE VERSION OF andx
		if	kndx<0		then				;IF END OF RECORDING IS REACHED...
			FLsetVal	1, 0, gihPlayOnce		;...DEACTIVATE PLAY BUTTON &
			turnoff						;TURN OFF THIS INSTRUMENT IMMEDIATELY.
		endif
	endif
	;OUT 	OPCODE 		INDEX | FUNCTION_TABLE
	asig	table3		andx,      giaudio			;READ AUDIO FROM AUDIO STORAGE FUNCTION TABLE
		out		asig*gkGain				;SEND AUDIO TO OUTPUT
endin
		
instr	6	;PLAY LOOPED
	if	gkLoopPlay=0	then				;IF LOOP-PLAY BUTTON IS OFF...
		turnoff                 			;...TURN OFF THIS INSTRUMENT
	endif                   				;END OF CONDITIONAL BRANCH
	irecdur	=		i(gkrecdur)			;DEFINE irecdur, AN I-RATE VERSION OF THE MOST RECENT VALUE OF gkrecdur (RECORDING DURATION IN SAMPLE FRAMES / TABLE POINT VALUES)
	aptr	phasor		(sr * gkSpeed) / irecdur	;CREATE READ POINTER FREQUENCY DEPENDENT UPON SAMPLING RATE, 'Speed' SLIDER, AND irecdur 
	aptr	=		aptr * irecdur			;RESCALE READ POINTER ACCCORDING TO irecdur VALUE SO THAT THE ENTIRE DURATION OF THE LAST RECORDING WILL BE PLAYED
	asig	table3		aptr, giaudio			;READ AUDIO FROM FUNCTION TABLE USING table3 OPCODE
	aenv	linsegr		1, 3600, 1, .01, 0		;CREATE AN AMPLITUDE ENVELOPE RELEASE FADE OUT TO PREVENT CLICKS IF PLAYBACK IS TERMINATED
		out		asig*aenv*gkGain		;SEND AUDIO TO OUTPUT
endin

</CsInstruments>

<CsScore>
i 2 0 3600	;READ REALTIME AUDIO IN AND SCAN DYNAMICS
</CsScore>

</CsoundSynthesizer>