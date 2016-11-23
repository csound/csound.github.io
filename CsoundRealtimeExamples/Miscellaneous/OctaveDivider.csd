<CsoundSynthesizer>

<CsOptions>
-iadc -odac
</CsOptions>

<CsInstruments>
sr = 44100
ksmps = 32
nchnls = 1
0dbfs = 1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL           	 | WIDTH | HEIGHT | X | Y
	FLpanel	"Octave Divider",   500,    250,    0,  0

;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,    0,    22,    120,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
;COUNTERS						MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkdivider, ihdivider	FLcount  "Divider", 		1,    400,     1,     10,     1,    120,    25,   130, 5,    -1
                                   
;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idToneFilt			FLvalue	" ",       70,    20,     5,  75
idInputFilt			FLvalue	" ",       70,    20,     5, 125
iddry				FLvalue	" ",       70,    20,     5, 175
idwet				FLvalue	" ",       70,    20,     5, 225

;SLIDERS												MIN   |  MAX | EXP | TYPE |  DISP     | WIDTH | HEIGHT | X | Y
gkToneFilt, ihToneFilt		FLslider "Tone Filter",		20,    20000,  -1,    23,  idToneFilt,   490,     25,    5,  50
gkInputFilt, ihInputFilt	FLslider "Input High-cut",	20,    20000,  -1,    23,  idInputFilt,  490,     25,    5, 100
gkdry, ihdry				FLslider "Dry",				0,        1,    0,    23,  iddry,        490,     25,    5, 150
gkwet, ihwet				FLslider "Wet",				0,        1,    0,    23,  idwet,        490,     25,    5, 200

;GENERAL_TEXT_SETTINGS			isize, ifont, ialign, ired, igreen, iblue
			FLlabel		13,      1,       1,   255,  255,   255		;NUMBERS MADE INVISIBLE

;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkinput, ihinput	FLbutBank	4,     1,     2,     20,     15*2,  310,  5,   -1

;GENERAL_TEXT_SETTINGS			isize, ifont, ialign, ired, igreen, iblue
			FLlabel		13,      5,      4,   0,      0,     0		;LABELS MADE VISIBLE AGAIN
;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Input:", 	1,      6,     12,     50,    15,   260,   4
ih		 	FLbox  	"Sound File", 	1,      5,     12,     70,    15,   330,   4
ih		 	FLbox  	"Live      ", 	1,      5,     12,     70,    15,   330,  19

FLsetVal_i	2, ihdivider
FLsetVal_i	300, ihInputFilt
FLsetVal_i	1000, ihToneFilt
FLsetVal_i	0.1, ihdry
FLsetVal_i	0.7, ihwet

FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 460, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                     Octave Divider                          ", 	1,      6,     16,    490,    20,     5,   3
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"This example implements a simple octave divider effect as    ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"found on guitar effects pedals.                              ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"From sensing the zero crossings of an input audio signal a   ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"sequence of triggers is generated. If a sequence of these    ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"triggers has been received -the number in each sequence      ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"defined by 'Divider'- the an output signal is flipped between", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"-1 and 1. This output signal flipping between -1 and 1 will  ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"approximate a square wave. Finally the RMS value of the input", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"signal is applied to the output signal (envelope following). ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"A dividing value of 2 should produce a tone one octave       ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"beneath the pitch of the input signal, a value of 3, an      ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"octave and a fifth, a value of 4, two octaves, a value of 1, ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"unison and so on.                                            ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"'Input High-cut' is the cutoff frequency of a lowpass filter ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"applied to the input before entering the octaver tracker.    ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"Reducing this value can help prevent incorrect tracking      ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"(jumping) octaves. It should be adjusted according to the    ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"input instrument selected, i.e. lower it for bass guitar.    ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"The critical code of the octave divider is embedded within a ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"UDO in order to facilitate easy transplantation into a       ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"different project.                                           ", 	1,      5,     14,    490,    20,     5, 440
		FLpanel_end

		FLrun	;RUN THE FLTK WIDGET THREAD

opcode	OctaveDivider,a,akkk
	ain,kdivider,kInputFilt,kToneFilt	xin
	krms	rms		ain
		setksmps	1		;SET kr=sr, ksmps=1 (sample)
	kcount	init		0		;COUNTER USED TO COUNT ZERO CROSSINGS
	kout	init		-1		;INITIAL DISPOSITION OF OUTPUT SIGNAL
	ain	butlp		ain,kInputFilt	;LOWPASS FILTER THE INPUT SIGNAL (TO REMOVE SOME HF OVERTONE MATERIAL)
	ain	butlp		ain,kInputFilt	;LOWPASS FILTER THE INPUT SIGNAL (TO REMOVE SOME HF OVERTONE MATERIAL)
	ain	butlp		ain,kInputFilt	;LOWPASS FILTER THE INPUT SIGNAL (TO REMOVE SOME HF OVERTONE MATERIAL)
	ksig	downsamp	ain		;CREATE A K-RATE VERSION OF THE INPUT AUDIO SIGNAL
	ktrig	trigger		ksig,0,2	;IF THE INPUT AUDIO SIGNAL (K-RATE VERSION) CROSSES ZERO IN EITHER DIRECTION, GENERATE A TRIGGER
	if ktrig==1 then			;IF A TRIGGER HAS BEEN GENERATED...
	 kcount	wrap	kcount+1,0,kdivider	;INCREMENT COUNTER BUT WRAPAROUND ACCORDING TO THE NUMBER OF FREQUENCY DIVISIONS REQUIRED
	 if kcount=0 then			;IF WE HAVE COMPLETED A DIVISION BLOCK (I.E. COUNTER HAS JUST WRAPPED AROUND)...
	  kout =	(kout=-1?1:-1)		;FLIP THE OUTPUT SIGNAL BETWEEN -1 AND 1 (THIS WILL CREATE A SQUARE WAVE)
	 endif
	endif
	aout	upsamp		kout		;CREATE A-RATE SIGNAL FROM K-RATE SIGNAL
	aout	butlp		aout,kToneFilt	;FILTER THE OUTPUT TONE
		xout		aout*krms	;SEND AUDIO BACK TO CALLER INSTRUMENT, SCALE ACCORDING TO THE ENVELOPE FOLLOW OF THE INPUT SIGNAL
endop

instr 1
	if gkOnOff==0 then
	 turnoff
	endif
	if gkinput==0 then
	 ain	diskin2		"AndItsAll.wav",1,0,1
	 ;koct	rspline		6,9,0.1,0.2			; simple sine tone
	 ;ain	poscil		0.2,cpsoct(koct)		; simple sine tone
	else
	 ain	inch	1
	endif
	aout	OctaveDivider	ain, gkdivider, gkInputFilt, gkToneFilt 
		out		(aout*gkwet)+(ain*gkdry)
endin

</CsInstruments>

<CsScore>
i 1 0 1000
e
</CsScore>

</CsoundSynthesizer>