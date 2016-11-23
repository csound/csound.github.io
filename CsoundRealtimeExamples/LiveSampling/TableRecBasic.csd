TableRecBasic.csd
Written by Iain McCurdy 2006. Updated 2011.

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr 	= 	44100	
ksmps 	= 	1
nchnls 	= 	1
0dbfs	=	1
maxalloc	1,1	;ENSURES THAT ONLY ONE INSTANCE OF INSTRUMENT 1 IS PERMITTED AT A TIME

		FLpanel	"Simple Record->Playback", 220, 140, 0, 0

;SWITCHES                                      					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
FLcolor	250,250,250,255,0,0	;RED
gkRecord,gihRecord	FLbutton	"@circle",				1,    0,     2,     50,     30,    10, 10,    0,      1,      0,      -1
FLcolor	250,250,250,0,0,255	;BLUE
gkPause,gihPause	FLbutton	"@||",					1,    0,     2,     50,     30,    60, 10,   -1
FLcolor	250,250,250,0,255,0	;GREEN
gkPlay,gihPlay		FLbutton	"@>",					1,    0,     2,     50,     30,   110, 10,    0,      1,      0,      -1
gkPlayStop,gihPlayStop	FLbutton	"@>|",					1,    0,     2,     50,     30,   160, 10,    0,      1,      0,      -1

;VALUE DISPLAY BOX			WIDTH | HEIGHT | X |  Y
idSpeed			FLvalue	" ",    60,       16,   10,  70
;SLIDER			            			MIN  | MAX | EXP | TYPE |   DISP  | WIDTH | HEIGHT | X | Y
gkSpeed, ihSpeed	FLslider 	"Speed",	0.1,    2,   -1,    3,    idSpeed,   200,    20,     10, 50
gkLoopBeg, ihLoopBeg	FLslider 	" ",		0,      1,    0,    3,         -1,   200,    15,     10, 90
gkLoopEnd, ihLoopEnd	FLslider 	"Loop Points",	0,      1,    0,    3,         -1,   200,    15,     10,105
FLsetVal_i	1, 	ihSpeed
FLsetVal_i	0, 	ihLoopBeg
FLsetVal_i	1, 	ihLoopEnd

		FLpanel_end	; END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 420, 232, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"         Record Audio to Function Table With Playback        ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"This example records live audio to a function table which the", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"user can then play back.                                     ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"A pause button pauses both record and playback.              ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"If record is pressed for a second time the original recording", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"is overwritten.                                              ", 	1,      5,     14,    490,    15,     5, 120
ih	  	 	FLbox  	"Maximum record time is determined by function table size and ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"sampling rate. In this example table size is 1048576 and     ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"sampling rate is 44100Hz therefore maximum record time is    ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"1048576/44100 = 24 seconds (approx.)                         ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"If maximum record time is reached, recording will cease and  ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"the record button is deactivated.                            ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"Playback can be either 'one shot' (triangle + line button) or", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"looped (triangle button).                                    ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"The recorded data is monophonic and live input is read from  ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"the first (left) input channel but this could easily be      ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"modified to record in stereo (or more).                      ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"Included are controls for playback speed and for playback    ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"start and end points. If the start and end points are        ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"inverted playback will be reversed.                          ", 	1,      5,     14,    490,    15,     5, 400

				FLpanel_end

		FLrun		; RUN THE WIDGET THREAD!

giRecDur	init	0			;DURATION OF THE LAST MADE RECORDING
gistorage	ftgen	0,0,1048576,-7,0	;AUDIO DATA STORAGE SPACE (ABOUT 23 SECONDS)

