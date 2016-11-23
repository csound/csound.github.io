SimpleModulatorCarrier.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr	=	44100
ksmps	=	16
nchnls	=	2

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL                           | WIDTH | HEIGHT | X | Y
	FLpanel	"FM Synthesis: Simple Carrier->Modulator", 500,    220,    0,  0

;SWITCHES  	                                  	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    140,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES					WIDTH | HEIGHT | X |  Y
idModAmp			FLvalue	" ",     	60,       20,    5,   75
idCarrAmp			FLvalue	" ",     	60,       20,    5,  125

;					            				MIN  |  MAX  | EXP | TYPE |   DISP   | WIDTH | HEIGHT | X | Y
gkModAmp,ihModAmp		FLslider 	"Modulator Amplitude",		0,     32768,    0,    23,   idModAmp,    490,     25,    5,  50
gkCarrAmp,ihCarrAmp		FLslider 	"Carrier Amplitude",		0,     32768,    0,    23,   idCarrAmp,   490,     25,    5, 100

;						 			MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkModFreq, ihModFreq		FLtext		"Modulator Frequency", 	0,   20000,  .5,     1,    100,     20,    50, 150
gkCarrFreq, ihCarrFreq		FLtext		"Carrier Frequency", 	0,   20000,  .5,     1,    100,     20,   350, 150

			FLsetVal_i	1000, 	ihModAmp
			FLsetVal_i	10000, 	ihCarrAmp
			FLsetVal_i	200, 	ihModFreq
			FLsetVal_i	200, 	ihCarrFreq

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 700, 512, 0
				FLscroll     515, 700, 0, 0

