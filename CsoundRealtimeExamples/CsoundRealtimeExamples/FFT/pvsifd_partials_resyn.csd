;22pvsifd_partials_resyn.csd
;Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr	= 	44100
ksmps	= 	8
nchnls	= 	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL                   | WIDTH | HEIGHT | X | Y
	FLpanel	"pvsifd partials resyn",   500,    300,    0,  0

;SWITCHES  	                         		ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    100,     25,    5,  5,    0,      1,      0,       -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE
gkmaxtracks, ihmaxtracks 	FLcount  "Max. No. Tracks",	1,    100,    1,      10,     1,   150,      25,    5, 200,    -1
gkminpts, ihminpts 		FLcount  "Min. Points",		1,     20,    1,      10,     1,   150,      25,  160, 200,    -1

;VALUE DISPLAY BOXES		LABEL | WIDTH | HEIGHT | X | Y
idthresh		FLvalue	" ",	 80,      20,    5,  75
idscal			FLvalue	" ",	 80,      20,    5, 125
idtrans			FLvalue	" ",	 80,      20,    5, 175
idmaxgap		FLvalue	" ",	 80,      20,    5, 275

;SLIDERS							MIN | MAX | EXP | TYPE |     DISP   | WIDTH | HEIGHT | X  | Y
gkthresh, ihthresh	FLslider 	"Threshold",		0,       1,  0,    23,    idthresh,    490,     25,    5,   50
gkscal, ihscal		FLslider 	"Amplitude Scaling",	0,       1,  0,    23,    idscal,      490,     25,    5,  100
gktrans, ihtrans	FLslider 	"Transposition",	0.125,   4, -1,    23,    idtrans,     490,     25,    5,  150
gkmaxgap, ihmaxgap	FLslider 	"Maximum Gap",		1,      10, -1,    23,    idmaxgap,    490,     25,    5,  250

;SET INITIAL VALUES FOR VALUATORS	VALUE | HANDLE
			FLsetVal_i	0.003, 	ihthresh
			FLsetVal_i	0.5, 	ihscal
			FLsetVal_i	1, 	ihtrans
			FLsetVal_i	30, 	ihmaxtracks
			FLsetVal_i	1, 	ihminpts
			FLsetVal_i	3, 	ihmaxgap

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     320,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                   pvsifd partials resyn                     ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"This example introduces three opcodes 'pvsifd', 'partials'   ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"and 'resyn' to demonstrate partial tracking analysis and     ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"resynthesis. An audio stream is first converted into two     ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"fsigs: amplitude-frequency and amplitude-phase.              ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"These two signals can be taken as input by the 'partials'    ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"opcode which performs a partial tracking analysis. The user  ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"can control the maximum number of tracks (Max. No. Tracks),  ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"minimum number of points needed to detect a partial track    ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"(Min. Points), maximum gap across which a track will be      ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"continued (Maximum Gap) and the threshold beneath which      ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"tracks will be ignored.                                      ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"'resyn' is used to resynthesize the 'tracks' signal output by", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"the 'partials' opcode. At this stage the pitch of the signal ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"can be modulated (Transposition).                            ", 	1,      5,     14,    490,    15,     5, 300
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;A SINE WAVE (NEEDED FOR THE RESYNTHESIS)
gisine	ftgen	0,0,1024,10,1

instr	1
	if	gkOnOff=0	then					;IF On/Off SWITCH IS SET TO 'Off'
		turnoff							;TURN THIS INSTRUMENT
	endif								;END OF CONDITIONAL BRANCHING
	kporttime	linseg		0, 0.001, 0.05			;A FUNCTION THAT QUICKLY RAMPS UP FROM ZERO THAT WILL BE USED FOR PORTAMENTO TIME
	ktrans		portk		gktrans, kporttime		;PORTAMENTO SMOOTHING APPLIED TO FLTK SLIDER PARAMETER
	asigin		diskin2		"AndItsAll.wav",1,0,1		;CREATE AUDIO SIGNAL OF AUDIO SAMPLE TO WHICH STENCILLING WILL BE APPLIED
	ffr,fphs 	pvsifd 		asigin, 1024, 512, 1 		;PVSIFD ANALYSIS
	ktrigger	changed		gkmaxtracks			;IF K-RATE INPUT CHANGES GENERATE AN TRIGGER OUTPUT (MOMENTARY 1)
	if		ktrigger=1	then				;IF TRIGGER IS '1'...
			reinit		UPDATE				;BEGIN A REINITIALIZATION PASS FROM LABEL 'UPDATE'
	endif								;END OF THE CONDITIONAL BRANCH
	UPDATE:								;LABEL 'UPDATE'
	ftrks  		partials 	ffr, fphs, gkthresh,gkminpts, gkmaxgap,   i(gkmaxtracks) 	;PARTIAL TRACKING
	rireturn
	aout  		resyn		ftrks, gkscal, ktrans, gkmaxtracks, gisine		;RESYNTHESIS
			out		aout				;SEND THE RESYNTHESIZED SIGNAL TO THE AUDIO OUTPUTS
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT ALLOWS REALTIME PLAYING FOR UP TO 1 HOUR
</CsScore>

</CsoundSynthesizer>