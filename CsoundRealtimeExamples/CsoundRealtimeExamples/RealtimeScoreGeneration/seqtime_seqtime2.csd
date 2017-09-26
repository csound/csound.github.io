seqtime_seqtime2.csd
Written by Iain McCurdy, 2015

<CsoundSynthesizer>

<CsOptions>
-odac -dm0 -b512 -B4096
</CsOptions>

<CsInstruments>

sr 	= 	44100  
ksmps 	= 	16
nchnls 	= 	2
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
		FLpanel	"seqtime seqtime2", 500, 250, 0, 0
;                                             		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | I | STARTTIM | IDUR |  p4
gkOnOff,ihOnOff	FLbutton	"Play/Stop",		1,    0,    22,    100,     25,    5,  5,   0,      2,     0,       -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;BORDERS					ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 		6,        1,    15,   490,     75,     5,100
ih		 	FLbox  	"seqtime2", 	1,       12,    15,   450,     15,    10,102

;COUNTERS						MIN    | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | POS_X | POS_Y | OPCODE
gkTimeUnit,ihTimeUnit	FLcount		"Time Unit",	0.125,    8,   0.125,    1,      1,   120,     25,     120,      5,     -1
gkLoopStart,ihLoopStart	FLcount		"Loop Start",	0,        7,   1,        1,      2,   100,     25,     255,      5,     -1
gkLoopEnd,ihLoopEnd	FLcount		"Loop End",	-8,       8,   1,        1,      2,   100,     25,     370,      5,     -1
gkInitPos,ihInitPos	FLcount		"Init.Pos.",	0,        8,   1,        1,      2,   100,     25,     130,     50,     -1
gkRhythm,ihRhythm	FLcount		"Rhythm",	1,        2,   1,        1,      2,   100,     25,     255,     50,     -1

;                                             			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | I | STARTTIM | IDUR |  p4
gkMetrOnOff,ihMetrOnOff		FLbutton	"Metronome",	1,    0,     2,    100,     25,   370,50,   -1
FLsetColor2	255, 50, 50, ihMetrOnOff		;SET SECONDARY COLOUR TO RED

;                                             			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | I | STARTTIM | IDUR |  p4
gkManRetrig,ihManRetrig		FLbutton	"Restart",	1,    0,     1,    100,     25,   15, 125,   0,     1,      0,       0
gkAutoRestart,ihAutoRestart	FLbutton	"Auto Restart",	1,    0,     2,    100,     25,   130,125,   -1
FLsetColor2	255, 50, 50, ihAutoRestart		;SET SECONDARY COLOUR TO RED
;COUNTERS							MIN    | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | POS_X | POS_Y | OPCODE
gkAutoRate,ihAutoRate 		FLcount		"Auto Rate",	0.125,    8,   0.125,    1,      1,    100,     25,     245,    125,     -1

;kout, ihandle 	FLtext	"label",        imin, imax, istep, itype, iwidth, iheight, ix, iy
k_,gihtrig_out	FLtext	"Trigger Val.", 0,     1,    0.000001,  0,     100,     25,  200,  190

;GENERAL_TEXT_SETTINGS			SIZE | FONT | ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,     1,    255,   255,    255	;LABELS MADE INVISIBLE
;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkopcode, ihopcode	FLbutBank	14,     1,     2,     10,      30,    5, 45,     -1
;GENERAL_TEXT_SETTINGS			SIZE | FONT | ALIGN | RED | GREEN | BLUE
			FLlabel		13,      5,      3,   0,      0,     0		;LABELS MADE VISIBLE AGAIN
;TEXT						ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	"seqtime ", 	1,       5,     15,    40,     15,    38, 43
ih		 	FLbox  	"seqtime2", 	1,       5,     15,    40,     15,    38, 58
      
FLsetVal_i	1, ihTimeUnit
FLsetVal_i	0, ihLoopStart
FLsetVal_i	8, ihLoopEnd
FLsetVal_i	0, ihInitPos
FLsetVal_i	1, ihRhythm
FLsetVal_i	0, ihMetrOnOff
FLsetVal_i	1, ihAutoRate

		FLpanel_end	;END OF PANEL CONTENTS



FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;INSTRUCTIONS AND INFO PANEL
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
				FLpanel	 " ", 512, 540, 562, 0
				FLscroll      512, 540, 0, 0
