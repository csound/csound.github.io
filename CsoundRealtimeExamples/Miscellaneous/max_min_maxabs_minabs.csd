; max_min_maxabs_minabs.csd

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
;					LABEL                    | WIDTH | HEIGHT | X | Y
				FLpanel	"max min maxabs minabs",    500,    260,    0,  0
 
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkopcode, ihopcode		FLbutBank	14,     1,     4,     18,      80,    5,  5,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"max   ", 		1,       5,    14,     45,     20,  27,   3
ih		 	FLbox  	"min   ", 		1,       5,    14,     45,     20,  27,  23
ih		 	FLbox  	"maxabs", 		1,       5,    14,     45,     20,  27,  43
ih		 	FLbox  	"minabs", 		1,       5,    14,     45,     20,  27,  63

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idin1				FLvalue	" ",       60,     17,    5, 105
idin2				FLvalue	" ",       60,     17,    5, 140
idin3				FLvalue	" ",       60,     17,    5, 175
idoutput			FLvalue	" ",       60,     17,    5, 235

;SLIDERS					            	MIN | MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X   | Y
gkin1,ihin1			FLslider 	"Input 1",	-5,    5,    0,    23,   idin1,     490,     15,    5,    90
gkin2,ihin2			FLslider 	"Input 2",	-5,    5,    0,    23,   idin2,     490,     15,    5,   125
gkin3,ihin3			FLslider 	"Input 3",	-5,    5,    0,    23,   idin3,     490,     15,    5,   160
gkoutput,gihoutput		FLslider 	"Output",	-5,    5,    0,    23,   idoutput,  490,     25,    5,   210

;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	0, 	ihin1
				FLsetVal_i	0, 	ihin2
				FLsetVal_i	0, 	ihin3
				FLsetVal_i	0, 	gihoutput
			
				FLpanel_end
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 220, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                   max min maxabs minabs                     ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"'max' outputs the maximum of any number of input signals.    ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"There exists both a-rate and k-rate versions of this opcode. ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"This example employs the k-rate version in which the three   ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"'input' sliders are the inputs and the 'ouput' slider is the ", 	1,      5,     14,    490,    20,     5, 100
ih		  	FLbox  	"opcode output, the maximum of all inputs.                    ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"'maxabs' outputs the absolute maximum of any number of       ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"inputs, i.e. sign is ignored in the input signals.           ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"'min' and 'minabs' behave in a similar way except that they  ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"output minimum values.                                       ", 	1,      5,     14,    490,    20,     5, 200

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

alwayson	1

instr	1
 ktrig	changed	gkin1,gkin2,gkin3,gkopcode
 if gkopcode=0 then
  koutput	max	gkin1,gkin2,gkin3
 elseif gkopcode=1 then
  koutput	min	gkin1,gkin2,gkin3
 elseif gkopcode=2 then 
  koutput	maxabs	gkin1,gkin2,gkin3
 else
  koutput	minabs	gkin1,gkin2,gkin3
 endif
 FLsetVal	ktrig,koutput,gihoutput
endin
  	
</CsInstruments>

<CsScore>
</CsScore>

</CsoundSynthesizer>