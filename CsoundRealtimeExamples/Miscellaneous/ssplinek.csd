ssplinek.csd
Written by Iain McCurdy, 2012

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>
sr = 44100
ksmps = 32
nchnls = 1
0dbfs = 1
seed	0	;SEED RANDOM NUMBER GENERATORS FROM THE SYSTEM CLOCK

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;					LABEL         | WIDTH | HEIGHT | X | Y
				FLpanel	"'S' Spline",    500,    300,    0,  0

;CHANGE FLTK LABEL DESIGN
; 	SIZE | FONT | ALIGN | RED | GREEN | BLUE
FLlabel   12,    3,       1, 0, 0, 0

;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gktrig,ih			FLbutton	"Trigger",	1,    1,    21,     80,     25,    5,  5,     0,     1,     0,          -1

;CHANGE FLTK LABEL DESIGN
; 	SIZE | FONT | ALIGN | RED | GREEN | BLUE
FLlabel	12,     3,      3,     0,      0,    0

;TEXT BOX					MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  |  Y
gk, gihnote		FLtext	"Current Note",	0,    127,   0,     1,     80,     20,     5,   35
;COUNTERS					     		MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT |  X | Y  | OPCODE 
gknote2, ihnote2		FLcount  	"New Note", 	0,    127,   1,     12,     1,      80,     20,     5,  75,   -1 

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
iddur				FLvalue	"",        50,     20,   90,  30
idcurve				FLvalue	"",        50,     20,   90,  75
idamp				FLvalue	"",        50,     20,   90, 120

;SLIDERS					            			MIN   | MAX | EXP | TYPE |   DISP  | WIDTH | HEIGHT | X   | Y
gkdur,ihdur			FLslider 	"Spline Duration",		0.1,   3000,  -1,    23,    iddur,    405,      20,  90,    5
gkcurve,ihcurve			FLslider 	"Curve",			-8,       8,   0,    23,  idcurve,    405,      20,  90,   50
gkamp,ihamp			FLslider 	"Tone Amplitude",		0,        1,   0,    23,    idamp,    405,      20,  90,   95

;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	10, 	ihdur
				FLsetVal_i	2, 	ihcurve
				FLsetVal_i	72, 	ihnote2
				FLsetVal_i	0.2, 	ihamp

		FLscroll                          500,150,  0,150
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		FLbox  	"This example demonstrates how to create an 's' shaped inflected spline,", 	1,      11,   15,     480,     20,    0, 150
ih		FLbox  	"which may prove useful when implementing natural parameter morphs from", 	1,      11,   15,     480,     20,    0, 170
ih		FLbox  	"one state to another.                                                 ", 	1,      11,   15,     480,     20,    0, 190
ih		FLbox  	"The rate of change of a parameter with this function begins changing  ", 	1,      11,   15,     480,     20,    0, 210
ih		FLbox  	"slowly, gradually increasing up to a midway point where a maximum rate", 	1,      11,   15,     480,     20,    0, 230
ih		FLbox  	"of change is experienced and thereafter decelerating until gently     ", 	1,      11,   15,     480,     20,    0, 250
ih		FLbox  	"coming to rest at the final value upon completion of the spline.      ", 	1,      11,   15,     480,     20,    0, 270
ih		FLbox  	"In this example these splines are used to implement a change in the   ", 	1,      11,   15,     480,     20,    0, 290
ih		FLbox  	"note number of a tone generator across a given duration ('Spline      ", 	1,      11,   15,     480,     20,    0, 310
ih		FLbox  	"Duration'). The only other information required from the user is the  ", 	1,      11,   15,     480,     20,    0, 330
ih		FLbox  	"new note at which to arrive upon completion of the spline and the     ", 	1,      11,   15,     480,     20,    0, 350
ih		FLbox  	"the curve of the spline. Higher values for curve will result in spline", 	1,      11,   15,     480,     20,    0, 370
ih		FLbox  	"with greater concave and convex curvature whereas values closer to    ", 	1,      11,   15,     480,     20,    0, 390
ih		FLbox  	"zero will result something closer to a straightline tranformation.    ", 	1,      11,   15,     480,     20,    0, 410
ih		FLbox  	"'Curve' should really be a positive value to achieve the kind of morph", 	1,      11,   15,     480,     20,    0, 430
ih		FLbox  	"described above, negative values are permitted but are perhaps less   ", 	1,      11,   15,     480,     20,    0, 450
ih		FLbox  	"useful as the resulting inverted spline will be rather unnatural.     ", 	1,      11,   15,     480,     20,    0, 470
ih		FLbox  	"GEN16 is at the heart of spline generation in this example so I       ", 	1,      11,   15,     480,     20,    0, 490
ih		FLbox  	"recommend investigating that opcode (or the similarly functioning     ", 	1,      11,   15,     480,     20,    0, 510
ih		FLbox  	"transeg) for a better understanding of the curve parameter.           ", 	1,      11,   15,     480,     20,    0, 530
ih		FLbox  	"A crucial element to the mechanism implemented in this example is that", 	1,      11,   15,     480,     20,    0, 550
ih		FLbox  	"the spline duration can be modulated in realtime whilst a spline is   ", 	1,      11,   15,     480,     20,    0, 570
ih		FLbox  	"underway. Reducing the duration will cause movement through the spline", 	1,      11,   15,     480,     20,    0, 590
ih		FLbox  	"function to accelerate whereas increasing duration will cause it to   ", 	1,      11,   15,     480,     20,    0, 610
ih		FLbox  	"decelerate. The core mechanism of this example is contained within a  ", 	1,      11,   15,     480,     20,    0, 630
ih		FLbox  	"UDO to facilitate easy transplantation into other orchestras.         ", 	1,      11,   15,     480,     20,    0, 650
FLscrollEnd
				FLpanel_end
				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	tables
