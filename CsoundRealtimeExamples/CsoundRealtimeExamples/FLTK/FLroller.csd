FLroller.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-odac -d
</CsOptions>

<CsInstruments>

;A SINE WITH OSCILLATOR WITH FL-ROLLER CONTROLLED FREQUENCY

sr		=	44100
ksmps		=	64
nchnls		=	2
0dbfs		=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

FLcolor	255,255,255,0,0,0	;SET COLOUR SCHEME
;		OPCODE	LABEL        | WIDTH | HEIGHT | X | Y
		FLpanel	"FL Rollers",   550,    450,   50, 50

;				iwidth, iheight, ix, iy
idfreq		FLvalue	"", 	90,     20,      20, 75
idamp		FLvalue	"", 	90,     20,     410,405


imin		=	200	;MINIMUM VALUE OUTPUT BY THE ROLLER
imax		=	5000	;MAXIMUM VALUE OUTPUT BY THE ROLLER
istep		=	1	;INCREMENT WITH EACH PIXEL
iexp		=	-1	;LOGARITHMIC TYPE ROLLER SELECTED
itype		=	1	;ROLLER GRAPHIC TYPE (1=HORIZONTAL)
idisp		=	idfreq	;DISPLAY HANDLE (-1=NOT USED)
iwidth		=	360	;WIDTH OF THE ROLLER IN PIXELS
iheight		=	50	;HEIGHT OF THE ROLLER IN PIXELS
ix		=	20	;DISTANCE OF THE LEFT EDGE OF THE KNOB FROM THE LEFT EDGE OF THE PANEL
iy		=	25	;DISTANCE OF THE TOP EDGE OF THE KNOB FROM THE TOP EDGE OF THE PANEL
gkfreq, ihandle1	FLroller	"Frequency (Type 1)", imin, imax, istep, iexp, itype, idisp, iwidth, iheight, ix, iy
gkamp, ihandle2		FLroller	"Amp (Type 2)",        0,      1,  0.001,  0,     2,  idamp,   50,    360,   430, 25

;SET INITIAL VALUES OF KNOBS
;OPCODE		VALUE | HANDLE
FLsetVal_i	200,   ihandle1
FLsetVal_i	0.5,  ihandle2
		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 515,     200,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          FLroller                           ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"", 	1,      5,     14,    490,    20,     5, 180
				FLpanel_end                                                                                                       
		FLrun		;RUN THE WIDGET THREAD!

gisine	ftgen	0, 0, 131072, 10, 1		;FUNCTION TABLE THAT DEFINES A SINGLE CYCLE OF A SINE WAVE

instr 1
	kporttime	linseg	0,0.001,0.005,1,0.005	;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A SET VALUE	
	kfreq	portk	gkfreq, kporttime	;SMOOTH SLIDER VARIABLE CHANGES		
	kamp	portk	1-gkamp,  kporttime	;SMOOTH SLIDER VARIABLE CHANGES	AND INVERT	
	aamp	interp	kamp		;INTERPOLATE kamp TO AUDIO RATE VARIABLE TO CREATE A SMOOTHER MOVEMENT STILL
	afreq	interp	kfreq		;INTERPOLATE kamp TO AUDIO RATE VARIABLE TO CREATE A SMOOTHER MOVEMENT STILL
	asig		oscili	aamp, afreq, gisine
			outs	asig, asig
endin	

</CsInstruments>

<CsScore>
i 1 0 3600		;INSTRUMENT 1 WILL PLAY A NOTE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>