;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"          FM Synthesis: Simple Modulator->Carrier            ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"This example demonstrates FM (frequency modulation) synthesis", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"in its simplest form. Two oscillators are used (one will be  ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"referred to as the 'carrier' and the other as the            ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"'modulator').                                                ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"Both oscillators employ a sine wave shape (as is most often  ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"the case in FM synthesis).                                   ", 	1,      5,     14,    490,    20,     5, 140 
ih		 	FLbox  	"The frequency (pitch) of the carrier is modulated (through   ", 	1,      5,     14,    490,    20,     5, 160 
ih		 	FLbox  	"addition) by the audio output of the modulator.              ", 	1,      5,     14,    490,    20,     5, 180 
ih		 	FLbox  	"Only the audio output of the carrier will be present at the  ", 	1,      5,     14,    490,    20,     5, 200 
ih		 	FLbox  	"final audio outputs of the FM synthesis algorithm. (The      ", 	1,      5,     14,    490,    20,     5, 220 
ih		 	FLbox  	"modulator is heard indirectly through its influence upon the ", 	1,      5,     14,    490,    20,     5, 240 
ih		 	FLbox  	"frequency of the carrier.)                                   ", 	1,      5,     14,    490,    20,     5, 260 
ih		 	FLbox  	"In this example the user is given direct control over the    ", 	1,      5,     14,    490,    20,     5, 280 
ih		 	FLbox  	"amplitudes and frequencies of the modulator and carrier      ", 	1,      5,     14,    490,    20,     5, 300 
ih		 	FLbox  	"oscillators. This is probably not the most useful design for ", 	1,      5,     14,    490,    20,     5, 320 
ih		 	FLbox  	"FM synthesis but should provide a clearer idea of how the    ", 	1,      5,     14,    490,    20,     5, 340 
ih		 	FLbox  	"modulator and carrier interact.                              ", 	1,      5,     14,    490,    20,     5, 360 
ih		 	FLbox  	"First of all adjust the carrier amplitude. Notice how this   ", 	1,      5,     14,    490,    20,     5, 380 
ih		 	FLbox  	"functions as a simple volume control. It has no effect on    ", 	1,      5,     14,    490,    20,     5, 400 
ih		 	FLbox  	"timbre.                                                      ", 	1,      5,     14,    490,    20,     5, 420 
ih		 	FLbox  	"Next adjust the modulator amplitude. Notice how this varies  ", 	1,      5,     14,    490,    20,     5, 440 
ih		 	FLbox  	"the brightness or spectral intensity of the sound. When this ", 	1,      5,     14,    490,    20,     5, 460 
ih		 	FLbox  	"is set at zero we are left with a pure sine tone (not        ", 	1,      5,     14,    490,    20,     5, 480 
ih		 	FLbox  	"silence!).                                                   ", 	1,      5,     14,    490,    20,     5, 500 
ih		 	FLbox  	"When we vary the modulator and carrier frequencies this      ", 	1,      5,     14,    490,    20,     5, 520 
ih		 	FLbox  	"changes the nature of the timbre. (These parameters are      ", 	1,      5,     14,    490,    20,     5, 540 
ih		 	FLbox  	"adjusted by either clicking and dragging left and right on   ", 	1,      5,     14,    490,    20,     5, 560 
ih		 	FLbox  	"the values displayed or by clicking a cursor into the box    ", 	1,      5,     14,    490,    20,     5, 580 
ih		 	FLbox  	"and typing in a new value.)                                  ", 	1,      5,     14,    490,    20,     5, 600 
ih		 	FLbox  	"Notice how when the modulator and carrier frequencies are in ", 	1,      5,     14,    490,    20,     5, 620 
ih		 	FLbox  	"simple ratio with one another harmonic spectra are produced. ", 	1,      5,     14,    490,    20,     5, 640 
ih		 	FLbox  	"For example when M.F. (modulator frequency) is 300 Hz and    ", 	1,      5,     14,    490,    20,     5, 660 
ih		 	FLbox  	"when C.F. (carrier frequency) is 200.                        ", 	1,      5,     14,    490,    20,     5, 680 
ih		 	FLbox  	"Notice how when M.F. and C.F. are not in simple ratio with   ", 	1,      5,     14,    490,    20,     5, 700 
ih		 	FLbox  	"one another inharmonic spectra are produced. For example when", 	1,      5,     14,    490,    20,     5, 720 
ih		 	FLbox  	"M.F. is 277 and C.F. is 200.                                 ", 	1,      5,     14,    490,    20,     5, 740 
ih		 	FLbox  	"Notice how when one frequency is slowly detuned away from a  ", 	1,      5,     14,    490,    20,     5, 760 
ih		 	FLbox  	"simple ratio with respect to the other a kind of timbral     ", 	1,      5,     14,    490,    20,     5, 780 
ih		 	FLbox  	"'beating' is heard. As the amount of detuning increases the  ", 	1,      5,     14,    490,    20,     5, 800 
ih		 	FLbox  	"rate of beating increases until it is no longer perceivable. ", 	1,      5,     14,    490,    20,     5, 820 
ih		 	FLbox  	"In general the modulator amplitude should be quite low in    ", 	1,      5,     14,    490,    20,     5, 840 
ih		 	FLbox  	"order to produce more interesting timbres that are not       ", 	1,      5,     14,    490,    20,     5, 860 
ih		 	FLbox  	"excessively shrill. As M.F. and C.F. are lowered the         ", 	1,      5,     14,    490,    20,     5, 880 
ih		 	FLbox  	"modulator amplitude should be also be lowered to maintain a  ", 	1,      5,     14,    490,    20,     5, 900 
ih		 	FLbox  	"constant spectral intensity. This is why in conventionally   ", 	1,      5,     14,    490,    20,     5, 920 
ih		 	FLbox  	"implemented FM synthesis a new parameter called 'the index of", 	1,      5,     14,    490,    20,     5, 940 
ih		 	FLbox  	"modulation' is derived that is directly proportional to the  ", 	1,      5,     14,    490,    20,     5, 960 
ih		 	FLbox  	"peak deviation (amplitude) of the modulator and inversely    ", 	1,      5,     14,    490,    20,     5, 980 
ih		 	FLbox  	"proportional to carrier modulator frequency.                 ", 	1,      5,     14,    490,    20,     5, 1000
ih		 	FLbox  	"The next example makes use of the 'index of modulation'      ", 	1,      5,     14,    490,    20,     5, 1020
ih		 	FLbox  	"formula.                                                     ", 	1,      5,     14,    490,    20,     5, 1040
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 1060
ih		 	FLbox  	"  SIMPLIFIED SCHEMATIC FOR A MODULATOR AND CARRIER FM PAIR   ", 	1,      5,     14,    490,    20,     5, 1080
ih		 	FLbox  	" ----------------------------------------------------------  ", 	1,      5,     14,    490,    20,     5, 1100
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 1120
ih		 	FLbox  	"                         +-----------+                       ", 	1,      5,     14,    490,    20,     5, 1140
ih		 	FLbox  	"                         |   oscil   |                       ", 	1,      5,     14,    490,    20,     5, 1160
ih		 	FLbox  	"                         |(modulator)|                       ", 	1,      5,     14,    490,    20,     5, 1180
ih		 	FLbox  	"                         +-----+-----+                       ", 	1,      5,     14,    490,    20,     5, 1200
ih		 	FLbox  	"                               |                             ", 	1,      5,     14,    490,    20,     5, 1220
ih		 	FLbox  	"                               |                             ", 	1,      5,     14,    490,    20,     5, 1240
ih		 	FLbox  	"                               |                             ", 	1,      5,     14,    490,    20,     5, 1260
ih		 	FLbox  	"                               |                             ", 	1,      5,     14,    490,    20,     5, 1280
ih		 	FLbox  	"                               |                             ", 	1,      5,     14,    490,    20,     5, 1300
ih		 	FLbox  	"                         +-----------+                       ", 	1,      5,     14,    490,    20,     5, 1320
ih		 	FLbox  	"                         |   oscil   |                       ", 	1,      5,     14,    490,    20,     5, 1340
ih		 	FLbox  	"                         | (carrier) |                       ", 	1,      5,     14,    490,    20,     5, 1360
ih		 	FLbox  	"                         +-----+-----+                       ", 	1,      5,     14,    490,    20,     5, 1380
ih		 	FLbox  	"                               |                             ", 	1,      5,     14,    490,    20,     5, 1400
ih		 	FLbox  	"                               |                             ", 	1,      5,     14,    490,    20,     5, 1420
ih		 	FLbox  	"                              OUT                            ", 	1,      5,     14,    490,    20,     5, 1440
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 1460

				FLscrollEnd
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen 0, 0, 65536, 10, 1	;A SINE WAVE (INTERPOLATING OSCILLATOR OPCODES ARE USED THEREFORE A SMALL TABLE SIZE (+1) CAN BE USED)

