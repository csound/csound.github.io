<CsoundSynthesizer>

<CsOptions>
-odevaudio -b400
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
kr 		= 	4410	;CONTROL RATE
ksmps 		= 	10	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs	=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;				LABEL    | WIDTH | HEIGHT | X | Y
			FLpanel	"pan2",     500,    250,    0,  0

;SWITCHES  	                                  		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff, ihOnOff		FLbutton	"On/Off",	1,    0,    22,    150,     30,    10, 10,    0,     1,      0,       -1
gkQuit, ihQuit			FLbutton	"Quit",		1,    0,    21,    150,     30,   340, 10,    0,   999,      0,        0
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES		LABEL  | WIDTH | HEIGHT | X | Y
idpan			FLvalue	" ",      100,     20,    5,  75
idgain			FLvalue	" ",      100,     20,    5, 125

;SLIDERS				            		MIN | MAX | EXP | TYPE |  DISP     | WIDTH | HEIGHT | X  | Y
gkpan, ihpan			FLslider 	"Pan",		0,     1,    0,    23,   idpan,       490,     25,    5,   50
gkgain, ihgain			FLslider 	"Gain",		0,     1,    0,    23,   idgain,      490,     25,    5,  100

;COUNTERS										MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkmode, ihmode 			FLcount  "Mode: 0=Equal_Power 1=Root_Square 2=Linear", 	0,     2,     1,      1,      2,    150,     30,   175,150,    -1

;SET INITIAL VALUES FOR SLIDERS		|VALUE  | HANDLE
			FLsetVal_i	  0.5, 	  ihpan
			FLsetVal_i	  0.5, 	  ihgain
			FLsetVal_i	  0, 	  ihmode

				FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     120,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                            pan2                             ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"The pan2 opcode provides a simple way to implement panning   ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"using one of three available methods. The method provided are", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"equal power (harmonic), square root and linear.              ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"Source sound in this example is pink noise.                  ", 	1,      5,     14,    490,    20,     5, 100

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


instr	1
	asig	pinkish	gkgain     	;GENERATE PINK NOISE
	kSwitch		changed	gkmode	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	UPDATE			;BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE'
	endif
	UPDATE:
	if	gkOnOff!=0	goto	CONTINUE	;SENSE FLTK ON/OFF SWITCH FOR 'PINK NOISE' - IF 'ON' JUMP TO LABEL 'CONTINUE'
				turnoff			;TURN THIS INSTRUMENT OFF IMMEDIATELY
	CONTINUE:					;LABEL 'CONTINUE'
	a1, a2	pan2 	asig, gkpan , i(gkmode)	;APPLY PANNING TO INPUT SIGNAL gasig USING THE MODE SELECTED BY i(gkmode)
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
	outs	a1, a2					;SEND AUDIO SIGNAL TO OUTPUTS
endin

instr	999	;QUIT
	exitnow
endin

</CsInstruments>

<CsScore>
i 1 0 3600	;INSTRUMENT 1 PLAYS FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>
