DrunkWalk.csd
Written by Iain McCurdy, 2008

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 	= 	44100  
ksmps 	= 	8
nchnls 	= 	2
0dbfs	=	1
	seed	0

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
		FLpanel	"Drunk Walk", 500, 215, 0, 0

;                                             		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | I | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    100,     25,    5,  5,   0,      1,     0,      3600
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;TEXT BOXES						ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	"", 			6,       5,    11,    260,      66,   115,   3

;GENERAL_TEXT_SETTINGS			SIZE | FONT | ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,     1,    255,   255,    255	;LABELS MADE INVISIBLE

;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkBoundary, gihBoundary	FLbutBank	14,     1,     3,     10,     50,    250, 10,     -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT | ALIGN | RED | GREEN | BLUE
			FLlabel		13,      5,      3,   0,      0,     0		;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Boundary Rule", 	1,       2,    12,    130,     35,   120, 17
ih		 	FLbox  	"None      ", 		1,       5,    11,     75,     25,   274,  5
ih		 	FLbox  	"Bounce    ", 		1,       5,    11,     75,     25,   274, 22
ih		 	FLbox  	"No Repeats", 		1,       5,    11,     75,     25,   274, 39

;							MIN   | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkstep, gihstep		FLtext		"Step", 	-1000, 1000,    1,    1,     50,     20,     5,   125
gkindex, gihindex	FLtext		"Index", 	-1000, 1000,    1,    1,     50,     20,    55,   125

;					            	MIN  | MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gk, gihindex2		FLslider 	"Index",	0,     15,    0,     3,    -1,    380,     20,   110,125

;VALUE DISPLAY BOXES					WIDTH | HEIGHT | X |  Y
idTrigFreq			FLvalue	" ",     	60,       20,    5,  100
idoutgain			FLvalue	" ",     	60,       20,    5,  190

;								MIN  |   MAX | EXP | TYPE |    DISP   | WIDTH | HEIGHT | X | Y
gkTrigFreq, ihTrigFreq	FLslider 	"Speed of Walk (Hz.)",	0.1,      20,   0,    23,  idTrigFreq,   490,     25,    5, 75
gkoutgain, ihoutgain	FLslider 	"Output Gain",		0,         1,   0,    23,  idoutgain,    490,     25,    5,165

		FLsetVal_i	2, 	ihTrigFreq
		FLsetVal_i	0.5, 	ihoutgain

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 520, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                         Drunk Walk                          ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"The Drunk Walk is a common concept of data generation in     ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"algorithmic composition. The metaphor is of a drunk person   ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"walking home - the person does not walk forward in a straight", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"line, instead randomly taking a step either to the left or to", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"the right.                                                   ", 	1,      5,     14,    490,    15,     5, 120
ih	  	 	FLbox  	"In this example this concept is applied to the generation of ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"note data. Data for two octaves of a pentatonic scale is     ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"stored in a GEN 2 function table. A metronome rhythmically   ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"triggers notes. Each time a new note is triggered a random   ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"choice is made to either take a step up or down this         ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"sequence.                                                    ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"Whenever the walk attempts to cross the upper or lower       ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"boundary one of three responses is taken depending on which  ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"'Boundary Rule' has been chosen by the user:                 ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"If 'None' has been chosen the boundary limit value is        ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"repeated.                                                    ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"If 'Bounce' has been chosen the walker 'bounces' off the     ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"boundary and a step is taken in the opposite direction.      ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"If 'No Repeats' has been chosen the walker holds the boundary", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"limit location but does not play a note.                     ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"Valuator boxes indicate for the user whether the walker is   ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"taking a step up or down the scale and where the walker is   ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"within the scale (index). The index value will range from    ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"zero to 10.                                                  ", 	1,      5,     14,    490,    15,     5, 500

				FLpanel_end

		FLrun		;RUN THE WIDGET THREAD!

;INITIAL INDEX VALUE (FROM WHERE IN THE giscale TABLE WE WILL BEGIN READING FROM)
giindex	init	5

