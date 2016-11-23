FLsetColor.csd
Written by Iain McCurdy 2009, updated 2011,

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

;USING THE OPCODE FLsetColor TO CHANGE FROM THE DEFAULT COLOURS FOR WIDGETS

sr		=	44100
ksmps		=	32
nchnls		=	2

		FLpanel	"FLsetColor/FLsetColor2", 300, 680, 0, 0

iy = 30	;Y LOCATION OF FIRST SLIDER
gk1,ihandle1	FLslider	"255 255 255 / 0 0 0", 200, 5000, -1, 3, -1, 280, 30, 10, iy
;OPCODE		RED | GREEN | BLUE | HANDLE
FLsetColor	255,   255,    255, ihandle1
FLsetColor2	0,      0,      0,  ihandle1
iy = iy + 50
gk1,ihandle2	FLslider	"150 255 255 / 255 150 255", 200, 5000, -1, 3, -1, 280, 30, 10, iy
;OPCODE		RED | GREEN | BLUE | HANDLE
FLsetColor	150,   255,   255,  ihandle2
FLsetColor2	255,   150,   255,  ihandle2
iy = iy + 50
gk1,ihandle3	FLslider	"200 150 255 / 255 255 150", 200, 5000, -1, 3, -1, 280, 30, 10, iy
;OPCODE		RED | GREEN | BLUE | HANDLE
FLsetColor	200,   150,   255,  ihandle3
FLsetColor2	255,   255,   150,  ihandle3
iy = iy + 50
gk1,ihandle4	FLslider	"50 255 255 / 255 50 255", 200, 5000, -1, 3, -1, 280, 30, 10, iy
;OPCODE		RED | GREEN | BLUE | HANDLE
FLsetColor	50,    255,   255,  ihandle4
FLsetColor2	255,    50,   255,  ihandle4
iy = iy + 50
gk1,ihandle5	FLslider	"255 50 255 / 255 255 50", 200, 5000, -1, 3, -1, 280, 30, 10, iy
;OPCODE		RED | GREEN | BLUE | HANDLE
FLsetColor	255,   50,    255,  ihandle5
FLsetColor2	255,   255,    50,  ihandle5
iy = iy + 50
gk1,ihandle6	FLslider	"255 0 0 / 0 255 0", 200, 5000, -1, 3, -1, 280, 30, 10, iy
;OPCODE		RED | GREEN | BLUE | HANDLE
FLsetColor	255,     0,    0,    ihandle6
FLsetColor2	0,     255,    0,    ihandle6
iy = iy + 50
gk1,ihandle7	FLslider	"0 255 0 / 0 0 255", 200, 5000, -1, 3, -1, 280, 30, 10, iy
;OPCODE		RED | GREEN | BLUE | HANDLE
FLsetColor	0,     255,     0,  ihandle7
FLsetColor2	0,     0,     255,  ihandle7

;TEXT BOXES									TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"      FLsetColor/FLsetColor2         ", 	1,      5,     14,    300,    20,     5,  400
ih		 	FLbox  	"-------------------------------------", 	1,      5,     14,    300,    20,     5,  420
ih		 	FLbox  	"Colours for individual sliders are   ", 	1,      5,     14,    300,    20,     5,  440
ih		 	FLbox  	"defined via their handle output      ", 	1,      5,     14,    300,    20,     5,  460
ih		 	FLbox  	"variables and using the opcodes      ", 	1,      5,     14,    300,    20,     5,  480
ih		 	FLbox  	"FLsetColor and FLsetColor2.          ", 	1,      5,     14,    300,    20,     5,  500
ih		 	FLbox  	"FLsetColor defines a widget's primary", 	1,      5,     14,    300,    20,     5,  520
ih		 	FLbox  	"colour and FLsteColor2 it's secondary", 	1,      5,     14,    300,    20,     5,  540
ih		 	FLbox  	"colour. Each colour is defined using ", 	1,      5,     14,    300,    20,     5,  560
ih		 	FLbox  	"three values corresponding to red,   ", 	1,      5,     14,    300,    20,     5,  580
ih		 	FLbox  	"green and blue (RGB) amounts.        ", 	1,      5,     14,    300,    20,     5,  600
ih		 	FLbox  	"The values for primary and secondary ", 	1,      5,     14,    300,    20,     5,  620
ih		 	FLbox  	"colours of each of the above sliders ", 	1,      5,     14,    300,    20,     5,  640
ih		 	FLbox  	"are given in their labels.           ", 	1,      5,     14,    300,    20,     5,  660

		FLpanel_end	;END OF PANEL CONTENTS


		FLpanel	"FLcolor", 300, 340, 315, 0
