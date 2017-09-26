portamento.csd

<CsoundSynthesizer>

<CsOptions>
-odac -dm0 -M0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>
sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255,  0,  0, 0
;			LABEL	| WIDTH | HEIGHT | X | Y
	FLpanel	"Portamento",      500,    170,    0,  0

;VALUE DISPLAY BOXES			WIDTH | HEIGHT | X |  Y
idporttime		FLvalue	" ",    60,       18,    5,   95
idcurve			FLvalue	" ",    60,       18,    5,  145

;SLIDERS				            			MIN  |   MAX | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X | Y
gkporttime,ihporttime		FLslider 	"Portamento Time",	0,        1,    0,    23,  idporttime,    490,    25,     5, 70
gkcurve,ihcurve			FLslider 	"Curve (s-curve)",	-8,       8,    0,    23,  idcurve,       490,    25,     5,120

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS			 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gktype, ihtype		FLbutBank	14,     1,     4,     18,      60,   50, 2,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Type:",		1,       2,    14,    48,      15,     0,   0
ih		 	FLbox  	"portk    ",		1,       5,    12,    65,      15,    70,   0
ih		 	FLbox  	"lineto   ",		1,       5,    12,    65,      15,    70,  15
ih		 	FLbox  	"s-curve 1",		1,       5,    12,    65,      15,    70,  30
ih		 	FLbox  	"s-curve 2",		1,       5,    12,    65,      15,    70,  45


;SET INITIAL VALUES			VALUE | HANDLE
			FLsetVal_i	 0.1,	ihporttime
			FLsetVal_i	 2,	ihcurve
			FLsetVal_i	 0,	ihtype

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 420, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           Portamento                        ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"Demonstration of three different approaches to implement     ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"pitch portamento between successive midi notes.              ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"The first method uses 'portk' which is really just a low pass", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"filter on the change of note. Changes between notes spaced   ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"far apart will take longer than changes between notes that   ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"are close together.                                          ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"The second method employs the 'lineto' opcode. This creates a", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"linear glide between the two notes and is the method that    ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"would be used on hardware synthesizers. Again glides between ", 	1,      5,     14,    490,    20,     5, 200
ih	  	 	FLbox  	"far apart notes will take longer than glides between notes   ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"that are close together.                                     ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"A third method (s-curve 1) moves between the two notes in the", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"shape of an inflected spline. The portamento time is the same", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"regardless of distance between the two notes. The shape of   ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"the curve (should be positive) can be set by the user.       ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"A fourth method (s-curve 2) differs to spline 1 in that      ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"portamento time is proportional to the gap between the old   ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"and new notes; rate of pitch change is constant. This method ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"probably gives the most natural portamento effect.           ", 	1,      5,     14,    490,    20,     5, 400
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


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


instr	1	;NOTE ON/OFF AND PITCH REGISERING INSTRUMENT. THIS INSTRUMENT WILL BE TRIGGERED BY NOTE PLAYED ON THE MIDI KEYBOARD
	inum		notnum		;READ IN MIDI NOTE NUMBERS
	gknum	=	inum		;CREATE A K-RATE GLOBAL VARIABLE VERSION OF MIDI PITCH THAT WILL BE USED IN INSTRUMENT 2.
	iInstr	=	2
	iactive	active	iInstr
	if iactive=0 then
	;		                p4
	 event_i	"i",iInstr,0,-1,p1		;THE VERY FIRST MIDI NOTE PLAYED WILL TRIGGER AN INFINITELY HELD NOTE IN INSTR 2. THE maxalloc SETTING IN THE ORCHESTRA HEADER WILL PREVENT ANY FURTHER TRIGGERINGS. 
	endif
endin

instr	2	;SOUND PRODUCING INSTRUMENT
	kactive	active	p4						;CONTINUALLY TRACK THE NUMBER OF ACTIVE INSTANCES OF INSTRUMENT 1. I.E. THE NUMBER OF MIDI NOTES HELD.
	if kactive==0 then
	 turnoff 
	endif	

	kporttime	linseg	0,0.001,1				;RAMPING UP PORTAMENTO FUNCTION TO PREVENT PORTAMENTO FROM ZERO WITH FIRST NOTE
	
	if i(gktype)==0 then						;IF PORTK SELECTED...
	 knum	portk	gknum,kporttime*gkporttime			;...APPLY PORTAMENTO SMOOTHING
	elseif i(gktype)==1 then					;OR IF LINETO IS SELECTED...
	 knum	lineto	gknum,kporttime*gkporttime			;...APPLY LINETO SMOOTHING
	elseif i(gktype)==2 then					;OR IF S-CURVE TYPE 1 IS SELECTED...
	 ktrig	changed	gknum						;...GENERATE A TRIGGER IS A NEW NOTE NUMBER IS GENERATED (FROM INSTR. 1)
	 gkOldNum	init	i(gknum)				;OLD NOTE NUMBER = FIRST NOTE NUMBER UPON INITIAL NOTE BEING PLAYED 
	 if ktrig=1 then						;IF A NEW (LEGATO) NOTE HAS BEEN PRESSED 
	  reinit	S_CURVE_1					;BEGIN A REINITIALISATION PASS FROM LABEL
	 endif								;END OF CONDITIONAL BRANCH
	 S_CURVE_1:							;A LABEL. REINITIALISATION BEGINS FROM HERE.
	 knum	sspline	gkporttime,i(gkOldNum),i(gknum),i(gkcurve)	;CALL sspline UDO
	 rireturn							;RETURN FROM REINITIALISATION PASS
	 gkOldNum	=	knum					;SET OLD NUMBER CURRENT NUMBER
	elseif i(gktype)==3 then					;...OR IF S-CURVE TYPE 2 IS SELECTED...
	 ktrig	changed	gknum						;...GENERATE A TRIGGER IS A NEW NOTE NUMBER IS GENERATED (FROM INSTR. 1)
	 gkOldNum	init	i(gknum)				;OLD NOTE NUMBER = FIRST NOTE NUMBER UPON INITIAL NOTE BEING PLAYED 
	 if ktrig=1 then						;IF A NEW (LEGATO) NOTE HAS BEEN PRESSED
	  reinit	S_CURVE_2					;BEGIN A REINITIALISATION PASS FROM LABEL
	 endif								;END OF CONDITIONAL BRANCH
	 S_CURVE_2:							;A LABEL. REINITIALISATION BEGINS FROM HERE.
	 idiff	=	1+abs(i(gknum)-i(gkOldNum))			;ABSOLUTE DIFFERENCE BETWEEN OLD NOTE AND NEW NOTE IN STEPS (+ 1)
	 knum	sspline	gkporttime*idiff,i(gkOldNum),i(gknum),i(gkcurve);CALL sspline UDO (PORTASMENTO TIME MULTIPLIED BY NOTE GAP (idiff))
	 rireturn							;RETURN FROM INITIALISATION PASS
	 gkOldNum	=	knum					;SET OLD NUMBER CURRENT NUMBER
	endif								;END OF CONDITIONAL BRANCH
	
	;CREATE A SAWTOOTH OSCILLATOR USING THE vco2 OPCODE
	asig		vco2	0.3,cpsmidinn(knum),4,0.5		;AUDIO OSCILLATOR

			outs	asig,asig				;SEND AUDIO TO OUTPUT
endin

</CsInstruments>
<CsScore>
f 0 360000
e
</CsScore>

</CsoundSynthesizer>
