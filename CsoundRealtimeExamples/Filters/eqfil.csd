eqfil.csd
Written by Iain McCurdy, 2010

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	16	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;					LABEL   | WIDTH | HEIGHT | X | Y
				FLpanel	"eqfil",   500,    250,    0,  0

;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,    0,    22,    140,     25,    5,  5,    0,      1,      0,      -1
gkstor,ihstor		FLbutton	"Store Internal Space",	1,    0,    22,    200,     25,  295,  5,   -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255,  50, 50, ihstor		;SET SECONDARY COLOUR TO RED

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idcf				FLvalue	" ",      70,     20,     5,  75
idbw				FLvalue	" ",      70,     20,     5, 125
idgain				FLvalue	" ",      70,     20,     5, 175
idamp				FLvalue	" ",      70,     20,     5, 225

;SLIDERS					            		MIN    |  MAX  | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gkcf, ihcf			FLslider 	"Cutoff Frequency",	20,      20000,  -1,    23,    idcf,   490,     25,    5,  50
gkbw, ihbw			FLslider 	"Bandwidth",		1,       10000,  -1,    23,    idbw,   490,     25,    5, 100
gkgain, ihgain			FLslider 	"Gain",			0.001,       8,  -1,    23,  idgain,   490,     25,    5, 150
gkamp, ihamp			FLslider 	"Output Amplitude",	0,           1,   0,    23,   idamp,   490,     25,    5, 200

;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	800, 	ihcf
				FLsetVal_i	200, 	ihbw
				FLsetVal_i	4, 	ihgain
				FLsetVal_i	0.5, 	ihamp
			
				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 100, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                            eqfil                            ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"eqfil is an implementation of a 2nd order tunable            ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"equalization filter with controls for centre frequency,      ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"bandwidth, and gain.                                         ", 	1,      5,     14,    490,    15,     5,  80
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1
	if	gkOnOff=0	then	;IF On/Off SWITCH IS SET TO 'OFF'...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	kporttime	linseg	0,0.001,0.005	;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A SET VALUE	
	kcf	portk	gkcf, kporttime	;SMOOTH MOVEMENT OF SLIDER VARIABLE
	;OUTPUTS	OPCODE	FILE           | SPEED | INSKIP | LOOPING (0=OFF 1=ON)
	asigL, asigR	diskin2	"Seashore.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)
	ktrig	changed	gkstor
	if ktrig=1 then
		reinit	UPDATE
	endif
	UPDATE:
	aresL		eqfil	asigL, kcf, gkbw, gkgain, i(gkstor)
	aresR		eqfil	asigR, kcf, gkbw, gkgain, i(gkstor)
	rireturn
		outs	aresL*gkamp, aresR*gkamp	;SEND FILTER OUTPUT TO THE AUDIO OUTPUTS
endin
  	
</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT ALLOWS REAL-TIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>