instr	1	;RECORD
	itablelen	=	ftlen(gistorage)		;DERIVE TABLE LENGTH

	if	gkPause=1	goto SKIP			;IF PAUSE BUTTON IS ACTIVATED SKIP ALL RECORDING AND PLAYBACK...

	  if	gkRecord=1	then				;IF RECORD BUTTON IS ACTIVE...
	    ain		inch		1			;READ AUDIO FROM LIVE INPUT CHANNEL 1
	    aRecNdx	line		0,itablelen/sr,1	;CREATE A POINTER FOR WRITING TO TABLE - FREQUENCY OF POINTER IS DEPENDENT UPON TABLE LENGTH AND SAMPLE RATE
	    aRecNdx	=		aRecNdx*itablelen	;RESCALE POINTER ACCORDING TO LENGTH OF FUNCTION TABLE 
	    gkRecDur	downsamp	aRecNdx			;CREATE A K-RATE GLOBAL VARIABLE THAT WILL BE USED BY THE 'PLAYBACK' INSTRUMENT TO DETERMINE THE LENGTH OF RECORDED DATA			
	  		;OPCODE 	INPUT|INDEX| FUNCTION_TABLE
	  		tablew		ain,  aRecNdx, gistorage;WRITE AUDIO TO AUDIO STORAGE TABLE
	    if	gkRecDur>=itablelen	then			;IF MAXIMUM RECORD TIME IS REACHED...
		FLsetVal	1, 0, gihRecord			;...DEACTIVATE RECORD BUTTON &
		turnoff						;TURN OFF THIS INSTRUMENT IMMEDIATELY.
	    endif						;END OF CONDITIONAL BRANCH


	  elseif	gkPlay=1	then			;IF PLAY LOOPED BUTTON IS ACTIVE THEN...	
	    kporttime	linseg	0,0.001,0.05			;PORTAMENTO TIME RAMPS UP RAPIDLY TO A HELD VALUE
	    kLoopBeg	portk	gkLoopBeg, kporttime		;APPLY PORTAMENTO SMOOTHING TO CHANGES OF LOOP BEGIN SLIDER
	    kLoopEnd	portk	gkLoopEnd, kporttime		;APPLY PORTAMENTO SMOOTHING TO CHANGES OF LOOP END SLIDER
	    kLoopBeg	=	kLoopBeg * gkRecDur		;RESCALE gkLoopBeg (RANGE 0-1) TO BE WITHIN THE RANGE 0-FILE_LENGTH. NEW OUTPUT VARIABLE kLoopBeg.
	    kLoopEnd	=	kLoopEnd * gkRecDur		;RESCALE gkLoopEnd (RANGE 0-1) TO BE WITHIN THE RANGE 0-FILE_LENGTH. NEW OUTPUT VARIABLE kLoopEnd.
	    kLoopLen	=	kLoopEnd - kLoopBeg		;DERIVE LOOP LENGTH FROM LOOP START AND END POINTS
	    ;             OPCODE	NUMERATOR | DENOMINATOR | SUBSTUTION_VALUE_(IF_DENOMINATOR=0)
	    kPlayPhasFrq	divz	gkSpeed,   (kLoopLen/sr),        0.00001	;SAFELY DIVIDE, PROVIDING ALTERNATIVE VALUE INCASE DENOMINATOR IS ZERO 
	    aPlayNdx		phasor	kPlayPhasFrq				;DEFINE PHASOR POINTER FOR TABLE INDEX
	    kLoopBeg	=	(kLoopBeg < kLoopEnd ? kLoopBeg : kLoopEnd)	;CHECK IF LOOP-BEGINNING AND LOOP-END SLIDERS HAVE BEEN REVERSED
	    aPlayNdx	=	(aPlayNdx*abs(kLoopLen)) + kLoopBeg		;RESCALE INDEX POINTER ACCORDING TO LOOP LENGTH AND LOOP BEGINING
	    ;OUT 		OPCODE 	INDEX     | FUNCTION_TABLE
	    asig		tablei	aPlayNdx,    gistorage		;READ AUDIO FROM AUDIO STORAGE FUNCTION TABLE
	    		out	asig				;SEND AUDIO TO OUTPUTS

	  elseif	gkPlayStop=1	then			;IF PLAY THEN STOP BUTTON IS ACTIVE THEN...
	    kLoopBeg	=	gkLoopBeg * gkRecDur		;RESCALE gkLoopBeg (RANGE 0-1) TO BE WITHIN THE RANGE 0-FILE_LENGTH. NEW OUTPUT VARIABLE kLoopBeg.
	    kLoopEnd	=	gkLoopEnd * gkRecDur		;RESCALE gkLoopEnd (RANGE 0-1) TO BE WITHIN THE RANGE 0-FILE_LENGTH. NEW OUTPUT VARIABLE kLoopEnd.
	    if	kLoopEnd>kLoopBeg	then			;IF LOOP END SLIDER IS AT A LATER POSITION TO LOOP BEGIN SLIDER...
	      aPlayStopNdx	line	0,1,1			;CREATE A MOVING POINTER
	      aPlayStopNdx	=	(aPlayStopNdx*gkSpeed*sr)+kLoopBeg	;RESCALE MOVING POINTER VALUE ACCORDING TO LOOP BEGIN POSITION AND SPEED SLIDER SETTING
	      kPlayStopNdx	downsamp	aPlayStopNdx	;CREATE kndx, A K-RATE VERSION OF andx. THIS WILL BE USED TO CHECK IF PLAYBACK OF THE DESIRED CHUNK OF AUDIO HAS COMPLETED.
		if	kPlayStopNdx>kLoopEnd	then		;IF END OF DESIRED CHUNK OF AUDIO PLAYBACK IS REACHED...
		  FLsetVal	1, 0, gihPlayStop		;...DEACTIVATE PLAY-STOP BUTTON &
		  turnoff					;TURN OFF THIS INSTRUMENT IMMEDIATELY.
		endif						;END OF CONDITIONAL BRANCH
	    else						;OTHERWISE (I.E. LOOP BEGIN SLIDER IS AT A LATER POSITION THAT LOOP END)
	      aPlayStopNdx	line	0,1,-1			;CREATE A NEGATIVE MOVING POINTER
	      aPlayStopNdx	=	(aPlayStopNdx*gkSpeed*sr)+kLoopBeg;RESCALE MOVING POINTER VALUE ACCORDING TO LOOP BEGIN POSITION AND SPEED SLIDER SETTING
	      kPlayStopNdx	downsamp	aPlayStopNdx	;CREATE kndx, A K-RATE VERSION OF andx
		if	kPlayStopNdx<kLoopEnd	then		;IF END OF DESIRED CHUNK OF AUDIO PLAYBACK IS REACHED...
		  FLsetVal	1,0,gihPlayStop			;...DEACTIVATE PLAY BUTTON &
		  turnoff					;TURN OFF THIS INSTRUMENT IMMEDIATELY.
		endif						;END OF CONDITIONAL BRANCH
	      endif						;END OF CONDITIONAL BRANCH
	    ;OUT 	OPCODE 		INDEX        | FUNCTION_TABLE
	    asig	tablei		aPlayStopNdx,     gistorage	;READ AUDIO FROM AUDIO STORAGE FUNCTION TABLE
	  	out		asig				;SEND AUDIO TO OUTPUT

	  else							;OTHERWISE (ALL BUTTONS ARE DE-ACTIVATED)...
	  	turnoff						;TURN OFF THIS INSTRUMENT
	  endif							;END OF CONDITIONAL BRANCH

	SKIP:							;LABEL CALLED 'SKIP'. JUMPS STRAIGHT TO HERE IF PAUSE BUTTON IS ACTIVE.
endin
		
</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT - KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>