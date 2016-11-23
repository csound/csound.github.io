delaySimplePitchShifter.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	1	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE (MAY NEED TO BE LOW WHEN WORKING WITH SHORT DELAY TIMES DEFINED INITIALLY AT KRATE)
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE


;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL                    | WIDTH | HEIGHT | X | Y
		FLpanel	"Simple Pitch Shifter",     500,    150,    0,  0

;SWITCHES                                           		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,    0,    22,    100,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS			 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkinput, ihinput	FLbutBank	14,     1,     2,     18,      40,  165,  0,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Source:",		1,       6,    12,    40,      18,   120,  0
ih		 	FLbox  	"Soundfile", 		1,       5,    12,    60,      20,   190,  0
ih		 	FLbox  	"Live     ", 		1,       5,    12,    60,      20,   190, 20

;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
idtrans				FLvalue	" ",      80,    20,     5,  75
iddlt				FLvalue	" ",      80,    20,     5, 125

;SLIDERS					            				MIN |  MAX | EXP | TYPE | DISP    | WIDTH | HEIGHT | X | Y
gkGain,ihGain			FLslider 	"Gain",					0,      1,    0,    23,   -1,         230,     20,  265,   5
gktrans,ihtrans			FLslider 	"Transposition (semitones)",		-24,   24,    0,    23,   idtrans,    490,     25,    5,  50
gkdlt,ihdlt			FLslider 	"Delay Time",				.001,  .2,    0,    23,   iddlt,      490,     25,    5, 100

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	.5, 	ihGain
		FLsetVal_i	0, 	ihtrans
		FLsetVal_i	.05, 	ihdlt

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 380, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                delay - simple pitch shifter                 ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"If the delay time is moved in a continuous cycle using a     ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"sawtooth waveform then a steady pitch shifting effect can be ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"achieved. By using a sawtooth up waveform downward           ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"transpositions are achieved. By using a sawtooth down        ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"waveform upward transpoisitions are achieved.                ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"The 'Delay Time' slider controls the amplitude of the        ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"sawtooth waveform that modulates the delay time. Very short  ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"settings of this parameter can lead to harmonic distortions  ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"of the input signal but whilst longer 'Delay Time' settings  ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"give smoother pitch shifing effects, the temporal distortion ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"of the source material becomes more marked.                  ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"This is an extremely basic demonstration of this technique   ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"and glitches in the audio stream are heard each time the     ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"waveform jumps back to the beginning of its cycle. In real   ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"pitch shifters (and in the next example) each cycle of the   ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"delay time oscillation is amplitude enveloped to mute these  ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"glitches.                                                    ", 	1,      5,     14,    490,    15,     5, 360
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


instr	1	;PLAYS FILE
	if gkOnOff=0	then	;SENSE FLTK ON/OFF SWITCH
			turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif			;END OF CONDITIONAL BRANCHING
	if	gkinput=0	then
		;OUTPUT		OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
		asig		diskin2	"AndItsAll.wav",     1,       0,        1
	else
		asig	inch	1
	endif
	gasig		=	asig * gkGain	;RESCALE AUDIO SIGNAL WITH ON-SCREEN GAIN SLIDER
endin

instr 	2	;PITCH SHIFTER-DELAY INSTRUMENT
	kporttime	linseg	0,0.001,0.005,1,0.005	;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A SET VALUE
	ktrans		portk	gktrans, kporttime	;SMOOTH CHANGES IN SLIDER VARIABLE
	kdlt		portk	gkdlt, kporttime	;SMOOTH CHANGES IN SLIDER VARIABLE
	koctfract	=	ktrans/12		;TRANSPOSITION AS FRACTION OF AN OCTAVE
	kratio		=	octave(koctfract)	;RATIO TO PRODUCE PITCH SHIFT
	krate		=	(kratio-1)/kdlt		;SUBTRACT 1/1 SPEED
	
	aphase		phasor	-krate			;MOVING PHASE 1 - 0
	
	aignore		delayr	.2			;ALLOC DELAY LINE
	adelsig		deltap3	aphase * kdlt		;VARIABLE TAP
			delayw	gasig			;WRITE AUDIO TO THE BEGINNING OF THE DELAY BUFFER
	
			outs	adelsig, adelsig
			clear	gasig			;CLEAR THE GLOBAL AUDIO SEND VARIABLES
endin

</CsInstruments>

<CsScore>
;INSTR | START | DURATION
i  2       0       -1	;INSTRUMENT 2 PLAYS A HELD NOTE

f 0 3600	;'DUMMY' SCORE EVENT KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>


</CsoundSynthesizer>



























