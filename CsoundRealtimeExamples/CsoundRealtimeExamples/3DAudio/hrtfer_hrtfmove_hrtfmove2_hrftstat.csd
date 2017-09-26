hrtfer_hrtfmove_hrtfmove2_hrftstat.csd
Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
-iadc -odac
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL                                 | WIDTH | HEIGHT | X | Y
	FLpanel		"hrtfer/hrtfmove/hrtfmove2/hrtfstat",    500,    400,    0,  0

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	6,        9,    15,    490,   100,     5, 410	;BORDER AROUND HRTFMOVE EXTRA PARAMETERS
ih		 	FLbox  	" ", 	6,        9,    15,    490,   100,     5, 520	;BORDER AROUND HRTFMOVE2 EXTRA PARAMETERS
ih		 	FLbox  	" ", 	6,        9,    15,    490,   100,     5, 630	;BORDER AROUND HRTFSTAT EXTRA PARAMETERS

;SWITCHES		                     		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    118,     30,     5, 5,    0,     1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW

;NUMBER DISPLAY BOXES				WIDTH | HEIGHT | X | Y
idAz		FLvalue	"Azimuth (Degrees)",	60,       20,    5, 130
idElev		FLvalue	"Elevation (Degrees)",	60,       20,    5, 190

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS			 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkopcode, ihopcode	FLbutBank	14,     1,     4,     18,      80,   180, 2,   -1
gkinput, ihinput	FLbutBank	14,     1,     2,     18,      40,   350, 2,   -1
gkmode, ihmode		FLbutBank	14,     1,     2,     18,      40,   150,420,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"hrtfer   ",		1,       5,    12,    45,      25,   208,   0
ih		 	FLbox  	"hrtfmove ",		1,       5,    12,    45,      25,   208,  20
ih		 	FLbox  	"hrtfmove2",		1,       5,    12,    45,      25,   208,  40
ih		 	FLbox  	"hrtfstat ",		1,       5,    12,    45,      25,   208,  60
ih		 	FLbox  	"Input:",		1,       2,    14,    45,      25,   300,   0
ih		 	FLbox  	"Bounce.wav",		1,       5,    12,    70,      25,   370,   0
ih		 	FLbox  	"Live Input",		1,       5,    12,    70,      25,   370,  20
ih		 	FLbox  	"Mode:",		1,       2,    14,    45,      15,   100, 420
ih		 	FLbox  	"phase truncation",	1,       5,    12,   120,      15,   170, 420
ih		 	FLbox  	"minimum phase   ",	1,       5,    12,   120,      15,   170, 440

;XY PANELS								MINX | MAXX | MINY | MAXY | EXPX | EXPY | DISPX | DISPY | WIDTH | HEIGHT | X | Y
gkAz, gkElev, ihAz, ihElev	FLjoy	"X=Azimuth  Y=Elevation",	-360,  360,   -40,    90,    0,     0,    idAz,  idElev,  360,    280,    70, 100


;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"hrtfmove",		1,       4,    13,    45,      13,   18,  415
ih		 	FLbox  	"hrtfmove2",		1,       4,    13,    45,      13,   18,  525
ih		 	FLbox  	"hrtfstat",		1,       4,    13,    45,      13,   18,  635


;VALUE DISPLAY BOXES	LABEL  | WIDTH | HEIGHT | X |  Y
idfade		FLvalue	" ",      70,    18,     20, 480

;SLIDERS				            		MIN |   MAX  | EXP | TYPE |  DISP    | WIDTH | HEIGHT | X  | Y
gkfade, ihfade			FLslider	"Fade",		1,       24,    0,    3,     idfade,    460,     20,    20,  460

