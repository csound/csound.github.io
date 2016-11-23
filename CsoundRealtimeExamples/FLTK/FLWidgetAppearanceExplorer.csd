;FLWidgetAppearanceExplorer.csd
;Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	8	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE (MAY NEED TO BE LOW WHEN WORKING WITH SHORT DELAY TIMES DEFINED INITIALLY AT KRATE)
nchnls 		= 	2	;NUMBER OF CHANNELS (1=MONO)

FLcolor	255, 255, 255, 0, 0, 0
;			LABEL                          | WIDTH | HEIGHT | X | Y
		FLpanel	"FL Widget Appearance Explorer",   500,    345,    0,  0
;SUB PANELS							TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih			FLbox  	"", 				6,      9,     15,    496,    80,      2, 220-215
ih			FLbox  	"Primary Colour (FLsetColor)", 	1,     10,     14,    486,    20,      7, 222-215
;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE
gkR_P, ihR_P 			FLcount  "Red", 		0,    255,    1,     10,      1,    140,     25,   25, 250-215,   -1
gkG_P, ihG_P 			FLcount  "Green", 		0,    255,    1,     10,      1,    140,     25,  180, 250-215,   -1
gkB_P, ihB_P 			FLcount  "Blue", 		0,    255,    1,     10,      1,    140,     25,  335, 250-215,   -1
;SUB PANELS							TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih			FLbox  	"", 				6,      9,     15,    496,    80,      2, 305-215
ih			FLbox  	"Secondary Colour (FLsetColor2)",1,     10,     14,    486,    20,      7, 307-215
;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE
gkR_S, ihR_S 			FLcount  "Red", 		0,    255,    1,     10,      1,    140,     25,   25, 335-215,   -1
gkG_S, ihG_S 			FLcount  "Green", 		0,    255,    1,     10,      1,    140,     25,  180, 335-215,   -1
gkB_S, ihB_S 			FLcount  "Blue", 		0,    255,    1,     10,      1,    140,     25,  335, 335-215,   -1
;SUB PANELS						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih			FLbox  	"", 			6,      9,     15,    496,   160,      2, 390-215
ih			FLbox  	"Font", 		1,     10,     14,    486,    20,      7, 392-215
gihFontDescription	FLbox  	"Helvetica (Arial)", 	1,      1,     14,    140,    20,     30, 458-215
gihAlignDescription	FLbox  	"(not set)", 		1,      1,     14,    140,    20,    180, 458-215
gihTextTypeDescription	FLbox  	"normal", 		1,      1,     14,    190,    20,    305, 458-215
;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE
gkfont, ihfont 			FLcount  "Font", 		1,     16,    1,     10,      2,    100,     25,    50, 420-215,   0,4,0,0
gkalign, ihalign		FLcount  "Align", 		0,      9,    1,     10,      2,    100,     25,   200, 420-215,   0,3,0,0
gktexttype, ihtexttype		FLcount  "Text Type", 		0,     10,    1,     10,      2,    100,     25,   350, 420-215,   0,5,0,0
gkfontsize, ihfontsize		FLcount  "Font Size", 		1,    100,    1,     10,      2,    100,     25,    10, 490-215,   -1
gkR_font, ihR_font		FLcount  "Red", 		0,    255,    1,     10,      1,    120,     25,   120, 490-215,   -1
gkG_font, ihG_font		FLcount  "Green", 		0,    255,    1,     10,      1,    120,     25,   245, 490-215,   -1
gkB_font, ihB_font		FLcount  "Blue", 		0,    255,    1,     10,      1,    120,     25,   370, 490-215,   -1

