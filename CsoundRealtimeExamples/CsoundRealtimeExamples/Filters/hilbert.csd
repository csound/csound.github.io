;Written by Iain McCurdy, 2009. 
;Parts of this example are based on the two examples given in the Csound Manual originally written by Sean Costello.

<CsoundSynthesizer>

<CsOptions>
-odevaudio -idevaudio -b400
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
kr 		= 	44100	;CONTROL RATE (BECAUSE OF THE USE OF A FEEDBACK LOOP kr MUST EQUAL sr)
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;					LABEL     | WIDTH | HEIGHT | X | Y
				FLpanel	"hilbert",   500,    330,    0,  0

;SWITCHES                       			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",	1,    0,    22,    140,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;BORDERS				ITYPE, IFONT, ISIZE, IWIDTH, IHEIGHT, IX, IY
ih		 	FLbox  	" ", 	6,        9,    15,    240,   145,     0, 148	;BORDER AROUND SOURCE-SELECT WIDGETS
ih		 	FLbox  	" ", 	6,        9,    15,    240,   175,   255, 148	;BORDER AROUND MIXER WIDGETS

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
gidfshift			FLvalue	" ",      100,    20,     5,  75
idfshiftmult			FLvalue	" ",      100,    20,     5, 125
idFB_Gain			FLvalue	" ",       50,    15,   260, 243
iddwmix				FLvalue	" ",       50,    15,   260, 273
idoutgain			FLvalue	" ",       50,    15,   260, 303
idVCOfrq			FLvalue	" ",       40,    15,   120, 268

;SLIDERS					            			MIN   |  MAX  | EXP | TYPE |    DISP    | WIDTH | HEIGHT | X  |  Y
gkfshift,gihfshift		FLslider 	"Frequency Shift",		-2000,   2000,   0,    23,           -1,   490,     25,     5,   50	;VALUE DISPLAY FOR THIS VARIABLE IS UPDATED FROM WITHIN THE MAIN ORCHESTRA (INSTR 2)
gkfshiftmlt,ihfshiftmlt		FLslider 	"Frequency Shift Multiplier",	-1,         1,   0,    23, idfshiftmult,   490,     25,     5,  100
gkingain,ihingain		FLslider 	"Input Gain",			0,          1,   0,    23,           -1,   100,     13,   120,  155
gkVCOfrq,ihVCOfrq		FLslider 	"Saw Freq.",			1,      10000,  -1,    23,     idVCOfrq,   100,     13,   120,  255
gkUpShiftGain,ihUpShiftGain	FLslider 	"Up-Shift Gain",		0,          1,   0,    23,           -1,   125,     20,   365,  170
gkDownShiftGain,ihDownShiftGain	FLslider 	"Down-Shift Gain",		0,          1,   0,    23,           -1,   125,     20,   365,  195
gkFB_Gain,ihFB_Gain		FLslider 	"Feedback Gain",		0,          1,   0,    23,    idFB_Gain,   230,     13,   260,  230
gkdwmix,ihdwmix			FLslider 	"Dry/Wet Mix",			0,          1,   0,    23,      iddwmix,   230,     13,   260,  260
gkoutgain,ihoutgain		FLslider 	"Output Gain",			0,          1,   0,    23,    idoutgain,   230,     13,   260,  290


