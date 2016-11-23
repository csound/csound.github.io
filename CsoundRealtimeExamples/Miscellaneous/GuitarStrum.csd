GuitarStrum.csd
Written by Iain McCurdy, 2013

This example implements a virtual strumming guitar. Strumming is performed by moving the mouse across the strings. 
The faster the mouse is moved the harder (and therefore louder) the strings will be plucked.
The sound of the plucked string will also depend upon were along the length of the string it was plucked.
Strings can be plucked up or down and touching a string with the mouse will mute it.

Fretting is performed on the virtual fret board. If the mute button for a string is active and if that string is open (un-fretted) then that string will not sound.
A number of chord presets are provided.
The strings can also be retuned to create alternative and so-called open tunings.

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100
ksmps 		= 	16
nchnls 		= 	2
0dbfs		=	1

giStringLen	=	1000	; String length in pixels.
giPanelHeight	=	700
giBorderWidth	=	50
giStringSpacing	=	40
giFirstString	=	(giPanelHeight-(5*giStringSpacing))*0.5

; string locations:
giStringY	ftgen	0,0,-6,-2,giFirstString,giFirstString+giStringSpacing,giFirstString+(giStringSpacing*2),giFirstString+(giStringSpacing*3),giFirstString+(giStringSpacing*4),giFirstString+(giStringSpacing*5)

; string tunings (high to low)
giTuning	ftgen	0,0,-6,-2,		64,	59,	55,	50,	45,	40
; fret positions (high to low)
gifrets		ftgen	0,0,-6,-2,		0,	0,	0,	0,	0,	0
; play
gimute		ftgen	0,0,-6,-2,		0,	0,	0,	0,	0,	0

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL        |   WIDTH    | HEIGHT | X | Y
		FLpanel	"Strum",     giStringLen+100,    giPanelHeight+100,    0, 0

;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT |     X      | Y | OPCODE | INS | STARTTIM | IDUR
gkDnStrum,ihDnStrum		FLbutton	"Down Strum",	1,    0,     2,    100,     25,   giStringLen-5,  5,    -1
FLsetColor2	255, 255, 50, ihDnStrum		;SET SECONDARY COLOUR TO YELLOW
FLsetVal_i	1,ihDnStrum
gkUpStrum,ihUpStrum		FLbutton	"Up Strum",	1,    0,     2,    100,     25,   giStringLen-5, 30,    -1
FLsetColor2	255, 255, 50, ihUpStrum		;SET SECONDARY COLOUR TO YELLOW
FLsetVal_i	1,ihUpStrum

#define	BROWN	#255,180,  0#

; create instrument border (outside of this border notes will be damped) 
ih	 FLbox  " ",   			13,     10, 14, giStringLen, giPanelHeight-(giBorderWidth*2), 0, giBorderWidth
FLsetColor	$BROWN,ih




; create sound hole (purely decorative)
iSoundHoleSize	=	250
ih	FLbox  	"@circle", 	1, 14, iSoundHoleSize, iSoundHoleSize, iSoundHoleSize, (giStringLen/2)-(iSoundHoleSize/2), (giPanelHeight/2)-(iSoundHoleSize/2)
FLsetColor	$BROWN,ih

; a macro is defined that will later be expanded six times to draw each string
#define STRING(N)
#
iy	table	$N-1,giStringY
ih	 FLbox  " ",   			2,     10, 14, giStringLen, 3, 0,iy
#
$STRING(1)
$STRING(2)
$STRING(3)
$STRING(4)
$STRING(5)
$STRING(6)

iy	table	0,giStringY
;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT |     X      | Y
ih		 	FLbox  	"Tuning", 	1,      2,     15,     80,    15,   giStringLen,  iy-35

#define SETUP(N)
#
iy	table	$N-1,giStringY
;COUNTERS				MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT |    X      |  Y    | OPCODE 
gkNote$N, gihNote$N	FLcount  "",	-1,   127,    1,     12,      1,     80,     20,   giStringLen,  iy-10,   -1
FLsetAlign	5,gihNote$N
iNote	table	$N-1,giTuning
FLsetVal_i	iNote,gihNote$N
#
$SETUP(1)
$SETUP(2)
$SETUP(3)
$SETUP(4)
$SETUP(5)
$SETUP(6)

