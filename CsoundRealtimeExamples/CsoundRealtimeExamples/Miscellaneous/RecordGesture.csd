; RecordGesture.csd
; Written by Iain McCurdy, 2014

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	10	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	1
0dbfs		=	1

FLcolor	255, 255, 255, 0, 0, 0
;			LABEL            | WIDTH | HEIGHT | X | Y
		FLpanel	"Record Gesture",   500,     90,    0,  0

;SWITCH                                         	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkRecord,gihRecord	FLbutton	"Rec/Stop",	1,    0,    22,    100,     25,     5,  5,   -1
FLsetColor2	255,100,100,gihRecord
gkPlay,gihPlay		FLbutton	"Play",		1,    0,    22,    100,     25,   110,  5,    0,      3,      0,      -1
FLsetColor2	  150,255,150,gihPlay
;VALUE_DISPLAY_BOXES		WIDTH | HEIGHT | X | Y
idval		FLvalue	"",	80,       20,    5,  60
                                                 
;SLIDERS					MIN  |  MAX  | EXP | TYPE |  DISP  | WIDTH | HEIGHT | X | Y
gkval, gihval	FLslider	"Pitch",	0,       1,     0,    23,   idval,    490,     25,    5,  35

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	0, 	gihval
		FLpanel_end

		
		;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 460, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                       Record Gesture                        ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"This example demonstrates how controller data can be recorded", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"and replayed from a function table.                          ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"Activate the 'Rec/Stop' button in order to enter a 'record   ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"ready' mode. Moving the 'Pitch' slider will start recording  ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"movements of that slider. Recording can be stopped by        ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"deactivating the 'Rec/Stop' button or else it will stop      ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"automatically when the table is full. The table size can of  ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"course be increased but in this example it currently allows  ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"for just under four minutes of recording. Record time can be ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"calculated as table_size/kr.                                 ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"This method of gesture recording can be easily adapted for   ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"the recording of midi gestures.                              ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"The slider value will be recorded on every control period,   ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"whether it has changed or not. This method is easy to        ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"implement but naturally will become rather wasteful of memory", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"if very long gestures (and/or a large number of them) are    ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"needed to be recorded. In this case it is preferrable to     ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"record controller data only when it changes from its previous", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"value. This will require data items to be time stamped and   ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"for the stored data to be appropriately parsed when played   ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"back.                                                        ", 	1,      5,     14,    490,    20,     5, 440

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE--------------------------------------------------------------------------------------------------------------------------------------------------------------------

gidata	ftgen	0,0,1048576,-2,0	; Table containing gesture data. Maximum duration recordable will be size/kr.
gisine	ftgen	0,0,4096,10,1		; A sine wave
gkndx	init	0			; Progress index initial value

instr	1	; Sense start of gesture (always on)
	ktrig	changed	gkval				; If slider is moved generate a trigger. 
	schedkwhen	ktrig*gkRecord,0,1,2,0,-1	; Start instr 2 with a held note whenever a trigger has been generated and the 'Rec/Stop' button is active.
endin

instr	2	; Record gesture
	if gkRecord==0 then				; If record button is deactivated...
	 turnoff					; ...turn this instrument off.
	endif
	gkndx	init	0				; Initialise index to zero.
	tablew	gkval,gkndx,gidata			; Write slider value to table location defined by current index.
	gkndx	=	gkndx+1				; Increment index.
	if gkndx>=ftlen(gidata) then			; If the end of the table is reached...
	 FLsetVal	1,0,gihRecord
	 turnoff					; ...turn off this instrument.
	endif
	
	; Generate a sound.
	kporttime	linseg	0,0.001,0.02
	kval	portk	gkval,kporttime
	asig	oscili	0.2,cpsoct((kval*2)+7),gisine
		outs	asig,asig	
endin

instr	3	; Playback recorded gesture
	if gkPlay==0 then				; if play button is deactivated...
	 turnoff					; ...turn this instrument off.
	endif
	kndx	init	0				; Initialise index to zero.
	kval	table	kndx,gidata			; Read value from table defined by current index.
		FLsetVal	1,kval,gihval		; Send value to slider.
	kndx	=	kndx+1				; Increment index.
	if kndx>=gkndx then				; If local index reach the last recorded gesture value in the table...
	 FLsetVal	1,0,gihRecord
	 turnoff					; ...turn this instrument off.
	endif

	; Generate a sound.
	kporttime	linseg	0,0.001,0.02
	kval	portk	gkval,kporttime
	asig	oscili	0.2,cpsoct((kval*2)+7),gisine
		outs	asig,asig	
endin

</CsInstruments>

<CsScore>
i 1 0 3600	; Sense changes in the the value slider.
e
</CsScore>

</CsoundSynthesizer>