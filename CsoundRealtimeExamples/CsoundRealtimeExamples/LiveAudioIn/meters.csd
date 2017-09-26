;Written by Iain McCurdy

<CsoundSynthesizer>

<CsOptions>
-idevaudio -odevaudio -dm0
</CsOptions>

<CsInstruments>

sr	= 	44100
ksmps	= 	32
nchnls	= 	2
0dbfs	=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL           | WIDTH | HEIGHT | X | Y
	FLpanel	"Level Meters",    500,    160,    0,  0

;VALUE DISPLAY BOXES		LABEL | WIDTH | HEIGHT | X | Y
idgainL			FLvalue	" ",	 80,      20,    5,  30
idgainR			FLvalue	" ",	 80,      20,    5,  80
idpanL			FLvalue	" ",	 40,      20,  320,  60
idpanR			FLvalue	" ",	 40,      20,  390,  60

;SLIDERS				            	MIN   | MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X  | Y
gkgainL, ihgainL	FLslider 	"Gain L",	0,      20,    0,   23,    idgainL,   300,     25,    5,    5
gkgainR, ihgainR	FLslider 	"Gain R",	0,      20,    0,   23,    idgainR,   300,     25,    5,   55
gkmeterL, gihmeterL	FLslider 	" ",		0,       1,    0,   21,    -1,        420,     30,   80,  100
gkmeterR, gihmeterR	FLslider 	"Meters L/R",	0,       1,    0,   21,    -1,        420,     30,   80,  130
FLsetColor2	0, 255, 0, gihmeterL	;COLOURIZE METERS (GREEN)
FLsetColor2	0, 255, 0, gihmeterR	;COLOURIZE METERS (GREEN)

;KNOBS							MIN | MAX | EXP | TYPE | DISP | WIDTH | X | Y
gkpanL, ihpanL		FLknob 		"Pan L", 	0,     1,    0,    1,   idpanL,   40,  320, 5
gkpanR, ihpanR		FLknob 		"Pan R", 	0,     1,    0,    1,   idpanR,   40,  390, 5


;						MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkreadoutL, gihreadoutL	FLtext		" ", 	0,     1,    0,     1,     80,      30,    0,  100
gkreadoutR, gihreadoutR	FLtext		" ", 	0,     1,    0,     1,     80,      30,    0,  130


;SET INITIAL VALUES FOR SLIDERS 	|VALUE | HANDLE
			FLsetVal_i	0, 	ihgainL
			FLsetVal_i	0, 	ihgainR
			FLsetVal_i	0, 	ihpanL
			FLsetVal_i	1, 	ihpanR
			FLsetVal_i	0, 	gihmeterL
			FLsetVal_i	0, 	gihmeterR
			FLsetVal_i	0, 	gihreadoutL
			FLsetVal_i	0, 	gihreadoutR

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     200,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"      Live Audio Input With Metering And Other Features      ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"This example adds some features to the previous example that,", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"again whilst not aurally spectacular, may prove useful in    ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"managing a live input signal in a larger realtime audio      ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"processing Csound orchestra.                                 ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"Individual volume controls for each channel of the stereo    ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"input have been added. Each channel can be panned            ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"independently. Visual meters monitor amplitude levels and    ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"number boxes give textual confimation of these values.       ", 	1,      5,     14,    490,    20,     5, 180
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr		1	;ALWAYS ON - SEE SCORE
	ainL, ainR	ins				;READ AUDIO FROM THE COMPUTER'S INPUT
	ainL		=		ainL * gkgainL	;APPLY GAIN CONTROL
	ainR		=		ainR * gkgainR  ;APPLY GAIN CONTROL
	aL		=		(ainL * (1-gkpanL)) + (ainR * (1 - gkpanR))	;APPLY PANNING CONTROL
	aR		=		(ainL * gkpanL) + (ainR * gkpanR)               ;APPLY PANNING CONTROL
	ameterL		follow 		aL, .01		;CREATE AN AMPLITUDE FOLLOWING UNIPOLAR SIGNAL (NEEDED FOR THE AMPLITUDE METERS)
	ameterR		follow 		aR, .01		;CREATE AN AMPLITUDE FOLLOWING UNIPOLAR SIGNAL (NEEDED FOR THE AMPLITUDE METERS)
	kmeterL		downsamp	ameterL		;CONVERT AMPLITUDE FOLLOWING SIGNAL TO K-RATE
	kmeterR		downsamp	ameterR		;CONVERT AMPLITUDE FOLLOWING SIGNAL TO K-RATE
	kmeterL		portk		kmeterL, .1	;SMOOTH THE MOVEMENT OF THE AMPLITUDE FOLLOWING SIGNAL - THIS WILL MAKE THE METERS EASIER TO VIEW
	kmeterR		portk		kmeterR, .1     ;SMOOTH THE MOVEMENT OF THE AMPLITUDE FOLLOWING SIGNAL - THIS WILL MAKE THE METERS EASIER TO VIEW
	ktrigL		changed		kmeterL		;IF THE AMPLIUDE FOLLOWING SIGNAL CHANGES GENERATE A TRIGGER SIGNAL (A MOMENTARY '1' VALUE)
	ktrigR		changed		kmeterR 	;IF THE AMPLIUDE FOLLOWING SIGNAL CHANGES GENERATE A TRIGGER SIGNAL (A MOMENTARY '1' VALUE)
	kreadouttrig	metro		10		;METRONOMIC TRIGGER (USED BY NUMBER BOX READOUTS) - 2 PER SECOND
			FLsetVal	kreadouttrig, kmeterL, gihreadoutL	;UPDATE NUMBER BOX READOUTS
			FLsetVal	kreadouttrig, kmeterR, gihreadoutR      ;UPDATE NUMBER BOX READOUTS
			FLsetVal	ktrigL, kmeterL, gihmeterL		;UPDATE AMPLITUDE METERS
			FLsetVal	ktrigR, kmeterR, gihmeterR              ;UPDATE AMPLITUDE METERS
			outs		aL, aR				;SEND THE AUDIO SIGNAL TO THE SPEAKERS
endin

</CsInstruments>

<CsScore>
i 1 0 3600	;INSTRUMENT 1 PLAYS FOR 1 HOUR (AND KEEPS PERFORMANCE GOING)
</CsScore>

</CsoundSynthesizer>