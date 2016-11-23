BowedMode.csd
Written by Iain McCurdy, 2012

<CsoundSynthesizer>

<CsOptions>
-odac -+rtmidi=virtual -M0 -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	16	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	1
0dbfs		=	1
;insno	nstrnum	"MIDIBowedModes"
;massign	1,insno
;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL        | WIDTH | HEIGHT | X | Y
		FLpanel	"Bowed Mode",   500,    450,    0,  0


;COLOUR SCHEME DEFINED USING MACROS TO FACILITATE EASIER EDITING OF COLOURS
#define COLOUR1 #200,200,155#
#define COLOUR2 #155,200,200#

;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih1 		FLbox  	"",		6,      9,     15,    490,    230,    5,  5	;BOX AROUND IMPULSE CONTROLS
FLsetColor	$COLOUR1,ih1
ihImpulse 	FLbox 	"Impulse", 	1,      12,    18,    100,     15,   200, 10	;IMPULSE BOX LABEL
FLsetColor	$COLOUR1,ihImpulse                                      
ih2 		FLbox  	"",		6,      9,     15,    490,    200,    5, 240	;BOX AROUND MODE FILTERS CONTROLS
FLsetColor	$COLOUR2,ih2
ihModeFilters 	FLbox 	"Mode Filters", 1,      12,    18,    100,     15,   200,245	;MODE FILTERS BOX LABEL
FLsetColor	$COLOUR2,ihModeFilters                                      

insno	nstrnum	"UpdateLabel"	;DERIVE NUMBER OF NAMED INSTRUMENT
;COUNTERS					MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE
gksound, ihsound	FLcount  "Sound", 	1,     27,     1,      1,      2,   100,     25,   10,  285,    0,    insno, 0, 0	;LABELS ARE UPDATED BY INSTRUMENT 'UpdateLabel' EACH TIME THIS COUNTER IS CHANGED

;TEXT BOXES     			TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
gihSoundName FLbox "Tubular Bell", 	1,      1,     14,    100,     25,   10,  250	;SOUND LABEL BOX
FLsetColor	155,200,200,gihSoundName

;VALUE_DISPLAY_BOXES			WIDTH | HEIGHT | X | Y
idImpAmp		FLvalue	" ",      80,     20,   10,  60
idJitDep		FLvalue	" ",      80,     20,   10, 110
idJitRte		FLvalue	" ",      80,     20,   10, 160
idHPF			FLvalue	" ",      80,     20,   10, 211
idLPF			FLvalue	" ",      80,     20,  405, 211
idbase			FLvalue	" ",      80,     20,   10, 355
idQ			FLvalue	" ",      80,     20,   10, 405
                                                 
;SLIDERS							MIN  |  MAX  | EXP | TYPE |   DISP    | WIDTH | HEIGHT | X | Y
gkImpAmp, ihImpAmp	FLslider	"Impulse Amplitude",	0,     0.004,   0,    23,   idImpAmp,    480,     25,   10,  35
gkJitDep, ihJitDep	FLslider	"Jitter Amplitude",	0,         5,   0,    23,   idJitDep,    480,     25,   10,  85
gkJitRte, ihJitRte	FLslider	"Jitter Rate",		0.01,     20,   0,    23,   idJitRte,    480,     25,   10, 135
gkHPF, ihHPF		FLslider	"",			20,    20000,  -1,     1,   idHPF,       480,     13,   10, 185
gkLPF, ihLPF		FLslider	"HPF/LPF",		20,    20000,  -1,     1,   idLPF,       480,     13,   10, 198
gkbase, gihbase		FLslider	"Base Frequency",  	20,    20000,  -1,    23,   idbase,      480,     25,   10, 330
gkQ, gihQ		FLslider	"Q",   			50,    10000,  -1,    23,   idQ,         480,     25,   10, 380

