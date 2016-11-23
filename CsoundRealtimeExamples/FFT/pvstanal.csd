; pvstanal.csd
; Written by Iain McCurdy, 2011 

; As of ver. 6.05 a bug exists whereby no sound is produced if wrap is initially zero (off) 


<CsoundSynthesizer>

<CsOptions>
-odac -dm0 -M0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL       | WIDTH | HEIGHT | X | Y
		FLpanel	"pvstanal",   500,    520,    0,  0

;SWITCHES  	                                  		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR | p4
gkOnOff,ihOnOff		FLbutton	"On/Off(MIDI)",		1,    0,    22,    110,     25,    5,  5,     0,     1,      0,      -1
gkdetect,ihdetect	FLbutton	"Onset Detection",	1,    0,    22,    150,     25,  120,  5,    -1
gkwrap,ihwrap		FLbutton	"Loop",			1,    0,    22,    110,     25,  275,  5,    -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihdetect	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihwrap	;SET SECONDARY COLOUR TO YELLOW
gkfreeze,ihfreeze	FLbutton	"Freeze",		0,    1,    22,     70,     20,  425, 75,    -1     
gknormal,ihnormal	FLbutton	"Normal",		1,    0,    21,     60,     20,  365, 75,     0,     2,      0,       0.01, 1  
gkunison,ihunison	FLbutton	"Unison",		1,    0,    21,     60,     20,  435,125,     0,     3,      0,       0.01, 1  
FLsetColor2	255, 255, 50, ihfreeze	;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES	LABEL | WIDTH | HEIGHT | X | Y
idtimescal      FLvalue	"",	 70,      20,    5,  75
idpitch      	FLvalue	"",	 70,      20,    5, 125
idamp      	FLvalue	"",	 70,      20,    5, 175
iddbthresh      FLvalue	"",	 70,      20,    5, 445
idoffset	FLvalue	"",	 70,      20,    5, 495

;TEXT INPUT		 	MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gk1, gihtime	FLtext	"", 	0,     20,    0,     1,     70,     20,    5,  75

;SLIDERS   				LABEL                        | MIN | MAX | EXP | TYPE |  DISP     | WIDTH | HEIGHT | X  | Y
gktimescal, gihtimescal	FLslider	"Time Scaling",                -2,    2,   0,    23,    idtimescal,  490,    25,     5,  50
gkpitch, gihpitch	FLslider	"Pitch",                    0.125,    4,  -1,    23,    idpitch,     490,    25,     5, 100
gkamp, ihamp		FLslider	"Amp",                          0,    5,   0,    23,    idamp,       490,    25,     5, 150
gkdbthresh, ihdbthresh	FLslider	"dB Threshold",                 0,    10,  0,    23,    iddbthresh,  490,    25,     5, 420
gkoffset, ihoffset	FLslider	"Offset",                       0,    1,   0,    23,    idoffset,    490,    25,     5, 470

;COUNTERS				     	MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkfile, ihfile	FLcount  	"Input File", 	1,     4,     1,     16,     2,     140,     25,   160,200,   -1 

;TEXT BOXES											TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"1 - Voice | 2 - Synth_Pad | 3 - Drum_Loop | 4 - Seashore", 	1,       1,    13,    490,      20,  10,  245

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      4,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkFFTsize, ihFFTsize		FLbutBank	14,     1,     7,     18,     140,   110,272,  -1
gkhopsize, gihhopsize		FLbutBank	14,     1,     7,     18,     140,   310,272,  -1
         
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      4,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"FFT Size:", 		1,       5,    14,    110,      20,   0, 270
ih		 	FLbox  	"128", 			1,       5,    14,     50,      20, 130, 270
ih		 	FLbox  	"256", 			1,       5,    14,     50,      20, 130, 290
ih		 	FLbox  	"512", 			1,       5,    14,     50,      20, 130, 310
ih		 	FLbox  	"1024", 		1,       5,    14,     50,      20, 130, 330
ih		 	FLbox  	"2048", 		1,       5,    14,     50,      20, 130, 350
ih		 	FLbox  	"4096", 		1,       5,    14,     50,      20, 130, 370
ih		 	FLbox  	"8192", 		1,       5,    14,     50,      20, 130, 390
ih		 	FLbox  	"Hop Size:", 		1,       5,    14,    110,      20, 200, 270
ih		 	FLbox  	"64", 			1,       5,    14,     50,      20, 330, 270
ih		 	FLbox  	"128", 			1,       5,    14,     50,      20, 330, 290
ih		 	FLbox  	"256", 			1,       5,    14,     50,      20, 330, 310
ih		 	FLbox  	"512", 			1,       5,    14,     50,      20, 330, 330
ih		 	FLbox  	"1024", 		1,       5,    14,     50,      20, 330, 350
ih		 	FLbox  	"2048", 		1,       5,    14,     50,      20, 330, 370
ih		 	FLbox  	"4096", 		1,       5,    14,     50,      20, 330, 390

