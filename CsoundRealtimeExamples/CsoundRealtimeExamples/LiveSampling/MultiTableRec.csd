MultiTableRec.csd
Written by Iain McCurdy 2006. Update 2011.

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr 	= 	44100	
ksmps 	= 	8
nchnls 	= 	1
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 155, 0, 0, 0	;SET INTERFACE COLOURS
		FLpanel	"Simple Record->Playback Looped", 330,300, 0, 0

iy	=	10

#define RECORD_PLAY_FLTK(COUNT'INSTR_NUM)
#
;SWITCHES                                 					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE |    INS    | STARTTIM | IDUR
FLcolor	200,200, 200,255,0,0	;RED
gkRecord$COUNT, gihRecord$COUNT	FLbutton	"@circle",			1,    0,     2,     50,     30,    10, iy,    0,    $INSTR_NUM,      0,      -1
FLsetTextColor 255, 0, 0, gihRecord$COUNT	;RED TEXT                                                                                            

FLcolor	200, 200, 200,0,255,0	;GREEN                                                                                                               
gkPlay$COUNT, gihPlay$COUNT	FLbutton	"@>",				1,    0,     2,     50,     30,    60, iy,    0,    $INSTR_NUM,      0,      -1
FLsetTextColor 0, 200, 0, gihPlay$COUNT	;GREEN TEXT

FLcolor	255, 255, 255, 0, 0, 100	;SET INTERFACE COLOURS

;VALUE DISPLAY BOX				WIDTH | HEIGHT | X |  Y
idSpeed$COUNT		FLvalue	" ",     	60,       16,   120, iy+20
;SLIDER			            				MIN  | MAX | EXP | TYPE |    DISP       | WIDTH | HEIGHT | X | Y
gkSpeed$COUNT, ihSpeed$COUNT	FLslider 	"Speed",	-2,     2,    0,    3,   idSpeed$COUNT,    200,    20,    120, iy

FLsetVal_i	1, 	ihSpeed$COUNT
iy	=	iy+50
#                                                                                                 

$RECORD_PLAY_FLTK(1'1)
$RECORD_PLAY_FLTK(2'2)
$RECORD_PLAY_FLTK(3'3)
$RECORD_PLAY_FLTK(4'4)
$RECORD_PLAY_FLTK(5'5)
$RECORD_PLAY_FLTK(6'6)

		FLpanel_end	; END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 300, 342, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"              Recording To Multiple Tables                   ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"This example layers 6 record/playback devices which record   ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"and playback  from 6 independent function tables. Playback   ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"and recording are looped. A playback speed control for each  ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"player is added. The code makes use of macros to minimize    ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"code repetition and facilitate easy expansion.               ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"If both record and play are active simultaneously for a      ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"particular voice, record takes precedence and playback is    ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"suspended. Playback will resume (using the newly recorded    ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"audio) once record is deactivated.                           ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"Each layer will record about 23 seconds of audio before      ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"recording loops and starts overwriting. This limit can be    ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"extended by increasing the sizes of the function tables used ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"for audio storage.                                           ", 	1,      5,     14,    490,    15,     5, 280

				FLpanel_end

		FLrun		; RUN THE WIDGET THREAD!

;INITIALIZE STORAGE BUFFERS
giRecBuf1	ftgen	0, 0, 1048576, -7, 0	;AUDIO DATA STORAGE
giRecBuf2	ftgen	0, 0, 1048576, -7, 0	;AUDIO DATA STORAGE
giRecBuf3	ftgen	0, 0, 1048576, -7, 0	;AUDIO DATA STORAGE
giRecBuf4	ftgen	0, 0, 1048576, -7, 0	;AUDIO DATA STORAGE
giRecBuf5	ftgen	0, 0, 1048576, -7, 0	;AUDIO DATA STORAGE
giRecBuf6	ftgen	0, 0, 1048576, -7, 0	;AUDIO DATA STORAGE

girecdur1	init	0                                                                 
girecdur2	init	0
girecdur3	init	0
girecdur4	init	0
girecdur5	init	0
girecdur6	init	0

#define	RECORD_PLAY_INSTR(COUNT'INSTR_NUM)
#
instr	$INSTR_NUM	;RECORD_PLAY INSTRUMENT
	iRecBuf		init		giRecBuf1+$COUNT-1	;STORAGE BUFFER FOR THIS INSTRUMENT


	if gkRecord$COUNT=1 then				; IF RECORDING...
	  itablelen	=		ftlen(iRecBuf)		;DERIVE TABLE LENGTH
	  ain		inch		1			;READ AUDIO FROM LIVE INPUT CHANNEL 1
	  aRecNdx	phasor		sr/itablelen		;CREATE A POINTER FOR WRITING TO TABLE - FREQUENCY OF POINTER IS DEPENDENT UPON TABLE LENGTH AND SAMPLE RATE
	  aRecNdx	=		aRecNdx*itablelen		;RESCALE POINTER ACCORDING TO LENGTH OF FUNCTION TABLE 
	  gkrecdur$COUNT	downsamp	aRecNdx		;CREATE A K-RATE GLOBAL VARIABLE THAT WILL BE USED BY THE 'PLAYBACK' INSTRUMENT TO DETERMINE THE LENGTH OF RECORDED DATA			
	  ;OPCODE	INPUT | INDEX | FUNCTION_TABLE
	  tablew	ain,   aRecNdx,    iRecBuf		;WRITE AUDIO TO THE APPROPRIATE AUDIO STORAGE TABLE

	  
	elseif gkPlay$COUNT=1 then				; IF PLAYING BACK...
	  aPlayNdx	phasor		(sr*gkSpeed$COUNT)/i(gkrecdur$COUNT)	;CREATE A POINTER FOR WRITING TO TABLE - FREQUENCY OF POINTER IS DEPENDENT UPON TABLE LENGTH AND SAMPLE RATE
	  aPlayNdx	=		aPlayNdx*i(gkrecdur$COUNT)		;RESCALE POINTER ACCORDING TO LENGTH OF PREVIOUS AUDIO RECORDING 
	  ;OUT 	OPCODE 	INDEX    | FUNCTION_TABLE
	  asig	tablei	aPlayNdx,      iRecBuf			;READ AUDIO FROM THE APPROPRIATE AUDIO STORAGE FUNCTION TABLE
	  	out	asig					;SEND AUDIO TO OUTPUTS

	  	
	else							; OTHERWISE...
	  turnoff						;TURN OFF THIS INSTRUMENT
	endif							;END OF CONDITIONAL BRANCH
endin
#

;MACRO USED TO CREATE A RECORD-PLAY INSTRUMENT IS EXPANDED (6 TIMES)
;THIS MACRO TAKES TWO ARGUMENTS: THE FIRST A COUNTER FOR THAT INSTRUMENT - THIS SHOULD FOLLOW THE SEQUENCE 1,2,3,4...
;                                THE SECOND IS THE INSTRUMENT NUMBER (THESE SHOULD CORRESOND TO THE INSTRUMENT NUMBERS DEFINED IN THE FLTK GUI
$RECORD_PLAY_INSTR(1'1)
$RECORD_PLAY_INSTR(2'2)
$RECORD_PLAY_INSTR(3'3)
$RECORD_PLAY_INSTR(4'4)
$RECORD_PLAY_INSTR(5'5)
$RECORD_PLAY_INSTR(6'6)

</CsInstruments>

<CsScore>
f 0 3600
</CsScore>

</CsoundSynthesizer>