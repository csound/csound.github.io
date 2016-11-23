;WRITTEN BY IAIN MCCURDY, 2010

<CsoundSynthesizer>

<CsOptions>
-odevaudio -b2048 -B4096
</CsOptions>

<CsInstruments>

sr	= 	44100
ksmps	= 	1
nchnls	= 	2
0dbfs	=	1

;       LABEL     | WIDTH | HEIGHT | X | Y
FLpanel	"FLmouse",  1100,    750,    0,  0

;TEXT BOXES																		TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih	FLbox  	"                                                          FLmouse 1                                                            ", 	1,      5,     14,   1090,    15,     5,  0
ih	FLbox  	"-------------------------------------------------------------------------------------------------------------------------------", 	1,      5,     14,   1090,    15,     5,  20
ih	FLbox  	"This example produces no sound but lets the user observe values that are output from the FLmouse opcode in its different modes.", 	1,      5,     14,   1090,    15,     5,  40
ih	FLbox  	"In mode 0 normalized values within the range 0-1 are output relative to the entire screen. In mode 1 raw pixel values are      ", 	1,      5,     14,   1090,    15,     5,  60
ih	FLbox  	"output relative to the entire screen. In mode 2 pixel values relative to this FLTK window are output.                          ", 	1,      5,     14,   1090,    15,     5,  80
ih	FLbox  	"Values output according to the stati of the three possible mouse buttons are also displayed. Right click is button three.      ", 	1,      5,     14,   1090,    15,     5,  80

;VALUE DISPLAY BOXES		LABEL     | WIDTH | HEIGHT |  X |  Y
gidx			FLvalue	"x val.",     80,     20,    10,  200
gidy			FLvalue	"y val.",     80,     20,   110,  200
gidb1			FLvalue	"but.1",      80,     20,   210,  200
gidb2			FLvalue	"but.2",      80,     20,   310,  200
gidb3			FLvalue	"but.3",      80,     20,   410,  200

;COUNTERS				   MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X |  Y  | OPCODE
gkmode, ihmode		FLcount  "Mode",   0,     2,    1,     10,      1,    166,     30,   10, 250,    -1

FLpanel_end
FLrun

giwave	ftgen	0,0,1024,10,1,.1,.05,.025,.0125,.00625	;A HARMONIC WAVEFORM WITH SOME OVERTONES

instr	1		;
	gktrigger	changed	gkmode	;ktrigger is a momentary 1 if gkmode changes
	if	gktrigger=1	then	;IF ktrigger=1...
		reinit	START		;REINITIALIZE BEGINNING AT LABEL 1
	endif				;END OF CONDITIONAL BRANCH
	START:				;LABEL
	kx, ky, kb1, kb2, kb3 FLmouse	i(gkmode)
	FLprintk2	kx, gidx	;IF kx CHANGES UPDATE FL DISPLAY BOX
	FLprintk2	ky, gidy	;IF kY CHANGES UPDATE FL DISPLAY BOX
	FLprintk2	kb1, gidb1	;IF kb1 CHANGES UPDATE FL DISPLAY BOX
	FLprintk2	kb2, gidb2	;IF kb2 CHANGES UPDATE FL DISPLAY BOX
	FLprintk2	kb3, gidb3	;IF kb3 CHANGES UPDATE FL DISPLAY BOX
	rireturn			;RETURN TO PERFORMANCE TIME AFTER REINITIALIZATION PASS
endin

</CsInstruments>

<CsScore>
i 1 0 3600	;INSTRUMENT 1 PLAYS A NOTE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>