;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	9, 	ihsound
		FLsetVal_i	0,   	ihImpAmp                                 
		FLsetVal_i	0.4,   	ihJitDep
		FLsetVal_i	3,   	ihJitRte
		FLsetVal_i	20,   	ihHPF
		FLsetVal_i	20000, 	ihLPF
		FLsetVal_i	437, 	gihbase
		FLsetVal_i	2000, 	gihQ
		FLpanel_end	; END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 780, 501, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                         Bowed Mode                          ", 	1,      6,     15,    490,    25,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"This example introduces another method of 'exciting' mode    ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"filters that creates an imitation of a resonant object being ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"bowed or rubbed. The excitation signal consists of a stack of", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"sine wave oscillators that match the number and frequencies  ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"of the mode filters being used. This arrangement can cause   ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"the mode filters to resonate with great intensity so the     ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"amplitudes of the sine wave oscillators should be kept low to", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"prevent overloading. Additionally the frequency of each      ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"sine wave oscillator is individually modulated using a random", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"'jitter' function created using 'gaussi' (interpolating      ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"gaussian noise generator). This technique results is a       ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"shifting spectral response from the filters. Adjusting the   ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"rate and amplitude of this jitter function can imitate a     ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"variety of bowing and rubbing techniques.                    ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"Selecting different 'Sound' presets will set base frequency  ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"and Q (quality/resonance) of the mode filters to appropriate ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"values for that instrument. If 'Q' is low then more of the   ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"character of the impulse sound (the sine wave oscillators)   ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"will be apparent (and therefore the jitter modulation will   ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"be more apparent). If 'Q' is higher then the character of the", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"mode filters will dominate and modulation of the impulse     ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"sound frequencies will become masked.                        ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"A key aspect of this instrument is that once the impulse     ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"sound is removed ('Impulse Amplitude' is brought to minimum) ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"the sound produced is solely the residual resonance of the   ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"mode filters, therefore any modulation within the sine wave  ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"oscillators becomes irrelevant.                              ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"This instrument can also be played from a MIDI keyboard in   ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"which case the 'Base Frequency' will be defined by the note  ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"played and the intensity of the impulse sound will be defined", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"by the note velocity and controller 1 (and not the 'Impulse  ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"Amplitude' slider). The amplitude attack time of the impulse ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"sound is also proportional to the note velocity. An          ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"improvement to this design would be that impulse amplitude be", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"controlled by polyphonic aftertouch ('polyaft' opcode) from  ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"the keyboard but I don't currently have access to a keyboard ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"with this capability and they are in fact rather rare.       ", 	1,      5,     14,    490,    20,     5, 760
				FLpanel_end                                                                                                       

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE--------------------------------------------------------------------------------------------------------------------------------------------------------------------





;FUNCTION TABLES STORING MODAL FREQUENCY RATIOS------------------------------------------------------------------------------------------------------------------------------------------------
;single
girtos1		ftgen	0,0,2, -2,	1,1

;dahina
girtos2		ftgen	0,0,-6,-2,	1,	2.89,	4.95,	6.99,	8.01,	9.02

;banyan
girtos3		ftgen	0,0,-6,-2,	1, 	2.0, 	3.01, 	4.01, 	4.69, 	5.63

;xylophone
girtos4		ftgen	0,0,-6,-2,	1, 	3.932, 	9.538,	16.688,	24.566,	31.147

;tibetan bowl (180mm)
girtos5		ftgen	0,0,-7,-2,	1, 	2.77828,	5.18099, 	8.16289,	11.66063,	15.63801,	19.99

;spinel sphere with diameter of 3.6675mm
girtos6		ftgen	0,0,-24,-2,	1,	1.026513174725,	1.4224916858532,	1.4478690202098,	1.4661959580455,	1.499452545408,	1.7891839345101,	1.8768994627782,	1.9645945254541,	1.9786543873113,	2.0334612432847,	2.1452852391916,	2.1561524686621,	2.2533435661294,	2.2905090816065,	2.3331798413917,	2.4567715528268,	2.4925556408289,	2.5661806088514,	2.6055768738808,	2.6692760296751,	2.7140956766436,	2.7543617293425,	2.7710411870043 

;pot lid
girtos7		ftgen	0,0,-6,-2,	1, 	3.2, 	6.23, 	6.27, 	9.92, 	14.15

;red cedar wood plate
girtos8		ftgen	0,0,-4,-2,	1, 	1.47, 	2.09, 	2.56

;tubular bell
girtos9		ftgen	0,0,-10,-2,	272/437,	538/437,	874/437,	1281/437,	1755/437,	2264/437,	2813/437,	3389/437,	4822/437,	5255/437

