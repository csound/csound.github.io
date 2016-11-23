; RecordGesture.csd
; Written by Iain McCurdy, 2014

<CsoundSynthesizer>

<CsOptions>
-odac -dm0 -B256
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	8	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	1
0dbfs		=	1

FLcolor	255, 255, 255, 0, 0, 0
;			LABEL            | WIDTH | HEIGHT | X | Y
		FLpanel	"Record Gesture",   500,     90,    0,  0

;SWITCH                                         	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkRecord,gihRecord	FLbutton	"Rec/Stop",	1,    0,    22,    100,     25,     5,  5,   -1
FLsetColor2	255,100,100,gihRecord
gkPlay,gihPlay		FLbutton	"Play",		1,    0,    22,    100,     25,   110,  5,   -1
FLsetColor2	  150,255,150,gihPlay
gksave,ihsave		FLbutton	"Save to HD",	1,    0,    21,    100,     25,   290,  5,    0,    4,  0,  0
gkload,ihload		FLbutton	"Load from HD",	1,    0,    21,    100,     25,   395,  5,    0,    5,  0,  0    


;VALUE_DISPLAY_BOXES		WIDTH | HEIGHT | X | Y
idval		FLvalue	"",	80,       20,    5,  60
                                                 
;SLIDERS					MIN  |  MAX  | EXP | TYPE |  DISP  | WIDTH | HEIGHT | X | Y
gkval, gihval	FLslider	"Pitch",	0,       1,     0,    23,   idval,    490,     25,    5,  35

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	0, 	gihval
		FLpanel_end

		
		;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 600, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                Record Controller Gesture                    ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"This example demonstrates how controller data can be recorded", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"and replayed from a function table.                          ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"Set the 'Pitch' slider to the desired initial value. Press   ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"'Record', move the 'Pitch' slider to create the gesture and  ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"press 'Record' again to stop recording. This gesture has been", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"saved to a function table as a series of data events         ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"consisting of a time stamp (time since the beginning of the  ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"recording) and the value associated with that time event.    ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"Additionally the duration of the complete gesture is stored  ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"at the first index location. This might come in useful when  ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"replaying the gesture as the final event will not necesarily ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"correspond with when the recording was stopped.              ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"Data is stored in sequential locations in a GEN 2 function   ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"table and the structure is: 'total duration', 'initial       ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"value', 'time stamp 1', 'value 1', 'time stamp 2', 'value 2' ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"and so on...                                                 ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"The code for recording controller gestures and for playback  ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"of stored controller gestures is encapsulated within UDOs    ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"for easy transplantation into other projects.                ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"The function table used for storage of data should be large  ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"enough to hold all the event data expected. It is impossible ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"to correlate table size to gesture duration in seconds as    ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"this will be dependent upon event density: how much the      ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"controller is moved. If the controller is left stationary, no", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"events are created.                                          ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"Recorded gestures can also be backed up on the hard drive    ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"for recall in a later session. This is done using the ftsave ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"and ftload opcodes.                                          ", 	1,      5,     14,    490,    20,     5, 580

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE--------------------------------------------------------------------------------------------------------------------------------------------------------------------

gidata	ftgen	1,0,1048576,-2,0	; Table containing gesture data. Maximum duration recordable will be size/kr.

opcode RecordController,0,Ki
	kval,ifn	xin

	i_	ftgen	1,0,ftlen(ifn),-2,0		; Table containing gesture data. Refill with zeros each time instrument is restarted.

	; write initial value
	tableiw	i(kval),1,ifn				; write initial value at index 1. (Index 0 will be used be storing the complete gesture duration.)
	kndx	init	2				; Initialise index
	
	kTime	timeinsts				; time since this instrument started in seconds
	
	if changed(kval)==1 && kndx<=(ftlen(ifn)-2) && kTime>0 then	; Write a data event only when the input calue changes
	 tablew	kTime, kndx, ifn			; Write timestamp to table location defined by current index.
	 tablew	kval, kndx + 1, ifn			; Write slider value to table location defined by current index.
	 kndx	=	kndx + 2			; Increment index 2 steps (one for time, one for value).
	endif

	krel	release					; sense note release
	if(krel==1) then				; if we are in the final k-cycle before the note ends
	 tablew	kTime,0,ifn				; write total gesture duration into the table at index 0
	endif

endop

opcode PlaybackController,k,i
	ifn	xin
	
	; read first value
	ival	table	1,ifn				; initial controller value read from index 1
	kval	init	ival				; initial value for k-rate output
	
	kndx	init	2				; Initialise index to first non-zero timestamp
	kTime	timeinsts				; time in seconds since this note started
	
	iTimeStamp	tablei	2,ifn			; first non-zero timestamp
	kTimeStamp	init	iTimeStamp		; initialise k-variable for first non-zero timestamp
	if kTime>=kTimeStamp && kTimeStamp>0 then	; if we have reached the timestamp value...
	 kval	table	kndx+1,ifn			; ...Read value from table defined by current index.
	 kTimeStamp	table	kndx+2,ifn		; Read next timestamp
	 kndx	limit	kndx+2, 0, ftlen(ifn)-2		; Increment index. (Always 2 steps: timestamp and value.)
	endif
	
		xout	kval
endop

instr	1	; cleaner way to start instruments than using FLbutton built-in mechanism
	kOnTrig	trigger	gkRecord,0.5,0		; trigger when button value goes from off to on 
	schedkwhen	kOnTrig,0,0,2,0,-1	; start instrument with a held note when trigger received
	kOnTrig	trigger	gkPlay,0.5,0		; trigger when button value goes from off to on
	schedkwhen	kOnTrig,0,0,3,0,-1	; start instrument with a held note when trigger received
	
endin

instr	2	; Record gesture
	if gkRecord==0 then				; If record button is deactivated...
	 turnoff					; ...turn this instrument off.
	endif

		RecordController	gkval,gidata	; call UDO
	
	; Generate a sound.
	kporttime	linseg	0,0.001,0.02
	kval	portk	gkval,kporttime
	asig	poscil	0.2,cpsoct((kval*2)+7)
		outs	asig,asig	
endin

instr	3	; Playback recorded gesture
	if gkPlay==0 then				; if play button is deactivated...
	 turnoff					; ...turn this instrument off.
	endif
	
	kval	PlaybackController	gidata

 		FLsetVal_i	i(kval),gihval			; send initial value to controller
		FLsetVal	changed(kval),kval,gihval	; Send values to slider when needed.


	; Generate a sound.
	kporttime	linseg	0,0.001,0.02
	kval	portk	gkval,kporttime
	asig	poscil	0.2,cpsoct((kval*2)+7)
		outs	asig,asig	

	; stop note when end of table reached
	kTime	timeinsts				; time in seconds since this note started
	iRecTime	tablei	0,gidata		; read complete gestire duration from index zero
	if kTime>=iRecTime then				; if we have reach complete duration of gesture...
	 FLsetVal	1,0,gihPlay			; deactivate play button (which will in turn, turn off this note.)
	endif
endin


instr	4	; save table
	ftsave "ControllerData.txt", 0, gidata

endin


instr	5	; load table
	ftload "ControllerData.txt", 0, gidata
endin

</CsInstruments>

<CsScore>
i 1 0 3600	; Start record or play instruments
e
</CsScore>

</CsoundSynthesizer>