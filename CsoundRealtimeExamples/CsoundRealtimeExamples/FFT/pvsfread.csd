;Written by Iain McCurdy

<CsoundSynthesizer>

<CsOptions>
-odevaudio -b400
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
kr 		= 	441	;CONTROL RATE
ksmps 		= 	100	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM SOUND INTENSITY LEVEL REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL      | WIDTH | HEIGHT | X | Y
	FLpanel	"pvsfread",   500,    200,    0,  0

;SWITCHES  	                         	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"On/Off",	1,    0,    22,    120,     25,    5,  5,    0,     1,      0,       -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES		LABEL | WIDTH | HEIGHT | X | Y
idptr			FLvalue	" ",	 70,      20,    5,  75
idspeed			FLvalue	" ",	 70,      20,    5, 125
idGain			FLvalue	" ",	 70,      20,    5, 175

;SLIDERS				            		MIN   | MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X  | Y
gkptr, ihptr		FLslider 	"File Pointer",		0,       1,    0,    23,   idptr,     490,    25,     5,   50
gkspeed, ihspeed	FLslider 	"Pointer Speed",	-2,      2,    0,    23,   idspeed,   490,    25,     5,  100
gkGain, ihGain		FLslider 	"Gain",			0,       1,    0,    23,   idGain,    490,    25,     5,  150

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      1,    255,   255,   255		;NUMBERS MADE INVISIBLE

;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkPtrMode,   ihPtrMode	FLbutBank	14,     1,     2,     18,     40,    175,  0,   -1
gkinput,   ihinput	FLbutBank	14,     1,     2,     18,     40,    320,  0,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      5,      4,     0,     0,     0		;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Manual Pointer", 	1,       5,    12,    100,     20,   205,   0
ih		 	FLbox  	"Speed Control ", 	1,       5,    12,    100,     20,   205,  20
ih		 	FLbox  	"Voice         ", 	1,       5,    12,    100,     20,   340,   0
ih		 	FLbox  	"Drum Loop     ", 	1,       5,    12,    100,     20,   340,  20

;SET INITIAL VALUES FOR SLIDERS 	|VALUE | HANDLE
			FLsetVal_i	 0.5,	ihGain
			FLsetVal_i	   1,	ihspeed
			FLsetVal_i	 0.5,	ihptr

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     320,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          pvsfread                           ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Pvsfread is used to read data from a Pvoc-ex file            ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"(extension .pvx) and convert it into an fsig which can       ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"subsequently be transformed by many of Csound's fsig opcodes.", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"Pvsfread offers an input argument to define the location, in ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"seconds, from the beginning of the file from which to read   ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"data. In this example there are two modes for modulating this", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"pointer variable. In the first mode the pointer is modulated ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"manually using the 'File Pointer' slider. In the second mode ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"'Pointer Speed' controls the speed at which a moving phase   ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"value moves through the file. A value of '1' here indicates  ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"normal playback speed, 2 = double speed, -2 = double speed in", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"reverse and so on.                                           ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"The fsig output by pvsfread is resynthesised using the       ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"pvsynth opcode.                                              ", 	1,      5,     14,    490,    15,     5, 300

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr 		1
	if		gkOnOff=0	then	;SENSE FLTK ON/OFF SWITCH
			turnoff			;TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif					;END OF CONDITIONAL BRANCHING
#define		ANALYSISFILE1	#"AndItsAll.pvx"#	;CREATE A TEXT MACRO OF THE CHOSEN ANALYSIS FILE NAME (TO SAVE US HAVING TO WRITE IT OUT TWICE!)
#define		ANALYSISFILE2	#"loop.pvx"#		;CREATE A TEXT MACRO OF THE CHOSEN ANALYSIS FILE NAME (TO SAVE US HAVING TO WRITE IT OUT TWICE!)
	ilen1		filelen		$ANALYSISFILE1			;DERIVE THE FILE LENGTH (IN SECONDS) OF THE CHOSEN ANALYSIS FILE	
	ilen2		filelen		$ANALYSISFILE2			;DERIVE THE FILE LENGTH (IN SECONDS) OF THE CHOSEN ANALYSIS FILE	

	klen	=	(gkinput=0?ilen1:ilen2)
	
	if	gkPtrMode=0	then		;IF POINTER MODE 'MANUAL' IS SELECTED...
		kptr = gkptr			;SET kptr TO THE VALUE OF SLIDER VALUE gkptr
	else					;OTHERWISE USE 'SPEED CONTROL' MODE
		kptr phasor	gkspeed/klen	;kptr IS A MOVING PHSE VALUE DIRECTLY PROPORTIONAL TO SLIDER VARIABLE gkspeed AND INVERESELY PROPORTIONAL TO FILE LENGTH
	endif					;END OF CONDITIONAL BRANCHING
	if	gkinput=0	then
		;OUTPUT		OPCODE		POINTER     |   FILE
		fsig  		pvsfread	kptr * klen, $ANALYSISFILE1	;READ AN ANALYSIS FILE FROM THE HARD DRIVE ACCORDING TO THE GIVEN FILE POINTER LOCATION. OUTPUT AN F-SIGNAL.
	else	
		;OUTPUT		OPCODE		POINTER     |   FILE
		fsig  		pvsfread	kptr * klen, $ANALYSISFILE2	;READ AN ANALYSIS FILE FROM THE HARD DRIVE ACCORDING TO THE GIVEN FILE POINTER LOCATION. OUTPUT AN F-SIGNAL.
	endif
	
	;OUTPUT		OPCODE		INPUT
	aresyn 		pvsynth  	fsig                      		;RESYNTHESIZE THE f-SIGNAL AS AN AUDIO SIGNAL
			outs		aresyn * gkGain, aresyn * gkGain	;SEND THE RESYNTHESIZED SIGNAL TO THE AUDIO OUTPUTS AND RESCALE USING ON-SCREEN GAIN CONTROL
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT - ALLOWS REAL TIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>