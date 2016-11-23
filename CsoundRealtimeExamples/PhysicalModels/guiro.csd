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
		FLpanel	"guiro",   500,    400,    0,  0

;BUTTONS					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"Scrape!",	1,    0,    21,    200,     30,   150, 10,    0,     1,      0,       -1

;VALUE DISPLAY BOXES	LABEL  | WIDTH | HEIGHT | X |  Y
idamp		FLvalue	" ",      100,     18,    5,   75
iddettack	FLvalue	" ",      100,     18,    5,  125
idnum		FLvalue	" ",      100,     18,    5,  175
iddamp		FLvalue	" ",      100,     18,    5,  225
idmaxshake	FLvalue	" ",      100,     18,    5,  275
idfreq		FLvalue	" ",      100,     18,    5,  325
idfreq1		FLvalue	" ",      100,     18,    5,  375

;SLIDERS				            					MIN |  MAX  | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X  | Y
gkamp, ihamp			FLslider	"Amplitude",				0,       1,    0,    23,   idamp,        490,    25,     5,   50
gkdettack, ihdettack		FLslider	"idettack (i-rate)",			.001,    1,   -1,    23,   iddettack,    490,    25,     5,  100
gknum, ihnum			FLslider	"Number of Grooves (i-rate)",		1.01,  100,    0,    23,   idnum,        490,    25,     5,  150
gkdamp, ihdamp			FLslider	"Damping (i-rate)",			0,     .75,    0,    23,   iddamp,       490,    25,     5,  200
gkmaxshake,ihmaxshake		FLslider 	"Energy Feedback (i-rate)",		0,       1,    0,    23,   idmaxshake,   490,    25,     5,  250
gkfreq,ihfreq			FLslider 	"Main Resonant Frequency (i-rate)",  	200,  8000,   -1,    23,   idfreq,       490,    25,     5,  300
gkfreq1,ihfreq1			FLslider 	"1st Resonant Frequency (i-rate)",  	200,  8000,   -1,    23,   idfreq1,      490,    25,     5,  350

;SET INITIAL VALUES OF FLTK VALUATORS
;				VALUE | HANDLE
		FLsetVal_i	0.4, 	ihamp
		FLsetVal_i	.01, 	ihdettack
		FLsetVal_i	128, 	ihnum
		FLsetVal_i	.47, 	ihdamp
		FLsetVal_i	0, 	ihmaxshake
		FLsetVal_i	2500, 	ihfreq
		FLsetVal_i	4000, 	ihfreq1

		FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 180, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           guiro                             ", 	1,       5,    14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,       5,    14,    490,    20,     5,  20
ih		 	FLbox  	"guiro is a semi-physical model of a guiro.                   ", 	1,       5,    14,    490,    20,     5,  40
ih		 	FLbox  	"It is one of the PhISEM percussion opcodes. PhISEM           ", 	1,       5,    14,    490,    20,     5,  60
ih		 	FLbox  	"(Physically Informed Stochastic Event Modeling) is an        ", 	1,       5,    14,    490,    20,     5,  80
ih		 	FLbox  	"algorithmic approach for simulating collisions of multiple   ", 	1,       5,    14,    490,    20,     5, 100
ih		 	FLbox  	"independent sound producing objects.                         ", 	1,       5,    14,    490,    20,     5, 120
ih		 	FLbox  	"Note that the opcode needs to be 're-scraped' in order to    ", 	1,       5,    14,    490,    20,     5, 140
ih		 	FLbox  	"hear the changes made to i-rate controls.                    ", 	1,       5,    14,    490,    20,     5, 160

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1	;GUIRO INSTRUMENT
	aguiro	guiro	gkamp, i(gkdettack), i(gknum), i(gkdamp) , i(gkmaxshake), i(gkfreq) , i(gkfreq1)
		outs 	aguiro, aguiro
endin

</CsInstruments>

<CsScore>
f 0 3600	;'DUMMY' SCORE EVENT KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>