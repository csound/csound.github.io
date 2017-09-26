;Written by Iain McCurdy, 2006

;DEMONSTRATION OF THE wgbow OPCODE. THIS IS A PHYSICALLY MODELLED BOWED STRING INSTRUMENT BASED ON WORK BY PERRY COOK

;kamp - AMPLITUDE

;kfreq - THE FUNDEMENTAL OF THE TONE PRODUCED

;kpres - PRESSURE OF THE BOW UPON THE STRING
;	THE OPCODE AUTHOR, JOHN FFITCH, SUGGESTS THAT WE CHOOSE VALUES WITHIN THE RANGE 1 to 5
;	HE ALSO SUGGESTS THAT A VALUE OF 3 REFLECTS NORMAL PLAYING PRESSURE

;krat - POSITION OF THE BOW ALONG THE LENGTH OF THE STRING
;	THE OPCODE AUTHOR SUGGESTS THAT WE CHOOSE VALUES WITHIN THE RANGE .025 to 0.23
;	HE ALSO SUGGESTS THAT A VALUE OF .127236 REFLECTS A NORMAL BOWING POSITION
;	STRING EFFECTS SUCH AS 'SUL PONTICELLO' (AT THE BRIDGE) AND 'FLAUTANDO' (OVER THE NECK) CAN BE IMITATED USING THIS PARAMETER
;	A VALUE OF .025 REFLECTS A 'SUL PONTICELLO' STYLE OF PLAYING AND PRODUCES A THINNER TONE
;	A VALUE OF .23 REFLECTS A 'FLAUTANDO' STYLE OF PLAYING AND PRODUCES A FLUTE-LIKE TONE
;	THESE SUGGESTED SETTINGS FOR krat ARE BASED UPON A CONVENTIONAL PLAYING TECHNIQUE OF A BOWED INSTRUMENT.
;	IF VALUES ARE CHOSEN BEYOND THESE LIMITS OTHER UNCONVENTIONAL SOUNDS ARE POSSIBLE.
;	0 = THE STRING BEING BOWED AT THE NUT (NECK), 1 = THE STRING BEING BOWED AT THE BRIDGE
;	IN ACTUALITY VALUES OF 0 AND 1 WILL PRODUCE SILENCE
;	VALUES CLOSE TO ZERO OR CLOSE TO 1 WILL PRODUCE A THIN, HARD SOUND (BOWED NEAR THE NECK END OR NEAR THE BRIDGE)
;	A VALUE OF .5 WILL PRODUCE A SOFT FLUTEY SOUND (STRING BOWED HALFWAY ALONG ITS LENGTH)

;kvibf/kvibamp - THIS OPCODE IMPLEMENTS VIBRATO THAT GOES BEYOND JUST FREQUENCY MODULATION AND INCLUDES MODULATION 
;	-UPON SEVERAL OTHER ASPECTS OF THE SOUND INCLUDING AMPLITUDE MODULATION
;	A USEFUL RANGE FOR kvibamp (AMPLITUDE OF VIBRATO) IS 0-.1 WHERE 0=NO VIBRATO AND .1=A LOT OF VIBRATO
;	kvibf IS USED TO CONTROL VIBRATO FREQUENCY, A NATURAL VIBRATYO FREQUENCY IS ABOUT 5 HZ

;ifn - A FUNCTION TABLE WAVEFORM MUST BE GIVEN TO DEFINE THE SHAPE OF THE VIBRATO, 
;	-THIS SHOULD NORMALLY BE A SINE WAVE.

;THE OPCODE OFFERS 1 FURTHER *OPTIONAL* PARAMETER:

;iminfreq - A MINIMUM FREQUENCY SETTING GIVEN TO THE ALGORITHM
;	- TYPICALLY THIS IS SET TO A VALUE BELOW THE FREQUENCY SETTING GIVEN BY kfreq (IF OMITTED IT DEFAULTS TO 50HZ)
;	- IF kfreq GOES BELOW iminfreq THE SETTING FOR kfreq NO LONGER REFLECTS THE PITCH THAT IS ACTUALLY HEARD.

<CsoundSynthesizer>

<CsOptions>
-odac -M0 -+rtmidi=virtual -dm0	;VIRTUAL MIDI DEVICE
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	100	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE                     
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE = 1, REGARDLESS OF BIT DEPTH
maxalloc	3,1		; restrict polyphony of instr 2 to '1'/monophonic.

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0

