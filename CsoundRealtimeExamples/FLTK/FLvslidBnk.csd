;Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
-odevaudio -b200
</CsOptions>

<CsInstruments>

sr		=	44100
kr		=	441
ksmps		=	100
nchnls		=	2
0dbfs		=	1

zakinit	16,200
giminmaxtable	ftgen	1, 0, 32, -2, 1,0,  1,0,  1,0,  1,0,  1,0,  1,0,  1,0,  1,0, 1,0,  1,0,  1,0,  1,0, 1,0,  1,0,  1,0,  1,0
gisine		ftgen	3, 0, 4096, 10, 1

FLcolor	255, 255, 255, 0, 0, 0		
		FLpanel	"FLvslidBnk",500, 700, 0, 0
;FLslidBnk "",                                         inumsliders [, ioutable] [, iwidth] [, iheight] [, ix] [, iy] [, itypetable] [, iexptable] [, istart_index] [, iminmaxtable]
FLvslidBnk "1@2@3@4@5@6@7@8@9@10@11@12@13@14@15@16",        16,          0,         380,         50,     100,     5,        -1,             0,             0,              1
FLvslidBnk "1@2@3@4@5@6@7@8@9@10@11@12@13@14@15@16",        16,          0,         380,         50,     100,   100,        -3,             0,            16,              1
FLvslidBnk "1@2@3@4@5@6@7@8@9@10@11@12@13@14@15@16",        16,          0,         380,         50,     100,   175,        -5,             0,            32,              1
FLvslidBnk "1@2@3@4@5@6@7@8@9@10@11@12@13@14@15@16",        16,          0,         380,         50,     100,   250,        -7,             0,            48,              1
FLvslidBnk "1@2@3@4@5@6@7@8@9@10@11@12@13@14@15@16",        16,          0,         380,         50,     100,   325,       -21,             0,            64,              1
FLvslidBnk "1@2@3@4@5@6@7@8@9@10@11@12@13@14@15@16",        16,          0,         380,         50,     100,   400,       -23,             0,            80,              1
FLvslidBnk "1@2@3@4@5@6@7@8@9@10@11@12@13@14@15@16",        16,          0,         380,         50,     100,   475,       -25,             0,            96,              1
FLvslidBnk "1@2@3@4@5@6@7@8@9@10@11@12@13@14@15@16",        16,          0,         380,         50,     100,   550,       -27,             0,           112,              1

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Type 1:", 	1,      6,     14,     65,     20,   25,  20
ih		 	FLbox  	"Type 3:", 	1,      6,     14,     65,     20,   25, 120
ih		 	FLbox  	"Type 5:", 	1,      6,     14,     65,     20,   25, 195
ih		 	FLbox  	"Type 7:", 	1,      6,     14,     65,     20,   25, 270
ih		 	FLbox  	"Type 21:", 	1,      6,     14,     65,     20,   25, 345
ih		 	FLbox  	"Type 23:", 	1,      6,     14,     65,     20,   25, 420
ih		 	FLbox  	"Type 25:", 	1,      6,     14,     65,     20,   25, 495
ih		 	FLbox  	"Type 27:", 	1,      6,     14,     65,     20,   25, 570

ix	init	100
iwidth	init	23.8
;VALUE DISPLAY BOXES	WIDTH | HEIGHT | X |  Y
gid1	FLvalue	" ",    iwidth,   16,   ix,  70
ix = ix + iwidth
gid2	FLvalue	" ",    iwidth,   16,   ix,  70
ix = ix + iwidth
gid3	FLvalue	" ",    iwidth,   16,   ix,  70
ix = ix + iwidth
gid4	FLvalue	" ",    iwidth,   16,   ix,  70
ix = ix + iwidth
gid5	FLvalue	" ",    iwidth,   16,   ix,  70
ix = ix + iwidth
gid6	FLvalue	" ",    iwidth,   16,   ix,  70
ix = ix + iwidth
gid7	FLvalue	" ",    iwidth,   16,   ix,  70
ix = ix + iwidth
gid8	FLvalue	" ",    iwidth,   16,   ix,  70
ix = ix + iwidth
gid9	FLvalue	" ",    iwidth,   16,   ix,  70
ix = ix + iwidth
gid10	FLvalue	" ",    iwidth,   16,   ix,  70
ix = ix + iwidth
gid11	FLvalue	" ",    iwidth,   16,   ix,  70
ix = ix + iwidth
gid12	FLvalue	" ",    iwidth,   16,   ix,  70
ix = ix + iwidth
gid13	FLvalue	" ",    iwidth,   16,   ix,  70
ix = ix + iwidth
gid14	FLvalue	" ",    iwidth,   16,   ix,  70
ix = ix + iwidth
gid15	FLvalue	" ",    iwidth,   16,   ix,  70
ix = ix + iwidth
gid16	FLvalue	" ",    iwidth,   16,   ix,  70

		FLpanelEnd	;END OF PANEL CONTENTS
		
