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

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL        | WIDTH | HEIGHT | X | Y
		FLpanel	"Tambourine",   500,    450,    0,  0

;BUTTONS                       	        	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM |  DUR
gkOnOff,ihOnOff	FLbutton	"Shake!",	1,    0,    21,    200,     30,   150, 10,    0,     1,      0,       -1

;VALUE DISPLAY BOXES		WIDTH | HEIGHT | X | Y
idamp		FLvalue	" ",    80,       18,    5,   75
iddettack	FLvalue	" ",    80,       18,    5,  125
idnum		FLvalue	" ",    80,       18,    5,  175
iddamp		FLvalue	" ",    80,       18,    5,  225
idmaxshake	FLvalue	" ",    80,       18,    5,  275
idfreq		FLvalue	" ",    80,       18,    5,  325
idfreq1		FLvalue	" ",    80,       18,    5,  375
idfreq2		FLvalue	" ",    80,       18,    5,  425

;SLIDERS				            					MIN | MAX     | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X  | Y
gkamp, ihamp			FLslider	"Amplitude",				0,         1,    0,    23,      idamp,     490,     25,    5,   50
gkdettack, ihdettack		FLslider	"idettack (i-rate)",			.001,      1,   -1,    23,  iddettack,     490,     25,    5,  100
gknum, ihnum			FLslider	"Number of Timbrels (i-rate)",		.0001,   100,    0,    23,      idnum,     490,     25,    5,  150
gkdamp, ihdamp			FLslider	"Damp (i-rate)",			0,       .75,    0,    23,     iddamp,     490,     25,    5,  200
gkmaxshake,ihmaxshake		FLslider 	"Energy Feedback (i-rate)",		0,         1,    0,    23, idmaxshake,     490,     25,    5,  250
gkfreq,ihfreq			FLslider 	"Main Resonant Frequency (i-rate)",  	200,    8000,   -1,    23,     idfreq,     490,     25,    5,  300
gkfreq1,ihfreq1			FLslider 	"1st Resonant Frequency (i-rate)",  	200,    8000,   -1,    23,     idfreq1,    490,     25,    5,  350
gkfreq2,ihfreq2			FLslider 	"2nd Resonant Frequency (i-rate)",  	200,    8000,   -1,    23,     idfreq2,    490,     25,    5,  400

;SET INITIAL VALUES OF FLTK VALUATORS
;				VALUE | HANDLE
		FLsetVal_i	0.6, 	ihamp
		FLsetVal_i	.01, 	ihdettack
		FLsetVal_i	32, 	ihnum
		FLsetVal_i	.47, 	ihdamp
		FLsetVal_i	0, 	ihmaxshake
		FLsetVal_i	2300, 	ihfreq
		FLsetVal_i	5600, 	ihfreq1
		FLsetVal_i	8100, 	ihfreq2

		FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 200, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                        tambourine                           ", 	1,       5,    14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,       5,    14,    490,    15,     5,  20
ih		 	FLbox  	"tambourine is a semi-physical model of a tambourine.         ", 	1,       5,    14,    490,    15,     5,  40
ih		 	FLbox  	"It is one of the PhISEM percussion opcodes. PhISEM           ", 	1,       5,    14,    490,    15,     5,  60
ih		 	FLbox  	"(Physically Informed Stochastic Event Modeling) is an        ", 	1,       5,    14,    490,    15,     5,  80
ih		 	FLbox  	"algorithmic approach for simulating collisions of multiple   ", 	1,       5,    14,    490,    15,     5, 100
ih		 	FLbox  	"independent sound producing objects.                         ", 	1,       5,    14,    490,    15,     5, 120
ih		 	FLbox  	"Sustained textures are possible if internal damping is set   ", 	1,       5,    14,    490,    15,     5, 140
ih		 	FLbox  	"at maximum (i.e. internal damping is insufficient to         ", 	1,       5,    14,    490,    15,     5, 160
ih		 	FLbox  	"eventually stop the movement of the beads).                  ", 	1,       5,    14,    490,    15,     5, 180

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1
	kSwitch		changed		gkamp, gkdettack ,gknum ,gkdamp ,gkmaxshake, gkfreq, gkfreq1, gkfreq2	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if kSwitch=1	then
		reinit	BEGIN
	endif
	BEGIN:
	atambourine	tambourine	gkamp, i(gkdettack) , i(gknum), i(gkdamp) , i(gkmaxshake), i(gkfreq) , i(gkfreq1), i(gkfreq2)
	rireturn
	outs 		atambourine, atambourine
endin

</CsInstruments>

<CsScore>
f 0 3600	;'DUMMY' SCORE EVENT KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>
