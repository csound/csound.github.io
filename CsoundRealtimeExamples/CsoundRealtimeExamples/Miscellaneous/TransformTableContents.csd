TransformTableContents.csd
Written by Iain McCurdy 2010, updated 2011 & 2014.
adapted from ShuffleTableContents.csd

<CsoundSynthesizer>

<CsOptions>
-odac -dm0 -Q2
; Use -Q flag for MIDI output
; -Q2

</CsOptions>

<CsInstruments>
sr 	=	44100
ksmps 	=	8
nchnls 	=	1
0dbfs	=	1	;MAXIMUM AMPLITUDE
	seed	0	;SEED RANDOM NUMBER GENERATORS FROM THE SYSTEM CLOCK

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL              | WIDTH | HEIGHT | X | Y
	FLpanel	"Transform Table Contents",   500,    495,    0,  0

;BORDERS								TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 					6,      9,     15,    496,    105,    2,  2	;BORDER PANEL
FLsetColor	220,220,220,ih
ih		 	FLbox  	"P   L   A   Y   B   A   C   K", 	1,      2,     12,    200,     15,  150,  4	;LABEL
FLsetColor	220,220,220,ih

ih		 	FLbox  	" ", 					6,      9,     15,    496,    325,    2,109	;BORDER PANEL
FLsetColor	220,220,220,ih
ih		 	FLbox  	"T   R   A   N   S   F   O   R   M", 	1,      2,     12,    200,     15,  150,111	;LABEL
FLsetColor	220,220,220,ih

ih		 	FLbox  	" ", 					6,      9,     15,    496,     56,    2,437	;BORDER PANEL
FLsetColor	220,220,220,ih
ih		 	FLbox  	"S   E   T   U   P", 			1,      2,     12,    100,     15,  200,439	;LABEL
FLsetColor	220,220,220,ih



;SWITCHES                                			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gk,ihPlay		FLbutton	"@DnArrow   Play Once",	1,    0,    21,    110,     22,   10,  6,     0,      3,      0,      0	;ZERO DURATION IS VALID WHEN THE TRIGGERED INSTRUMENT ONLY NEEDS TO PERFORM I-TIME OPERATIONS
FLsetColor2	0,255,0,ihPlay
gkWander,ihWander	FLbutton	"@DnArrow   Walk",	1,    0,    22,    110,     22,   10, 31,     0,      4,      0,      -1
FLsetColor2	0,255,0,ihWander
gkPick,ihPick		FLbutton	"@DnArrow   Pick",	1,    0,    22,    110,     22,   10, 56,     0,     50,      0,      -1
FLsetColor2	0,255,0,ihPick
gkLoop,ihLoop		FLbutton	"@DnArrow   Loop",	1,    0,    22,    110,     22,   10, 81,     0,     51,      0,      -1
FLsetColor2	0,255,0,ihLoop

;SLIDERS						MIN  | MAX | EXP | TYPE |   DISP    | WIDTH | HEIGHT | X | Y
gkgain, ihgain		FLslider 	"Level",	0,       1,   0,    3,      -1,        70,     15,    125, 20
gkRestProb, ihRestProb	FLslider 	"Rest Prob.",	0,     0.9,   0,    3,      -1,        70,     12,    250, 57
gkDoubProb, ihDoubProb	FLslider 	"Doub.Prob.",	0,     0.9,   0,    3,      -1,        70,     12,    325, 57
FLsetVal_i	0.2,ihgain

;VALUE INPUT BOXES						MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkgap, ihgap			FLtext		"Gap",  	0,      1,  0.01,   1,     50,     18,    200,  20
gkSpeedRatio, ihSpeedRatio	FLtext		"Ratio", 	0.1,    5,  0.01,   1,     50,     18,    255,  20
gkFirst, ihFirst		FLtext		"First", 	1,     99,     1,   1,     50,     18,    310,  20
gkLast, gihLast			FLtext		"Last", 	1,     99,     1,   1,     50,     18,    365,  20
gkDur, ihDur			FLtext		"Duration", 	0.01,  10,  0.01,   1,     50,     18,    420,  20
;SWITCHES                                			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkSkipNeg,ihSkipNeg		FLbutton	"Skip Repeats",	1,    0,     2,    120,     22,   125, 57,    -1
FLsetColor2	255,155,00,ihSkipNeg
gkMidiOut,ihMidiOut		FLbutton	"MIDI Out",     1,    0,     2,     85,     20,   400, 57,    -1
FLsetColor2	150,150,255,ihMidiOut
;COUNTERS						MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkMidiChan, ihMidiChan		FLcount  	"", 	1,     16,    1,      1,     2,      85,     20,   400, 77,   -1 

FLsetVal_i	1,ihFirst
FLsetVal_i	12,gihLast
FLsetVal_i	0.6,ihDur
FLsetVal_i	1,ihMidiChan






;SWITCHES                                		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gk,ih		FLbutton	"Shuffle",		1,    0,    21,     90,     30,   90, 130,     0,      1,      0,      0
gk,ih		FLbutton	"Retrograde",		1,    0,    21,     90,     30,  185, 130,     0,      5,      0,      0
gk,ih		FLbutton	"Reset Scale",		1,    0,    21,     90,     30,  280, 130,     0,      6,      0,      0
gk,ih		FLbutton	"Reset Value:",		1,    0,    21,     90,     20,  375, 135,     0,     20,      0,      0
;VALUE INPUT BOXES					MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkResetVal, ihResetVal		FLtext		"",	0,    128,   1,     1,     30,     20,    465, 135
FLsetVal_i	60,ihResetVal

gk,ih		FLbutton	"Add",	 		1,    0,    21,     40,     20,   90,180,     0,      7,      0,      0
gk,ih		FLbutton	"Multiply",	 	1,    0,    21,     60,     20,  135,180,     0,      8,      0,      0
gk,ih		FLbutton	"Add Rand.",	 	1,    0,    21,     75,     20,  200,180,     0,      9,      0,      0
gk,ih		FLbutton	"Add Bi-Rand.",	 	1,    0,    21,     95,     20,  280,180,     0,     24,      0,      0
gk,ih		FLbutton	"Mult. Rand. (+1)", 	1,    0,    21,    110,     20,  380,180,     0,     10,      0,      0

gk,ih		FLbutton	"Ascending",	 	1,    0,    21,     85,     20,   90,210,     0,     11,      0,      0
gk,ih		FLbutton	"Descending",	 	1,    0,    21,     85,     20,  180,210,     0,     12,      0,      0
gk,ih		FLbutton	"Integer",	 	1,    0,    21,     60,     20,  270,210,     0,     13,      0,      0
gk,ih		FLbutton	"Round",	 	1,    0,    21,     60,     20,  335,210,     0,     14,      0,      0
gk,ih		FLbutton	"Min",	 		1,    0,    21,     40,     20,  405,210,     0,     15,      0,      0
gk,ih		FLbutton	"Max",	 		1,    0,    21,     40,     20,  450,210,     0,     16,      0,      0

gk,ih		FLbutton	"Flip Rpts.", 		1,    0,    21,     90,     20,   90,240,     0,     17,      0,      0
gk,ih		FLbutton	"Flip Recurrences",	1,    0,    21,    125,     20,  185,240,     0,     19,      0,      0
gk,ih		FLbutton	"Absolute",	 	1,    0,    21,     85,     20,  315,240,     0,     18,      0,      0
gk,ih		FLbutton	"Invert",	 	1,    0,    21,     85,     20,  405,240,     0,     25,      0,      0

gk,ih		FLbutton	"Add Gaussian",	 	1,    0,    21,    100,     20,   90,280,     0,     32,      0,      0,6
gk,ih		FLbutton	"Add Exp.",	 	1,    0,    21,     80,     20,  195,280,     0,     32,      0,      0,4
gk,ih		FLbutton	"Add Bi-Exp.",	 	1,    0,    21,    100,     20,  280,280,     0,     32,      0,      0,5
gk,ih		FLbutton	"+ Lin.Rand",	 	1,    0,    21,    100,     20,  385,280,     0,     32,      0,      0,2

