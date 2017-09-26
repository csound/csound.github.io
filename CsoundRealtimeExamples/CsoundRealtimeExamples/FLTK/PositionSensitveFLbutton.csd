WRITTEN BY IAIN MCCURDY, 2010

<CsoundSynthesizer>

<CsOptions>
-odac -d -m0
</CsOptions>

<CsInstruments>

sr	= 	44100
ksmps	= 	16
nchnls	= 	2
0dbfs	=	1

FLcolor	0,100,0, 0,100,255

;				LABEL          | WIDTH | HEIGHT | X | Y
	FLpanel	"Position Sensitive FLbutton",    600,    400,   10, 10

;SWITCHES                               	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y  | OPCODE | INS | STARTTIM | IDUR
gkTrigNote, ihTrigNote	FLbutton 	"",	1,    0,    21,    500,    300,   50,  50,    0,      2,      0,       4

FLpanel_end
FLcolor	255, 255, 255, 0, 0, 0
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 220, 30, 480
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"     FLxyin used to create a position sensitive button       ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"By combining a FLxyin position sensitive area with an        ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"FLbutton a button with position sensitivity can be created.  ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"In this example clicking nthe button triggers a note but     ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"position along its x axis controls the pitch and position    ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"along its y axis controls the starting cutoff frequency of   ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"of the filter envelope.                                      ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"In order for this example to work it is important that the   ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"dimensions of the FLbutton correspond to the dimensions of   ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"the FLxyin panel.                                            ", 	1,      5,     14,    490,    15,     5, 200

				FLpanel_end

FLrun

instr	1	;ALWAYS ON INSTRUMENT - SCANS X-Y LOCATION OF MOUSE OVER FLTK BUTTON
	;KOUTX, KOUTY, KINSIDE    FLXYIN IOUTX_MIN, IOUTX_MAX, IOUTY_MIN, IOUTY_MAX, IWINDX_MIN, IWINDX_MAX, IWINDY_MIN, IWINDY_MAX [, IEXPX, IEXPY, IOUTX, IOUTY] 
	gkoutx, gkouty,  kinside  FLxyin    12,        96,        0,         1,        50,         550,         50,         350,        -1,     0
endin

instr	2	;SOUND GENERATING INSTRUMENT. TRIGGERED FROM FLTK BUTTON
	icps	=	cpsmidinn(int(i(gkoutx)))	
	aenv	expsega	0.001,0.01,1,p3-0.01,0.001
	a1	vco2	1, icps, 2, 0.5
	kcf	transeg	50,0.01,-2,cpsoct(8*i(gkouty)+6),p3-0.01,-10,50 
	a1	moogladder	a1, kcf, 0.8
	adelL	rspline	1,10,0.3,1
	adelR	rspline	1,10,0.3,1
	aL	vdelay3	a1,adelL,10
	aR	vdelay3	a1,adelR,10
		outs	aL*aenv/3,aR*aenv/3
endin

</CsInstruments>

<CsScore>
i 1 0 3600	;INSTRUMENT 1 (ALWAYS ON) SENSES XY POSITION OF THE MOUSE
</CsScore>

</CsoundSynthesizer>