;			LABEL | WIDTH | HEIGHT | X | Y
		FLpanel	"wgbow", 500,    665,    0,  0

;BUTTONS                              			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"Bow / Off (MIDI)",	1,    0,    22,    150,     25,    5,  5,    0,      2,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

gklegato,ihlegato	FLbutton	"Legato (MIDI)",1,    0,    22,    120,     25,  270,  5,   -1
FLsetColor2	255, 255, 50, ihlegato		;SET SECONDARY COLOUR TO YELLOW
;SLIDERS				            	MIN |   MAX   | EXP | TYPE | DISP | WIDTH | HEIGHT | X  | Y
gkporttime, ihporttime	FLslider	"Port.Time",	0.01,    3,     -1,    23,    -1,    100,     20,   395,  5

;VALUE DISPLAY BOXES	LABEL  | WIDTH | HEIGHT | X |  Y
idamp		FLvalue	"",       70,     18,    5,   75
idfreq		FLvalue	"",       70,     18,    5,  125
idpres		FLvalue	"",       70,     18,    5,  175
idminfreq	FLvalue	"",       70,     18,    5,  595

;SLIDERS				            						MIN |   MAX   | EXP | TYPE |   DISP    | WIDTH | HEIGHT | X  | Y
gkamp, ihamp			FLslider	"Amplitude",					0,        1,     0,    23,    idamp,      490,     25,    5,   50
gkfreq, ihfreq			FLslider	"Frequency",					20,    4000,    -1,    23,    idfreq,     490,     25,    5,  100
gkpres, ihpres			FLslider	"Bow Pressure",					0.01,    90,    -1,    23,    idpres,     490,     25,    5,  150

gkminfreq,ihminfreq		FLslider 	"Minimum Frequency (i-rate and optional)",	20,   20000,    -1,    23,    idminfreq,  490,     25,    5,  570
gkRvbSend,ihRvbSend		FLslider 	"Reverb Send",					0,        1,     0,    23,    -1,         240,     25,    5,  620 
gkRvbSize,ihRvbSize		FLslider 	"Reverb Size",					0.5,   0.99,     0,    23,    -1,         240,     25,  255,  620 







;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,       9,    15,    490,    105,    5, 200	;BOW PRESSURE ENVELOPE

;BUTTONS                              			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkPresEnv,ihPresEnv	FLbutton	"On / Off",	1,    0,    22,     80,    25,    15, 235,    -1
FLsetColor2	255, 50, 50, ihPresEnv		;SET SECONDARY COLOUR TO YELLOW

;TEXT BOXES							TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Bow Pressure Envelope",	1,      11,    15,    180,     12,   160, 205

;VALUE DISPLAY BOXES	LABEL  | WIDTH | HEIGHT | X |  Y
idPlev1		FLvalue	"",       40,     18,    105, 280
idPtim1		FLvalue	"",       40,     18,    155, 280
idPlev2		FLvalue	"",       40,     18,    205, 280
idPtim2		FLvalue	"",       40,     18,    255, 280
idPSusLev	FLvalue	"",       40,     18,    305, 280
idPRelTim	FLvalue	"",       40,     18,    355, 280
idPRelLev	FLvalue	"",       40,     18,    405, 280

;KNOBS							MIN    |   MAX | EXP|  TYPE |  DISP    | WIDTH | X |  Y
gkPlev1,   ihPlev1	FLknob		"Lev.1",	0.01,      90,   -1,    1,   idPlev1,      40,  105, 225
gkPtim1,   ihPtim1	FLknob		"Time.1",	0.001,      5,   -1,    1,   idPtim1,      40,  155, 225
gkPlev2,   ihPlev2	FLknob		"Lev.2",	0.01,      90,   -1,    1,   idPlev2,      40,  205, 225
gkPtim2,   ihPtim2	FLknob		"Time.2",	0.001,      5,   -1,    1,   idPtim2,      40,  255, 225
gkPSusLev, ihPSusLev	FLknob		"Sus.Lev.",	0.01,      90,   -1,    1,   idPSusLev,    40,  305, 225
gkPRelTim, ihPRelTim	FLknob		"Rel.Time",	0.001,      5,   -1,    1,   idPRelTim,    40,  355, 225
gkPRelLev, ihPRelLev	FLknob		"Rel.Lev",	0.01,      90,   -1,    1,   idPRelLev,    40,  405, 225

FLsetTextSize	11,ihPlev1
FLsetTextSize	11,ihPtim1
FLsetTextSize	11,ihPlev2
FLsetTextSize	11,ihPtim2
FLsetTextSize	11,ihPSusLev
FLsetTextSize	11,ihPRelTim
FLsetTextSize	11,ihPRelLev











