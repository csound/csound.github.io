timeinsts_timeinstk.csd
Written by Iain McCurdy, 2008. Updated 2011.

<CsoundSynthesizer>

<CsOptions>
-odac -d
</CsOptions>


<CsInstruments>

sr	=	44100
kr	=	100	;kr LOW FOR THE PURPOSES OF DEMONSTRATING timeinstk
ksmps	=	441
nchnls	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL                 | WIDTH | HEIGHT | X | Y
	FLpanel	"timeinsts timeinstk",   500,    130,    0,  0
;                                                      ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"On/Off",		1,   0,    22,    140,     30,    5,  5,    0,      1,      0,       -1
gkExit,ihExit	FLbutton	"Exit",			1,   0,    21,    140,     30,  345,  5,    0,    999,      0,       0.001
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES						WIDTH | HEIGHT | X |  Y
gidtimes			FLvalue	"Time (secs.)",     	 120,     25,   120,  60
gidtimek			FLvalue	"Time (k-cycles)",     	 120,     25,   260,  60

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 260, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                    timeinsts timeinstk                      ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"The 'timeinsts' opcode outputs the time elapsed since the    ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"beginning of the note event for the instrument containing the", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"opcode.                                                      ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"'timeinstk' outputs the number of k-rate cycles that have    ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"occured since a note began and therefore its behaviour is    ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"dependent upon the setting of the control rate. In this      ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"example k-rate has been set low, kr=100, therefore after     ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"1 second it will output a value of 100 and so on. Experiment ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"with different settings of 'kr'. This opcode can be useful in", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"situations where it is required to know the number of times  ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"a k-rate operation has been executed since a note began.     ", 	1,      5,     14,    490,    20,     5, 240

			FLpanel_end

			FLrun	;RUN THE FLTK WIDGET THREAD


instr 1
if	gkOnOff!=0	kgoto	CONTINUE	;SENSE IF FLTK INSTRUMENT ON/OFF SWITCH IS NOT OFF (IN WHICH CASE SKIP THE NEXT LINE)
turnoff						;TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:					;A LABEL
	ktimes	timeinsts
	ktimek	timeinstk
	FLprintk2 	ktimes, gidtimes
	FLprintk2 	ktimek, gidtimek
endin

instr	999
	exitnow
endin

</CsInstruments>

<CsScore>
f 0 3600
</CsScore>

</CsoundSynthesizer>



