gk,ih		FLbutton	"Add Cauchy",	 	1,    0,    21,     90,     20,   90,310,     0,     32,      0,      0,8
gk,ih		FLbutton	"Add Bi-Cauchy",	1,    0,    21,    110,     20,  185,310,     0,     32,      0,      0,7
gk,ih		FLbutton	"Add Beta",		1,    0,    21,     90,     20,  300,310,     0,     32,      0,      0,9
gk,ih		FLbutton	"+ Tri.Rand",		1,    0,    21,     90,     20,  395,310,     0,     32,      0,      0,3

gk,ih		FLbutton	"Add Weibull",		1,    0,    21,    100,     20,   90,340,     0,     32,      0,      0,10
gk,ih		FLbutton	"Add Poisson",		1,    0,    21,    100,     20,  195,340,     0,     32,      0,      0,11


gk,ihundo	FLbutton	"Undo 1",		1,    0,    21,     70,     20,   10,130,     0,    999,      0,      0
gk,ihundo2	FLbutton	"Undo 2",		1,    0,    21,     70,     20,   10,150,     0,   1000,      0,      0
FLsetColor	0,0,255,ihundo
FLsetColor	0,0,255,ihundo2








;VALUE INPUT BOXES						MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkval, ihval			FLtext		"Value",	-100, 100,  0.01,   1,     70,     20,     10, 180
gkarg1, ihval1			FLtext		"Arg.1",	-100, 100,  0.01,   1,     70,     20,     10, 280
gkarg2, ihval2			FLtext		"Arg.2",	-100, 100,  0.01,   1,     70,     20,     10, 320

FLsetVal_i	1,ihval1
FLsetVal_i	1,ihval2

FLsetVal_i	0.2,ihgap
FLsetVal_i	1.05,ihSpeedRatio

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Items", 	1,       5,    14,     45,     20,    3,  375
FLsetColor	220,220,220,ih
ih		 	FLbox  	"Notes", 	1,       5,    14,     45,     20,    3,  408
FLsetColor	220,220,220,ih
gihNote1	 	FLbox  	"", 		1,       5,    14,     35,     20,   50,  408	; print note names
gihNote2	 	FLbox  	"", 		1,       5,    14,     35,     20,   85,  408
gihNote3	 	FLbox  	"", 		1,       5,    14,     35,     20,  120,  408
gihNote4	 	FLbox  	"", 		1,       5,    14,     35,     20,  155,  408
gihNote5	 	FLbox  	"", 		1,       5,    14,     35,     20,  190,  408
gihNote6	 	FLbox  	"", 		1,       5,    14,     35,     20,  225,  408
gihNote7	 	FLbox  	"", 		1,       5,    14,     35,     20,  260,  408
gihNote8	 	FLbox  	"", 		1,       5,    14,     35,     20,  295,  408
gihNote9	 	FLbox  	"", 		1,       5,    14,     35,     20,  330,  408
gihNote10	 	FLbox  	"", 		1,       5,    14,     35,     20,  365,  408
gihNote11	 	FLbox  	"", 		1,       5,    14,     35,     20,  400,  408
gihNote12	 	FLbox  	"", 		1,       5,    14,     35,     20,  435,  408


;TEXT BOXES			MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gk1,  gih1	FLtext	"1", 	8,     9,    0,     1,      35,     20,   50,  375
gk2,  gih2	FLtext	"2", 	8,     9,    0,     1,      35,     20,   85,  375
gk3,  gih3	FLtext	"3", 	8,     9,    0,     1,      35,     20,  120,  375
gk4,  gih4	FLtext	"4", 	8,     9,    0,     1,      35,     20,  155,  375
gk5,  gih5	FLtext	"5", 	8,     9,    0,     1,      35,     20,  190,  375
gk6,  gih6	FLtext	"6", 	8,     9,    0,     1,      35,     20,  225,  375                       
gk7,  gih7	FLtext	"7", 	8,     9,    0,     1,      35,     20,  260,  375
gk8,  gih8	FLtext	"8", 	8,     9,    0,     1,      35,     20,  295,  375
gk9,  gih9	FLtext	"9", 	8,     9,    0,     1,      35,     20,  330,  375
gk10, gih10	FLtext	"10", 	8,     9,    0,     1,      35,     20,  365,  375
gk11, gih11	FLtext	"11", 	8,     9,    0,     1,      35,     20,  400,  375
gk12, gih12	FLtext	"12", 	8,     9,    0,     1,      35,     20,  435,  375
gk,ih		FLbutton	"@<-", 1,    0,     1,      25,     20,  470,  375,     0,     23,      0,      0
FLsetColor	220,220,220,gihNote1	 	
FLsetColor	220,220,220,gihNote2	 	
FLsetColor	220,220,220,gihNote3	 	
FLsetColor	220,220,220,gihNote4	 	
FLsetColor	220,220,220,gihNote5	 	
FLsetColor	220,220,220,gihNote6	 	
FLsetColor	220,220,220,gihNote7	 	
FLsetColor	220,220,220,gihNote8	 	
FLsetColor	220,220,220,gihNote9	 	
FLsetColor	220,220,220,gihNote10	 	
FLsetColor	220,220,220,gihNote11	 	
FLsetColor	220,220,220,gihNote12	 	






;COUNTERS						MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkTabLen, ihTabLen		FLcount  "Table Length",2,     99,    1,      8,     1,     110,      20,   10,450,    -1

FLsetVal_i	12,ihTabLen


FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 512, 560, 510, 0
				FLscroll     512, 560, 0,  0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                Transform Table Contents                     ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"This example transforms the contents of a function table in a", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"variety of ways. Although a function table created using any ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"GEN routine could be used it is probably most useful with a  ", 	1,      5,     14,    490,    20,     5,  80 