instr 1
	if	gkOnOff=0	then	;IF On/Off SWITCH IS SET TO 'OFF'...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	kporttime	linseg	0,0.001,0.005,1,0.005	;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A SET VALUE
	kModAmp		portk	gkModAmp, kporttime	;SMOOTH SLIDER VARIABLE
	aModAmp		interp	kModAmp			;INTERPOLATE AND CREATE AN AUDIO RATE VERSION OF K-RATE VARIABLE

	;OUTPUT		OPCODE	AMPLITUDE   |   FREQUENCY               | FUNCTION_TABLE	
	aModulator	oscili	aModAmp,      gkModFreq,                    gisine		;DEFINE THE MODULATOR WAVEFORM
	aCarrier	oscili	gkCarrAmp,     gkCarrFreq+aModulator,        gisine		;DEFINE THE CARRIER WAVEFORM (NOTE HOW ITS FREQUENCY IS MODULATED (THROUGH ADDITION) BY THE AUDIO OUTPUT OF THE MODULATOR WAVEFORM)
			outs	aCarrier, aCarrier	;SEND THE AUDIO OUTPUT OF THE CARRIER WAVEFORM *ONLY* TO THE OUTPUTS 
endin
	
</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT - KEEPS REALTIME PERFORMANCE GOING FOR ONE HOUR
</CsScore>

</CsoundSynthesizer>