;redwood wood plate
girtos10	ftgen	0,0,-4,-2,	1, 1.47, 2.11, 2.57

;douglas fir wood plate
girtos11	ftgen	0,0,-4,-2,	1, 1.42, 2.11, 2.47

;uniform wooden bar
girtos12	ftgen	0,0,-6,-2,	1, 2.572, 4.644, 6.984, 9.723, 12

;uniform aluminum bar
girtos13	ftgen	0,0,-6,-2,	1, 2.756, 5.423, 8.988, 13.448, 18.680

;vibraphone 1
girtos14	ftgen	0,0,-6,-2,	1, 3.984, 10.668, 17.979, 23.679, 33.642

;vibraphone 2
girtos15	ftgen	0,0,-6,-2,	1, 3.997, 9.469, 15.566, 20.863, 29.440

;Chalandi plates
girtos16	ftgen	0,0,-5,-2,	1, 1.72581, 5.80645, 7.41935, 13.91935

;tibetan bowl (152 mm)
girtos17	ftgen	0,0,-7,-2,	1, 2.66242, 4.83757, 7.51592, 10.64012, 14.21019, 18.14027

;tibetan bowl (140 mm)
girtos18	ftgen	0,0,-5,-2,	1, 2.76515, 5.12121, 7.80681, 10.78409

;wine glass
girtos19	ftgen	0,0,-5,-2,	1, 2.32, 4.25, 6.63, 9.38

;small handbell
girtos20	ftgen	0,0,-22,-2,	1, 1.0019054878049, 1.7936737804878, 1.8009908536585, 2.5201981707317, 2.5224085365854, 2.9907012195122, 2.9940548780488, 3.7855182926829, 3.8061737804878, 4.5689024390244, 4.5754573170732, 5.0296493902439, 5.0455030487805, 6.0759908536585, 5.9094512195122, 6.4124237804878, 6.4430640243902, 7.0826219512195, 7.0923780487805, 7.3188262195122, 7.5551829268293 

;albert clock bell belfast
girtos21	ftgen	0,0,-22,-2, 2.043260,1.482916,1.000000,3.328848,4.761811,1.477056,0.612007,2.661295,1.002793,4.023776,0.254139,2.043916,4.032463,2.659438,4.775560,5.500494,3.331014,0.809697,2.391301, 0.254098,1.901476,2.366563    ;,0.614968,2.046543,1.814887,3.130744,2.484426,0.558874,0.801697,0.070870,3.617036,2.782656

;wood block
girtos22	ftgen	0,0,4,-2,	915/915,1540/915,1863/915,3112/915

;harmonic 10
girtos23	ftgen	0,0,-10,-2,	1,2,3,4,5,6,7,8,9,10

;harmonic 20
girtos24	ftgen	0,0,-20,-2,	1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20

;harmonic 30
girtos25	ftgen	0,0,-30,-2,	1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30

;harmonic odd 10
girtos26	ftgen	0,0,-10,-2,	1,3,5,7,9,11,13,15,17,19

;harmonic odd 20
girtos27	ftgen	0,0,-20,-2,	1,3,5,7,9,11,13,15,17,19,21,23,25,27,29,31,33,35,37,39

seed	0			;RANDOM NUMBER GENERATORS SEEDED FROM THE SYSTEM CLOCK
gasend	init	0		;INITIALISE THE GLOBAL AUDIO SEND VARIABLE
gisine	ftgen	0,0,4096,10,1	;A SINE WAVE

;initc7	1,1,1
;ctrlinit 1, 1, 127

giNoteActive	ftgen	0,0,128,2,0
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------







