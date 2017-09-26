DiskRecAndPLayback.csd
Written by Iain McCurdy, 2008. Revised 2011.

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr 	= 	44100	
ksmps 	= 	10
nchnls 	= 	1

		FLpanel	"Disk Record->Playback (No Looping)", 170, 50, 0, 0

;SWITCHES                                      					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
FLcolor	250,250,250,255,0,0	;RED
gkRecord,gihRecord	FLbutton	"@circle",				1,    0,     2,     50,     30,    10, 10,    0,      1,      0,      0.001
FLcolor	250,250,250,0,0,255	;BLUE
gkPause,gihPause	FLbutton	"@||",					1,    0,     2,     50,     30,    60, 10,   -1
FLcolor	250,250,250,0,255,0	;GREEN
gkPlay,gihPlay		FLbutton	"@>",					1,    0,     2,     50,     30,   110, 10,    0,      2,      0,      -1

		FLpanel_end	; END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 320, 182, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"         Record Audio to Disk With Playback (Once)           ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"When it is required to record long sections of audio for     ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"playback or for storage for later retrieval, then recording  ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"to function tables will not be sufficient. In this situation ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"it is necessary to record audio to the computers hard disk   ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"(function table are merely stored temporarily in RAM).       ", 	1,      5,     14,    490,    15,     5, 120
ih	  	 	FLbox  	"In this example recording audio to disk is implemented using ", 	1,      5,     14,    490,    15,     5, 140
ih	  	 	FLbox  	"the fout opcode. Playback is implemented using the diskin2   ", 	1,      5,     14,    490,    15,     5, 160
ih	  	 	FLbox  	"opcode. Playback will play the entire recording back once    ", 	1,      5,     14,    490,    15,     5, 180
ih	  	 	FLbox  	"(unless playback is deactivated).                            ", 	1,      5,     14,    490,    15,     5, 200
ih	  	 	FLbox  	"The recording will be stored as '32BitRecording.raw' in the  ", 	1,      5,     14,    490,    15,     5, 220
ih	  	 	FLbox  	"default location for file output storage.                    ", 	1,      5,     14,    490,    15,     5, 240
ih	  	 	FLbox  	"In this example file format is 32 bit floats at 44100. Care  ", 	1,      5,     14,    490,    15,     5, 260
ih	  	 	FLbox  	"always needs to be taken that file storage format and        ", 	1,      5,     14,    490,    15,     5, 280
ih	  	 	FLbox  	"playback format correspond.                                  ", 	1,      5,     14,    490,    15,     5, 300

				FLpanel_end

		FLrun		; RUN THE WIDGET THREAD!

gitablelen	init	1048576
gkrecdur	init	0

instr	1	;TRIGGERED BY RECORD BUTTON. SENSES OF RECORDING IS ON OR OFF AND TURNS ON OR OFF THE RECORDING INSTRUMENT (3) ACCORDINGLY
	if i(gkRecord)=1 then		;IF RECORD BUTTON IS ON...
		turnon 3		;TURN ON INSTRUMENT 3
	elseif i(gkRecord)=0 then	;OR ELSE IF RECORD BUTTON IS OFF...
		turnoff2 3,0,0		;TURNOFF INSTRUMENT 3
	endif				;END OF THIS CONDITIONAL BRANCH
endin
		
instr	2	;PLAYBACK INSTRUMENT
	if	gkPlay=0	then		;IF PLAY BUTTON IS DEACTIVATED THEN...
		turnoff				;...TURNOFF THIS INSTRUMENT
	endif					;END OF CONDITIONAL BRANCH
	
	if	gkPause!=1	then		;IF PAUSE BUTTON IS NOT ACTIVATED... 
	  asig	diskin2		"32BitRecording.raw",1	;PLAY AUDIO FROM FILE
	  	out		asig		;SEND AUDIO TO OUTPUT

	  kplaydur	line	0,1,1		;CREATE A RISING VALUE USED AS A TIMER
	  if	kplaydur>=gkrecdur	then	;IF END OF RECORDING IS REACHED...
	    FLsetVal	1, 0, gihPlay		;...DEACTIVATE PLAY BUTTON AND THEN -
	    turnoff				;- TURN OFF THIS INSTRUMENT IMMEDIATELY.
	  endif					;END OF CONDITIONAL BRANCH
	endif					;END OF CONDITIONAL BRANCH
endin

instr	3	;RECORD
	if	gkPause!=1	then		;IF PAUSE BUTTON IS NOT ACTIVATED...
	  ain	inch	1			;READ AUDIO FROM LIVE INPUT CHANNEL 1
	  fout "32BitRecording.raw", 6, ain	;WRITE MONO AUDIO TO A 32 BIT HEADERLESS FILE (TYPE:6)
	  gkrecdur	line	0,1,1		;GLOBAL VARIABLE USED TO REGISTER THE DURATION OF THE CURRENTLY RECORDED FILE
	endif					;END OF CONDITIONAL BRANCHING	
endin

</CsInstruments>

<CsScore>
f 0 3600
</CsScore>

</CsoundSynthesizer>
