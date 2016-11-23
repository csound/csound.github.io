xyin.csd
Written by Iain McCurdy, 2010

<CsoundSynthesizer>

<CsOptions>
-odac --displays
</CsOptions>

<CsInstruments>

sr	= 	44100
ksmps	= 	100
nchnls	= 	1
0dbfs	=	1
                                                               
FLcolor	255, 255, 255, 0, 0, 0                          
;INSTRUCTIONS AND INFO PANEL
;				LABEL      | WIDTH | HEIGHT | X | Y
				FLpanel	" ",  500,     160,  30,  30
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		FLbox  	"                            xyin                             ", 	1,      5,     14,    490,    15,     5,  0
ih		FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		FLbox  	"xyin creates a mouse position sensitive window.              ", 	1,      5,     14,    490,    15,     5,  40
ih		FLbox  	"In this example x-position controls frequency of an          ", 	1,      5,     14,    490,    15,     5,  60
ih		FLbox  	"oscillator and y-position controls its amplitude.            ", 	1,      5,     14,    490,    15,     5,  80
ih		FLbox  	"It may be required to include the '--displays' command line  ", 	1,      5,     14,    490,    15,     5, 100
ih		FLbox  	"flag for it to function if displays have been disabled       ", 	1,      5,     14,    490,    15,     5, 120
ih		FLbox  	"elsewhere.                                                   ", 	1,      5,     14,    490,    15,     5, 140

				FLpanel_end

FLrun

instr		1		;READ CONTROLLERS, SCAN FOR THRESHOLD CROSSING, OUTPUT CONTROLLER VALUES TO DISPLAY
	iporttime	=	0.05				;PORTAMENTO TIME VARIABLE
	kporttime	linseg	0,0.001,iporttime,1,iporttime	;CREATE A RAMPING UP VARIABLE THAT WILL BE USED FOR PORTAMENTO TIME

	iprd	=	0.1	;PERIOD OF TIME TO RE-SENSE
	ixmin	=	0	;X MINIMUM
	ixmax	=	1	;X MAXIMUM
	iymin	=	0	;Y MINIMUM
	iymax	=	1	;Y MAXIMUM
	ixinit	=	0.1	;X INITIAL VALUE
	iyinit	=	0.1	;Y INITIAL VALUE
	kx, ky xyin iprd, ixmin, ixmax, iymin, iymax, ixinit, iyinit	;CREATE AN xyin PANEL
	
	koct	=	(kx*2)+9		;RESCALE x VARIABLE FOR USE AS AN OCT FORMAT PITCH VALUE
	kcps	=	cpsoct(koct)		;CONVERT OCT-FORMAT PITCH VALUE TO CPS-FORMAT
	kcps	portk	kcps,kporttime		;APPLY PORTAMENTO TO VARIABLE
	kamp	portk	ky, kporttime           ;APPLY PORTAMENTO TO VARIABLE
	a1	vco2	kamp, kcps, 4, 0.5	;CREATE AN OSCILLATOR
		out	a1			;SEND AUDIO TO OUTPUT
endin

</CsInstruments>

<CsScore>
i 1 0 3600	;INSTRUMENT 1 PLAYS A NOTE FOR 1 HOUR (AND KEEPS REAL-TIME PERFORMANCE GOING)
</CsScore>

</CsoundSynthesizer>