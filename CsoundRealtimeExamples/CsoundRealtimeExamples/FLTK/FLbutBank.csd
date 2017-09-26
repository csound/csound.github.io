FLbutBank.csd
Written by Iain McCurdy, 2009. Updated 2011.

<CsoundSynthesizer>

<CsOptions>
-odac -d
</CsOptions>

<CsInstruments>

;USING THE OPCODE FLsetColor TO CHANGE FROM THE DEFAULT COLOURS FOR WIDGETS

sr		=	44100
ksmps		=	4                                            
nchnls		=	1
0dbfs	=	1

		FLpanel	"FLbutBank", 500, 550, 0, 0
;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ihtitle	FLbox  	"FLbutBank: Button Banks", 	7,      15,    20,   490,     35,     5,  5
FLsetColor	255, 255, 150, ihtitle		;SET SECONDARY COLOUR TO YELLOW

;BUTTON BANKS			 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkopcode, ihopcode	FLbutBank	1,      5,      1,    300,     30,  100, 50,   -1
gkopcode, ihopcode	FLbutBank	2,      5,      1,    300,     30,  100, 85,   -1
gkopcode, ihopcode	FLbutBank	3,      5,      1,    300,     30,  100,120,   -1
gkopcode, ihopcode	FLbutBank	4,      5,      1,    300,     30,  100,155,   -1
gkopcode, ihopcode	FLbutBank	21,     5,      1,    300,     30,  100,190,   -1
gkopcode, ihopcode	FLbutBank	22,     5,      1,    300,     30,  100,225,   -1
gkopcode, ihopcode	FLbutBank	23,     5,      1,    300,     30,  100,260,   -1
gkopcode, ihopcode	FLbutBank	24,     5,      1,    300,     30,  100,295,   -1

;TEXT BOXES			TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih	FLbox  	"Type 1:", 	1,      1,     16,    90,     35,     5,  50
ih	FLbox  	"Type 2:", 	1,      1,     16,    90,     35,     5,  85
ih	FLbox  	"Type 3:", 	1,      1,     16,    90,     35,     5, 120
ih	FLbox  	"Type 4:", 	1,      1,     16,    90,     35,     5, 155
ih	FLbox  	"Type 21:", 	1,      1,     16,    90,     35,     5, 190
ih	FLbox  	"Type 22:", 	1,      1,     16,    90,     35,     5, 225
ih	FLbox  	"Type 23:", 	1,      1,     16,    90,     35,     5, 260
ih	FLbox  	"Type 24:", 	1,      1,     16,    90,     35,     5, 295

;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"FLbutBank can be used to create a set of buttons that will   ", 	1,      5,    12,    490,     20,    5, 350
ih		 	FLbox  	"function as a set of radio buttons. That is: activating a    ", 	1,      5,    12,    490,     20,    5, 370
ih		 	FLbox  	"button de-activates the previous button. The variable output ", 	1,      5,    12,    490,     20,    5, 390
ih		 	FLbox  	"by the opcode corresponds to the number label of the         ", 	1,      5,    12,    490,     20,    5, 410
ih		 	FLbox  	"activated button.                                            ", 	1,      5,    12,    490,     20,    5, 430
ih		 	FLbox  	"A bank of buttons of any number of rows and columns can be   ", 	1,      5,    12,    490,     20,    5, 450
ih		 	FLbox  	"created. Individual buttons can also be of any size. A       ", 	1,      5,    12,    490,     20,    5, 470
ih		 	FLbox  	"variety of style or types are available as displayed above.  ", 	1,      5,    12,    490,     20,    5, 490
ih		 	FLbox  	"FLbutBank can also activate a real-time score event such as  ", 	1,      5,    12,    490,     20,    5, 510
ih		 	FLbox  	"starting a note.                                             ", 	1,      5,    12,    490,     20,    5, 530

		FLpanel_end	;END OF PANEL CONTENTS                      

FLcolor	255, 255, 255, 200, 100, 200


				FLpanel	"", 515, 540, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"It is possible to hide the number labels on buttons by colourizing ", 	1,      5,    12,    490,     20,     5,  0
