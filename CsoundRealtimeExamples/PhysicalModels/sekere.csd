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
;			LABEL   | WIDTH | HEIGHT | X | Y
		FLpanel	"sekere",  500,    300,    0,  0

;BUTTONS					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"Shake!",	1,    0,    21,    200,     30,   150, 10,    0,     1,      0,       -1

;VALUE DISPLAY BOXES	LABEL  | WIDTH | HEIGHT | X |  Y
idamp		FLvalue	" ",       70,     18,    5,   75
iddettack	FLvalue	" ",       70,     18,    5,  125
idnum		FLvalue	" ",       70,     18,    5,  175
iddamp		FLvalue	" ",       70,     18,    5,  225
idmaxshake	FLvalue	" ",       70,     18,    5,  275

;SLIDERS				            				MIN |  MAX  | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X  | Y
gkamp, ihamp			FLslider	"Amplitude",			0,       1,    0,    23,   idamp,        490,     25,    5,  50
gkdettack, ihdettack		FLslider	"idettack (i-rate)",		.001,    1,   -1,    23,   iddettack,    490,     25,    5, 100
gknum, ihnum			FLslider	"Number (i-rate)",		.0001, 100,    0,    23,   idnum,        490,     25,    5, 150
gkdamp, ihdamp			FLslider	"Damping (i-rate)",		0,       1,    0,    23,   iddamp,       490,     25,    5, 200
gkmaxshake,ihmaxshake		FLslider 	"Energy Feedback (i-rate)",	0,       1,    0,    23,   idmaxshake,   490,     25,    5, 250

;SET INITIAL VALUES OF FLTK VALUATORS
;				VALUE | HANDLE
		FLsetVal_i	0.7, 	ihamp
		FLsetVal_i	.01, 	ihdettack
		FLsetVal_i	64, 	ihnum
		FLsetVal_i	.5, 	ihdamp
		FLsetVal_i	0, 	ihmaxshake

		FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 280, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           sekere                            ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"sekere is a semi-physical model of a sekere.                 ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"It is one of the PhISEM percussion opcodes. PhISEM           ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"(Physically Informed Stochastic Event Modeling) is an        ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"algorithmic approach for simulating collisions of multiple   ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"independent sound producing objects.                         ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"Sustained textures are possible if internal damping is set   ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"at maximum (i.e. internal damping is insufficient to         ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"eventually stop the movement of the beads).                  ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"Note that the opcode needs to be 're-shaken' in order to     ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"hear the changes made to i-rate controls.                    ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"The sound quality of this particular model is rather         ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"artificial.                                                  ", 	1,      5,     14,    490,    15,     5, 260

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1
	kSwitch		changed		gkamp, gkdettack, gknum, gkdamp, gkmaxshake	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if kSwitch=1	then
		reinit	BEGIN
	endif
	BEGIN:
	asekere		sekere 		i(gkamp), i(gkdettack) , i(gknum), i(gkdamp) , i(gkmaxshake)
	rireturn
		outs 		asekere, asekere
endin

</CsInstruments>

<CsScore>
f 0 3600	;'DUMMY' SCORE EVENT KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>
