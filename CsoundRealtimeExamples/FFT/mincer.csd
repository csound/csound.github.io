mincer.csd
Written by Iain McCurdy, 2010

<CsoundSynthesizer>

<CsOptions>
-odac -dm0  -M0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	16	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL    | WIDTH | HEIGHT | X | Y
		FLpanel	"mincer",   500,    470,    0,  0

;SWITCHES  	         	                         	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off(MIDI)",		1,    0,    22,    110,     25,    5,  5,     0,     1,      0,     -1
gklock,ihlock		FLbutton	"Lock On/Off",		1,    0,    22,    110,     25,  385,  5,    -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 50, 50, ihlock	;SET SECONDARY COLOUR TO RED
gkfreeze,ihfreeze	FLbutton	"Freeze",		1,    0,    21,     60,     20,  435,125,     0,     2,      0,       0.01, 0     
gknormal,ihnormal	FLbutton	"Normal",		1,    0,    21,     60,     20,  375,125,     0,     2,      0,       0.01, 1   
gkunison,ihunison	FLbutton	"Unison",		1,    0,    21,     60,     20,  435,175,     0,     3,      0,       0.01, 1  

;VALUE DISPLAY BOXES	LABEL | WIDTH | HEIGHT | X | Y
gidptr      	FLvalue	" ",	 70,      20,    5,  75
idspeed      	FLvalue	" ",	 70,      20,    5, 125
idpitch      	FLvalue	" ",	 70,      20,    5, 175
idamp      	FLvalue	" ",	 70,      20,    5, 225

;TEXT INPUT		 	MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gk1, gihtime	FLtext	"", 	0,     20,    0,     1,     70,     20,    5,  75

;SLIDER 				LABEL                        | MIN | MAX | EXP | TYPE |  DISP  | WIDTH | HEIGHT | X  | Y
gkptr, ihptr		FLslider	"Manual Pointer (seconds)",     0,    1,   0,    23,    -1,       490,    25,     5,  50
gkspeed, gihspeed	FLslider	"Pointer Speed",               -2,    2,   0,    23,    idspeed,  490,    25,     5, 100
gkpitch, gihpitch	FLslider	"Pitch",                        0.125,4,   0,    23,    idpitch,  490,    25,     5, 150
gkamp, ihamp		FLslider	"Amp",                          0,    5,   0,    23,    idamp,    490,    25,     5, 200

;COUNTERS				     	MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkfile, ihfile	FLcount  	"Input File", 	1,     4,     1,     16,     2,     140,     25,   160,250,   -1 

;TEXT BOXES											TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"1 - Voice | 2 - Synth_Pad | 3 - Drum_Loop | 4 - Seashore", 	1,       1,    13,    490,      20,  10,  295

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkPtrMode, ihPtrMode		FLbutBank	14,     1,     2,     18,      40,   280, 2,   -1
gkFFTsize, ihFFTsize		FLbutBank	14,     1,     6,     18,     120,   110,332,  -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Pointer Mode:", 	1,       5,    14,    110,      20, 170,   0
ih		 	FLbox  	"Manual", 		1,       5,    14,     50,      20, 300,   0
ih		 	FLbox  	"Speed ", 		1,       5,    14,     50,      20, 300,  20
ih		 	FLbox  	"FFT Size:", 		1,       5,    14,    110,      20,   0, 330
ih		 	FLbox  	"128", 			1,       5,    14,     50,      20, 130, 330
ih		 	FLbox  	"512", 			1,       5,    14,     50,      20, 130, 350
ih		 	FLbox  	"1024", 		1,       5,    14,     50,      20, 130, 370
ih		 	FLbox  	"2048", 		1,       5,    14,     50,      20, 130, 390
ih		 	FLbox  	"4096", 		1,       5,    14,     50,      20, 130, 410
ih		 	FLbox  	"8192", 		1,       5,    14,     50,      20, 130, 430

;SET INITIAL VALUES FOR SLIDERS |VALUE | HANDLE
		FLsetVal_i	0.1, ihptr
		FLsetVal_i	1, gihpitch
		FLsetVal_i	1, ihamp
		FLsetVal_i	1, ihlock
		FLsetVal_i	2, ihfile
		FLsetVal_i	1, gihspeed
		FLsetVal_i	1, ihPtrMode
		FLsetVal_i	3, ihFFTsize

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     580,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           mincer                            ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"mincer performs phase vocoding resynthesis on GEN 1 function ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"tables with the option of phase locking. Phase locking can   ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"give improved results, particularly when freezing the time   ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"pointers progress through the sound.                         ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"Access to the GEN 1 function table is done by providing the  ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"opcode with a time value in seconds. This example interprets ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"the lengths of a variety of sound files so that the pointer  ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"always encompasses the entirety of the chosen file.          ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"External to the opcode, a phasor is used to move through the ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"file (speed mode) to provide a 'time scaling' type operation ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"using the 'Speed' control.                                   ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"Additional buttons allow the user to freeze progress through ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"the sound file or to restore normal speed.                   ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"Pitch transposition is also possible by providing a pitch    ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"ratio value. An on screen button will return this control to ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"its unison setting.                                          ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"The user can choose between four input sound file options.   ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"A variety of FFT sizes can be explored - smaller sizes will  ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"will result in less time smearing by more spectral distortion", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"larger sizes will result in less spectral distortion but more", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"time smearing.                                               ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"This example can also be activated from a MIDI keyboard in   ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"which case MIDI pitch is mapped to the the pitch ratio used  ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"by mincer. In this mode the FLTK slider for pitch will be    ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"ignored. Middle C is the point of no transposition.          ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"NOTE THAT IN THE 5.13 MANUAL THE ktab AND klock PARAMETER ARE", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"INCORRECTLY SWAPPED.                                         ", 	1,      5,     14,    490,    15,     5, 560

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gifile1	ftgen	0,0,0,1,"AndItsAll.wav",0,0,1
gifile2	ftgen	0,0,0,1,"SynthPad.wav",0,0,1
gifile3	ftgen	0,0,0,1,"808loop.wav",0,0,1
gifile4	ftgen	0,0,0,1,"Seashore.wav",0,0,1

