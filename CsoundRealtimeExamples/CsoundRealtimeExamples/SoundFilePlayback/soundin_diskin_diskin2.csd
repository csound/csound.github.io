soundin_diskin_diskin2.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	8	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE (MAY NEED TO BE LOW WHEN WORKING WITH SHORT DELAY TIMES DEFINED INITIALLY AT KRATE)
nchnls 		= 	1	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 255, 255,105	;SET COLOUR SCHEME
;			LABEL                    | WIDTH | HEIGHT | X | Y
		FLpanel	"soundin diskin diskin2",   500,    340,    0,  0

;                                                      		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,    0,    22,    120,     25,    5,  5,    0,      1,      0,       -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
idspeed				FLvalue	" ",    60,       20,    5, 125
idinskip			FLvalue	" ",    60,       20,    5, 175
idgain				FLvalue	" ",    60,       20,    5, 315

;SLIDERS					            			MIN | MAX | EXP | TYPE | DISP       | WIDTH | HEIGHT | X | Y
gkspeed,ihspeed			FLslider 	"Speed",			-3,    3,    0,    23,  idspeed,       490,     25,    5, 100
gkinskip,ihinskip		FLslider 	"In skip",			0,     1,    0,    23,  idinskip,      490,     25,    5, 150
gkgain, ihgain			FLslider 	"Output Gain",			0,     1,    0,    23,  idgain,        490,     25,    5, 290

;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT |  X  | Y | OPCODE
gksfile, ihsfile		FLcount  "Sound File", 		1,     2,     1,      1,      2,    145,     25,   175,   5,   -1

