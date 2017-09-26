Delay_PitchShiftInLoop.csd
Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	4	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE (MAY NEED TO BE LOW WHEN WORKING WITH SHORT DELAY TIMES DEFINED INITIALLY AT KRATE)
nchnls 		= 	1	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL                                         | WIDTH | HEIGHT | X | Y
		FLpanel	"delay with a pitch shifter in feedback loop",   500,    420,    0,  0

;                                                      	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"Input On/Off",	1,    0,    22,    180,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X  |  Y | OPCODE | INS | STARTTIM | DUR
gkinput, ihinput		FLbutBank	14,     1,     2,     18,      40,   250,   0,   -1
gkPSmethod, ih			FLbutBank	14,     1,     3,     18,      60,   160, 350,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES							TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Input", 			1,       5,    14,     50,      16, 200,   0
ih		 	FLbox  	"Sample", 			1,       5,    14,     55,      16, 270,   0
ih		 	FLbox  	"Live  ", 			1,       5,    14,     55,      16, 270,  20
ih		 	FLbox  	"Pitch Shift Method:", 		1,       5,    14,    160,      16,   0, 350
ih		 	FLbox  	"FFT                        ",	1,       5,    14,    220,      16, 180, 350
ih		 	FLbox  	"Delay                      ",	1,       5,    14,    220,      16, 180, 370
ih		 	FLbox  	"FFT (spectral preservation)", 	1,       5,    14,    220,      16, 180, 390

;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
iddlt				FLvalue	" ",      80,    20,     5,  75
idmix				FLvalue	" ",      80,    20,     5, 125
idfeedbackamt			FLvalue	" ",      80,    20,     5, 175
idamp				FLvalue	" ",      80,    20,     5, 225
idporttime			FLvalue	" ",      80,    20,     5, 275
idPS				FLvalue	" ",      80,    20,     5, 325

;SLIDERS					            			MIN |  MAX | EXP | TYPE |      DISP    | WIDTH | HEIGHT | X | Y
gkdlt,ihdlt			FLslider 	"Delay Time (sec)",		0.001, 5,    0,    23,           iddlt,   490,     25,    5,  50
gkmix,ihmix			FLslider 	"Dry/Wet Mix",			0,      1,    0,    23,           idmix,   490,     25,    5, 100
gkfeedamt,ihfeedamt		FLslider 	"Feedback Amount",		0,   0.99,    0,    23,   idfeedbackamt,   490,     25,    5, 150
gkamp,ihamp			FLslider 	"Output Amplitude Rescaling",	0,      1,    0,    23,           idamp,   490,     25,    5, 200
gkporttime,ihporttime		FLslider 	"Portamento Time",		0,      2,    0,    23,      idporttime,   490,     25,    5, 250
gkPS,ihPS			FLslider 	"Pitch Shift (semitones)",	-12,   12,    0,    23,            idPS,   490,     25,    5, 300
gkingain,ihingain		FLslider 	"Live Input Gain",		0,      1,    0,    23,              -1,   140,     20,  350,   5

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	0.31, 	ihdlt
		FLsetVal_i	0.7, 	ihmix
		FLsetVal_i	0.8, 	ihfeedamt
		FLsetVal_i	0.7, 	ihamp
		FLsetVal_i	0.3, 	ihporttime
		FLsetVal_i	2, 	ihPS

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 320, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"            Delay Effects - Pitch Shifter in Loop            ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"                  +-----+   +-----------+                    ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"        IN----+-->|DELAY|-->|PITCH SHIFT|---+---->OUT        ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"              ^   +-----+   +-----------+   |                ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"              |                             |                ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"              +-----<----(FEEDBACK)----<----+                ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"In this example a pitch shifter is inserted into the delay   ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"buffer to implement an effect that is sometimes referred to  ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"as an 'arpeggiator'.                                         ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"Three methods of pitch shifting are implemented: FFT using   ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"the 'pvscale' opcode, delay method pitch shifting using      ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"the 'vdelay3' opcode and FFT with spectral preservation. The ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"user can switch between these three methods for comparison.  ", 	1,      5,     14,    490,    15,     5, 300

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1	;PLAYS FILE
	if gkOnOff=0 then					;IF ON/OFF SWITCH IS OFF...
	  turnoff						;...TURN THIS INSTRUMENT OFF
	endif							;END OF CONDITIONAL BRANCH
	if gkinput==0 then					;IF INPUT 'Sample' IS SELECTED...
	  gasig	diskin2	"AndItsAll.wav",1,0,1			;GENERATE 1 AUDIO SIGNAL FROM A MONO SOUND FILE (NOTE THE USE OF A GLOBAL VARIABLE)		
	else							;OTHERWISE
		asig		inch	1			;TAKE INPUT FROM COMPUTER'S LEFT AUDIO INPUT
		gasig	=	asig * gkingain			;SCALE AMPLITUDE USING 'Input Gain' SLIDER
	endif							;END OF CONDITIONAL BRANCH
