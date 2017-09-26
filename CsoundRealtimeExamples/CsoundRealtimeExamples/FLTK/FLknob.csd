FLknob
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-odevaudio -b400
</CsOptions>

<CsInstruments>

sr		=	44100
ksmps		=	32
nchnls		=	2
0dbfs		=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

;		OPCODE	LABEL       | WIDTH | HEIGHT | X | Y
		FLpanel	"FL Knob",     400,    150,   50, 50

imin		=	1	;MINIMUM VALUE OUTPUT BY THE KNOB
imax		=	2000	;MAXIMUM VALUE OUTPUT BY THE KNOB
iexp		=	-1	;LOGARITHMIC TYPE KNOB SELECTED
itype		=	1	;KNOB GRAPHIC TYPE (1=3D KNOB)
idisp		=	-1	;DISPLAY HANDLE (-1=NOT USED)
iwidth		=	70	;WIDTH OF THE KNOB IN PIXELS
ix		=	10	;DISTANCE OF THE LEFT EDGE OF THE KNOB FROM THE LEFT EDGE OF THE PANEL
iy		=	10	;DISTANCE OF THE TOP EDGE OF THE KNOB FROM THE TOP EDGE OF THE PANEL
icursorsize	=	20	;SIZE OF THE INDICATOR (TYPE 1 ONLY)
gkfreq, ihandle1	FLknob	"Frequency (Knob Type 1)", imin, imax, iexp, itype, idisp, iwidth, ix,     iy, icursorsize
gkamp, ihandle2		FLknob	"Amplitude (Knob Type 2)",  0,   0.05,   0,    2,   idisp, iwidth, ix+100, iy, icursorsize
gkpan, ihandle3		FLknob	"Pan (Knob Type 3)",        0,     1,    0,    3,   idisp, iwidth, ix+200, iy, icursorsize
gkpw, ihandle4		FLknob	"Pulse Width (Knob Type 4)",0.005,0.995,   0,    4,   idisp, iwidth, ix+300, iy, icursorsize

;SET INITIAL VALUES OF KNOBS
;OPCODE		VALUE | HANDLE
FLsetVal_i	100,   ihandle1
FLsetVal_i	0.03,  ihandle2
FLsetVal_i	0.5,   ihandle3
FLsetVal_i	0.5,   ihandle4

		FLpanel_end	;END OF PANEL CONTENTS
		FLrun		;RUN THE WIDGET THREAD

;gisine	ftgen	0, 0, 131072, 10, 1		;FUNCTION TABLE THAT DEFINES A SINGLE CYCLE OF A SINE WAVE

instr 	1
	kporttime	linseg	0,0.001,0.05	;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A SET VALUE	
	kcps	portk	gkfreq, kporttime	;SMOOTH SLIDER VARIABLE CHANGES
	kamp	portk	gkamp,  kporttime     	;SMOOTH SLIDER VARIABLE CHANGES
	kpan	portk	gkpan,  kporttime     	;SMOOTH SLIDER VARIABLE CHANGES
	kpw	portk	gkpw,   kporttime      	;SMOOTH SLIDER VARIABLE CHANGES
	;ares 	vco	kamp, kcps, 2, kpw, gisine	;CREATE A PULSE WIDTH MODULATED AUDIO SIGNAL
	ares	vco2	kamp, kcps, 2, kpw
	aL,aR	pan2	ares, kpan			;PAN THE SIGNAL
		outs		aL, aR	;SEND AUDIO TO OUTPUTS
endin

</CsInstruments>

<CsScore>
i 1 0 3600		;INSTRUMENT 1 WILL PLAY A NOTE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>