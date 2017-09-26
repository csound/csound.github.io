oscbnk.csd
Written by Iain McCurdy, 2011.

<CsoundSynthesizer>

<CsOptions>
;virtual midi
-odac -M0 -+rtmidi=virtual -dm0

;hardware midi
;-odac -Ma -dm0
</CsOptions>

<CsInstruments>

sr	=	44100
ksmps	=	64
nchnls	=	2
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 250, 250, 50
;	LABEL      | WIDTH | HEIGHT | X | Y
FLpanel	"oscbnk",     500,    760,    0,  0

;BUTTONS                       					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"On(FLTK) / Off(MIDI)",	1,    0,    22,    200,     30,    5,  5,    0,      1,      0,       -1      

gkopt1,ihopt1		FLbutton	"LFO1 to Frequency",	128,   0,    22,    120,     50,   10,650,    -1      
gkopt2,ihopt2		FLbutton	"LFO1 to Amplitude",	64,    0,    22,    120,     50,  130,650,    -1      
gkopt3,ihopt3		FLbutton	"LFO1 to Phase",	32,    0,    22,    120,     50,  250,650,    -1      
gkopt4,ihopt4		FLbutton	"LFO1 to EQ",		16,    0,    22,    120,     50,  370,650,    -1      
gkopt5,ihopt5		FLbutton	"LFO2 to Frequency",	8,     0,    22,    120,     50,   10,700,    -1      
gkopt6,ihopt6		FLbutton	"LFO2 to Amplitude",	4,     0,    22,    120,     50,  130,700,    -1      
gkopt7,ihopt7		FLbutton	"LFO2 to Phase",	2,     0,    22,    120,     50,  250,700,    -1      
gkopt8,ihopt8		FLbutton	"LFO2 to EQ",		1,     0,    22,    120,     50,  370,700,    -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)
;				FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkmono_stereo, ihmono_stereo	FLbutBank	1,      2,     1,     80,      15,    5, 40,    -1; 0,     2,    0, 3600
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN
;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"MONO", 	1,      1,     10,     40,     15,    5,  55
ih		 	FLbox  	"STEREO", 	1,      1,     10,     40,     15,   45,  55

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X   | Y | OPCODE
gkovrlaps, ihovrlaps 		FLcount  "Number of Oscillators", 	1,   1000,    1,     10,      1,    140,     25,   230,    5,   -1
gkwaveform,ihwaveform 		FLcount  "Waveform:", 			1,     10,    1,     10,      2,    100,     25,   390,    5,    -1;0,   3,0,0
gkEQmode,ihEQmode 		FLcount  "EQ Mode:", 			-1,     5,    1,     10,      2,    100,     25,    50,  420,    -1;0,   2,0,0
;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
gihEQmodeLabel		 	FLbox  	"disable", 	1,      1,     14,    200,    20,     0,  460
gihWaveformLabel		FLbox  	"sawtooth", 	1,      1,     14,    100,    20,   390,   45

;VALUE DISPLAY BOXES		WIDTH | HEIGHT | X |  Y
idgain		FLvalue	" ",    50,       17,    5,   95
idfreq		FLvalue	" ",    50,       17,    5,  145                                                 
idfmd		FLvalue	" ",    50,       17,    5,  195
idamd		FLvalue	" ",    50,       17,    5,  245
idpmd		FLvalue	" ",    50,       17,    5,  295
idl1minf	FLvalue	" ",    50,       17,    5,  350
idl1maxf	FLvalue	" ",    50,       17,  445,  350
idl2minf	FLvalue	" ",    50,       17,    5,  400
idl2maxf	FLvalue	" ",    50,       17,  445,  400
idEQminf	FLvalue	" ",    50,       17,    5,  520
idEQmaxf	FLvalue	" ",    50,       17,  445,  520
idEQminl	FLvalue	" ",    50,       17,    5,  570
idEQmaxl	FLvalue	" ",    50,       17,  445,  570
idEQminq	FLvalue	" ",    50,       17,    5,  620
idEQmaxq	FLvalue	" ",    50,       17,  445,  620                                                    
                                                                                       
