;FLsetPosition_FLsetSize.csd
;Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	4	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE (MAY NEED TO BE LOW WHEN WORKING WITH SHORT DELAY TIMES DEFINED INITIALLY AT KRATE)
nchnls 		= 	2	;NUMBER OF CHANNELS (1=MONO)
0dbfs		=	1	;MAXIMUM SOUND INTENSITY LEVEL REGARDLESS OF BIT DEPTH

gisine	ftgen	0,0,4097,10,1
seed	0
giButtonWidth	init	100
giButtonHeight	init	100
giPanelWidth	init	500
giPanelHeight	init	500

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL                        |     WIDTH     |    HEIGHT     | X | Y
		FLpanel	"FLsetPosition  FLsetSize",     giPanelWidth,   giPanelHeight,  0,  0
;A MACRO IS USE TO SAVE HAVING TO REPEAT CODE FOR THE MULTIPLE COLOURED BUTTONS
;USING A MACRO ALSO MAKES IT EASIER TO ADD FURTHER BUTTONS
;MACRO ARGUMENTS ARE FOR: NUMBER_INDEX(1,2,3...)  RED GREEN BLUE(0-255)   MIDI_NOTE_NUMBER NOTE_DURATION CARRIER_RATIO MODULATOR_RATIO
#define	BUTTON(N'R'G'B'NOTE'DURATION'CAR'MOD)
#
;BUTTONS                       			ON | OFF | TYPE |    WIDTH      |     HEIGHT     | X | Y | OPCODE | INS | STARTTIM |   DUR    |   p4  |P5   P6   P7
gk$N,gih$N		FLbutton	"",	1,    0,     1,  giButtonWidth,  giButtonHeight,   0,  0,    0,      2,      0,     $DURATION,  $NOTE, $N, $CAR,$MOD      
FLsetColor	$R,$G,$B,gih$N	;COLOUR THE BUTTON
FLsetColor2	$R,$G,$B,gih$N	;SECONDARY COLOUR THE SAME AS THE PRIMARY BUTTON
FLhide gih$N			;HIDE THE BUTTON
#
;EXPAND THE MACRO FOR AS MANY BUTTONS AS ARE DESIRED
$BUTTON(1'  0'  0'255'24'15'1'1.1)	;BLUE
$BUTTON(2'  0'255'  0'24'15'1'2.52)	;GREEN
$BUTTON(3'255'  0'  0'24'15'9'1.01)	;RED
$BUTTON(4'255'255'  0'24'15'5'1)	;YELLOW
$BUTTON(5'  0'255'255'24'15'1'1.317)	;TURQUOISE
	FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 560, 512, 0
				FLscroll     515, 560, 0, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"          FLsetPosition FLsetSize (FLhide FLshow)            ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"'FLsetPosition' can be used to set the location of an FLTK   ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"widget after it has already been placed according to the 'x' ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"and 'y' values given to the widget in its own opcode line.   ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"'x' and 'y' parameters always refer to the location of the   ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"top left corner of the widget in terms of the number of      ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"pixels from the upper and left boundaries of the FL panel    ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"respectively.                                                ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"In a similar fashion 'FLsetSize' redefines the size of a     ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"widget in terms of its width and its height after it has     ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"been created,                                                ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"'FLhide' hides an FLTK widget, 'FLshow' reveals a widget that", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"has previously been hidden. While a widget is hidden it can  ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"not be interacted with.                                      ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"When a widget is relocated using FLsetPosition or resized    ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"using FLsetSize it must first be hidden using FLhide. Once   ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"changes to position and size have been made it can then be   ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"revealed in its new position and its new size using FLshow.  ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"In this example these opcodes are used to move five coloured,", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"shape changing buttons randomly around the panel. Clicking a ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"button plays a tone (created using FM synthesis with foscili)", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"with characteristics unique to that button. The 'x' and 'y'  ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"locations and dimensions are also written into function      ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"tables so that they are accesible by the sound producing     ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"instrument for that button. The higher up the panel a button ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"is the brighter the tone is that it produces and also the    ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"higher its pitch is. Pitch modulation range is 5 octaves in  ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"semitone steps from the bottom of the panel to the top.      ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"Brightness varies continuously as the button moves whereas   ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"pitch modulation is fixed at the moment a note is triggered. ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"The horizontal distance a button is across the panel is      ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"used to define the speed of an auto-panner. When the button  ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"is at the left boundary of the panel this speed is zero hertz", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"and when it is at the right hand boundary it is 20 hertz.    ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"This parameter is varied continuously as a button moves      ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"around the panel.                                            ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"Button width is reflected in the cutoff frequency of a       ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"resonant lowpass filter ('moogvcf') and height is reflected  ", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"in the cutoff frequency of a resonant highpass filter        ", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"('statevar').                                                ", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"The random movement of buttons is governed by 'rspline'      ", 	1,      5,     14,    490,    20,     5, 820
ih		 	FLbox  	"random spline generators.                                    ", 	1,      5,     14,    490,    20,     5, 840
ih		 	FLbox  	"Buttons are randomly re-colourized when they are clicked.    ", 	1,      5,     14,    490,    20,     5, 860
ih		 	FLbox  	"This is not interpretted into sound.                         ", 	1,      5,     14,    490,    20,     5, 880
ih		 	FLbox  	"The rate at which buttons are updated can be changed by the  ", 	1,      5,     14,    490,    20,     5, 900
ih		 	FLbox  	"user using the on screen slider. An excessively high value   ", 	1,      5,     14,    490,    20,     5, 920
ih		 	FLbox  	"can affect realtime audio performance, an excessively low    ", 	1,      5,     14,    490,    20,     5, 940
ih		 	FLbox  	"value will result in conspicuously stepped movement of the   ", 	1,      5,     14,    490,    20,     5, 960
ih		 	FLbox  	"buttons. A value of 15-20 seems like a good compromise here. ", 	1,      5,     14,    490,    20,     5, 980
				FLscroll_end                                                                                     
				FLpanel_end

;		LABEL      | WIDTH | HEIGHT | X | Y
	FLpanel	"controls",   500,    150,  512, 400
;VALUE DISPLAY BOXES			WIDTH | HEIGHT | X |  Y
idspeedP1		FLvalue	" ",    50,       17,    5,   30
idspeedP2		FLvalue	" ",    50,       17,  445,   30
idspeedS1		FLvalue	" ",    50,       17,    5,   80
idspeedS2		FLvalue	" ",    50,       17,  445,   80
idUpdateRate		FLvalue	" ",    50,       17,    5,  130

;SLIDERS								MIN  |   MAX | EXP | TYPE |   DISP       | WIDTH | HEIGHT | X | Y
gkspeedP1, ihspeedP1		FLslider 	"",			0.02,     3,   -1,     3,   idspeedP1,      490,     15,    5,  0
gkspeedP2, ihspeedP2		FLslider 	"Speed (Position)",	0.02,     3,   -1,     3,   idspeedP2,      490,     15,    5, 15
gkspeedS1, ihspeedS1		FLslider 	"",			0.02,     3,   -1,     3,   idspeedS1,      490,     15,    5, 50
gkspeedS2, ihspeedS2		FLslider 	"Speed (Size)",		0.02,     3,   -1,     3,   idspeedS2,      490,     15,    5, 65
gkUpdateRate, ihUpdateRate	FLslider 	"Rate of Update",	1,       50,   -1,     3,   idUpdateRate,   490,     25,    5,100

		FLsetVal_i	0.1, 	ihspeedP1
		FLsetVal_i	0.4, 	ihspeedP2
		FLsetVal_i	0.1, 	ihspeedS1
		FLsetVal_i	0.4, 	ihspeedS2
		FLsetVal_i	20, 	ihUpdateRate

	FLpanel_end	;END OF PANEL CONTENTS

	FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gix		ftgen	0,0,16,-2,0
giy		ftgen	0,0,16,-2,0
giwidth		ftgen	0,0,16,-2,0  
giheight	ftgen	0,0,16,-2,0

instr	1	;MOVE THE FLTK BUTTON WIDGETS AROUND RANDOMLY
	kmetro	metro	gkUpdateRate	;RATE AT WHICH BUTTONS LOCATIONS ARE UPDATED. 
					;TOO FAST AND FL-UPDATING WILL INTERFERE WITH REALTIME AUDIO. 
					;TOO SLOW AND MOVEMENT WILL BE VERY STEP-LIKE.
#define	MOVE_BUTTON(N)			;A MACRO IS DEFINED TO PREVENT CODE REPETITION FOR EACH BUTTON. 
					;THIS WILL ALSO MAKE IT EASIER TO ADD EXTRA BUTTONS
					;THIS MACRO TAKE ONE ARGUMENT 'N' WHICH WILL BE A COUNTER USED TO INDEX AND REFER TO THE BUTTON
	#
	kx$N		rspline	0,1,gkspeedP1,gkspeedP2		;RANDOM SPLINE CURVE CREATES 'X' POSITION (WITHIN THE RANGE 0 - 1)
	ky$N		rspline	0,1,gkspeedP1,gkspeedP2		;RANDOM SPLINE CURVE CREATES 'Y' POSITION (WITHIN THE RANGE 0 - 1)
	kx$N		limit	kx$N,0,1			;LIMIT THE VALUE OF 'X' POSITION BETWEEN 0 - 1. (rspline CAN OUTPUT VALUES BEYOND ITS BOUNDARIES)
	ky$N		limit	ky$N,0,1			;LIMIT THE VALUE OF 'Y' POSITION BETWEEN 0 - 1. (rspline CAN OUTPUT VALUES BEYOND ITS BOUNDARIES)	
	kwidth$N	rspline	0.01,1,gkspeedS1,gkspeedS2	;RANDOM SPLINE CURVE CREATES HEIGHT MULTIPLE (WITHIN THE RANGE 0.01 - 1). MINIMUM IS NOT ZERO SO SO THAT THE BUTTON CANNOT DISAPPEAR COMPLETELY. 
	kheight$N	rspline	0.01,1,gkspeedS1,gkspeedS2	;RANDOM SPLINE CURVE CREATES WIDTH MULTIPLE (WITHIN THE RANGE 0.01 - 1). MINIMUM IS NOT ZERO SO SO THAT THE BUTTON CANNOT DISAPPEAR COMPLETELY.
	kwidth$N	limit	kwidth$N,0.01,1			;LIMIT THE VALUE OF WIDTH MULTIPLE BETWEEN 0 - 1. (rspline CAN OUTPUT VALUES BEYOND ITS BOUNDARIES)
	kheight$N	limit	kheight$N,0.01,1		;LIMIT THE VALUE OF HEIGHT MULTIPLE POSITION BETWEEN 0 - 1. (rspline CAN OUTPUT VALUES BEYOND ITS BOUNDARIES)	

	tablew		kx$N,$N,gix		;WRITE THE NEW WIDGET X LOCATION TO THE FUNCTION TABLE SO IT CAN BE ACCESSED BY INSTRUMENT 2
						;TABLE LOCATION IS DERIVED FROM THE BUTTON INDEX NUMBER
	tablew		ky$N,$N,giy		;WRITE THE NEW WIDGET Y LOCATION TO THE FUNCTION TABLE SO IT CAN BE ACCESSED BY INSTRUMENT 2
	tablew		kwidth$N,$N,giwidth	;WRITE THE NEW WIDGET WIDTH MULTPLE TO THE FUNCTION TABLE SO IT CAN BE ACCESSED BY INSTRUMENT 2
	tablew		kheight$N,$N,giheight	;WRITE THE NEW WIDGET HEIGHT MULTPLE TO THE FUNCTION TABLE SO IT CAN BE ACCESSED BY INSTRUMENT 2
	if kmetro=1 then		;IF A METRONOME IMPULSE IS RECEIVED...
	  reinit UPDATE$N		;BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE$N'
	endif				;END OF CONDITIONAL BRANCH
	UPDATE$N:			;A LABEL. REINITIALISATION TO RESET THE WIDGET POSITION BEGINS FROM HERE.
	FLhide gih$N			;HIDE THE WIDGET
					
	FLsetPosition i(kx$N)*(giPanelWidth-giButtonWidth),i(ky$N)*(giPanelHeight-giButtonHeight),gih$N	
					;RELOCATE THE WIDGET
					;'X' AND 'Y' LOCATIONS ARE RESCALED ACCORINDING TO THE DIMENSIONS OF THE PANEL, DECLARED IN THE HEADER
					;THE SIZE OF THE BUTTONS ARE ALSO TAKEN INTO ACCOUNT
	FLsetSize	i(kwidth$N)*giButtonWidth, i(kheight$N)*giButtonHeight, gih$N
	
	FLshow gih$N			;THE WIDGET IS REVEALED
	rireturn			;RETURN FROM REINITIALISATION PASS
	#
	;EXPAND THE MACRO FOR EACH BUTTON
	$MOVE_BUTTON(1)
	$MOVE_BUTTON(2)
	$MOVE_BUTTON(3)
	$MOVE_BUTTON(4)
	$MOVE_BUTTON(5)
endin

instr	2	;SOUND PRODUCING INSTRUMENT
		event_i	"i",3,0,0,p5	;TRIGGER NEW COLOUR SELECTION FO RTHIS BUTTON
	iy	table	p5,giy		;READ 'Y' POSITION FROM FUNCTION TABLE AT I-RATE. (K-RATE VARIABLE IS NOT AVAILABLE AT INITIALISATION TIME)
	iy	=	1-iy		;INVERT 'Y' VARIABLE. (NOW, 1=TOP 0=BOTTOM)
	itrans	init	int(iy*60)	;DERIVE A TRANSPOSITION VALUE WITHIN THE RANGE 0-60 IN INTEGER STEPS
	kx	table	p5,gix		;READ 'X' POSITION FROM FUNCTION TABLE AT K-RATE, TABLE LOCATION IS DERIVED FROM THE BUTTON INDEX NUMBER (p5)
	ky	table	p5,giy		;READ 'Y' POSITION FROM FUNCTION TABLE AT K-RATE, TABLE LOCATION IS DERIVED FROM THE BUTTON INDEX NUMBER (p5)
	ky	=	1-ky		;INVERT 'Y' VARIABLE. (NOW, 1=TOP 0=BOTTOM)
	kwidth	table	p5,giwidth	;READ WIDTH MULTIPLIER FROM FUNCTION TABLE AT K-RATE, TABLE LOCATION IS DERIVED FROM THE BUTTON INDEX NUMBER (p5)
	kheight	table	p5,giheight	;READ HEIGHT MULTIPLIER FROM FUNCTION TABLE AT K-RATE, TABLE LOCATION IS DERIVED FROM THE BUTTON INDEX NUMBER (p5)

	aenv	expseg	0.001,0.005,1,p3-0.005,0.001	;CREATE AN AMPLITUDE ENVELOPE
	kpan	lfo	0.5,(kx^2)*20,0			;CREATE AN AUTO PAN MODULATION RATE WITHIN THE RANGE 0 - 20 AND BASED ON THE CONTINUOUSLY CHANGING X-POSITION OF THE BUTTON
							;'X' VARIABLE IS RAISED TO THE POWER OF 2 TO CREATE A CONCAVE MAPPING RATHER THAN A LINEAR ONE
	kpan	=	kpan+0.5			;DC OFFSET PANNING VARIABLE TO BE WITHIN THE RANGE 0 - 1
	kndx	expseg	40,0.02,10,p3-0.02,0.001		;CREATE AN ENVELOPE FOR FM INDEX (BRIGHTNESS)
	asig	foscili 1/3,cpsmidinn(p4+itrans),p6,p7,kndx*(ky^2),gisine	
							;CREATE AN FM TONE
							;BASE FREQUENCY, CARRIER FREQUENCY RATIO AND MODULATOR FREQUENCY RATIO ARE DERIVED FROM P-FIELDS PASSED BY THE FL BUTTONS (p4,p6,p7)
	kLPF	=	cpsoct(8*(sqrt(kwidth))+4)	;DERIVE LOWPASS FILTER CUTOFF FREQUENCY FROM BUTTON WIDTH VALUE
	kHPF	=	cpsoct(8*((1-(kheight^2)))+4)	;DERIVE HIGHPASS FILTER CUTOFF FREQUENCY FROM BUTTON HEIGHT VALUE
	aLPF	interp	kLPF				;CONVERT TO A-RATE VARIABLE - PRODUCES SMOOTHER RESULTS
	aHPF	interp	kHPF				;CONVERT TO A-RATE VARIABLE - PRODUCES SMOOTHER RESULTS
	afilt	moogvcf2	asig,kLPF,0.7		;LOWPASS FILTER AUDIO (CREATE A NEW AUDIO SIGNAL AT THE OUTOUT SO THIS CAN BE AMPLITUDE BALANCED AGAINST THE ORIGINAL LATER ON)
	afilt	bqrez	afilt, aHPF, 25 ,1		;HIGHPASS FILTER THE AUDIO
	asig	balance	afilt,asig			;BALANCE FILTERED AUDIO SIGNAL AGAIN THE PRE-FILTERED SIGNAL. THE SHOULD ATTENUATE LEAPS IN AMPLITIDE CAUSED BY THE RESOSONANT FILTERS
	aL,aR	pan2	asig*aenv,kpan			;PAN THE MONO AUDIO TO CREATE A STEREO SIGNAL. kpan IS DERIVED FROM AN LFO
	aL	delay	aL,rnd(0.06)+0.0001		;RANDOM STATIC DELAY THE LEFT CHANNEL. COMBINED WITH A DIFFERENT RANDOM DELAY ON THE RIGHT CHANNEL THIS WILL CREATE A DIFFERENT STEREO SPATIAL EFFECT WITH EACH NOTE. 
	aR	delay	aR,rnd(0.06)+0.0001		;RANDOM STATIC DELAY THE RIGHT CHANNEL
		outs	aL,aR				;SEND AUDIO TO OUTPUTS
endin

instr	3	;RANDOMLY RE-COLOURIZE BUTTON THIS IS EXECUTED WHEN A BUTTON IS CLICKED
	iR		random	0,255.99	;RANDOM RED COLOUR ATTRIBUTE (WITHIN THE RANGE 0 - 255)
	iG		random	0,255.99	;RANDOM GREEN COLOUR ATTRIBUTE (WITHIN THE RANGE 0 - 255)
	iB		random	0,255.99	;RANDOM BLUE COLOUR ATTRIBUTE (WITHIN THE RANGE 0 - 255)
	FLsetColor	iR,iG,iB,gih1+p4-1	;COLOUR THE BUTTON
	FLsetColor2	iR,iG,iB,gih1+p4-1	;SECONDARY COLOUR THE SAME AS THE PRIMARY BUTTON
endin

</CsInstruments>

<CsScore>
i 1 0 3600	;INSTRUMENT TO MOVE THE BUTTONS RANDOMLY AROUND THE SCREEN. RUNS FOR 1 HOUR.
e
</CsScore>

</CsoundSynthesizer>