;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,       9,    15,    490,    115,    5, 310	;bow position
ih		 	FLbox  	" ", 	6,       9,    15,    120,     90,  185, 330

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Bow Position",	1,      11,    15,    180,     12,   160, 315

;VALUE DISPLAY BOXES	LABEL  | WIDTH | HEIGHT | X |  Y
idrat		FLvalue	"",       50,     18,    130, 400

;KNOBS								MIN   | MAX | EXP|  TYPE |  DISP    | WIDTH | X |  Y
gkrat, ihrat		FLknob		"Position",		0.006, 0.988,  0,    1,    idrat,      50,  130, 335
gkPosA, ihPosA		FLknob		"Mod.Amp",		0,         1,  0,    1,    -1,         50,  190, 335
gkPosF, ihPosF		FLknob		"Mod.Freq.",		0.1,      50, -1,    1,    -1,         50,  250, 335
gkPosIRnd, ihPosIRnd	FLknob		"Init.Rand.",		0,         1,  0,    1,    -1,         50,  310, 335


FLsetTextSize	11,ihrat
FLsetTextSize	11,ihPosA
FLsetTextSize	11,ihPosF
FLsetTextSize	11,ihPosIRnd






;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,       9,    15,    490,    115,    5, 445	;VIBRATO

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Vibrato",	1,      11,    15,    180,     12,   160, 450
                                         
;VALUE DISPLAY BOXES	LABEL  | WIDTH | HEIGHT | X |  Y
idvibf		FLvalue	"",       50,     18,   105,  535
idvibamp	FLvalue	"",       50,     18,   165,  535
idVibDel	FLvalue	"",       50,     18,   225,  535

;KNOBS							MIN | MAX | EXP|  TYPE |   DISP  | WIDTH | X | Y
gkvibf, ihvibf		FLknob		"Vib.Freq.",	0,     30,   0,    1,   idvibf,     50,  105, 465
gkvibamp, ihvibamp	FLknob		"Vib.Amp.",	0,    0.1,   0,    1,   idvibamp,   50,  165, 465
gkVibDel, ihVibDel	FLknob		"Delay",	0,      7,   0,    1,   idVibDel,   50,  225, 465
gkDeReg, ihDeReg	FLknob		"Dereg.",	0,      1,   0,    1,   -1,         50,  285, 465                                         
gkTriSq, ihTriSq	FLknob		"Tri/Sq.",	0,      1,   0,    1,   -1,         50,  345, 465
                                                                                               
                       
;SET INITIAL VALUES FOR VALUATORS
		FLsetVal_i	0.3, 	ihamp
		FLsetVal_i	170, 	ihfreq
		FLsetVal_i	3, 	ihpres
		FLsetVal_i	.127236,ihrat
		FLsetVal_i	4.5, 	ihvibf
		FLsetVal_i	.008, 	ihvibamp
		FLsetVal_i	20, 	ihminfreq
		FLsetVal_i	0.2, 	ihTriSq
		FLsetVal_i	1.5, 	ihVibDel
		FLsetVal_i	0.1, 	ihporttime
		FLsetVal_i	0.5, 	ihPosF
		FLsetVal_i	0.2, 	ihRvbSend
		FLsetVal_i	0.8, 	ihRvbSize
		FLsetVal_i	90, 	ihPlev1
		FLsetVal_i	0.1, 	ihPtim1
		FLsetVal_i	1, 	ihPlev2
		FLsetVal_i	0.1, 	ihPtim2
		FLsetVal_i	90, 	ihPSusLev
		FLsetVal_i	0.1, 	ihPRelTim
		FLsetVal_i	90, 	ihPRelLev


		FLpanel_end