;SLIDERS								MIN  | MAX | EXP | TYPE |   DISP    | WIDTH | HEIGHT | X | Y
gkgain, ihgain		FLslider 	"Output Gain",			0,       1,   0,    23,   idgain,      490,     25,    5,  70
gkfreq, ihfreq		FLslider 	"Base Frequency (FLTK)",	20,   4000,  -1,    23,   idfreq,      490,     25,    5, 120
gkfmd, ihfmd		FLslider 	"Frequency Modulation Depth",	0,     0.1,   0,    23,    idfmd,      490,     25,    5, 170
gkamd, ihamd		FLslider 	"Amplitude Modulation Depth",	0,       1,   0,    23,    idamd,      490,     25,    5, 220
gkpmd, ihpmd		FLslider 	"Phase Modulation Depth",	0,       1,   0,    23,    idpmd,      490,     25,    5, 270
gkl1minf, ihl1minf	FLslider 	"",				0,      50,   0,    23, idl1minf,      490,     15,    5, 320
gkl1maxf, ihl1maxf	FLslider 	"LFO 1 Freq.",			0,      50,   0,    23, idl1maxf,      490,     15,    5, 335
gkl2minf, ihl2minf	FLslider 	"",				0,      50,   0,    23, idl2minf,      490,     15,    5, 370
gkl2maxf, ihl2maxf	FLslider 	"LFO 2 Freq.",			0,      50,   0,    23, idl2maxf,      490,     15,    5, 385
gkEQminf, ihEQminf	FLslider 	"",				1,    sr/2,  -1,    23, idEQminf,      490,     15,    5, 490
gkEQmaxf, ihEQmaxf	FLslider 	"EQ Min/Max Freq.",		1,    sr/2,  -1,    23, idEQmaxf,      490,     15,    5, 505
gkEQminl, ihEQminl	FLslider 	"",				0,       1,   0,    23, idEQminl,      490,     15,    5, 540
gkEQmaxl, ihEQmaxl	FLslider 	"EQ Min/Max Level",		0,       1,   0,    23, idEQmaxl,      490,     15,    5, 555
gkEQminq, ihEQminq	FLslider 	"",				0,      10,   0,    23, idEQminq,      490,     15,    5, 590
gkEQmaxq, ihEQmaxq	FLslider 	"EQ Min/Max Q",			0,      10,   0,    23, idEQmaxq,      490,     15,    5, 605

;SET VALUATORS TO INITIAL VALUES
		FLsetVal_i	1, 	ihgain
		FLsetVal_i	100, 	ihfreq
		FLsetVal_i	10, 	ihovrlaps
		FLsetVal_i	0.0073, ihfmd
		FLsetVal_i	0.1, 	ihamd
		FLsetVal_i	0.03, 	ihpmd
		FLsetVal_i	1, 	ihl1minf
		FLsetVal_i	5, 	ihl1maxf                                  
		FLsetVal_i	0.5, 	ihl2minf
		FLsetVal_i	6.7, 	ihl2maxf
		FLsetVal_i	-1, 	ihEQmode
		FLsetVal_i	0, 	ihEQminf                                               
		FLsetVal_i	8000, 	ihEQmaxf
		FLsetVal_i	1, 	ihEQminl
		FLsetVal_i	1, 	ihEQmaxl
		FLsetVal_i	1, 	ihEQminq
		FLsetVal_i	1, 	ihEQmaxq
		FLsetVal_i	1, 	ihwaveform
		FLsetVal_i	128,	ihopt1
		FLsetVal_i	64,	ihopt2
		FLsetVal_i	32,	ihopt3
		FLsetVal_i	8,	ihopt5
		FLsetVal_i	4,	ihopt6
		FLsetVal_i	2,	ihopt7
		FLsetVal_i	1,	ihmono_stereo

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL          
				FLpanel	" ", 515, 620, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                            oscbnk                           ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"WARNING: THE PARAMETRIC EQ WITHIN THIS OPCODE SEEMS RATHER   ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"UNSTABLE. I WOULD RECOMMEND NOT USING THIS FEATURE, I.E.     ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"LEAVING EQ MODE AT -1.                                       ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"'oscbnk' is intended for creating rich tones with a lot of   ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"internal modulation by mixing together a user-defined number ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"of basic oscillators.                                        ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"Each oscillator has its own multi-mode parameteric EQ which  ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"can be either peaking, low shelving or high shelving. EQ mode", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"is set globally for all oscillators.                         ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"Each oscillator has two LFOs of its own and these LFOs can be", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"mapped to the frequency, amplitude, phase and EQ of that     ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"oscillator according to a patching structure defined by the  ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"user. The patching LFO structure is set globally for all     ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"oscillators.                                                 ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"The opcode asks for 'Frequency Modulation Depth' to be       ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"defined in hertz but in this example which can be played as a", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"MIDI synth it seemed to make more sense for this to relate to", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"the basic pitch of the cluster, that way low and high notes  ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"would sound equally pitch modulated. My slider for this      ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"parameter defines a fraction of an octave about the base     ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"frequency for modulation depth.                              ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"The waveform for the oscillators can be any function table   ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"supplied by the user. I have supplied ten example waveforms. ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"The wave shape adopted by the LFOs can also be any function  ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"table, in this example I have supplied a cosine wave for both", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"LFOs just for simplicity.                                    ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"As mentioned at the top the parametric EQ feature of this    ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"opcode seems rather unusable. If you find a way of using this", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"successfully please let me know!                             ", 	1,      5,     14,    490,    20,     5, 600
				FLpanel_end

	FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	tables
