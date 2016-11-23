GEN01.csd
Written by Iain McCurdy, 2012

<CsoundSynthesizer>

<CsOptions>
-odac --displays
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (1=MONO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

/*///////////////////////////////////////////////////////// FLTK INTERFACE CODE ///////////////////////////////////////////////////////*/
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;			LABEL   | WIDTH | HEIGHT | X | Y
		FLpanel	"GEN01",   500,    225,    0,  0
;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR | p4
gkOnOff1,ihOnOff1		FLbutton	"1 @>",		1,    0,    22,     80,     25,   75, 12,     -1;0,     1,      0,       -1
FLsetColor2	0,200,0, ihOnOff1		;SET SECONDARY COLOUR TO GREEN
FLsetTextColor	0,200,0,ihOnOff1            
gkOnOff2,ihOnOff2		FLbutton	"2 @>",		1,    0,    22,     80,     25,  160, 12,     -1;0,     2,      0,       -1
FLsetColor2	0,200,0, ihOnOff2		;SET SECONDARY COLOUR TO GREEN
FLsetTextColor	0,200,0,ihOnOff2                                                 
gkOnOff3,ihOnOff3		FLbutton	"3 @>",		1,    0,    22,     80,     25,  245, 12,     -1;0,     3,      0,       -1
FLsetColor2	0,200,0, ihOnOff3		;SET SECONDARY COLOUR TO GREEN
FLsetTextColor	0,200,0,ihOnOff3
gkOnOff4,ihOnOff4		FLbutton	"4 @>",		1,    0,    22,     80,     25,  330, 12,     -1;0,     4,      0,       -1
FLsetColor2	0,200,0, ihOnOff4		;SET SECONDARY COLOUR TO GREEN
FLsetTextColor	0,200,0,ihOnOff4
gknudgeinskip,ihnudge		FLbutton	"< nudge",		-1,  -1,    21,     70,     20,  350, 75,     -1;0,     99,      0,       0
gknudgeinskip,ihnudge		FLbutton	"nudge >",		1,    1,    21,     70,     20,  420, 75,     -1;0,     99,      0,       0
gknudgetabsize,ihnudge		FLbutton	"< nudge",		-1,  -1,    21,     70,     20,  350,125,     -1;0,    100,      0,       -1
gknudgetabsize,ihnudge		FLbutton	"nudge >",		1,    1,    21,     70,     20,  420,125,     -1;0,    100,      0,       -1
    
;NUMBER DISPLAY BOXES			WIDTH | HEIGHT | X | Y
;idinskip		FLvalue	" ",	80,      20,     5,  75
idtabsize		FLvalue	" ",	80,      20,     5, 125

;SLIDERS					      		MIN |  MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X  | Y
gkinskip, gihinskip		FLslider	"Inskip (1, 2, 3 & 4)",  	0,      1,    0,    23,        -1,   490,     25,    5,   50
gktabsize, gihtabsize		FLslider	"Table Size (4 only)",  	0,      1,    0,    23,  idtabsize,  490,     25,    5,  100

;VALUE INPUT BOXES				 		MIN |     MAX    | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkinskip2, gihinskip2		FLtext		"", 		0,    9999999999,    0,     1,    100,     20,    5,   75
gktabsize2, gihtabsize2		FLtext		"", 		0,    9999999999,    0,     1,    100,     20,    5,  125

;MAKE FL LABELS A LITTLE BIT SMALLER
FLlabel 13, 1, 0, 0, 0, 0
;TEXT BOXES							TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"post-normalised (GEN=1)", 	1,      5,     12,    170,    20,     0, 160
;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR | p4
gkfragtrig,ih		FLbutton	"Fragment 1",		0,    0,    21,     80,     25,  170,160,     -1;0,     5,      0,        0,   0
gkfragtrig,ih		FLbutton	"Fragment 2",		1,    0,    21,     80,     25,  250,160,     -1;0,     5,      0,        0,   1
gkfragtrig,ih		FLbutton	"Fragment 3",		2,    0,    21,     80,     25,  330,160,     -1;0,     5,      0,        0,   2
gkfragtrig,ih		FLbutton	"Fragment 4",		3,    0,    21,     80,     25,  410,160,     -1;0,     5,      0,        0,   3
ih		 	FLbox  	"un-normalised (GEN=-1)", 	1,      5,     12,    170,    20,     0, 185
gkfragtrig,ih		FLbutton	"Fragment 1",		4,    0,    21,     80,     25,  170,185,     -1;0,     5,      0,        0,   4
gkfragtrig,ih		FLbutton	"Fragment 2",		5,    0,    21,     80,     25,  250,185,     -1;0,     5,      0,        0,   5
gkfragtrig,ih		FLbutton	"Fragment 3",		6,    0,    21,     80,     25,  330,185,     -1;0,     5,      0,        0,   6
gkfragtrig,ih		FLbutton	"Fragment 4",		7,    0,    21,     80,     25,  410,185,     -1;0,     5,      0,        0,   7

;INITIALISATION OF SLIDERS	VALUE | HANDLE
		FLsetVal_i	0, 	gihinskip
		FLsetVal_i	1, 	gihtabsize
		FLpanel_end	;END OF PANEL CONTENTS

			FLpanel	" ", 515, 700, 512, 0
			FLscroll     515, 700, 0,   0

;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                            GEN01                            ", 	1,      6,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      6,     14,    490,    20,     5,  20
ih		 	FLbox  	"quick instructions:                                          ", 	1,      8,     14,    490,    20,     5,  40
ih		 	FLbox  	"'1' starts and stops a mono GEN01 function table of deferred ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"size (size=0) played in a loop using the 'flooper' opcode.   ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"'2' starts and stops a stereo GEN01 function table of        ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"deferred size played once using 'loscil3'.                   ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"'3' starts and stops a 'sndwarp' instrument that reads from a", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"stereo GEN01 function table. sndwarp will not accept deferred", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"size function tables so this time size is specified          ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"explicitly, (size=1048576).                                  ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"'4' starts and stops a mono function table played back by    ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"flooper. This time non-power of two function table sizes are ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"specified by giving size preceded by a minus sign '-'. This  ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"allows 'Table Size' to be modulated using the FLTK slider so ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"that sizes can be specifed that don't correspond to the size ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"of the source sound file.                                    ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"'Fragment 1' to 'Fragment 4' trigger individual drum sounds  ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"selected from a drum loop by careful setting of table size   ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"and inskip.                                                  ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"slow instructions:                                           ", 	1,      8,     14,    490,    20,     5, 400 
ih		 	FLbox  	"GEN01 is used for the storage of sound files in RAM for the  ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"use opcodes that require random access to them and is        ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"probably one of the first function tables that the new Csound", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"user will encounter. This example and description aim to draw", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"attention to some of the subtler details of working with this", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"GEN routine.                                                 ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"As with most function table GEN routines, GEN01 is normally  ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"placed in the score (as an 'f' statement) or in the orchestra", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"(using the 'ftgen' opcode). This example places most of the  ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"function table creation within instruments (using the        ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"'ftgentmp' opcode) in order to allow tables to be changed    ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"during performance and their displays to be updated. This    ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"should not be adopted as normal practice and is for          ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"demonstration only. Select the appropriate function table    ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"from the drop-down menu in the displays window to view the   ", 	1,      5,     14,    490,    20,     5, 700 
ih		 	FLbox  	"results of changes made to that function table.              ", 	1,      5,     14,    490,    20,     5, 720 
ih		 	FLbox  	"The structure for GEN01 is:                                  ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"f#  time  size  1  filcod  skiptime  format  channel         ", 	1,      6,     14,    490,    20,     5, 760
ih		 	FLbox  	"'time' is the time into the performance at which to create   ", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"the table (normally zero), 'size' is the size of the table   ", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"(in table points/number of samples), next value given is the ", 	1,      5,     14,    490,    20,     5, 820
ih		 	FLbox  	"GEN routine number, 'filcod' is the path to the sound file as", 	1,      5,     14,    490,    20,     5, 840
ih		 	FLbox  	"a string, 'skiptime' is the time in seconds at which to begin", 	1,      5,     14,    490,    20,     5, 860
ih		 	FLbox  	"reading from the sound file, 'format' is a number which      ", 	1,      5,     14,    490,    20,     5, 880
ih		 	FLbox  	"specifies the sample format of the sound file and 'channel'  ", 	1,      5,     14,    490,    20,     5, 900
ih		 	FLbox  	"defines which channel or channels to read from a multi-      ", 	1,      5,     14,    490,    20,     5, 920
ih		 	FLbox  	"-channel sound file.                                         ", 	1,      5,     14,    490,    20,     5, 940
ih		 	FLbox  	"Table size relates to the duration of audio that a GEN01     ", 	1,      5,     14,    490,    20,     5, 960
ih		 	FLbox  	"table can store. In the past 'size' would always have to be a", 	1,      5,     14,    490,    20,     5, 980
ih		 	FLbox  	"power of two (or a power of two +1). This would mean, for    ", 	1,      5,     14,    490,    20,     5,1000
ih		 	FLbox  	"example, that a sound file of 1 second's duration at a       ", 	1,      5,     14,    490,    20,     5,1020
ih		 	FLbox  	"sample rate of 44100 would require a table size of the next  ", 	1,      5,     14,    490,    20,     5,1040
ih		 	FLbox  	"power of two greater than 44100 (i.e. 65536). Note that if   ", 	1,      5,     14,    490,    20,     5,1060
ih		 	FLbox  	"this method is used the actual duration of the sound file    ", 	1,      5,     14,    490,    20,     5,1080
ih		 	FLbox  	"contained within can still be derived by using the nsamp(fn) ", 	1,      5,     14,    490,    20,     5,1100
ih		 	FLbox  	"function. If you are not sure of what power of two to use you", 	1,      5,     14,    490,    20,     5,1120
ih		 	FLbox  	"can always use the lazy approach and underestimate the table ", 	1,      5,     14,    490,    20,     5,1140
ih		 	FLbox  	"size, run the orchestra at which point Csound will warn and  ", 	1,      5,     14,    490,    20,     5,1160
ih		 	FLbox  	"advise you about what table size is required, then substitute", 	1,      5,     14,    490,    20,     5,1180
ih		 	FLbox  	"in this recommended table size. Table sizes can be           ", 	1,      5,     14,    490,    20,     5,1200
ih		 	FLbox  	"overestimated but this wastes RAM as you will ultimately be  ", 	1,      5,     14,    490,    20,     5,1220
ih		 	FLbox  	"storing large chunks of silence. Button 3 triggers a sndwarp ", 	1,      5,     14,    490,    20,     5,1240
ih		 	FLbox  	"instrument that needs a function table with a power of 2     ", 	1,      5,     14,    490,    20,     5,1260
ih		 	FLbox  	"table size. The 'table..' opcodes also require power of 2    ", 	1,      5,     14,    490,    20,     5,1280
ih		 	FLbox  	"table sizes.                                                 ", 	1,      5,     14,    490,    20,     5,1300
ih		 	FLbox  	"For opcodes that don't demand a power of 2 table size we can ", 	1,      5,     14,    490,    20,     5,1320
ih		 	FLbox  	"use a deferred size allocation instruction - give size as    ", 	1,      5,     14,    490,    20,     5,1340
ih		 	FLbox  	"zero - in which case Csound will assign the exact table size ", 	1,      5,     14,    490,    20,     5,1360
ih		 	FLbox  	"required to contain the given sound file. Buttons 1 and 2    ", 	1,      5,     14,    490,    20,     5,1380
ih		 	FLbox  	"trigger instruments that use the flooper and loscil3 opcodes ", 	1,      5,     14,    490,    20,     5,1400
ih		 	FLbox  	"that read from deferred size GEN01 function tables.          ", 	1,      5,     14,    490,    20,     5,1420
ih		 	FLbox  	"We can also prescribe  a non-power-of-two table size by      ", 	1,      5,     14,    490,    20,     5,1440
ih		 	FLbox  	"preceding a size value with a minus sign. Button 4 triggers  ", 	1,      5,     14,    490,    20,     5,1460
ih		 	FLbox  	"an instrument that uses a table size with a negative table   ", 	1,      5,     14,    490,    20,     5,1480
ih		 	FLbox  	"size which thus permits table size to be modulated using an  ", 	1,      5,     14,    490,    20,     5,1500
ih		 	FLbox  	"FLTK slider.                                                 ", 	1,      5,     14,    490,    20,     5,1520
ih		 	FLbox  	"If GEN number is given as '1', sounds stored within these    ", 	1,      5,     14,    490,    20,     5,1540
ih		 	FLbox  	"function tables will be post-normalised, which means they    ", 	1,      5,     14,    490,    20,     5,1560
ih		 	FLbox  	"will be amplified to fill the available dynamic range of     ", 	1,      5,     14,    490,    20,     5,1580
ih		 	FLbox  	"the table. This can be useful if you want to balance the     ", 	1,      5,     14,    490,    20,     5,1600
ih		 	FLbox  	"amplitudes of different sound files. If you prefer to retain ", 	1,      5,     14,    490,    20,     5,1620
ih		 	FLbox  	"dynamic relationships between different sound files then     ", 	1,      5,     14,    490,    20,     5,1640
ih		 	FLbox  	"disable post-normalisation by giving GEN number as '-1'.     ", 	1,      5,     14,    490,    20,     5,1660
ih		 	FLbox  	"The same four sound file fragments are presented as either   ", 	1,      5,     14,    490,    20,     5,1680
ih		 	FLbox  	"post-normalised (top row) or un-normalised (bottom row) as a ", 	1,      5,     14,    490,    20,     5,1700
ih		 	FLbox  	"aural demonstration of this feature. Note that function      ", 	1,      5,     14,    490,    20,     5,1720
ih		 	FLbox  	"tables are always displayed normalised.                      ", 	1,      5,     14,    490,    20,     5,1740
ih		 	FLbox  	"The 'filcod' should be a directory path pointing to the      ", 	1,      5,     14,    490,    20,     5,1760
ih		 	FLbox  	"sound file. If the complete path is not given then Csound    ", 	1,      5,     14,    490,    20,     5,1780
ih		 	FLbox  	"will look for the named sound file in the present working    ", 	1,      5,     14,    490,    20,     5,1800
ih		 	FLbox  	"directory or the drectory specified as SSDIR.                ", 	1,      5,     14,    490,    20,     5,1820
ih		 	FLbox  	"Format can be used to explicitly tell Csound what format of  ", 	1,      5,     14,    490,    20,     5,1840
ih		 	FLbox  	"samples are contained within the sound file. For a full      ", 	1,      5,     14,    490,    20,     5,1860
ih		 	FLbox  	"description of the different types that can be specified here", 	1,      5,     14,    490,    20,     5,1880
ih		 	FLbox  	"refer to the Csound Reference Manual. Normally we can just   ", 	1,      5,     14,    490,    20,     5,1900
ih		 	FLbox  	"allow Csound to deduce the sample format from the sound file ", 	1,      5,     14,    490,    20,     5,1920
ih		 	FLbox  	"header by giving a value of zero here.                       ", 	1,      5,     14,    490,    20,     5,1940
ih		 	FLbox  	"Channel numbers from which to read are given as '1' for the  ", 	1,      5,     14,    490,    20,     5,1960
ih		 	FLbox  	"first channel (or left channel in a stereo file). '2' for the", 	1,      5,     14,    490,    20,     5,1980
ih		 	FLbox  	"second (right) channel and so on. A value of zero here will  ", 	1,      5,     14,    490,    20,     5,2000
ih		 	FLbox  	"instruct Csound to read all channels (if a multi-channel     ", 	1,      5,     14,    490,    20,     5,2020
ih		 	FLbox  	"file) and create a function table with interleaved audio     ", 	1,      5,     14,    490,    20,     5,2040
ih		 	FLbox  	"data. Note that a stereo sound file will required twice the  ", 	1,      5,     14,    490,    20,     5,2060
ih		 	FLbox  	"storage space of a mono sound file of the same duration. Care", 	1,      5,     14,    490,    20,     5,2080
ih		 	FLbox  	"should also be taken that mono opcodes read from mono tables,", 	1,      5,     14,    490,    20,     5,2100
ih		 	FLbox  	"stereo opcodes read from stereo tables and so on.            ", 	1,      5,     14,    490,    20,     5,2120
			FLscroll_end
			FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD

/*////////////////////////////////////////////// END OF FLTK INTERFACE CODE ///////////////////////////////////////////////////////////*/

;POST NORMALISED SOUND FILE FRAGMENTS (GEN=1)
gifragment1	ftgen	0,0,-5155,1,"loop.wav",0.399296,0,0
gifragment2	ftgen	0,0,-5827,1,"loop.wav",0.92351,0,0
gifragment3	ftgen	0,0,-5454,1,"loop.wav",1.85305,0,0
gifragment4	ftgen	0,0,-5492,1,"loop.wav",1.98725,0,0
;UN NORMALISED SOUND FILE FRAGMENTS (GEN=-1)
gifragment1b	ftgen	0,0,-5155,-1,"loop.wav",0.399296,0,0
gifragment2b	ftgen	0,0,-5827,-1,"loop.wav",0.92351,0,0
gifragment3b	ftgen	0,0,-5454,-1,"loop.wav",1.85305,0,0
gifragment4b	ftgen	0,0,-5492,-1,"loop.wav",1.98725,0,0


instr	StartStopInstrs
#define	StartHeld(N) #ktrig$N	changed	gkOnOff$N
	ktrig$N	changed	gkOnOff$N
	if ktrig$N==1 then
	 event	"i",$N,0,-1
	endif#
	$StartHeld(1)
	$StartHeld(2)
	$StartHeld(3)
	$StartHeld(4)
	ktrig	changed	gknudgeinskip
	if ktrig==1&&gknudgeinskip!=0 then
	 event	"i",99,0,0
	 gknudgeinskip=0
	endif
	ktrig	changed	gknudgetabsize
	if ktrig==1&&gknudgetabsize!=0 then
	 event	"i",100,0,-1
	 gknudgetabsize=0
	endif
	ktrig	changed	gkfragtrig
	if ktrig==1&&gkfragtrig!=-1 then
	 event	"i",5,0,0,gkfragtrig
	 gkfragtrig=-1
	endif
endin

instr	1	;FLOOPER WILL WORK WITH DEFERRED TABLE SIZES (SIZE=0)
	if gkOnOff1==0 then	;IF FIRST ON/OFF SWITCH IS OFF...
	 turnoff		;TURN THIS INSTRUMENT OFF
	endif
	ktrig	changed	       gkinskip	;IF ANY OF THE PARAMETERS FOR THE CREATION OF THE AMPLITUDE ENVELOPE HAVE CHANGED GENERATE A MOMENTARY '1' AT THE OUTPUT IN VARIABLE ktrig1
	Sfile	=	"AndItsAll.wav"	;FILE NAME CREATED AS A STRING VARIABLE
	isecs	filelen	Sfile
	if ktrig=1 then		;IF A VARIABLE USED FOR THE CREATION OF AMPLITUDE ENVELOPE HAS BEEN CHANGED...
	 reinit UPDATE		;...BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE1'
	 UPDATE:		;LABEL CALLED 'UPDATE1'. REINITIALISATION OF AMPLITUDE ENVELOPE BEGINS HERE
	 iinskip	limit	isecs*i(gkinskip),0,isecs-(1/sr)
	 FLsetVal_i	iinskip,gihinskip2
	 ifile		ftgentmp	1,0,0,1,Sfile,iinskip,0,1
	endif		;END OF CONDITIONAL BRANCH
	isamps	=	ftlen(ifile)
	FLsetVal_i	isamps,gihtabsize2
	idur	=	isamps/sr
	asig		flooper 1, 1, 0, idur, 0, ifile
		outs	asig,asig
endin

instr	2	;loscil 3 WILL WORK WITH STEREO TABLES AND DEFERRED SIZE (SIZE=0)
	if gkOnOff2==0 then	;IF SECOND ON/OFF SWITCH IS OFF...
	 turnoff                ;TURN THIS INSTRUMENT OFF
	endif
	ktrig	changed	       gkinskip	;IF ANY OF THE PARAMETERS FOR THE CREATION OF THE AMPLITUDE ENVELOPE HAVE CHANGED GENERATE A MOMENTARY '1' AT THE OUTPUT IN VARIABLE ktrig1
	Sfile	=	"ClassicalGuitar.wav"	;FILE NAME CREATED AS A STRING VARIABLE
	isecs	filelen	Sfile
	if ktrig=1 then		;IF A VARIABLE USED FOR THE CREATION OF AMPLITUDE ENVELOPE HAS BEEN CHANGED...
	 reinit UPDATE		;...BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE1'
	 UPDATE:		;LABEL CALLED 'UPDATE1'. REINITIALISATION OF AMPLITUDE ENVELOPE BEGINS HERE
	 iinskip	limit	isecs*i(gkinskip),0,isecs-(1/sr)
	 FLsetVal_i	iinskip,gihinskip2
	 ifile		ftgentmp	2,0,0,1,Sfile,iinskip,0,0
	endif		;END OF CONDITIONAL BRANCH
	isamps	=	ftlen(ifile)
	FLsetVal_i	isamps,gihtabsize2
	idur	=	isamps/sr
	a1,a2	loscil3 1, 1, ifile, 1
		outs	a1,a2
endin

instr	3	;sndwarp - REQUIRES A POWER OF 2 FUNCTION TABLE SIZE: '0'/DEFERRED SIZE NOT PERMITTED
	if gkOnOff3==0 then	;IF THIRD ON/OFF SWITCH IS OFF...
	 turnoff                ;TURN THIS INSTRUMENT OFF
	endif
	iwindow	ftgentmp	0,0,131072,9,0.5,1,0
	ktrig	changed	       gkinskip	;IF ANY OF THE PARAMETERS FOR THE CREATION OF THE AMPLITUDE ENVELOPE HAVE CHANGED GENERATE A MOMENTARY '1' AT THE OUTPUT IN VARIABLE ktrig1
	Sfile	=	"ClassicalGuitar.wav"	;FILE NAME CREATED AS A STRING VARIABLE
	isecs	filelen	Sfile
	if ktrig=1 then		;IF A VARIABLE USED FOR THE CREATION OF AMPLITUDE ENVELOPE HAS BEEN CHANGED...
	 reinit UPDATE		;...BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE1'
	 UPDATE:		;LABEL CALLED 'UPDATE1'. REINITIALISATION OF AMPLITUDE ENVELOPE BEGINS HERE
	 iinskip	limit	isecs*i(gkinskip),0,isecs-(1/sr)
	 FLsetVal_i	iinskip,gihinskip2
	 ifile		ftgentmp	3,0,1048576,1,Sfile,iinskip,0,0
	 FLsetVal_i	ftlen(ifile),gihtabsize2
	endif		;END OF CONDITIONAL BRANCH	
	a1,a2	sndwarpst	0.2, 2, 1,ifile,0, 4000, 10000, 16, iwindow, 0
		outs	a1,a2
endin

instr	4	;BOTH INSKIP AND FUNCTION TABLE SIZE ARE MANIPULATED
	if gkOnOff4==0 then		;IF FOURTH ON/OFF SWITCH IS OFF...
	 turnoff                	;TURN THIS INSTRUMENT OFF
	endif
	ktrig	changed	       gkinskip,gktabsize	;IF ANY OF THE PARAMETERS FOR THE CREATION OF THE AMPLITUDE ENVELOPE HAVE CHANGED GENERATE A MOMENTARY '1' AT THE OUTPUT IN VARIABLE ktrig1
	Sfile	=	"loop.wav"
	isecs	filelen	Sfile
	if ktrig=1 then		;IF A VARIABLE USED FOR THE CREATION OF AMPLITUDE ENVELOPE HAS BEEN CHANGED...
	 reinit UPDATE		;...BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE1'
	 UPDATE:		;LABEL CALLED 'UPDATE1'. REINITIALISATION OF AMPLITUDE ENVELOPE BEGINS HERE
	 iinskip	limit	isecs*i(gkinskip),0,isecs-(1/sr)
	 FLsetVal_i	iinskip,gihinskip2
	 itabsize	limit	isecs*i(gktabsize)*sr,1,isecs*sr
	 FLsetVal_i	int(itabsize),gihtabsize2
	 ifile		ftgentmp	4,0,-itabsize,1,Sfile,iinskip,0,0
	endif		;END OF CONDITIONAL BRANCH	
	isamps	=	ftlen(ifile)
	idur	=	isamps/sr
	asig		flooper 0.5, 1, 0, idur, 0, ifile
		outs	asig,asig
endin

instr	5	;PLAY FRAGMENT
	ifile	=	gifragment1+p4
	p3	=	ftlen(ifile)/sr
	aenv	linseg	1,p3-0.02,1,0.02,0
	a1	loscil3 0.5*aenv, 1, ifile, 1
		outs	a1,a1
endin

instr	99	;NUDGE INSKIP
	FLsetVal_i	i(gkinskip)+(i(gknudgeinskip)*0.0001),gihinskip
endin

instr	100	;NUDGE TABLE LENGTH
	ilen		filelen	"loop.wav"
	isamps		=	int(ilen*sr)
	FLsetVal_i	i(gktabsize)+( (i(gknudgetabsize)*10) /isamps),gihtabsize	
endin

</CsInstruments>

<CsScore>
i "StartStopInstrs" 0 3600
f 0 3600
</CsScore>

</CsoundSynthesizer>