;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     240,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          FLvslidBnk                         ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"FLvslidBnk can be useful when a large number of parallel     ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"sliders are required. The user defines now many sliders are  ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"required and values are written into either a function       ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"table or as a sequence of zak variables.                     ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"Customization of individual slider types, value ranges,      ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"exponential scaling etc can be done using function tables.   ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"FLslidBnk (note spelling) is a similar opcode that produces  ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"horizontal sliders.                                          ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"In this example each set of 16 sliders controls partial      ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"strengths of a harmonic tone.                                ", 	1,      5,     14,    490,    15,     5, 220

				FLpanel_end

		FLrun		;RUN THE WIDGET THREAD

instr	1
#define	UPDATE_SLIDER(COUNT)
	#
	kval	zkr	$COUNT-1
	FLprintk2	kval, gid$COUNT
	#
	$UPDATE_SLIDER(1)
	$UPDATE_SLIDER(2)
	$UPDATE_SLIDER(3)
	$UPDATE_SLIDER(4)
	$UPDATE_SLIDER(5)
	$UPDATE_SLIDER(6)
	$UPDATE_SLIDER(7)
	$UPDATE_SLIDER(8)
	$UPDATE_SLIDER(9)
	$UPDATE_SLIDER(10)
	$UPDATE_SLIDER(11)
	$UPDATE_SLIDER(12)
	$UPDATE_SLIDER(13)
	$UPDATE_SLIDER(14)
	$UPDATE_SLIDER(15)
	$UPDATE_SLIDER(16)
endin

;DEFINE A MACRO TO PREVENT CODE REPETITION
#define	TONE(I'basefreq'ZakOS)
#
instr	$I
	kamp1	zkr	$ZakOS+0
	kamp2	zkr	$ZakOS+1
	kamp3	zkr	$ZakOS+2
	kamp4	zkr	$ZakOS+3
	kamp5	zkr	$ZakOS+4
	kamp6	zkr	$ZakOS+5
	kamp7	zkr	$ZakOS+6
	kamp8	zkr	$ZakOS+7
	kamp9	zkr	$ZakOS+8
	kamp10	zkr	$ZakOS+9
	kamp11	zkr	$ZakOS+10
	kamp12	zkr	$ZakOS+11
	kamp13	zkr	$ZakOS+12
	kamp14	zkr	$ZakOS+13
	kamp15	zkr	$ZakOS+14
	kamp16	zkr	$ZakOS+15
	aamp1	interp	kamp1	
	aamp2	interp	kamp2	
	aamp3	interp	kamp3	
	aamp4	interp	kamp4	
	aamp5	interp	kamp5	
	aamp6	interp	kamp6	
	aamp7	interp	kamp7	
	aamp8	interp	kamp8	
	aamp9	interp	kamp9	
	aamp10  interp	kamp10      
	aamp11  interp	kamp11      
	aamp12  interp	kamp12      
	aamp13  interp	kamp13      
	aamp14  interp	kamp14      
	aamp15  interp	kamp15      
	aamp16  interp	kamp16      
	a1	oscil	0.05*aamp1	, $basefreq             , gisine 
	a2	oscil	0.05*aamp2	, $basefreq*2             , gisine 
	a3	oscil	0.05*aamp3	, $basefreq*3             , gisine 
	a4	oscil	0.05*aamp4	, $basefreq*4             , gisine 
	a5	oscil	0.05*aamp5	, $basefreq*5             , gisine 
	a6	oscil	0.05*aamp6	, $basefreq*6             , gisine 
	a7	oscil	0.05*aamp7	, $basefreq*7             , gisine 
	a8	oscil	0.05*aamp8	, $basefreq*8             , gisine 
	a9	oscil	0.05*aamp9	, $basefreq*9             , gisine 
	a10     oscil	0.05*aamp10      , $basefreq*10             , gisine 
	a11     oscil	0.05*aamp11      , $basefreq*11             , gisine 
	a12     oscil	0.05*aamp12      , $basefreq*12             , gisine 
	a13     oscil	0.05*aamp13      , $basefreq*13             , gisine 
	a14     oscil	0.05*aamp14      , $basefreq*14             , gisine 
	a15     oscil	0.05*aamp15      , $basefreq*15             , gisine 
	a16     oscil	0.05*aamp16      , $basefreq*16             , gisine 
	amix	sum	a1, a2, a3, a4, a5, a6, a7, a8, a9, a10, a11, a12, a13, a14, a15, a16
	outs	amix, amix
endin
#

;8 TONE CREATED THROUGH THE USE OF PRE-DEFINED MACRO
;(I'BaseFreq'ZakOS)
$TONE(2'100'0)
$TONE(3'137'16)
$TONE(4'177'32)
$TONE(5'211'48)
$TONE(6'237'64)
$TONE(7'317'80)
$TONE(8'387'96)
$TONE(9'437'112)

</CsInstruments>

<CsScore>
i 1 0 3600
i 2 0 3600
i 3 0 3600
i 4 0 3600
i 5 0 3600
i 6 0 3600
i 7 0 3600
i 8 0 3600
i 9 0 3600
</CsScore>

</CsoundSynthesizer>