;TEXT BOXES									TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"               FLcolor               ", 	1,      5,     14,    300,    20,     5,  160
ih		 	FLbox  	"-------------------------------------", 	1,      5,     14,    300,    20,     5,  180
ih		 	FLbox  	"FLcolor sets the primary and         ", 	1,      5,     14,    300,    20,     5,  200
ih		 	FLbox  	"optionally the secondary colours for ", 	1,      5,     14,    300,    20,     5,  220
ih		 	FLbox  	"all subsequent widgets. In this      ", 	1,      5,     14,    300,    20,     5,  240
ih		 	FLbox  	"example the instruction:             ", 	1,      5,     14,    300,    20,     5,  260
ih		 	FLbox  	"FLcolor 100,200,200, 200,50,50       ", 	1,      5,     14,    300,    20,     5,  280
ih		 	FLbox  	"is given just before the code for the", 	1,      5,     14,    300,    20,     5,  300
ih		 	FLbox  	"sliders.                             ", 	1,      5,     14,    300,    20,     5,  320
;OPCODE	PRIMARY:RED | GREEN | BLUE | SECONDARY:RED | GREEN | BLUE
FLcolor	        100,   200,    200,            200,    50,    50	;SET GLOBAL PRIMARY AND SECONDARY COLOURS
iy = 30	;Y LOCATION OF FIRST SLIDER
gk1,ihandle1	FLslider	"", 200, 5000, -1, 3, -1, 280, 30, 10, iy
iy = iy + 50	;NEXT SLIDER 50 PIXELS LOWER
gk1,ihandle1	FLslider	"", 200, 5000, -1, 3, -1, 280, 30, 10, iy
iy = iy + 50	;NEXT SLIDER 50 PIXELS LOWER
gk1,ihandle1	FLslider	"", 200, 5000, -1, 3, -1, 280, 30, 10, iy
iy = iy + 50	;NEXT SLIDER 50 PIXELS LOWER
		FLpanel_end	;END OF PANEL CONTENTS


;OPCODE	PRIMARY:RED | GREEN | BLUE
FLcolor	         100,   100,   200	;SET GLOBAL PRIMARY COLOUR
		FLpanel	"FLcolor", 300, 240, 315, 417
;TEXT BOXES									TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"               FLcolor               ", 	1,      5,     14,    300,    20,     5,   20
ih		 	FLbox  	"-------------------------------------", 	1,      5,     14,    300,    20,     5,   40
ih		 	FLbox  	"To colourize a panel place the       ", 	1,      5,     14,    300,    20,     5,   60
ih		 	FLbox  	"FLcolor line before the FLpanel line.", 	1,      5,     14,    300,    20,     5,   80
ih		 	FLbox  	"In this example the line:            ", 	1,      5,     14,    300,    20,     5,  100
ih		 	FLbox  	"FLcolor 100, 100, 200                ", 	1,      5,     14,    300,    20,     5,  120
ih		 	FLbox  	"is placed before the line that       ", 	1,      5,     14,    300,    20,     5,  140
ih		 	FLbox  	"creates the panel itself             ", 	1,      5,     14,    300,    20,     5,  160
ih		 	FLbox  	"Secondary color is not used or needed", 	1,      5,     14,    300,    20,     5,  180
ih		 	FLbox  	"in colourizing an FL panel.          ", 	1,      5,     14,    300,    20,     5,  200
		FLpanel_end	;END OF PANEL CONTENTS