;SET INITIAL VALUES FOR SLIDERS |VALUE | HANDLE
		FLsetVal_i	1, gihtimescal
		FLsetVal_i	1, gihpitch
		FLsetVal_i	1, ihamp
		FLsetVal_i	2, ihfile
		FLsetVal_i	4, ihFFTsize
		FLsetVal_i	3, gihhopsize
		FLsetVal_i	1, ihdbthresh
		FLsetVal_i	0, ihoffset
		FLsetVal_i	1, ihwrap
		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 515,     500,   512, 0
				FLscroll     515,     500,     0, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          pvstanal                           ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"'pvstanal' is very similar to the 'temposcal' opcode. Its    ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"priniciple difference is that it outputs an fsig as          ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"opposed to an audio signal as is the case with temposcal.    ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"An fsig might be a preferrable output if you are wanting to  ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"perform further processing using other pvs opcodes.          ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"pvstanal does not include the phase locking feature of       ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"temposcal.                                                   ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"pvstanal uses phase vocoding to resynthesize a sound file    ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"stored in a GEN 1 function table. Movement through the sound ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"file is controlled using a time scaling control. On screen   ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"switches allow the user to instantly freeze the sound or     ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"restore normal speed.                                        ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"Pitch can be controlled independently using a pitch ratio    ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"control. Unison can be restored using an on screen switch.   ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"The user can choose between four input sound file options.   ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"This example can also be activated from a MIDI keyboard in   ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"which case MIDI pitch is mapped to the the pitch ratio used  ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"by pvstanal. In this mode the FLTK slider for pitch will be  ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"ignored. Middle C is the point of no transposition.          ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"'pvstanal' includes a facility to detect fast transients of  ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"amplitude and to ignore time-stretching when this happens.   ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"This can used to prevent smearing of the attacks of          ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"percussive sounds. This aspect of the opcode is best explored", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"using the drum loop sample. 'Onset Detection' turns the      ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"effect on and off and 'dB Threshold' defines the decibel     ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"increase needed to trigger the effect.                       ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"A variety of FFT and hop sizes can be explored - smaller     ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"sizes will result in less time smearing but more spectral    ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"distortion, larger sizes will result in less spectral        ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"distortion but more time smearing. Hop size should be at most", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"half the FFT size. This instrument protects against incorrect", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"settings by automatically changing the hop size button bank  ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"if incorrectly set.                                          ", 	1,      5,     14,    490,    20,     5, 680
				FLscroll_end
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gifile1L	ftgen	0,0,0,1,"AndItsAll.wav",0,0,1
gifile2L	ftgen	0,0,0,1,"SynthPad.wav",0,0,1
gifile3L	ftgen	0,0,0,1,"808loop.wav",0,0,1                                                   
gifile4L	ftgen	0,0,0,1,"Seashore.wav",0,0,1

gifile1R	ftgen	0,0,0,1,"AndItsAll.wav",0,0,1
gifile2R	ftgen	0,0,0,1,"SynthPad.wav",0,0,2
gifile3R	ftgen	0,0,0,1,"808loop.wav",0,0,2
gifile4R	ftgen	0,0,0,1,"Seashore.wav",0,0,2

giFFTsizes	ftgen	0,0,8,-2,128,256,512,1024,2048,4096,8192	;FFT SIZES
gihopsizes	ftgen	0,0,8,-2, 64,128,256, 512,1024,2048,4096	;HOP SIZES