;--UDOS--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
opcode	SineVoice,a,kkkiiii
	kfreq,kjitdep,kjitrte,icount,invoices,irtos,isfn	xin
	amix	=	0						;INITIALISE AUDIO MIX VARIABLE (MIXTURE OF ALL SINE WAVE OSCILLATORS)
	a1	=	0						;
	kjit	gaussi	kjitdep, 1, kjitrte				;JITTER FUNCTION (SEMITONE DEVIATION)
	irto	table	icount,irtos					;READ THE FREQUENCY RATIO FOR THIS OSCILLATOR FROM THE APPROPRIATE RATIOS TABLE
	a1	oscili	1,semitone(kjit)*kfreq*irto,isfn		;CREATE THE OSCILLATOR
	icount	=	icount+1					;INCREMENT COUNTER
	if icount<invoices then						;IF NOT ALL REQUIRED OSCILLATORS HAVE BEEN CREATED YET... 
	 amix	SineVoice	kfreq,kjitdep,kjitrte,icount,invoices,irtos,isfn	;CALL THE UDO AGAIN, WITH THE INCREMENTED COUNTER
	endif
	xout	amix + a1						;SEND MIX OF ALL OSCILLATORS BACK THE THE UDO OUTPUT
endop

opcode	ModeVoice,a,akkiii						;MODE UDO (K-RATE BASE FREQUENCY) - USED FOR NON-MIDI MODE 
	ain,kfreq,kq,icount,inmodes,irtos  xin				;NAME INPUT VARIABLES
	amix	=	0						;INITIALISE AUDIO MIX VARIABLE (MIXTURE OF ALL MODE FILTERS)
	a1	=	0						;INITIALISE AUDIO FOR THE MODE FILTER IN THIS ITERATION OF THE UDO IONLY NEEDED INCASE 
	irto	table	icount,irtos					;READ FREQUENCY RATIO FOR CURRENT MODE ACCORDING TO ITERATION COUNTER
	kThisFreq	=	kfreq * irto				;DERIVE MODAL FREQUENCY FROM PRODUCT OF RATIO AND BASE FREQUENCY
	if sr/kThisFreq>=$M_PI then
	 a1	mode	ain, kThisFreq, kq				;CREATE MODE SIGNAL
	 icount	=	icount + 1					;INCREMENT COUNTER IN PREPARTION FOR NEXT MODE
	 if	icount < inmodes	then				;IF ALL THE MODES IN THIS CURRENT INSTRUMENT HAVE NOT YET BEEN CREATED...
	  amix	ModeVoice	ain, kfreq,kq, icount, inmodes,irtos	;...CALL modemodule UDO AGAIN WITH INCREMENTED COUNTER
	 endif								;END OF CONDITIONAL BRANCHING
	endif
	xout	amix+a1							;SEND ALL AUDIO BACK TO CALLER INSTRUMENT
endop									;END OF UDO
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------





;--INSTRUMENTS-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
instr	1	;MIDI TRIGGERED INSTRUMENT
	ibase	cpsmidi							;READ IN MIDI NOTE NUMBER AS A CPS VALUE
	ivel	ampmidi	1						;READ IN MIDI NOTE VELOCITY AS A VALUE WITHIN THE RANGE 0 TO 1
	inum	notnum							;READ IN MIDI NOTE NUMBER AS AN INTEGER (USED FOR CREATE A TABLE OF ACTIVE NOTES FLAGS)
	krelease	release						;NOTE RELEASE FLAG (0 = NOTE HELD, 1 = NOTE RELEASED)
		tablew	1-krelease,inum,giNoteActive			;WRITE NOTE RELEASE FLAG TO TABLE AT THE LOCATION CORRESPONDING TO NOTE NUMBER
	event_i	"i","BowedModesMIDI",0,3600,ibase,ivel,inum		;CALL 'BowedModesMIDI' INSTRUMENT WITH THE APPROPROPRIATE P-FIELDS
endin