; chords panel (-1 means muted)
giOpen		ftgen	0,0,-6,-2,		0,	0,	0,	0,	0,	0
giD		ftgen	0,0,-6,-2,  		2,	3,	2,	0,	0,	-1
giG		ftgen	0,0,-6,-2,  		3,	0,	0,	0,	2,	3
giA		ftgen	0,0,-6,-2,  		0,	2,	2,	2,	0,	0
giC		ftgen	0,0,-6,-2,  		0,	1,	0,	2,	3,	-1
giE		ftgen	0,0,-6,-2,		0,	0,	1,	2,	2,	0
giB		ftgen	0,0,-6,-2,		2,	4,	4,	4,	2,	2
giF		ftgen	0,0,-6,-2,		1,	1,	2,	3,	3,	1
giDm		ftgen	0,0,-6,-2,		1,	3,	2,	0,	0,	-1
giAm		ftgen	0,0,-6,-2,		0,	1,	2,	2,	0,	0
giEm		ftgen	0,0,-6,-2,		0,	0,	0,	2,	2,	0

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT |     X      | Y
ih		 	FLbox  	"Chords:", 	1,      2,     12,     38,    20,   5,  0
iButtonWidth	=	40
iNButtons	=	11
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)
;			FLBUTBANK 	TYPE |   NUMX    | NUMY |           WIDTH         | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkchord, ihchord	FLbutBank	1,    iNButtons,     1,   iButtonWidth*iNButtons,     20,   50,  0,     0,     5,    0,   0
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

; fret board
;TEXT BOXES				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih	 FLbox  " ",   			8,     10,    14,    890,    130,    77, 670	; neck
ih	 FLbox  " ",   			8,     10,    14,      4,    130,   176, 670	; 3rd fret
ih	 FLbox  " ",   			8,     10,    14,      4,    130,   256, 670	; 5th fret
ih	 FLbox  " ",   			8,     10,    14,      4,    130,   336, 670	; 7th fret
ih	 FLbox  " ",   			8,     10,    14,      4,    130,   416, 670	; 9th fret
ih	 FLbox  " ",   			8,     10,    14,      8,    130,   534, 670	; 12th fret
ih	 FLbox  " ",   			8,     10,    14,      4,    130,   656, 670	; 15th fret
ih	 FLbox  " ",   			8,     10,    14,      4,    130,   736, 670	; 17th fret
ih	 FLbox  " ",   			8,     10,    14,      4,    130,   816, 670	; 19th fret
ih	 FLbox  " ",   			8,     10,    14,      4,    130,   896, 670	; 21st fret

iy	=	670
ispace	=	20
;TEXT BOXES					TYPE | FONT | SIZE |    WIDTH     | HEIGHT | X | Y
ih		 	FLbox  	"Mute", 	1,      1,     14,       40,          15,   12,  iy-17
;SWITCHES                       			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkmute1,gihmute1		FLbutton	"",	1,    0,     2,     20,     25,   20, iy,    -1
FLsetColor2	255,50,50,gihmute1
gkmute2,gihmute2		FLbutton	"",	1,    0,     2,     20,     25,   20, iy+ispace,    -1
FLsetColor2	255,50,50,gihmute2
gkmute3,gihmute3		FLbutton	"",	1,    0,     2,     20,     25,   20, iy+(ispace*2),    -1
FLsetColor2	255,50,50,gihmute3
gkmute4,gihmute4		FLbutton	"",	1,    0,     2,     20,     25,   20, iy+(ispace*3),    -1
FLsetColor2	255,50,50,gihmute4
gkmute5,gihmute5		FLbutton	"",	1,    0,     2,     20,     25,   20, iy+(ispace*4),    -1
FLsetColor2	255,50,50,gihmute5
gkmute6,gihmute6		FLbutton	"",	1,    0,     2,     20,     25,   20, iy+(ispace*5),    -1
FLsetColor2	255,50,50,gihmute6
FLsetColor2	255, 255, 50, ihDnStrum		;SET SECONDARY COLOUR TO YELLOW
FLsetVal_i	1,ihDnStrum

