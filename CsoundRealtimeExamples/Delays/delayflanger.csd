delayflanger.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	1	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE (MAY NEED TO BE LOW WHEN WORKING WITH SHORT DELAY TIMES DEFINED INITIALLY AT KRATE)
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL                    | WIDTH | HEIGHT | X | Y
		FLpanel	"Flanger Implementation",   500,    400,    0,  0

;                                                      	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"Input On/Off",	1,    0,    22,    180,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkinput, ihinput		FLbutBank	14,     1,     2,     18,      40,   250, 0,   -1
FLcolor2	255, 255, 50	;SET SECONDARY COLOUR TO YELLOW
gkmode, ihmode			FLbutBank	12,     1,     2,     25,      40,   145,350,  -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Input", 		1,       5,    14,     50,      16, 200,   0
ih		 	FLbox  	"Drum Loop", 		1,       5,    14,     75,      16, 270,   0
ih		 	FLbox  	"Live     ", 		1,       5,    14,     75,      16, 270,  20
ih		 	FLbox  	"Mode", 		1,       5,    14,     50,      16, 100, 350
ih		 	FLbox  	"First Principles", 	1,       5,    14,    130,      16, 170, 350
ih		 	FLbox  	"Flanger Opcode  ", 	1,       5,    14,    130,      16, 170, 370

;VALUE_DISPLAY_BOXES			 	WIDTH | HEIGHT | X | Y
iddlt				FLvalue	" ",      80,    20,     5,  75
idmix				FLvalue	" ",      80,    20,     5, 125
idfeedbackamt			FLvalue	" ",      80,    20,     5, 175
idamp				FLvalue	" ",      80,    20,     5, 225
idFlaDepth			FLvalue	" ",      80,    20,     5, 275
idFlaRate			FLvalue	" ",      80,    20,     5, 325

;SLIDERS					            				MIN      |  MAX | EXP | TYPE |      DISP    | WIDTH | HEIGHT | X | Y
gkdlt,ihdlt			FLslider 	"Delay Time (sec)",			ksmps/sr,    1,   -1,   23,           iddlt,   490,     25,    5,  50
gkmix,ihmix			FLslider 	"Dry/Wet Mix",				0,           1,    0,   23,           idmix,   490,     25,    5, 100
gkfeedamt,ihfeedamt		FLslider 	"Feedback Amount",			-.99,      .99,    0,   23,   idfeedbackamt,   490,     25,    5, 150
gkamp,ihamp			FLslider 	"Output Amplitude Rescaling",		0,           1,    0,   23,           idamp,   490,     25,    5, 200
gkFlaDepth,ihFlaDepth		FLslider 	"Flanger Modulation Depth (sec)",	0,          .2,    0,   23,      idFlaDepth,   490,     25,    5, 250
gkFlaRate,ihFlaRate		FLslider 	"Flanger Modulation Rate (hz.)",	.001,        7,   -1,   23,       idFlaRate,   490,     25,    5, 300
gkingain,ihingain		FLslider 	"Live Input Gain",		0,      1,    0,    23,             -1,   140,     20,  350,   5

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	.0001, 	ihdlt
		FLsetVal_i	.5, 	ihmix
		FLsetVal_i	.9, 	ihfeedamt
		FLsetVal_i	.2, 	ihamp
		FLsetVal_i	.005, 	ihFlaDepth
		FLsetVal_i	.05, 	ihFlaRate

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 460, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"               delayr delayw deltap3 - flanger               ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"A flanger is really just a delay effect where the delay tap  ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"is slowly modulated using an LFO (Low Frequency Oscillator). ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"Typically the delay times involved in this system are very   ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"short so that rather than being able to hear distinct echoes,", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"the comb filtering effect of very short delays is evident.   ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"A feedback loop is essential to creating the sound of a      ", 	1,      5,     14,    490,    15,     5, 140          
ih		 	FLbox  	"flanger.                                                     ", 	1,      5,     14,    490,    15,     5, 160          
ih		 	FLbox  	"A flanger derives its name from that fact that when          ", 	1,      5,     14,    490,    15,     5, 180          
ih		 	FLbox  	"originally implemented using reel-to-reel tape recorders the ", 	1,      5,     14,    490,    15,     5, 200          
ih		 	FLbox  	"engineer was required to rub their finger against the flange ", 	1,      5,     14,    490,    15,     5, 220          
ih		 	FLbox  	"of the reel of tape with varying pressure in order to create ", 	1,      5,     14,    490,    15,     5, 240          
ih		 	FLbox  	"the short varying delay time modulations.                    ", 	1,      5,     14,    490,    15,     5, 260          
ih		 	FLbox  	"In this example the user can choose between a drum loop sound", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"file as input or the computer's live input. A gain control is", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"is provided to control the gain of the live input.           ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"Csound also contains an opcode called 'flanger' dedicated to ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"reproducing this effect. At the bottom of the GUI the user   ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"can switch between a flanger created from first principles   ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"using deltapr deltap3 and deltapw and one created using this ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"dedicated opcode. It will be heard that the results are very ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"similar.                                                     ", 	1,      5,     14,    490,    15,     5, 440
                                                                                              
				FLpanel_end                                                   
                                                                                              
				FLrun	;RUN THE FLTK WIDGET THREAD                           
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gilfoshape	ftgen	0, 0, 131072, 19, 0.5, 1, 180, 1	;U-SHAPE PARABOLA

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
                                                                                              
