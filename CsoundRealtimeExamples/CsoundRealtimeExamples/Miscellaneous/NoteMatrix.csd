NoteMatrix.csd
Written by Iain McCurdy 2014

; Each row represents a complete chromatic scale and there are 9 rows therefore 9 octaves.
; 
; Circles in the grid are colourised algorithmically based upon their position within the grid.

; SOUND    - selects from a range of synthesized sounds
; OCTAVE   - shifts all notes by the the number of octaves
; SEMITONE - shifts all notes by this number of semitones
; MODIFIER - modifies the sound in some way (its precise function is determined by the 'SOUND' selected

; STRIKE   - this button will re-strike percussive sounds (if selected using 'SOUND')
; MUTE     - will mute all sounds and then restart them when released 

<CsoundSynthesizer>

<CsOptions>
-odac -dm0 -+rtmidi=mme -Q1
</CsOptions>

<CsInstruments>
sr 	=	44100
ksmps 	=	32
nchnls 	=	2
0dbfs	=	1	;MAXIMUM AMPLITUDE
	seed	0	;SEED RANDOM NUMBER GENERATORS FROM THE SYSTEM CLOCK

alwayson 1
alwayson 99

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 255, 0, 0
;			LABEL  | WIDTH | HEIGHT | X | Y
	FLpanel	"Note Matrix",    530,    500,    0,  0
ix_init	=	30
ix	=	ix_init
iy_init	=	30
iy	=	iy_init
ispace	=	10
iwidth	=	30
iheight	=	30
#define	SWITCH(N)
#
;SWITCHES						ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gk$N,ih$N			FLbutton	"",	1,    0,     2,   iwidth, iheight, ix,iy,    -1
ix = ix + iwidth + ispace
#
$SWITCH(0)
$SWITCH(1)
$SWITCH(2)
$SWITCH(3)
$SWITCH(4)
$SWITCH(5)
$SWITCH(6)
$SWITCH(7)
$SWITCH(8)
$SWITCH(9)
$SWITCH(10)
$SWITCH(11)
iy = iy + iheight + ispace
ix	=	ix_init
$SWITCH(12)
$SWITCH(13)
$SWITCH(14)
$SWITCH(15)
$SWITCH(16)
$SWITCH(17)
$SWITCH(18)
$SWITCH(19)
$SWITCH(20)
$SWITCH(21)
$SWITCH(22)
$SWITCH(23)
iy = iy + iheight + ispace
ix	=	ix_init
$SWITCH(24)
$SWITCH(25)
$SWITCH(26)
$SWITCH(27)
$SWITCH(28)
$SWITCH(29)
$SWITCH(30)
$SWITCH(31)
$SWITCH(32)
$SWITCH(33)
$SWITCH(34)
$SWITCH(35)
iy = iy + iheight + ispace
ix	=	ix_init
$SWITCH(36)
$SWITCH(37)
$SWITCH(38)
$SWITCH(39)
$SWITCH(40)
$SWITCH(41)
$SWITCH(42)
$SWITCH(43)
$SWITCH(44)
$SWITCH(45)
$SWITCH(46)
$SWITCH(47)
iy = iy + iheight + ispace
ix	=	ix_init
$SWITCH(48)
$SWITCH(49)
$SWITCH(50)
$SWITCH(51)
$SWITCH(52)
$SWITCH(53)
$SWITCH(54)
$SWITCH(55)
$SWITCH(56)
$SWITCH(57)
$SWITCH(58)
$SWITCH(59)
iy = iy + iheight + ispace
ix	=	ix_init
$SWITCH(60)
$SWITCH(61)
$SWITCH(62)
$SWITCH(63)
$SWITCH(64)
$SWITCH(65)
$SWITCH(66)
$SWITCH(67)
$SWITCH(68)
$SWITCH(69)
$SWITCH(70)
$SWITCH(71)
iy = iy + iheight + ispace
ix	=	ix_init
$SWITCH(72)
$SWITCH(73)
$SWITCH(74)
$SWITCH(75)
$SWITCH(76)
$SWITCH(77)
$SWITCH(78)
$SWITCH(79)
$SWITCH(80)
$SWITCH(81)
$SWITCH(82)
$SWITCH(83)
iy = iy + iheight + ispace
ix	=	ix_init
$SWITCH(84)
$SWITCH(85)
$SWITCH(86)
$SWITCH(87)
$SWITCH(88)
$SWITCH(89)
$SWITCH(90)
$SWITCH(91)
$SWITCH(92)
$SWITCH(93)
$SWITCH(94)
$SWITCH(95)
iy = iy + iheight + ispace
ix	=	ix_init
$SWITCH(96)
$SWITCH(97)
$SWITCH(98)
$SWITCH(99)
$SWITCH(100)
$SWITCH(101)
$SWITCH(102)
$SWITCH(103)
$SWITCH(104)
$SWITCH(105)
$SWITCH(106)
$SWITCH(107)

ix	=	ix_init
iy	=	iy_init-25
;TEXT BOXES				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"C", 	1,      6,     15,   iwidth,   25,   ix,  iy
ix = ix + iwidth + ispace
ih		 	FLbox  	"C#", 	1,      6,     15,   iwidth,   25,   ix,  iy
ix = ix + iwidth + ispace
ih		 	FLbox  	"D", 	1,      6,     15,   iwidth,   25,   ix,  iy
ix = ix + iwidth + ispace
ih		 	FLbox  	"D#", 	1,      6,     15,   iwidth,   25,   ix,  iy
ix = ix + iwidth + ispace
ih		 	FLbox  	"E", 	1,      6,     15,   iwidth,   25,   ix,  iy
ix = ix + iwidth + ispace
ih		 	FLbox  	"F", 	1,      6,     15,   iwidth,   25,   ix,  iy
ix = ix + iwidth + ispace
ih		 	FLbox  	"F#", 	1,      6,     15,   iwidth,   25,   ix,  iy
ix = ix + iwidth + ispace
ih		 	FLbox  	"G", 	1,      6,     15,   iwidth,   25,   ix,  iy
ix = ix + iwidth + ispace
ih		 	FLbox  	"G#", 	1,      6,     15,   iwidth,   25,   ix,  iy
ix = ix + iwidth + ispace
ih		 	FLbox  	"A", 	1,      6,     15,   iwidth,   25,   ix,  iy
ix = ix + iwidth + ispace
ih		 	FLbox  	"A#", 	1,      6,     15,   iwidth,   25,   ix,  iy
ix = ix + iwidth + ispace
ih		 	FLbox  	"B", 	1,      6,     15,   iwidth,   25,   ix,  iy

ix	=	ix_init - 25
iy	=	iy_init
;TEXT BOXES				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"0", 	1,      6,     15,     25,   iheight, ix,  iy
iy = iy + iwidth + ispace
ih		 	FLbox  	"1", 	1,      6,     15,     25,   iheight, ix,  iy
iy = iy + iwidth + ispace
ih		 	FLbox  	"2", 	1,      6,     15,     25,   iheight, ix,  iy
iy = iy + iwidth + ispace
ih		 	FLbox  	"3", 	1,      6,     15,     25,   iheight, ix,  iy
iy = iy + iwidth + ispace
ih		 	FLbox  	"4", 	1,      6,     15,     25,   iheight, ix,  iy
iy = iy + iwidth + ispace
ih		 	FLbox  	"5", 	1,      6,     15,     25,   iheight, ix,  iy
iy = iy + iwidth + ispace
ih		 	FLbox  	"6", 	1,      6,     15,     25,   iheight, ix,  iy
iy = iy + iwidth + ispace
ih		 	FLbox  	"7", 	1,      6,     15,     25,   iheight, ix,  iy
iy = iy + iwidth + ispace
ih		 	FLbox  	"8", 	1,      6,     15,     25,   iheight, ix,  iy
iy = iy + iwidth + ispace


;COUNTERS						MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkSoundSelect, ih		FLcount  "Sound Select",1,     11,    1,      8,     2,     110,     25,   10,400,    -1
FLsetVal_i 2,ih
gkOctave, ih			FLcount  "Octave",	-3,     3,    1,      8,     2,     110,     25,  125,400,    -1
FLsetVal_i 0,ih
gkSemitone, ih			FLcount  "Semitone",	-11,   11,    1,      8,     2,     110,     25,  240,400,    -1
FLsetVal_i 0,ih
;KNOBS							MIN | MAX | EXP | TYPE | DISP| WIDTH | X | Y
gkLevel, ih			FLknob 	"Level", 	0,    1,     0,    1,     -1,   40,   360,400
FLsetVal_i 0.9,ih
gkModifier, ih			FLknob 	"Modifier", 	0,    1,     0,    1,     -1,   40,   415,400
FLsetVal_i 0,ih
gkReverb, ih			FLknob 	"Reverb", 	0,    1,     0,    1,     -1,   40,   470,400
FLsetVal_i 0.5,ih

;SWITCHES							ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkStrike,gihStrike		FLbutton	"Strike",	1,    0,     2,    60,      30,    10,440,    -1
gkMute,ihMute			FLbutton	"Mute",		1,    0,     2,    60,      30,    80,440,    -1
gkMidiOut,ihMidiOut		FLbutton	"Midi Out",	1,    0,     2,    80,      30,   150,440,    -1


FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;









opcode	scale_i,i,iii					; UDO for an i-rate version of the 'scale' opcode
 ival,imax,imin	xin
 ival	=	(ival * (imax-imin)) + imin
	xout	ival
endop









gkStrike	init	0

giactive	ftgen	0,0,128,-2,0
gisine		ftgen	0,0,131073,10,1

instr	1
#define Scan_Switches(N)
#
 ktrig	changed	gk$N,gkMute
 if ktrig==1 then

;;  tablew	gk$N,$N+12,giactive	; NB C0 = MIDI_NN.12. Maybe a table isn't required?

  if gk$N==1&&gkMute==0 then							; If switch has been turned on...
   event	"i",2+($N*0.001),0,-1,$N				; play a note
  else									; Otherwise (note has been turned off)...
   turnoff2	2+($N*0.001),4,1					; turnoff a note
  endif
 endif
#
$Scan_Switches(0)
$Scan_Switches(1)
$Scan_Switches(2)
$Scan_Switches(3)
$Scan_Switches(4)
$Scan_Switches(5)
$Scan_Switches(6)
$Scan_Switches(7)
$Scan_Switches(8)
$Scan_Switches(9)
$Scan_Switches(10)
$Scan_Switches(11)
$Scan_Switches(12)
$Scan_Switches(13)
$Scan_Switches(14)
$Scan_Switches(15)
$Scan_Switches(16)
$Scan_Switches(17)
$Scan_Switches(18)
$Scan_Switches(19)
$Scan_Switches(20)
$Scan_Switches(21)
$Scan_Switches(22)
$Scan_Switches(23)
$Scan_Switches(24)
$Scan_Switches(25)
$Scan_Switches(26)
$Scan_Switches(27)
$Scan_Switches(28)
$Scan_Switches(29)
$Scan_Switches(30)
$Scan_Switches(31)
$Scan_Switches(32)
$Scan_Switches(33)
$Scan_Switches(34)
$Scan_Switches(35)
$Scan_Switches(36)
$Scan_Switches(37)
$Scan_Switches(38)
$Scan_Switches(39)
$Scan_Switches(40)
$Scan_Switches(41)
$Scan_Switches(42)
$Scan_Switches(43)
$Scan_Switches(44)
$Scan_Switches(45)
$Scan_Switches(46)
$Scan_Switches(47)
$Scan_Switches(48)
$Scan_Switches(49)
$Scan_Switches(50)
$Scan_Switches(51)
$Scan_Switches(52)
$Scan_Switches(53)
$Scan_Switches(54)
$Scan_Switches(55)
$Scan_Switches(56)
$Scan_Switches(57)
$Scan_Switches(58)
$Scan_Switches(59)
$Scan_Switches(60)
$Scan_Switches(61)
$Scan_Switches(62)
$Scan_Switches(63)
$Scan_Switches(64)
$Scan_Switches(65)
$Scan_Switches(66)
$Scan_Switches(67)
$Scan_Switches(68)
$Scan_Switches(69)
$Scan_Switches(70)
$Scan_Switches(71)
$Scan_Switches(72)
$Scan_Switches(73)
$Scan_Switches(74)
$Scan_Switches(75)
$Scan_Switches(76)
$Scan_Switches(77)
$Scan_Switches(78)
$Scan_Switches(79)
$Scan_Switches(80)
$Scan_Switches(81)
$Scan_Switches(82)
$Scan_Switches(83)
$Scan_Switches(84)
$Scan_Switches(85)
$Scan_Switches(86)
$Scan_Switches(87)
$Scan_Switches(88)
$Scan_Switches(89)
$Scan_Switches(90)
$Scan_Switches(91)
$Scan_Switches(92)
$Scan_Switches(93)
$Scan_Switches(94)
$Scan_Switches(95)
$Scan_Switches(96)
$Scan_Switches(97)
$Scan_Switches(98)
$Scan_Switches(99)
$Scan_Switches(100)
$Scan_Switches(101)
$Scan_Switches(102)
$Scan_Switches(103)
$Scan_Switches(104)
$Scan_Switches(105)
$Scan_Switches(106)
$Scan_Switches(107)

endin




















;; UDOS

opcode	Oscil1a,a,iii					; an oscillator that plays a single cycle of an audio waveform at a-rate
 iamp,ifrq,ifn	xin
 aptr	line	0,1/ifrq,1
 asig	tablei	aptr,ifn,1
 aenv	linseg	1,1/ifrq,1,0.001,0
	xout	asig*iamp*aenv
endop

opcode	uniform_wooden_bar, a, akk
	ain, kbasfrq, kq	xin
	amix	init	0
#define	MODE_PARTIAL(FRQ)
	#
	kfrq	=	kbasfrq*$FRQ
	if sr/kfrq>=3.1415926535897932384626433832795 then			;$M_PI
	 asig	mode	ain, kfrq, kq
	 amix	=	amix + asig
	endif
	#
	$MODE_PARTIAL(1    )
	$MODE_PARTIAL(2.572)
	$MODE_PARTIAL(4.644)
	$MODE_PARTIAL(6.984)
	$MODE_PARTIAL(9.723)
	$MODE_PARTIAL(12   )
		xout	amix/6
		clear	amix
endop

opcode	red_cedar_wood_plate, a, akk
	ain, kbasfrq, kq	xin
	amix	init	0
#define	MODE_PARTIAL(FRQ)
	#
	kfrq	=	kbasfrq*$FRQ
	if sr/kfrq>=3.1415926535897932384626433832795 then			;$M_PI
	 asig	mode	ain, kfrq, kq
	 amix	=	amix + asig
	endif
	#
	$MODE_PARTIAL(1   )
	$MODE_PARTIAL(1.47)
	$MODE_PARTIAL(2.09)
	$MODE_PARTIAL(2.56)
		xout	amix/4
		clear	amix
endop




; Global variables and function tables
giImp	ftgen	0,0,4097,9,0.5,1,0			; shape for the hammer inpulse
gaSendL,gaSendR	init	0
gisine	ftgen	0,0,4096,10,1
gicos	ftgen	0,0,131072,11,1
gihann	ftgen	0, 0, 8192,  20, 2, 1			; Hanning window
giSoftSaw	ftgen	0,0,131072,10,1,1/8,1/16,1/32,1/64,1/128,1/256

instr	2	; produce a sound
 iCF_Time	=	0.05			; cross-fade time (when changing 'SOUND' selector
 icps		=	cpsmidinn(p4+12)
 
 kSoundSelect	=	gkSoundSelect
 kSoundSelectD	delayk	 kSoundSelect,iCF_Time	; delayed 'SOUND' selector control

 kChangeTrans	changed	gkOctave,gkSemitone,kSoundSelect	; Impulse generated when transposition is changed (used to retrigger percussive sounds)
 kStrike	changed	gkStrike+kChangeTrans			; Impulse generated when 'STRIKE' button is clicked
 
 
 ; A MECHANISM IS IMPLEMENTED TO PREVENT CLICKS WHEN CHANGING 'SOUND'
 kEnv2	init	0			;
 ksmooth	init	1		;
 if changed(kSoundSelect)==1 then	; If 'SOUND' switch is changed...
  ksmooth	=	0		; ...smoothing mode set to '0' (ramp amplitude down)
  reinit RAMP_DOWN
 elseif changed(kSoundSelectD)==1 then	; Shortly after 'SOUND' switch has been changed...
  ksmooth	=	1		; ...smoothing mode set to '1' (ramp amplitude back up and hold)
  reinit NORMAL_ENV
 endif
 
 RAMP_DOWN:
 kEnv1	linseg	i(kEnv2),iCF_Time,0	; Ramp amplitude down to prevent clicks when sound is changed
 rireturn				
 
 NORMAL_ENV:				; Ramp amplitude up and hold. Release smoothly if note is released.
 kEnv2	linsegr	0,iCF_Time,1,1,0
 rireturn
 
 kEnv	=	(ksmooth==0?kEnv1:kEnv2); Choose appropriate envelope based on mode: crossfade down / crossfade up. 
 
 
 
 kdtn	jspline	10,0.05,0.2		; A detuning function - producing a slow instability in pitch. Range roughly -10 to +10 cents.

 
 if kSoundSelectD==1 then		; sine modifying to buzz
  kmul	scale	gkModifier,0.8,0
  asig	gbuzz	0.04*kEnv,icps*cent(kdtn)*octave(gkOctave)*semitone(gkSemitone),80, 1, kmul, gicos

 elseif kSoundSelectD==2 then	; undulating buzz
  kmul	rspline	0.1,0.8,0.1,0.4
  kmul	limit	kmul+gkModifier,0,0.9
  asig	gbuzz	0.04*kEnv,icps*cent(kdtn)*octave(gkOctave)*semitone(gkSemitone),20, 1, kmul^2, gicos


 elseif kSoundSelectD==3 then	; hsboscil
  ktone		=	0
  kbrite	rspline	-2,2,0.1,0.2
  kocts		scale	gkModifier,6,1
  if changed(gkOctave+gkSemitone+kocts)==1 then
   reinit RESTART_HSBOSCIL
  endif
  RESTART_HSBOSCIL:
  asig	hsboscil	0.04*kEnv, ktone+(kdtn/1000), kbrite, icps*octave(i(gkOctave))*semitone(i(gkSemitone)), gisine, gihann, i(kocts), 0
  rireturn


 elseif kSoundSelectD==4 then	; whistle (filtered noise)
  ;asig	pinkish	0.04*kEnv
  asig	noise	0.04*kEnv,0.9
  kbw	scale	gkModifier,0.1,0.0005
  asig	reson	asig,icps*cent(kdtn)*octave(gkOctave)*semitone(gkSemitone), cpsmidinn(p4+11)*cent(kdtn)*kbw*octave(gkOctave)*semitone(gkSemitone), 2
  ;asig	buthp	asig,icps*cent(kdtn)*octave(gkOctave)*semitone(gkSemitone)

 elseif kSoundSelectD==5 then	; wgflute
  kjet	scale	gkModifier,1.5,0.28	;0.28
  kngain	=	0.05
  kvibf	=	0.2
  kvamp	=	0.05
  asig	wgflute 0.04*kEnv, icps*cent(kdtn)*octave(gkOctave)*semitone(gkSemitone), kjet, 0.1, 0.1, kngain, kvibf, kvamp, gisine


 elseif kSoundSelectD==6 then	; wgclar
  kstiff	scale	gkModifier,1,-0.3	;-0.3
  kngain	scale	gkModifier,0.9,0.05		;0.05
  kvibf	=	0
  kvamp	=	0
  asig	wgclar	0.1, icps*cent(kdtn)*octave(gkOctave)*semitone(gkSemitone), kstiff, 0.1, 0.1, kngain, kvibf, kvamp, gisine, 1
  asig	dcblock2	asig*kEnv


 elseif kSoundSelectD==7 then	; wgbow
  kpres	scale	gkModifier,10,3	;3
  krat	scale	gkModifier,0.8,0.127236	;	0.127236
  kvibf	=	rnd(1)+randomi(1,4,0.2,1)
  kvamp	=	0.001
  asig	wgbow	0.1*kEnv, icps*cent(kdtn)*octave(gkOctave)*semitone(gkSemitone), kpres, krat, kvibf, kvamp, gisine, 1


 elseif kSoundSelectD==8 then 	; struck wooden bar
  if kStrike==1 then
   reinit UNIFORM_WOODEN_BAR
  endif
  UNIFORM_WOODEN_BAR:
  aImpls	Oscil1a	0.04,icps*octave(i(gkOctave))*semitone(i(gkSemitone)),giImp
  kres	scale	gkModifier,2000,250
  asig	uniform_wooden_bar	aImpls,icps*octave(gkOctave)*semitone(gkSemitone),kres 
  asig	delay	asig,rnd(0.05)+0.0001
  rireturn
  kRel	linsegr	1,0.1,0
  asig	=	asig * kRel

 elseif kSoundSelectD==9 then ; struck cedar wood
  if kStrike==1 then
   reinit RED_CEDAR_WOOD_PLATE
  endif
  RED_CEDAR_WOOD_PLATE:
  aImpls	Oscil1a	0.04,icps*octave(i(gkOctave))*semitone(i(gkSemitone)),giImp
  kres	scale	gkModifier,2000,250
  asig	red_cedar_wood_plate	aImpls,icps*octave(gkOctave)*semitone(gkSemitone),kres 
  asig	delay	asig,rnd(0.05)+0.0001
  rireturn
  kRel	linsegr	1,0.1,0
  asig	=	asig * kRel


 elseif kSoundSelectD==10 then	; plucked string
  if kStrike==1 then
   reinit WGUIDE2
  endif
  WGUIDE2:
  aImpls	Oscil1a	0.3,300,giImp
  rireturn
  kLPF		scale	gkModifier, 20000,3000
  asig		wguide1	aImpls,icps*octave(gkOctave)*semitone(gkSemitone), kLPF, 0.99995  
  kdltim	trandom	kStrike,0.001,0.0501
  asig		vdelay	asig,kdltim*1000,0.0501*1000
  asig		dcblock2	asig
  kRel	linsegr	1,0.1,0
  asig	=	asig * kRel


 elseif kSoundSelectD==11 then	; FM marimba
  idur	scale_i	(p4/127)^0.5,0.2,10
  kRat	scale	gkModifier,5.12,2.15
  if kStrike==1 then
   reinit FM_MARIMBA
  endif
  FM_MARIMBA:
  aAEnv	transeg	1,idur,-8,0
  kIEnv	transeg	1,idur,-100,0
  asig	foscil aAEnv*0.1, icps*octave(gkOctave)*semitone(gkSemitone), 1, kRat, 0.55*kIEnv, gisine
  asig	delay	asig,rnd(0.05)+0.0001
  rireturn
 	outs	asig,asig

 endif

 asig	=	asig * gkLevel


 iSide	random	0,1
 iDelTim	random	0.001,0.04
 if iSide>0.5 then
  aL	delay	asig,iDelTim
  aR	=	asig
 else
  aR	delay	asig,iDelTim
  aL	=	asig
 endif

	outs aL, aR

 gaSendL	=	gaSendL + (aL*gkReverb)
 gaSendR	=	gaSendR + (aR*gkReverb)
 

 ; MIDI OUT
 if i(gkMidiOut)==1 then
  noteondur 1, p4+12+(i(gkOctave)*12)+i(gkSemitone), 100, 3600
 endif
 
endin


instr	99	; Reverb
 
 aL,aR	reverbsc	gaSendL,gaSendR,0.83,6000
 	outs		aL,aR
 	clear		gaSendL,gaSendR
endin


</CsInstruments>

<CsScore>
</CsScore>

</CsoundSynthesizer>