instr 1
	kporttime	linseg	0,0.001,0.02	;RAMPING UP FUNCTION TO BE USED FOR PORTAMENTO TIME
	iMIDIActiveValue	=	1		;IF MIDI ACTIVATED
	iMIDIflag		=	0		;IF FLTK ACTIVATED
	mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 
	icps	cpsmidi					;READ MIDI PITCH VALUES IN CPS FORMAT
	if	gkOnOff=0&&iMIDIflag=0	then 		;SENSE FLTK ON/OFF SWITCH & WHETHER THIS IS A MIDI NOTE ITS STATUS WILL BE IGNORED
				turnoff			;TURNOFF THIS INSTRUMENT IMMEDIATELY
	endif

	if iMIDIflag=1 then				;IF THIS IS A MIDI ACTIVATED NOTE... 
		kpitch	=	icps/cpsoct(8)		;MAP TO MIDI NOTE VALUE TO PITCH (CONVERT TO RATIO: MIDDLE C IS POINT OF UNISON)
	else						;OTHERWISE...
		kpitch	portk	gkpitch, kporttime	;APPLY PORTAMENTO SMOOTHING TO PITCH SLIDER VALUE
	endif						;END OF THIS CONDITIONAL BRANCH

	kamp	portk	gkamp, kporttime	;APPLY PORTAMENTO SMOOTHING TO AMPLITUDE SLIDER VALUE
	ktabL	=	gifile1L + gkfile - 1	;DERIVE K-RATE TABLE VALUE
	ktabR	=	gifile1R + gkfile - 1	;DERIVE K-RATE TABLE VALUE
	ktrigger	changed	gkFFTsize,gkoffset,gkdbthresh,gkhopsize	;IF ANY OF THE INPUT ARGUMENTS CHANGE GENERATE A '1' (BANG)
	if ktrigger=1 then			;IF THE ABOVE LINE HAS GENERATED A '1'...
		reinit	UPDATE2			;BEGIN A REINITIALIZATION PASS FROM LABEL 'UPDATE2'
	endif					;END OF THIS CONDITIONAL BRANCH
	UPDATE2:				;LABEL CALLED 'UPDATE2'
	if i(gkhopsize)>=i(gkFFTsize) then			;ENSURE HOP SIZE IS AT MOST HAVE THE SIZE OF FFT SIZE
	 	FLsetVal_i	i(gkFFTsize),gihhopsize		;FIX IT IF IT WASN'T
	endif							;END OF CONDITIONAL BRANCH
	ilen	=	(ftlen(gifile1L+i(gkfile)-1))/sr	;DETERMINE THE LENGTH OF THE INPUT SOUND FILE
	ifftsize	table	i(gkFFTsize), giFFTsizes	;DERIVE CHOSEN FFT SIZE FROM ON SCREEN BUTTON BANK AND FFTsizes FUNCTION TABLE
	ihop		table	i(gkhopsize), gihopsizes	;DERIVE CHOSEN HOP SIZE FROM ON SCREEN BUTTON BANK AND HOPsizes FUNCTION TABLE
	fsigL	pvstanal gktimescal*gkfreeze,kamp,kpitch,ktabL, gkdetect, gkwrap, i(gkoffset)*ilen,ifftsize, ihop, i(gkdbthresh)
	fsigR	pvstanal gktimescal*gkfreeze,kamp,kpitch,ktabR, gkdetect, gkwrap, i(gkoffset)*ilen,ifftsize, ihop, i(gkdbthresh)
	asigL	pvsynth  fsigL					;RESYNTHESIZE THE SIGNAL
	asigR	pvsynth  fsigR
	
	aenv	linsegr	0,0.05,1,0.05,0		;DE-CLICKING ENVELOPE
		outs	asigL*aenv, asigR*aenv	;SEND AUDIO TO OUTPUTS
endin

instr	2	;SET TIME SCALING SLIDER TO P4 DETERMINED VALUES
	FLsetVal_i	p4, gihtimescal
endin

instr	3	;SET TIME SCALING SLIDER TO P4 DETERMINED VALUES
	FLsetVal_i	p4, gihpitch
endin

</CsInstruments>

<CsScore>
f 0 3600
e
</CsScore>

</CsoundSynthesizer>

