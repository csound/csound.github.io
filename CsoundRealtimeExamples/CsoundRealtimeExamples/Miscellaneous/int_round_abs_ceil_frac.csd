; int_round_abs_ceil_frac.csd
; Written by Iain McCurdy, 2014.

<CsoundSynthesizer>

<CsOptions>
-n -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	16	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL                      | WIDTH | HEIGHT | X | Y
		FLpanel	"int round abs ceil frac",    500,    310,    0,  0

;VALUE INPUT BOXES			MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkinput2, gihinput2	FLtext	"", 	-5,    5,   0.001,  1,     75,      20,    5,  35
 
;VALUE DISPLAY BOXES		LABEL  | WIDTH | HEIGHT | X | Y
idint			FLvalue	"",       75,     17,     5,  85
idround			FLvalue	"",       75,     17,     5, 135
idabs			FLvalue	"",       75,     17,     5, 185
idceil			FLvalue	"",       75,     17,     5, 235
idfrac			FLvalue	"",       75,     17,     5, 285

;SLIDERS					            	MIN | MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X   | Y
gkinput,gihinput		FLslider 	"Input",	-5,    5,    0,    23,  -1,         490,     25,    5,    10
gkint,gihint			FLslider 	"int",	        -5,    5,    0,    23,  idint,      490,     25,    5,    60
gkround,gihround		FLslider 	"round",	-5,    5,    0,    23,  idround,    490,     25,    5,   110
gkabs,gihabs			FLslider 	"abs",		-5,    5,    0,    23,  idabs,      490,     25,    5,   160
gkceil,gihceil			FLslider 	"ceil",		-5,    5,    0,    23,  idceil,     490,     25,    5,   210
gkfrac,gihfrac			FLslider 	"frac",		-5,    5,    0,    23,  idfrac,     490,     25,    5,   260

FLsetColor	255,0,0,gihinput
FLsetColor	255,200,200,gihinput2


;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	0, 	gihinput
				FLsetVal_i	0, 	gihinput2
				FLsetVal_i	0, 	gihint
				FLsetVal_i	0, 	gihround
				FLsetVal_i	0, 	gihabs
				FLsetVal_i	0, 	gihceil
				FLsetVal_i	0, 	gihfrac
			
				FLpanel_end
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 480, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                   int round abs ceil frac                   ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"int(x), round(x), abs(x), ceil(x) and frac(x) can be used to ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"modify an input value (either i, k or a rate) in a variety of", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"ways. They are functions, not opcodes so they operate upon   ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"the bracketed variable and the output is the function text   ", 	1,      5,     14,    490,    20,     5, 100
ih		  	FLbox  	"itself so they can be used directly as input arguments to    ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"opcodes. In this example the user modifies the input value,  ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"either by moving the slider or typing directly into its      ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"number box.                                                  ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"'int' returns the integer if its input value, i.e. it removes", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"the fractional part.                                         ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"'round' rounds its input to the nearer integer 0.5 will be   ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"rounded down to zero, -0.5 will be rounded up to zero.       ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"'abs' returns the absolute value of its input, i.e. negative ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"input values will have the minus sign removed.               ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"'ceil' returns the lowest integer not smaller that its input,", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"i,e, the next smallest integer.                              ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"'frac' returns the fractional part of its input.             ", 	1,      5,     14,    490,    20,     5, 460

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

alwayson	1

instr	1

 ktrig1	changed	gkinput
 ktrig2	changed	gkinput2
 if ktrig1==1 then
  FLsetVal	ktrig1,gkinput,gihinput2
 elseif ktrig2==1 then
  FLsetVal	ktrig2,gkinput2,gihinput
 endif


 kint	=	int(gkinput)
 ktrig	changed	kint
 	FLsetVal	ktrig, kint, gihint

 kround	=	round(gkinput)
 ktrig	changed	kround
 	FLsetVal	ktrig, kround, gihround

 kabs	=	abs(gkinput)
 ktrig	changed	kabs
 	FLsetVal	ktrig, kabs, gihabs

 kceil	=	ceil(gkinput)
 ktrig	changed	kceil
 	FLsetVal	ktrig, kceil, gihceil

 kfrac	=	frac(gkinput)
 ktrig	changed	kfrac
 	FLsetVal	ktrig, kfrac, gihfrac

endin
  	
</CsInstruments>

<CsScore>
</CsScore>

</CsoundSynthesizer>