FLsetAlign 4, ihUpShiftGain	;ALIGN LABEL TO THE LEFT OF REFERENCED WIDGET
FLsetAlign 4, ihDownShiftGain   ;ALIGN LABEL TO THE LEFT OF REFERENCED WIDGET
FLsetAlign 9, ihVCOfrq		;ALIGN LABEL TO THE BOTTOM-RIGHT OF REFERENCED WIDGET
FLsetTextSize 12.5, ihVCOfrq	;SET LABEL TEXT-SIZE OF REFERENCED WIDGET

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS			 		TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE
gksoundfile, ihsoundfile	FLbutBank	13,     1,     5,     18,     125,   55, 150,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Source:",		1,       6,    12,    45,      25,     7, 150
ih		 	FLbox  	"live   ", 		1,       5,    12,    25,      25,    90, 150
ih		 	FLbox  	"voice  ", 		1,       5,    12,    25,      25,    90, 175
ih		 	FLbox  	"drums  ", 		1,       5,    12,    25,      25,    90, 200
ih		 	FLbox  	"songpan", 		1,       5,    12,    25,      25,    90, 225
ih		 	FLbox  	"saw    ", 		1,       5,    12,    25,      25,    90, 250
ih		 	FLbox  	"Mixer",		1,       6,    12,    45,      25,   257, 150

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	0, 	gihfshift
				FLsetVal_i	1, 	ihfshiftmlt
				FLsetVal_i	1, 	ihdwmix
				FLsetVal_i	100, 	ihVCOfrq
				FLsetVal_i	0.7, 	ihoutgain
				FLsetVal_i	1, 	ihUpShiftGain
				FLsetVal_i	0, 	ihDownShiftGain
				FLsetVal_i	0, 	ihFB_Gain
				FLsetVal_i	2, 	ihsoundfile
			
				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 512, 700, 512, 0
				FLscroll     512, 700, 0,   0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                         hilbert                             ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"hilbert is an infinite impulse response (IIR) filter that    ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"outputs two signals that are in quadrature (i.e. are 90° out ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"of phase with each other). Listened to on their own, these   ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"output signals will sound almost unchanged from the original ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"but with further manipulation a variety of effects are       ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"possible.                                                    ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"Internally the hilbert filter consists of two parallel 6th   ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"order allpass filters that induce a phase lag that increases ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"with frequency but the phase difference between the two      ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"outputs for any given input frequency is always 90°.         ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"Hilbert's output can be used to create a frequency shifting  ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"effect. A frequency shifter adds a specified number of       ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"cycles-per-second to every frequency of an input signal (as  ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"opposed to a pitch shifter which *multiplies* every frequency", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"of an input signal by a specified amount).                   ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"To complete the frequency shifting procedure the two signals ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"are ring-modulated. The modulating waveforms used should also", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"be in quadrature (90° out of phase with each other). The two ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"resulting signals are either summed or one is subtracted from", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"the other. If the signals are summed the resulting side-bands", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"will be above the original frequency, if one has been        ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"subtracted from the other the resulting side-bands will be   ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"below the original frequency. In this example the gain of    ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"these two signals can be independently controlled using the  ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"'Up-Shift Gain' and 'Down-Shift Gain' sliders. If equal gain ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"is applied to both signals the result is the same as a       ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"ring-modulation effect.                                      ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"Frequency shift values can be negative. Applying negative    ", 	1,      5,     14,    490,    20,     5, 580                                                              