ih		 	FLbox  	"GEN 2 created list of numbers.                               ", 	1,      5,     14,    490,    20,     5, 100 
ih		 	FLbox  	"The table's contents in this example are the notes of a      ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"chromatic scale in MIDI note number format from middle C to  ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"the B above.                                                 ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"'Shuffle' shuffles the contents of a function table in a     ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"fashion similar to shuffling a deck of cards. Each time the  ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"'Shuffle' button is clicked the order of these twelve items  ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"is changed. The new table is printed to the terminal and to  ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"the FL boxes and the table contents can be played in sequence", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"as a note row by clicking 'Play Row'.                        ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"'Walk' plays through the row in a drunk walk / random walk   ", 	1,      5,     14,    490,    20,     5, 300 
ih		 	FLbox  	"fashion.                                                     ", 	1,      5,     14,    490,    20,     5, 320 
ih		 	FLbox  	"'Pick' plays notes that are picked randomly from the row.    ", 	1,      5,     14,    490,    20,     5, 340 
ih		 	FLbox  	"'First' and 'Last' allow us to modify the range from within  ", 	1,      5,     14,    490,    20,     5, 360 
ih		 	FLbox  	"the table that the three play modes will choose values.      ", 	1,      5,     14,    490,    20,     5, 380 
ih		 	FLbox  	"Table shuffling is achieved by sequencially swapping each    ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"table item with another randomly chosen item.                ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"'Retrograde' reverses the order of the table's contents.     ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"Clicking on 'Reset Scale' will reset the table to the        ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"original ascending chromatic scale condition.                ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"Clicking on 'Reset Value:' will reset all table values to the", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"value provided.                                              ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"In the second row of buttons the user can specify a value    ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"which can then be added or multiplied to each value in the   ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"table. Negative values are allowed. The procedure will       ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"protect against out of range values.                         ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"'Add Rand.' will add a random value within the range zero to ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"'Value' to each item in the table. A new random number is    ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"generated for each addition. 'Mult. Rand.' multiplies each   ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"value by a random number (plus 1).                           ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"Clicking on 'Integer' will remove the fractional part of all ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"values. Clicking on 'Round' will round all values to the     ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"nearest integer.                                             ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"'Ascending' sorts values into ascending order, 'Descending'  ", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"into descending order.                                       ", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"'Flip Rpts.' will search for repeated notes and flip the sign", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"(i.e. positive to negative) of any values is finds that are  ", 	1,      5,     14,    490,    20,     5, 820
ih		 	FLbox  	"repeats of the previous value. The playback engine will      ", 	1,      5,     14,    490,    20,     5, 840
ih		 	FLbox  	"ignore any notes that are less than zero. If 'Skip Negatives'", 	1,      5,     14,    490,    20,     5, 860
ih		 	FLbox  	"in the playback section is activate the playback engine will ", 	1,      5,     14,    490,    20,     5, 880
ih		 	FLbox  	"skip over negative note numbers without leaving a rest.      ", 	1,      5,     14,    490,    20,     5, 900
ih		 	FLbox  	"'Flip Recurrences' will flip the sign of any value than is a ", 	1,      5,     14,    490,    20,     5, 920
ih		 	FLbox  	"recurrence of an earlier value.                              ", 	1,      5,     14,    490,    20,     5, 940
ih		 	FLbox  	"'Absolute' will invert any values that are negative. This    ", 	1,      5,     14,    490,    20,     5, 960
ih		 	FLbox  	"function can be used top undo the effects of 'Flip Rpts.' and", 	1,      5,     14,    490,    20,     5, 980
ih		 	FLbox  	"'Flip Recurrences'.                                          ", 	1,      5,     14,    490,    20,     5,1000
ih		 	FLbox  	"'Invert' will relect note numbers across the value of        ", 	1,      5,     14,    490,    20,     5,1020
ih		 	FLbox  	"'Value'.                                                     ", 	1,      5,     14,    490,    20,     5,1040
ih		 	FLbox  	"Clicking the '<' button beside the number boxes will write   ", 	1,      5,     14,    490,    20,     5,1060
ih		 	FLbox  	"all box values that have been edited by typing to the table. ", 	1,      5,     14,    490,    20,     5,1080
ih		 	FLbox  	"The table length can be changed from the default 12 items.   ", 	1,      5,     14,    490,    20,     5,1100
ih		 	FLbox  	"Transformations will be applied to all items in the new sized", 	1,      5,     14,    490,    20,     5,1120
ih		 	FLbox  	"table (even ones that are not visible in the FLTK GUI).      ", 	1,      5,     14,    490,    20,     5,1140
ih		 	FLbox  	"Note that when table length is changed the 'Last' value in   ", 	1,      5,     14,    490,    20,     5,1160
ih		 	FLbox  	"the playback section changes to the same value.              ", 	1,      5,     14,    490,    20,     5,1180
ih		 	FLbox  	"Note names are also written into the FLTK GUI for each note  ", 	1,      5,     14,    490,    20,     5,1200 
ih		 	FLbox  	"of the row. Non-integer values are rounded to the nearest    ", 	1,      5,     14,    490,    20,     5,1220
ih		 	FLbox  	"integer before being converted to a note name.               ", 	1,      5,     14,    490,    20,     5,1240
ih		 	FLbox  	"Within the 'PLAYBACK' section we can also specify the first  ", 	1,      5,     14,    490,    20,     5,1260
ih		 	FLbox  	"and last notes to be played. 'Gap' specifies the time gap    ", 	1,      5,     14,    490,    20,     5,1280
ih		 	FLbox  	"between adjacent notes. 'Ratio' is a value multiplied to the ", 	1,      5,     14,    490,    20,     5,1300
ih		 	FLbox  	"time gap iteratively as the rown progresses, therefore ratios", 	1,      5,     14,    490,    20,     5,1320
ih		 	FLbox  	"greater than '1' will result in a slowing playback and ratios", 	1,      5,     14,    490,    20,     5,1340
ih		 	FLbox  	"less than '1' will result in accelerating playbacks. 'Rest   ", 	1,      5,     14,    490,    20,     5,1360
ih		 	FLbox  	"Prob.' defines the probability that a rest will be inserted  ", 	1,      5,     14,    490,    20,     5,1380
ih		 	FLbox  	"between adjacent notes in the row. When this is at its       ", 	1,      5,     14,    490,    20,     5,1400
ih		 	FLbox  	"minimum setting, no rests will be inserted.                  ", 	1,      5,     14,    490,    20,     5,1420
ih		 	FLbox  	"The note row produced can also easily be output as MIDI by   ", 	1,      5,     14,    490,    20,     5,1440
ih		 	FLbox  	"adding the -Q Csound flag in <CsOptions>. Rows can then be   ", 	1,      5,     14,    490,    20,     5,1460
ih		 	FLbox  	"recorded into a sequencer.                                   ", 	1,      5,     14,    490,    20,     5,1480

FLscroll_end
FLpanel_end                                                                                       
FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; INITIAL TABLES
giTable		ftgen	1,0,-12,-2, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71	;CHROMATIC SCALE - 12 ITEMS - NEGATIVE TABLE SIZE PERMITS THE USE OF NON-ZERO TABLE SIZE
giUndoBuffer	ftgen	2,0,-12,-2, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71	;CHROMATIC SCALE - 12 ITEMS - NEGATIVE TABLE SIZE PERMITS THE USE OF NON-ZERO TABLE SIZE
giUndoBuffer2	ftgen	3,0,-12,-2, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71	;CHROMATIC SCALE - 12 ITEMS - NEGATIVE TABLE SIZE PERMITS THE USE OF NON-ZERO TABLE SIZE
giTempBuffer	ftgen	4,0,-12,-2, 60, 61, 62, 63, 64, 65, 66, 67, 68, 69, 70, 71	;CHROMATIC SCALE - 12 ITEMS - NEGATIVE TABLE SIZE PERMITS THE USE OF NON-ZERO TABLE SIZE







gisine		ftgen	0, 0, 4096, 10, 1						;A SINE WAVE

strset 0,	"C"	; Strings for the notes of the chromatic scale linked to integer values
strset 1,	"C#"
strset 2,	"D"
strset 3,	"D#"
strset 4,	"E"
strset 5,	"F"
strset 6,	"F#"
strset 7,	"G"
strset 8,	"G#"
strset 9,	"A"
strset 10,	"A#"
strset 11,	"B"







opcode	tab_shuffle,0,i
	ifn		xin
	iNumItems	=	ftlen(ifn)			;DERIVE THE NUMBER OF ITEMS IN THE FUNCTION TABLE
	icount 		= 	0				;INITIALISE COUNTER
	loop:							;LABEL
	ival1	table	icount, ifn				;READ A VALUE FROM SEQUENCIAL COUNTER TABLE LOCATION
	irndndx	random	0,iNumItems-0.001			;RANDOM TABLE INDEX USED TO CHOOSE SECOND ITEM
	ival2	table	irndndx, ifn				;READ SECOND VALUE FROM TABLE LOCATION
		tableiw	ival2, icount, ifn			;ITEM 2 WRITTEN TO ITEM 1'S LOCATION
		tableiw	ival1, irndndx, ifn			;ITEM 1 WRITTEN TO ITEM 2'S LOCATION
	;	OPCODE  COUNTER | INCREMENT | LIMIT | LABEL
		loop_lt	icount,       1,    iNumItems,loop	;LOOPING CONSTRUCTION
endop


opcode	tab_retrograde,0,i
	ifn		xin
	iNumItems	=		ftlen(ifn)			;DERIVE THE NUMBER OF ITEMS IN THE FUNCTION TABLE
	iTableBuffer	ftgentmp	0,0,-iNumItems,-2, 0		;TEMPORARY BUFFER TABLE INITIALLY CONSISTING OF ZEROES
	icount		=		0				;INITIALISE COUNTER
	loop:								;LABEL - LOOPING LOOPS BACK TO HERE
	ival		table		iNumItems-icount-1, ifn		;READ VALUE FROM TABLE
			tableiw		ival, icount, iTableBuffer	;READ VALUE FROM MIRROR OPPOSITE POSITION IN TABLE
		loop_lt	icount,1,iNumItems,loop				;LOOPING CONSTRUCTION
	;COPY BUFFER TABLE BACK INTO ORIGINAL TABLE
	icount		=		0
	loop2:
	ival		table		icount,iTableBuffer
			tableiw		ival,icount,ifn
			loop_lt		icount,1,iNumItems,loop2
endop

opcode	tab_add_value,0,ii
	iaddval,ifn	xin
	iNumItems	=	ftlen(ifn)		;DERIVE THE NUMBER OF ITEMS IN THE FUNCTION TABLE
	icount		=	0			;INITIALISE LOOP COUNTER
	loop:						;LABEL - LOOPING LOOPS BACK TO HERE
	ival		table	icount,ifn		;READ VALUE FROM TABLE
	ival		=	ival+iaddval            ;ADD VALUE
			tableiw	ival,icount,ifn		;WRITE NEW VALUE INTO LOCATION OF ORIGINAL VALUE
			loop_lt	icount,1,iNumItems,loop	;LOOPING CONSTRUCTION
