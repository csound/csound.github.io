;WRITTEN BY IAIN MCCURDY, 2010

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr	= 	44100
ksmps	= 	100
nchnls	= 	2
0dbfs	=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

;	LABEL     | WIDTH | HEIGHT | X | Y
FLpanel	"FLxyin",    800,    700,    10,  10
;TEXT BOXES										      TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		FLbox  	"                          FLxyin                             ", 	1,    5,     20,    790,    30,     5,  0
ih		FLbox  	"-------------------------------------------------------------", 	1,    5,     20,    790,    30,     5,  30
ih		FLbox  	"FLxyin senses mouse position within an FL window. The area   ", 	1,    5,     20,    790,    30,     5,  60
ih		FLbox  	"sensed can be all or part of the window.                     ", 	1,    5,     20,    790,    30,     5,  90
ih		FLbox  	"In this example x-position defines the frequency of an       ", 	1,    5,     20,    790,    30,     5,  120
ih		FLbox  	"oscillator and y-position defines the amplitude of this      ", 	1,    5,     20,    790,    30,     5,  150
ih		FLbox  	"oscillator.                                                  ", 	1,    5,     20,    790,    30,     5,  180
ih		FLbox  	"It is not possible to define which window is to be sensed so ", 	1,    5,     20,    790,    30,     5,  210
ih		FLbox  	"this opcode works best when just a single FL panel has been  ", 	1,    5,     20,    790,    30,     5,  240
ih		FLbox  	"created.                                                     ", 	1,    5,     20,    790,    30,     5,  270
FLpanel_end

FLrun

gisine	ftgen	0,0,1024,10,1

instr	1
	iporttime	=	0.05
	kporttime	linseg	0,0.001,iporttime,1,iporttime
	
	;koutx, kouty, kinside  FLxyin ioutx_min, ioutx_max, iouty_min, iouty_max, iwindx_min, iwindx_max, iwindy_min, iwindy_max [, iexpx, iexpy, ioutx, iouty] 
	koutx, kouty, kinside  FLxyin     0,         1,          0,         1,         0,         800,          0,       600; [, iexpx, iexpy, ioutx, iouty] 
	
	koct	=	(koutx*2)+9
	kcps	=	cpsoct(koct)
	kcps	portk	kcps,kporttime
	kamp	portk	kouty, kporttime
	;kinside	portk	kinside, kporttime
	a1	oscili	kamp*0.2*kinside, kcps, gisine
outs	a1, a1

endin

</CsInstruments>

<CsScore>
i 1 0 3600	;INSTRUMENT 1 PLAYS A NOTE FOR 1 HOUR (AND KEEPS REAL-TIME PERFORMANCE GOING)
</CsScore>

</CsoundSynthesizer>