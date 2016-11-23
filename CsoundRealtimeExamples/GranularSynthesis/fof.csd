fof.csd
Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
-odac -dm0 -M0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;			LABEL | WIDTH | HEIGHT | X | Y
		FLpanel	"fof",   500,     680,   0,  0

;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,    0,    22,    150,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;NUMBER DISPLAY BOXES			WIDTH | HEIGHT | X | Y
idamp			FLvalue	" ",	80,      20,     5,  75
idoct			FLvalue	" ",	80,      20,     5, 455
idband			FLvalue	" ",	80,      20,     5, 505
iddur			FLvalue	" ",	80,      20,     5, 555
idris			FLvalue	" ",	80,      20,     5, 605
iddec			FLvalue	" ",	80,      20,     5, 655

;SLIDERS					      		MIN | MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X   | Y
gkamp, ihamp		FLslider	"Amplitude",  		0,       1,  0,    23,    idamp,     490,     25,    5,    50
gkoct, ihoct		FLslider	"Octaviation Factor",	0,       8,  0,    23,    idoct,     490,     25,    5,   430
gkband, ihband		FLslider	"Bandwidth",		0,     100,  0,    23,    idband,    490,     25,    5,   480
gkdur, ihdur		FLslider	"Duration",		.017,    1,  0,    23,    iddur,     490,     25,    5,   530
gkris, ihris		FLslider	"Rise Time",		0.001, 0.5,  0,    23,    idris,     490,     25,    5,   580
gkdec, ihdec		FLslider	"Decay Time",		0.001, 0.5,  0,    23,    iddec,     490,     25,    5,   630

;NUMBER DISPLAY BOXES			WIDTH | HEIGHT | X | Y
idfund			FLvalue	"Fund.",70,      20,     5,  380
idform			FLvalue	"Form.",70,      20,   420,  380

;XY PANELS									MINX | MAXX | MINY | MAXY | EXPX | EXPY | DISPX | DISPY | WIDTH | HEIGHT | X | Y
gkfund, gkform, ihfund, ihform	FLjoy	"X - Fundemental  Y - Formant",	1,     5000,   20,   5000,   -1,    -1,  idfund, idform,   490,    280,    5, 100
FLsetColor2	255, 0, 0, ihfund		;SET SECONDARY COLOUR TO RED
FLsetColor2	255, 0, 0, ihform		;SET SECONDARY COLOUR TO RED