ih		 	FLbox  	"values produces the effect of creating side-bands in the     ", 	1,      5,     14,    490,    20,     5, 600                                                              
ih		 	FLbox  	"opposite direction of the frequency shift. This interface    ", 	1,      5,     14,    490,    20,     5, 620                                                              
ih		 	FLbox  	"includes a slider which multiplies the frequency shift value ", 	1,      5,     14,    490,    20,     5, 640                                                              
ih		 	FLbox  	"by a value within the range 0 to -1. This can be useful for  ", 	1,      5,     14,    490,    20,     5, 660                                                              
ih		 	FLbox  	"fine-tuning small frequency shift values and switching its   ", 	1,      5,     14,    490,    20,     5, 680                                                              
ih		 	FLbox  	"polarity.                                                    ", 	1,      5,     14,    490,    20,     5, 700                                                              
ih		 	FLbox  	"A 'barber-pole' endlessly rising (or falling) phaser effect  ", 	1,      5,     14,    490,    20,     5, 720                                                              
ih		 	FLbox  	"can be created by mixing the input signal with the output    ", 	1,      5,     14,    490,    20,     5, 740                                                              
ih		 	FLbox  	"signal (use the 'Dry/Wet Mix' control) with small frequency  ", 	1,      5,     14,    490,    20,     5, 760                                                              
ih		 	FLbox  	"shift amounts (typically less that 10 Hz). Fine control of   ", 	1,      5,     14,    490,    20,     5, 780                                                              
ih		 	FLbox  	"the rate of the phaser effect can be executed using the      ", 	1,      5,     14,    490,    20,     5, 800                                                              
ih		 	FLbox  	"'Frequency Shift Multiplier' control. The effect can be      ", 	1,      5,     14,    490,    20,     5, 820                                                              
ih		 	FLbox  	"intensified using the 'Feedback Gain' control which controls ", 	1,      5,     14,    490,    20,     5, 840                                                              
ih		 	FLbox  	"how much of the output signal is fed back into the input.    ", 	1,      5,     14,    490,    20,     5, 860                                                              
ih		 	FLbox  	"Care should be taken when using the feature as dynamic       ", 	1,      5,     14,    490,    20,     5, 880                                                              
ih		 	FLbox  	"resonances can be created which can overload and damage      ", 	1,      5,     14,    490,    20,     5, 900                                                              
ih		 	FLbox  	"speakers (and ears!). When using feedback only one of the    ", 	1,      5,     14,    490,    20,     5, 920                                                              
ih		 	FLbox  	"frequency shifters outputs should be used (controlled using  ", 	1,      5,     14,    490,    20,     5, 940                                                              
ih		 	FLbox  	"Up/Down Shift Gain controls) and 'Dry/Wet Mix' should be kept", 	1,      5,     14,    490,    20,     5, 960                                                              
ih		 	FLbox  	"at around 0.5. As the frequency shift value flips into the   ", 	1,      5,     14,    490,    20,     5, 980                                                              
ih		 	FLbox  	"negative domain the phaser sweeps change direction from      ", 	1,      5,     14,    490,    20,     5, 1000                                                              
ih		 	FLbox  	"upwards to downwards.                                        ", 	1,      5,     14,    490,    20,     5, 1020                                                              
ih		 	FLbox  	"To explore the sonic possibilities of the frequency shifter  ", 	1,      5,     14,    490,    20,     5, 1040                                                              
ih		 	FLbox  	"a variety of source sound inputs are available in this       ", 	1,      5,     14,    490,    20,     5, 1060                                                              
ih		 	FLbox  	"example including the computer's live input.                 ", 	1,      5,     14,    490,    20,     5, 1080                         

				FLscroll_end
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine		ftgen	1, 0, 131072, 10, 1

