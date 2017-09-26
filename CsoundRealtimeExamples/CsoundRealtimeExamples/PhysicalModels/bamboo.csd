;Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-odevaudio -b400
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	100	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

		FLcolor		-2	;RANDOMLY COLOURIZE THE INTERFACE
		FLcolor2	-2	;RANDOMLY COLOURIZE THE INTERFACE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL       | WIDTH | HEIGHT | X | Y
		FLpanel	"bamboo",      500,    450,    0,  0

;BUTTONS					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"Shake!",	1,   -1,    21,    200,     30,   150, 10,    0,     1,      0,       -1


;VALUE DISPLAY BOXES	LABEL  | WIDTH | HEIGHT | X |  Y
idamp		FLvalue	" ",       80,     18,    5,   75
iddettack	FLvalue	" ",       80,     18,    5,  125
idnum		FLvalue	" ",       80,     18,    5,  175
iddamp		FLvalue	" ",       80,     18,    5,  225
idmaxshake	FLvalue	" ",       80,     18,    5,  275
idfreq		FLvalue	" ",       80,     18,    5,  325
idfreq1		FLvalue	" ",       80,     18,    5,  375
idfreq2		FLvalue	" ",       80,     18,    5,  425

;SLIDERS				            					MIN | MAX    | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X   | Y
gkamp, ihamp			FLslider	"Amplitude",				0,        1,    0,    23,   idamp,        490,    25,     5,    50
gkdettack, ihdettack		FLslider	"idettack (i-rate)",			.001,     1,   -1,    23,   iddettack,    490,    25,     5,   100
gknum, ihnum			FLslider	"Number of Bamboo Beads (i-rate)",	.0001,  100,    0,    23,   idnum,        490,    25,     5,   150
gkdamp, ihdamp			FLslider	"Internal Damping (i-rate)",		-1,     .05,    0,    23,   iddamp,       490,    25,     5,   200
gkmaxshake,ihmaxshake		FLslider 	"Energy Feedback (i-rate)",		0,        1,    0,    23,   idmaxshake,   490,    25,     5,   250
gkfreq,ihfreq			FLslider 	"Main Resonant Frequency (i-rate)",  	200,   8000,   -1,    23,   idfreq,       490,    25,     5,   300
gkfreq1,ihfreq1			FLslider 	"1st Resonant Frequency (i-rate)",  	200,   8000,   -1,    23,   idfreq1,      490,    25,     5,   350
gkfreq2,ihfreq2			FLslider 	"2nd Resonant Frequency (i-rate)",  	200,   8000,   -1,    23,   idfreq2,      490,    25,     5,   400

;SET INITIAL VALUES OF FLTK VALUATORS
;				VALUE | HANDLE
		FLsetVal_i	0.6, 	ihamp
		FLsetVal_i	.01, 	ihdettack
		FLsetVal_i	1.25, 	ihnum
		FLsetVal_i	0, 	ihdamp
		FLsetVal_i	0, 	ihmaxshake
		FLsetVal_i	2800, 	ihfreq
		FLsetVal_i	2240, 	ihfreq1
		FLsetVal_i	3360, 	ihfreq2

		FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 240, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           bamboo                            ", 	1,       5,    14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,       5,    14,    490,    20,     5,  20
ih		 	FLbox  	"bamboo is a semi-physical model of a bamboo shaker sound.    ", 	1,       5,    14,    490,    20,     5,  40
ih		 	FLbox  	"It is one of the PhISEM percussion opcodes. PhISEM           ", 	1,       5,    14,    490,    20,     5,  60
ih		 	FLbox  	"(Physically Informed Stochastic Event Modeling) is an        ", 	1,       5,    14,    490,    20,     5,  80
ih		 	FLbox  	"algorithmic approach for simulating collisions of multiple   ", 	1,       5,    14,    490,    20,     5, 100
ih		 	FLbox  	"independent sound producing objects.                         ", 	1,       5,    14,    490,    20,     5, 120
ih		 	FLbox  	"Sustained textures are possible if internal damping is set   ", 	1,       5,    14,    490,    20,     5, 140
ih		 	FLbox  	"at maximum (i.e. internal damping is insufficient to         ", 	1,       5,    14,    490,    20,     5, 160
ih		 	FLbox  	"eventually stop the movement of the beads).                  ", 	1,       5,    14,    490,    20,     5, 180
ih		 	FLbox  	"Instrument automatically reinitialises if i-rate variables   ", 	1,       5,    14,    490,    20,     5, 200
ih		 	FLbox  	"are changed.                                                 ", 	1,       5,    14,    490,    20,     5, 220

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr		1
	ktrigger	changed		gkdettack, gknum, gkdamp, gkmaxshake, gkfreq, gkfreq1, gkfreq2
	if	ktrigger=1	then
		reinit	UPDATE
	endif
	UPDATE:
	abamboo	bamboo 		gkamp, i(gkdettack) , i(gknum), i(gkdamp) , i(gkmaxshake), i(gkfreq) , i(gkfreq1), i(gkfreq2)
	rireturn
	outs 		abamboo, abamboo
endin

</CsInstruments>

<CsScore>
f 0 3600	;'DUMMY' SCORE EVENT KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>
