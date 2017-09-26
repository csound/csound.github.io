ftsave_ftload.csd
Written by Iain McCurdy, 2008

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 	= 	44100  
ksmps 	= 	1
nchnls 	= 	2
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 150, 150, 150
FLpanel	"ftsave, ftload", 300, 60, 0, 0
;                                             		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | I | STARTTIM | IDUR |  p4
gkSave,ihSave	FLbutton	"Save",			1,    0,     1,     50,     20,    0,  0,   0,      1,     0,       .01
gkLoad,ihLoad	FLbutton	"Load",			1,    0,     1,     50,     20,   50,  0,   0,      2,     0,       .01
FLsetColor	255,100,100,ihSave	;LIGHT RED
FLsetColor	100,255,100,ihLoad	;LIGHT GREEN

;SLIDERS			            	MIN  |  MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gkSlider1, gihSlider1	FLslider 	"",	1,    5000,   -1,    3,     -1,    200,      20,  100,  0
gkSlider2, gihSlider2	FLslider 	"",	0,       4,    0,    3,     -1,    200,      20,  100, 20
gkSlider3, gihSlider3	FLslider 	"",	50,   5000,   -1,    3,     -1,    200,      20,  100, 40

;SET INITIAL VALUES OF FLTK VALUATORS
FLsetVal_i	100, gihSlider1
FLsetVal_i	0, gihSlider2
FLsetVal_i	500, gihSlider3

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 520, 312, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                        ftsave, ftload                       ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"ftsave and ftload allow the contents of function tables to be", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"saved to and loaded from files stored on the computer's hard ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"disk. There could be many practical uses for this function.  ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"In this example I am using ftsave and ftload to store the    ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"locations of FLTK sliders (and therefore the variables they  ", 	1,      5,     14,    490,    20,     5, 120
ih	  	 	FLbox  	"output).                                                     ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"When the 'Save' button is pressed the values from the three  ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"FLTK sliders are first stored into a function table and then ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"that function table is stored as a file on the hard disk     ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"which in this example I have named 'data.txt'.               ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"When the 'Load' button is pressed the reverse procedure is   ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"carried out - the file 'data.txt' is loaded into a function  ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"table, relevant values are read from the table and then sent ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"to the sliders.                                              ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"The advantage that this method of storing presets might have ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"over the traditional method using FL opcodes is that the user", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"has control over which FL valuators to store in the preset   ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"file.                                                        ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"When using ftsave and ftload we can save the data as binary  ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"data or as text. It doesn't really matter which we choose    ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"except that we need to be consistant with the choice we make ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"for ftsave and for ftload. Choosing 'text' makes the file    ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"more readable in a text editor.                              ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"The audio is a simple FOF sound.                             ", 	1,      5,     14,    490,    20,     5, 500

FLpanel_end

FLrun		;RUN THE WIDGET THREAD!

gidata		ftgen		0,0,4,-2,0
giDataTypeFlag	=	0	;0=BINARY NON-ZERO=TEXT - THIS DEFINES THE DATA TYPE IN THE FILE SAVED TO SUBSEQUENTLY LOADED FROM DISK
gisine	ftgen	0, 0, 1024, 10, 1		;SINE WAVE
giexp	ftgen	0, 0, 1024, 19, .5, .5, 270, .5	;EXPONENTIAL CURVE

instr	1	;SAVE DATA
	tableiw	i(gkSlider1), 0, gidata	;SLIDER DATA IS WRITTEN TO THE FUNCTION TABLE
	tableiw	i(gkSlider2), 1, gidata ;SLIDER DATA IS WRITTEN TO THE FUNCTION TABLE
	tableiw	i(gkSlider3), 2, gidata ;SLIDER DATA IS WRITTEN TO THE FUNCTION TABLE
	ftsave "Data.txt", giDataTypeFlag, gidata	;FUNCTION TABLE IS SAVED AS A TEXT FILE (FILE EXTENSION COULD BE ANYTHING OR NOTHING BUT MAKING IT A TEXT FILE MAKES IT EASY TO OPEN AND EXAMINE AND POSSIBLY ALTER - FOR THIS, DATA TYPE FLAG SHOULD BE NON-ZERO)
endin
	
instr	2	;LOAD DATA
	ftload "Data.txt", giDataTypeFlag, gidata	;LOAD FILE "Data.txt" TO FUNCTION TABLE gidata
	iSlider1	table	0, gidata	;READ DATA ITEM FROM TABLE
	FLsetVal_i	iSlider1, gihSlider1	;SEND DATA TO THE APPROPRIATE SLIDER
	iSlider2	table	1, gidata       ;READ DATA ITEM FROM TABLE          
	FLsetVal_i	iSlider2, gihSlider2    ;SEND DATA TO THE APPROPRIATE SLIDER
	iSlider3	table	2, gidata	;READ DATA ITEM FROM TABLE          
	FLsetVal_i	iSlider3, gihSlider3    ;SEND DATA TO THE APPROPRIATE SLIDER
endin

instr	3	;SOUND IS PRODUCED BY THE FOF OPCODE:
	kporttime	linseg	0,0.001,0.02
	kSlider1	portk	gkSlider1,kporttime
	kSlider2	portk	gkSlider2,kporttime
	kSlider3	portk	gkSlider3,kporttime
	;ASIG 	FOF 	GKAMP  |   KFUND     |    KFORM     | GKOCT    | GKBAND | GKRIS | GKDUR | GKDEC | IOLAPS | IFNA |  IFNB |  ITOTDUR
	asig 	fof 	0.2,      kSlider1,     kSlider3,    kSlider2,     50,    .003,     .1,    .007,    500,  gisine,  giexp,     3600
	outs	asig, asig
endin
	
</CsInstruments>

<CsScore>
i 3 0 3600
</CsScore>

</CsoundSynthesizer>