endop

opcode	tab_mult_value,0,ii
	imultval,ifn	xin
	iNumItems	=	ftlen(ifn)		;DERIVE THE NUMBER OF ITEMS IN THE FUNCTION TABLE
	icount		=	0			;INITIALISE LOOP COUNTER
	loop:						;LABEL - LOOPING LOOPS BACK TO HERE
	ival		table	icount,ifn		;READ VALUE FROM TABLE
	ival		=	ival*imultval		;MULTIPLY BY VALUE
			tableiw	ival,icount,ifn		;WRITE NEW VALUE INTO LOCATION OF ORIGINAL VALUE
			loop_lt	icount,1,iNumItems,loop	;LOOPING CONSTRUCTION
endop

opcode	tab_add_random,0,ii
	irange,ifn	xin
	iNumItems	=	ftlen(ifn)		;DERIVE THE NUMBER OF ITEMS IN THE FUNCTION TABLE
	icount		=	0                       ;INITIALISE LOOP COUNTER
	loop:                                      	;LABEL - LOOPING LOOPS BACK TO HERE
	ival		table	icount,ifn		;READ VALUE FROM TABLE
	iRAdd		random	0,irange		;CREATE A RANDOM VALUE
	ival		=	ival+iRAdd		;ADD RANDOM VALUE
			tableiw	ival,icount,ifn		;WRITE NEW VALUE INTO LOCATION OF ORIGINAL VALUE
			loop_lt	icount,1,iNumItems,loop	;LOOPING CONSTRUCTION
endop

opcode	tab_add_bi_random,0,ii
	irange,ifn	xin
	iNumItems	=	ftlen(ifn)		;DERIVE THE NUMBER OF ITEMS IN THE FUNCTION TABLE
	icount		=	0                       ;INITIALISE LOOP COUNTER
	loop:                                      	;LABEL - LOOPING LOOPS BACK TO HERE
	ival		table	icount,ifn		;READ VALUE FROM TABLE
	iRAdd		random	-irange,irange		;CREATE A RANDOM VALUE
	ival		=	ival+iRAdd		;ADD RANDOM VALUE
			tableiw	ival,icount,ifn		;WRITE NEW VALUE INTO LOCATION OF ORIGINAL VALUE
			loop_lt	icount,1,iNumItems,loop	;LOOPING CONSTRUCTION
endop

opcode	tab_mult_random,0,ii
	irange,ifn	xin
	iNumItems	=	ftlen(ifn)		;DERIVE THE NUMBER OF ITEMS IN THE FUNCTION TABLE
	icount		=	0			;INITIALISE LOOP COUNTER
	loop:						;LABEL - LOOPING LOOPS BACK TO HERE
	ival	table	icount,ifn			;READ VALUE FROM TABLE
	iRMult	random	1,1+irange			;CREATE A RANDOM VALUE
	ival	=	ival*iRMult			;MULTIPLY BY RANDOM VALUE
		tableiw	ival,icount,ifn			;WRITE NEW VALUE INTO LOCATION OF ORIGINAL VALUE
		loop_lt	icount,1,iNumItems,loop		;LOOPING CONSTRUCTION
endop

