isorhythm.csd
Written by Iain McCurdy 2011

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>
sr	=	44100
ksmps	=	1	;ksmps SHOULD BE 1 TO RETAIN TIMING
nchnls	=	2
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255,255,255,255,255,50
;		LABEL        | WIDTH | HEIGHT | X | Y
	FLpanel	"isorhythms",   500,     150,   0,  0

;SWITCHES                                				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff			FLbutton	"On/Off",		1,    0,    22,    140,     25,   10,  5,    0,      1,      0,      -1
gkMetroOnOff,ihMetroOnOff	FLbutton	"Metronome",		1,    0,    22,    140,     25,  180,  5,   -1
gkNoOLap,ihNoOLap		FLbutton	"No Overlaps",		1,    0,    22,    140,     25,   10,100,   -1

;COUNTERS					     	MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gktempo, ihtempo	FLcount  	"Tempo",	1,   800,   0.01,     1,     1,     140,     25,   350, 5,   -1 
gkNoteFn, ihNoteFn	FLcount  	"Note Row",	1,     5,      1,     1,     2,     140,     25,    10,50,    0, 1, 0, -1	;TRIGGER INSTRUMENT TO RESET INDICES TO ZERO.
gkRhyFn, ihRhyFn	FLcount  	"Rhythm",	1,    13,      1,     1,     2,     140,     25,   180,50,    0, 1, 0, -1	;TRIGGER INSTRUMENT TO RESET INDICES TO ZERO.
gkDurFn, ihDurFn	FLcount  	"Duration Row",	1,    13,      1,     1,     2,     140,     25,   350,50,    0, 1, 0, -1	;TRIGGER INSTRUMENT TO RESET INDICES TO ZERO.

;VALUE_DISPLAY_BOXES			 WIDTH | HEIGHT | X | Y
idgain			FLvalue	" ",     70,       20,   180, 175

;SLIDERS					MIN | MAX | EXP | TYPE | DISP  | WIDTH | HEIGHT | X | Y
gkgain,ihgain		FLslider 	"Gain",	0,     1,    0,    23,  idgain,   315,     25,   180, 100

; INITIAL VALUES OF SLIDERS
;OPCODE		VALUE | HANDLE
FLsetVal_i   	120, 	ihtempo
FLsetVal_i   	4, 	ihNoteFn
FLsetVal_i   	11, 	ihRhyFn
FLsetVal_i   	11, 	ihDurFn
FLsetVal_i   	0.2, 	ihgain
FLsetVal_i   	1, 	ihMetroOnOff

	FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 560, 512, 0
                                                                  
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                         Isorhythm                           ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"'Isorhythm' is a technique whereby a series of durations     ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"forming a rhythm is applied to a row of notes. Normally the  ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"number of durations forming the rhythm would be much less    ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"than he number of notes in the note row so the rhythm would  ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"be repeated in cyclical fashion. This is a technique which   ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"dates back to at least the 13th century but it is one which  ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"is still revisited by contemporary composers.                ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"The rhythmic code used is referred to as the 'talea'. In this", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"example a variety of taleae can be applied to any of four    ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"note rows. The note rows are taken from four well known      ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"national anthems. The first four taleae correspond to the    ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"original rhythms of the four note rows so if you wish to     ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"replay a tune with its original rhythm set 'Note Row',       ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"'Rhythm' and 'Duration Row' to the same number.              ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"Normally rhythm and the durations of the elements within that", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"rhythm would be bound together but in this example the user  ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"can freely choose a different rhythm talea with a different  ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"talea of durations. This can lead to overlapping notes - this", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"can be prevented by activating 'No Overlaps'.                ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"Rhythmic and durational taleae beyond number 4 are shorter   ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"and are therefore more representative of traditional taleae. ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"It is recommended to examine the function tables that store  ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"the various note rows and taleae to understand this technique", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"better. Notes are represented as MIDI note numbers and       ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"rhythms (and durations) as fractions of a crotchet (quarter  ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"note). 1 = crotchet, 1/3 triplet-quaver, 2 = minim and so on.", 	1,      5,     14,    490,    15,     5, 540
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;NOTE, RHYTHM AND DURATION ROWS STORED AS GEN 2 FUNCTION TABLES.
;END OF EACH ROW IS INDICATED BY A -1. TABLES SIZES CAN THEREFORE EXCEED THE NUMBER OF ELEMENTS THEY CONTAIN. TABLE SIZES SHOULD NOT BE SMALLER THAN THE NUMBER OF ELEMENTS THEY CONTAIN.
;NON-POWER OF 2 FUNCTION TABLES ARE ALLOWED IF PRESEDED BY A MINUS SIGN
ginotes1	ftgen	0,0,256,-2,	63,63,63,68,68,70,70,75,72,68,68,72,68,65,73,70,67,68,    68,70,72,72,72,73,72,72,70,   70,72,73,73,73,75,73,72,  75,75,75,72,68,75,72,68,63,  \
					63,63,67,70,73,70,67,70,68,  66,65, 68,68,68,67,68,70,  70,71,71,71,71,73,75,70,  71,70,68,68,68,71,70,68,68,67,  \
					75,75,75,72,68,70,  75,75,75,72,68,70,  \
					63,68,70,72,  73,75,77,70,   77,75,72,73,70,68,   63,63,63,63,63,63,63,  75,75,75,72,68,70,  75,75,75,72,68,70,  63,68,70,72,73,75,77,70,   \
					77,75,72,73,70,68, 68,68,68, -1
