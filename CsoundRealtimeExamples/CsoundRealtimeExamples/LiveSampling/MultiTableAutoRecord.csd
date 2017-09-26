MultiTableAutoRecord.csd
Written by Iain McCurdy 2011.

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0 -M0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>

sr 	= 	44100	
ksmps 	= 	4
nchnls 	= 	1
0dbfs	=	1	;MAXIMUM AMPLITUDE
maxalloc	2,1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
		FLpanel	"Multi-table Auto-record", 500, 450, 0, 0
;SWITCHES                         	             				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkRecReady,ihRecReady			FLbutton	"Record Buffers",	1,    0,    22,    150,     30,    10, 10,    0,      2,      0,      -1
gkReset,ihReset				FLbutton	"Reset Buffers",	1,    0,    21,    140,     30,   170, 10,    0,      3,      0,       0
gkMeter,ihMeter				FLbutton	"Meter On/Off",		1,    0,    22,    140,     25,   170, 45,    0,      6,      0,      -1
FLsetColor2	255, 0, 0, ihRecReady	;SET SECONDARY COLOUR TO RED
FLsetColor2	255,250,50, ihMeter	;SET SECONDARY COLOUR TO RED

;VALUE INPUT BOXES				 		MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkBufNum,gihBufNum		FLtext		"Buffer Number",1,   2000,    1,     1,    80,     20,    390, 5

;HANDLE		OPCODE	"LABEL"    		WIDTH | HEIGHT | POS_X | POS_Y
idOnThresh	FLvalue	" ",        		 60,      25,    430,    100
idOffThresh	FLvalue	" ",        		 60,      25,    430,    125

;VALUE DISPLAY BOXES			WIDTH | HEIGHT | X |  Y
idRetrigDel		FLvalue	" ",	60,       18,    5,  200
idMinTim		FLvalue	" ",	60,       18,    5,  250
idMinPeak		FLvalue	" ",	60,       18,    5,  300
idDelayAudio		FLvalue	" ",	60,       18,    5,  350

;SLIDERS			            					MIN   | MAX | EXP | TYPE |    DISP        | WIDTH | HEIGHT | X  | Y
gkRetrigDel, ihRetrigDel	FLslider 	"Retrigger Delay",		0.001,  0.1,  -1,    23,   idRetrigDel,      490,     25,    5,  175
gkMinTim, ihMinTim		FLslider 	"Minimum Allowed Time",		0.01,   0.5,   0,    23,      idMinTim,      490,     25,    5,  225
gkMinPeak, ihMinPeak		FLslider 	"Minimum Allowed Amp. Peak",	0.01,   0.9,  -1,    23,     idMinPeak,      490,     25,    5,  275
gkDelayAudio, ihDelayAudio	FLslider 	"Delay Audio",			0.0001, 0.2,  -1,    23,  idDelayAudio,      490,     25,    5,  325

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ihKeyRange	 	FLbox  	" ", 	6,      9,     15,    200,     70,    5, 370	;KEY RANGE SUB-PANEL
;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ihKR_Label	 	FLbox  	"Key Range", 	1,      1,     14,    190,     15,   10,  377
FLsetColor	205,205,255, ihKeyRange	;SET COLOUR
FLsetColor	205,205,255, ihKR_Label	;SET COLOUR 

;COUNTERS					     					MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkMinKey, ihMinKey		FLcount  	"Min.", 				0,    127,   1,       1,     2,      80,     20,    20,400,   -1 
gkMaxKey, ihMaxKey		FLcount  	"Max.", 				0,    127,   1,       1,     2,      80,     20,   110,400,   -1 
gkManBuf, ihManBuf		FLcount  	"Manually Adjust Buffer Counter",	1,    128,   1,      10,     1,     150,     30,   240,375,    0, 5, 0, 0 

;FLLABEL  SIZE | FONT | ALIGN | RED | GREEN | BLUE
FLlabel   12,       5,    4,     0,     0,      0	;WIDGET LABELS ALIGNED TO THE LEFT
FLcolor  255, 255, 255, 0, 255, 0	;GREEN


;SLIDERS			            				MIN   | MAX | EXP | TYPE |    DISP        | WIDTH | HEIGHT | X  | Y
gkmeter, gihmeter		FLslider 	"        Meter",	0,      0.1,   0,     1,       -1,           390,     25,   100,   75
FLcolor  255, 255, 255, 200, 200, 240	;LIGHT GREY
gkOnThresh, ihOnThresh		FLslider 	" On Threshold",	0,      0.1,   0,     1,   idOnThresh,       330,     25,   100,  100
gkOffThresh, ihOffThresh	FLslider 	"Off Threshold",	0,      0.1,   0,     1,   idOffThresh,      330,     25,   100,  125
;FLLABEL  SIZE | FONT | ALIGN | RED | GREEN | BLUE
FLlabel   14,      1,     3,     0,     0,      0	;WIDGET LABELS ALIGNED TO THE BOTTOM, BLACK, HELVETICA/ARIAL, 12 pt.

