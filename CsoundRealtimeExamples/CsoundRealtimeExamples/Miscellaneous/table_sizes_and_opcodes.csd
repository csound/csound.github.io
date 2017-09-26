table_sizes_and_opcodes.csd
Written by Iain McCurdy, 2014

<CsoundSynthesizer>

<CsOptions>
-odac --displays
</CsOptions>

<CsInstruments>

sr		=	44100
ksmps		=	32
nchnls		=	1
0dbfs		=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

FLcolor	255,255,255,0,0,0	;SET COLOUR SCHEME
;		OPCODE	LABEL                      | WIDTH | HEIGHT | X | Y
		FLpanel	"table sizes vs opcodes",    500,     330,   0,  0

;COUNTERS					MIN |  MAX   | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gksize, gihsize 	FLcount  "Table Size",	2,   1048577,    1,      1,      2,    150,     25,    5,  5,    -1

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idfreq				FLvalue	"",        80,     20,    5,  75
idamp				FLvalue	"",        80,     20,    5, 125

;SLIDERS					            			MIN   | MAX | EXP | TYPE |  DISP        | WIDTH | HEIGHT | X   | Y
gkfreq,ihfreq			FLslider 	"Frequency",			1,      5000, -1,    23,   idfreq,         490,      25,   5,    50
gkamp,ihamp			FLslider 	"Amplitude",			0,         1,  0,    23,    idamp,         490,      25,   5,   100

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkopcode, ihopcode		FLbutBank	11,     1,     8,     18,    20*8,    63,150,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Opcode:", 		1,       6,    14,     50,     20,   10, 150
ih		 	FLbox  	"oscil  ", 		1,       5,    14,     55,     20,   82, 150
ih		 	FLbox  	"oscili ", 		1,       5,    14,     55,     20,   82, 170
ih		 	FLbox  	"oscil3 ", 		1,       5,    14,     55,     20,   82, 190
ih		 	FLbox  	"poscil ", 		1,       5,    14,     55,     20,   82, 210
ih		 	FLbox  	"poscil3", 		1,       5,    14,     55,     20,   82, 230
ih		 	FLbox  	"table  ", 		1,       5,    14,     55,     20,   82, 250
ih		 	FLbox  	"tablei ", 		1,       5,    14,     55,     20,   82, 270
ih		 	FLbox  	"table3 ", 		1,       5,    14,     55,     20,   82, 290


;SET INITIAL VALUES OF VALUATOR                                                                                                
		FLsetVal_i	0, gihsize
		FLsetVal_i	100, ihfreq
		FLsetVal_i	0.5, ihamp

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 220, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                   Table Sizes and Opcodes                   ", 	1,      6,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      6,     14,    490,    20,     5,  20
ih		 	FLbox  	"This example allows the user to explore the audible results  ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"of choosing different function table sizes - critically the  ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"sound degradation that occurs when table sizes are very      ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"small - and different opcodes for creating audio oscillators.", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"The main thing to observe when choosing opcodes is the audio ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"improvement they implement through interpolation upon small  ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"function tables.                                             ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"If displays are enabled then user can observe how the        ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"waveform accuracy improves as function table size increases. ", 	1,      5,     14,    490,    20,     5, 200

				FLpanel_end



		FLrun		;RUN THE WIDGET THREAD

instr	1
	isizes	ftgentmp	0,0,128,-2, 2,3,4,5,8,9,16,17,32,33,64,65,128,129,256,257,512,513,1024,1025,2048,2049,4096,4097,8192,8193,16384,16385,32768,32769,65536,65537,131072,131073,262144,262145,524288,524289,1048576,1048577	;TABLE THAT STORES THE NON-SEQUENTIAL VALUES
	indx	init	i(gksize)					;INDEX USED TO REFERENCE VALUES IN THE ABOVE TABLE
	isize	table	indx,isizes					;INITIAL VALUE FOR THE COUNTER AT START-UP
	
	kup	trigger	gksize,isize,0					;TRIGGER GENERATED WHEN COUNTER IS INCREASED
	kdn	trigger	gksize,isize,1					;TRIGGER GENERATED WHEN COUNTER IS DECREASED
	
	if kup==1 then							;IF STEPPING UP...
	 reinit UPDATE1							;REINITIALISE STARTING FROM THE NEXT LINE
	 UPDATE1:							
	 indx = indx + 1						;INCREMENT INDEX
	 isize	table	indx,isizes					;READ NEW VALUE FROM NON SEQUENTIAL LIST TABLE
	 FLsetVal_i	isize,gihsize					;WRITE VALUE TO COUNTER
	 rireturn							;RETURN FROM REINITIALISATION
	elseif kdn==1 then						;SIMILAR PROCEDURE FOR WHENEVER COUNTER IS STEPPING DOWN
	 reinit UPDATE2
	 UPDATE2:
	 indx = indx - 1
	 isize	table	indx,isizes
	 FLsetVal_i	isize,gihsize	
	 rireturn
	endif
	
	ktrig	changed	gksize						; rewrite function table according to new size
	if ktrig==1 then
	 reinit REWRITE_TABLE
	 REWRITE_TABLE:
	 isine	ftgen	1,0,i(gksize),10,1
	endif
	
	if gkopcode==0 then						; choose opcode
	 asig	oscil	gkamp,gkfreq,isine
	elseif gkopcode==1 then
	 asig	oscili	gkamp,gkfreq,isine
	elseif gkopcode==2 then
	 asig	oscil3	gkamp,gkfreq,isine
	elseif gkopcode==3 then
	 asig	poscil	gkamp,gkfreq,isine
	elseif gkopcode==4 then
	 asig	poscil3	gkamp,gkfreq,isine
	elseif gkopcode>=5&&gkopcode<=8 then
	 aptr	phasor	gkfreq
	 if gkopcode==5 then
	  asig	table	aptr,isine,1
	 elseif gkopcode==6 then
	  asig	tablei	aptr,isine,1
	 elseif gkopcode==7 then
	  asig	table3	aptr,isine,1
	 endif
 	 asig	=	asig*gkamp
 	endif

	rireturn
		out	asig
endin

</CsInstruments>

<CsScore>
i 1 0 3600
</CsScore>

</CsoundSynthesizer>