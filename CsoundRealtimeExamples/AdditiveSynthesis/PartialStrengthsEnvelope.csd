PartialStrengthSEnvelope.csd
Written by Iain McCurdy, 2012

<CsoundSynthesizer>

<CsOptions>
-odac -m0 --displays
</CsOptions>

<CsInstruments>

sr	=	44100
ksmps	=	32
nchnls	=	1
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 255, 255, 50
;			LABEL                          | WIDTH | HEIGHT | X | Y
		FLpanel	"Partial Strengths Envelope",     500,    425,    0,  0

;VALUE_DISPLAY_BOXES		 	WIDTH | HEIGHT | X | Y
idfrq			FLvalue	" ",      60,    20,     5,  35
idamp			FLvalue	" ",      60,    20,     5,  85

;SLIDERS					            		MIN  | MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gkfrq,ihfrq			FLslider 	"Oscillator Frequency",	20,   5000,  -1,    23,  idfrq,   490,     25,    5,  10
gkamp,ihamp			FLslider 	"Oscillator Amplitude",	0,       1,   0,    23,  idamp,   490,     25,    5,  60

;TEXT BOXES							TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"", 				7,      1,     14,    490,    120,    5,  110	;BOX AROUND ENVELOPE FUNCTION TABLE PARAMETERS
FLsetColor	255,230,170,ih											;COLOUR BOX

;VALUE_DISPLAY_BOXES		 	WIDTH | HEIGHT | X | Y
idphase			FLvalue	" ",      80,    20,    15, 155
idshape			FLvalue	" ",      80,    20,    15, 205

;SLIDERS					            		MIN  | MAX | EXP | TYPE |  DISP  | WIDTH | HEIGHT | X | Y
gkphase,ihphase			FLslider 	"Envelope Phase",	-1,     2,    0,    23,  idphase,   470,     25,   15, 130
gkshape,ihshape			FLslider 	"Envelope Shape",	0.001, 20,    0,    23,  idshape,   470,     25,   15, 180

;TEXT BOXES							TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"", 				7,      1,     14,    490,    175,    5,  240		;BOX AROUND AUDIO WAVEFORM SLIDERS
FLsetColor	150,255,200,ih												;COLOUR BOX
ih		 	FLbox  	"Waveform Partial Strengths", 	1,      1,     14,    400,     20,   50,  243	;BOX AROUND AUDIO WAVEFORM LABEL
FLsetColor	150,255,200,ih

;SWITCHES  	                                  		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkFLTKUpdate,ih		FLbutton	"Update",		1,    0,    22,     80,     20,   15, 370,   -1
FLsetColor2	255, 255, 50, ih	;SET SECONDARY COLOUR TO YELLOW
FLsetVal_i	1,ih

#define SLIDER(N)
#
;SLIDERS					            	MIN  | MAX | EXP | TYPE |  DISP  | WIDTH | HEIGHT | X | Y
gk$N, gih$N		FLslider	"",    			0,       1,   0,   24,      -1,      8,    100,     ix, 265
ix = ix +8  
FLsetVal_i	1,gih$N
#
ix=15
$SLIDER(1)
$SLIDER(2)
$SLIDER(3)
$SLIDER(4)
$SLIDER(5)
$SLIDER(6)
$SLIDER(7)
$SLIDER(8)
$SLIDER(9)
$SLIDER(10)
$SLIDER(11)
$SLIDER(12)
$SLIDER(13)
$SLIDER(14)
$SLIDER(15)
$SLIDER(16)
$SLIDER(17)
$SLIDER(18)
$SLIDER(19)
$SLIDER(20)
$SLIDER(21)
$SLIDER(22)
$SLIDER(23)
$SLIDER(24)                         
$SLIDER(25)
$SLIDER(26)
$SLIDER(27)
$SLIDER(28)
$SLIDER(29)
$SLIDER(30)
$SLIDER(31)      
$SLIDER(32)
$SLIDER(33)
$SLIDER(34)
$SLIDER(35)
$SLIDER(36)
$SLIDER(37)
$SLIDER(38)
$SLIDER(39)
$SLIDER(40)
$SLIDER(41)
$SLIDER(42)
$SLIDER(43)
$SLIDER(44)
$SLIDER(45)
$SLIDER(46)
$SLIDER(47)
$SLIDER(48)
$SLIDER(49)
$SLIDER(50)
$SLIDER(51)
$SLIDER(52)
$SLIDER(53)
$SLIDER(54)
$SLIDER(55)
$SLIDER(56)
$SLIDER(57)
$SLIDER(58)
$SLIDER(59)

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