FLcolor 255, 255, 255, 255, 0, 0	;RED

;SLIDERS					MIN   | MAX | EXP | TYPE |  DISP | WIDTH | HEIGHT | X  | Y
gkRec, gihRec		FLslider 	"",	0,       1,    0,    1,      -1,    150,     20,    10,  40	;RECORDING RED LIGHT

		FLsetVal_i	0.03, ihOnThresh
		FLsetVal_i	0.02, ihOffThresh
		FLsetVal_i	0.01, ihRetrigDel
		FLsetVal_i	0.01, ihRetrigDel
		FLsetVal_i	0.07,  ihMinTim
		FLsetVal_i	0.05,  ihMinPeak
		FLsetVal_i	0.05, ihDelayAudio
		FLsetVal_i	1, gihBufNum
		FLsetVal_i	21, ihMinKey
		FLsetVal_i	109,ihMaxKey
		FLsetVal_i	1,ihManBuf
		FLsetVal_i	1,ihMeter

		FLpanel_end	; END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 660, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                 Multi-table Auto-record                     ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"This example buffers and 'edits' audio on the fly. Audio     ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"chunks are written in sequential function tables. In this    ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"example 127 buffers are implemented but this number could    ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"easily be increased. When the final buffer has been written  ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"to, writing begins again at the first buffer.                ", 	1,      5,     14,    490,    15,     5, 120
ih	  	 	FLbox  	"Each recorded chunk is automatically mapped to a different   ", 	1,      5,     14,    490,    15,     5, 140
ih	  	 	FLbox  	"note on a MIDI keyboard for playback.                        ", 	1,      5,     14,    490,    15,     5, 160
ih	  	 	FLbox  	"Editing of audio chunks is done based on the setting of the  ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"On and Off Thresholds. If the R.M.S. of the input signal     ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"rises above the 'On Threshold' recording begins, if it       ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"subsequently drops below the 'Off Threshold' recording stops.", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"In order for a buffer to be kept and the buffer counter to   ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"increment it must pass the requirements for 'Minimum Allowed ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"Time' and 'Minimum Allowed Amp. Peak'. This is done in order ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"to weed out excessively short or excessively quiet chunks.   ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"'Retrigger Delay' defines a minimum time after a recording   ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"has completed before a new recording can begin. Increasing   ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"this can also help prevent the recording of accidental       ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"chunks.                                                      ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"'Delay Audio' is a time delay applied to the audio written   ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"into the buffer. Increasing this can help prevent the loss of", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"attack portions in recorded chunks - this might be           ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"particularly useful if the source sound has a slow attack    ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"such as a clarinet.                                          ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"'Note Range' defines the range of notes that will trigger    ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"samples. If 'Min.' is set to 21 then MIDI note 21 will       ", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"trigger buffer number 1.                                     ", 	1,      5,     14,    490,    15,     5, 560
ih		 	FLbox  	"A number box informs the user which buffer will be written   ", 	1,      5,     14,    490,    15,     5, 580
ih		 	FLbox  	"to next.                                                     ", 	1,      5,     14,    490,    15,     5, 600
ih		 	FLbox  	"'Reset Buffers' will erase all buffers and reset the buffer  ", 	1,      5,     14,    490,    15,     5, 620
ih		 	FLbox  	"recording to the first buffer in the list.                   ", 	1,      5,     14,    490,    15,     5, 640

				FLpanel_end
		FLrun		; RUN THE WIDGET THREAD!

;CREATE EMPTY BUFFERS
giNumBufs	=	127		;NUMBER OF AVAILABLE BUFFERS (THE BUFFER COUNTER WILL LOOP WHEN ALL BUFFERS HAVE BEEN FILLED)
giBufSize	=	524288		;SIZE OF EACH INDIVIDUAL BUFFER
iCount		=  	1		;A COUNTER USED IN THE LOOPING PROCESS TO CREATE MANY EMPTY BUFFERS
LOOP:					;A LABEL - LOOP RETURNS TO THIS POINT
gibuff	ftgen iCount, 0, giBufSize, -7, 0	;CREATE AN EMPTY BUFFER FOR AUDIO
iCount	=  iCount + 1			;INCREMENT THE COUNTER
	if (iCount < 89) igoto LOOP	;IF NOT ALL BUFFERS HAVE BEEN CREATED YET RETURN TO THE BEGINNING POF THE LOOP

