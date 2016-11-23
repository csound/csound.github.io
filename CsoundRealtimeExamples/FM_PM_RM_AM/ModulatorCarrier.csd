ModulatorCarrier.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>


<CsInstruments>

sr	=	44100
ksmps	=	128
nchnls	=	2
0dbfs	=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL                           | WIDTH | HEIGHT | X | Y
	FLpanel	"FM Synthesis: Simple Carrier->Modulator", 500,    310,    0,  0

;SWITCHES  	                                  	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    140,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES				WIDTH | HEIGHT | X |  Y
idCarAmp		FLvalue	" ",     	60,       20,     5, 285
idbasefreq		FLvalue	"Base Freq.",	70,       20,     5, 140
idindex			FLvalue	"Index",	70,       20,   325, 140

;SLIDERS				            			MIN  |  MAX | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X | Y
gkbasefreq, ihbasefreq		FLslider 	"Base Frequency",	20,    20000, -1,    23,   idbasefreq,   390,     23,    5,  50

;XY PANELS										MINX | MAXX | MINY | MAXY | EXPX | EXPY |   DISPX   | DISPY  | WIDTH | HEIGHT | X | Y
gkbasefreq, gkindex, ihbasefreq, ihindex	FLjoy	"X - Base Freq.  Y - Index",	20,    2000,    0,    10,    -1,     0,  idbasefreq, idindex,   390,    100,    5,  40

;SLIDERS				            			MIN  |   MAX | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X | Y
gkCarAmp, ihCarAmp		FLslider 	"Carrier Amplitude",	0,        1,   0,    23,  idCarAmp,      490,    25,     5, 260

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	6,        9,    15,    220,    70,   140, 180

;TEXT BOXES					 			MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkCarRatio, ihCarRatio		FLtext		" ", 			.125,   8,  .001,   1,     50,     20,   190, 190
gkModRatio, ihModRatio		FLtext		" ", 			.125,   8,  .001,   1,     50,     20,   260, 190
gkPeakDev, gihPeakDev		FLtext		"Peak Deviation", 	0,  10000,     0,   1,     80,     20,   410,  65 ;DISPLAY ONLY!

;TEXT BOXES										TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	":", 							1,      5,     14,     5,    15,    248,  192
ih		 	FLbox  	"Carrier Frequency", 					1,      5,     12,    90,    15,    170,  220
ih		 	FLbox  	"Modulator Frequency", 					1,      5,     12,    90,    15,    245,  220

			FLsetVal_i	100, 	ihbasefreq
			FLsetVal_i	3, 	ihindex
			FLsetVal_i	1, 	ihCarRatio
			FLsetVal_i	1, 	ihModRatio
			FLsetVal_i	0.2, 	ihCarAmp

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 560, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"          FM Synthesis: Simple Modulator->Carrier            ", 	1,      5,     14,    490,     20,    5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,     20,    5,  20
ih		 	FLbox  	"This example also employs a simple modulator carrier pairing.", 	1,      5,     14,    490,     20,    5,  40
ih		 	FLbox  	"This time, however, the FM implementation and the parameters ", 	1,      5,     14,    490,     20,    5,  60
ih		 	FLbox  	"presented to the user are more typical (and more usable).    ", 	1,      5,     14,    490,     20,    5,  80
ih		 	FLbox  	"The 'Index of Modulation' is used to control the spectral    ", 	1,      5,     14,    490,     20,    5, 100
ih		 	FLbox  	"intensity (brightness) of the FM timbre. This value is used  ", 	1,      5,     14,    490,     20,    5, 120
ih	  	 	FLbox  	"in the formula: 'Peak Deviation = Index * Base Frequency' to ", 	1,      5,     14,    490,     20,    5, 140
ih		 	FLbox  	"calculate the Peak Deviation (amplitude) of the modulator    ", 	1,      5,     14,    490,     20,    5, 160
ih		 	FLbox  	"within the code. A value box for peak deviation is provided  ", 	1,      5,     14,    490,     20,    5, 180
ih		 	FLbox  	"to inform the user how its value changes in relation to      ", 	1,      5,     14,    490,     20,    5, 200
ih		 	FLbox  	"changes made to the base frequency and the index of          ", 	1,      5,     14,    490,     20,    5, 220
ih		 	FLbox  	"modulation. The value for peak deviation can not be directly ", 	1,      5,     14,    490,     20,    5, 240
ih		 	FLbox  	"modified by the user, its value box in the interface is for  ", 	1,      5,     14,    490,     20,    5, 260
ih		 	FLbox  	"display purposes only.                                       ", 	1,      5,     14,    490,     20,    5, 280
ih		 	FLbox  	"The frequencies of the carrier and modulator are calculated  ", 	1,      5,     14,    490,     20,    5, 300
ih		 	FLbox  	"in relation to 'Base Frequency' using a ratio between the    ", 	1,      5,     14,    490,     20,    5, 320
ih		 	FLbox  	"carrier frequency and the modulator frequency. This practice ", 	1,      5,     14,    490,     20,    5, 340
ih		 	FLbox  	"makes it easier for the user to see when the two frequencies ", 	1,      5,     14,    490,     20,    5, 360
ih		 	FLbox  	"are in a simple ratio with respect to each other.            ", 	1,      5,     14,    490,     20,    5, 380
ih		 	FLbox  	"Although the code for this example makes use of two separate ", 	1,      5,     14,    490,     20,    5, 400
ih		 	FLbox  	"'oscili' (oscillator) opcodes for the modulator and carrier  ", 	1,      5,     14,    490,     20,    5, 420
ih		 	FLbox  	"an opcode exists that will allow the FM carrier modulator    ", 	1,      5,     14,    490,     20,    5, 440
ih		 	FLbox  	"pair to be implemented in a single line (foscil/foscili). The", 	1,      5,     14,    490,     20,    5, 460
ih		 	FLbox  	"advantage of emplying separate 'oscili's is that a better    ", 	1,      5,     14,    490,     20,    5, 480
ih		 	FLbox  	"understanding of the innards of FM synthesis is gained and   ", 	1,      5,     14,    490,     20,    5, 500
ih		 	FLbox  	"also that the algorithm can easily be expanded to create more", 	1,      5,     14,    490,     20,    5, 520
ih		 	FLbox  	"complex multi-modulator and multi-carrier algorithms.        ", 	1,      5,     14,    490,     20,    5, 540

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen 0, 0, 65536, 10, 1		;FUNCTION TABLE THAT STORES A SINGLE CYCLE OF A SINE WAVE