FLcolor2	255, 255, 50	;SET SECONDARY COLOUR TO YELLOW
;BUTTON BANKS			 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkWrapMode, ihWrapMode	FLbutBank	2,      1,      2,     30,     40,   190,370,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Mode:", 	1,       6,    12,     40,      20,  150, 370                                                                             
FLsetColor	150,255,200, ih	;SET SECONDARY COLOUR TO YELLOW
ih		 	FLbox  	"Wrap-around", 	1,       5,    12,    80,      20,  220, 370
FLsetColor	150,255,200, ih	;SET SECONDARY COLOUR TO YELLOW
ih		 	FLbox  	"Limit      ", 	1,       5,    12,    80,      20,  220, 390
FLsetColor	150,255,200, ih	;SET SECONDARY COLOUR TO YELLOW

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	50, 	ihfrq
		FLsetVal_i	0.1, 	ihamp
		FLsetVal_i	0, 	ihphase
		FLsetVal_i	2, 	ihshape

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 720, 505, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                Partial Strengths Envelopes                  ", 	1,      6,     14,    490,    20,     5,   3
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      6,     14,    490,    20,     5,  20
ih		 	FLbox  	"This example offers a suggestion for how to manipulate a     ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"large number of parameters in a shaped fashion with a minimum", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"of input control parameters. Specifically in this example    ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"this mechanism is used to apply a spectral envelope over the ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"partial strengths of a harmonic additive synthesis tone with ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"59 partials.                                                 ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"A gaussian shape windowing function is used to scale the     ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"partial amplitudes. The phase of the window can be modulated ", 	1,      5,     14,    490,    20,     5, 180       
ih		 	FLbox  	"to alter how it lines up with the sequence of partials       ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"strengths. The shape of the window itself can be modulated   ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"with the 'Envelope Shape' slider. A visual impression of the ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"window/envelope is provided in Csound's displays window      ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"- provided that displays are enabled (--displays flag). The  ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"derived partial strengths are represented by the 59 small    ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"vertical sliders - note that these sliders are for display   ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"only and manually changing them will have no effect on the   ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"sound produced. If updating of these FLTK sliders interrupts ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"realtime audio, it can be deactivated by deselecting the     ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"'update' button.                                             ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"If a reading is attempted beyond the limits of the window    ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"(less than zero, greater than '1') this can be dealt with in ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"one of two ways: by either wrapping values around to the     ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"opposite end of the window (Wrap-around) or by holding values", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"at the upper or lower limits of the window (Limit).          ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"Data from the window (in this case partial strengths) is read", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"using a recursive UDO to reduce code and to enable easy      ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"expansion. The oscillators for each partial are also created ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"in this recursive UDO.                                       ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"As additive synthesis is only used as a sonic demonstration  ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"of this technique, it is suggested that the user experiments ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"with other applications, such as the organisation of filter  ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"amplitudes in a bank of filters, delay time in a bank of     ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"delays etc. Exploration of other GEN routines for window     ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"creation is also encouraged. (See section on GEN routines.)  ", 	1,      5,     14,    490,    20,     5, 700

				FLpanel_end                                                 
                                                                                        
				FLrun	;RUN THE FLTK WIDGET THREAD                 
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

giPartialsEnv	ftgen	1,0,1024,20,6,1,i(gkshape)	;WINDOW USED TO SHAPE
gisine	ftgen	0,0,4096,10,1