ginotes2	ftgen	0,0,128,-2,	63,65,67,65,68,67,65,62,63,  72,70,68,67,65,67,63,70,  63,65,67,65,68,67,65,62,63,   72,70,68,67,65,67,63,70, \
					65,67,65,62,58,68,67,65,62,58, 70,68,67,67,69,69,70,70, \
					75,74,74,72,70,72,70,70,68,67,65,67,68,70,72,68,65,63,67,65,63,  75,74,74,72,70,72,70,70,68,67,65,67,68,70,72,68,65,63,67,65,63,  -1
ginotes3	ftgen	0,0,128,-2,	70,70,72,69,70,72,74,74,75,74,72,70,72,70,69,70,70,72,74,75,77,77,77,77,75,74,75,75,75,75,74,72,74,75,74,72,70,74,75,77,79,75,74,72,70,-1
ginotes4	ftgen	0,0,128,-2,	65,62,58,62,65,70, 74,72,70,62,64,65, 65,65,74,72,70,69,67,69,70,70,65,62,58,  65,62,58,62,65,70, 74,72,70,62,64,65, 65,65,74,72,70,69,67,69,70,70,65,62,58, \
					74,74,75,77,77,75,74,72,74,75,75,  75,74,72,70,69,  67,69,70,62,64,65,  65,70,70,70,69,67,67,  67,72,75,74,72,70,70,69,  65,65,70,72,74,75,77, 70,72,74,75,72,70, -1
ginotes5	ftgen	0,0,-9,-2,	60,62,65,67,69,67,65,62, -1	

giRhy1	ftgen	0,0,256,-2,	1/3,2/3,1/3,1,1,1,1,1.5,0.5,2/3,1/3,2/3,1/3,1,2,2/3,1/3,3,   2/3,1/3,1,1,1,2/3,1/3,1,2,   2/3,1/3,1,1,1,2/3,1/3,3, 2/3,1/3,1,2/3,1/3,1,2/3,1/3,8/3, \
				1/3,2/3,1/3,2,1,2/3,1/3,1,1,  2,1,   2/3,1/3,1,2/3,1/3,3,  1,1.5,0.5,0.5,0.5,0.5,0.5,3,  0.5,0.5,1.5,0.5,0.5,0.5,0.5,0.5,1,8/3, \
				1/3,2.5,0.5,2/3,1/3,11/3, 1/3,2.5,0.5,2/3,1/3,3, \
				1,3,1,4,2,1,1,3,1,2.5,0.5,2/3,1/3,0.5, 0.25,0.25,0.5,0.5,0.5,0.5,2/3, \
				1/3,2.5,0.5,2/3,1/3,11/3, 1/3,2.5,0.5,2/3,1/3,3, \
				1,3,1,4,2,1,1,3,1,2.5,0.5,2/3,1/3,1,0.75,0.25, 2/3,     -1
giRhy2	ftgen	0,0,128,-2,	1.5,0.5,1,1,1,1,0.5,0.5,1,    1,1,1,1,1,0.5,0.5,2, \
				1.5,0.5,1,1,1,1,0.5,0.5,1,    1,1,1,1,1,0.5,0.5,2, \
				1.5,0.5,0.5,0.5,1,1,1,0.5,0.5,1, 1,1,1,1,1,0.5,0.5,2,\
				1.5,0.5,0.5,0.5,1,  1.5,0.5,0.5,0.5,1, 1.5,0.25,0.25,0.5,0.5,0.5,0.5,1,0.5,0.5,2, \
				1.5,0.5,0.5,0.5,1,  1.5,0.5,0.5,0.5,1, 1.5,0.25,0.25,0.5,0.5,0.5,0.5,1,0.5,0.5,2, -1
