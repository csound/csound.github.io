;pvswrite.csd
;Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr	= 	44100
ksmps	= 	16
nchnls	= 	1
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL        | WIDTH | HEIGHT | X | Y
	FLpanel	"pvswrite",    500,    250,    0,  0

;SWITCHES  	                         		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkwrite,ihwrite		FLbutton	"Write",	1,    0,    22,    100,     25,    5,  5,   -1
gkread,ihread		FLbutton	"Read",		1,    0,    22,    100,     25,  110,  5,    0,      2,      0,       -1
FLsetColor2	255, 255, 50, ihwrite		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihread		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES		LABEL | WIDTH | HEIGHT | X | Y
idptr			FLvalue	" ",	 70,      20,    5,  75
idspeed			FLvalue	" ",	 70,      20,    5, 125
idtrans			FLvalue	" ",	 70,      20,    5, 175
idGain			FLvalue	" ",	 70,      20,    5, 225

;SLIDERS				            		MIN   | MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X  | Y
gkptr, ihptr		FLslider 	"File Pointer",		0,       1,    0,    23,   idptr,     490,    25,     5,   50
gkspeed, ihspeed	FLslider 	"Pointer Speed",	-2,      2,    0,    23,   idspeed,   490,    25,     5,  100
gktrans, ihtrans	FLslider 	"Transpose",		0.125,   4,   -1,    23,   idtrans,   490,    25,     5,  150
gkGain, ihGain		FLslider 	"Gain",			0,       1,    0,    23,   idGain,    490,    25,     5,  200

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      1,    255,   255,   255		;NUMBERS MADE INVISIBLE

;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkPtrMode, ihPtrMode	FLbutBank	14,     1,     2,     18,     40,    225,  0,   -1
gkResType, ihResType	FLbutBank	14,     1,     2,     18,     40,    360,  0,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      5,      4,     0,     0,     0		;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Manual Pointer", 	1,       5,    12,    105,     15,   240,   1
ih		 	FLbox  	"Speed Control ", 	1,       5,    12,    105,     15,   240,  21
ih		 	FLbox  	"pvsread", 		1,       5,    12,     60,     15,   375,   1
ih		 	FLbox  	"pvoc   ", 		1,       5,    12,     60,     15,   375,  21

;SET INITIAL VALUES FOR SLIDERS 	|VALUE | HANDLE
			FLsetVal_i	 0.5,	ihGain
			FLsetVal_i	   1,	ihPtrMode
			FLsetVal_i	   1,	ihspeed
			FLsetVal_i	 0.5,	ihptr
			FLsetVal_i	 1,	ihtrans
			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     420,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          pvswrite                           ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"'pvswrite' allows you to write a streaming f-sig to a pvx    ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"file stored on disk. The stored pvx file can be accessed     ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"later during that performance or in a completely new         ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"performance. In this example the user first records a pvx    ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"file to disk using the 'Write' button to start and then stop ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"this procedure. The audio for this pvx file is taken from the", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"computer's live input. This stored file can then be replayed ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"using the 'play' button. The user can choose between either  ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"'pvsfread' (and 'pvscale') or 'pvoc' for resynthesis. 'pvoc' ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"is probably higher quality but places much more demand on the", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"CPU. There are two modes of playback: one in which a pointer ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"through the file is controlled manually and another in which ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"the user controls the playback speed. The user can also      ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"modulate the transposition of the file.                      " , 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"As the file is loaded once during playback, re-recording a   ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"new file will not overwrite the original file loaded into    ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"memory, instead performance will need to be restarted.       ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"N.b. pvswrite seems to require 0dbfs = 1 in the orchestra    ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"header.                                                      ", 	1,      5,     14,    490,    15,     5, 400
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#define	ANALYSISFILE	#"pvswriteFile.pvx"#

instr	3	;THIS INSTRUMENT CONTROLS THE TURNING ON OF INSTRUMENT 1
	ktrig	changed	gkwrite					;IF 'gkwrite' BUTTON IS SWITCHED GENERATE A 'BANG'
	if ktrig==1 then					;IF A 'BANG' HAS BEEN GENERATED...
		schedkwhen	gkwrite, 0, 0, 1, 0, 3600	;A NOTE WILL BE TRIGGERED IN INSTRUMENT 1 (BUT ONLY IF 'gkwrite' IS 'ON')
	endif							;END OF THIS CONDITIONAL BRANCH
endin

instr	1	;WRITE PVS FILE
	if	gkwrite=0	then					;IF 'gkwrite' SWITCH IS SET TO 'Off'
		turnoff							;TURN THIS INSTRUMENT
	endif								;END OF CONDITIONAL BRANCHING
	asigin		inch	1					;READ AUDIO FROM THE LIVE AUDIO INPUT
	fsigin 		pvsanal		asigin, 1024, 256, 1024, 1	;ANALYSE THE AUDIO SIGNAL THAT WAS CREATED IN INSTRUMENT 1. OUTPUT AN F-SIGNAL.      	
			pvsfwrite 	fsigin, $ANALYSISFILE
endin

instr	2
	if	gkread=0	then					;IF On/Off SWITCH IS SET TO 'Off'
		turnoff							;TURN THIS INSTRUMENT
	endif								;END OF CONDITIONAL BRANCHING
	ilen		filelen		$ANALYSISFILE
	kporttime	linseg	0,0.001,0.05
	if gkPtrMode==0 then
		kptr	portk	gkptr, kporttime
	elseif gkPtrMode=1 then
		kptr		phasor		gkspeed/ilen
	endif
	
	if gkResType==0 then
	 fsig1		pvsfread	kptr*ilen,$ANALYSISFILE
	 fsig2		pvscale		fsig1, gktrans
	 aresyn 		pvsynth  	fsig2			;RESYNTHESIZE THE f-SIGNAL AS AN AUDIO SIGNAL
        elseif gkResType==1 then
	 aresyn		pvoc		kptr*ilen, gktrans, $ANALYSISFILE
	endif
			out		aresyn*gkGain
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT ALLOWS REALTIME PLAYING FOR UP TO 1 HOUR
i 3 0 3600
</CsScore>

</CsoundSynthesizer>