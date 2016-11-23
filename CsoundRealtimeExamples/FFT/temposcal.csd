temposcal.csd
Written by Iain McCurdy, 2010

<CsoundSynthesizer>

<CsOptions>
-odac -dm0 -M0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	16	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL       | WIDTH | HEIGHT | X | Y
		FLpanel	"temposcal",   500,    400,    0,  0

;SWITCHES  	                                  		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR | p4
gkOnOff,ihOnOff		FLbutton	"On/Off(MIDI)",		1,    0,    22,    110,     25,    5,  5,     0,     1,      0,      -1
gklock,ihlock		FLbutton	"Lock On",		1,    0,    22,    110,     25,  385,  5,    -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 50, 50, ihlock	;SET SECONDARY COLOUR TO RED
gkfreeze,ihfreeze	FLbutton	"Freeze",		1,    0,    21,     60,     20,  435, 75,     0,     2,      0,       0.01, 0     
gknormal,ihnormal	FLbutton	"Normal",		1,    0,    21,     60,     20,  375, 75,     0,     2,      0,       0.01, 1  
gkunison,ihunison	FLbutton	"Unison",		1,    0,    21,     60,     20,  435,125,     0,     3,      0,       0.01, 1  

;VALUE DISPLAY BOXES	LABEL | WIDTH | HEIGHT | X | Y
idtimescal      FLvalue	" ",	 70,      20,    5,  75
idpitch      	FLvalue	" ",	 70,      20,    5, 125
idamp      	FLvalue	" ",	 70,      20,    5, 175

;SLIDERS   				LABEL                        | MIN | MAX | EXP | TYPE |  DISP     | WIDTH | HEIGHT | X  | Y
gktimescal, gihtimescal	FLslider	"Time Scaling",                -2,    2,   0,    23,    idtimescal,  490,    25,     5,  50
gkpitch, gihpitch	FLslider	"Pitch",                    0.125,    4,  -1,    23,    idpitch,     490,    25,     5, 100
gkamp, ihamp		FLslider	"Amp",                          0,    5,   0,    23,    idamp,       490,    25,     5, 150

;COUNTERS				     	MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkfile, ihfile	FLcount  	"Input File", 	1,     3,     1,     16,     2,     140,     25,   160,200,   -1 

;TEXT BOXES											TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"1 - Voice | 2 - Synth_Pad | 3 - Drum_Loop | 4 - Seashore", 	1,       1,    13,    490,      20,  10,  245

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkFFTsize, ihFFTsize		FLbutBank	14,     1,     6,     18,     120,   110,272,  -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"FFT Size:", 		1,       5,    14,    110,      20,   0, 270
ih		 	FLbox  	"128", 			1,       5,    14,     50,      20, 130, 270
ih		 	FLbox  	"512", 			1,       5,    14,     50,      20, 130, 290
ih		 	FLbox  	"1024", 		1,       5,    14,     50,      20, 130, 310
ih		 	FLbox  	"2048", 		1,       5,    14,     50,      20, 130, 330
ih		 	FLbox  	"4096", 		1,       5,    14,     50,      20, 130, 350
ih		 	FLbox  	"8192", 		1,       5,    14,     50,      20, 130, 370

;SET INITIAL VALUES FOR SLIDERS |VALUE | HANDLE
		FLsetVal_i	1, gihtimescal
		FLsetVal_i	1, gihpitch
		FLsetVal_i	1, ihamp
		FLsetVal_i	1, ihlock
		FLsetVal_i	2, ihfile
		FLsetVal_i	3, ihFFTsize

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     360,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                         temposcal                           ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"temposcal uses phase vocoding with the option of phase       ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"locking to resynthesize a sound file stored in a GEN 1       ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"function table. Movement through the sound file is controlled", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"using a time scaling control.On screen switches allow the    ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"user to instantly freeze the sound or restore normal speed.  ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"Pitch can be controlled independently using a pitch ratio    ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"control. Unison can be restored using an on screen switch.   ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"The user can choose between four input sound file options.   ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"A variety of FFT sizes can be explored - smaller sizes will  ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"will result in less time smearing by more spectral distortion", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"larger sizes will result in less spectral distortion but more", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"time smearing.                                               ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"This example can also be activated from a MIDI keyboard in   ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"which case MIDI pitch is mapped to the the pitch ratio used  ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"by temposcal. In this mode the FLTK slider for pitch will be ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"ignored. Middle C is the point of no transposition.          ", 	1,      5,     14,    490,    15,     5, 340

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

	kamp	portk	gkamp, kporttime	;APPLY PORTAMENTO SMOOTHING TO AMPLITUDE SLIDER VALUE
	ktab	=	gifile1 + gkfile - 1	;DERIVE K-RATE TABLE VALUE
	ktrigger	changed	gkFFTsize	;IF gkFFTsize CHANGES GENERATE A '1' (BANG)
	if ktrigger=1 then			;IF THE ABOVE LINE HAS GENERATED A '1'...
		reinit	UPDATE2			;BEGIN A REINITIALIZATION PASS FROM LABEL 'UPDATE2'
	endif					;END OF THIS CONDITIONAL BRANCH
	UPDATE2:				;LABEL CALLED 'UPDATE2'
	ifftsize	table	i(gkFFTsize), giFFTsizes	;DERIVE CHOSEN FFT SIZE FROM ON SCREEN BUTTON BANK AND FFTsizes FUNCTION TABLE
	asig	temposcal	gktimescal, kamp, kpitch, ktab, gklock, ifftsize	;, idecim, ithresh]
	aenv	linsegr	0,0.05,1,0.05,0		;DE-CLICKING ENVELOPE
		outs	asig*aenv, asig*aenv	;SEND AUDIO TO OUTPUTS
endin

instr	2	;SET TIME SCALING SLIDER TO P4 DETERMINED VALUES
	FLsetVal_i	p4, gihtimescal
endin

instr	3	;SET PITCH SLIDER TO P4 DETERMINED VALUES
	FLsetVal_i	p4, gihpitch
endin

</CsInstruments>

<CsScore>
f 0 3600
e
</CsScore>

</CsoundSynthesizer>