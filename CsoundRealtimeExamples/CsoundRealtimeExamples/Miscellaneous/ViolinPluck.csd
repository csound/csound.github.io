ViolinPluck.csd
Written by Iain McCurdy, 2014.

<CsoundSynthesizer>

<CsOptions>
-odac -dm0 -Q0 -+rtmidi=mme

; Use -Q flag for MIDI output
; -Q0

</CsOptions>

<CsInstruments>

sr 		= 	44100
ksmps 		= 	8
nchnls 		= 	2
0dbfs		=	1


; string tunings (high to low)
giTuning	ftgen	0,0,-4,-2,		76,	69,	62,	55
; fret positions (high to low)
gifrets		ftgen	0,0,-4,-2,		0,	0,	0,	0,	0,	0
; play
gimute		ftgen	0,0,-4,-2,		0,	0,	0,	0,	0,	0

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL     | WIDTH | HEIGHT | X | Y
		FLpanel	"Violin",    840,    180,    0,  0

;SWITCHES                       			ON | OFF | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE | INS | STARTTIM | IDUR
gkPluck,gihPluck	FLbutton	"Pluck",	1,    0,     2,    100,     25,    5,   5,    -1
FLsetColor2	255, 255, 50, gihPluck		;SET SECONDARY COLOUR TO YELLOW
gkMidiOut,gihMidiOut	FLbutton	"MidiOut",	1,    0,     2,    100,     25,  320,   5,    -1
FLsetColor2	255, 255, 50, gihMidiOut	;SET SECONDARY COLOUR TO YELLOW


;TEXT BOXES			MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkgap,  ihgap	FLtext	"Gap", 	0,    10,   0.01,   1,      50,     20,   150,  5
gkdur,  ihdur	FLtext	"Dur.", 0,    10,   0.01,   1,      50,     20,   210,  5
FLsetVal_i	0.1,ihgap
FLsetVal_i	5,ihdur

;KNOBS							MIN | MAX | EXP | TYPE | DISP | WIDTH | X | Y
gkamp, ihamp	FLknob 		"Level", 		0,    1,      0,    1,    -1,    35,   270, 5
FLsetVal_i	0.25,ihamp



/* TUNING */
iy	=	70
;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X  | Y
ih		 	FLbox  	"Tuning", 	1,      1,     14,     80,    15,     5,  iy-15
#define SETUP(N)
#
;COUNTERS				MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X  |  Y    | OPCODE 
gkNote$N, gihNote$N	FLcount  "",	-1,   127,    1,     12,      1,     80,     20,    5,  iy+5,   -1
FLsetAlign	5,gihNote$N
iNote	table	$N-1,giTuning
FLsetVal_i	iNote,gihNote$N
iy	=	iy + 20
#
$SETUP(1)
$SETUP(2)
$SETUP(3)
$SETUP(4)

iy	=	70
;TEXT BOXES				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih	 FLbox  " ",   			8,     10,    14,      4,     87,   176,  iy	; nut


ix	=	120
ispace	=	20
;TEXT BOXES					TYPE | FONT | SIZE |    WIDTH     | HEIGHT | X | Y
ih		 	FLbox  	"Mute", 	1,      1,     14,       40,          15,   112, iy-17
;SWITCHES                       			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkmute1,gihmute1		FLbutton	"",	1,    0,     2,     20,     25,   ix, iy,    -1
FLsetColor2	255,50,50,gihmute1
gkmute2,gihmute2		FLbutton	"",	1,    0,     2,     20,     25,   ix, iy+ispace,    -1
FLsetColor2	255,50,50,gihmute2
gkmute3,gihmute3		FLbutton	"",	1,    0,     2,     20,     25,   ix, iy+(ispace*2),    -1
FLsetColor2	255,50,50,gihmute3
gkmute4,gihmute4		FLbutton	"",	1,    0,     2,     20,     25,   ix, iy+(ispace*3),    -1
FLsetColor2	255,50,50,gihmute4

ix		=	150
iNButtons	=	15	;7
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)
gkStr1, gihStr1		FLbutBank	4,    iNButtons,     1,       40*iNButtons,           30,   ix, iy,   0,6,0,0,1
gkStr2, gihStr2		FLbutBank	4,    iNButtons,     1,       40*iNButtons,           30,   ix, iy+ispace,   0,6,0,0,2
gkStr3, gihStr3		FLbutBank	4,    iNButtons,     1,       40*iNButtons,           30,   ix, iy+(ispace*2),   0,6,0,0,3
gkStr4, gihStr4		FLbutBank	4,    iNButtons,     1,       40*iNButtons,           30,   ix, iy+(ispace*3),   0,6,0,0,4

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

/* NOTE OUTPUT */
ix	=	750
;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X  | Y
ih		 	FLbox  	"Output", 	1,      1,     14,     80,    15,    ix-17,  iy-12
;TEXT BOXES				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
gihOutNote1	 	FLbox  	"", 	1,      1,     14,    50,    20,     ix,  5+iy
gihOutNote2	 	FLbox  	"", 	1,      1,     14,    50,    20,     ix,  5+iy+ispace
gihOutNote3	 	FLbox  	"", 	1,      1,     14,    50,    20,     ix,  5+iy+(ispace*2)
gihOutNote4	 	FLbox  	"", 	1,      1,     14,    50,    20,     ix,  5+iy+(ispace*3)


		FLpanel_end                                                                                                       
                                                                                                                                               
				FLrun	;RUN THE FLTK WIDGET THREAD                                                                              