gisaw		ftgenonce	0,0,4096,11,80,1,0.9
gisquare	ftgenonce	0,0,4096,10, 1,0, 1/3,0, 1/5,0, 1/7,0, 1/9,0, 1/11,0, 1/13,0, 1/15,0, 1/17,0, 1/19,0, 1/21,0, 1/23,0, 1/25,0, 1/27,0, 1/29,0, 1/31,0, 1/33,0, 1/35,0, 1/37,0, 1/39
giahh		ftgenonce	0, 0, 4096, 10, 1, 0.615880,0.089582,0.201498,0.202694,0.249961,0.225852,0.199864,0.029378,0.012306,0.007803,0.007846,0.007454,0.008827,0.007466,0.007495,0.007979,0.017837,0.061000,0.059055,0.039181,0.038364,0.032715,0.048415,0.029643,0.010094
giorg		ftgenonce	0,0,4096,9, 1,1,rnd(1), 2,1/2,rnd(1), 4,1/4,rnd(1), 8,1/8,rnd(1), 16,1/16,rnd(1), 32,1/32,rnd(1), 64,1/64,rnd(1), 128,1/128,rnd(1)
gitromb		ftgenonce	0,0,4096,10,0.104682,0.077444,0.175816,0.178469,0.192922,0.167695,0.127283,0.094343,0.073856,0.045425,0.030985,0.027993,0.019936,0.013950,0.010611,0.007164,0.006458,0.003987,0.002664,0.002030,0.001435,0.001274,0.001036,0.000975,0.000876
;gitrpt		ftgenonce	0,0,4096,10,0.346469,0.852732,0.693941,0.494616,0.677656,0.590592,0.441108,0.626951,0.588338,0.416046,0.198161,0.107710,0.085130,0.075318,0.052485,0.050367,0.041515,0.039286,0.027532,0.023320,0.016384,0.012677,0.009971,0.006867,0.004900
gibassoon	ftgenonce	0,0,4096,10, 0.130954,0.157859,0.302897,0.190190,0.890855,0.427124,0.039988,0.105341,0.011869,0.102000,0.115308,0.039058,0.131398,0.081308,0.047672,0.026006,0.010927,0.034420,0.033017,0.014769,0.014178,0.023091,0.023960,0.013178,0.004946
gioboe		ftgenonce	0,0,4096,10, 0.258272,0.920123,0.458442,0.445704,0.088446,0.177257,0.063786,0.140382,0.031660,0.021808,0.048812,0.007823,0.004163,0.004775,0.002608,0.001464,0.001702,0.004168,0.003318,0.003878,0.002319,0.002505,0.002480,0.003416,0.002453
giclarinet	ftgenonce	0,0,4096,10, 0.820044,0.009787,0.242206,0.034475,0.058957,0.021330,0.028307,0.053692,0.006131,0.002513,0.002370,0.001698,0.001269,0.000933,0.002758,0.001387,0.000831,0.000953,0.000658,0.000892,0.000687,0.000479,0.000481,0.000310,0.000425
gieee 		ftgenonce 	0,0,4096,10, 0.430487,0.778043,0.090552,0.011467,0.030632,0.017911,0.006520,0.006820,0.007109,0.006437,0.008527,0.009083,0.016774,0.058922,0.070507,0.116728,0.045479,0.060107,0.069023,0.036487,0.047350,0.049526,0.036678,0.022550,0.022550
giooh 		ftgenonce 	0,0,4096,10, 0.110941,0.606890,0.046168,0.040510,0.031310,0.007323,0.003115,0.002749,0.002420,0.002253,0.002853,0.002337,0.002672,0.002061,0.002202,0.002410,0.002615,0.005079,0.003192,0.002699,0.003708,0.003501,0.002264,0.001713,0.001713
gicos		ftgenonce	0,0,4096,11,1		;COSINE WAVE (USED BY THE LFOS)
gieqffn		ftgenonce	0,0,4097,7,-1,4096,1
gieqlfn		ftgenonce	0,0,4097,7,-1,4096,1
gieqqfn		ftgenonce	0,0,4097,7,-1,4096,1
endin

