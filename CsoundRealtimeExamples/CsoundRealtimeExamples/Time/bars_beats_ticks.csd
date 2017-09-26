bars_beats_ticks.csd
Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr = 44100
ksmps = 4
nchnls = 1
0dbfs = 1

;FLTK INTERFACE CODE==============================================================================================================================================================
FLcolor	255,255,255,255,255,50
;	LABEL                   | WIDTH | HEIGHT | X | Y
FLpanel	"Bars, Beat and Ticks",    235,    200,    0,  0
;SWITCHES                       					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkStartStop,ihStartStop		FLbutton	"Start/Stop",		1,    0,    22,    110,     25,    5, 5,    -1
gkreset,ihreset			FLbutton	"Reset",		1,    1,    21,    110,     25,  120, 5,    0,      2,      0,       0
gkCompSimp,ihCompSimp		FLbutton	"Compound/Simple Time",	3,    1,    22,    200,     25,    5,150,   -1
;VALUE INPUT BOXES				 		MIN |  MAX  |  STEP  | TYPE | WIDTH | HEIGHT | X  | Y
gk, gihbar			FLtext		"Bar",		1,   999999,     1,     1,      70,     20,    5,   50
gk, gihbeat			FLtext		"Beat",		1,   999999,     1,     1,      70,     20,   80,   50
gk, gihtick			FLtext		"Tick",		1,   999999,     1,     1,      70,     20,  155,   50

;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT |  X  | Y | OPCODE
gktempo, ihtempo 		FLcount  "Tempo", 		0,    9999,   0.01,    1,     1,    120,     25,     5,  100,   -1
gkBeatsPerBar, ihBeatsPerBar	FLcount  "Beats per Bar", 	1,    9999,      1,    1,     2,    100,     25,   130,  100,   -1

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	1, 	gihbar
		FLsetVal_i	1, 	gihbeat
		FLsetVal_i	0, 	gihtick
		FLsetVal_i	90, 	ihtempo
		FLsetVal_i	4, 	ihBeatsPerBar
FLpanel_end

	;INSTRUCTIONS AND INFO PANEL
	FLpanel	"", 500, 300, 245, 0
	;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
	ih		 	FLbox  	"            Bars, Beats and Ticks Time-keeping               ", 	1,      5,     14,    490,    20,     5,    0
	ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,   20
	ih		 	FLbox  	"This example demonstrates a simple mechanism to construct a  ", 	1,      5,     14,    490,    20,     5,   40
	ih		 	FLbox  	"metrical clock as might be found in a sequencer. The units of", 	1,      5,     14,    490,    20,     5,   60
	ih		 	FLbox  	"measurement are bars, beats and ticks. The number of beats   ", 	1,      5,     14,    490,    20,     5,   80
	ih		 	FLbox  	"per bar can be changed.                                      ", 	1,      5,     14,    490,    20,     5,  100
	ih		 	FLbox  	"Tempo and number of ticks per beat can be set within the     ", 	1,      5,     14,    490,    20,     5,  120
	ih		 	FLbox  	"code. It is normal for this value to be something divisible  ", 	1,      5,     14,    490,    20,     5,  140
	ih		 	FLbox  	"by 2 and 3 several times and large enough to reduce the      ", 	1,      5,     14,    490,    20,     5,  160                                                         
	ih		 	FLbox  	"influence of rounding errors. Its value in this example is   ", 	1,      5,     14,    490,    20,     5,  180
	ih		 	FLbox  	"960.                                                         ", 	1,      5,     14,    490,    20,     5,  200
	ih		 	FLbox  	"This example may be a useful device in the construction of   ", 	1,      5,     14,    490,    20,     5,  220
	ih		 	FLbox  	"some other more elaborate live set-up that is dependent upon ", 	1,      5,     14,    490,    20,     5,  240
	ih		 	FLbox  	"synchronisation with bars and beats rather than minutes and  ", 	1,      5,     14,    490,    20,     5,  260
	ih		 	FLbox  	"seconds.                                                     ", 	1,      5,     14,    490,    20,     5,  280
FLpanel_end

FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE=======================================================================================================================================================