;SET INITIAL VALUES			VALUE | HANDLE
			FLsetVal_i   	0,	ihAz
			FLsetVal_i   	0,	ihElev
			FLsetVal_i   	8,	ihfade
			FLsetVal_i   	1,	ihopcode

	FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 520, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"           hrtfer/hrtfmove/hrtfmove2/hrtfstat                ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"This example demonstrates Csound's four opcodes for 3-d      ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"binaural spacialisation, these are the oldest hrtfer and the ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"three newer opcodes, hftfmove, hrtfmove2 and hrtfstat.       ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"By presenting them in this fashion the user is able to easily", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"compare them.                                                ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"Each opcode requires a data file which basically contains    ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"information about how the human ears, head and body filter   ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"and delays frequencies before they reach each ear drum.      ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"The two crucial input parameters that each of these opcodes  ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"requires are elevation, basically vertical direction in      ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"degrees from which the sound emanates, and azimuth which     ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"determines from where on the horizontal plane the sound      ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"emanates from.                                               ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"To allow the user to explore dynamic gestures involving both ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"of these parameters they are combined to be controlled from  ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"an X-Y panel.                                                ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"Each of these opcodes expects a monophonic audio input and   ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"outputs binaural stereo audio meaning that the 3-d effect    ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"will really only work through stereo headphones.             ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"The user can choose between either a sound file input (a     ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"bouncing ping-pong ball) or the computer's live audio input. ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"Azimuth and elevation are i-rate parameters in 'hrtfstat'    ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"therefore audio discontinuities are heard when modulating    ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"these parameters as the opcode is re-initialized.            ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"'hrtfmove', 'hrtfmove2' and 'hrtfstat' each have several     ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"optional input arguments but I have not yet set up FLTK      ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"controls for these.                                          ", 	1,      5,     14,    490,    15,     5, 500

		FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1	;CONTROL INSTRUMENT
	if	gkOnOff=0	then	;IF FLTK ON/OFF CONTROL IS OFF...
		turnoff			;TURN OFF THIS INSTRUMENT IMMEDIATELY
	endif				;END OF CONDITIONAL BRANCHING
	if	gkinput=0	then				;IF INPUT SELECTOR IS ON 'Bounce.wav'...
		gasrc, asigR	diskin2	"Bounce.wav", 1,0,1	;READ AUDIO FILE FROM DISK (RIGHT CHANNEL WILL BE IGNORED)
	elseif	gkinput=1	then				;OR IF INPUT SELECTER IS ON 'LIVE INPUT'
		gasrc	inch	1				;READ LIVE AUDIO FROM THE COMPUTER'S FIRST (LEFT) AUDIO INPUT
	endif							;END OF CONDITIONAL BRANCHING
	if	gkopcode=0	then						;IF OPCODE SELECTER IS ON 'hrtfer'...
		;SCHEDKWHEN KTRIGGER, KMINTIM, KMAXNUM, KINSNUM, KWHEN, KDUR 
		schedkwhen     1,        0,       1,       2,       0,  -1 	;START INSTRUMENT 2 (hrtfer)
	endif									;END OF CONDITIONAL BRANCHING
	if	gkopcode=1	then						;IF OPCODE SELECTER IS ON 'hrtfmove'...
		;SCHEDKWHEN KTRIGGER, KMINTIM, KMAXNUM, KINSNUM, KWHEN, KDUR                                         
		schedkwhen     1,        0,       1,       3,       0,  -1      ;START INSTRUMENT 3 (hrtfmove)         
	endif                                                                   ;END OF CONDITIONAL BRANCHING        
	if	gkopcode=2	then						;IF OPCODE SELECTER IS ON 'hrtfmove2'...
		;SCHEDKWHEN KTRIGGER, KMINTIM, KMAXNUM, KINSNUM, KWHEN, KDUR                                         
		schedkwhen     1,        0,       1,       4,       0,  -1      ;START INSTRUMENT 4 (hrtfmove2)         
	endif                                                                   ;END OF CONDITIONAL BRANCHING        
	if	gkopcode=3	then						;IF OPCODE SELECTER IS ON 'hrtfstat'...
		;SCHEDKWHEN KTRIGGER, KMINTIM, KMAXNUM, KINSNUM, KWHEN, KDUR                                         
		schedkwhen     1,        0,       1,       5,       0, -1       ;START INSTRUMENT 5 (hrtfstat)         
	endif                                                                   ;END OF CONDITIONAL BRANCHING        
endin

instr	2	;hrtfer
	; SENSE FLTK ON/OFF SWITCH
	if		gkOnOff=0	then	;IF ON/OFF SELECTER IS OFF
			turnoff			;TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif					;END OF CONDITIONAL BRANCHING
	if		gkopcode!=0	then	;IF OPCODE SELECTER IS NOT ON 'hrtfer'... 
			turnoff			;TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif					;END OF CONDITIONAL BRANCHING
	aleft, aright 	hrtfer gasrc, gkAz, gkElev, "HRTFcompact"	;APPLY hrtfer OPCODE TO AUDIO SOURCE FROM INSTR 1
	outs	aleft*100, aright*100					;SEND TO AUDIO OUTPUTS AND BOOST
