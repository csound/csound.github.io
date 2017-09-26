;Written by Iain McCurdy, 2009

<CsoundSynthesizer>
<CsOptions>
-odevaudio -b400
</CsOptions>

<CsInstruments>

;A SINE WITH OSCILLATOR WITH FL-TEXT BOX CONTROLLED FREQUENCY
;EITHER CLICK AND DRAG OR DOUBLE CLICK AND TYPE TO CHANGE FREQUENCY VALUE

sr		=	44100
ksmps		=	10
nchnls		=	2
0dbfs		=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

;		OPCODE	LABEL    | WIDTH | HEIGHT | X | Y
		FLpanel	"FLtext",   260,    630,   50, 50

imin		=	20	;MINIMUM VALUE OUTPUT BY THE TEXT BOX
imax		=	5000	;MAXIMUM VALUE OUTPUT BY THE TEXT BOX
istep		=	1	;STEP SIZE
itype		=	1	;TEXT BOX GRAPHIC TYPE
iwidth		=	70	;WIDTH OF THE TEXT BOX IN PIXELS
iheight		=	30	;HEIGHT OF THE TEXT BOX IN PIXELS
ix		=	100	;DISTANCE OF THE LEFT EDGE OF THE TEXT BOX FROM THE LEFT EDGE OF THE PANEL
iy		=	 50	;DISTANCE OF THE TOP EDGE OF THE TEXT BOX FROM THE TOP EDGE OF THE PANEL
gkfreq,ih1	FLtext		"Frequency", imin, imax, istep, itype, iwidth, iheight, ix, iy
gkamp, ih2	FLtext		"Amplitude", 0,      1,  0.01,    2,   iwidth, iheight, ix, iy+200
gkpan, ih3	FLtext		"Pan",       0,      1,  0.01,    3,   iwidth, iheight, ix, iy+400

;TEXT BOXES									TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 FLbox  	"Text input widget type 1: values", 	1,      5,     14,    260,    20,     0, 100
ih		 FLbox  	"can be changed by clicking and  ", 	1,      5,     14,    260,    20,     0, 120
ih		 FLbox  	"dragging horizontally on the box", 	1,      5,     14,    260,    20,     0, 140
ih		 FLbox  	"or by typing values directly    ", 	1,      5,     14,    260,    20,     0, 160
ih		 FLbox  	"into the box.                   ", 	1,      5,     14,    260,    20,     0, 180

ih		 FLbox  	"Text input widget type 2: values", 	1,      5,     14,    260,    20,     0, 300
ih		 FLbox  	"can be changed by typing values ", 	1,      5,     14,    260,    20,     0, 320
ih		 FLbox  	"directly into the box.          ", 	1,      5,     14,    260,    20,     0, 340

ih		 FLbox  	"Text input widget type 3: values", 	1,      5,     14,    260,    20,     0, 500
ih		 FLbox  	"can be changed by clicking and  ", 	1,      5,     14,    260,    20,     0, 520
ih		 FLbox  	"dragging horizontally on the    ", 	1,      5,     14,    260,    20,     0, 540
ih		 FLbox  	"box.                            ", 	1,      5,     14,    260,    20,     0, 560

;SET INITIAL VALUE OF THE TEXT BOX (FLtext) DOESN'T SEEM TO WORK CORRECTLY UNLESS YOU DO THIS
		FLsetVal_i	200, ih1
		FLsetVal_i	0.1, ih2
		FLsetVal_i	0.5, ih3

		FLpanel_end	;END OF PANEL CONTENTS
		FLrun		;RUN THE WIDGET THREAD!

gisine	ftgen 0, 0, 65536, 10, 1		;FUNCTION TABLE THAT DEFINES A SINGLE CYCLE OF A SINE WAVE

instr 1
	kporttime	linseg	0,0.001,0.005,1,0.005	;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A SET VALUE
	kfreq		portk	gkfreq, kporttime	;SMOOTH SLIDER VARIABLE
	kamp		portk	gkamp, kporttime	;SMOOTH SLIDER VARIABLE
	kpan		portk	gkpan, kporttime	;SMOOTH SLIDER VARIABLE
	afreq		interp	kfreq		;INTERPOLATE AND CREATE AN AUDIO RATE VERSION OF K-RATE VARIABLE
	aamp		interp	kamp		;INTERPOLATE AND CREATE AN AUDIO RATE VERSION OF K-RATE VARIABLE
	apan		interp	kpan		;INTERPOLATE AND CREATE AN AUDIO RATE VERSION OF K-RATE VARIABLE
	asig		oscil	aamp, afreq, gisine	;SINE WAVE OSCILLATOR
	aL, aR		pan2	asig, apan		;PAN MONO SIGNAL - CREATE STEREO OUTPUT
			outs	aL, aR			;SEND AUDIO TO OUTPUTS
endin
		
</CsInstruments>

<CsScore>
i 1 0 3600		;INSTRUMENT 1 WILL PLAY A NOTE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>