instr 1
	iMIDIActiveValue	=	1		;IF MIDI ACTIVATED
	iMIDIflag		=	0		;IF FLTK ACTIVATED
	mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 

	kporttime	linseg	0,0.01,0.01
	
	
	;------------------------------------------------------------------------------------------------------------
	;IF MIDI ACTIVATED...
	;------------------------------------------------------------------------------------------------------------
	if iMIDIflag==1 then					
	  icps	cpsmidi						;READ IN MIDI NOTE DATA
	  
	  kbend		pchbend	0,2				;READ IN PITCH BEND (RANGE -1 TO 1)
	  ibendrange	=	2				;PITCH BEND RANGE (IN SEMITONES)
	  kbend		portk	kbend*ibendrange,kporttime	;RESCALE PITCH BEND AND SMOOTH WITH PORTAMENTO
	  
	  kvibdep		ctrl7	1,1,0,1			;READ IN CONTROLLER 1 MIDI CHANNEL 1
	  kvib		lfo	kvibdep,5.5,0			;CREATE AN LFO SINE WAVE DEPTH DEFINED BY CONTROLLR 1
	  
	  kcps	=	icps*semitone(kbend+kvib)		;DEFINE BASIC FREQUENCY OF OSCILLATOR. FACTOR IN PITCH BEND AND VIBRATO MODULATION
	  
	  ivel	veloc	0,0.1					;READ IN NOTE VELOCITY
	
	  
	  
	;------------------------------------------------------------------------------------------------------------
	;OTHERWISE ASSUME AN FLTK TRIGGERED NOTE...
	;------------------------------------------------------------------------------------------------------------
	else
	  kcps	portk	gkfreq,kporttime			;BASIC PITCH COMES SOLELY FROM BASIC FREQUENCY SLIDER
	  ivel	=	0.04					;DEFINE NOTE VELOCITY AS A STATIC VALUE
	  if gkOnOff=0 then					;OF FLTK SWITCH IS OFF...
	    turnoff						;TURN THIS INSTRUMENT OFF
	  endif							;
	endif
	
	kwave	=	gisaw+gkwaveform-1			;DERIVE FUNCTION TABLE NUMBER OF WAVEFORM FOR THE OSCILLATORS

	ktrig	changed	gkovrlaps,gkEQmode,gkopt1,gkopt2,gkopt3,gkopt4,gkopt5,gkopt6,gkopt7,gkopt8	;IF ANY OF THE CONTROLS WHICH MUST BE ENTERED AS I-RATE CONTROLLERS HAVE CHANGED GEENRATE A TRIGGER IMPULSE AT THE OUTPUT
	if ktrig==1 then					;IF ANY I-RATE CONTROL HAS CHANGED...
	  reinit	UPDATE					;BEGIN A REINITILISATION PASS FROM LABEL 'UPDATE'
	endif							
	UPDATE:							;BEGIN REINIT PASS FROM HERE
	iLFOmode	init	i(gkopt1)+i(gkopt2)+i(gkopt3)+i(gkopt4)+i(gkopt5)+i(gkopt6)+i(gkopt7)+i(gkopt8)	;LFO MODE IS THE SUM OF THE OUTPUT VALUES OF ALL THE SWITCHES

	
	;TWO ITERATIONS OF oscbnk ARE CREATED, ONE FOR EACH OF THE STEREO AUDIO CHANNELS. THE OUTPUTS WILL BE DIFFERENT AS THE RANDOM NUMBER GENERATORS WILL BE SEEDED BY THE SYSTEM CLOCK
	;OUTPUT	OPCODE  CPS  | AMD  |    FMD     | PMD |    OVRLAP     | SEED | L1MINF  | L1MAXF  | L2MINF  | L2MAXF  | LFOMODE | EQMINF  | EQMAXF | EQMINL | EQMAXL | EQMINQ | EQMAXQ  |  EQMODE   | KFN  |   L1FN  | L2FN | EQFFN  | EQLF   |  EQQFN |  TABL  | OUTFN
	aL	oscbnk	kcps, gkamd, gkfmd*kcps, gkpmd,  i(gkovrlaps),   0,   gkl1minf, gkl1maxf, gkl2minf, gkl2maxf, iLFOmode,  gkEQminf, gkEQmaxf,gkEQminl,gkEQmaxl,gkEQminq,gkEQmaxq, i(gkEQmode), kwave,  gicos,  gicos, gieqffn, gieqlfn, gieqqfn
	if gkmono_stereo=1 then
	  aR	oscbnk	kcps, gkamd, gkfmd*kcps, gkpmd,  i(gkovrlaps),   0,   gkl1minf, gkl1maxf, gkl2minf, gkl2maxf, iLFOmode,  gkEQminf, gkEQmaxf,gkEQminl,gkEQmaxl,gkEQminq,gkEQmaxq, i(gkEQmode), kwave,  gicos,  gicos, gieqffn, gieqlfn, gieqqfn
	else
	  aR	=	aL
	endif
	rireturn						;RETURN FROM REINIT PASS
	
	aenv	linsegr	0,0.01,1,0.1,0				;CREATE A BASIC GATE ENVELOPE WITH SMOOTH ATTACK AND RELEASE TO PREVENT CLICKS
		outs	aL*aenv*ivel*gkgain, aR*aenv*ivel*gkgain	;SEND AUDIO TO THE OUTPUTS. RESCALE EACH CHANNLE WITH NOTE VELOCITY, AMPLITUDE ENVELOPE AND FLTK OUTPUT GAIN CONTROL.
