;Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>

sr	= 	44100
ksmps	= 	32
nchnls	= 	2
0dbfs	=	1	;MAXIMUM SOUND INTENSITY LEVEL REGARDLESS OF BIT DEPTH                                                                      

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL     | WIDTH | HEIGHT | X | Y
	FLpanel	"pvsvoc",    500,    550,    0,  0

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,      9,     15,    496,    128,    2, 150	;BORDER AROUND SOURCE 1 (AMPLITUDE INPUT)
ih		 	FLbox  	" ", 	6,      9,     15,    496,    128,    2, 280	;BORDER AROUND SOURCE 1 (FREQUENCIES INPUT)
ih		 	FLbox  	" ", 	6,      9,     15,    496,     80,    2, 411	;BORDER AROUND PITCH RESCALING

;SWITCHES                                            		ON | OFF | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,    0,    22,    120,     25,     5,  5,    0,     1,      0,      -1
gkswap,ihswap		FLbutton	"Swap Sources",		1,    0,    22,    150,     25,   345,  5,   -1
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihswap	;SET SECONDARY COLOUR TO YELLOW

;COUNTERS					     	MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE 
gkcoefs, ihcoefs	FLcount  	"Num. Coefs.", 	1,    200,    1,     10,     1,     120,     25,   190,  5,   -1 
gkoctave, ihoctave	FLcount  	"Octave", 	-3,     3,    1,     10,     2,     140,     25,    20, 440,   -1 
gksemitone, ihsemitone	FLcount  	"Semitones", 	-12,   12,    1,     10,     2,     140,     25,   180, 440,   -1 
gkcents, ihcents	FLcount  	"Cents", 	-100, 200,    1,     10,     1,     140,     25,   340, 440,   -1 

;VALUE DISPLAY BOXES		LABEL | WIDTH | HEIGHT | X | Y
iddepth			FLvalue	" ",	 80,      20,    5,  75
idgain			FLvalue	" ",	 80,      20,    5, 125
idspeed1		FLvalue	" ",	 80,      20,    5, 255
idspeed2		FLvalue	" ",	 80,      20,    5, 385

;SLIDERS				            			MIN   | MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X  | Y
gkdepth, ihdepth	FLslider 	"Depth of Cross Synthesis",	0,       1,    0,    23,   iddepth,   490,     25,    5,   50
gkgain, ihgain		FLslider 	"Gain",				0,      50,    0,    23,   idgain,    490,     25,    5,  100
gkspeed1, ihspeed1	FLslider 	"Speed 1",			-2,      2,    0,    23,   idspeed1,  490,     25,    5,  230
gkspeed2, ihspeed2	FLslider 	"Speed 2",			-2,      2,    0,    23,   idspeed2,  490,     25,    5,  360
gkrvb, ihrvb		FLslider 	"Reverb Mix",			0,       1,    0,    23,   -1,        490,     25,    5,  500

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS				TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkinput1, ihinput1	FLbutBank	14,     1,     3,     18,      60,  310, 160,  -1   
gkinput2, ihinput2	FLbutBank	14,     1,     3,     18,      60,  310, 290,  -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES										TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Source 1 (Amplitudes)",       				1,       4,    14,    160,     20,    5,  151
ih		 	FLbox  	"Source 2 (Frequencies)",       			1,       4,    14,    160,     20,    5,  281
ih		 	FLbox  	"Pitch Rescaling",       				1,       4,    14,    120,     20,    5,  412
ih		 	FLbox  	"Source:",  	     					1,       4,    12,     50,     20,  250,  160
ih		 	FLbox  	"Drum Loop",  	     					1,       3,    12,     70,     20,  330,  160
ih		 	FLbox  	"Vocal Sample",       					1,       3,    12,     90,     20,  330,  180
ih		 	FLbox  	"Live Input (Left Channel)",				1,       3,    12,    140,     20,  330,  200
ih		 	FLbox  	"Source:",  	     					1,       4,    12,     50,     20,  250,  290
ih		 	FLbox  	"Synth Pad",  	     					1,       3,    12,     60,     20,  330,  290
ih		 	FLbox  	"Classical Guitar",       				1,       3,    12,     90,     20,  330,  310
ih		 	FLbox  	"Live Input (Right Channel)",  				1,       3,    12,    145,     20,  330,  330