giRhy3	ftgen	0,0,128,-2,	1,1,1,1.5,0.5,1, 1,1,1,1.5,0.5,1, 1,1,1,1, 0.5,0.5,0.5,0.5,\
				1,1,1,1.5,0.5,1, 1,1,1,1.5,0.5,1, 1,0.5,0.5,0.5,0.5,1.5,0.5,1, 0.5,0.5,1,1,2, -1
giRhy4	ftgen	0,0,128,-2,	0.75,0.25,1,1,1,2,  0.75,0.25,1,1,1,2,  0.5,0.5,1.5,0.5,1,2, 0.5,0.5,1,1,1,1,1,  0.75,0.25,1,1,1,2,  0.75,0.25,1,1,1,2,  0.5,0.5,1.5,0.5,1,2, 0.5,0.5,1,1,1,1,1, \	
				1,1,1,1,2, 0.5,0.5,1,1,1,2, 1,1.5,0.5,1,2, 0.5,0.5,1,1,1,2,  1,1,1,0.5,0.5,1,1, 1,1,0.5,0.5,0.5,0.5,1,1, 0.5,0.5,1.5,0.5,0.5,0.5,2, 0.5,0.5,1.5,0.5,1,2, -1
giRhy5	ftgen	0,0,4,-2,	1, 0.5, 0.5, -1
giRhy6	ftgen	0,0,-3,-2,	1, 0.5, -1
giRhy7	ftgen	0,0,-3,-2,	2/3, 1/3, -1
giRhy8	ftgen	0,0,16,-2,	1/2, 1/2, 1/3,1/3,1/3, 1/5,1/5,1/5,1/5,1/5, -1
giRhy9	ftgen	0,0,4,-2,	1/2, 1/2, -1
giRhy10	ftgen	0,0,8,-2,	0.5, 0.25, -1
giRhy11	ftgen	0,0,8,-2,	1/2, 1/2, 1/3, 1/3, 1/3, -1
giRhy12	ftgen	0,0,-9,-2,	1/4,1/4,1/4,1/4,1/2,1/2,1/2,1/2,-1
giRhy13	ftgen	0,0,-9,-2,	1/4,1/4,1/4,1/4,1/2,1/2,1/2,-1

giDur1	ftgen	0,0,256,-2,	1/3,2/3,1/3,1,1,1,1,1.5,0.5,2/3,1/3,2/3,1/3,1,2,2/3,1/3,3,   2/3,1/3,1,1,1,2/3,1/3,1,2,   2/3,1/3,1,1,1,2/3,1/3,3, 2/3,1/3,1,2/3,1/3,1,2/3,1/3,8/3, \
				1/3,2/3,1/3,2,1,2/3,1/3,1,1,  2,1,   2/3,1/3,1,2/3,1/3,3,  1,1.5,0.5,0.5,0.5,0.5,0.5,3,  0.5,0.5,1.5,0.5,0.5,0.5,0.5,0.5,1,8/3, \
				1/3,2.5,0.5,2/3,1/3,11/3, 1/3,2.5,0.5,2/3,1/3,3, \
				1,3,1,4,2,1,1,3,1,2.5,0.5,2/3,1/3,0.5, 0.25,0.25,0.5,0.5,0.5,0.5,2/3, \
				1/3,2.5,0.5,2/3,1/3,11/3, 1/3,2.5,0.5,2/3,1/3,3, \
				1,3,1,4,2,1,1,3,1,2.5,0.5,2/3,1/3,1,0.75,0.25, 2/3,     -1
giDur2	ftgen	0,0,128,-2,	1.5,0.5,1,1,1,1,0.5,0.5,1,    1,1,1,1,1,0.5,0.5,2, \
				1.5,0.5,1,1,1,1,0.5,0.5,1,    1,1,1,1,1,0.5,0.5,2, \
				1.5,0.5,0.5,0.5,1,1,1,0.5,0.5,1, 1,1,1,1,1,0.5,0.5,2,\
				1.5,0.5,0.5,0.5,1,  1.5,0.5,0.5,0.5,1, 1.5,0.25,0.25,0.5,0.5,0.5,0.5,1,0.5,0.5,2, \
				1.5,0.5,0.5,0.5,1,  1.5,0.5,0.5,0.5,1, 1.5,0.25,0.25,0.5,0.5,0.5,0.5,1,0.5,0.5,2, -1
giDur3	ftgen	0,0,128,-2,	1,1,1,1.5,0.5,1, 1,1,1,1.5,0.5,1, 1,1,1,1, 0.5,0.5,0.5,0.5,\
				1,1,1,1.5,0.5,1, 1,1,1,1.5,0.5,1, 1,0.5,0.5,0.5,0.5,1.5,0.5,1, 0.5,0.5,1,1,2, -1
