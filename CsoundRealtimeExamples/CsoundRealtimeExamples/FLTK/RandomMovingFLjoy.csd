RandomMovingFLjoy.csd
Written by Iain McCurdy

<CsoundSynthesizer>

<CsOptions>
-odac -d -m0
</CsOptions>

<CsInstruments>
sr			=	44100
ksmps			=	8
nchnls			=	2
0dbfs			=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 230, 0, 0, 0	;SET INTERFACE COLOURS
;			LABEL                                       | WIDTH | HEIGHT | X | Y
			FLpanel	"Randomly Moving X-Y Panel Cursor",    500,     800,   0,  0

;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
idXFreq				FLvalue	" ",     50,      18,    5, 575
idYFreq				FLvalue	" ",     50,      18,    5, 625

;XY PANELS				MINX | MAXX | MINY | MAXY | EXPX | EXPY | DISPX | DISPY | WIDTH | HEIGHT | X | Y
gkx, gky, gihx, gihy	FLjoy	" ", 	0,       1,    0,       1,   0,     0,      -1,     -1,    470,    470,    0,  0

;SLIDER					        				MIN | MAX | EXP | TYPE | DISP | WIDTH | HEIGHT |  X  | Y
gkMinX,	ihMinX		FLslider 	" ",					0,     1,    0,    3,     -1,    470,     15,     0,  470
gkMaxX,	ihMaxX		FLslider 	" ",					0,     1,    0,    3,     -1,    470,     15,     0,  485
gkMinY,	ihMinY		FLslider 	" ",					0,     1,    0,    4,     -1,     15,    470,   470,    0
gkMaxY,	ihMaxY		FLslider 	" ",					0,     1,    0,    4,     -1,     15,    470,   485,    0
gkXFreq, ihXFreq	FLslider 	"X:Frequency",				.001, 10,    0,    3,   idXFreq, 490,     25,    5,   550
gkYFreq, ihYFreq	FLslider 	"Y:Frequency",				.001, 10,    0,    3,   idYFreq, 490,     25,    5,   600
gkXi_h,	ihXi_h		FLslider 	"X:Interpolating <-> Sample and Hold",	0,     1,    0,    3,        -1, 490,     25,    5,   650
gkYi_h,	ihYi_h		FLslider 	"Y:Interpolating <-> Sample and Hold",	0,     1,    0,    3,        -1, 490,     25,    5,   700
gkgain,	ihgain		FLslider 	"Gain",					0,   0.2,    0,    3,        -1, 490,     25,    5,   750

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	0, 	ihMinX
		FLsetVal_i	1, 	ihMaxX
		FLsetVal_i	0, 	ihMinY
		FLsetVal_i	1, 	ihMaxY
		FLsetVal_i	1, 	ihXFreq
		FLsetVal_i	1, 	ihYFreq
		FLsetVal_i	1, 	ihXi_h
		FLsetVal_i	1, 	ihYi_h
		FLsetVal_i	0.03, 	ihgain

			FLpanel_end
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 220, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                 FLsetVal - Random Moving XY                 ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"This generates random functions in a manner similar to the   ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"previous example (RandomMovingSlider.csd). In this example   ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"two functions are created which drive the x and y axis       ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"variables of an FLjoy panel. Again random ranges, frequency  ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"and a crossfade between a sample and hold and an             ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"interpolating function are controllable using the FLTK GUI.  ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"These functions are also used in the synthesis of a FOF tone.", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"X axis movement displays the formant and y axis movement     ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"displays the fundemental.                                    ", 	1,      5,     14,    490,    15,     5, 200

				FLpanel_end
			FLrun

gisine	ftgen	0, 0, 1024, 10, 1		;SINE WAVE
giexp	ftgen	0, 0, 1024, 19, .5, .5, 270, .5	;EXPONENTIAL CURVE
			
instr 1
	kxh		randomh		gkMinX, gkMaxX, gkXFreq	;GENERATE SAMPLE AND HOLD TYPE RANDOM VALUES
	kyh		randomh		gkMinY, gkMaxY, gkYFreq  ;GENERATE SAMPLE AND HOLD TYPE RANDOM VALUES
	kxi		lineto		kxh, 1/gkXFreq	;INTERPOLATE VALUES
	kyi		lineto		kyh, 1/gkYFreq	;INTERPOLATE VALUES
	
	kx		ntrpol		kxi, kxh, gkXi_h		;CROSSFADE BETWEEN INTERPOLATING AND SAMPLE AND HOLD TYPE RANDOM VALUES
	ky		ntrpol		kyi, kyh, gkYi_h		;CROSSFADE BETWEEN INTERPOLATING AND SAMPLE AND HOLD TYPE RANDOM VALUES
	kmetro		metro		20				;THIS METRONOME IS USED TO LIMIT THE MAXIMUM RATE OF WIDGET UPDATE
	if kmetro==1 then
	  ktrigx	changed		kx				;CREATE A TRIGGER (MOMENTARY 1 VALUE) EACH TIME kx CHANGES
	  ktrigy	changed		ky                      	;CREATE A TRIGGER (MOMENTARY 1 VALUE) EACH TIME ky CHANGES
			FLsetVal	ktrigx, kx, gihx		;SEND VALUE kx TO X DIRECTION OF X-Y PANEL
			FLsetVal	ktrigy, ky, gihy      		;SEND VALUE ky TO Y DIRECTION OF X-Y PANEL
	endif
	
	;SOUND IS PRODUCED BY THE FOF OPCODE:
	;ASIG 	FOF 	GKAMP  |      KFUND          |      KFORM        | GKOCT | GKBAND | GKRIS | GKDUR | GKDEC | IOLAPS | IFNA |  IFNB |  ITOTDUR
	asig 	fof 	gkgain,  cpsoct(((1-ky)*4)+4),  cpsoct((kx*6)+6),     0,     50,    .003,     .1,    .007,    500,  gisine,  giexp,     3600
			outs	asig, asig
endin

</CsInstruments>

<CsScore>   
i 1 0 3600     	;INSTRUMENT 1 PLAYS FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>