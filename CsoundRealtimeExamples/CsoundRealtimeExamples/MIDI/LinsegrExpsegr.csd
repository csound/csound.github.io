LinsegrExpsegr.csd
Written by Iain McCurdy 2006. Updated 2011.

<CsoundSynthesizer>                                

<CsOptions>
-odac -Ma -dm0 
</CsOptions>    

<CsInstruments>

sr 	= 	44100	;SAMPLE RATE
ksmps 	= 	4	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 	= 	1	;NUMBER OF CHANNELS (1=MONO)
0dbfs	=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
		FLpanel	"linsegr/expsegr", 500, 160, 0, 0                   

;DISPLAY FLTK VALUES			WIDTH | HEIGHT | X  | Y
idIniLev		FLvalue	"",	60,      20,     5,  60
idAttTim		FLvalue	"",	60,      20,    70,  60
idAttLev		FLvalue	"",	60,      20,   135,  60
idDecTim		FLvalue	"",	60,      20,   200,  60
idSusLev		FLvalue	"",	60,      20,   265,  60
idRelTim		FLvalue	"",	60,      20,   330,  60
idRelLev		FLvalue	"",	60,      20,   395,  60

;KNOBS							MIN | MAX | EXP|  TYPE |  DISP    | WIDTH | X | Y
gkIniLev,ihIniLev	FLknob		"Ini.Lev.",	0,     1,    0,    1,   idIniLev,     40,    5+10,  5             
gkAttTim,ihAttTim	FLknob		"Att.Tim.",	0.001, 8,    0,    1,   idAttTim,     40,   70+10,  5	;ENVELOPE SEGMENT TIMES OF ZERO COULD CAUSE CLICKS WHEN USED AS AMPLITUDE ENVELOPE SEGMENTS            
gkAttLev,ihAttLev	FLknob		"Att.Lev.",	0,     1,    0,    1,   idAttLev,     40,  135+10,  5             
gkDecTim,ihDecTim	FLknob		"Dec.Tim.",	0.001, 8,    0,    1,   idDecTim,     40,  200+10,  5             
gkSusLev,ihSusLev	FLknob		"Sus.Lev.",	0,     1,    0,    1,   idSusLev,     40,  265+10,  5             
gkRelTim,ihRelTim	FLknob		"Rel.Tim.",	0.001, 8,    0,    1,   idRelTim,     40,  330+10,  5             
gkRelLev,ihRelLev	FLknob		"Rel.Lev.",	0,     1,    0,    1,   idRelLev,     40,  395+10,  5             

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,    255,   255,   255
;BUTTON BANKS				TYPE | NUMX | NUMY | WIDTH | HEIGHT | X   | Y  | OPCODE | INS | STARTTIM | DUR
gkEnvType, ihEnvType	FLbutBank	14,     1,     2,     18,      40,    10,  101,   -1	
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"linsegr",	1,       1,    14,     50,     20,    30,  100
ih		 	FLbox  	"expsegr",	1,       1,    14,     50,     20,    30,  120

;INITIALISE VALUATORS		VALUE | HANDLE
		FLsetVal_i	0, 	ihIniLev
		FLsetVal_i	0.3, 	ihAttTim
		FLsetVal_i	1, 	ihAttLev
		FLsetVal_i	0.3, 	ihDecTim
		FLsetVal_i	0.5, 	ihSusLev
		FLsetVal_i	2, 	ihRelTim
		FLsetVal_i	0, 	ihRelLev
                                                                                                                                                   
		FLpanel_end	;END OF PANEL CONTENTS