instr	InitMIDI		;INITIALISE MIDI CONTROLLER (WORKAROUND FOR THE FACT THAT initc7 WON'T WORK PROPERLY IN THE HEADER WITH THE VIRTUAL MIDI DEVICE. THIS INSTRUMENT WILL NOT NEEDED WHEN HARDWARE MIDI IS USED.)
	initc7	1,1,1							;SET CONTROLLER '1' INITIALLY TO ITS MAXIMUM VALUE
endin

instr	BowedModesMIDI	;MIDI NOTE TRIGGERED BOWED MODES
	ktime		timeinsts					;TIME ELAPSED OF THIS NOTE. THIS IS USED TO PREVENT PREMATURE SWITCHING OF OF THE NOTE IN THE SUBSEQUENT CODE
	xtratim		0.1
	ibase		=	p4					;BASE FREQUENCY READ FROM p4
	ivel		=	p5					;NOTE VELOCITY
	inum		=	p6					;NOTE NUMBER
	kactive		table	p6,giNoteActive				;CHECK WHETHER THE MIDI KEY CORRESPONDING TO THIS NOTE IS BEING HELD OR HAS BEEN RELEASED (1 = HELD, 0 = RELEASED). THIS VALUE WILL BE USED TO CONTROL WHETHER THE IMPULSE SCOUND SHOULD BE ACTIVE OR NOT. 	
	icount		=	0					;COUNTER TO COUNT ITERATIONS FOR RECURSIVE UDOS FOR SINE OSCILLATORS AND MODE FILTERS (STARTS AT ZERO)
	irtos		=	girtos1 + i(gksound) - 1		;DERIVE ACTUAL FUNCTION TABLE NUMBER FOR RATIOS ACCORDING TO 'Sound' CHOSEN
	invoices	=	ftlen(irtos)				;DERIVE THE NUMBER OF VOICES NEEDED FOR THE 'Sound' CHOSEN
	kctrl1		ctrl7	1,1,0,1					;CONTROLLER 1 (MOD. WHEEL), MIDI CHANNEL 1, RANGE 0 TO 1
	kactive		port	kactive,0.05				;SMOOTH NOTE ACTIVE ON/OFF SWITCHING
	kenv		linseg	0,(1-ivel)+0.01,ivel			;CREATE AN AMPLITUDE ENVELOPE FOR THE IMPULSE SOUND. IMPULSE SOUND WILL BE VELOCITY SENSITIVE AND THE ATTACK TIME OF THIS ENVELOPE WILL BE PROPORTIONATE TO THE NOTE VELOCITY ALSO. 
	aSineMix	SineVoice	ibase,gkJitDep,gkJitRte,icount,invoices,irtos,gisine	;CALL SINE OSCILLATOR UDO (IT WILL BE RECURSIVELY RECALLED WITHIN THE UDO THE APPROPRIATE NUMBER OF TIMES ACCORDING TO invoices)
	aSineMix	=	aSineMix*0.002*kactive*kenv*kctrl1	;SCALE THE MIXTURE OF SINES AUDIO SIGNAL
	aSineMix	buthp	aSineMix,gkHPF
	aSineMix	butlp	aSineMix,gkLPF	 
	amodes		ModeVoice	aSineMix,ibase,gkQ,icount,invoices,irtos	;CALL SINE OSCILLATOR UDO (IT WILL BE RECURSIVELY RECALLED WITHIN THE UDO THE APPROPRIATE NUMBER OF TIMES ACCORDING TO invoices)
	amodes		=		amodes/(invoices*5)		;SCALE THE AMPLITUDE OF THE SOUND ACCORDING TO THE NUMBER OF MODES IN THE CHOSEN ALGORITHM
	krms		rms		amodes				;TRACK THE AMPLITUDE OF THE SOUND AS AN RMS VALUE
	if krms<0.001&&ktime>0.1 then					;
	 turnoff
	endif
			out	amodes		 			;SEND MODE FILTERS OUTPUT MIXTURE TO OUTPUT AND RESCALE ACCORDING TO THE NUMBER OF MODES USED
endin

instr	BowedModes
	ktrig	changed	gksound						;IF 'Sound' COUNTER IS CHANGED GENERATE A MOMENTARY '1' (OTHERWISE OUTPUT ZERO)
	if ktrig==1 then						;IF 'Sound' COUNTER HAS BEEN CHANGED...
	 reinit UPDATE							;BEGIN A REINIT PASS FORM LABEL 'UPDATE' (AND RESTART SINE WAVE OSCILLATORS AND MODE FILTERS ACCORDING TO THE NEW RATIOS TABLE)
	endif
	UPDATE:								;A LABEL. BEGIN REINIT. PASS FROM HERE
	icount	=	0						;COUNTER TO COUNT ITERATIONS FOR RECURSIVE UDOS FOR SINE OSCILLATORS AND MODE FILTERS (STARTS AT ZERO)
	irtos	=	girtos1 + i(gksound) - 1			;DERIVE ACTUAL FUNCTION TABLE NUMBER FOR RATIOS ACCORDING TO 'Sound' CHOSEN
	invoices	=	ftlen(irtos)				;DERIVE THE NUMBER OF VOICES NEEDED FOR THE 'Sound' CHOSEN
	aSineMix	SineVoice	gkbase,gkJitDep,gkJitRte,icount,invoices,irtos,gisine	;CALL SINE OSCILLATOR UDO (IT WILL BE RECURSIVELY RECALLED WITHIN THE UDO THE APPROPRIATE NUMBER OF TIMES ACCORDING TO invoices)
	aSineMix	=	aSineMix*gkImpAmp			;SCALE THE MIXTURE OF SINES AUDIO SIGNAL BY THE VALUE FROM FLTK SLIDER
	aSineMix	buthp	aSineMix,gkHPF
	aSineMix	butlp	aSineMix,gkLPF	 
	amodes		ModeVoice	aSineMix,gkbase,gkQ,icount,invoices,irtos	;CALL SINE OSCILLATOR UDO (IT WILL BE RECURSIVELY RECALLED WITHIN THE UDO THE APPROPRIATE NUMBER OF TIMES ACCORDING TO invoices)
			out	amodes/invoices	 			;SEND MODE FILTERS OUTPUT MIXTURE TO OUTPUT AND RESCALE ACCORDING TO THE NUMBER OF MODES USED
	rireturn
endin


instr	UpdateLabel
	if	i(gksound)==1	then					;IF 'Sound' COUNTER IS '1'...
		FLsetText "                             ", gihSoundName	;ERASE CURRENT LABEL (NEEDED ON SOME OPERATING SYSTEMS)	
		FLsetText "Single", gihSoundName			;NEW LABEL	
		FLsetVal_i	330, gihbase				;SET APPROPRIATE BASE FREQUENCY
		FLsetVal_i	1000, gihQ				;SET APPROPRIATE Q (QUALITY/RESONANCE)
	elseif	i(gksound)==2	then
		FLsetText "                             ", gihSoundName
		FLsetText "Dahina", gihSoundName
		FLsetVal_i	150, gihbase
		FLsetVal_i	50, gihQ
	elseif	i(gksound)==3	then
		FLsetText "                             ", gihSoundName	
		FLsetText "Banyan", gihSoundName
		FLsetVal_i	350, gihbase
		FLsetVal_i	444, gihQ
	elseif	i(gksound)==4	then
		FLsetText "                             ", gihSoundName
		FLsetText "Xylophone", gihSoundName
		FLsetVal_i	160, gihbase
		FLsetVal_i	200, gihQ
	elseif	i(gksound)==5	then
		FLsetText "                             ", gihSoundName	
		FLsetText "Tibetan Bowl (180mm)", gihSoundName
		FLsetVal_i	221, gihbase
		FLsetVal_i	2200, gihQ
	elseif	i(gksound)==6	then
		FLsetText "                             ", gihSoundName
		FLsetText "Spinel Sphere", gihSoundName
		FLsetVal_i	997.25, gihbase
		FLsetVal_i	80, gihQ
	elseif	i(gksound)==7	then
		FLsetText "                             ", gihSoundName	
		FLsetText "Pot Lid", gihSoundName
		FLsetVal_i	250, gihbase
		FLsetVal_i	1500, gihQ
	elseif	i(gksound)==8	then
		FLsetText "                             ", gihSoundName
		FLsetText "Red Cedar Wood Plate", gihSoundName
		FLsetVal_i	700, gihbase
		FLsetVal_i	100, gihQ
	elseif	i(gksound)==9	then
		FLsetText "                             ", gihSoundName
		FLsetText "Tubular Bell", gihSoundName
		FLsetVal_i	437, gihbase
		FLsetVal_i	2000, gihQ
	elseif	i(gksound)==10	then
		FLsetText "                             ", gihSoundName	
		FLsetText "Redwood Wood Plate", gihSoundName
		FLsetVal_i	1000, gihbase
		FLsetVal_i	100, gihQ
	elseif	i(gksound)==11	then
		FLsetText "                             ", gihSoundName	
		FLsetText "Douglas Fir Wood Plate", gihSoundName
		FLsetVal_i	1200, gihbase
		FLsetVal_i	150, gihQ
	elseif	i(gksound)==12	then
		FLsetText "                             ", gihSoundName	
		FLsetText "Uniform Wooden Bar", gihSoundName
		FLsetVal_i	700, gihbase
		FLsetVal_i	300, gihQ
	elseif	i(gksound)==13	then
		FLsetText "                             ", gihSoundName
		FLsetText "Uniform Aluminium Bar", gihSoundName
		FLsetVal_i	327, gihbase
		FLsetVal_i	1000, gihQ
	elseif	i(gksound)==14	then
		FLsetText "                             ", gihSoundName
		FLsetText "Vibraphone 1", gihSoundName
		FLsetVal_i	440, gihbase
		FLsetVal_i	2000, gihQ
	elseif	i(gksound)==15	then
		FLsetText "                             ", gihSoundName
		FLsetText "Vibraphone 2", gihSoundName
		FLsetVal_i	440, gihbase
		FLsetVal_i	2000, gihQ
	elseif	i(gksound)==16	then
		FLsetText "                             ", gihSoundName
		FLsetText "Chalandi Plates", gihSoundName
		FLsetVal_i	62, gihbase
		FLsetVal_i	500, gihQ
	elseif	i(gksound)==17	then
		FLsetText "                             ", gihSoundName
		FLsetText "Tibetan Bowl (152mm)", gihSoundName
		FLsetVal_i	314, gihbase
		FLsetVal_i	2200, gihQ
	elseif	i(gksound)==18	then
		FLsetText "                             ", gihSoundName	
		FLsetText "Tibetan Bowl (140mm)", gihSoundName
		FLsetVal_i	528, gihbase
		FLsetVal_i	2200, gihQ
	elseif	i(gksound)==19	then
		FLsetText "                             ", gihSoundName
		FLsetText "Wine Glass", gihSoundName
		FLsetVal_i	980, gihbase
		FLsetVal_i	1500, gihQ
	elseif	i(gksound)==20	then
		FLsetText "                             ", gihSoundName
		FLsetText "Small Hand Bell", gihSoundName
		FLsetVal_i	1312, gihbase
		FLsetVal_i	2500, gihQ
	elseif	i(gksound)==21	then
		FLsetText "                             ", gihSoundName	
		FLsetText "Albert Clock Bell", gihSoundName
		FLsetVal_i	570, gihbase
		FLsetVal_i	2400, gihQ
	elseif	i(gksound)==22	then
		FLsetText "                             ", gihSoundName	
		FLsetText "Wood Block", gihSoundName
		FLsetVal_i	915, gihbase
		FLsetVal_i	60, gihQ
	elseif	i(gksound)==23	then
		FLsetText "                             ", gihSoundName	
		FLsetText "Harmonic 10", gihSoundName
		FLsetVal_i	200, gihbase
		FLsetVal_i	600, gihQ
	elseif	i(gksound)==24	then
		FLsetText "                             ", gihSoundName	
		FLsetText "Harmonic 20", gihSoundName
		FLsetVal_i	200, gihbase
		FLsetVal_i	600, gihQ
	elseif	i(gksound)==25	then
		FLsetText "                             ", gihSoundName	
		FLsetText "Harmonic 30", gihSoundName
		FLsetVal_i	200, gihbase
		FLsetVal_i	600, gihQ
	elseif	i(gksound)==26	then
		FLsetText "                             ", gihSoundName	
		FLsetText "Harmonic Odd 10", gihSoundName
		FLsetVal_i	200, gihbase
		FLsetVal_i	600, gihQ
	elseif	i(gksound)==27	then
		FLsetText "                             ", gihSoundName	
		FLsetText "Harmonic Odd 20", gihSoundName
		FLsetVal_i	200, gihbase
		FLsetVal_i	600, gihQ
	endif
endin
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------






</CsInstruments>

<CsScore>
i "InitMIDI" 0.1 0		;INITIALISE MIDI CONTROLLER *SHORTLY AFTER* PERFORMANCE BEGINS
i "BowedModes" 0 3600
i "UpdateLabel" 0 0
e
</CsScore>

</CsoundSynthesizer>