endin

instr	3	;hrtfmove			
	if	gkOnOff=0	then            ;IF ON/OFF SELECTER IS OFF                    
		turnoff                         ;TURN THIS INSTRUMENT OFF IMMEDIATELY         
	endif                                   ;END OF CONDITIONAL BRANCHING                 
	if		gkopcode!=1	then    ;IF OPCODE SELECTER IS NOT ON 'hrtfmove'...
			turnoff                 ;TURN THIS INSTRUMENT OFF IMMEDIATELY         
	endif                                   ;END OF CONDITIONAL BRANCHING                 
	ktrigger	changed	gkmode, gkfade	;IF gkmode OR gkfade CHANGE OUTPUT (ktrigger) A MOMENTARY 1 VALUE
	if	ktrigger=1	then		;IF ktrigger IS 1
		reinit	UPDATE			;BEGIN A RE-INITIALIZATION PASS FROM LABEL 'UPDATE'
	endif					;END OF CONDITIONAL BRANCHING
	UPDATE:					;LABEL 'UPDATE'
	aleft, aright hrtfmove gasrc, gkAz, gkElev, "hrtf-44100-left.dat","hrtf-44100-right.dat", i(gkmode), i(gkfade), sr	;APPLY hrtfmove OPCODE TO AUDIO SOURCE FROM INSTR 1
 	rireturn				;END OF RE-INITIALIZATION PASS - RETURN TO PERFORMANCE TIME
 	outs	aleft, aright			;SEND AUDIO TO OUTPUTS
endin

instr	4	;hrtfmove2
	if	gkOnOff=0	then		;IF ON/OFF SELECTER IS OFF                 
		turnoff                         ;TURN THIS INSTRUMENT OFF IMMEDIATELY      
	endif                                   ;END OF CONDITIONAL BRANCHING              
	if		gkopcode!=2	then    ;IF OPCODE SELECTER IS NOT ON 'hrtfmove2'...
			turnoff                 ;TURN THIS INSTRUMENT OFF IMMEDIATELY      
	endif                                   ;END OF CONDITIONAL BRANCHING              
	aleft, aright hrtfmove2 gasrc, gkAz, gkElev, "hrtf-44100-left.dat","hrtf-44100-right.dat"; [,ioverlap, iradius, isr]   	;APPLY hrtfmove2 OPCODE TO AUDIO SOURCE FROM INSTR 1
 	outs	aleft, aright			;SEND AUDIO TO OUTPUTS
endin

instr	5	;hrtfstat
	if	gkOnOff=0	then		;IF ON/OFF SELECTER IS OFF                  
		turnoff                         ;TURN THIS INSTRUMENT OFF IMMEDIATELY       
	endif                                   ;END OF CONDITIONAL BRANCHING               
	if		gkopcode!=3	then    ;IF OPCODE SELECTER IS NOT ON 'hrtfstat'...
			turnoff                 ;TURN THIS INSTRUMENT OFF IMMEDIATELY      
	endif                                   ;END OF CONDITIONAL BRANCHING              
	ktrigger	changed	gkAz, gkElev    ;IF gkAz OR gkElev CHANGE OUTPUT (ktrigger) A MOMENTARY 1 VALUE
	if	ktrigger=1	then            ;IF ktrigger=1, i.e. gkAz OR gkElev ARE CHANGED...
		reinit	UPDATE                  ;BEGIN A REINITIALIZATION PASS FROM LABEL 'UPDATE'
	endif                                   ;END OF CONDITIONAL BRANCHING               
	UPDATE:					;BEGIN A RE-INITIALIZATION PASS FROM LABEL 'UPDATE'
	aleft, aright hrtfstat gasrc, i(gkAz), i(gkElev), "hrtf-44100-left.dat","hrtf-44100-right.dat";[,iradius, isr]   	;APPLY hrtfmove2 OPCODE TO AUDIO SOURCE FROM INSTR 1
	rireturn				;END OF RE-INITIALIZATION PASS - RETURN TO PERFORMANCE TIME
 	outs	aleft, aright			;SEND AUDIO TO OUTPUTS
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT - SUSTAINS REAL-TIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>