;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-odevaudio -b400
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
kr 		= 	441	;CONTROL RATE
ksmps 		= 	100	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;					LABEL   | WIDTH | HEIGHT | X | Y
				FLpanel	"pareq",   500,    350,    0,  0

;SWITCHES                       			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    140,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idc				FLvalue	" ",      70,     20,     5,  75
idv				FLvalue	" ",      70,     20,     5, 125
idq				FLvalue	" ",      70,     20,     5, 175
idamp				FLvalue	" ",      70,     20,     5, 225

;COUNTERS										MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X |  Y  | OPCODE
gkskip, ihskip 			FLcount  "Initialisation 0-On 1-Off", 			0,     1,     1,      1,     2,     150,     25,   345,   5,    -1
gkmode, ihmode			FLcount  "0-Peaking 1-Low_Shelving 2-High_Shelving",	0,     2,     1,      1,     2,     150,     25,   175, 250,    -1

;SLIDERS					            		MIN | MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gkc, ihc			FLslider 	"Cutoff Frequency",	20,  20000, -1,   23,    idc,    490,     25,    5,  50
gkv, ihv			FLslider 	"Parametric Gain",	0,      20,  0,   23,    idv,    490,     25,    5, 100
gkq, ihq			FLslider 	"Q",			.707,   20,  0,   23,    idq,    490,     25,    5, 150
gkamp, ihamp			FLslider 	"Output Amplitude",	0,       4,  0,   23,  idamp,    490,     25,    5, 200

;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	3000, 	ihc
				FLsetVal_i	1, 	ihv
				FLsetVal_i	.707, 	ihq
				FLsetVal_i	.7, 	ihamp
			
				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 160, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                            pareq                            ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"pareq is an implementation of Zoelzer's parametric equalizer ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"filters. The interface presented here reflects pareq's input ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"arguments and their functions should be familiar from        ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"parametric equalisers found in the studio. An output         ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"amplitude control is included to compenstate for gain peaks  ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"caused by high settings of 'Parametric Gain' and 'Q'.        ", 	1,      5,     14,    490,    15,     5, 140

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1
	if	gkOnOff=0	then	;IF On/Off SWITCH IS SET TO 'OFF'...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	kporttime	linseg	0,0.001,0.005,1,0.005	;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A SET VALUE	
	kc	portk	gkc, kporttime	;SMOOTH MOVEMENT OF SLIDER VARIABLE
	;OUTPUTS	OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
	asigL, asigR	diskin2	"Seashore.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)
	kSwitch		changed	gkmode, gkskip	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	START			;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif
	START:
	aresL 		pareq 	asigL, kc, gkv, gkq, i(gkmode), i(gkskip)	;FILTER EACH CHANNEL SEPARATELY
	aresR 		pareq 	asigR, kc, gkv, gkq, i(gkmode), i(gkskip)	;FILTER EACH CHANNEL SEPARATELY
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
		outs	aresL*gkamp, aresR*gkamp	;SEND FILTER OUTPUT TO THE AUDIO OUTPUTS
endin
  	
</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT ALLOWS REAL-TIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>



