giFFTsizes	ftgen	0,0,8,-2,128,256,512,1024,2048,4096,8192	;FFT SIZES

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

	ktrigger	changed	gkfile		;IF INPUT FILE COUNTER IS CHANGED GENERATE A '1' (BANG)
	if ktrigger=1 then			;IF A BANG HAD BEEN GENERATED IN THE LINE ABOVE
		reinit	UPDATE			;REINITIALIZE FROM LABEL 'UPDATE'
	endif					;END OF THIS CONDITIONAL BRANCH
	UPDATE:					;LABEL CALLED 'UPDATE'
	itab	init	i(gkfile) + gifile1 - 1	;DERIVE CHOSEN FUNCTION TABLE NUMBER
	ilen	=	nsamp(itab)/sr		;DERIVE FILE LENGTH IN SECONDS
	rireturn				;RETURN FROM REINITIALIZATION PASS
	kptr	=	gkptr*ilen		;POINTER IN SECONDS (AS OPPOSED TO 0-1)	
	FLprintk2	kptr, gidptr	;UPDATE POINTER VALUE IN SECONDS DISPLAY BOX
	kptr	portk	kptr, kporttime		;APPLY PORTAMENTO TO POINTER VARIABLE
	if gkPtrMode=0 then			;IF 'MANUAL POINTER' POINTER MODE HAS BEEN CHOSEN...
		atimpt	interp	kptr		;POINTER TAKEN DIRECTLY FROM FLTK SLIDER
	elseif gkPtrMode=1 then			;OR IF SPEED POINTER MODE HAS BEEN CHOSEN... 
		kspeed	portk	gkspeed, kporttime	;APPLY PORTAMENTO SMOOTHING TO SPEED SLIDER 
		atimpt	phasor	kspeed/ilen	;CREATE A MOVING PHASE VALUE PROPORTIONAL TO SPEED AND INVERSELY PROPOERTIONAL TO FILE LENGTH
		atimpt	=	atimpt * ilen	;RESCALE MOVING PHASE VALUE TO ENCOMPASS ENTIRE SOUND FILE
	endif					;END OF THIS CONDITIONAL BRANCH
	kamp	portk	gkamp, kporttime	;APPLY PORTAMENTO SMOOTHING TO AMPLITUDE SLIDER VALUE
	ktab	=	gifile1 + gkfile - 1	;DERIVE K-RATE TABLE VALUE
	ktrigger	changed	gkFFTsize	;IF gkFFTsize CHANGES GENERATE A '1' (BANG)
	if ktrigger=1 then			;IF THE ABOVE LINE HAS GENERATED A '1'...
		reinit	UPDATE2			;BEGIN A REINITIALIZATION PASS FROM LABEL 'UPDATE2'
	endif					;END OF THIS CONDITIONAL BRANCH
	UPDATE2:				;LABEL CALLED 'UPDATE2'
	ifftsize	table	i(gkFFTsize), giFFTsizes	;DERIVE CHOSEN FFT SIZE FROM ON SCREEN BUTTON BANK AND FFTsizes FUNCTION TABLE
	asig 	mincer 	atimpt, kamp, kpitch, ktab, gklock, ifftsize	;,idecim]	;ktab AND klock SEEM TO BE REVERSED WITH RESPECT TO THEIR DOCUMENTATION IN THE MANUAL
	rireturn
	aenv	linsegr	0,0.05,1,0.05,0		;DE-CLICKING ENVELOPE
		outs	asig*aenv, asig*aenv	;SEND AUDIO TO OUTPUTS
endin

instr	2	;SET TIME SCALING SLIDER TO P4 DETERMINED VALUES
	FLsetVal_i	p4, gihspeed
endin

instr	3	;SET PITCH SCALING SLIDER TO P4 DETERMINED VALUES
	FLsetVal_i	p4, gihpitch
endin

</CsInstruments>

<CsScore>
f 0 3600
e
</CsScore>

</CsoundSynthesizer>