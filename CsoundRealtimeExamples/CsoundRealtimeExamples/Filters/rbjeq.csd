;Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
-odevaudio -b400
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
kr 		= 	4410	;CONTROL RATE
ksmps 		= 	10	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM SOUND INTENSITY LEVEL REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;					LABEL   | WIDTH | HEIGHT | X | Y
				FLpanel	"rbjeq",   500,    495,    0,  0

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idSawFrq			FLvalue	" ",       70,    15,   170,  67
idfco				FLvalue	" ",      100,    20,     5, 110
idlvl				FLvalue	" ",      100,    20,     5, 160
idQ				FLvalue	" ",      100,    20,     5, 210
idS				FLvalue	" ",      100,    20,     5, 260
idamp				FLvalue	" ",      100,    20,     5, 310

;COUNTERS											MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X |  Y  | OPCODE
gkskip, ihskip 			FLcount  "Initialisation 0-On 1-Off", 				0,     1,     1,      1,     2,     150,     30,   350, 345,    -1

;SLIDERS					            		MIN | MAX | EXP | TYPE |    DISP | WIDTH | HEIGHT | X | Y
gkSawFrq, ihSawFrq		FLslider 	"Sawtooth Frequency",	20,   5000, -1,   23,   idSawFrq,  310,     12,  170,  55
gkfco, ihfco			FLslider 	"Cutoff Frequency",	20,  20000, -1,   23,      idfco,  490,     25,    5,  85
gklvl, ihlvl			FLslider 	"Gain",			0.001,  16, -1,   23,      idlvl,  490,     25,    5, 135
gkQ, ihQ			FLslider 	"Q",			.0001, 0.1, -1,   23,      idQ,    490,     25,    5, 185
gkS, ihS			FLslider 	"Slope",		0,       1,  0,   23,      idS,    490,     25,    5, 235
gkamp, ihamp			FLslider 	"Output Gain",		0,       1,  0,   23,      idamp,  490,     25,    5, 285

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS				TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkmode, ihmode		FLbutBank	14,     1,     7,     18,     140,   65, 345,   -1
gkOnOff, ihOnOff	FLbutBank	12,     1,     3,     70,      75,    5,   5,    0,     1,     0,        -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Off       ", 		1,       6,    14,     90,      20,  75,   5
ih		 	FLbox  	"Sound file", 		1,       6,    14,     90,      20,  75,  30
ih		 	FLbox  	"Sawtooth  ", 		1,       6,    14,     90,      20,  75,  55
ih		 	FLbox  	"Mode:",		1,       6,    15,     45,      20,   7, 345
ih		 	FLbox  	"resonant lowpass ", 	1,       5,    14,    140,      20,  90, 345
ih		 	FLbox  	"resonant highpass", 	1,       5,    14,    140,      20,  90, 365
ih		 	FLbox  	"bandpass         ", 	1,       5,    14,    140,      20,  90, 385
ih		 	FLbox  	"band-reject      ", 	1,       5,    14,    140,      20,  90, 405
ih		 	FLbox  	"peaking EQ       ", 	1,       5,    14,    140,      20,  90, 425
ih		 	FLbox  	"low shelf EQ     ",	1,       5,    14,    140,      20,  90, 445
ih		 	FLbox  	"high shelf EQ    ",	1,       5,    14,    140,      20,  90, 465