instr	1	;HILBERT FILTERING INSTRUMENT
	if gkOnOff=0	then					;IF FLTK 'On/Off' SWITCH IS OFF... 
		turnoff         				;TURN THIS INSTRMENT OFF IMEDIATELY
	endif                   				;END OF CONDITIONAL BRANCHING      	
	amix		init	0			;INITIALISE amix SIGNAL (NEEDED FOR FEEDBACK SIGNAL ON INITIAL PASS) 

	kfshift		=	gkfshift * gkfshiftmlt	;FREQUENCY VALUE IS DERIVED FROM PRODUCT OF 'Frequency Shift' AND 'Frequency Shift Multiplier' SLIDER
	
	kporttime	linseg	0, 0.001, 0.05, 1, 0.05	;PORTAMENTO FUNCTION RISES FROM ZERO
	kVCOfrq		portk	gkVCOfrq, kporttime	;PORTAMENTO APPLIED TO VARIABLE
	kfshift		portk	kfshift, kporttime	;PORTAMENTO APPLIED TO VARIABLE
	
	;SOURCE SOUND IS SELECTED
	if	gksoundfile==0	then				;IF BUTTON-BANK VALUE IS 0...
		ain	inch	1				;ain IS LIVE INPUT
		ain	=	ain * gkingain			;LIVE INPUT MULTIPLIED BY INPUT GAIN SLIDER VALUE
	elseif	gksoundfile==1	then				;IF BUTTON-BANK VALUE IS 1...
		ain	diskin2	"anditsall.wav", 1, 0, 1        ;ain IS VOCAL SAMPLE
	elseif	gksoundfile==2	then                            ;IF BUTTON-BANK VALUE IS 2...
		ain	diskin2	"loop.wav", 1, 0, 1             ;ain IS DRUMS SAMPLE         
	elseif	gksoundfile==3	then                            ;IF BUTTON-BANK VALUE IS 3...
		ain,aR	diskin2	"songpan.wav", 1, 0, 1          ;ain IS CHINESE TOWN SOUNDSCAPE SAMPLE         
	elseif	gksoundfile==4	then                            ;IF BUTTON-BANK VALUE IS 1...
		ain	vco	10000, kVCOfrq, 1, 0.5, gisine  ;ain IS SAW WAVEFORM SAMPLE         
	endif                                                   ;END OF CONDITIONAL BRANCHING
	
	
	ain	=	ain + (amix * gkFB_Gain)		;ADD FEEDBACK SIGNAL TO INPUT (AMOUNT OF FEEDBACK CONTROLLED BY 'Feedback Gain' SLIDER)
	areal, aimag hilbert ain				;HILBERT OPCODE OUTPUTS TWO PHASE SHIFTED SIGNALS, EACH 90° OUT OF PHASE WITH EACH OTHER
	
	;QUADRATURE OSCILLATORS. I.E. 90° OUT OF PHASE WITH RESPECT TO EACH OTHER
	;OUTUTS	OPCODE	AMPLITUDE | FREQ. | FUNCTION_TABLE | INITIAL_PHASE (OPTIONAL;DEFAULTS TO ZERO)
	asin 	oscili       1,    kfshift,     gisine,          0
	acos 	oscili       1,    kfshift,     gisine,          .25
	
	;RING MODULATE EACH SIGNAL USING THE QUADRATURE OSCILLATORS AS MODULATORS
	amod1 = areal * acos
	amod2 = aimag * asin
	
	;UPSHIFTING OUTPUT
	aupshift = (amod1 - amod2)
	;DOWNSHIFTING OUTPUT
	adownshift = (amod1 + amod2)
	
	;CREATE A MIX OF THE UPSHIFTING OUTPUT SIGNAL AND THE DOWNSHIFTING OUTPUT SIGNAL. MIX IS CONTROLLED BY FLTK SLIDERS 'Up-Shift Gain' AND 'Down-Shift Gain'
	amix	sum	aupshift * gkUpShiftGain, adownshift * gkDownShiftGain
	
	;CREATE A DRY/WET MIX
	amix	ntrpol	 ain, amix, gkdwmix	;DRY/WET MIX IS CREATED

	outs	amix * gkoutgain, amix * gkoutgain	;SEND AUDIO TO OUTPUT AND SCALE USING THE FLTK SLIDER DERIVED VARIABLE gKoutgain
endin

instr	2	;THIS INSTRUMENT, WHICH IS ALWAYS ON, UPDATES THE FLTK VALUE DISPLAY BOX FOR FREQUENCY SHIFT PARAMETER  
	kfshift		=	gkfshift * gkfshiftmlt	;FREQUENCY VALUE IS DERIVED FROM PRODUCT OF 'Frequency Shift' AND 'Frequency Shift Multiplier' SLIDER
	FLprintk2	kfshift, gidfshift		;VALUE DISPLAY BOX IS UPDATED WHENEVER kshift CHANGES
endin

</CsInstruments>

<CsScore>
i 2 0 3600	;UPDATES FREQUENCY SHIFT DISPLAY BOX AND ALSO KEEPS PERFORMANCE GOING FOR 1 HOUR 
</CsScore>

</CsoundSynthesizer>