;INSTRUCTIONS AND INFO PANEL                   WIDTH | HEIGHT | X | Y
				FLpanel	"info", 515,    600,   515, 0
				FLscroll        515,    600,    0,  0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"   linsegr / expsegr  - envelopes with MIDI release stages   ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"We can still use the traditional envelope generating opcodes ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"line/expon/linseg/expseg in MIDI activated instruments but   ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"the common practise of employing p3 (note duration) within   ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"the formation of an envelope in order to make the envelope's ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"shape dependent upon note duration in some way will not be   ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"possible as Csound will not know note duration until the MIDI", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"key is lifted and a note-off received. In actual fact p3 will", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"have a value of '-1' to indicate a held note.                ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"The opcodes 'linsegr' (for straight line segments) and       ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"'expsegr' (for exponential segments) will hold their         ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"penultimate break-point value until a MIDI note off is       ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"received at which point the final segment will proceed.      ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"The final three arguments in a linsegr/expsegr can, from the ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"perspective of a playable instrument, be regarded as         ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"'sustain time', 'release time' and 'release level'.          ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"As with expon and expseg, when using expsegr, break point    ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"values of zero are illegal and must be alike in sign. Values ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"close to zero can be used instead and this DC offset can be  ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"removed subsequently using subtraction if required. (transegr", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"has no such restrictions.)                                   ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"The maximum allowed value for the release time is 32768/kr.  ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"Exceeding this limit will cause the envelope to not function ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"properly.                                                    ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"In this example an ADSR envelope is created with all levels  ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"and durations for the envelope available for editing.        ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"The abbreviations are for:                                   ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"- Initial Level                                              ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"- Attack Time                                                ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"- Attack Level                                               ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"- Decay Time                                                 ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"- Sustain Level                                              ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"- Release Time                                               ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"- Release Level                                              ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"This envelope is used to control amplitude so 'Initial Level'", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"and 'Release Level' should probably remain at zero to prevent", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"audio clicks. Time durations of zero are prevented for the   ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"same reason.                                                 ", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"The user can swap between 'linsegr' and 'expsegr' as the     ", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"envelope generator for comparison. In the case of an         ", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"amplitude envelope, 'expsegr' will probably give more natural", 	1,      5,     14,    490,    20,     5, 820
ih		 	FLbox  	"sounding results.                                            ", 	1,      5,     14,    490,    20,     5, 840
ih		 	FLbox  	"Other envelope generating opcodes with MIDI release sensing  ", 	1,      5,     14,    490,    20,     5, 860
ih		 	FLbox  	"include 'transegr', 'linenr' and 'madsr'.                    ", 	1,      5,     14,    490,    20,     5, 880
				FLscroll_end
				FLpanel_end
				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

giwave	ftgen	0,0,4096,10,1,1/4,1/9,1/16,1/25,1/36,1/49,1/64,1/81	;A RICH WAVEFORM

instr	1	; SIMPLE INSTRUMENT ACTIVATED VIA A CONNECTED MIDI KEYBOARD
	icps	cpsmidi		;READ IN MIDI NOTE NUMBER AND CONVERT TO CYCLES PER SECOND VALUE
	iamp	ampmidi	0.2	;READ IN MIDI VELOCITY. RESCALE TO THE RANGE 0 - 0.2
	
	aLinEnv	linsegr	i(gkIniLev),      i(gkAttTim),i(gkAttLev),      i(gkDecTim),i(gkSusLev),      i(gkRelTim),i(gkRelLev)
	aExpEnv	expsegr	i(gkIniLev)+0.001,i(gkAttTim),i(gkAttLev)+0.001,i(gkDecTim),i(gkSusLev)+0.001,i(gkRelTim),i(gkRelLev)+0.001	;BREAK POINT VALUES OF ZERO ARE NOT PERMITTED WITH expsegr SO AN OFFSET IS ADDED TO EACH VALUE IN CASE ITS CORRESPONDING FLTK KNOB IS SET TO ZERO
	if gkEnvType=0 then		;IF linsegr TYPE IS CHOSEN FROM THE FLTK BUTTON BANK...
	  aenv	=	aLinEnv		;...aenv ADOPTS THE SHAPE OF ENVELOPE aLinEnv
	else				;OTHERWISE (I.E. expsegr TYPE HAS BEEN CHOSEN)
	  aenv	=	aExpEnv		;...aenv ADOPTS THE SHAPE OF ENVELOPE aExpEnv
	endif				;END OF CONDITIONAL BRANCH
	;OUTPUT	OPCODE	AMPLITUDE | FREQUENCY | FUNCTION_TABLE
	asig	poscil	iamp*aenv,     icps,        giwave
		out	asig	;SEND AUDIO OUTPUT OF OSCILLATOR TO THE OUTPUT
endin

</CsInstruments>

<CsScore>
f 0 600	; THIS LINE FUNCTIONS AS A DUMMY SCORE EVENT AND ALLOWS REALTIME MIDI PLAYING FOR 10 MINUTES
</CsScore>

</CsoundSynthesizer>