endin

instr	2	;UPDATE EQ MODE LABEL (TRIGGERED BY CHANGES MADE TO THE EQ MODE COUNTER)
	;CHANGE TEXT BOX LABEL INDICATING EQ MODE ACCORDING TO THE VALUE OF THE FL COUNTER                                          
	iEQmode	=	i(gkEQmode)
	if iEQmode=-1 then
	  Slabel	=	"disable"
	elseif iEQmode=0 then
	  Slabel	=	"peak"
	elseif iEQmode=1 then
	  Slabel	=	"low shelf"
	elseif iEQmode=2 then
	  Slabel	=	"high shelf"
	elseif iEQmode=3 then
	  Slabel	=	"peak (no interp.)"
	elseif iEQmode=4 then
	  Slabel	=	"low shelf (no interp.)"
	elseif iEQmode=5 then
	  Slabel	=	"high shelf (no interp.)"
	endif
	FLhide		gihEQmodeLabel				;HIDE LABEL BOX
	FLsetText	Slabel,gihEQmodeLabel			;CHANGE LABEL BOX
	FLshow		gihEQmodeLabel				;SHOW LABEL BOX
endin

instr	3	;UPDATE WAVEFORM LABEL (TRIGGERED BY CHANGES MADE TO THE EQ MODE COUNTER)
	ktrig	changed	gkwaveform
	if ktrig==1 then
	 reinit UPDATE
	endif
	UPDATE:
	;CHANGE TEXT BOX LABEL INDICATING EQ MODE ACCORDING TO THE VALUE OF THE FL COUNTER
	iwaveform	=	i(gkwaveform)
	if iwaveform=1 then
	  Slabel	=	"sawtooth"
	elseif iwaveform=2 then
	  Slabel	=	"square"
	elseif iwaveform=3 then
	  Slabel	=	"ahh"
	elseif iwaveform=4 then
	  Slabel	=	"organ"
	elseif iwaveform=5 then
	  Slabel	=	"trombone"
	elseif iwaveform=6 then  
	  Slabel	=	"bassoon"
	elseif iwaveform=7 then  
	  Slabel	=	"oboe"
	elseif iwaveform=8 then
	  Slabel	=	"clarinet"
	elseif iwaveform=9 then
	  Slabel	=	"eee"
	elseif iwaveform=10 then
	  Slabel	=	"ooh"
	endif
	FLhide		gihWaveformLabel			;HIDE LABEL BOX
	FLsetText	Slabel,gihWaveformLabel			;CHANGE LABEL BOX
	FLshow		gihWaveformLabel			;SHOW LABEL BOX
endin

</CsInstruments>

<CsScore>
i "tables" 0 3600
i 3 0 3600
f 0 3600	;DUMMY SCORE EVENT
e
</CsScore>

</CsoundSynthesizer>