instr 		2	;FLANGER-DELAY INSTRUMENT                             
	iporttime	=		.1	;PORTAMENTO TIME                                      
	kporttime	linseg		0, .001, iporttime, 1, iporttime ;USE OF AN ENVELOPE VALUE THAT QUICKLY RAMPS UP FROM ZERON TO THE REQUIRED VALUE PREVENTS VARIABLES GLIDING TO THEIR REQUIRED VALUES EACH TIME THE INSTRUMENT IS STARTED
	kdlt		portk		gkdlt, kporttime ;PORTAMENTO IS APPLIED TO THE VARIABLE 'gkdlt'. A NEW VARIABLE 'kdlt' IS CREATED.
	adlt		interp		kdlt	;A NEW A-RATE VARIABLE 'adlt' IS CREATED BY INTERPOLATING THE K-RATE VARIABLE 'kdlt' 
	                                                                                              
	amod		oscili		gkFlaDepth, gkFlaRate, gilfoshape	;OSCILLATOR THAT MAKES USE OF THE POSITIVE DOMAIN ONLY U-SHAPE PARABOLA WITH FUNCTION TABLE NUMBER gilfoshape
	                                                                                              
	adlt		sum		adlt, amod	;STATIC DELAY TIME AND MODULATING DELAY TIME ARE SUMMED
	;REMEMBER THAT THE LENGTH OF THE DELAY BUFFER DEFINED WILL HAVE TO TAKE ACCOUNT OF THE SUMMED MAXIMUM OF THE STATIC DELAY TIME AND MODULATING DELAY TIME
	   
	   
	   
	if	gkmode=0	then                                                                                           
		;;;LEFT CHANNEL DELAY;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		abufferL	delayr	1.2	;CREATE A DELAY BUFFER OF 5 SECONDS DURATION (EQUIVALENT TO THE MAXIMUM DELAY TIME POSSIBLE USING THIS EXAMPLE)
		adelsigL 	deltap3	adlt	;TAP THE DELAY LINE AT gkdlt SECONDS                          
				delayw	gasigL + (adelsigL * gkfeedamt)	;WRITE AUDIO SOURCE AND FEEDBACK SIGNAL INTO THE BEGINNING OF THE BUFFER
		
		;;;RIGHT CHANNEL DELAY;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;		                                                                                              
		abufferR	delayr	1.2	;CREATE A DELAY BUFFER OF 5 SECONDS DURATION (EQUIVALENT TO THE MAXIMUM DELAY TIME POSSIBLE USING THIS EXAMPLE)
		adelsigR 	deltap3	adlt	;TAP THE DELAY LINE AT gkdlt SECONDS                          
				delayw	gasigR + (adelsigR * gkfeedamt)	;WRITE AUDIO SOURCE AND FEEDBACK SIGNAL INTO THE BEGINNING OF THE BUFFER
        elseif	gkmode=1	then											
		adelsigL	flanger gasigL, adlt, gkfeedamt , 1.2
		adelsigR	flanger gasigR, adlt, gkfeedamt , 1.2		
	endif                                                                                      
	aL		ntrpol	gasigL, adelsigL, gkmix		;CREATE DRY/WET MIX
	aR		ntrpol	gasigR, adelsigR, gkmix		;CREATE DRY/WET MIX

			outs		aL * gkamp, aR * gkamp	;CREATE A MIX BETWEEN THE WET AND THE DRY SIGNALS AT THE OUTPUT

			clear		gasigL, gasigR		;CLEAR THE GLOBAL AUDIO SEND VARIABLES
endin                                                                         
                                                                                              
</CsInstruments>                                                                              
                                                                                              
<CsScore>                                                                                     
;INSTR | START | DURATION                                                                     
i  2       0       -1	;INSTRUMENT 2 PLAYS A HELD NOTE                                       
                                                                                                                                                                                            
f 0 3600	;'DUMMY' SCORE EVENT KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR              
</CsScore>                                                                                    
                                                                                              
                                                                                              
</CsoundSynthesizer>                                                                          
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              
                                                                                              















































