;INSTRUCTIONS AND INFO PANEL                       
				FLpanel	" ", 500, 740, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           wgbow                             ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"wgbow is a wave guide physical model of a bowed string based ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"on work by Perry Cook but re-coded for Csound by John ffitch.", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"Bow pressure represents the downward pressure of the bow upon", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"the string and should be a value between 1 and 5. The author ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"suggests a value of about 3 to represent normal bow pressure.", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"Bow position represents the position of the bow along the    ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"length of the string.                                        ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"Bow position represents the position of the bow along the    ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"length of the string. The opcode author suggests that we     ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"choose values within the range .025 to 0.23. He also suggests", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"that a value of .127236 reflects a normal bowing position.   ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"String effects such as 'sul ponticello' (at the bridge) and  ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"'flautando' (over the neck) can be imitated using this       ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"parameter. A value of .025 reflects a 'sul ponticello' style ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"of playing and produces a thinner tone. A value of .23       ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"reflects a 'flautando' style of playing and produces a flute-", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"-like tone. Additional modulations of this paramter I have   ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"implemented are an init-time random offset value which adds  ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"or subtracts a bow position offset value to each note. This  ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"random value will be different for each new note and is      ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"useful for humanising short repeating notes. 'Mod Amp' and   ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"'Mod Freq' are used to setup a continuously varying random   ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"movement of bow position, as if the bow is also moving       ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"perpendicularily along the string.                           ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"Vibrato is implemented within the opcode and does not need to", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"be applied separately to the frequency parameter. Vibrato    ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"amplitude and frequency are input arguments of the the       ", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"opcode. In addition, this example allows the user to de-     ", 	1,      5,     14,    490,    15,     5, 560
ih		 	FLbox  	"-regulate vibrato amplitude and frequency for a more human   ", 	1,      5,     14,    490,    15,     5, 580
ih		 	FLbox  	"sounding vibrato. 'Delay' delays the onset of the vibrato.   ", 	1,      5,     14,    490,    15,     5, 600
ih		 	FLbox  	"The user is also required to provide a vibrato 'shape' via a ", 	1,      5,     14,    490,    15,     5, 620
ih		 	FLbox  	"function table. Often this is a sine wave but in this example", 	1,      5,     14,    490,    15,     5, 640
ih		 	FLbox  	"the user can morph this waveform continuously from a triangle", 	1,      5,     14,    490,    15,     5, 660
ih		 	FLbox  	"to a square waveform.                                        ", 	1,      5,     14,    490,    15,     5, 680
ih		 	FLbox  	"Minimum frequency (optional) defines the lowest frequency at ", 	1,      5,     14,    490,    15,     5, 700
ih		 	FLbox  	"which the model will play.                                   ", 	1,      5,     14,    490,    15,     5, 720
ih		 	FLbox  	"Bow pressure can also be modulated using an envelope which   ", 	1,      5,     14,    490,    15,     5, 740
ih		 	FLbox  	"can be set up using the GUI controls. When activated, the    ", 	1,      5,     14,    490,    15,     5, 760
ih		 	FLbox  	"FLTK slider is bypassed. Bow pressure envelope can be used   ", 	1,      5,     14,    490,    15,     5, 780
ih		 	FLbox  	"to imitate spiccato bowing techniques.                       ", 	1,      5,     14,    490,    15,     5, 800
ih		 	FLbox  	"This example can also be triggered via MIDI. MIDI note       ", 	1,      5,     14,    490,    15,     5, 820
ih		 	FLbox  	"number, velocity and pitch bend are interpreted              ", 	1,      5,     14,    490,    15,     5, 840
ih		 	FLbox  	"appropriately.                                               ", 	1,      5,     14,    490,    15,     5, 860

		FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen	0, 0, 4096, 10, 1	;SINE WAVE (USED FOR VIBRATO)
gisqu	ftgen	0, 0, 4096, 7, 1, 2048, 1, 0, -1, 2048, -1 
gitri	ftgen	0, 0, 4096, 7, 0, 1024, 1, 2048, -1, 1024, 0 
gimix	ftgen	0, 0, 4096, 2, 0 
giMixTabs	ftgen	0,0,2,-2,gitri,gisqu
gasendL,gasendR	init	0



opcode	lineto2,k,kk
 kinput,ktime	xin
 ktrig	changed	kinput,ktime				; reset trigger
 if ktrig==1 then					; if new note has been received or if portamento time has been changed...
  reinit RESTART
 endif
 RESTART:						; restart 'linseg' envelope
 if i(ktime)==0 then					; 'linseg' fails if duration is zero...
  koutput	=	i(kinput)			; ...in which case output simply equals input
 else
  koutput	linseg	i(koutput),i(ktime),i(kinput)	; linseg envelope from old value to new value
 endif
 rireturn
 		xout	koutput
endop




instr	99	; mix tables for vibrato function
	gkftndx	=	1
	ftmorf gkTriSq, giMixTabs, gimix
endin