;TEXT BOXES              					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y 
ih		 FLbox  "1=808loopMono.wav 2=AndItsAll.wav", 	1,     9,      12,   150,     30,    175, 50

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS				TYPE | NUMX | NUMY | WIDTH | HEIGHT | X  | Y | OPCODE | INS | STARTTIM | DUR
gkopcode, ihopcode	FLbutBank	1,      1,     3,     20,      60,   65,  201,   -1
gklooping, ihlooping	FLbutBank	1,      1,     2,     20,      40,  230,  201,   -1
gkwsize, ihwsize	FLbutBank	1,      1,     4,     20,      80,  390,  201,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Opcode:", 	1,       5,    14,     60,      20,   5, 200
ih		 	FLbox  	"soundin",	1,       5,    14,     75,      20,  85, 200
ih		 	FLbox  	"diskin ", 	1,       5,    14,     75,      20,  85, 220
ih		 	FLbox  	"diskin2", 	1,       5,    14,     75,      20,  85, 240
ih		 	FLbox  	"Looping:", 	1,       5,    14,     60,      20, 170, 200
ih		 	FLbox  	"Off",		1,       5,    14,     30,      20, 250, 200
ih		 	FLbox  	"On ", 		1,       5,    14,     30,      20, 250, 220
ih		 	FLbox  	"Window Size:", 1,       5,    14,    100,      20, 290, 200
ih		 	FLbox  	"No Interp. ",	1,       5,    14,     90,      20, 410, 200
ih		 	FLbox  	"Linear     ", 	1,       5,    14,     90,      20, 410, 220
ih		 	FLbox  	"Cubic      ", 	1,       5,    14,     90,      20, 410, 240
ih		 	FLbox  	"Point Sinc.", 	1,       5,    14,     90,      20, 410, 260

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	1, 	ihspeed
		FLsetVal_i	0, 	ihinskip
		FLsetVal_i	2, 	ihopcode
		FLsetVal_i	1, 	ihlooping
		FLsetVal_i	1, 	ihsfile
		FLsetVal_i	0.7, 	ihgain
		FLsetVal_i	2, 	ihwsize

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 680, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                   soundin diskin diskin2                    ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"'soundin', 'diskin' and 'diskin2' can all be used to read    ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"audio from disk. These opcodes buffer audio directly from    ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"disk in contrast to opcodes such as 'loscil' and 'flooper'   ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"which read audio completely into RAM (using a GEN01 function ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"table) at the start of performance. 'soundin', 'diskin' and  ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"'diskin2' might be more suitable when reading of very long   ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"files is required. Where a high polyphony of sound file      ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"playback is required 'loscil', 'flooper' etc. might be a     ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"better choice as when using 'soundin' ect. we are limited by ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"the mechanical performance of the hard drive.                ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"'soundin' provides sound file playback but does not permit   ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"modulation of playback speed. 'diskin' and 'diskin2' both    ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"implement modulation of playback speed. Negative playback    ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"speeds result in reversed playback direction.                ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"Playback can be looped (wrapped around) when using 'diskin'  ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"and 'diskin2'.                                               ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"'In Skip' varies the location at which playback initially    ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"begins. In this example this is expressed as a fraction of   ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"the duration of the entire file. If playback wraps around it ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"wraps around to the beginning or end of the file, not the    ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"inskip point. This parameter is i-rate so performance must be", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"interrupted when it is changed in order to implement that    ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"change.                                                      ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"When using 'diskin2' the user can define the window size     ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"across which samples are interpolated when speed is          ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"modulated. Larger window sizes will improve sound quality    ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"when speed is not an integer at some CPU cost.               ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"In this example both sound files used are mono but 'soundin',", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"'diskin' and 'diskin2' can all read from sound files with up ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"to 24 channels.                                              ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"'diskin' is listed as 'deprecated' and 'diskin2' should be   ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"used in its place.                                           ", 	1,      5,     14,    490,    20,     5, 660

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


instr	1
	if gkOnOff==0 then								;IF On/Off SWITCH IS SET TO 'OFF'...
	  turnoff									;TURN THIS INSTRUMENT OFF
	endif										;END OF CONDITIONAL BRANCHING
	kporttime	linseg		0,0.001,0.02					;PORTAMENTO TIME IS DEFINED AS A FUNCTION THAT RAMPS UP QUICKLY FROM ZERO TO A HELD VALUE
	kspeed		portk		gkspeed,kporttime				;APPLY PORTAMENTO SMOOTHING TO CHANGES OF THE FLTK SLIDER VARIABLE
	iwsizetab	ftgenonce	0,0,4,-2, 1,2,4,8				;A FUNCTION TABLE THAT STORE THE LIST OF WINDOW SIZE VALUES
	ktrig	changed	gkinskip,gklooping,gkwsize,gksfile				;GENERATE A '1' IF INPUT ARG. CHANGES
	if ktrig==1 then								;IF I-RATE VARIABLE SLIDERS HAS BEEN CHANGED...
	  reinit	UPDATE								;...REINITIALISE FROM LABEL 'UPDATE'
	endif										;END OF CONDITIONAL BRANCH
	UPDATE:										;LABEL, REINITIALISATION BEGINS FROM HERE
	if i(gksfile)==1 then								;IF SOUND FILE OPTION 1 IS CHOSEN...
	  Sfile	=	"808loopMono.wav"						;CREATE STRING VARIABLE FOR FILE NAME. (ENABLES EASY SWITCHING OF FILE)
	else										;I.E. IF SOUND FILE OPTION 2 IS CHOSEN...
	  Sfile	=	"AndItsAll.wav"							;CREATE STRING VARIABLE FOR FILE NAME. (ENABLES EASY SWITCHING OF FILE)
	endif										;END OF CONDITIONAL BRANCH
	ilen	filelen	Sfile								;DERIVE FILE DURATION IN SECONDS
	iwsize	tablei	i(gkwsize),iwsizetab						;READ THE REQUIRED WINDOW SIZE FROM THE FUNCTION TABLE 'iwsizetab'
	if gkopcode==0 then								;IF FIRST OPTION BUTTON SELECTED...
	  asig	soundin	Sfile,i(gkinskip)*ilen						;CREATE STEREO AUDIO BY READING FILE FROM DISK USING soundin
	elseif gkopcode==1 then								;IF SECOND OPTION BUTTON SELECTED...
	  asig		diskin	Sfile,kspeed,i(gkinskip)*ilen,i(gklooping)		;CREATE STEREO AUDIO BY READING FILE FROM DISK USING diskin
	else										;IF THIRD OPTION BUTTON SELECTED...
	  asig		diskin2	Sfile,kspeed,i(gkinskip)*ilen,i(gklooping),0,iwsize	;CREATE STEREO AUDIO BY READING FILE FROM DISK USING diskin2
	endif										;END OF CONDITIONAL BRANCH
	rireturn:									;RETURN FROM REINITIALISATION PASS
			out	asig*gkgain						;SEND STEREO AUDIO TO OUTPUTS
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT - ALLOWS REAL-TIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>