ix	=	50
iNButtons	=	23
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)
gkStr1, gihStr1		FLbutBank	4,    iNButtons,     1,       40*iNButtons,           30,   ix, iy,   0,6,0,0,1
iy	=	iy + ispace
gkStr2, gihStr2		FLbutBank	4,    iNButtons,     1,       40*iNButtons,           30,   ix, iy,   0,6,0,0,2
iy	=	iy + ispace
gkStr3, gihStr3		FLbutBank	4,    iNButtons,     1,       40*iNButtons,           30,   ix, iy,   0,6,0,0,3
iy	=	iy + ispace
gkStr4, gihStr4		FLbutBank	4,    iNButtons,     1,       40*iNButtons,           30,   ix, iy,   0,6,0,0,4
iy	=	iy + ispace
gkStr5, gihStr5		FLbutBank	4,    iNButtons,     1,       40*iNButtons,           30,   ix, iy,   0,6,0,0,5
iy	=	iy + ispace
gkStr6, gihStr6		FLbutBank	4,    iNButtons,     1,       40*iNButtons,           30,   ix, iy,   0,6,0,0,6
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

ix	=	50
;TEXT BOXES					TYPE | FONT | SIZE |    WIDTH     | HEIGHT | X | Y
ih		 	FLbox  	"Open", 	1,      1,     12,   iButtonWidth,    15,   ix,  20
ix	=	ix + iButtonWidth
ih		 	FLbox  	"D", 		1,      1,     12,   iButtonWidth,    15,   ix,  20
ix	=	ix + iButtonWidth
ih		 	FLbox  	"G", 		1,      1,     12,   iButtonWidth,    15,   ix,  20
ix	=	ix + iButtonWidth
ih		 	FLbox  	"A", 		1,      1,     12,   iButtonWidth,    15,   ix,  20
ix	=	ix + iButtonWidth
ih		 	FLbox  	"C", 		1,      1,     12,   iButtonWidth,    15,   ix,  20
ix	=	ix + iButtonWidth
ih		 	FLbox  	"E", 		1,      1,     12,   iButtonWidth,    15,   ix,  20
ix	=	ix + iButtonWidth
ih		 	FLbox  	"B", 		1,      1,     12,   iButtonWidth,    15,   ix,  20
ix	=	ix + iButtonWidth
ih		 	FLbox  	"F", 		1,      1,     12,   iButtonWidth,    15,   ix,  20
ix	=	ix + iButtonWidth
ih		 	FLbox  	"Dm", 		1,      1,     12,   iButtonWidth,    15,   ix,  20
ix	=	ix + iButtonWidth
ih		 	FLbox  	"Am", 		1,      1,     12,   iButtonWidth,    15,   ix,  20
ix	=	ix + iButtonWidth
ih		 	FLbox  	"Em", 		1,      1,     12,   iButtonWidth,    15,   ix,  20

		FLpanel_end                                                                                                       
                                                                                                                                               
				FLrun	;RUN THE FLTK WIDGET THREAD                                                                              
;END OF FLTK INTERFACE CODE-------------------------------------------------------------------------------------------------------------------------

instr	1	; sense mouse position and velocity and trigger plucks when appropriate
	gkx, gky, kb1, kb2, kb3 FLmouse	2

	; sense velocity of mouse movement
	koldy	delayk	gky,0.05
	gkamp	limit	abs(gky-koldy)/100,0,1

	; sense a change of chord
	gkChangeChord	changed	gkchord
	
#define PLUCK_STRING(N)
	#
	iy$N		table	$N-1,giStringY				; read string position from table for *this* string
	kTrigDnStrum	trigger	gky,iy$N,1				; trigger when strumming down
	kTrigUpStrum	trigger	gky,iy$N+2,0				; trigger when strumming up	

	if(gkStr$N==0&&gkmute$N==1) then				; check whether to play this note
	 kplay	=	0
	else
	 kplay	=	1
	endif
	if gkx<giStringLen then
	 schedkwhen	(kTrigUpStrum*gkUpStrum*kplay)+(kTrigDnStrum*gkDnStrum*kplay),0,0,2+($N/10),0,20,$N		; trigger a 'pluck'
	endif
	#
	;
	$PLUCK_STRING(1)						; expand the macro for each of the six strings
	$PLUCK_STRING(2)
	$PLUCK_STRING(3)
	$PLUCK_STRING(4)
	$PLUCK_STRING(5)
	$PLUCK_STRING(6)             
endin