instr	1
	if	gkOnOff=0	then	;IF On/Off SWITCH IS SET TO 'OFF'...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING

	kporttime	linseg	0,0.001,0.01			;CREATE A RAMPING UP FUNCTION TO REPRESENT PORTAMENTO TIME
	kindex		portk	gkindex, kporttime		;APPLY PORTAMENTO SMOOTHING
	kbasefreq	portk	gkbasefreq, kporttime		;APPLY PORTAMENTO SMOOTHING
	kCarAmp		portk	gkCarAmp, kporttime		;APPLY PORTAMENTO SMOOTHING
	kpeakdeviation	=	kbasefreq * kindex	;CALCUALATE THE PEAK DEVIATION OF THE MODULATOR FROM THE VALUES GIVEN FOR BASE FREQUENCY AND THE INDEX OF MODULATION
	
	;OUTPUT		OPCODE	AMPLITUDE         |     FREQUENCY                         | FUNCTION_TABLE
	aModulator	oscili	kpeakdeviation,    kbasefreq * gkModRatio,                       gisine		;DEFINE THE MODULATOR WAVEFORM
	aCarrier	oscili	kCarAmp,          (kbasefreq * gkCarRatio) + aModulator,    	 gisine		;DEFINE THE CARRIER WAVEFORM (NOTE HOW ITS FREQUENCY IS MODULATED (THROUGH ADDITION) BY THE AUDIO OUTPUT OF THE MODULATOR WAVEFORM)
			outs	aCarrier, aCarrier	;SEND THE AUDIO OUTPUT OF THE CARRIER WAVEFORM *ONLY* TO THE OUTPUTS 
	ktrig	  	metro	4	;CREATE A REPEATING TRIGGER SIGNAL
	if ktrig==1 then
	  ktrig	changed	gkbasefreq
		FLsetVal 	ktrig, gkbasefreq*gkindex, gihPeakDev	;UPDATE VALUE BOX 'gihPeakDev' WITH THE VALUE kpeakdeviation WHENEVER A TRIGGER PULSE IS RECEIVED
	endif
endin
	
</CsInstruments>


<CsScore>
f 0 3600	;DUMMY SCORE EVENT - KEEPS REALTIME PERFORMANCE GOING FOR ONE HOUR
</CsScore>


</CsoundSynthesizer>



