giwave	ftgen	0,0,4096,10,1,1/2,1/4,1/8,1/16,1/32,1/64,1/128
gknote	init	60					;NOTE NUMBER INITIAL VALUE
endin

opcode	sspline,k,Kiii
	kdur,istart,iend,icurve	xin										;READ IN INPUT ARGUMENTS
	imid	=	istart+((iend-istart)/2)								;SPLINE MID POINT VALUE
	isspline	ftgentmp	0,0,4096,-16,istart,4096*0.5,icurve,imid,(4096/2)-1,-icurve,iend	;GENERATE 'S' SPLINE
	kspd	=	i(kdur)/kdur										;POINTER SPEED AS A RATIO (WITH REFERENCE TO THE ORIGINAL DURATION)
	kptr	init	0											;POINTER INITIAL VALUE	
	kout	tablei	kptr,isspline										;READ VALUE FROM TABLE
	kptr	limit	kptr+((ftlen(isspline)/(i(kdur)*kr))*kspd), 0, ftlen(isspline)-1			;INCREMENT THE POINTER BY THE REQUIRED NUMBER OF TABLE POINTS IN ONE CONTROL CYCLE AND LIMIT IT BETWEEN FIRST AND LAST TABLE POINT - FINAL VALUE WILL BE HELD IF POINTER ATTEMPTS TO EXCEED TABLE DURATION
		xout	kout											;SEND VALUE BACK TO CALLER INSTRUMENT
endop

instr	1	;INSTRUMENT TO TRIGGER A NEW SPLINE
	inote1	=	i(gknote)			;START VALUE FOR THE 'S' SPLINE ABOUT TO BE GENERATED
	gknote	sspline	gkdur,inote1,i(gknote2),i(gkcurve)	;CALL UDO FOR GENERATING 'S' SHAPED SPLINE
endin

instr	2	;INTERPRET SPLINE AS A NOTE NUMBER AND GENERATE A TONE USING THE NOTE NUMBER
	a1	oscili	gkamp,cpsmidinn(gknote),giwave	;CREATE AN OSCILLATOR
		out	a1				;SEND AUDIO TO OUTPUT
	kprint	metro	10				;RATE OF CHECKING WHETHER TO UPDATE OF THE FLTK NUMBER BOX				
	if kprint==1 then				;IF A PRINT TRIGGER HAS BEEN RECEIVED...
	 kchanged	changed	gknote			;...CHECK TO SEE OF THE NOTE SPLINE VALUE HAS CHANGED SINCE THE LAST CHECK...
	 FLsetVal	kprint,gknote,gihnote		;...AND IF IT HAS, UPDATE THE FLTK NUMBER BOX
	endif
endin

</CsInstruments>
<CsScore>
i "tables" 0 3600
i 2 0.01 3600
e
</CsScore>

</CsoundSynthesizer>