opcode	tabsort_ascnd,0,i
	ifn		xin
	;---DERIVE MAXIMUM VALUE---
	iNumItems	=	ftlen(ifn)			;DERIVE THE NUMBER OF ITEMS IN THE FUNCTION TABLE
	imax	table	0,ifn					;STARTING VALUE IN THE SEARCH FOR  FOR THE MAXIMUM
	icount	=	1					;COUNTER STARTS AT ONE (WE'VE ALREADY READ VALUE ZERO)
	loop1:							;LABEL - BEGINING OF SUMMING LOOP
	  ival	table	icount,ifn				;READ VALUE FROM TABLE
	  imax = (ival>=imax?ival:imax)				;IF VAL IS BIGGER THAN CURRENT MAXIMUM THEN MAKE IT THE NEW MAXIMUM
	loop_lt	icount,1,iNumItems,loop1			;LOOP BACK TO 'loop1' UNTIL LOOPING COMPLETE
		
	;---SORT INTO ASCENDING ORDER---
	;THIS CONSISTS OF TWO LOOPS: THE MAIN LOOP WILL BE EXECUTED iNumItems TIMES
	;                            THE SUB LOOP WILL BE EXECUTED iNumItems x iNumItems TIMES
	iTableBuffer	ftgentmp	0,0,-iNumItems,-2, 0	;TEMPORARY BUFFER TABLE INITIALLY CONSISTING OF ZEROES - WILL BE USED TO STORE
	icount1		=	0				;INITIALISE MAIN LOOP COUNTER
	loop2:							;LABEL - MAIN LOOPING LOOPS BACK TO HERE
	  icount2	=	0				;RE-INITIALISE SUB-LOOP COUNTER AT THE BEGINNING OF EACH PRIMARY LOOP
	  imin		=	imax				;INITIALISE 'MINIMUM' TO THE MAXIMUM VALUE - RESET AT THE BEGINNING OF EACH PRIMARY LOOP
	  loop3:						;LABEL - SUB-LOOP LOOPS BACK TO HERE
	    ival	table	icount2,ifn			;READ VALUE FROM TABLE...
	    if ival<=imin then					;...IF IT IS SMALLER THAN OR EQUAL TO THE CURRENT MINIMUM VALUE... ('EQUAL TO' IS REQUIRED IN THE EVENTUALITY THAT TWO TABLE ITEMS ARE THE SAME)			
	      imin = ival					;...MAKE IT THE NEW MINIMUM
	      iloc = icount2					;REMEMBER ITS LOCATION - IF IT IS THE FINAL MINIMUM IN THIS SEARCH IT WILL HAVE TO BE SET TO A VERY HIGH VALUE SO WE DON'T FIND IT IN SUBSEQUENT SEARCHES 
	    endif
	    loop_lt	icount2,1,iNumItems,loop3		;SUB-LOOP LOOPS BACK TO 'LOOP2BEGIN' UNTIL COUNTER REACH THE END OF THE TABLE
	  tableiw	imin,icount1,iTableBuffer		;WRITE THE MINIMUM VALUE FOUND INTO THE BUFFER TABLE
	  tableiw	imax,iloc,ifn				;SET THE MINIMUM VALUE IN THE ORIGINAL TABLE TO THE MAXIMUM VALUE SO THAT WE DON'T FIND IT AGAIN
	  loop_lt	icount1,1,iNumItems,loop2		;LOOPING CONSTRUCTION
	;COPY BUFFER TABLE BACK INTO ORIGINAL TABLE
	icount		=		0
	loop4:
	ival		table		icount,iTableBuffer
			tableiw		ival,icount,ifn
			loop_lt		icount,1,iNumItems,loop4
endop

opcode	tabsort_dscnd,0,i
	ifn		xin
	;---DERIVE MAXIMUM VALUE---
	iNumItems	=	ftlen(ifn)			;DERIVE THE NUMBER OF ITEMS IN THE FUNCTION TABLE
	imax	table	0,ifn					;STARTING VALUE IN THE SEARCH FOR  FOR THE MAXIMUM
	icount	init	1					;COUNTER STARTS AT ONE (WE'VE ALREADY READ VALUE ZERO)
	loop1:							;LABEL - BEGINING OF SUMMING LOOP
	  ival	table	icount,ifn				;READ VALUE FROM TABLE
	  imax = (ival>=imax?ival:imax)				;IF VAL IS BIGGER THAN CURRENT MAXIMUM THEN MAKE IT THE NEW MAXIMUM
	  		loop_lt	icount,1,iNumItems,loop1	;LOOP BACK TO 'LOOP0BEGIN' UNTIL LOOPING COMPLETE
		
	;---SORT INTO DESCENDING ORDER---
	;THIS CONSISTS OF TWO LOOPS: THE MAIN LOOP WILL BE EXECUTED 11 TIMES
	;                            THE SUB LOOP WILL BE EXECUTED 11x11 (121) TIMES
	iTableBuffer	ftgentmp	0,0,-iNumItems,-2, 0	;TEMPORARY BUFFER TABLE INITIALLY CONSISTING OF ZEROES - WILL BE USED TO STORE
	icount1		=	0				;INITIALISE MAIN LOOP COUNTER
	loop2:							;LABEL - MAIN LOOPING LOOPS BACK TO HERE
	  icount2	=	0				;RE-INITIALISE SUB-LOOP COUNTER AT THE BEGINNING OF EACH PRIMARY LOOP
	  imin		=	imax				;INITIALISE 'MINIMUM' TO MAXIMUM - RESET AT THE BEGINNING OF EACH PRIMARY LOOP
	  loop3:						;LABEL - SUB-LOOP LOOPS BACK TO HERE
	    ival	table	icount2,ifn			;READ VALUE FROM TABLE...
	    if ival<=imin then					;...IF IT IS SMALLER THAN OR EQUAL TO THE CURRENT MINIMUM VALUE... ('EQUAL TO' IS REQUIRED IN THE EVENTUALITY THAT TWO TABLE ITEMS ARE THE SAME)			
	      imin 	= 	ival				;...MAKE IT THE NEW MINIMUM
	      iloc 	= 	icount2				;REMEMBER ITS LOCATION - IF IT IS THE FINAL MINIMUM IN THIS SEARCH IT WILL HAVE TO BE SET TO A VERY HIGH VALUE SO WE DON'T FIND IT IN SUBSEQUENT SEARCHES 
	    endif
	    		loop_lt	icount2,1,iNumItems,loop3	;SUB-LOOP LOOPS BACK TO 'LOOP2BEGIN' UNTIL COUNTER REACH THE END OF THE TABLE
	  tableiw	imin,iNumItems-icount1-1,iTableBuffer	;WRITE THE MINIMUM VALUE FOUND INTO THE BUFFER TABLE
	  tableiw	imax,iloc,ifn				;SET THE MINIMUM VALUE IN THE ORIGINAL TABLE TO THE MAXIMUM VALUE SO THAT WE DON'T FIND IT AGAIN
	  		loop_lt	icount1,1,iNumItems,loop2	;LOOPING CONSTRUCTION
	;COPY BUFFER TABLE BACK INTO ORIGINAL TABLE
	icount		=		0
	loop4:
	ival		table		icount,iTableBuffer
			tableiw		ival,icount,ifn
			loop_lt		icount,1,iNumItems,loop4
endop

opcode	tab_integerise,0,i
	ifn		xin
	iNumItems	=	ftlen(ifn)			;DERIVE THE NUMBER OF ITEMS IN THE FUNCTION TABLE
	icount		=	0				;INITIALISE LOOP COUNTER
	loop:							;LABEL - LOOPING LOOPS BACK TO HERE
	ival		table	icount,ifn			;READ VALUE FROM TABLE
	ival		=	int(ival)			;INTEGERISE VALUE
			tableiw	ival,icount,ifn			;WRITE NEW VALUE INTO LOCATION OF ORIGINAL VALUE
			loop_lt	icount,1,iNumItems,loop		;LOOPING CONSTRUCTION
endop


opcode	tab_round,0,i
	ifn		xin
	iNumItems	=	ftlen(ifn)		;DERIVE THE NUMBER OF ITEMS IN THE FUNCTION TABLE
	icount		=	0			;INITIALISE LOOP COUNTER
	loop:						;LABEL - LOOPING LOOPS BACK TO HERE
	ival		table	icount,ifn		;READ VALUE FROM TABLE
	ival		=	round(ival)		;ROUND VALUES TO THE NEAREST INTEGER
			tableiw	ival,icount,ifn		;WRITE NEW VALUE INTO LOCATION OF ORIGINAL VALUE
			loop_lt	icount,1,iNumItems,loop	;LOOPING CONSTRUCTION
endop

              opcode         tabmin,ii,i	        ; UDO for deriving minimum value and its index from a table
itabnum       xin     
inumitems     =              ftlen(itabnum)             ; derive number of items in table
imin          table          0,itabnum                  ; minimum value starts as first table item
icount        init           1                          ; counter starts at 1 (we've already read item 0)
loop:                                                   ; loop 1 beginning
ival          table          icount,itabnum             ; read value from table
if ival<=imin then					; if value read from table is lower than (or equal to) current minimum...
 imin	=	ival					; ...values becomes new minimum
 indx	=	icount					; index of minimum becomes the index of this value
endif							; end of conditional branch
              loop_lt        icount,1,inumitems,loop    ; conditionally loop back
	      xout           imin,indx			; return minimum value & its index to caller instrument
              endop

	      opcode         tabmax,ii,i		; UDO for deriving maximum value and its index from a table
itabnum       xin     
inumitems     =              ftlen(itabnum)             ; derive number of items in table
imax          table          0,itabnum                  ; maximum value starts as first table items
icount        init           1                          ; counter starts at 1 (we've already read item 0)
loop:                                                   ; loop 1 beginning
ival          table          icount,itabnum             ; read value from table
if ival>=imax then					; if value read from table is higher than (or equal to) current maximum...
 imax	=	ival					; ...values becomes new maximum
 indx	=	icount					; index of maximum becomes the index of this value
endif							; end of conditional branch
              loop_lt        icount,1,inumitems,loop    ; conditionally loop back
	      xout           imax,indx			; return maximium value to caller instrument
              endop   


	      opcode         tableicopy2,0,ii		; replacement for tableicopy
idft,isft     xin     
iftlen        =              ftlen(isft)                ; derive number of items in table
icount        =              0
loop:
ival          table          icount,isft
              tableiw        ival,icount,idft           ; maximum value starts as first table items
              loop_lt        icount,1,iftlen,loop       ; conditionally loop back
              endop   





instr	RebuildTables
; igoto SKIP
 ktrig	changed	gkTabLen	; If table length is changed...
 if ktrig==1 then
  reinit REBUILD_TABLES
 endif
 REBUILD_TABLES:
 tableicopy2 giTempBuffer,giTable
 giTable		ftgen	1,0,-i(gkTabLen),-7, 0	;CHROMATIC SCALE - 12 ITEMS - NEGATIVE TABLE SIZE PERMITS THE USE OF NON-ZERO TABLE SIZE
 tableimix	giTable, 0, i(gkTabLen),  giTable, 0, 1, giTempBuffer, 0, 1	
 giUndoBuffer		ftgen	2,0,-i(gkTabLen),-7, 60, i(gkTabLen), 60+i(gkTabLen)	;CHROMATIC SCALE - 12 ITEMS - NEGATIVE TABLE SIZE PERMITS THE USE OF NON-ZERO TABLE SIZE
 giUndoBuffer2		ftgen	3,0,-i(gkTabLen),-7, 60, i(gkTabLen), 60+i(gkTabLen)	;CHROMATIC SCALE - 12 ITEMS - NEGATIVE TABLE SIZE PERMITS THE USE OF NON-ZERO TABLE SIZE
 FLsetVal_i	i(gkTabLen),gihLast
 event_i	"i", 2, 0, 0				;PRINT TABLE VALUES
endin


instr	1	;SHUFFLE TABLE CONTENTS
	prints	" Shuffle:"
	tableicopy2 giUndoBuffer2, giUndoBuffer		;SAVE BEFORE TRANSFORMATION STATE TO UNDO BUFFER TABLE
	tableicopy2 giUndoBuffer, giTable		;SAVE BEFORE TRANSFORMATION STATE TO UNDO BUFFER TABLE
		tab_shuffle	giTable			;CALL UDO
	event_i	"i", 2, 0, 0				;PRINT TABLE VALUES
endin

instr	2	;PRINT TABLE VALUES TO COMMAND LINE AND FL BOXES
	iNumItems	limit	ftlen(giTable),1,12	;DERIVE THE NUMBER OF ITEMS IN THE FUNCTION TABLE
	prints "\\n"					;NEWLINE
	icount	init	0				;INITIALISE COUNTER
	LOOPBEGIN:					;LABEL
		ival	table	icount, giTable		;READ VALUE FROM TABLE
		iModVal	=	round(ival) % 12	;MODULUS VALUE (wrapping integer in the range 0 - 11)
		Snote	strget	iModVal			;DERIVE NOTE NAME STRING FROM MODULUS VALUE
		ioct	=	int(ival/12) - 1	;DERIVE OCTAVE NUMBER
		SNoteOct	sprintf	"%s%i",Snote,ioct	;CONCATANATE NOTE NAME AND OCTAVE NUMBER AND CREATE A NEW STRING
		if ival<0 then				;IF NOTE NUMBER IS NEGATIVE...
		 SNoteOct	=	"-"		;
		endif					;
;		FLsetText SNoteOct, gihNote1+icount	;WRITE THE NOTE NAMES INTO THE FLTK PANEL				 
		printf_i "%3.3f\t%s\n" , 1,ival, SNoteOct	;PRINT NOTE NUMBER AND NOTE STRING TO THE TERMINAL FOR EACH NOTE
		FLsetVal_i	ival,gih1+icount	;WRITE THE READ VALUE INTO THE FLVALUE WIDGET
		loop_lt	icount,1,iNumItems,LOOPBEGIN	;LOOPING CONSTRUCTION


	;; FLsetText in the above loop seems unreliable. 
	;; The alternative method below using macros and unique string names for each label seems more reliable.
	#define	PRINT_NOTE_NAME_TO_GUI(N)
	#
	ival	table	$N, giTable		;READ VALUE FROM TABLE
	iModVal	=	round(ival) % 12	;MODULUS VALUE (wrapping integer in the range 0 - 11)
	Snote$N	strget	iModVal			;DERIVE NOTE NAME STRING FROM MODULUS VALUE
	ioct	=	int(ival/12) - 1	;DERIVE OCTAVE NUMBER
	SNoteOct$N	sprintf	"%s%i",Snote$N,ioct	;CONCATANATE NOTE NAME AND OCTAVE NUMBER AND CREATE A NEW STRING
	if ival<0 then				;IF NOTE NUMBER IS NEGATIVE...
	 SNoteOct$N	=	"-"		;
	endif					;
	FLsetText SNoteOct$N, gihNote1+$N	;WRITE THE NOTE NAMES INTO THE FLTK PANEL		
	#
	$PRINT_NOTE_NAME_TO_GUI(0)
	$PRINT_NOTE_NAME_TO_GUI(1)
	$PRINT_NOTE_NAME_TO_GUI(2)
	$PRINT_NOTE_NAME_TO_GUI(3)
	$PRINT_NOTE_NAME_TO_GUI(4)
	$PRINT_NOTE_NAME_TO_GUI(5)
	$PRINT_NOTE_NAME_TO_GUI(6)
	$PRINT_NOTE_NAME_TO_GUI(7)
	$PRINT_NOTE_NAME_TO_GUI(8)
	$PRINT_NOTE_NAME_TO_GUI(9)
	$PRINT_NOTE_NAME_TO_GUI(10)
	$PRINT_NOTE_NAME_TO_GUI(11)
	
	
endin

instr	3	;TRIGGER NOTES IN SOUND GENERATING INSTRUMENT
	iNumItems	=	ftlen(giTable)		;DERIVE THE NUMBER OF ITEMS IN THE FUNCTION TABLE
	igap	init	i(gkgap)			;INITIAL GAP BETWEEN PLAYED NOTES 
	iSpeedRatio	init	i(gkSpeedRatio)
	iwhen	init	0				;TIME TO PLAY INITIAL NOTE (I.E. IMMEDIATELY)
	icount	limit	i(gkFirst),1,iNumItems		;COUNTER FOR THE LOOP (AND PROTECT AGAINST OUT OF RANGE VALUES)
	iend	limit	i(gkLast),1,iNumItems		;FINAL ITEM IN SEQUENCE (AND PROTECT AGAINST OUT OF RANGE VALUES)
	iDir	=	i(gkLast)>i(gkFirst)?1:-1	;DERIVE DIRECTION (1 = FORWARDS, -1 = BACKWARDS)
	iDur	init	i(gkDur)
	LOOPBEGIN:					;A LABEL - LOOPING LOOPS BACK TO HERE
	  ipch	table	icount-1, giTable		;READ PITCH (pch FORMAT) FROM TABLE ACCORDING TO WHERE WE ARE IN THE SEQUENCE
	  if ipch<0&&i(gkSkipNeg)==1 then		;IF THIS IS A NEGHATIVE NOTE NUMBER AND 'SKIP NEGATIVES' BUTTON IS ACTIVE...
	   goto SKIP					;AND SKIP THE LINE THAT PLAYS A NOTE AND INCREMENTS THE GAP TIME
	  endif
	  if rnd(1)<i(gkRestProb) then			;IF RANDOM TEST DECIDES A REST SHOULD BE INSERTED...
	   iwhen	=	iwhen + igap		;CREATE THE TIME THE NEXT NOTE WILL BE PLAYED
	   igap	=	igap * iSpeedRatio		;GAP BETWEEN NOTES CAN CHANGE AS WE PROGRESS RESULTING IN A RALLENTANDO (SLOWING DOWN) OR ACCELERANDO (SPEEDING UP) AS THE SEQUENCE IS PLAYED
	   goto LOOPBEGIN
	  endif
	  iDur	=	iDur * iSpeedRatio
	  event_i		"i",400, iwhen, iDur, ipch	;CREATE A NOTE EVENT TO BE PLAYED BY INSTR 3
	  if  rnd(1)<i(gkDoubProb) then			;IF RANDOM TEST DECIDES A DOUBLE SPEED NOTE SHOULD BE PLAYED...
	   iwhen	=	iwhen + (igap*0.5)
	  else
	   iwhen	=	iwhen + igap			;CREATE THE TIME THE NEXT NOTE WILL BE PLAYED
	  endif
	  igap	=	igap * iSpeedRatio		;GAP BETWEEN NOTES CAN CHANGE AS WE PROGRESS RESULTING IN A RALLENTANDO (SLOWING DOWN) OR ACCELERANDO (SPEEDING UP) AS THE SEQUENCE IS PLAYED
	  SKIP:
	if iDir==1 then					;IF FORWARDS
	  	loop_le	icount,1,iend,LOOPBEGIN	;LOOPING CONSTRUCTION
	elseif iDir==-1 then				;IF BACKWARDS
	  	loop_ge	icount,1,iend,LOOPBEGIN	;LOOPING CONSTRUCTION
	endif
endin

instr	4	; Wander play (drunk walk)
 if gkWander==0 then
  turnoff
 endif
 iNumItems	=	ftlen(giTable)
 kNdx		init	0
 kgap	limit	gkgap,0.05,1
 ktrig	metro	1/kgap
 if ktrig==1 then
  krandom	random	0,1
  if krandom<gkRestProb kgoto SKIP
   knum	table	kNdx,giTable
   krandom	random	0,1
   if krandom<gkDoubProb then
    kwhen = kgap*0.5
    kdur  = gkDur*0.5
   else
    kwhen = 0
    kdur  = gkDur
   endif
	   event		"i",400, kwhen, kdur, knum	;CREATE A NOTE EVENT TO BE PLAYED BY INSTR 3
   kLoopCount	=	0
   Repeat_Try_Again:
   if kLoopCount>=100 then	; Safety against endless k-loops
    printks	"Stopped%n",0
    turnoff
   endif
   kstep	random	0,2
   kstep	=	(int(kstep) - 0.5) * 2
   kNdx	mirror	kNdx + kstep, gkFirst-1, gkLast-1
   kNewNum table	kNdx,giTable
   kLoopCount	=	kLoopCount + 1
   if ( (kNewNum<0 || kNewNum==knum) && gkSkipNeg==1 ) kgoto Repeat_Try_Again
  endif
 SKIP:
endin

instr	50	; Random pick play
 if gkPick==0 then
  turnoff
 endif
 iNumItems	=	ftlen(giTable)
 iNdx		random	i(gkFirst)-1, i(gkLast)-1	; initial choice
 kNdx		init	iNdx
 kgap	limit	gkgap,0.05,1
 ktrig	metro	1/gkgap
 if ktrig==1 then
  krandom	random	0,1
  if krandom<gkRestProb kgoto SKIP
   knum	table	kNdx,giTable
   krandom	random	0,1
   if krandom<gkDoubProb then
    kwhen = gkgap*0.5
    kdur  = gkDur*0.5
   else
    kwhen = 0
    kdur  = gkDur
   endif
	   event		"i",400, kwhen, kdur, knum	;CREATE A NOTE EVENT TO BE PLAYED BY INSTR 3
   kLoopCount	=	0
   Repeat_Try_Again:
   if kLoopCount>=100 then	; Safety against endless k-loops
    printks	"Stopped%n",0
    turnoff
   endif
   kStep	random	1, gkLast - gkFirst + 1			;step increment to next value
   kNdx		wrap	kNdx + int(kStep),gkFirst-1,gkLast	;add increment. n.b. repeated indexes not possible.
   kNewNum table	kNdx,giTable
   kLoopCount	=	kLoopCount + 1
   if ( (kNewNum<0 || kNewNum==knum) && gkSkipNeg==1 ) kgoto Repeat_Try_Again
  endif
 SKIP:
endin

instr	51	; Loop play
 if gkLoop==0 then
  turnoff
 endif
 iNumItems	=	ftlen(giTable)
 kNdx		init	0
 kgap	limit	gkgap,0.05,1
 ktrig	metro	1/gkgap
 if ktrig==1 then
  krandom	random	0,1
  if krandom<gkRestProb kgoto SKIP
   knum	table	kNdx,giTable
   krandom	random	0,1
   if krandom<gkDoubProb then
    kwhen = gkgap*0.5
    kdur  = gkDur*0.5
   else
    kwhen = 0
    kdur  = gkDur
   endif
	   event		"i",400, kwhen, kdur, knum	;CREATE A NOTE EVENT TO BE PLAYED BY INSTR 3
   kLoopCount	=	0
   Repeat_Try_Again:
   if kLoopCount>=100 then	; Safety against endless k-loops
    printks	"Stopped%n",0
    turnoff
   endif
   kNdx		wrap	kNdx+1, gkFirst-1, gkLast
   kNewNum table	kNdx,giTable
   kLoopCount	=	kLoopCount + 1
   if ( (kNewNum<0 || kNewNum==knum) && gkSkipNeg==1 ) kgoto Repeat_Try_Again
  endif
 SKIP:
endin

instr	400	;SOUND GENERATING INSTRUMENT
	if p4<0 goto SKIP
	aenv	linseg	0,0.001,i(gkgain),p3-0.001,0;CREATE AN AMPLITUDE ENVELOPE
	a1	oscili	aenv, cpsmidinn(p4), gisine	;GENERATE AN AUDIO SIGNAL (PITCH RECEIVED FROM INSTR 2 VIA p4)
		out	a1				;SEND AUDIO TO OUTPUT
	
	;**MIDI OUTPUT**  without -Q in <CsOptions> this output will go nowhere
	if i(gkMidiOut)==1 then
	 noteondur i(gkMidiChan), p4, 100, p3			
	endif
	SKIP:
endin

instr	5	;PERFORM RETROGRADE
	prints	" Retrograde:"
	tableicopy2 giUndoBuffer2, giUndoBuffer		;SAVE TWO-STEP BUFFER TABLE
	tableicopy2 giUndoBuffer, giTable		;SAVE BEFORE TRANSFORMATION STATE TO UNDO BUFFER TABLE
			tab_retrograde	giTable		;CALL UDO
			event_i		"i", 2, 0.1, 0			;PRINT TABLE VALUES
endin

instr	6	;RE-WRITE TABLE IN THE ORIGINAL ORDER
	prints	" Rewrite table to original setting:"
	tableicopy2 giUndoBuffer2, giUndoBuffer		;SAVE TWO-STEP BUFFER TABLE
	tableicopy2 giUndoBuffer, giTable		;SAVE BEFORE TRANSFORMATION STATE TO UNDO BUFFER TABLE
	iNumItems	=	ftlen(giTable)		;DERIVE THE NUMBER OF ITEMS IN THE FUNCTION TABLE
	icount		init	0			;INITIALISE LOOP COUNTER
	LOOPBEGIN:					;LABEL - LOOPING LOOPS BACK TO HERE
		tableiw	i(gkResetVal)+icount,icount,giTable	;WRITE 60+COUNTER INTO LOCATION OF TABLE CORRESPONDING TO THE COUNTER VALUE
		loop_lt	icount,1,iNumItems,LOOPBEGIN	;LOOPING CONSTRUCTION
	event_i	"i", 2, 0, 0				;PRINT TABLE VALUES
endin

instr	7	;ADD VALUE
	prints	" Add a user defined value to each table item:"
	tableicopy2 giUndoBuffer2, giUndoBuffer		;SAVE TWO-STEP BUFFER TABLE
	tableicopy2 giUndoBuffer, giTable		;SAVE BEFORE TRANSFORMATION STATE TO UNDO BUFFER TABLE
		tab_add_value	i(gkval),giTable	;CALL UDO
	event_i	"i", 2, 0, 0				;CALL INSTRUMENT THAT PRINTS TABLE VALUES
endin

instr	8	;MULTIPLY VALUE
	prints	" Multiply each table item by a user defined value:"
	tableicopy2 giUndoBuffer2, giUndoBuffer		;SAVE TWO-STEP BUFFER TABLE
	tableicopy2 giUndoBuffer, giTable		;SAVE BEFORE TRANSFORMATION STATE TO UNDO BUFFER TABLE
		tab_mult_value	i(gkval),giTable	;CALL UDO
	event_i	"i", 2, 0, 0				;CALL INSTRUMENT THAT PRINTS TABLE VALUES
endin

instr	9	;ADD RANDOM VALUE
	prints	" Add a user random value to each table item:"
	tableicopy2 giUndoBuffer2, giUndoBuffer		;SAVE TWO-STEP BUFFER TABLE
	tableicopy2 giUndoBuffer, giTable		;SAVE BEFORE TRANSFORMATION STATE TO UNDO BUFFER TABLE
		tab_add_random	i(gkval),giTable	;CALL UDO
	event_i	"i", 2, 0, 0				;CALL INSTRUMENT THAT PRINTS TABLE VALUES
endin

instr	10	;MULTIPLY BY RANDOM VALUE
	prints	" Multiply each table item by a random value:"
	tableicopy2 giUndoBuffer2, giUndoBuffer		;SAVE TWO-STEP BUFFER TABLE
	tableicopy2 giUndoBuffer, giTable		;SAVE BEFORE TRANSFORMATION STATE TO UNDO BUFFER TABLE
		tab_mult_random	i(gkval),giTable	;CALL UDO
	event_i	"i", 2, 0, 0				;CALL INSTRUMENT THAT PRINTS TABLE VALUES
endin

instr	11	;SORT INTO ASCENDING ORDER
	prints	" Sort into ascending order:"
	tableicopy2 giUndoBuffer2, giUndoBuffer		;SAVE TWO-STEP BUFFER TABLE
	tableicopy2 giUndoBuffer, giTable		;SAVE BEFORE TRANSFORMATION STATE TO UNDO BUFFER TABLE
		tabsort_ascnd	giTable				;CALL UDO
	event_i	"i", 2, 0, 0					;CALL INSTRUMENT THAT PRINT TABLE VALUES TO THE TERMINAL AND TO THE FL BOXES
endin

instr	12	;SORT INTO DESCENDING ORDER
	;THE PROCEDURE FOR SORTING TABLE ITEMS INTO DESCENDING ORDER IS ALMOST THE SAME AS FOR SORTING INTO ASCENDING ORDER.
	;THE ONLY DIFFERENCE IS THAT SORTED ITEMS ARE WRITTEN INTO THE TABLE STARTING FROM THE END AND WORKING BACKWARDS.
	prints	" Sort into descending order:"
	tableicopy2 giUndoBuffer2, giUndoBuffer		;SAVE TWO-STEP BUFFER TABLE
	tableicopy2 giUndoBuffer, giTable		;SAVE BEFORE TRANSFORMATION STATE TO UNDO BUFFER TABLE
		tabsort_dscnd	giTable			;CALL UDO
	event_i	"i", 2, 0, 0				;CALL INSTRUMENT THAT PRINT TABLE VALUES TO THE TERMINAL AND TO THE FL BOXES
endin

instr	13	;INTEGERISE VALUES
	prints	" Round values down to the nearest integer:"
	tableicopy2 giUndoBuffer2, giUndoBuffer		;SAVE TWO-STEP BUFFER TABLE
	tableicopy2 giUndoBuffer, giTable		;SAVE BEFORE TRANSFORMATION STATE TO UNDO BUFFER TABLE
		tab_integerise	giTable			;CALL UDO
	event_i	"i", 2, 0, 0				;CALL INSTRUMENT THAT PRINTS TABLE VALUES
endin

instr	14	;ROUND VALUES TO THE NEAREST INTEGER
	prints	" Round values to the nearest integer:"
	tableicopy2 giUndoBuffer2, giUndoBuffer		;SAVE TWO-STEP BUFFER TABLE
	tableicopy2 giUndoBuffer, giTable		;SAVE BEFORE TRANSFORMATION STATE TO UNDO BUFFER TABLE
		tab_round	giTable			;CALL UDO
	event_i	"i", 2, 0, 0				;CALL INSTRUMENT THAT PRINTS TABLE VALUES
endin

instr	15
	imin,indx	tabmin	giTable						;CALL UDO
		prints	"Minimum Table Value: %3.3f%tIndex: %d%N",imin,indx	;PRINT MINIMUM VALUE AND ITS INDEX TO THE TERMINAL
endin

instr	16
	imax,indx	tabmax	giTable						;CALL UDO
		prints	"Maximum Table Value: %3.3f%tIndex: %d%N",imax,indx	;PRINT MAXIMUM VALUE & ITS INDEX TO THE TERMINAL
endin

instr	17	; FLIP REPEATS TO NEGATIVE VALUES
	prints	" Flip repeats:"
	icount		=	0
	itabnum		=	giTable
	iNumItems	=	ftlen(itabnum)		; derive number of items in table
	iPrevVal	init	-1
	loop:
	ival		table	icount,itabnum
	if ival=iPrevVal then
	 tableiw	-ival,icount,itabnum
	endif
	iPrevVal	=	ival
			loop_lt	icount,1,iNumItems,loop		;LOOPING CONSTRUCTION
	event_i	"i", 2, 0, 0				;CALL INSTRUMENT THAT PRINTS TABLE VALUES
endin

instr	18	; SET ALL TO ABSOLUTE VALUES
	prints	" Set all to absolute value:"
	icount		=	0
	itabnum		=	giTable
	iNumItems	=	ftlen(itabnum)		; derive number of items in table
	loop:
	ival		table	icount,itabnum
	tableiw	abs(ival),icount,itabnum
			loop_lt	icount,1,iNumItems,loop		;LOOPING CONSTRUCTION
	event_i	"i", 2, 0, 0				;CALL INSTRUMENT THAT PRINTS TABLE VALUES
	
endin

instr	19	; FLIP RECURRENCES TO NEGATIVE
	prints	" Flip recurrences:"
	icount		=	0
	itabnum		=	giTable
	iNumItems	=	ftlen(itabnum)		; derive number of items in table
	loop:
	ival		table	icount,itabnum
	 icount2		=	icount + 1
	 loop2:
	 icompare	table	icount2,itabnum
	 if ival=icompare&&ival>=0 then
	  tableiw	-ival,icount2,itabnum
	 endif
	 loop_lt	icount2,1,iNumItems,loop2	;LOOPING CONSTRUCTION
	loop_lt	icount,1,iNumItems,loop			;LOOPING CONSTRUCTION
	event_i	"i", 2, 0, 0				;CALL INSTRUMENT THAT PRINTS TABLE VALUES
endin

instr	20	; SET ALL TO A VALUE
	prints	" Set all to a specific value:"
	tableicopy2 giUndoBuffer2, giUndoBuffer		;SAVE TWO-STEP BUFFER TABLE
	tableicopy2 giUndoBuffer, giTable		;SAVE BEFORE TRANSFORMATION STATE TO UNDO BUFFER TABLE
	icount		=	0
	iSetVal		=	i(gkResetVal)
	itabnum		=	giTable
	iNumItems	=	ftlen(itabnum)		; derive number of items in table
	loop:
	tableiw		iSetVal,icount,itabnum
			loop_lt	icount,1,iNumItems,loop		;LOOPING CONSTRUCTION
	event_i	"i", 2, 0, 0				;CALL INSTRUMENT THAT PRINTS TABLE VALUES
	
endin


instr	23	; Write values typed into boxes into table
	prints	" Write typed values to table:"
	tableicopy2 giUndoBuffer2, giUndoBuffer		;SAVE TWO-STEP BUFFER TABLE
	tableicopy2 giUndoBuffer, giTable		;SAVE BEFORE TRANSFORMATION STATE TO UNDO BUFFER TABLE
	#define WRITE_FLBOX_VAL_TO_TABLE(N)
	#
	if i(gkTabLen)<$N goto SKIP
	tableiw	i(gk$N),$N-1,giTable
	#
	$WRITE_FLBOX_VAL_TO_TABLE(1)
	$WRITE_FLBOX_VAL_TO_TABLE(2)
	$WRITE_FLBOX_VAL_TO_TABLE(3)
	$WRITE_FLBOX_VAL_TO_TABLE(4)
	$WRITE_FLBOX_VAL_TO_TABLE(5)
	$WRITE_FLBOX_VAL_TO_TABLE(6)
	$WRITE_FLBOX_VAL_TO_TABLE(7)
	$WRITE_FLBOX_VAL_TO_TABLE(8)
	$WRITE_FLBOX_VAL_TO_TABLE(9)
	$WRITE_FLBOX_VAL_TO_TABLE(10)
	$WRITE_FLBOX_VAL_TO_TABLE(11)
	$WRITE_FLBOX_VAL_TO_TABLE(12)
	SKIP:
	event_i	"i", 2, 0, 0				;CALL INSTRUMENT THAT PRINTS TABLE VALUES
endin




instr	24	;ADD BI-RANDOM VALUE
	prints	" Add a user random value (positive or negative) to each table item:"
	tableicopy2 giUndoBuffer2, giUndoBuffer		;SAVE TWO-STEP BUFFER TABLE
	tableicopy2 giUndoBuffer, giTable		;SAVE BEFORE TRANSFORMATION STATE TO UNDO BUFFER TABLE
		tab_add_bi_random	i(gkval),giTable;CALL UDO
	event_i	"i", 2, 0, 0				;CALL INSTRUMENT THAT PRINTS TABLE VALUES
endin

instr	25	; INVERT ABOUT VALUE
	prints	" Invert:"
	icount		=	0
	itabnum		=	giTable
	iNumItems	=	ftlen(itabnum)		; derive number of items in table
	loop:
	 ival		table	icount,itabnum
	 tableiw	(i(gkval)*2) - ival,icount,itabnum
	loop_lt	icount,1,iNumItems,loop			;LOOPING CONSTRUCTION
	event_i	"i", 2, 0, 0				;CALL INSTRUMENT THAT PRINTS TABLE VALUES
endin




instr	32	; add random distribution
	prints	" Add random distribution to table:"
	tableicopy2 giUndoBuffer2, giUndoBuffer		;SAVE TWO-STEP BUFFER TABLE
	tableicopy2 giUndoBuffer, giTable		;SAVE BEFORE TRANSFORMATION STATE TO UNDO BUFFER TABLE
	itabnum		=	giTable
	iNumItems	=	ftlen(itabnum)		; derive number of items in table
	iLevel		=	i(gkval)
	iarg1		=	i(gkarg1)
	iarg2		=	i(gkarg2)
	itype		=	p4
	iNseTab		ftgentmp	0,0,-iNumItems,-21,itype,iLevel,iarg1,iarg2
	
	tableimix itabnum, 0, iNumItems,  itabnum, 0, 1, iNseTab, 0, 1
	
	event_i	"i", 2, 0, 0				;CALL INSTRUMENT THAT PRINTS TABLE VALUES
endin


instr	999	; undo
	tableicopy2 giTable, giUndoBuffer
	event_i	"i", 2, 0, 0				;CALL INSTRUMENT THAT PRINTS TABLE VALUES
endin

instr	1000	; undo 2
	tableicopy2 giTable, giUndoBuffer2
	event_i	"i", 2, 0, 0				;CALL INSTRUMENT THAT PRINTS TABLE VALUES
endin


</CsInstruments>

<CsScore>
i "RebuildTables" 0 36000		;
i 2 0 0		;PRINT TABLE ITEMS TO CONSOLE AND FL BOXES AT THE BEGINNING OF PERFORMANCE
f 0 36000	;DUMMY SCORE EVENT KEEPS PERFORMANCE GOING
</CsScore>

</CsoundSynthesizer>