giDurations	ftgen		0,0,4096,-2,0	;TABLE CONTAINING RECORDING DURATIONS
giBufNum	init	1	;BUFFER NUMBER

instr	1	;MIDI PLAYBACK INSTRUMENT
	inum	notnum						;MIDI NOTE NUMBER
	ioffset	init	i(gkMinKey)				;FIRST NOTE THAT WILL TRIGGER A SAMPLE
	iTabNum	init	1+inum-ioffset				;DERIVE THE REQUIRED FUNCTION TABLE NUMBER FOR AUDIO DATA
	iDur	table	inum-ioffset+1,giDurations		;DERIVE THE DURATION OF THE BUFFER THAT WILL BE PLAYED FROM THE VALUE PREVIOUSLY WRITTEN INTO DURATIONS TABLE 
	iamp	ampmidi	1					;READ MIDI KEY VELOCITY
	ktime	timeinsts					;TIMER OF HOW LONG THIS NOTE HAS BEEN PLAYING
	iRel	init	0.05					;RELEASE TIME
	if	ktime>=iDur-iRel then				;IF END OF FILE IS REACHED BEFORE THE KEY IS RELEASED...
	  turnoff						;TURN OFF
	endif							;END OF THIS CONDITIONAL BRANCH
	andx	line	0,1,sr					;INFINITELY RISING LINE USED AS FILE POINTER
	;OUT 	OPCODE 		INDEX | FUNCTION_TABLE
	asig	tablei		andx,   iTabNum			;READ AUDIO FROM AUDIO STORAGE FUNCTION TABLE
	aenv	linsegr	0,0.01,1,iRel,0				;ANTI-CLICK AMPLITUDE ENVELOPE WITH RELEASE STAGE 
		out	asig*aenv*iamp				;SEND AUDIO TO OUTPUT
endin

instr	2	;RECORD BUFFERS
	if	gkRecReady=0	then				;IF FLTK 'Rec. Ready' BUTTON IS IN THE OFF POSITION...
		turnoff						;...TURN OFF THIS INSTRUMENT IMMEDIATELY
	endif							;END OF CONDITIONAL BRANCH
	
	ain 		inch		1			;READ CHANNEL 1 (LEFT CHANNEL IF STEREO)
	aDelSig		delay	ain,i(gkDelayAudio)		;CREATE DELAYED VERSION OF AUDIO SIGNAL
	krms 		rms 		ain			;CREATE A AMPLITUDE FOLLOWING UNIPOLAR SIGNAL

	iBufNum		limit	giBufNum,1,giNumBufs		;BUFFER NUMBER FOR THIS INSTRUMENT
	itablen		=	ftlen(iBufNum)			;INTERROGATE FUNCTION TABLE USED FOR AUDIO RECORDING TO DETERMINE ITS LENGTH - THIS WILL BE USED TO CONTROL THE MOVEMENT OF THE WRITE POINTER
	kStartRec	trigger krms, gkOnThresh,0		;GENERATE A TRIGGER IMPULSE WHEN RECORDING BEGINS
	kStopRec	trigger krms, gkOffThresh,1		;GENERATE A TRIGGER IMPULSE WHEN RECORDING STOPS
			FLsetVal	kStartRec,1,gihRec	;...TURN ON 'RECORDING' RED LIGHT...
			FLsetVal	kStopRec,0,gihRec	;...TURN OFF 'RECORDING' RED LIGHT...
	
	if	krms>gkOnThresh	then				;IF RMS RISES ABOVE 'ON THRESHOLD'...
		aRecNdx	line	0,1,sr				;RISING VALUE THAT WILL BE USED AS TYHE WRITE POINTER
		kRecDur	line	0,1,1				;CREATE A GLOBAL K-RATE VERSION OF THE WRITE POINTER
		aenv	linseg	0,0.01,1			;REMOVE POSSIBLE CLISK AT BEGINNING OF WRITTEN TABLE
		aDelSig	=	aDelSig*aenv	
			tablew	aDelSig,aRecNdx,iBufNum	;WRITE AUDIO TO AUDIO STORAGE TABLE
		apeak	init	0				;INITIAL VALUE FOR PEAK AMPLITUDE
			maxabsaccum apeak, aDelSig			;COMPARE PREVIOUS PEAK AMPLITUDE WITH CURRENT AMPLITUDE
		kpeak	downsamp	apeak			;CREATE A KRATE VERSION OF PEAK AMPLITUDE
	elseif	kStopRec=1 then					;IF RMS DROPS BELOW THE 'OFF THRESHOLD'...
			tablew	kRecDur,iBufNum,giDurations	;WRITE BUFFER DURATION TO THE DURATIONS TABLE. REMEMBER BUFFER NUMBER HAS ALREADY BEEN INCREMENTED, THEREFORE THE NEED TO COMPENSATE
		event	"i",4,0,i(gkRetrigDel),iBufNum,kpeak	;TRIGGER INSTRUMENT TO CHECK BUFFER
		event	"i",p1,0.1,-1				;RETRIGGER ITSELF AFTER A SMALL DELAY
		turnoff						;TURNOFF THIS INSTRUMENT IMMEDIATELY
	endif							;END OF CONDITIONAL BRANCHING