;SET INITIAL VALUES FOR SLIDERS 	|VALUE | HANDLE
			FLsetVal_i	1, 	ihdepth
			FLsetVal_i	0.75, 	ihspeed1
			FLsetVal_i	-1, 	ihspeed2
			FLsetVal_i	2, 	ihgain
			FLsetVal_i	80, 	ihcoefs
			FLsetVal_i	0, 	ihoctave
			FLsetVal_i	0, 	ihsemitone
			FLsetVal_i	0, 	ihcents
			FLsetVal_i	0.15, 	ihrvb

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     640,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                            pvsvoc                           ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Pvsvoc combines the spectral envelope of one signal          ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"(referred to as the input signal) with the frequencies of    ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"another signal (referred to as the excitation signal).       ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"This capability can be used to imitate the functioning of the", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"traditional vocoder.                                         ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"Typically the source which supplies amplitudes will be a     ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"dynamically lively source such as drums of voice. The source ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"that supplies the frequencies is often a sustaining harmonic ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"sound such as a synthesizer pad.                             ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"In this example a variety of sources are provided for        ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"experimentation. Live input can be used for both sources.    ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"For the classic vocoder arrangement connect a microphone to  ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"the left channel input and a synthesizer to the right channel", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"input when using live input for both sources.                ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"The 'Depth of Cross Synthesis' slider allows the user to vary", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"the amount of cross synthesis that will be applied. If this  ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"control is at zero then the output signal of pvsvoc will be  ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"simply the 'input' signal, if 'Depth...' is at 1 then the    ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"frequencies in the output signal will be entirely those of   ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"the excitation signal.                                       ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"Sound files used as source inputs are played within the      ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"instrument using diskin2 opcodes. The speed of playback for  ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"each diskin2 player can be modulated. Naturally this will    ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"modify pitch as well as speed.                               ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"Additionally the output can be transposed in octaves,        ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"semitones an cents. This function uses the pvscale opcode.   ", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"Reverb can also be added to the output signal.               ", 	1,      5,     14,    490,    15,     5, 560
ih		 	FLbox  	"The number of cepstrum coefficients used in the vocoding can ", 	1,      5,     14,    490,    15,     5, 580
ih		 	FLbox  	"be adjusted using a counter. The 'Swap Sources' switch swaps ", 	1,      5,     14,    490,    15,     5, 600
ih		 	FLbox  	"sources one and two around.                                  ", 	1,      5,     14,    490,    15,     5, 620
                                                                                               
				FLpanel_end
                                                                                                     
				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                 
gasendL	init	0	;GLOBAL AUDIO VARIABLE FOR REVERB SEND LEFT CHANNEL                                                                 
gasendR	init	0	;GLOBAL AUDIO VARIABLE FOR REVERB SEND RIGHT CHANNEL