ih		 	FLbox  	"them the same colour as the primary FLcolor.                       ", 	1,      5,    12,    490,     20,     5, 20
ih		 	FLbox  	"FLButBank outputs integers 0,1,2,3... starting from the top left   ", 	1,      5,    12,    490,     20,     5, 40
ih		 	FLbox  	"button, continuing down that column, following on down the next    ", 	1,      5,    12,    490,     20,     5, 60
ih		 	FLbox  	"column and so on. In this example the value box 'Raw Value' outputs", 	1,      5,    12,    490,     20,     5, 80
ih		 	FLbox  	"the value directly from FLButBank. It is possible to parse this    ", 	1,      5,    12,    490,     20,     5,100
ih		 	FLbox  	"value to create X and Y co-ordinates. Calculate the Y co-ordinate  ", 	1,      5,    12,    490,     20,     5,120
ih		 	FLbox  	"first as it is used in the dervation of the X co-ordinate.         ", 	1,      5,    12,    490,     20,     5,140
ih		 	FLbox  	"In the following code:                                             ", 	1,      6,    12,    490,     20,     5,160
ih		 	FLbox  	"iNumX = 'number of buttons in the X axis'                          ", 	1,      5,    12,    490,     20,     5,180
ih		 	FLbox  	"iNumY = 'number of buttons in the Y axis'                          ", 	1,      5,    12,    490,     20,     5,200
ih		 	FLbox  	"To calculate the Y co-ordinate:                                    ", 	1,      6,    12,    490,     20,     5,220
ih		 	FLbox  	"iYco_ord	wrap	i(gkXYval),0,iNumY                          ", 	1,      5,    12,    490,     20,     5,240
ih		 	FLbox  	"iYco_ord	=	iNumY-iYco_ord	                            ", 	1,      5,    12,    490,     20,     5,260
ih		 	FLbox  	"To calculate the X co-ordinate:                                    ", 	1,      6,    12,    490,     20,     5,280
ih		 	FLbox  	"iXco_ord	=	1+((iXYval-(iNumY-iYco_ord))/(iNumY))       ", 	1,      6,    12,    490,     20,     5,300
ih		 	FLbox  	"This will work with button banks of any dimensions.                ", 	1,      5,    12,    490,     20,     5,320
                                                                                                                                                


;						 		MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkRawVal, gihRawVal		FLtext		"Raw Value", 	0,    16,    0,     1,   100,     20,     270, 375
gkXVal, gihXVal			FLtext		"X Co-ordinate",0,    16,    0,     1,   100,     20,     270, 425
gkYVal, gihYVal			FLtext		"Y Co-ordinate",0,    16,    0,     1,   100,     20,     270, 475
		;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)
                                                                                                    
;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkXYval, ihXYval		FLbutBank	11,     4,     4,    4*40,    4*40,  100,360,   0,      1,      0,       0
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN
FLsetVal_i	3,ihXYval                      

;TEXT BOXES				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"1", 	1,      2,     14,     40,      20,  100, 520
ih		 	FLbox  	"2", 	1,      2,     14,     40,      20,  140, 520
ih		 	FLbox  	"3", 	1,      2,     14,     40,      20,  180, 520
ih		 	FLbox  	"4", 	1,      2,     14,     40,      20,  220, 520
ih		 	FLbox  	"4", 	1,      2,     14,     20,      40,   80, 360
ih		 	FLbox  	"3", 	1,      2,     14,     20,      40,   80, 400
ih		 	FLbox  	"2", 	1,      2,     14,     20,      40,   80, 440
ih		 	FLbox  	"1", 	1,      2,     14,     20,      40,   80, 480


		FLrun

instr	1                                   
	iNumX		=	4			;NUMBER OF BOXES IN THE X AXIS
	iNumY		=	4			;NUMBER OF BOXES IN THE Y AXIS
	iXYval		=	i(gkXYval)
	                                                      
	iYco_ord	wrap	i(gkXYval),0,iNumY
	iYco_ord	=	iNumY-iYco_ord	
	
	iXco_ord	=	1+((iXYval-(iNumY-iYco_ord))/(iNumY))
		                            
	FLsetVal_i	i(gkXYval), gihRawVal
	FLsetVal_i	iXco_ord, gihXVal
	FLsetVal_i	iYco_ord, gihYVal
	
	event_i "i",2,0,-1,iXco_ord,iYco_ord
endin

instr	2                                   
	asig	vco2	0.2,cpsmidinn(48)*octave(p5-1),0
	klfo	lfo	1,p4,5
	acf	interp	cpsoct(4+klfo*6)
	asig	moogvcf2	asig,acf,0
		out	asig
endin

</CsInstruments>

<CsScore>
i 1 0 3600
</CsScore>

</CsoundSynthesizer>