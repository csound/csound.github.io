rtclock.csd
Written by Iain McCurdy, 2008

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>


<CsInstruments>

sr	=	44100
ksmps	=	16
nchnls	=	2

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL     | WIDTH | HEIGHT | X | Y
	FLpanel	"rtclock",   500,    130,    0,  0
;                                                      ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"On/Off",		1,   0,    22,    150,     25,    5,  5,    0,      1,      0,       -1
gkExit,ihExit	FLbutton	"Exit",			1,   0,    21,    150,     25,  345,  5,    0,    999,      0,       0.001
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES					WIDTH | HEIGHT | X |  Y
gidclock			FLvalue	"CLOCK",     	 100,     25,   200,  60

FLsetVal_i	1, ihOnOff	

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 220, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          rtclock                            ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"'rtclock' is an opcode that outputs the time value           ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"corresponding to the time elapsed since the beginning of the ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"current Csound performance.                                  ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"In this example the 'On/Off' button turns on and off the     ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"instrument that updates the 'CLOCK' display. You will notice ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"that while this instrument is off the clock continues to run.", 	1,      5,     14,    490,    20,     5, 140
ih	  	 	FLbox  	"The resolution of the clock output varies from operating     ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"system to operating system.                                  ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"The 'rtclock' opcode is very similar in function to the      ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"'times' opcode.                                              ", 	1,      5,     14,    490,    20,     5, 200

				FLpanel_end



			FLrun	;RUN THE FLTK WIDGET THREAD


instr 1
if	gkOnOff!=0	kgoto	CONTINUE	;SENSE IF FLTK INSTRUMENT ON/OFF SWITCH IS NOT OFF (IN WHICH CASE SKIP THE NEXT LINE)
turnoff						;TURN THIS INSTRUMENT OFF IMMEDIATELY
CONTINUE:					;A LABEL

	ktime 		rtclock
	kupdate		metro	30		;RATE AT WHICH DISPLAY UPDATE IS PEGGED BACK
	if kupdate==1 then
	 FLprintk2 	ktime, gidclock
	endif
endin

instr	999
	exitnow
endin

</CsInstruments>

<CsScore>
f 0 3600
</CsScore>

</CsoundSynthesizer>



























