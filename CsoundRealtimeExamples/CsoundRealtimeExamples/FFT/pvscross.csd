;Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
-idevaudio -odevaudio -b4096
</CsOptions>

<CsInstruments>

sr	= 	44100
ksmps	= 	256
nchnls	= 	2

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL      | WIDTH | HEIGHT | X | Y
	FLpanel	"pvscross",   500,    320,    0,  0

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,      9,     15,    490,    70,     5, 160	;BORDER AROUND SOURCE TRANSPOSE ATTRIBUTES
ih		 	FLbox  	" ", 	6,      9,     15,    490,    70,     5, 240	;BORDER AROUND DESTINATION INPUT

;SWITCHES  	                         	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"On/Off",	1,    0,    22,    150,     30,    5,  5,    0,       1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES		LABEL | WIDTH | HEIGHT | X | Y
idamp1			FLvalue	" ",	 80,      20,    5,  75
idamp2			FLvalue	" ",	 80,      20,    5, 125

;SLIDERS				            				MIN   | MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X  | Y
gkamp1, ihamp1		FLslider 	"Source Amplitude (amp 1)",		0,       1,    0,    23,   idamp1,    490,     25,    5,   50
gkamp2, ihamp2		FLslider 	"Destination Amplitude (amp 2)",	0,       1,    0,    23,   idamp2,    490,     25,    5,  100

;COUNTERS					MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkoct, ihoct		FLcount  "Octaves", 	-2,    2,     1,      1,      2,    100,     20,   180,180,   -1
gksemi, ihsemi		FLcount  "Semitones", 	-12,  12,     1,      1,      2,    100,     20,   290,180,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,       1,   255,   255,   255		;NUMBERS MADE INVISIBLE

;BUTTON BANKS			   			TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkinput,   ihinput			FLbutBank	4,      1,     2,     18,      50,  180, 252,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      5,      4,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Live Input", 		1,       5,    12,    70,      25,   206,  251
ih		 	FLbox  	"Drum Loop ", 		1,       5,    12,    70,      25,   206,  276
ih		 	FLbox  	"Source Transpose",     1,       4,    14,   150,      25,   15,  180
ih		 	FLbox  	"Destination Input",    1,       4,    14,   150,      25,   15,  260

;SET INITIAL VALUES FOR SLIDERS 	|VALUE | HANDLE
			FLsetVal_i	0, 	ihamp1
			FLsetVal_i	1, 	ihamp2
			FLsetVal_i	0, 	ihoct
			FLsetVal_i	0, 	ihsemi
			FLsetVal_i	1, 	ihinput

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     440,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          pvscross                           ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"pvscross performs cross synthesis between two fsigs          ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"(streaming phase vocoding analysis signals).                 ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"The harmonic content of a source signal will be imposed upon ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"the dynamic contour of a destination signal. Typically the   ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"source signal should be dynamically steady and a harmonic or ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"resonant, signal. The destination should be dynamically      ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"transient - a drum pattern or speech is typical.             ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"In this example the source sound is a rather cliched         ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"synthesizer pad sequence (but should give a good illustration", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"of the typical usage of this opcode).                        ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"The destination sound in this example is either the          ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"computer's live input or a drum loop.                        ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"The source sound can be transposed in octave and in semitone ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"steps.                                                       ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"The two amplitude sliders control the amount of influence the", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"source and destination sounds have on the amplitude contour  ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"of the output signal. The frequency envelope is always that  ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"of the source therefore the impact of raising the source     ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"amplitude is to increase the sense of the source in the      ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"output mix.                                                  ", 	1,      5,     14,    490,    15,     5, 420
          
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr 		1	;THIS INSTRUMENT GENERATES AND PERFORMS PROCESSING UPON AN FSIG CREATED FROM THE AUDIO STREAM CREATED IN INSTRUMENT 1
	if	gkOnOff=0	then	;IF Sig.Gen. SWITCH IS SET TO 'OFF'...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	kmlt	=	cpsoct(8+gkoct+(gksemi/12))/cpsoct(8)	;DERIVE A PLAYBACK SPEED RATIO FROM TRANSPOSE SETTING
		asrcL, asrcR	diskin2		"synthpad.wav",     kmlt,      0,        1			;READ A STORED AUDIO FILE FROM THE HARD DRIVE
	if	gkinput=0	then	;IF 'INPUT' SELECTOR IS ON 'Live Input'
		adest	inch	1	;READ AUDIO FROM COMPUTER'S FIRST (LEFT) INPUT CHANNEL
	elseif	gkinput=1	then	;IF 'INPUT' SELECTOR IS ON 'Drum Loop'
		adest	diskin2		"loop.wav",      1,      0,        1		;READ A STORED AUDIO FILE FROM THE HARD DRIVE
	endif				;END OF CONDITIONAL BRANCHING
	iFFTsize	=	1024	;SET FFT SIZE TO BE USED IN ANALYSIS   
	ioverlap	=	256     ;SET OVERLAP SIZE TO BE USED IN ANALYSIS
	iwinsize	=	1024    ;SET WINDOW SIZE TO BE USED IN ANALYSIS
	iwintype	=	1	;SET WINDOW TYPE TO BE USED IN ANALYSIS
	fsrcL  		pvsanal		asrcL, iFFTsize, ioverlap, iwinsize, iwintype		;ANALYSE THE AUDIO SIGNAL. OUTPUT AN F-SIGNAL.
	fsrcR  		pvsanal		asrcR, iFFTsize, ioverlap, iwinsize, iwintype		;ANALYSE THE AUDIO SIGNAL. OUTPUT AN F-SIGNAL.
	fdest  		pvsanal		adest, iFFTsize, ioverlap, iwinsize, iwintype		;ANALYSE THE AUDIO SIGNAL. OUTPUT AN F-SIGNAL.

	fcrossL 	pvscross fsrcL, fdest, gkamp1, gkamp2	;IMPLEMENT fsig CROSS SYNTHESIS
	fcrossR 	pvscross fsrcR, fdest, gkamp1, gkamp2	;IMPLEMENT fsig CROSS SYNTHESIS


	;OUTPUT		OPCODE		INPUT
	aresynL		pvsynth  	fcrossL                      		;RESYNTHESIZE THE f-SIGNAL AS AN AUDIO SIGNAL (LEFT CHANNEL)
	aresynR		pvsynth  	fcrossR                      		;RESYNTHESIZE THE f-SIGNAL AS AN AUDIO SIGNAL (RIGHT CHANNEL)
			outs		aresynL, aresynR			;SEND THE RESYNTHESIZED SIGNAL TO THE AUDIO OUTPUTS
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT SUSTAINS REAL-TIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>