;INTIALISE CLOCK SETTINGS
gkbar		init	0	;BAR NUMBER NEEDS TO START AT ZERO (AND NOT ONE) AS IT WILL BE IMMEDIATELY INCREMENTED WHEN THE CLOCK IS FIRST STARTED
gkbeat		init	0	;BEAT NUMBER NEEDS TO START AT ZERO (AND NOT ONE) AS IT WILL BE IMMEDIATELY INCREMENTED WHEN THE CLOCK IS FIRST STARTED
gktick		init	0
giTicksPerBeat	init	960	;TICKS: NUMBER OF SUBDIVISIONS OF EACH BEAT 
gisine		ftgen	0,0,1024,10,1

instr	1
	if gkStartStop==0 goto skip					;IF START STOP SWITCH IS ON 'STOP'...
	kbeattick	metro	(gktempo*gkCompSimp)/(60)		;THE BEAT METRONOME
	gkbeat		wrap	gkbeat+kbeattick, 1, gkBeatsPerBar+1	;INCREMENTING BEATS ARE WRAPPED AROUND WHEN THEY EXCEED THE BAR DURATION
	if kbeattick==1&&gkbeat==1 then					;IF BEAT TICK IS OCCURING AND WE HAVE JUST WRAPPED AROUND TO THE BEGINNING OF THE BAR...
	 gkbar = gkbar + 1						;INCREMENT THE BAR COUNTER
	 kbartick = 1							;SET BAR TICK TO '1' (ACTIVE TICK). USED TO INDICATE WHEN TO UPDATE THE DISPLAY
	endif								;END OF CONDITIONAL BRANCH

	if gkCompSimp==3 then						;IF COMPOUND TIME SELECTED...
	 if frac((gkbeat-1)/gkCompSimp)!=0 then				;IF BEAT TICK IS NOT A MAIN BEAT... 
	  kbeattick = 0							;DISABLE BEAT TICK
	 endif
	endif
	
	schedkwhen	kbartick,0,0,"metronome",0,0.1,9		;PLAY METRONOME ON THE FIRST BEAT OF THE BAR
	schedkwhen	kbeattick-kbartick,0,0,"metronome",0,0.1,8	;PLAY METRONOME ON BEATS OTHER THAN THE FIRST OF THE BAR
		FLsetVal	kbeattick,((gkbeat-1)/gkCompSimp)+1,gihbeat	;UPDATE BEAT DISPLAY WHENEVER IT CHANGES
		FLsetVal	kbartick,gkbar,gihbar			;UPDATE BAR DISPLAY WHENEVER IT CHANGES
	kbartick	=	0					;RESET BAR TICK TO 'INACTIVE'
	if kbeattick==1||gkreset==1 then				;UPON EACH BEAT HARD RESET THE TICK PHASOR TO ENSURE PRECISION
	 reinit	RestartTickPhasor					;REINITIALISE (THE TICK PHASOR)
	endif								;END OF CONDITIONAL
	RestartTickPhasor:						;LABEL - BEGIN REINITIALISATION FROM HERE
	kticks	phasor	gktempo/60,i(gktick)/giTicksPerBeat		;'TICKS' PHASOR
	rireturn							;RETURN FROM REINITIALISATION PASS - RESUME PERFORMANCE PASSES
	gktick	=	kticks*giTicksPerBeat				;NUMBER OF TICKS ELAPSED
	gkreset	=	0
	kupdate	metro	50						;RATE AT WHICH 'TICK' DISPLAY IS UPDATED
		FLsetVal	kupdate,kticks*giTicksPerBeat,gihtick	;UPDATE 'TICK' READ-OUT
	skip:
endin

instr	2	;RESET CLOCK
	gkbar		init	0
	gkbeat		init	0
	gktick		init	0
	FLsetVal_i	1,gihbar
	FLsetVal_i	1,gihbeat
	FLsetVal_i	0,gihtick
endin

instr	metronome
	aenv	expon	1,p3,0.001			;PERCUSSIVE AMPLITUDE ENVELOPE
	asig	poscil	aenv*0.2,cpsoct(p4),gisine	;OSCILLATOR
		out	asig				;SEND AUDIO TO OUTPUT
endin

</CsInstruments>

<CsScore>
i 1 0 3600
e
</CsScore>                               

</CsoundSynthesizer>