opcode	AdditiveTone,a,kkkiiii
	kfreq,kphase,kWrapMode,icount,inpartials,iwaveform,iPartsEnv	xin			;READ IN UDO INPUT PARAMETERS
	amix	init	0									;INITIALISE AUDIO MIX VARIABLE
	if kWrapMode==0 then									;IF 'WRAP-AROUND' MODE IS SELECTED...
	 kphase1	wrap	(icount/(inpartials-1)) - kphase,0,1				;...CALCULATE THE PHASE FOR THIS PARTIAL AND WRAP-AROUND OUT OF RANGE VALUES
	else											;OTHERWISE ('LIMIT' MODE HAS BEEN SELECTED)
	 kphase1	=	(icount/(inpartials-1)) - kphase				;...CALCULATE THE PHASE FOR THIS PARTIAL. OUT OF RANGE VALUES WILL BE LIMITED BY THE table OPCODE
	endif											;END OF CONDITIONAL BRANCH
	kamp	tablei	kphase1, iPartsEnv, 1							;READ AMPLITUDE VALUE FOR THIS PARTIAL FROM THE WINDOW TABLE
	kamp	port	kamp,0.05								;APPLY PORTAMENTO SMOOTHING TO AMPLITUDE CHANGES (CAUSED BY CHANGES TO THE WINDOW FUNCTION)
	asig	oscili	kamp,kfreq + (kfreq*icount), iwaveform					;CREATE AN AUDIO SIGNAL FOR THIS PARTIAL
	icount	=	icount + 1								;INCREMENT THE COUNTER (IN READINESS FOR THE NEXT PARTIAL)
	if icount<inpartials then								;IF WE HAVEN'T YET REACHED THE FULL COMPLEMENT OF PARTIALS...
	 amix	AdditiveTone	kfreq,kphase,kWrapMode,icount,inpartials,iwaveform,iPartsEnv	;...CALL THE UDO AGAIN (WITH THE INCREMENTED COUNTER)
	endif											;ENDO IF CONDITIONAL BRANCH	
		xout	amix+asig
endop


instr	1
	inpartials	=	59						;NUMBER OF PARTIALS THAT WILL FORM THE ADDITIVE SYNTHESIS TONE
	
	;--UPDATE WINDOW/FUNCTION TABLE-- 
	ktrig1	changed	gkshape							;IF WINDOW/ENVELOPE SHAPE HAS BEEN MODIFIED USING ITS FLTK SLIDER GENERATE A TRIGGER INPULSE
	if ktrig1==1 then							;...IF A TRIGGER IMPULSE HAS BEEN GENERATED...
	 reinit UPDATE_GEN_TABLE						;BEGIN A REINITIALISATION PASS FROM THE GIVEN LABEL
	endif									;END OF CONDITIONAL BRANCH
	UPDATE_GEN_TABLE:							;A LABEL. REINITIALISATION PASS BEGINS FROM HERE
	giPartialsEnv	ftgen	1,0,1024,20,6,1,i(gkshape)			;WINDOW/ENVELOPE IS REWRITTEN
	rireturn								;RETURN FORM REINITIALISATION PASS
	
	;--UPDATE FLTK SLIDERS--
	kmetro	metro	5							;METRONOME OF TRIGGER IMPULSES (10 PER SECOND)
	if kmetro==1 then							;IS A METRONOME PULSE HAS BEEN GENERATED...
	 ktrig2	changed	gkphase							;GENERATE A TRIGGER IMPULSE IF PHASE SLIDER IS MOVED
	endif									;END OF CONDITIONAL BRANCH
	if ktrig1+ktrig2==1&&gkFLTKUpdate==1 then				;IF EITHER OF THE PREVIOUS TWO TRIGGERS IS ACTIVE *AND* IF 'Update' BUTTON IS ON...
	 reinit UPDATE2								;BEGIN A REINITIALISATION PASS FROM THE GIVEN LABEL
	endif									;END OF CONDITIONAL BRANCH
	UPDATE2:								;A LABEL. REINITIALISATION PASS BEGINS FROM HERE
