waveset.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	1	;NUMBER OF CHANNELS (2=STEREO)

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL   | WIDTH | HEIGHT | X | Y
	FLpanel	"waveset",   500,  120,    0,  0

;SWITCHES  	                                  	ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"On/Off",		1,    0,    22,    140,     25,    5,  5,     0,     1,      0,      -1
gkreset,ihreset	FLbutton	"Reset Buffer",		1,    0,    21,    140,     25,    5, 40,    -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES		LABEL  | WIDTH | HEIGHT | X | Y
idgain			FLvalue	" ",       80,     20,    5, 95

;COUNTERS				MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkrep,ihrep 	FLcount  "Repeats", 	1,   1000,    1,     10,      1,    150,     25,   250, 5,   -1

;SLIDERS				            	MIN | MAX | EXP | TYPE | DISP  | WIDTH | HEIGHT | X  | Y
gkgain,ihgain		FLslider 	"Output Gain",	0,     2,    0,    23,  idgain,   490,     25,    5,  70

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      1,    255,   255,   255		;NUMBERS MADE INVISIBLE
FLcolor2	255, 255, 50	;SET SECONDARY COLOUR TO YELLOW
;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gkinput,   ihinput	FLbutBank	12,     1,     3,     30,    60,    150,  5,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      5,      4,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Voice", 		1,       2,    12,    60,      20,   180,   5
ih		 	FLbox  	"Drums", 		1,       2,    12,    60,      20,   180,  25
ih		 	FLbox  	"Live Input", 		1,       2,    12,    60,      20,   180,  45

;SET INITIAL VALUES FOR SLIDERS 	VALUE | HANDLE
			FLsetVal_i	-1, 	ihinput
			FLsetVal_i	-1, 	ihreset
			FLsetVal_i	1, 	ihrep
			FLsetVal_i	1, 	ihinput
			FLsetVal_i	1, 	ihgain

	FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
FLcolor	255, 255, 255, 0, 0, 0
				FLpanel	" ", 515,      380,  512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                         waveset                             ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"The opcode waveset performs timestretching by first defining ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"the audio stream as a sequence of 'wavelets' - wavelets being", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"a chunk of audio bounded by every 2nd zero amplitude         ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"crossing. These wavelets are then repeated a number of times ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"as defined in this example by the 'repeats' counter. Once a  ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"wavelet has been repeated the required number of times,      ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"waveset moves onto the next wavelet and repeats the          ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"procedure.                                                   ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"Waveset obviously has to allocate memory for the proceeding  ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"audio stream whilst it is involved in repeating wavelets.    ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"The amount of memory allocated at i-time for this purpose    ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"defaults to half of p3 but it can optionally be defined      ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"explicitly as an opcode input argument. In a real-time       ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"situation predicting the memory that will be required becomes", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"a little more difficult. In this example I have given a value", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"of 5 minutes - I assume the user will have become bored with ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"the example by that time.                                    ", 	1,      5,     14,    490,    15,     5, 360
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1
	if gkOnOff==0 then	;SENSE FLTK ON/OFF SWITCH
	 turnoff		;TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif
	
	if gkinput==0 then						;CHECK STATUS OF gkinput (FLTK BUTTON BANK)
	 asig		diskin2		"AndItsAll.wav", 1, 0, 1	;READ IN SOUND FILE FROM DISK
	elseif		gkinput==1	then				;CHECK STATUS OF gkinput (FLTK BUTTON BANK)
	 asig		diskin2		"808loopmono.wav", 1, 0, 1	;READ IN SOUND FILE FROM DISK
	elseif		gkinput==2	then				;CHECK STATUS OF gkinput (FLTK BUTTON BANK)
	 asig		inch		1				;READ THE COMPUTER'S LEFT LIVE AUDIO INPUT
	endif								;END OF if... BRANCHING
	
	kSwitch		changed		gkinput, gkreset		;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if kSwitch==1 then
	 reinit UPDATE
	endif
	UPDATE:
	;OUTPUT		OPCODE	INPUT | REPEATS | INPUT_DURATION (OPTIONAL)
	ares 		waveset asig,   gkrep,      5*60*sr		;PASS THE AUDIO SIGNAL THROUGH waveset OPCODE. Input duration is defined in samples - in this example the expression given equats to a 5 minute buffer
			out	ares*gkgain				;SEND waveset OUTPUT TO THE SPEAKERS
	gkreset		=	0
endin
</CsInstruments>

<CsScore>
f 0 3600
</CsScore>

</CsoundSynthesizer>