endin

instr 		2	;DELAY INSTRUMENT
	kporttime	linseg		0,0.001,1		;USE OF AN ENVELOPE VALUE THAT QUICKLY RAMPS UP FROM ZERO TO 1. THIS PREVENTS VARIABLES GLIDING TO THEIR REQUIRED VALUES EACH TIME THE INSTRUMENT IS STARTED.
	kporttime	=		kporttime*gkporttime	;SCALE PORTAMENTO FUNCTION WITH FLTK SLIDER VALUE
	kdlt		portk		gkdlt, kporttime 	;PORTAMENTO IS APPLIED TO THE VARIABLE 'gkdlt'. A NEW VARIABLE 'kdlt' IS CREATED.
	adlt		interp		kdlt			;A NEW A-RATE VARIABLE 'adlt' IS CREATED BY INTERPOLATING THE K-RATE VARIABLE 'kdlt' 
	abuffer		delayr	5				;CREATE A DELAY BUFFER OF 5 SECONDS DURATION (EQUIVALENT TO THE MAXIMUM DELAY TIME POSSIBLE USING THIS EXAMPLE)
	adelsig 	deltap3	adlt				;TAP THE DELAY LINE AT gkdlt SECONDS

	if gkPSmethod==0 then
	  fsig1		pvsanal		adelsig, 2048,512,2048,1	;CONVERT DELAY TAP TO FSIG
	  fsig2		pvscale		fsig1, semitone(gkPS)		;PITCH SHIFT FSIG
	  adelsig	pvsynth		fsig2				;CONVERT FSIG BACK INTO AN AUDIO SIGNAL
	elseif gkPSmethod==1 then
	  ihalfsine	ftgenonce	0, 0, 1025, 9, 0.5, 1, 0	;HALF SINE  WINDOW FUNCTION USED FOR AMPLITUDE ENVELOPING
	  aphase1		phasor	-(semitone(gkPS)-1)/0.05
	  aphase2		phasor	-(semitone(gkPS)-1)/0.05, 0.5	
	  agate1		tablei	aphase1, ihalfsine, 1, 0, 1
	  agate2		tablei	aphase2, ihalfsine, 1, 0, 1		
	  adelsig1	vdelay	adelsig,aphase1*0.05*1000,0.05*1000
	  aGatedSig1	=	adelsig1 * agate1	
	  adelsig2	vdelay	adelsig,aphase2*0.05*1000,0.05*1000
	  aGatedSig2	=	adelsig2 * agate2	
	  adelsig		=	(aGatedSig1+aGatedSig2)/2
	else
	  fsig1		pvsanal		adelsig, 2048,512,2048,1	;CONVERT DELAY TAP TO FSIG
	  fsig2		pvscale		fsig1, semitone(gkPS),1		;PITCH SHIFT FSIG
	  adelsig	pvsynth		fsig2				;CONVERT FSIG BACK INTO AN AUDIO SIGNAL
	endif

			delayw	gasig + (adelsig * gkfeedamt)	;WRITE AUDIO SOURCE AND FEEDBACK SIGNAL INTO THE BEGINNING OF THE BUFFER
	aMix		ntrpol	gasig, adelsig, gkmix		;CREATE WET/DRY MIX FOR LEFT CHANNEL
			out		aMix*gkamp		;CREATE A MIX BETWEEN THE WET AND THE DRY SIGNALS AT THE OUTPUT
			clear		gasig			;CLEAR THE GLOBAL AUDIO SEND VARIABLES
endin

</CsInstruments>

<CsScore>
i  2       0       3600		;INSTRUMENT 2 PLAYS FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>