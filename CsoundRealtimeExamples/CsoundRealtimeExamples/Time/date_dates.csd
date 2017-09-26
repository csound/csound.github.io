;Written by Iain McCurdy, 2008

<CsoundSynthesizer>

<CsOptions>
-s -dm0
</CsOptions>


<CsInstruments>

sr	=	44100
ksmps	=	128
nchnls	=	2

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		FLcolor		255, 255, 255, 0, 0, 0
;		LABEL        | WIDTH | HEIGHT | X | Y
	FLpanel	"date, dates",   500,    100,    0,  0
;BUTTONS                                               			ON | OFF | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE | INS | STARTTIM | IDUR
gkUpdate,ihUpdate		FLbutton	"Manual Update",	1,    0,    21,    150,     28,    50,  5,    0,      2,      0,       0.01
gkAutoUpdate,ihAutoUpdate	FLbutton	"Auto-Update",		1,    0,    22,    150,     28,   300,  5,    0,      1,      0,       -1
FLsetColor2	255, 255, 50, ihAutoUpdate		;SET SECONDARY COLOUR TO YELLOW

;VALUE BOXES					 			MIN | MAX | STEP  | TYPE | WIDTH | HEIGHT | X  | Y
gkdate,  gihdate		FLtext		"Date (secs.)", 	0,     1,  .0001,     1,    200,     20,   25,   50

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
gihdates		 	FLbox  	"", 	1,      5,     14,    200,    20,   275,  50
FLsetColor	200,200,255,gihdates

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 180, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                        date, dates                          ", 	1,       5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,       5,     14,    490,    15,     5,  20
ih		 	FLbox  	"The 'date' opcode outputs at i-rate the number of seconds    ", 	1,       5,     14,    490,    15,     5,  40
ih		 	FLbox  	"since January 1st 1970 (the beginning of the current epoch.  ", 	1,       5,     14,    490,    15,     5,  60
ih		 	FLbox  	"The 'dates' opcode parses this information to output the same", 	1,       5,     14,    490,    15,     5,  80
ih		 	FLbox  	"value as a string giving day, month, date, time (hours,      ", 	1,       5,     14,    490,    15,     5, 100
ih		 	FLbox  	"minutes and seconds) and year. In the case of 'dates' the    ", 	1,       5,     14,    490,    15,     5, 120
ih		 	FLbox  	"user can pass the opcode an explicit number of seconds since ", 	1,       5,     14,    490,    15,     5, 140
ih		 	FLbox  	"1970 or allow it to read from the computer's system clock.   ", 	1,       5,     14,    490,    15,     5, 160



				FLpanel_end

			FLrun	;RUN THE FLTK WIDGET THREAD

instr	1	;AUTO UPDATE - TRIGGERS INSTR 2
	if	gkAutoUpdate=0	then
		turnoff
	endif
	ktrig	metro	50
	schedkwhen	ktrig, 0, 0, 2, 0, 0.01
endin

instr	2	
	idate_secs date				;READ DATE SINCE 1ST JANUARY 1970 IN SECONDS
	FLsetVal_i 	idate_secs, gihdate	;SEND 'date' READING TO FL VALUE BOX
	Sdate	dates				;READ DATE SINCE 1ST JANUARY 1970 AS A STRING
	FLsetText Sdate, gihdates		;SEND 'dates' STRING TO FL TEXT BOX
endin

</CsInstruments>

<CsScore>
i 2 0 0.01	;
f 0 3600	;DUMMY SCORE EVENT
</CsScore>

</CsoundSynthesizer>



