;SET INITIAL VALUES OF FLTK VALUATORS
;						VALUE | HANDLE
				FLsetVal_i	3000, 	ihfco
				FLsetVal_i	1, 	ihlvl
				FLsetVal_i	0.005, 	ihQ
				FLsetVal_i	1, 	ihS
				FLsetVal_i	0, 	ihskip
				FLsetVal_i	0.4, 	ihamp
				FLsetVal_i	0, 	ihmode
				FLsetVal_i	200, 	ihSawFrq	

				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 480, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                            rbjeq                            ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"rbjeq is a filter and EQ opcode offering 7 different modes.  ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"It is based on an algorithm by Robert Bristow-Johnson, which ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"was subsequently written in Csound orchestra code by Josep M ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"Comajuncosas and converted into C and into an opcode by      ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"Istvan Varga.                                                ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"Two source signal inputs are offered in this example, either ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"a sound file or a sawtooth waveform.                         ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"'Gain' controls the amount of boost or cut that the filter   ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"applies. A value of 1 specifies no boost or cut. Values      ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"lower than 1 attenuate and values above 1 boost amplitude    ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"according to the filter or EQ mode selected. This parameter  ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"should not be zero.                                          ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"'Slope' defines the steepness of the filter at the cutoff    ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"frequency.                                                   ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"The function of 'Q' varies depending upon which filter or EQ ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"type has been selected: When 'lowpass' or 'highpass' is      ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"selected 'Q' controls resonance. When 'bandpass',            ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"'band-reject' or 'peaking EQ' is selected 'Q' controls       ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"bandwidth. When 'low shelf' or 'high shelf' is selected 'Q'  ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"is ignored.                                                  ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"The Csound Manual goes into greater detail about this opcode ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"and is recomended for further reading.                       ", 	1,      5,     14,    490,    15,     5, 460

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1
	if	gkOnOff=0	then	;IF On/Off SWITCH IS SET TO 'OFF'...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	kporttime	linseg	0,0.001,0.005,1,0.005	;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A SET VALUE	
	kfco	portk	gkfco,    kporttime	;SMOOTH MOVEMENT OF SLIDER VARIABLE	
	kSawFrq	portk	gkSawFrq, kporttime	;SMOOTH MOVEMENT OF SLIDER VARIABLE	
	if	gkOnOff==1	then		;IF ON/OFF RADIO SELECTER IS 'SOUND FILE' ...
		gasigL, gasigR	diskin2	"Seashore.wav",    1,       0,         1	;GENERATE 2 AUDIO SIGNALS FROM A STEREO SOUND FILE (NOTE THE USE OF GLOBAL VARIABLES)
	elseif	gkOnOff==2	then		;IF ON/OFF RADIO SELECTER IS 'SAWTOOTH' ...
		gasigL	vco2    1, kSawFrq		;SAWTOOTH WAVE
		gasigR	=	gasigL			;SET RIGHT CHANNEL THE SAME AS LEFT CHANNEL
	endif				;END OF CONDITIONAL BRANCHING
	kSwitch		changed	gkmode, gkskip	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	START			;BEGIN A REINITIALISATION PASS FROM LABEL 'START'
	endif
	START:
	imode		init	(i(gkmode) * 2) + i(gkskip)	;MODE PARAMETER IS A SUM OF 'FILTER MODE' TIMES 2, AND INITIALISATION SKIP VALUE
	;MODE VALUES ARE:	0=RESONANT LOWPASS
	;			2=RESONANT HIGHPASS
	;			4=BANDPASS
	;			6=BAND-REJECT
	;			8=PEAKING EQ
	;			10=LOW SHELF EQ
	;			12=HIGH SHELF EQ
			denorm	gasigL, gasigR					;ADD A SMALL AMOUNT OF NOISE TO AUDIO SIGNALS TO PREVENT SLOW DOWNS (ON INTEL PROCESSORS) IF ORIGINAL AUDIO SIGNAL IS SILENT 
	aresL 		rbjeq 	gasigL, kfco, gklvl, gkfco*gkQ, gkS, imode	;APPLY rbjeq TO BOTH CHANNELS OF AUDIO SIGNAL
	aresR 		rbjeq 	gasigR, kfco, gklvl, gkfco*gkQ, gkS, imode	;APPLY rbjeq TO BOTH CHANNELS OF AUDIO SIGNAL
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
			outs	aresL*gkamp, aresR*gkamp	;SEND FILTER OUTPUT TO THE AUDIO OUTPUTS AND MULTIPLY BY OUTPUT GAIN FLTK SLIDER VARIABLE
endin                                    
  	                                 
</CsInstruments>                         
                                         
<CsScore>                                
f 0 3600	;'DUMMY' SCORE EVENT - KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>                               
                                         
</CsoundSynthesizer>                     
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         
                                         