;OPCODE	PRIMARY:RED | GREEN | BLUE
FLcolor	        -2,    -2,     -2	;SET GLOBAL PRIMARY COLOUR
		FLpanel	"FLcolor", 300, 340, 630, 0
iy = 30	;Y LOCATION OF FIRST SLIDER
gk1,ihandle1	FLslider	"", 200, 5000, -1, 3, -1, 280, 30, 10, iy
iy = iy + 50	;NEXT SLIDER 50 PIXELS LOWER
gk1,ihandle1	FLslider	"", 200, 5000, -1, 3, -1, 280, 30, 10, iy
iy = iy + 50	;NEXT SLIDER 50 PIXELS LOWER
gk1,ihandle1	FLslider	"", 200, 5000, -1, 3, -1, 280, 30, 10, iy
iy = iy + 50	;NEXT SLIDER 50 PIXELS LOWER
gk1,ihandle1	FLslider	"", 200, 5000, -1, 3, -1, 280, 30, 10, iy
iy = iy + 50	;NEXT SLIDER 50 PIXELS LOWER
gk1,ihandle1	FLslider	"", 200, 5000, -1, 3, -1, 280, 30, 10, iy
;TEXT BOXES									TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"               FLcolor               ", 	1,      5,     14,    300,    20,     5,  220
ih		 	FLbox  	"-------------------------------------", 	1,      5,     14,    300,    20,     5,  240
ih		 	FLbox  	"Colours can be randomized by giving  ", 	1,      5,     14,    300,    20,     5,  260
ih		 	FLbox  	"FLcolor values of -2:                ", 	1,      5,     14,    300,    20,     5,  280
ih		 	FLbox  	"FLcolor -2, -2, -2                   ", 	1,      5,     14,    300,    20,     5,  300
		FLpanel_end	;END OF PANEL CONTENTS


		FLpanel	"FLsetColor2", 300, 230, 945, 0
;SWITCHES                       					ON | OFF | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE
gkSwitch1,ihSwitch1		FLbutton	"yellow: 255 255 50",	1,    0,    22,    280,     30,    10,  5,   -1
FLsetColor2	255, 255, 50, ihSwitch1		;SET SECONDARY COLOUR TO YELLOW
gkSwitch2,ihSwitch2		FLbutton	"red: 255 50 50",	1,    0,    22,    280,     30,    10, 50,   -1
FLsetColor2	255,  50,  50, ihSwitch2	;SET SECONDARY COLOUR TO RED
gkSwitch3,ihSwitch3		FLbutton	"blue: 50 50 255",	1,    0,    22,    280,     30,    10, 95,   -1
FLsetColor2	 00,  50, 255, ihSwitch3	;SET SECONDARY COLOUR TO BLUE

;TEXT BOXES									TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"           FLsetColor2               ", 	1,      5,     14,    300,    20,     5,  150
ih		 	FLbox  	"-------------------------------------", 	1,      5,     14,    300,    20,     5,  170
ih		 	FLbox  	"The secondary colour of a button     ", 	1,      5,     14,    300,    20,     5,  190
ih		 	FLbox  	"widget defines its light 'On' colour.", 	1,      5,     14,    300,    20,     5,  210
		FLpanel_end	;END OF PANEL CONTENTS

		FLpanel	"FLcolor", 300, 360, 945, 310
