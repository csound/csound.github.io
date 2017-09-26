pvsdelay.csd
Written by Iain McCurdy, 2012

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	4	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE
giMaxDelay	=	4	;MAXIMUM DELAY TIME

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL        | WIDTH | HEIGHT | X | Y
		FLpanel	"PVS Delay",    500,    250,    0,  0

;                                                      	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"Input On/Off",	1,    0,    22,    180,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkinput, ihinput		FLbutBank	14,     1,     2,     18,      40,   250, 0,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Input", 		1,       5,    14,     50,      16, 200,   0
ih		 	FLbox  	"Drum Loop", 		1,       5,    14,     75,      16, 270,   0
ih		 	FLbox  	"Live     ", 		1,       5,    14,     75,      16, 270,  20

;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
iddlt				FLvalue	" ",      80,    20,     5,  75
idmix				FLvalue	" ",      80,    20,     5, 125
idfeedbackamt			FLvalue	" ",      80,    20,     5, 175
idamp				FLvalue	" ",      80,    20,     5, 225

;SLIDERS					            			MIN   |       MAX      | EXP | TYPE |       DISP    | WIDTH | HEIGHT | X | Y
gkdlt,ihdlt			FLslider 	"Delay Time (sec)",		0.001, giMaxDelay-0.01,   -1,   23,          iddlt,    490,     25,     5,  50
gkmix,ihmix			FLslider 	"Dry/Wet Mix",			0,                   1,    0,   23,          idmix,    490,     25,     5, 100
gkfeedamt,ihfeedamt		FLslider 	"Feedback Ratio",		0,                   1,    0,   23,  idfeedbackamt,    490,     25,     5, 150
gkamp,ihamp			FLslider 	"Output Amplitude Rescaling",	0,                   1,    0,   23,          idamp,    490,     25,     5, 200
gkingain,ihingain		FLslider 	"Live Input Gain",		0,                   1,    0,   23,             -1,    140,     20,   350,   5

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	.5, 	ihdlt
		FLsetVal_i	0.5, 	ihmix
		FLsetVal_i	0.7, 	ihfeedamt
		FLsetVal_i	0.7, 	ihamp

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 260, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          PVS Delay                          ", 	1,      6,     14,    490,    30,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"This example implements a simple delay buffer, but instead of", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"the typical audio buffer, this time a streaming FFT (PVS)    ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"signal buffer is used. The key opcodes in use here are       ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"'pvsbuffer' and 'pvsbufread'. The principle difference of    ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"using an FFT signal buffer rather that an audio buffer is    ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"that we can modulate the delay time without any distortions  ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"in pitch occuring. It might also be worth experimenting with ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"the addition of further pvs transformation within the        ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"feedback loop.                                               ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"This PVS delay is implemented within a UDO to facilitate easy", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"transplantation into other Csound projects.                  ", 	1,      5,     14,    490,    20,     5, 240

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

opcode	pvsdelay,a,akkiiiii
	ain,kDlyTim,kFBamt,iMaxDelay,iFFTsize,ioverlap,iwinsize,iwintype	xin
	f_FB		pvsinit 	iFFTsize,ioverlap,iwinsize,iwintype, 0		;INITIALISE FEEDBACK FSIG
	f_Dry  		pvsanal		ain, iFFTsize, ioverlap, iwinsize, iwintype	;ANALYSE THE AUDIO SIGNAL THAT WAS CREATED IN INSTRUMENT 1. OUTPUT AN F-SIGNAL.
	f_Mix		pvsmix		f_Dry, f_FB					;MIX AUDIO INPUT WITH FEEDBACK SIGNAL	
	ibuffer,ktime  	pvsbuffer	f_Mix, iMaxDelay				;BUFFER FSIG
	khandle		init 		ibuffer						;INITIALISE HANDLE TO BUFFER
	kread		=		ktime-kDlyTim					;READ POINTER LAGS BEHIND WRITE POINTER BY gkdlt SECONDS
	f_Delay  	pvsbufread  	kread , khandle					;READ BUFFER
	f_FB		pvsgain 	f_Delay, kFBamt					;CREATE FEEDBACK F-SIGNAL FOR NEXT PASS
	aresyn 		pvsynth  	f_Delay						;RESYNTHESIZE THE f-SIGNAL AS AN AUDIO SIGNAL	
			xout		aresyn						;SEND AUDIO BACK TO CALLER INSTRUMENT
endop

instr	1	;PLAYS FILE
	if gkOnOff=0	then	;SENSE FLTK ON/OFF SWITCH
			turnoff	;TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif
	if	gkinput==0	then	;IF INPUT '808loop.wav' IS SELECTED...
		gasigL, gasigR	diskin2	"808loop.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)		
	else				;OTHERWISE
		asigL, asigR	ins	;TAKE INPUT FROM COMPUTER'S AUDIO INPUT
		gasigL	=	asigL * gkingain	;SCALE USING 'Input Gain' SLIDER
		gasigR	=	asigR * gkingain	;SCALE USING 'Input Gain' SLIDER
	endif						;END OF CONDITIONAL BRANCHING
endin

instr 		2	;DELAY INSTRUMENT
	; fft attributes
	iFFTsize	=	512
	ioverlap	=	256
	iwinsize	=	1024
	iwintype	=	1
	; send input audio to pvs_delay udo
	aDlyL		pvsdelay	gasigL,gkdlt,gkfeedamt,giMaxDelay,iFFTsize,ioverlap,iwinsize,iwintype	;
	aDlyR		pvsdelay	gasigR,gkdlt,gkfeedamt,giMaxDelay,iFFTsize,ioverlap,iwinsize,iwintype
	; create a wet/dry mix
	amixL		ntrpol		gasigL,aDlyL,gkmix
	amixR		ntrpol		gasigR,aDlyR,gkmix
			outs	amixL*gkamp, amixR*gkamp

			clear		gasigL, gasigR		;CLEAR THE GLOBAL AUDIO SEND VARIABLES
endin

</CsInstruments>

<CsScore>
;INSTR | START | DURATION
i  2       0       -1	;INSTRUMENT 2 (DELAY INSTRUMENT) PLAYS A HELD NOTE

f 0 3600	;'DUMMY' SCORE EVENT KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>