times_timek.csd
Written by Iain McCurdy, 2011.

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>


<CsInstruments>

sr	=	44100
kr	=	100
nchnls	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL         | WIDTH | HEIGHT | X | Y
	FLpanel	"times timek",   500,    130,    0,  0
;                                                      ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"On/Off",		1,   0,    22,    140,     30,    5,  5,    0,      1,      0,       -1
gkExit,ihExit	FLbutton	"Exit",			1,   0,    21,    140,     30,  345,  5,    0,    999,      0,       0.001
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES						WIDTH | HEIGHT | X |  Y
gidtimes			FLvalue	"Time (secs.)",     	 120,     25,   120,  60
gidtimek			FLvalue	"Time (k-cycles)",     	 120,     25,   260,  60

FLsetVal_i	1,ihOnOff
			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 220, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                         times timek                         ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"'times' and 'timek' are very similar to 'timeinsts' and      ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"'timeinstk' except that instead of providing measures of time", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"since a note began they measure time since the Csound        ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"performance began. Therefore the clocks that they use        ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"continue to increment even when no instruments are active.   ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"'times' measures time in seconds, 'timek' measures time in   ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"terms of the number of elapsed control cycles.               ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"In this example kr=100 so that after 1 second of performance ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"time, the k-cycle clock will output a value of 100 and so on.", 	1,      5,     14,    490,    20,     5, 200

			FLpanel_end

			FLrun	;RUN THE FLTK WIDGET THREAD


instr 1			;READ AND PRINT TIME
if	gkOnOff!=0	kgoto	CONTINUE	;SENSE IF FLTK INSTRUMENT ON/OFF SWITCH IS NOT OFF (IN WHICH CASE SKIP THE NEXT LINE)
turnoff						;TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:					;A LABEL
	ktimes	times				;READ TIME SINCE PERFORMANCE BEGAN IN SECONDS
	ktimek	timek				;READ TIME SINCE CSOUND PERFORMANCE BEGAN IN K-RATE CYCLES
	FLprintk2 	ktimes, gidtimes	;PRINT TIME IN SECONDS TO FLvalue BOX
	FLprintk2 	ktimek, gidtimek	;PRINT TIME IN K-RATE CYCLES TO FLvalue BOX
endin

instr	999		;EXIT CSOUND
	exitnow
endin

</CsInstruments>

<CsScore>
f 0 3600
</CsScore>

</CsoundSynthesizer>