giDur4	ftgen	0,0,128,-2,	0.75,0.25,1,1,1,2,  0.75,0.25,1,1,1,2,  0.5,0.5,1.5,0.5,1,2, 0.5,0.5,1,1,1,1,1,  0.75,0.25,1,1,1,2,  0.75,0.25,1,1,1,2,  0.5,0.5,1.5,0.5,1,2, 0.5,0.5,1,1,1,1,1, \	
				1,1,1,1,2, 0.5,0.5,1,1,1,2, 1,1.5,0.5,1,2, 0.5,0.5,1,1,1,2,  1,1,1,0.5,0.5,1,1, 1,1,0.5,0.5,0.5,0.5,1,1, 0.5,0.5,1.5,0.5,0.5,0.5,2, 0.5,0.5,1.5,0.5,1,2, -1
giDur5	ftgen	0,0,4,-2,	1, 0.5, 0.5, -1
giDur6	ftgen	0,0,-3,-2,	1, 0.5, -1
giDur7	ftgen	0,0,-3,-2,	2/3, 1/3, -1
giDur8	ftgen	0,0,16,-2,	1/2, 1/2, 1/3,1/3,1/3, 1/5,1/5,1/5,1/5,1/5, -1
giDur9	ftgen	0,0,4,-2,	1/2, 1/2, -1
giDur10	ftgen	0,0,8,-2,	0.5, 0.25, -1
giDur11	ftgen	0,0,8,-2,	1/2, 1/2, 1/3, 1/3, 1/3, -1
giDur12	ftgen	0,0,-9,-2,	1/4,1/4,1/4,1/4,1/2,1/2,1/2,1/2,-1
giDur13	ftgen	0,0,-9,-2,	1/4,1/4,1/4,1/4,1/2,1/2,1/2,-1

gisine	ftgen	0,0,4096,10,1			;SINE WAVEFORM (USED FOR METRONOME)
gicos	ftgen	0, 0, 16384, 11, 1		;COSINE WAVEFORM (USED BY gbuzz)

gasend	init	0	;GLOBAL sAUDIO VARIABLE USED TO SEND AUDIO TO REVERB INSTRUMENT

instr	1	;NOTE TRIGGERING INSTRUMENT
	;INDEXES (ALL INITIALIZED TO ZERO / START OF THE ROW)
	iRhyNdx		init	0
	giNoteNdx	init	0
	iDurNdx		init	0

	if gkOnOff==0 then					;IF ON/OFF SWITCH IS OFF
		turnoff2	p1,0,0				;TURN THIS INSTRUMENT OFF
	endif							;END OF CONDITIONAL BRANCH

	start:							;LABEL - EACH SUBSEQUENT NEW NOTE STARTS HERE AS DIRECTED BNY THE reinit STATEMENT FURTHER DOWN
	iRhy	table	iRhyNdx, giRhy1+i(gkRhyFn)-1		;READ RHYTHM VALUE FROM TABLE
	if iRhy==-1 then					;IF END OF ROW HAS BEEN REACHED...
	  iRhyNdx	=	0				;...RESET NOTE INDEX TO BEGINNING OF THE ROW...
	  		igoto	start				;...AND REDO THE NOTE READING OPERATION BY JUMPING IMMEDIATELY BACK TO THE LABEL 'start'
	endif							;END OF CONDITIONAL BRANCH
	iRhyNdx		=	iRhyNdx + 1			;INCREMENT THE RHYTHM INDEX
	iRhy		=	iRhy*(60/i(gktempo))		;RESCALE ACCORDING TO CURRENT TEMPO

	repeatDur:						;LABEL
	iDur		table	iDurNdx, giDur1+i(gkDurFn)-1	;READ RHYTHM VALUE FROM TABLE
	if iDur==-1 then					;IF END OF ROW HAS BEEN REACHED...
	  iDurNdx	=	0				;...RESET DURATION INDEX TO BEGINNING OF THE ROW...
	  		igoto	repeatDur			;...AND REDO THE DURATION READING OPERATION BY JUMPING IMMEDIATELY BACK TO THE LABEL 'repeatDur'
	endif							;END OF CONDITIONAL BRANCH
	iDurNdx		=	iDurNdx + 1			;INCREMENT THE RHYTHM INDEX
	iDur		=	iDur*(60/i(gktempo))		;RESCALE ACCORDING TO CURRENT TEMPO

	if iDur>iRhy&&i(gkNoOLap)==1&&iRhy!=0 then		;IF DURATION IS GREATER THAN RHYTHM VALUE AND FLTK GUI INSTRUCTS 'NO OVERLAPS'...
	  iDur 		=	iRhy				;RESTRICT DURATION TO THE CURRENT RHYTHM VALUE
	endif							;END OF CONDITIONAL BRANCH
	
			event_i	"i", 2, 0, iDur			;INSTRUCT SOUND PRODUCING INSTRUMENT TO PLAY A NOTE. p3 MAY BE MODULATED IN CALLED INSTRUMENT
	if iRhy=0 then						;IF RHYTHM IS ZERO THIS IS PART OF A CHORD SO CALL ANOTHER NOTE FROM THE ROW	
	  iDurNdx	=	iDurNdx - 1			;REGRESS DURATION COUNTER SO THAT ALL NOTES OF THE CHORD WILL HAVE THE SAME DURATION
	endif							;END OF CONDITIONAL BRANCH

			timout 0,iRhy,wait			;JUMP REINITIALIZATION INSTRUCTION FOR THE GIVEN TIME
	
	reinit	start						;REINITIALIZATION FROM LABEL 'start'

	wait:							;LABEL 'wait'
	rireturn						;RETURN FROM REINITIALIZATION PASS

	;METRONOME
	ktrig	metro	gktempo/60				;METRONONE TRIGGER
	if gkRhyFn==1 then					;RHYTHM ROW 1 HAS AN UP-BEAT
	  ktrig	vdel_k   ktrig, (1/3)*(60/gktempo), 20		;DELAY THE METRONOME TRIGGER BY THE DURATION OF THE UPBEAT - MAXIMUM DELAY IS WHAT THIS DURATION WOULD BE IF TEMPO WAS 1
	endif
	schedkwhen	ktrig*gkMetroOnOff,0,0,100,0,0.005	;CALL METRONOME INSTRUMENT TO PLAY A 'CLICK'