ih		 	FLbox  	"                       seqtime seqtime2                      ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"            1     2     3     4     5     6     7     8      ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"Rhythm 1:   0.5   0.25  0.5   1     0.5   0.25  0.5   0.5    ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"Rhythm 2:   1/3   2/3   1     1/3   1/3   1/3   2/3   1/3    ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"seqtime and seqtime2 can be used to generate trigger         ", 	1,      5,     14,    490,    20,     5, 120
ih	  	 	FLbox  	"sequences based upon user-defined time gap values held in    ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"GEN02 function tables (or from a text file via a GEN23       ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"table). These time gaps can be thought of as fractions of a  ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"beat. The actual duration of each beat will ultimately be    ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"determined by the value given to 'Time Unit'.                ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"The sequence will loop between the values 'Loop Start' and   ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"'Loop End' - the values refer to steps (or indices) within   ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"the table. In this example two 'rhythm' tables are provided  ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"between which the user can choose. The value contents of     ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"these two tables are shown above. It might seem initially    ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"slightly confusing, but the value for 'Loop Start' should    ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"indicate a point before the step from which we want looping  ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"to start. For example if we want the loop to begin a step 1  ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"then we need to give 'Loop Start' a value of zero.           ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"Conversely, a 'Loop End' value of '8' will determine that the", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"sequencer will loop back once the step 8 duration has        ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"completed. We can also define a initial start position using ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"'Init.Pos'. Giving 'Loop End' a negative value will result in", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"the sequencer playing in reverse. Setting 'Loop Start' and   ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"'Loop End' to the same value will force seqtime/seqtime to   ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"behave like a 'one shot' sequency player, starting from      ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"'Init.Pos' and stopping once the 'Loop Start'/'Loop End' step", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"is reached.                                                  ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"seqtime2 differs form seqtime in that it includes an input   ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"trigger which when used, will force the sequencer to restart.", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"It will only restart once the current duration has completed ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"so that rhythmic coherence should be maintained.             ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"In this example this retrigger can be employed manually or   ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"using an automated metronome.                                ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"The actual trigger values output by seqtime/seqtime2 will be ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"the current rhythmic value. In this example these values are ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"should in the GUI. Perhaps the user will find a creative use ", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"for these.                                                   ", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"I have included a regular metronome in this example which the", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"user can switch on to gauge the rhythms output by seqtime    ", 	1,      5,     14,    490,    20,     5, 820
ih		 	FLbox  	"better.                                                      ", 	1,      5,     14,    490,    20,     5, 840
ih		 	FLbox  	"A small bug in these opcodes means that the first trigger    ", 	1,      5,     14,    490,    20,     5, 860
ih		 	FLbox  	"value will actually be output twice (on the first and second ", 	1,      5,     14,    490,    20,     5, 880
ih		 	FLbox  	"k-periods). In this example I have implemented a small       ", 	1,      5,     14,    490,    20,     5, 900
ih		 	FLbox  	"workaround to remove the second of these two triggers.       ", 	1,      5,     14,    490,    20,     5, 920
			FLscroll_end
			FLpanel_end
			FLrun


gisine		ftgen		0,0,4096,10,1	;SINE WAVE

;                         1     2     3     4     5     6     7     8
girhythm1 ftgen 0,0,8,-2, 0.5,  0.25, 0.5,  1,    0.5,  0.25, 0.5,  0.5
girhythm2 ftgen 0,0,8,-2, 1/3,  2/3,  1,    1/3,  1/3,  1/3,  2/3,  1/3

gkReTrig	init	0

instr	1
 gkReTrig	init	i(gkManRetrig)
endin


instr	2	; SEQUENCER INSTRUMENT
 ; TEST FOR ON/OFF STATUS
 if gkOnOff==0 then
  turnoff
 endif
 
 ; REINITIALISATION WHEN CERTAIN CONTROLS ARE CHANGED DONE IN ORDER TO PREVENT UNPLEASANT NOISES CAUSED BY SUDDEN STREAMS OF CONTINUOUS TRIGGERS
 kReInit	changed	gkRhythm, gkopcode
 if kReInit==1 then
  reinit	RESTART_SEQTIME					; better to reinit seqtime when certain parameters change
 endif
 RESTART_SEQTIME:

 ; AUTO RESTART (seqtime2)
 kAutoRate	init	i(gkAutoRate)
 kAutoTrig	metro	kAutoRate
 if kAutoTrig==1 then						; only update auto-retrigger metronome on a tick in order to maintain rhythmic sync. This is not necessay for all applications.
  kAutoRate	=	gkAutoRate
 endif
 kAutoTrig	=	kAutoTrig * gkAutoRestart

 ; SET SOME INPUT ARGUMENTS AT I_TIME
 kRhythm	=	girhythm1 + gkRhythm - 1
 kRhythm	init	girhythm1 + i(gkRhythm) - 1
 kInitPos	init	i(gkInitPos)
 kLoopStart	init	i(gkLoopStart)
 kLoopStart	=	gkLoopStart
 kLoopEnd	init	i(gkLoopEnd)
 kLoopEnd	=	gkLoopEnd
 kTimeUnit	init	i(gkTimeUnit)
 kTimeUnit	=	gkTimeUnit

 ; CHOOSE BETWEEN SEQTIME AND SEQTIME2
 if gkopcode==0 then
  ktrig_out	seqtime		                      kTimeUnit, kLoopStart, kLoopEnd, kInitPos, kRhythm
 else
  ktrig_out	seqtime2	gkReTrig + kAutoTrig, kTimeUnit, kLoopStart, kLoopEnd, kInitPos, kRhythm	; manual retrigger and auto retrigger added together in order to facilitate both mechanisms simultaneously
 endif 
 gkReTrig	=	0

 ; CREATE AN EVENT
 if ktrig_out>0 && timeinstk()!=1 then	; nb remove repeat trigger on second k-cycle
  event	"i",3,0,0.015
 endif

 ; PRINT TRIGGER VALUE
 kPrintTrig	trigger	ktrig_out,0.001,0
 FLsetVal	kPrintTrig,ktrig_out,gihtrig_out
 
 ; REGULAR METRONOME
 kmetro		metro		gkTimeUnit
 schedkwhen	kmetro*gkMetrOnOff,0,0,4,0,0.02
endin

instr	3 ;rhythm tap
 aenv	expon	1,p3,0.001
 acps	expon	2000,p3,40
 asig	poscil	0.7*aenv,acps,gisine
 	outs	asig*0.5,asig
endin

instr	4 ;metronome
 aenv	expon	1,p3,0.001
 asig	poscil	0.2*aenv,4000,gisine
 	outs	asig,asig*0.5
endin

</CsInstruments>

<CsScore>
f0 3600	;DUMMY SCORE EVENT - ALLOWS REALTIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>