instr	1	;MIDI ACTIVATED INSTRUMENT
	if	gkOnOff=1	then ; SENSE FLTK ON/OFF SWITCH
			turnoff	;TURNOFF THIS INSTRUMENT IMMEDIATELY
	endif
	
	ioct	octmidi		;READ NOTE VALUES FROM MIDI INPUT IN THE 'OCT' FORMAT
	iamp	ampmidi	1	;AMPLITUDE IS READ FROM INCOMING MIDI NOTE

	if gklegato==1 then
	 gkoct	=	ioct			;CREATE A K-RATE GLOBAL VARIABLE VERSION OF OCTAVE
	 gkVAmp	=	iamp
	 event_i	"i",3,0,-1		;THE VERY FIRST MIDI NOTE PLAYED WILL TRIGGER AN INFINITELY HELD NOTE IN INSTR 2. THE maxalloc SETTING IN THE ORCHESTRA HEADER WILL PREVENT ANY FURTHER TRIGGERINGS. 
                
	else
	 
	 kporttime	linseg	0,0.001,0.05
	 
	 if gkPosA>0 then			; randomise bowing position
	  kRatMod	rspline	-gkPosA,gkPosA,gkPosF*0.5,gkPosF*2
	  ;iRatRnd	random	-i(gkPosIRnd), i(gkPosIRnd)
	  krat		mirror	gkrat + kRatMod, 0, 1
	 else
	  krat		portk	gkrat, kporttime
	 endif
         
	 iRatRnd	random	-i(gkPosIRnd), i(gkPosIRnd)
         krat		mirror	krat + iRatRnd, 0, 1
         
	 kRndVibF	rspline	-gkDeReg,gkDeReg,1,5		; deregulation of vibrato amplitude and frequency for more humanistic results
	 kvibf		=	gkvibf * (2 ^ kRndVibF)
	 kRndVibA	rspline	-gkDeReg,gkDeReg,1,5
	 kvibamp		=	gkvibamp * (2 ^ kRndVibA)

	 if i(gkVibDel)>0 then					; vibrato amplitude envelope
	  kVibEnv	transeg	0,i(gkVibDel),4,1
	  kvibamp	=	kvibamp * kVibEnv
	 endif
         
	 if gkPresEnv==1 then
	  ; envelope
	  kpres		expsegr	i(gkPlev1),i(gkPtim1),i(gkPlev2),i(gkPtim2),i(gkPSusLev),i(gkPRelTim),i(gkPRelLev)
	 else
	  ;kpres	aftouch	1, 5		;AFTERTOUCH CONTROL OF BOW PRESSURE
	  ;kpres	ctrl7	1, 1, 1, 5	;MOD. WHEEL CONTROL OF BOW PRESSURE
	  kpres	=	gkpres
	 endif
	 
	 ;PITCH BEND INFORMATION IS READ
	 iSemitoneBendRange = 2		;PITCH BEND RANGE IN SEMITONES (WILL BE DEFINED FURTHER LATER) - SUGGESTION - THIS COULD BE CONTROLLED BY AN FLTK COUNTER
	 imin = 0			;EQUILIBRIUM POSITION
	 imax = iSemitoneBendRange * .0833333	;MAX PITCH DISPLACEMENT (IN oct FORMAT)
	 kbend	pchbend	imin, imax	;PITCH BEND VARIABLE (IN oct FORMAT)
	 kfreq	=	cpsoct(ioct+ kbend)
	 aenv	linsegr		1,3600,1,0.01+i(gkPRelTim),0		;ANTI-CLICK ENVELOPE
	 abow	wgbow	gkamp*iamp, kfreq, kpres, krat, kvibf, kvibamp, gimix, i(gkminfreq)
	 abow	=	abow * aenv
	 	outs		abow, abow	;SEND AUDIO TO OUTPUTS
	gasendL	=	gasendL + (abow * gkRvbSend)
	gasendR	=	gasendR + (abow * gkRvbSend)
	endif
endin