endin

instr	2	;SOUND PRODUCING INSTRUMENT
	if gkOnOff==0 then						;IF ON/OFF SWITCH IS OFF
		turnoff2	p1,0,0				;TURN THIS INSTRUMENT OFF
	endif								;END OF CONDITIONAL BRANCH
	
	repeat:								;LOOP BACK TO HERE IF THE END OF THE NOTE ROW HAS BEEN REACHED
	iNote	table	giNoteNdx, ginotes1+i(gkNoteFn)-1		;READ NOTE VALUE FROM TABLE
	if iNote=-1 then						;IF NOTE VALUE IS -1 THEN THE END OF THE ROW HAS BEEN REACHED...
	  giNoteNdx = 0							;...RESET NOTE INDEX TO ZERO (THE BEGINNING OF THE ROW)
	  igoto repeat							;RE-READ A NOTE VALUE (WILL BE THE FIRST NOTE IN THE ROW)
	endif								;END OF CONDITIONAL BRANCH
	giNoteNdx	=	giNoteNdx+1				;INCREMENT NOTE INDEX COUNTER

	aenv	expsega	0.001,0.005,1,p3-0.055,0.8,0.05,0.001		;AMPLITUDE ENVELOPE	
	kmul	expseg	0.1,0.01,0.5,0.03,0.4,1,0.4			;AMPLITUDE COEFFICIENT MULTIPLER
	a1	gbuzz	aenv*gkgain, cpsmidinn(iNote), 40, 1, kmul, gicos	;gbuzz OSCILLATOR	
		outs	a1,a1						;SEND AUDIO TO OUTPUTS
		gasend	=	gasend+(a1*0.3)				;SEND SOME AUDIO THROUGH GLOBAL AUDIO SEND CHANNEL
endin

instr	100	;METRONOME
	acps	expon	15000,p3,20					;PITCH ENVELOPE
	aenv	linseg	0, 0.002,1,p3-0.004,1,0.002,0			;AMPLITUDE ENVELOPE
	a1	poscil	0.2*aenv,acps,gisine				;AUDIO OSCILLATOR
	outs	a1,a1							;SEND AUDIO TO OUTPUTS
endin

instr	1000	;REVERB (ALWAYS ON)
	aRvbL,aRvbR	reverbsc	gasend, gasend, 0.8, 10000	;CREATE STEREO REVERB
			outs		aRvbL,aRvbR			;SEND AUDIO TO OUTPUTS
			clear		gasend				;CLEAR GLOBAL AUDIO VARIABLE (TO PREVENT ACCUMULATION RUNNING AWAY WITH ITSELF)
endin

</CsInstruments>
<CsScore>
i 1000 0 3600	;REVERB STAYS ON FOR 1 HOUR (AND KEEPS PERFORMANCE GOING) 
e
</CsScore>

</CsoundSynthesizer>