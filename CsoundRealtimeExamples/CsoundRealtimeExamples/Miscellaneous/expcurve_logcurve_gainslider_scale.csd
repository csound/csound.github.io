expcurve_logcurve_gainslider_scale.csd
Written by Iain McCurdy, 2013

<CsoundSynthesizer>

<CsOptions>
-dm0 -n
</CsOptions>

<CsInstruments>

sr	= 	44100
ksmps	= 	32
nchnls	= 	2
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL                                | WIDTH | HEIGHT | X | Y
	FLpanel	"expcurve/logcurve/gainslider/scale",   500,    165,    0,  0


;SLIDERS				            				MIN     | MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X  | Y
gkinput, ihinput	FLslider 	"Input",				0,         1,    0,    23,    -1,       490,     25,    5,   65
gkoutput, gihoutput	FLslider 	"Output",				0,         1,    0,    23,    -1,       490,     25,    5,  115

; TEXT BOXES							MIN  | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gksteepness, ihsteepness	FLtext		"Steepness", 	0,     100,  0.1,    1,     80,     20,   170,  5
gkmin, ihmin			FLtext		"Min", 		-20000,20000,0.1,    1,     80,     20,   320,  5
gkmax, ihmax			FLtext		"Max", 		-20000,20000,0.1,    1,     80,     20,   410,  5
gkinputS, gihinputS		FLtext		"", 		0,     127,    0,    1,     80,     20,     5, 90
gkoutputS, gihoutputS		FLtext		"", 		-20000,20000,  0,    1,     80,     20,     5,140


;SET INITIAL VALUES FOR SLIDERS 	|VALUE | HANDLE
			FLsetVal_i	0, 	ihinput
			FLsetVal_i	0, 	gihoutput
			FLsetVal_i	8, 	ihsteepness
			FLsetVal_i	0, 	ihmin
			FLsetVal_i	1, 	ihmax

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS			 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkopcode, ihopcode	FLbutBank	14,     1,     3,     18,     45,    65,  5,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"opcode:",		1,       6,    13,    60,      15,     5,   3
ih		 	FLbox  	"expcurve  ", 		1,       5,    13,    37,      15,   105,   3
ih		 	FLbox  	"logcurve  ", 		1,       5,    13,    37,      15,   105,  18
ih		 	FLbox  	"gainslider", 		1,       5,    13,    37,      15,   105,  33
ih		 	FLbox  	"scale:",		1,       6,    13,    60,      15,   260,   6

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     500,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"             expcurve logcurve gainslider scale              ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"'expcurve' and 'logcurve' are used to rescale a (probably)   ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"linear function within the range 0 to 1 according to an      ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"exponential or logarithmic scale respectively.               ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"The 'curve' value is used to vary the steepness of the curves", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"with larger values (greater than 1) producing steeper curves.", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"Values for curve should be greater than 1 although values    ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"less than 1 but greater than zero are also usable. Negative  ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"values or 1 or zero are not useful.                          ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"Although the input values are expected to be within the range", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"zero to 1, values outside this range are permitted - the     ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"curve is simply continued beyond these values, getting       ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"increasingly steep or shallow. Zero and 1 are always rescaled", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"to zero and 1 respectively.                                  ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"'gainslider' is an implementation of a logarithmic gain      ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"slider similar to the ~gainslider object in MaxMSP. It       ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"expects a value in the range 0 - 127 (but higher values are  ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"permitted). An input of 0 - 127 will output values 0-~0.935. ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"These opcodes are useful for fine tuning the response of GUI ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"sliders.                                                     ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"'scale' is used remap a value, 0 to 1, onto a new scale using", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"a new minimum and maximum. Note that output values less than ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"zero or greater than 1 will be displayed by the outout box   ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"but not the output slider.                                   ", 	1,      5,     14,    490,    15,     5, 480
          
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

alwayson	1

instr	1
 kinput		=	gkinput
 if gkopcode=0 then						; if 'expcurve' opcode selected...
  koutput	expcurve	kinput,gksteepness		; ...create output value by mapping input value through expcurve
 elseif gkopcode=1 then						; otherwise if 'logcurve' has been selected...
  koutput	logcurve	kinput,gksteepness		; ...create output value by mapping input value through logcurve
 else
  kinput	=	kinput*127
  koutput	gainslider kinput
 endif


 koutput	scale	koutput,gkmax,gkmin

 ktrig		changed		gkinput,gksteepness,gkopcode,gkmin,gkmax	; if 'input', 'curve' or 'opcode' are changed generate a trigger which will be used to update the 'output' slider
 FLsetVal	ktrig,koutput,gihoutput				; send output value to 'output' slider
 FLsetVal	ktrig,koutput,gihoutputS			; send output value to 'output' slider
 FLsetVal	ktrig,kinput,gihinputS				; send output value to 'input' slider
endin

</CsInstruments>

<CsScore>
</CsScore>

</CsoundSynthesizer>