instr	1
	if gkOnOff=0 then	;IF ON/OFF SWITCH IS OFF...
	  turnoff		;TURN THIS INSTRUMENT OFF IMMEDIATELY	                        
	endif			;END OF THIS CONDITIONAL BRANCH
	
	kporttime	linseg	0,0.001,0.05		;A FUNCTION THAT RAMPS UP QUICK FROM ZERO TO A HELD VALUE IS CREATED THAT WILL BE USED AS POTAMENTO TIME                                
	kspeed1		portk	gkspeed1,kporttime	;APPLY PORTAMENTO SMOOTHING TO THE FLTK SLIDER VARIABLE
	kspeed2		portk	gkspeed2,kporttime	;APPLY PORTAMENTO SMOOTHING TO THE FLTK SLIDER VARIABLE
	if gkinput1=0 then				;IF FIRST INPUT OPTION IS CHOSEN FOR 'AMPLITUDES' SOURCE FROM THE FLTK BUTTON BANK...
	  a1L	diskin	"loop.wav",kspeed1,0,1		;...READ MONO SOUND FILE-
	  a1R	=	a1L				;-AND COPY THE SINGLE AUDIO CHANNEL FROM THE MONO SOUND FILE INTO THE RIGHT HAND CHANNEL FOR STEREO COMPATIBILITY 
	elseif gkinput1=1 then				;OR IF 2ND INPUT OPTION  HAS BEEN CHOSEN...  
	  a1L	diskin	"AndItsAll.wav",kspeed1,0,1	;...READ MONO SOUND FILE-
	  a1R	=	a1L	  			;-AND COPY THE SINGLE AUDIO CHANNEL FROM THE MONO SOUND FILE INTO THE RIGHT HAND CHANNEL FOR STEREO COMPATIBILITY
	else						;OTHERWISE...
	  a1L	inch	1				;READ LIVE AUDIO INPUT FROM THE COMPUTER'S LEFT CHANNEL-
	  a1R	=	a1L	  	  		;-AND COPY INTO THE RIGHT CHANNEL FOR STEREO COMPATIBILITY
	endif	  					;END OF THIS CONDITIONAL BRANCH
	f1L	pvsanal	a1L, 1024, 256, 1024, 1		;CREATE AN FSIG STREAMING FFT ANALYSIS OF THE LEFT AUDIO CHANNEL
	f1R	pvsanal	a1R, 1024, 256, 1024, 1		;CREATE AN FSIG STREAMING FFT ANALYSIS OF THE RIGHT AUDIO CHANNEL

	if gkinput2=0 then                               		;IF FIRST INPUT OPTION IS CHOSEN FOR 'FREQUENCIES' SOURCE FROM THE FLTK BUTTON BANK...
	  a2L,a2R	diskin	"SynthPad.wav",kspeed2,0,1		;READ STEREO SOUND FILE
	elseif gkinput2=1 then						;OR IF 2ND INPUT OPTION  HAS BEEN CHOSEN...   
	  a2L,a2R	diskin	"ClassicalGuitar.wav",kspeed2,0,1	;READ STEREO SOUND FILE
	else								;OTHERWISE
	  a2L	inch	2						;READ LIVE AUDIO INPUT FROM THE COMPUTER'S LEFT CHANNEL-
	  a2R	=	a2L						;-AND COPY INTO THE RIGHT CHANNEL FOR STEREO COMPATIBILITY
	endif								;END OF THIS CONDITIONAL BRANCH
	f2L	pvsanal	a2L, 1024, 256, 1024, 1				;CREATE AN FSIG STREAMING FFT ANALYSIS OF THE LEFT AUDIO CHANNEL
	f2R	pvsanal	a2R, 1024, 256, 1024, 1				;CREATE AN FSIG STREAMING FFT ANALYSIS OF THE RIGHT AUDIO CHANNEL
	
	if gkswap=0 then						;IF 'SWAP INPUTS' SWITCH IS DEACTIVATED... 
	  f3L	pvsvoc	f1L, f2L, gkdepth, gkgain, gkcoefs		;PERFORM VOCODING BETWEEN THE TWO LEFT CHANNELS WITH THE SOURCES THE NORMAL WAY AROUND
	  f3R	pvsvoc	f1R, f2R, gkdepth, gkgain, gkcoefs		;PERFORM VOCODING BETWEEN THE TWO RIGHT CHANNELS WITH THE SOURCES THE NORMAL WAY AROUND
	elseif gkswap=1 then						;OTHERWISE IF THE 'SWAP INPUTS' SWITCH IS ACTIVATED... 
	  f3L	pvsvoc	f2L, f1L, gkdepth, gkgain, gkcoefs		;PERFORM VOCODING BETWEEN THE TWO LEFT CHANNELS WITH THE SOURCES SWAPPED    
	  f3R	pvsvoc	f2R, f1R, gkdepth, gkgain, gkcoefs		;PERFORM VOCODING BETWEEN THE TWO RIGHT CHANNELS WITH THE SOURCES SWAPPED
	endif								;END OF THIS CONDITIONAL BRANCH                                                               
	kscal	=	octave(gkoctave)*semitone(gksemitone)*cent(gkcents)	;DERIVE PITCH SCALING RATIO FROM OCTAVE, SEMITONES AND CENTS TRANSPOSE SETTINGS	
	f4L	pvscale	f3L, kscal						;PITCH RESCALE THE LEFT CHANNEL
	f4R	pvscale	f3R, kscal						;PITCH RESCALE THE RIGHT CHANNEL
		
	;OUTPUT		OPCODE		INPUT
	aresynL		pvsynth  	f4L                     ;RESYNTHESIZE THE f-SIGNAL AS AN AUDIO SIGNAL
	aresynR		pvsynth  	f4R                     ;RESYNTHESIZE THE f-SIGNAL AS AN AUDIO SIGNAL
			outs		aresynL*(1-gkrvb), aresynR*(1-gkrvb)	;SEND THE RESYNTHESIZED SIGNAL TO THE AUDIO OUTPUTS
	gasendL		=		gasendL + aresynL*gkrvb	;SEND SOME AUDIO INTO THE REVERB LEFT CHANNEL
	gasendR		=		gasendR + aresynR*gkrvb	;SEND SOME AUDIO INTO THE REVERB RIGHT CHANNEL
endin

instr	4
	aRvbL,aRvbR	reverbsc	gasendL,gasendR,0.82,8000	;CREATE A STEREO REVERB SIGNAL
			outs		aRvbL,aRvbR			;SEND REVERB TO THE OUTPUTS
			clear		gasendL,gasendR			;CLEAR THE REVERB SEND CHANNELS
endin

</CsInstruments>

<CsScore>
i 4 0 3600	;REVERB EFFECT IS ON FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>