#define	UPDATE_SLIDER(N)							;A MACRO IS DEFINED FOR UPDATING OF A SLIDER (TO REDUCE CODE REPETITION)
	#									;START OF CODE TO BE CONTAINIED WITHIN MACRO
	if i(gkWrapMode)==0 then						;IF 'WRAP-AROUND' MODE IS SELECTED...
	 iphase$N	wrap	(($N-1)/(inpartials-1)) - i(gkphase),0,1        ;...CALCULATE THE PHASE FOR THIS PARTIAL AND WRAP-AROUND OUT OF RANGE VALUES
	else                                                                    ;OTHERWISE ('LIMIT' MODE HAS BEEN SELECTED)
	 iphase$N	=	(($N-1)/(inpartials-1)) - i(gkphase)        	;...CALCULATE THE PHASE FOR THIS PARTIAL. OUT OF RANGE VALUES WILL BE LIMITED BY THE table OPCODE
	endif                                                                   ;END OF CONDITIONAL BRANCH
	iamp$N	table	iphase$N,giPartialsEnv,1				;READ AMPLITUDE VALUE FOR THIS PARTIAL FROM THE WINDOW TABLE
	FLsetVal_i	1-iamp$N,gih$N						;WRITE THE AMPLITUDE VALUE TO THE RELEVANT FLTK SLIDER
	#									;END OF CODE TO BE CONTAINED WITHIN MACRO
	$UPDATE_SLIDER(1)							;EXPAND MACRO MULTIPLE TIMES
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
	$UPDATE_SLIDER(17)
	$UPDATE_SLIDER(18)
	$UPDATE_SLIDER(19)
	$UPDATE_SLIDER(20)
	$UPDATE_SLIDER(21)
	$UPDATE_SLIDER(22)
	$UPDATE_SLIDER(23)
	$UPDATE_SLIDER(24)
	$UPDATE_SLIDER(25)
	$UPDATE_SLIDER(26)
	$UPDATE_SLIDER(27)
	$UPDATE_SLIDER(28)
	$UPDATE_SLIDER(29)
	$UPDATE_SLIDER(30)
	$UPDATE_SLIDER(31)
	$UPDATE_SLIDER(32)
	$UPDATE_SLIDER(33)
	$UPDATE_SLIDER(34)
	$UPDATE_SLIDER(35)
	$UPDATE_SLIDER(36)
	$UPDATE_SLIDER(37)
	$UPDATE_SLIDER(38)
	$UPDATE_SLIDER(39)
	$UPDATE_SLIDER(40)
	$UPDATE_SLIDER(41)
	$UPDATE_SLIDER(42)
	$UPDATE_SLIDER(43)
	$UPDATE_SLIDER(44)
	$UPDATE_SLIDER(45)
	$UPDATE_SLIDER(46)
	$UPDATE_SLIDER(47)
	$UPDATE_SLIDER(48)
	$UPDATE_SLIDER(49)
	$UPDATE_SLIDER(50)
	$UPDATE_SLIDER(51)
	$UPDATE_SLIDER(52)
	$UPDATE_SLIDER(53)
	$UPDATE_SLIDER(54)
	$UPDATE_SLIDER(55)
	$UPDATE_SLIDER(56)
	$UPDATE_SLIDER(57)
	$UPDATE_SLIDER(58)
	$UPDATE_SLIDER(59)
	rireturn								;RETURN FROM REINITIALISATION PASS
		
	asig	AdditiveTone	gkfrq,gkphase,gkWrapMode,0,inpartials,gisine,giPartialsEnv	;CALL UDO FOR GENERATING ADDITIVE SYNTHESIS TONE (UDO WILL BE RECALLED RECURSIVELY WITHIN ITSELF)
		out		asig*gkamp					;SEND AUDIO BACK TO OUTPUT. SCALE WITH FLTK AMPLITUDE CONTROL
endin

</CsInstruments>

<CsScore>
i 1 0 3600	;INSTRUMENT PLAYS FOR 1 HOUR. (AND KEEPS PERFORMANCE GOING.)
e
</CsScore>

</CsoundSynthesizer>