instr	2	;FLTK TRIGGERED INSTRUMENT
	if	gkOnOff=0	then ; SENSE FLTK ON/OFF SWITCH
			turnoff	;TURNOFF THIS INSTRUMENT IMMEDIATELY
	endif
	kSwitch		changed		gkminfreq	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then
		reinit	START
	endif
	iporttime	=	0.01
	kporttime	linseg	0,0.01,iporttime,1,iporttime
	krat		portk	gkrat, kporttime
	kfreq		portk	gkfreq, kporttime

	
	if gkPosA>0 then					; randomise bowing position
	 kRatMod	rspline	-gkPosA,gkPosA,gkPosF*0.5,gkPosF*2
	 iRatRnd	random	-i(gkPosIRnd), i(gkPosIRnd)
	 krat		mirror	krat + kRatMod + iRatRnd, 0, 1
	endif
	
	kRndVibF	rspline	-gkDeReg,gkDeReg,1,5		; deregulation of vibrato amplitude and frequency for more humanistic results
	kvibf		=	gkvibf * (2 ^ kRndVibF)
	kRndVibA	rspline	-gkDeReg,gkDeReg,1,5
	kvibamp		=	gkvibamp * (2 ^ kRndVibA)

	if i(gkVibDel)>0 then					; vibrato amplitude envelope
	 kVibEnv	transeg	0,i(gkVibDel),4,1
	 kvibamp	=	kvibamp * kVibEnv
	endif
	   
	if gkPresEnv==1 then
	 ; envelope
	 kpres		expsegr	i(gkPlev1),i(gkPtim1),i(gkPlev2),i(gkPtim2),i(gkPSusLev),i(gkPRelTim),i(gkPRelLev)
	else
	 kpres		portk	gkpres, kporttime	
	endif
	
	START:
	abow	wgbow	gkamp, kfreq, kpres, krat, kvibf, kvibamp, gimix, i(gkminfreq)
	rireturn
		outs 	abow, abow
	gasendL	=	gasendL + (abow * gkRvbSend)
	gasendR	=	gasendR + (abow * gkRvbSend)
endin   


instr	3	;LEGATO MIDI INSTRUMENT
	kactive	active	1	; sense number of active instances of instr 1
	if kactive==0 then	; all no instances of instr 1 are playing, i.e. if all midi notes have been released...
	 turnoff		; turn this instrument off
	endif
	
	;CREATE PORTAMENTO ON PITCH PARAMETER
	kporttime	linseg	0,0.01,1					;PORTAMENTO TIME RISES QUICKLY TO A HELD VALUE (0.1)
	koct		lineto2	gkoct, kporttime * gkporttime			;APPLY PORTAMENTO TO NOTE CHANGES
	kamp		lineto2	gkVAmp, kporttime * gkporttime			;APPLY PORTAMENTO TO AMPLITUDE

	kRndVibF	rspline	-gkDeReg,gkDeReg,1,5		; deregulation of vibrato amplitude and frequency for more humanistic results
	kvibf		=	gkvibf * (2 ^ kRndVibF)
	kRndVibA	rspline	-gkDeReg,gkDeReg,1,5
	kvibamp		=	gkvibamp * (2 ^ kRndVibA)

	if i(gkVibDel)>0 then					; vibrato amplitude envelope
	 kVibEnv	transeg	0,i(gkVibDel),4,1
	 kvibamp	=	kvibamp * kVibEnv
	endif
        
	if gkPresEnv==1 then
	 kpres		expsegr	i(gkPlev1),i(gkPtim1),i(gkPlev2),i(gkPtim2),i(gkPSusLev),i(gkPRelTim),i(gkPRelLev)
	else
	 kpres	=	gkpres
	endif
        
	;PITCH BEND INFORMATION IS READ
	iSemitoneBendRange = 2			; PITCH BEND RANGE IN SEMITONES (WILL BE DEFINED FURTHER LATER) - SUGGESTION - THIS COULD BE CONTROLLED BY AN FLTK COUNTER
	imin = 0				; EQUILIBRIUM POSITION
	imax = iSemitoneBendRange * .0833333	; MAX PITCH DISPLACEMENT (IN oct FORMAT)
	kbend	pchbend	imin, imax		; PITCH BEND VARIABLE (IN oct FORMAT)
	kfreq	=	cpsoct(koct+ kbend)
	aenv	linsegr		1,3600,1,0.01+i(gkPRelTim),0		;ANTI-CLICK ENVELOPE
	abow	wgbow	kamp*gkamp, kfreq, kpres, gkrat, kvibf, kvibamp, gimix, i(gkminfreq)
	abow	=	abow *aenv
		outs		abow, abow	;SEND AUDIO TO OUTPUTS
	gasendL	=	gasendL + (abow * gkRvbSend)
	gasendR	=	gasendR + (abow * gkRvbSend)
endin

instr	999
	aL,aR	reverbsc	gasendL, gasendR, gkRvbSize, 3000
		outs		aL,aR
		clear		gasendL,gasendR
endin


</CsInstruments>

<CsScore>
i 99  0 3600
i 999 0 3600	
f 0 3600	;DUMMY SCORE EVENT SUSTAINS REALTIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>