;TEXT BOXES									TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Different widget types can render    ", 	1,      5,     14,    300,    20,     5,  240
ih		 	FLbox  	"different colours slightly           ", 	1,      5,     14,    300,    20,     5,  260
ih		 	FLbox  	"differently.                         ", 	1,      5,     14,    300,    20,     5,  280
ih		 	FLbox  	"The colours of the above sliders have", 	1,      5,     14,    300,    20,     5,  300
ih		 	FLbox  	"all been defined using the line:     ", 	1,      5,     14,    300,    20,     5,  320
ih		 	FLbox  	"FLcolor 100, 200, 200, 200, 50, 50   ", 	1,      5,     14,    300,    20,     5,  340
;OPCODE	PRIMARY:RED | GREEN | BLUE | SECONDARY:RED | GREEN | BLUE
FLcolor	        100,   200,    200,            200,    50,    50	;SET GLOBAL PRIMARY AND SECONDARY COLOURS
iy = 30	;Y LOCATION OF FIRST SLIDER
gk1,ih	FLslider	"Type 3", 200, 5000, -1, 3, -1, 280, 30, 10, iy
iy = iy + 50	;NEXT SLIDER 50 PIXELS LOWER
gk1,ih	FLslider	"Type 5", 200, 5000, -1, 5, -1, 280, 30, 10, iy
iy = iy + 50	;NEXT SLIDER 50 PIXELS LOWER
gk1,ih	FLslider	"Type 23", 200, 5000, -1,23, -1, 280, 30, 10, iy
iy = iy + 50	;NEXT SLIDER 50 PIXELS LOWER
gk1,ih	FLslider	"Type 25", 200, 5000, -1,25, -1, 280, 30, 10, iy

		FLpanel_end	;END OF PANEL CONTENTS

		
FLcolor	         255,255,255, 0,0,0	;SET GLOBAL COLOURS - BLACK AND WHITE
		FLpanel	"Colour Explorer", 300, 300, 630, 417
;TEXT BOXES									TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"           Colour Explorer           ", 	1,      5,     14,    300,    20,     5,   20
ih		 	FLbox  	"-------------------------------------", 	1,      5,     14,    300,    20,     5,   40
ih		 	FLbox  	"Move the sliders to explore the      ", 	1,      5,     14,    300,    20,     5,   60
ih		 	FLbox  	"different colours possible.          ", 	1,      5,     14,    300,    20,     5,   80
gkR,ih	FLslider	"Red",   0, 255, 0, 3, -1, 290, 15,  5, 100
gkG,ih	FLslider	"Green", 0, 255, 0, 3, -1, 290, 15,  5, 140
gkB,ih	FLslider	"Blue",  0, 255, 0, 3, -1, 290, 15,  5, 180
;VALUE INPUT BOXES				MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gk, gihR		FLtext		"", 	0,    255,   0,     1,      40,     17,    5,  115
gk, gihG		FLtext		"", 	0,    255,   0,     1,      40,     17,    5,  155
gk, gihB		FLtext		"", 	0,    255,   0,     1,      40,     17,    5,  195
;SUB PANELS					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
gihColourBox		FLbox  	"", 		6,      9,     15,    290,     60,    5, 220

	FLpanel_end	;END OF PANEL CONTENTS

		FLrun		;RUN THE WIDGET THREAD!

instr 1	;UPDATE COLOUR EXPLORER COLOUR OUTPUT BOX AND INTEGERIZED NUMBER BOXES
	ktrig	changed	gkR,gkG,gkB
	if ktrig==1 then
	  reinit UPDATE
	endif
	UPDATE:
	iR	init	int(i(gkR))
	iG	init	int(i(gkG))
	iB	init	int(i(gkB))
	FLhide	gihColourBox
	FLsetColor	iR,iG,iB,gihColourBox
	FLshow	gihColourBox
	FLsetVal_i	iR,gihR
	FLsetVal_i	iG,gihG
	FLsetVal_i	iB,gihB
endin

</CsInstruments>

<CsScore>
i 1 0 3600
</CsScore>

</CsoundSynthesizer>