;SET INITIAL VALUES FOR VALUATORS
		FLsetVal_i	50, 	ihR_P                                                                                  
		FLsetVal_i	100, 	ihG_P
		FLsetVal_i	150, 	ihB_P                                                                               
		FLsetVal_i	150, 	ihR_S
		FLsetVal_i	200, 	ihG_S
		FLsetVal_i	15, 	ihB_S
		FLsetVal_i	1, 	ihfont                                                                         
		FLsetVal_i	12, 	ihfontsize                                                                        

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 320, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                 FL Widget Appearance Explorer               ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"This example facilitates to exploration of changing the FLTK ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"attributes for primary and secondary colours (red,blue,green ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"components), font, font size, label alignment, text style and", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"font colour.                                                 ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"The results of these changes are displayed reflected by a    ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"number of widgets in realtime.                               ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"Note that the colour attributes of button banks are not      ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"altered using 'FLsetColor' and 'FLsetColor2'. Instead, they  ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"can be changed using 'FLcolor' and 'FLcolor2'. These opcodes ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"are normally used to change the attributes of all widgets    ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"that follow them (unless specifically set using 'FLsetColor' ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"or 'FLsetColor2'.                                            ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"Note that as FLjoy uses two 'handles', one for each axis,    ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"the two crosshairs could be coloured differently if desired. ", 	1,      5,     14,    490,    20,     5, 300
	FLpanel_end

instr	1 
	;	LABEL    | WIDTH | HEIGHT | X | Y
	FLpanel	"Output",   500,    430,    0,  420
	;SUB PANELS					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
	gihbox1		 	FLbox  	"FLbox", 	6,      9,     15,     95,     85,    40, 40	;SUB-PANEL
	;XY PANELS						MINX | MAXX | MINY | MAXY | EXPX | EXPY | DISPX | DISPY | WIDTH | HEIGHT | X | Y
	gk,gkjoy,gihjoy1,gihjoy2	FLjoy	"FLjoy",	0,       1,    0,     1,     0,     0,     -1,      -1,     95,     85,   190, 40
	;BUTTONS                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
	gkbutton1,gihbutton1	FLbutton	"FLbutton 1",	1,    0,     2,    120,    30,   320, 40,    -1      
	gkbutton2,gihbutton2	FLbutton	"FLbutton 2",	1,    0,    22,    120,    30,   320, 95,    -1      
	FLsetVal_i	0.5,gihjoy1
	FLsetVal_i	0.5,gihjoy2
	;SLIDERS						MIN  |   MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
	gkslider1,gihslider1	FLslider 	"FLslider 1",	0,        1,    0,    3,    -1,     200,     20,    250, 165
	gkslider2,gihslider2	FLslider 	"FLslider 2",	0,        1,    0,   23,    -1,     200,     20,    250, 205
	gkslider3,gihslider3	FLslider 	"FLslider 3",	0,        1,    0,   25,    -1,     200,     20,    250, 245
	FLsetVal_i	0.5,gihslider2
	;KNOBS						MIN | MAX | EXP|  TYPE | DISP | WIDTH | X | Y
	gkknob1, gihknob1	FLknob	"knob 1",	0,     1,    0,    1,     -1,    40,   40, 155
	gkknob2, gihknob2	FLknob	"knob 2",	0,     1,    0,    2,     -1,    40,  100, 155
	gkknob3, gihknob3	FLknob	"knob 3",	0,     1,    0,    3,     -1,    40,  160, 155
	FLsetVal_i	0.5,gihknob2
	;FLROLLER	FLROLLER			MIN | MAX | STEP | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
	gk, gihroller1	FLroller	"FLroller 1",	0,     1,   0.01,   0,    1,     -1,    160,      20,  40, 230
	;COUNTERS					MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE
	gk, gihcounter1		FLcount  "Counter 1", 	0,     1,     1,     10,      2,    100,     25,   300, 300,   -1
	;VALUE INPUT BOXES				 	MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
	gk, gihvalue1		FLtext		"FLtext input",	0,     1,   0.01,    1,    100,     20,   300,  350
	;BUTTON BANK		FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
	gk,gihbutbank1		FLbutBank	1,       1,    4,      30,     80,    40,280,    -1
	gk,gihbutbank2		FLbutBank	2,       1,    4,      30,     80,    80,280,    -1
	gk,gihbutbank3		FLbutBank	3,       1,    4,      30,     80,   120,280,    -1
	gk,gihbutbank4		FLbutBank	4,       1,    4,      30,     80,   160,280,    -1
	FLpanel_end	;END OF PANEL CONTENTS
	FLrun	;RUN THE FLTK WIDGET THREAD
endin

instr	2	;
	kmetro	metro	20		;RATE AT WHICH APPEARANCE IS UPDATED. 
	if kmetro=1 then		;IF A METRONOME IMPULSE IS RECEIVED...
	  ktrig	changed	gkR_P,gkG_P,gkB_P,gkR_S,gkG_S,gkB_S,gkfont,gkfontsize,gktexttype,gkR_font,gkG_font,gkB_font
	  if ktrig=1 then		;AND IF ONE OF THE FLTK APPEARANCE CONTROLS HAS BEEN CHANGED...
	    reinit UPDATE		;REINITIALISE FROM LABEL 'UPDATE'
	  endif				;END OF CONDITIONAL BRANCH
	endif				;END OF CONDITIONAL BRANCH		
	UPDATE:				;A LABEL. REINITIALISATION TO RESET THE WIDGET APPEARANCE BEGINS FROM HERE.
#define	UPDATE_APPEARANCE(HANDLE)
	#
	FLhide $HANDLE			;HIDE THE WIDGET
	FLsetColor	i(gkR_P),i(gkG_P),i(gkB_P),$HANDLE
	FLsetColor2	i(gkR_S),i(gkG_S),i(gkB_S),$HANDLE
	FLsetFont	i(gkfont),$HANDLE
	FLsetTextColor	i(gkR_font),i(gkG_font),i(gkB_font),$HANDLE
	FLsetTextSize	i(gkfontsize),$HANDLE
	FLsetTextType	i(gktexttype),$HANDLE
	FLshow $HANDLE			;THE WIDGET IS REVEALED
	#
	$UPDATE_APPEARANCE(gihbox1)
	$UPDATE_APPEARANCE(gihknob1)
	$UPDATE_APPEARANCE(gihknob2)
	$UPDATE_APPEARANCE(gihknob3)
	$UPDATE_APPEARANCE(gihroller1)
	$UPDATE_APPEARANCE(gihjoy1)
	$UPDATE_APPEARANCE(gihjoy2)
	$UPDATE_APPEARANCE(gihbutton1)
	$UPDATE_APPEARANCE(gihbutton2)
	$UPDATE_APPEARANCE(gihslider1)
	$UPDATE_APPEARANCE(gihslider2)
	$UPDATE_APPEARANCE(gihslider3)
	$UPDATE_APPEARANCE(gihcounter1)
	$UPDATE_APPEARANCE(gihbutbank1)
	$UPDATE_APPEARANCE(gihbutbank2)
	$UPDATE_APPEARANCE(gihbutbank3)
	$UPDATE_APPEARANCE(gihbutbank4)
	rireturn			;RETURN FROM REINITIALISATION PASS
endin

instr	3
#define	UPDATE_APPEARANCE(HANDLE)
	#
	FLhide $HANDLE			;HIDE THE WIDGET
	FLsetAlign	i(gkalign),$HANDLE
	FLshow $HANDLE			;THE WIDGET IS REVEALED
	#
	$UPDATE_APPEARANCE(gihbox1)
	$UPDATE_APPEARANCE(gihknob1)
	$UPDATE_APPEARANCE(gihknob2)
	$UPDATE_APPEARANCE(gihknob3)
	$UPDATE_APPEARANCE(gihroller1)
	$UPDATE_APPEARANCE(gihjoy1)
	$UPDATE_APPEARANCE(gihjoy2)
	$UPDATE_APPEARANCE(gihbutton1)
	$UPDATE_APPEARANCE(gihbutton2)
	$UPDATE_APPEARANCE(gihslider1)
	$UPDATE_APPEARANCE(gihslider2)
	$UPDATE_APPEARANCE(gihslider3)
	$UPDATE_APPEARANCE(gihcounter1)
	$UPDATE_APPEARANCE(gihbutbank1)
	$UPDATE_APPEARANCE(gihbutbank2)
	$UPDATE_APPEARANCE(gihbutbank3)
	$UPDATE_APPEARANCE(gihbutbank4)
	
	;UPDATE DESCRIPTION BOX
	ialign	init	i(gkalign)
	if ialign==1 then
	  Sdescription = "center"
	elseif ialign==2 then
	  Sdescription = "top"
	elseif ialign==3 then
	  Sdescription = "bottom"
	elseif ialign==4 then
	  Sdescription = "left"
	elseif ialign==5 then
	  Sdescription = "right"
	elseif ialign==6 then
	  Sdescription = "top-left"
	elseif ialign==7 then
	  Sdescription = "top-right"
	elseif ialign==8 then
	  Sdescription = "bottom-left"
	elseif ialign==9 then
	  Sdescription = "bottom-right"
	endif
	FLhide	gihAlignDescription
	FLsetText Sdescription, gihAlignDescription
	FLshow	gihAlignDescription
endin

instr	4
	ifont	init	i(gkfont)
	if ifont==1 then
	  Sdescription = "Helvetica (Arial)"
	elseif ifont==2 then
	  Sdescription = "Helvetica Bold"
	elseif ifont==3 then
	  Sdescription = "Helvetica Italic"
	elseif ifont==4 then
	  Sdescription = "Helvetica Bold Italic"
	elseif ifont==5 then
	  Sdescription = "Courier"
	elseif ifont==6 then
	  Sdescription = "Courier Bold"
	elseif ifont==7 then
	  Sdescription = "Courier Italic"
	elseif ifont==8 then
	  Sdescription = "Courier Bold Italic"
	elseif ifont==9 then
	  Sdescription = "Times"
	elseif ifont==10 then
	  Sdescription = "Times Bold"
	elseif ifont==11 then
	  Sdescription = "Times Italic"
	elseif ifont==12 then
	  Sdescription = "Times Bold Italic"
	elseif ifont==13 then
	  Sdescription = "Symbol"
	elseif ifont==14 then
	  Sdescription = "Screen"
	elseif ifont==15 then
	  Sdescription = "Screen Bold"
	else
	  Sdescription = "Dingbats"
	endif
	FLhide	gihFontDescription
	FLsetText Sdescription, gihFontDescription
	FLshow	gihFontDescription
endin

instr	5	;UPDATE TEXT TYPE DESCRIPTION
	itexttype	init	i(gktexttype)
	if itexttype==0 then
	  Sdescription = "normal"
	elseif itexttype==1 then
	  Sdescription = "none"
	elseif itexttype==2 then
	  Sdescription = "symbol"
	elseif itexttype==3 then
	  Sdescription = "shadow"
	elseif itexttype==4 then
	  Sdescription = "engraved"
	elseif itexttype==5 then
	  Sdescription = "embossed"
	elseif itexttype==6 then
	  Sdescription = "bitmap (not implemented yet)"
	elseif itexttype==7 then
	  Sdescription = "pixmap (not implemented yet)"
	elseif itexttype==8 then
	  Sdescription = "image (not implemented yet)"
	elseif itexttype==9 then
	  Sdescription = "multi (not implemented yet)"                                 
	elseif itexttype==10 then                                                                           
	  Sdescription = "free-type (not implemented yet)"                                                                              
	endif
	FLhide	gihTextTypeDescription
	FLsetText Sdescription, gihTextTypeDescription
	FLshow	gihTextTypeDescription
endin

</CsInstruments>

<CsScore>
i 1 0 3600
i 2 0 3600	;RUNS FOR 1 HOUR.
e
</CsScore>

</CsoundSynthesizer>