; INITIALISATION OF SLIDERS	VALUE | HANDLE
		FLsetVal_i	0.3, 	ihamp
		FLsetVal_i	60, 	ihfund
		FLsetVal_i	1200, 	ihform
		FLsetVal_i	0, 	ihoct
		FLsetVal_i	50, 	ihband
		FLsetVal_i	.1, 	ihdur
		FLsetVal_i	.003, 	ihris
		FLsetVal_i	.007, 	ihdec

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL

				FLpanel	" ", 515, 700, 512, 0
				FLscroll     515, 700, 0, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                            fof                              ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"FOF (fonction d'onde formantique) is a rather specialised    ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"type of granular synthesis in that its common use is in the  ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"creation of vocal vowel sounds through the use of rapidly    ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"repeated sine wave grains. (The should not be viewed as a    ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"restriction upon it being used less conventionally.) Other   ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"instruments that exhibit a disinctive filtering 'voice', such", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"as the bassoon, can also be successfully imitated.           ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"If the user launches this example, the first thing that is   ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"heard is a stream of repeated pulses in which each pulse is  ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"easily discernible. The pitch contained within each grain is ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"just about discernible.                                      ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"If the 'Formant' slider is raised (XY pad y axis) it is heard", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"that the pitch of each grain is raised.                      ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"If the 'Fundemental' slider is slowly moved from left to     ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"right it is heard that the frequency of grain repetition     ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"increases. As we pass about 35 hertz we are no longer able   ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"distinguish individual grains and instead a new tone emerges ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"which is a consequence of the periodically repeating         ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"identical grains.                                            ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"Keep 'Fundemental' at a highish value - say 200 Hz - and now ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"move the 'Formant' slider. The effect this time is of a      ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"bandpass filter being applied to the tone. A formant is      ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"really just a peak of energy on a harmonic sound spectrum.   ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"The strength of a formant will always be greatest when the   ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"formant frequency is in integer ratio with the fundemental   ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"frequency, e.g. if the fundemental is 100Hz and the formant  ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"is 100Hz/200Hz/300Hz etc. A lift in power can also be heard  ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"if the formant is in integer ratio with the sub-harmonic     ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"below the fundemental. For example, if the fundemental is    ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"still 100Hz the sub-harmonic is 50Hz and the additional (but ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"weaker) peaks will be at 150Hz/250Hz/350Hz and so on.        ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"The phenomena just demonstrated are the fundemental          ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"principles behind fof synthesis. To convincingly imitate     ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"vowel sounds of the human voice about five simulataneous fof ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"signals are needed. For a given voice and vowel, the formant ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"frequencies could remain fixed while the fundemental changes ", 	1,      5,     14,    490,    20,     5, 740 
ih		 	FLbox  	"to express a voice singing different pitches with a constant ", 	1,      5,     14,    490,    20,     5, 760 
ih		 	FLbox  	"vowel sound. Conversely, the formant frequencies can be      ", 	1,      5,     14,    490,    20,     5, 780 
ih		 	FLbox  	"morphed while the fundemental remains constant to imitate a  ", 	1,      5,     14,    490,    20,     5, 800 
ih		 	FLbox  	"voice moving between vowels while singing a long note. A more", 	1,      5,     14,    490,    20,     5, 820 
ih		 	FLbox  	"unusual scenario would be to morph the formants between sets ", 	1,      5,     14,    490,    20,     5, 840 
ih		 	FLbox  	"of values used to define different voice types (soprano, alto", 	1,      5,     14,    490,    20,     5, 860 
ih		 	FLbox  	"tenor, bass etc). The example 'fofx5.csd' models a singing   ", 	1,      5,     14,    490,    20,     5, 880 
ih		 	FLbox  	"voice using five instances of the fof opcode.                ", 	1,      5,     14,    490,    20,     5, 900 
ih		 	FLbox  	"The amplitude envelope that is applied to each grain is      ", 	1,      5,     14,    490,    20,     5, 920
ih		 	FLbox  	"controlled by a combination of the 'Duration' (kdur), 'Rise  ", 	1,      5,     14,    490,    20,     5, 940
ih		 	FLbox  	"Time' (kris), 'Decay Time' (kdec) and 'Bandwidth' (kband).   ", 	1,      5,     14,    490,    20,     5, 960
ih		 	FLbox  	"Bandwidth controls how an exponential curve defined in a     ", 	1,      5,     14,    490,    20,     5, 980
ih		 	FLbox  	"separate function is applied to the decay of each grain.     ", 	1,      5,     14,    490,    20,     5,1000
ih		 	FLbox  	"'Duration' should be at least as long as the sum of 'Rise    ", 	1,      5,     14,    490,    20,     5,1020
ih		 	FLbox  	"Time' and 'Decay Time'. If the attack and the decay of the   ", 	1,      5,     14,    490,    20,     5,1040
ih		 	FLbox  	"grain envelope are too gradual then we will not be able to   ", 	1,      5,     14,    490,    20,     5,1060
ih		 	FLbox  	"perceive the fundemental (only the formant). This may, on    ", 	1,      5,     14,    490,    20,     5,1080
ih		 	FLbox  	"occasion, be a desired effect. As a rule of thumb: in order  ", 	1,      5,     14,    490,    20,     5,1100
ih		 	FLbox  	"for the fundemental to be heard, the grain envelope needs to ", 	1,      5,     14,    490,    20,     5,1120
ih		 	FLbox  	"have a 'hard edge', either at its beginning or end (or both).", 	1,      5,     14,    490,    20,     5,1140
ih		 	FLbox  	"'Octaviation Index' (koct) is typically zero but as it tends ", 	1,      5,     14,    490,    20,     5,1160
ih		 	FLbox  	"to 1 every other grain is increasingly attenuated. When it is", 	1,      5,     14,    490,    20,     5,1180
ih		 	FLbox  	"exactly 1 the grain density is effectively halved and the fof", 	1,      5,     14,    490,    20,     5,1200
ih		 	FLbox  	"fundemental is dropped by one octave. From 1 to 2 the process", 	1,      5,     14,    490,    20,     5,1220
ih		 	FLbox  	"is repeated and the density is halved again and so on from 2 ", 	1,      5,     14,    490,    20,     5,1240
ih		 	FLbox  	"to 3 and beyond. This effect is perceived quite differently  ", 	1,      5,     14,    490,    20,     5,1260
ih		 	FLbox  	"for dense and sparse textures.                               ", 	1,      5,     14,    490,    20,     5,1280
ih		 	FLbox  	"This example can also be played from a MIDI keyboard.        ", 	1,      5,     14,    490,    20,     5,1300

				FLscrollEnd
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen	0, 0, 4096, 10, 1			;SINE WAVE
giexp	ftgen	0, 0, 1024, 19, 0.5, 0.5, 270, 0.5	;EXPONENTIAL CURVE

instr	1
	iporttime	=	0;.2			; CREATE A VARIABLE THAT WILL BE USED FOR PORTAMENTO TIME
	kporttime	linseg	0,0.001,iporttime	; CREATE A VARIABLE THAT WILL BE USED FOR PORTAMENTO TIME

	iMIDIActiveValue	=	1		;IF MIDI ACTIVATED
	iMIDIflag		=	0		;IF FLTK ACTIVATED
	mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 
	icps	cpsmidi		;READ MIDI PITCH VALUES - THIS VALUE CAN BE MAPPED TO GRAIN DENSITY AND/OR PITCH DEPENDING ON THE SETTING OF THE MIDI MAPPING SWITCHES

	if	gkOnOff=0&&iMIDIflag=0	then ;SENSE FLTK ON/OFF SWITCH & WHETHER THIS IS A MIDI NOTE ITS STATUS WILL BE IGNORED
				turnoff	;TURNOFF THIS INSTRUMENT IMMEDIATELY
	endif

	if iMIDIflag=1 then	;IF THIS IS A MIDI ACTIVATED NOTE AND MIDI-TO-DENSITY SWITCH IS ON... 
		kfund	=	icps		;MAP TO MIDI NOTE VALUE TO DENSITY
	else					;OTHERWISE...
		kfund		portk	gkfund, kporttime	;USE THE FLTK SLIDER VALUE
	endif					;END OF THIS CONDITIONAL BRANCH

	kamp	portk	gkamp, kporttime	;APPLY PORTAMENTO TO SELECTED FLTK SLIDER VARIABLE AND CREATE NEW NON-GLOBAL VARIABLES TO BE USED BY THE FOF OPCODE
	kform	portk	gkform, kporttime       ;APPLY PORTAMENTO TO SELECTED FLTK SLIDER VARIABLE AND CREATE NEW NON-GLOBAL VARIABLES TO BE USED BY THE FOF OPCODE
	
	iolaps	=	500		;MAXIMUM ALLOWED NUMBER OF GRAIN OVERLAPS (THE BEST IDEA IS TO SIMPLY OVERESTIMATE THIS VALUE)
	ifna	=	gisine		;WAVEFORM USED BY THE GRAINS (NORMALLY A SINE WAVE)
	ifnb	=	giexp		;WAVEFORM USED IN THE DESIGN OF THE EXPONENTIAL ATTACK AND DECAY OF THE GRAINS
	itotdur	=	3600		;TOTAL DURATION OF THE FOF NOTE. IN NON-REALTIME THIS WILL BE p3. IN REALTIME OVERESTIMATE THIS VALUE, IN THIS CASE 1 HOUR - PERFORMANCE CAN STILL BE INTERRUPTED PREMATURELY
	;THE FOF OPCODE:
	asig 	fof 	gkamp, kfund, kform, gkoct, gkband, gkris, gkdur, gkdec, iolaps, ifna, ifnb, itotdur ;[, iphs] [, ifmode] [, iskip
	aenv	linsegr	0,0.03,1,0.03,0	;ANTI CLICK
		outs	asig*aenv, asig*aenv	;OUTPUT OF fof OPCODE IS SENT TO THE OUTPUTS  
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT - PERMITS REALTIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>