instr	2	; string pluck
	inum	table	p4-1,giTuning					; read open string note from table
	ifret	table	p4-1,gifrets					; read fret position from table
	iy	table	p4-1,giStringY					; read string location from table
	if(gky==iy+1)||inum==-1||gkChangeChord==1 then				; conditions when note should TURN OFF: 1. touching string 2. non-playing note according to chord/tuning 3. chord change
	 kdamp = 0.9							; if string is instructed to turn off increase damping for wgpluck
	 turnoff							; turn this instrument off (envelopes with release segments will be allowed to complete)
	endif
	kdamp	init	0.3						; string damping factor
	iplk	limit	i(gkx)/giStringLen,0.01,0.99			; calculate string pluck position (range 0 - 1). This will be determined by the mouse position. 'limit' protects against out of range values.
	kpick	=	0.1						; pick up position
	asig	wgpluck2	iplk, 0.1, cpsmidinn(inum+ifret), kpick, kdamp	; use string model, wgpluck
	aenv		linsegr	0, 0.0008, 1, p3-0.1008, 0, 0.1, 0	; amplitude envelope. Attack removes excessive 'click'. Decays to nothing across note duration (p3). Short release stage prevents click if a note is interrupted.
	icf	=	cpsoct(6+(i(gkamp)*8))				; define tone control cutoff frequency (velocity dependent)
	asig	butlp	asig,icf					; apply tone control (lowpass filter)
	asig	=	asig*aenv*i(gkamp)				; apply amplitude envelope and plucking velocity
		outs	asig, asig
endin

instr	3	; (always on) if a note counter value changes update its value in the tuning table
	; a macro is created to prevent code repetition which is then expanded six times, once for each string
#define	CHANGED_NOTE(N)
	#
	ktrig$N	changed	gkNote$N		; generate a trigger if the counter for this string is changed
	if ktrig$N==1 then			; if counter for this string has been changed 
	 tablew	gkNote$N,$N-1,giTuning		; write new value into table
	 event	"i",4,0,0			; call instrument 4 (which updates the label (note name) in line with the note number change
	endif
	#
	$CHANGED_NOTE(1)
	$CHANGED_NOTE(2)
	$CHANGED_NOTE(3)
	$CHANGED_NOTE(4)
	$CHANGED_NOTE(5)
	$CHANGED_NOTE(6)	
endin

instr	4	; update the note name label for the note number counters
#define	SET_LABEL(N)
	#
	ival	wrap	i(gkNote$N),0,12	; derive a wrapped integer number (0 - 11) corresponding to the note. i.e. octave is ignored, only note name is used
	if(ival==0) then			; if zero
	 SName	=	"C"			; it's a 'C'
	elseif(ival==1) then			; etc....
	 SName	=	"C+"			; n.b. sharp signs are not allowed. '+' used instead.		
	elseif(ival==2) then	
	 SName	=	"D"
	elseif(ival==3) then
	 SName	=	"D+"
	elseif(ival==4) then
	 SName	=	"E"
	elseif(ival==5) then
	 SName	=	"F"
	elseif(ival==6) then
	 SName	=	"F+"
	elseif(ival==7) then
	 SName	=	"G"
	elseif(ival==8) then
	 SName	=	"G+"
	elseif(ival==9) then
	 SName	=	"A"
	elseif(ival==10) then
	 SName	=	"A+"
	elseif(ival==11) then
	 SName	=	"B"
	endif
	FLhide	gihNote$N
	FLsetText	SName,gihNote$N
	FLshow	gihNote$N
	#
	$SET_LABEL(1)
	$SET_LABEL(2)
	$SET_LABEL(3)
	$SET_LABEL(4)
	$SET_LABEL(5)
	$SET_LABEL(6)
endin

instr	5	; set chord preset
#define	SET_FRET(N)
	#
	ifret$N	table	$N-1,giOpen+i(gkchord)
	if(ifret$N==-1) then		; if open string and muted..
	 FLsetVal_i	1,gihmute$N
	 FLsetVal_i	0,gihStr$N
	else 
	 FLsetVal_i	0,gihmute$N
	 FLsetVal_i	ifret$N,gihStr$N
	 gkStr$N	init	ifret$N
	endif
	SKIP$N:
	#
	$SET_FRET(1)
	$SET_FRET(2)
	$SET_FRET(3)
	$SET_FRET(4)
	$SET_FRET(5)
	$SET_FRET(6)
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
	$SET_FRET_TABLE(5)
	$SET_FRET_TABLE(6)
endin

</CsInstruments>

<CsScore>
i 1 0 [60*60*24*7]	; sense mouse movement, trigger pluckes when required
i 3 0 [60*60*24*7]	; sense changes of note number counters
;i 5 0 0
</CsScore>

</CsoundSynthesizer>