;END OF FLTK INTERFACE CODE-------------------------------------------------------------------------------------------------------------------------



opcode	MIDI_Note_to_String,S,i
 inum		xin
 strset 0,	"C"				; Strings for the notes of the chromatic scale linked to integer values
 strset 1,	"C#"
 strset 2,	"D"
 strset 3,	"D#"
 strset 4,	"E"
 strset 5,	"F"
 strset 6,	"F#"
 strset 7,	"G"
 strset 8,	"G#"
 strset 9,	"A"
 strset 10,	"A#"
 strset 11,	"B"
 Snote	strget	inum % 12		; Derive note name string from modulus value
 ioct		=	int(inum/12) - 1	; Derive octave number
 SNoteOct	sprintf	"%s%i",Snote,ioct	; Concatanate note name and octave number and create a new string
 		xout	SNoteOct
endop

instr	1	; sense mouse position and velocity and trigger plucks when appropriate

 ktrig	trigger	gkPluck,0.5,0

	
#define PLUCK_STRING(N)
	#
	schedkwhen	ktrig*(1-gkmute$N),0,0,2+($N/10),gkgap*(4-$N),gkdur, $N	; trigger a 'pluck'
	#
	;
	$PLUCK_STRING(1)						; expand the macro for each of the six strings
	$PLUCK_STRING(2)
	$PLUCK_STRING(3)
	$PLUCK_STRING(4)
endin

giDampMap	ftgen	0,0,128,-27, 0,0.9, 36,0.9, 55,0.85, 76,0.55, 127,0.55

instr	2	; string pluck
	if gkPluck==0 then
	 turnoff
	endif
	
	kfret	table	p4-1,gifrets					; read fret position from table
	ktrig	changed	kfret
	if ktrig==1 then
	 reinit RESTART_NOTE
	endif
	RESTART_NOTE:
	inum	table	p4-1,giTuning					; read open string note from table
	ifret	table	p4-1,gifrets					; read fret position from table

	idamp	tablei	inum+ifret,giDampMap				; string damping factor
	iplk	=	0.1
	kpick	=	0.3						; pick up position
	asig	wgpluck2	iplk, gkamp, cpsmidinn(inum+ifret), kpick, idamp	; use string model, wgpluck
	aenv		linsegr	0, 0.0008, 1, p3-0.1008, 0, 0.1, 0	; amplitude envelope. Attack removes excessive 'click'. Decays to nothing across note duration (p3). Short release stage prevents click if a note is interrupted.
	asig	=	asig*aenv					; apply amplitude envelope and plucking velocity
		outs	asig, asig

	if i(gkMidiOut)==1 then
	 ;**MIDI OUTPUT**  without -Q in <CsOptions> this output will go nowhere
	 noteondur 1, inum+ifret, 100, p3			
	endif

	krelease	release
	FLsetVal krelease,0,gihPluck
endin

instr	3	; (always on) if a note counter value changes update its value in the tuning table
	; a macro is created to prevent code repetition which is then expanded six times, once for each string
#define	CHANGED_TUNING(N)
	#
	ktrig$N	changed	gkNote$N,gkStr$N	; generate a trigger if the counter for this string is changed
	if ktrig$N==1 then			; if counter for this string has been changed 
 	 tablew	gkNote$N,$N-1,giTuning		; write new value into table
	 reinit	UPDATE_LABEL$N
	 ;event	"i",4,0,0			; call instrument 4 (which updates the label (note name) in line with the note number change
	endif
	UPDATE_LABEL$N:
	iTuning	=	i(gkNote$N)
	SNoteOct$N	MIDI_Note_to_String	iTuning
	FLsetText "                    ", gihNote$N	;WRITE THE NOTE NAMES INTO THE FLTK PANEL		
	FLsetText SNoteOct$N, gihNote$N	;WRITE THE NOTE NAMES INTO THE FLTK PANEL		

	iOutNote=	i(gkNote$N) + i(gkStr$N)
	SNoteOct$N	MIDI_Note_to_String	iOutNote
	FLsetText "                    ", gihOutNote$N	;WRITE THE NOTE NAMES INTO THE FLTK PANEL		
	FLsetText SNoteOct$N, gihOutNote$N	;WRITE THE NOTE NAMES INTO THE FLTK PANEL		

	rireturn
	#
	$CHANGED_TUNING(1)
	$CHANGED_TUNING(2)
	$CHANGED_TUNING(3)
	$CHANGED_TUNING(4)
endin


instr	6	; fret position changed
#define	SET_FRET_TABLE(N)
	#
	tableiw	i(gkStr$N),$N-1,gifrets
	#
	$SET_FRET_TABLE(1)
	$SET_FRET_TABLE(2)
	$SET_FRET_TABLE(3)
	$SET_FRET_TABLE(4)
endin

</CsInstruments>

<CsScore>
i 1 0 [60*60*24*7]	; trigger plucks when required
i 3 0 [60*60*24*7]	; sense changes of note number counters
</CsScore>

</CsoundSynthesizer>