endin

instr	3	;ERASE BUFFERS AND RESET COUNTER TO BEGINNING OF LIST
	;CLEAR BUFFERS
	iCount		=  	1				;A COUNTER USED IN THE LOOPING PROCESS TO CREATE MANY EMPTY BUFFERS
	LOOP:							;A LABEL - LOOP RETURNS TO THIS POINT
	gibuff	ftgen iCount, 0, giBufSize, -7, 0			;CREATE AN EMPTY BUFFER FOR AUDIO
	iCount	=  iCount + 1					;INCREMENT THE COUNTER
		if (iCount < 89) igoto LOOP			;IF NOT ALL BUFFERS HAVE BEEN CREATED YET RETURN TO THE BEGINNING POF THE LOOP
	giBufNum	=		1			;RESET BUFFER NUMBER TO BEGINNING OF LIST
			FLsetVal_i	giBufNum,gihBufNum	;UPDATE DISPLAY OF BUFFER NUMBER	
endin

instr	4	;CHECK RECORDER BUFFER CHARACTERISTICS (AMPLITUDE AND DURATION) - DELETE IF IT DOESN'T MEET REQUIREMENTS
	iBufNum	=	p4	;BUFFER NUMBER OF THE BUFFER TO BE CHECKED. SENT FROM INSTR 3 AS p4
	iPeak	=	p5	;AMPLITUDE PEAK VALUE FROM THE BUFFER TO BE CHECKED. SENT FROM INSTR 3 AS p5
	iDur	table	iBufNum,giDurations	;READ DURATION OF THIS BUFFER FROM THE DURATIONS TABLE
	if iPeak>i(gkMinPeak)&&iDur>i(gkMinTim) then				;IF RECORDED BUFFER MEETs THE STIPULATED REQUIREMENTS...
	  giBufNum	=	giBufNum+1					;BUFFER TO RECORD TO IS INCREMENTED, READY FOR THE NEXT BUFFER RECORD AFTER THIS ONE
	  giBufNum	wrap	giBufNum,1,abs(i(gkMaxKey)-i(gkMinKey)+1)	;WRAP TO PREVENT OUT OF RANGE VALUES
			FLsetVal_i	giBufNum,gihBufNum			;UPDATE DISPLAY OF BUFFER NUMBER	
	endif								;END OF CONDITIONAL BRANCH
endin

instr	5	;MANUALLY ADJUST COUNTER
	giBufNum	=	i(gkManBuf)					;SET BUFFER COUNTER TO VALUE OF FL COUNTER
	giBufNum	limit	giBufNum,1,abs(i(gkMaxKey)-i(gkMinKey)+1)	;LIMIT TO PREVENT OUT OF RANGE VALUES
	FLsetVal_i	giBufNum,gihBufNum					;UPDATE DISPLAY OF BUFFER NUMBER	
endin

instr	6	;RMS METER
	if gkMeter=0 then
	  FLsetVal	1, 0, gihmeter				;SET METER TO ZERO
	  turnoff
	endif
	ain 		inch		1			;READ CHANNEL 1 (LEFT CHANNEL IF STEREO)
	krms 		rms 		ain			;CREATE A AMPLITUDE FOLLOWING UNIPOLAR SIGNAL
	kmetertrig	metro		20			;METRONOMIC TRIGGER (USED TO CONTROL THE RATE OF METER UPDATES) - 10 PER SECOND
	FLsetVal	kmetertrig, krms, gihmeter		;UPDATE METER
endin

</CsInstruments>

<CsScore>
f 0 3600	;READ REALTIME AUDIO IN AND SCAN DYNAMICS
</CsScore>

</CsoundSynthesizer>