;TABLE STORING PCH VALUES USED IN THE DRUNK WALK
;                                           0    1    2    3    4    5    6    7    8    9    10   11   12   13   14   15
giscale		ftgen		0,0,16  ,-2,6.00,6.03,6.05,6.07,6.10,7.00,7.03,7.05,7.07,7.10,8.00,8.03,8.05,8.07,8.10,9.00


instr	1	;NOTE TRIGGERING INSTRUMENT
	if	gkOnOff=0	then		;IF FLTK ON/OFF BUTTON IS OFF...
		turnoff				;TURNOFF THIS INSTRUMENT IMMEDIATELY
	endif					;END OF CONDITIONAL BRANCHING
	ktrigger	metro	gkTrigFreq	;CREATE A METRONOME OF MOMENTARY '1's
	
	;		 		TRIGGER | MINTIM | MAXNUM | INSNUM | WHEN | KDUR
			schedkwhen 	ktrigger,   0,        0,     p1+1,    0,    0.01	;TRIGGER NEXT INSTRUMENT METRONOMICALLY
endin

instr	2	;PROCESS DRUNK WALK
	istep	random	0, 2					;STEP VALUE SET TO RANDOM FLOAT BETWEEN 0 AND 2
	istep	=	(int(istep)*2)-1			;istep WILL BE EITHER 1 OR -1
	iindex	=	giindex + istep				;ADD RANDOM VALUE TO OLD INDEX VALUE

	if	i(gkBoundary)==0	then
		iindex	limit	iindex,0,ftlen(giscale)-1	;LIMIT INDEX VALUE WITHIN TABLE LIMITS	
	elseif	i(gkBoundary)==1	then			;IF BOUNDARY MODE IS SET TO 'BOUNCE'
		if	iindex<0	then                    ;IF INDEX PUSHES BELOW BOUNDARY...
			iindex=1                                ;...SET TO ONE ABOVE MINIMUM
		elseif	iindex>ftlen(giscale)-1	then            ;IF INDEX PUSHES BEYOND BOUNDARY...
			iindex=ftlen(giscale)-2                 ;...BOUNCE TO ONE BELOW BOUNDARY
		endif                                           ;END OF CONDITIONAL BRANCHING
	elseif	i(gkBoundary)==2	then			;IF 'NO REPEATS' CHOSEN
		iindex	limit	iindex,0,ftlen(giscale)-1	;LIMIT INDEX VALUE WITHIN TABLE LIMITS	
		if iindex==giindex then
			goto	end
		endif
	endif		
		turnoff2	3, 1, 1				;TURNOFF 'OLD' NOTE TO PREVENT POLYPHONY 
	;                      i   strt   dur p4      p5  
		event_i	"i", p1+1, 0.001,  8, giindex,istep	;PLAY A NOTE USING NEXT INSTRUMENT
	end:
		giindex	=	iindex				;GLOBAL INDEX (USED AS THE 'OLD' INDEX VALUE FOR COMPARISON IN NEXT PERFORMANCE PASS)
		turnoff
endin

instr	3
		FLsetVal_i	p5, gihstep				;WRITE STEP VALUE TO FL TEXT BOX
		FLsetVal_i	p4, gihindex				;WRITE INDEX VALUE TO FL TEXT BOX
		FLsetVal_i	p4, gihindex2				;WRITE INDEX VALUE TO FL TEXT BOX
	ipch	table	p4, giscale					;READ PCH VALUE FROM TABLE USING INDEX
	aenv	linsegr	0, 0.005, 1, p3-0.105, 1, 0.1, 0		;AMPLITUDE ENVELOP WITH RELEASE STAGE
	iplk	random	0.1,0.3						;SLIGHTLY RANDOMIZE PLUCK POSITION
	asig 	wgpluck2    	0.98, 1, cpspch(ipch), iplk, 0.6        ;PLUCKED STRING PHYSICAL MODEL
	asig	=	asig  * aenv * gkoutgain			;SCALE AUDIO SIGNAL USING AMPLITUDE ENVELOPE AND OUTPUT GAIN SLIDER
		outs	asig, asig					;SEND AUDIO TO OUTPUTS
endin
	
</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT
</CsScore>

</CsoundSynthesizer>