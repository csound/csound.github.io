;Written by Iain McCurdy, 2006

;DEMONSTRATION OF THE wgflute OPCODE WHICH IS BASED ON PERRY COOK'S PHYSICAL MODEL OF A FLUTE

;THIS OPCODE OFFERS A LOT OF INPUT PARAMETERS

;kamp - AMPLITUDE

;kfreq - THE FUNDEMENTAL OF THE TONE PRODUCED

;KJET - A PARAMETER CONTROLLING THE AIR JET. VALUES SHOULD BE POSITIVE, AND ABOUT 0.3. THE USEFUL RANGE IS APPROXIMATELY 0.08 TO 0.56
;LOW SETTINGS FOR KJET FORCE OVERTONES FROM THE INSTRUMENT
;THIS IS PROBABLY THE MOST INSTERESTING PARAMETER IN THIS OPCODE

;iatt/idek - ATTACK AND DECAY TIMES APPARENTLY BUT THEY DON'T SEEM TO DO ANYTHING AT ALL AS FAR AS I CAN SEE!

;kngain - AMPLITUDE OF BREATH/WIND NOISE. THE FLUTE SOUND CONSISTS OF 2 MAIN ELEMENTS:
;	THE RESONANT TONE AND THE BREATH NOISE. 
;	THIS PARAMETER CONTROLS THE STRENGTH OF THE BREATH/WIND NOISE.
;	A USEFUL RANGE FOR THIS IS ABOUT 0-1
;	0=NO BREATH NOISE, 1=BREATH NOISE ONLY

;kvibf/kvibamp - THIS OPCODE IMPLEMENTS VIBRATO THAT GOES BEYOND JUST FREQUENCY MODULATION AND INCLUDES MODULATION 
;	-UPON SEVERAL OTHER ASPECTS OF THE SOUND INCLUDING AMPLITUDE MODULATION
;	A USEFUL RANGE FOR kvibamp (AMPLITUDE OF VIBRATO) IS 0-.25 WHERE 0=NO VIBRATO AND .25=A LOT OF VIBRATO
;	kvibf IS USED TO CONTROL VIBRATO FREQUENCY, A NATURAL VIBRATO FREQUENCY IS ABOUT 5 HZ

;ifn - A FUNCTION TABLE WAVEFORM MUST BE GIVEN TO DEFINE THE SHAPE OF THE VIBRATO, 
;	-THIS SHOULD NORMALLY BE A SINE WAVE.

;THE OPCODE OFFERS 3 FURTHER *OPTIONAL* PARAMETERS:

;iminfreq - A MINIMUM FREQUENCY SETTING GIVEN TO THE ALGORITHM
;	- TYPICALLY THIS IS SET TO A VALUE BELOW THE FREQUENCY SETTING GIVEN BY kfreq
;	- IF kfreq GOES BELOW iminfreq IS CAN HAVE A STRANGE EFFECT ON THE SOUND AND THE SETTING FOR kfreq NO LONGER 
;	-REFLECTS THE PITCH THAT IS ACTUALLY HEARD.

;ijetrf - AMOUNT OF REFLECTION OF THE BREATH JET. I.E. RESISTANCE OF THE AIR COLUMN ON THE FLUTE (I-RATE ONLY)

;iendrf - BREATH JET REFLECTION COEFFICIENT (I-RATE ONLY) THIS CONTROLS HOW THE BREATH JET INTERACTS WITH THE RESONANT SOUND
;	- 0=BREATH JET DOMINATES 1=RESONANCE DOMINATES

<CsoundSynthesizer>

<CsOptions>
-odac -dm0 -M0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE
		seed	0
		
;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS

;			LABEL   | WIDTH | HEIGHT | X | Y
		FLpanel	"wgflute",1000,    800,    0,  0

;BUTTONS                              						ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff			FLbutton	"On (FLTK) / Off (MIDI) ",	1,    0,    22,    190,     25,    5,  5,    0,      2,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		; SET SECONDARY COLOUR TO YELLOW
gkMonoStereo,ihMonoStereo	FLbutton	"Mono / Stereo",		1,    0,    22,    120,     25,  375,  5,    0,      2,      0,      -1
FLsetColor2	255, 255, 50, ihMonoStereo	; SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES	LABEL  | WIDTH | HEIGHT | X |  Y
idamp		FLvalue	" ",      100,    18,     5,   75
idfreq		FLvalue	" ",      100,    18,     5,  125
idjet		FLvalue	" ",      100,    18,     5,  175
idatt		FLvalue	" ",      100,    18,     5,  225
iddek		FLvalue	" ",      100,    18,     5,  275
idngain		FLvalue	" ",      100,    18,     5,  325
idvibf		FLvalue	" ",      100,    18,     5,  375
idvibamp	FLvalue	" ",      100,    18,     5,  425
idminfreq	FLvalue	" ",      100,    18,     5,  475
idjetrf		FLvalue	" ",      100,    18,     5,  525
idendrf		FLvalue	" ",      100,    18,     5,  575

;SLIDERS				            						MIN |   MAX  | EXP | TYPE |  DISP    | WIDTH | HEIGHT | X  | Y
gkamp, ihamp			FLslider	"Amplitude",					0,        1,    0,    23,   idamp,      490,     25,    5,   50
gkfreq, gihfreq			FLslider	"Frequency",					20,   20000,   -1,    23,   idfreq,     490,     25,    5,  100
gkjet, ihjet			FLslider	"Air Jet",					0,   10,    0,    23,   idjet,      490,     25,    5,  150
gkatt, ihatt			FLslider	"Attack Time (i-rate in seconds)",		0,    	  1,    0,    23,   idatt,      490,     25,    5,  200
gkdek,ihdek			FLslider 	"Decay Time (i-rate in seconds)",  		0,        1,    0,    23,   iddek,      490,     25,    5,  250
gkngain,ihngain			FLslider 	"Amplitude of Breath Noise",  			0,        1,    0,    23,   idngain,    490,     25,    5,  300
gkvibf,ihvibf			FLslider 	"Vibrato Frequency",  				-30,       30,    0,    23,   idvibf,     490,     25,    5,  350
gkvibamp,ihvibamp		FLslider 	"Vibrato Amplitude",  				0,        3,    0,    23,   idvibamp,   490,     25,    5,  400
gkminfreq,ihminfreq		FLslider 	"Minimum Frequency (i-rate)",			20,   20000,   -1,    23,   idminfreq,  490,     25,    5,  450
gkjetrf,ihjetrf			FLslider 	"Amount of Reflection of Breath Jet (i-rate)",	0,        1,    0,    23,   idjetrf,    490,     25,    5,  500
gkendrf,ihendrf			FLslider 	"Breath Jet Reflection Coefficient (i-rate)",	0,        1,    0,    23,   idendrf,    490,     25,    5,  550


;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"", 	6,       9,    15,    490,    100,    5, 600	;AIR JET ENVELOPE
ih		 	FLbox  	"", 	6,       9,    15,    490,    100,    5, 700	;NOISE ENVELOPE
ih		 	FLbox  	"", 	6,       9,    15,    110,    100,  505,   5	;FILTER
ih		 	FLbox  	"", 	6,       9,    15,    165,    100,  625,   5	;AMPLITUDE ENVELOPE
ih		 	FLbox  	"", 	6,       9,    15,    110,    100,  800,   5	;REVERB

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Jet Envelope",		1,      11,    15,    180,     12,   160, 605
ih		 	FLbox  	"Noise Envelope",	1,      11,    15,    180,     12,   160, 705
ih		 	FLbox  	"Filter",		1,      11,    15,    100,     12,   510,  10
ih		 	FLbox  	"Amplitude Envelope",	1,      11,    15,    145,     12,   635,  10
ih		 	FLbox  	"Reverb",		1,      11,    15,     90,     12,   805,  10

;BUTTONS                           			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkJetEnv,ihJetEnv	FLbutton	"On / Off",	1,    0,    22,     80,    25,    15, 620,   -1
FLsetColor2	255, 50, 50, ihJetEnv		;SET BUTTON LED COLOUR
gkNseEnv,ihNseEnv	FLbutton	"On / Off",	1,    0,    22,     80,    25,    15, 720,   -1
FLsetColor2	255, 50, 50, ihNseEnv		;SET BUTTON LED COLOUR


;VALUE DISPLAY BOXES	LABEL  | WIDTH | HEIGHT | X |  Y
idJlev1		FLvalue	"",       40,     18,    105, 675
idJtim1		FLvalue	"",       40,     18,    155, 675
idJlev2		FLvalue	"",       40,     18,    205, 675
idJtim2		FLvalue	"",       40,     18,    255, 675
idJSusLev	FLvalue	"",       40,     18,    305, 675
idJRelTim	FLvalue	"",       40,     18,    355, 675
idJRelLev	FLvalue	"",       40,     18,    405, 675                                                        

idNAttLev	FLvalue	"",       40,     18,    105, 775
idNAttTim	FLvalue	"",       40,     18,    155, 775
idNSusLev	FLvalue	"",       40,     18,    205, 775
idNRelTim	FLvalue	"",       40,     18,    255, 775
idNRelLev	FLvalue	"",       40,     18,    305, 775

idHPF		FLvalue	"",       50,     18,    510,  80
idLPF		FLvalue	"",       50,     18,    560,  80

idAAttTim	FLvalue	"",       50,     18,    630,  80
idASusLev	FLvalue	"",       50,     18,    680,  80
idARelTim	FLvalue	"",       50,     18,    730,  80

idRvbSend	FLvalue	"",       50,     18,    805,  80
idRvbSize	FLvalue	"",       50,     18,    855,  80

;KNOBS							MIN    |   MAX | EXP|  TYPE |  DISP    | WIDTH | X |  Y
gkJlev1,   ihJlev1	FLknob		"Lev.1",	0.005,     10,   -1,    1,   idJlev1,      40,  105, 620
gkJtim1,   ihJtim1	FLknob		"Time.1",	0.001,      5,   -1,    1,   idJtim1,      40,  155, 620
gkJlev2,   ihJlev2	FLknob		"Lev.2",	0.005,     10,   -1,    1,   idJlev2,      40,  205, 620
gkJtim2,   ihJtim2	FLknob		"Time.2",	0.001,      5,   -1,    1,   idJtim2,      40,  255, 620
gkJSusLev, ihJSusLev	FLknob		"Sus.Lev.",	0.005,     10,   -1,    1,   idJSusLev,    40,  305, 620
gkJRelTim, ihJRelTim	FLknob		"Rel.Time",	0.001,      5,   -1,    1,   idJRelTim,    40,  355, 620
gkJRelLev, ihJRelLev	FLknob		"Rel.Lev",	0.005,     10,   -1,    1,   idJRelLev,    40,  405, 620

gkNAttLev, ihNAttLev	FLknob		"Att.Lev",	-1,         1,    0,    1,   idNAttLev,    40,  105, 720
gkNAttTim, ihNAttTim	FLknob		"Att.Time",	0.001,      5,   -1,    1,   idNAttTim,    40,  155, 720
gkNSusLev, ihNSusLev	FLknob		"Sus.Lev.",	-1,         1,    0,    1,   idNSusLev,    40,  205, 720
gkNRelTim, ihNRelTim	FLknob		"Rel.Time",	0.001,      5,   -1,    1,   idNRelTim,    40,  255, 720
gkNRelLev, ihNRelLev	FLknob		"Rel.Lev",	-1,         1,    0,    1,   idNRelLev,    40,  305, 720

gkHPF, ihHPF		FLknob		"HPF",		20,     20000,   -1,    1,   idHPF,        40,  515,  25
gkLPF, ihLPF		FLknob		"LPF",		20,     20000,   -1,    1,   idLPF,        40,  565,  25

gkAAttTim, ihAAttTim	FLknob		"Att.Time",	0.001,      5,   -1,    1,   idAAttTim,    40,  635,  25
gkASusLev, ihASusLev	FLknob		"Sus.Lev.",	0,          1,    0,    1,   idASusLev,    40,  685,  25
gkARelTim, ihARelTim	FLknob		"Rel.Time",	0.001,      5,   -1,    1,   idARelTim,    40,  735,  25

gkRvbSend, ihRvbSend	FLknob		"Send",		0,          1,    0,    1,   idRvbSend,    40,  810,  25
gkRvbSize, ihRvbSize	FLknob		"Size",		0.5,     0.99,    0,    1,   idRvbSize,    40,  860,  25

FLsetTextSize	11,ihJlev1
FLsetTextSize	11,ihJtim1
FLsetTextSize	11,ihJlev2
FLsetTextSize	11,ihJtim2
FLsetTextSize	11,ihJSusLev
FLsetTextSize	11,ihJRelTim
FLsetTextSize	11,ihJRelLev

FLsetTextSize	11,ihNAttLev
FLsetTextSize	11,ihNAttTim
FLsetTextSize	11,ihNSusLev
FLsetTextSize	11,ihNRelTim
FLsetTextSize	11,ihNRelLev

FLsetTextSize	11,ihHPF
FLsetTextSize	11,ihLPF

FLsetTextSize	11,ihAAttTim
FLsetTextSize	11,ihASusLev
FLsetTextSize	11,ihARelTim

FLsetTextSize	11,ihRvbSend
FLsetTextSize	11,ihRvbSize
                                                                                     
;SET INITIAL VALUES FOR VALUATORS
		FLsetVal_i	1, 	ihMonoStereo

		FLsetVal_i	1, 	ihJlev1
		FLsetVal_i	0.1, 	ihJtim1
		FLsetVal_i	10, 	ihJlev2
		FLsetVal_i	0.1, 	ihJtim2
		FLsetVal_i	1, 	ihJSusLev
		FLsetVal_i	0.1, 	ihJRelTim
		FLsetVal_i	1, 	ihJRelLev

		FLsetVal_i	1, 	ihNAttLev
		FLsetVal_i	0.15, 	ihNAttTim
		FLsetVal_i	0, 	ihNSusLev
		FLsetVal_i	0.05, 	ihNRelTim
		FLsetVal_i	0.5, 	ihNRelLev

		FLsetVal_i	100, 	ihHPF
		FLsetVal_i	4000, 	ihLPF

		FLsetVal_i	0.1, 	ihAAttTim
		FLsetVal_i	0.141, 	ihASusLev
		FLsetVal_i	0.1, 	ihARelTim

		FLsetVal_i	0.2, 	ihRvbSend
		FLsetVal_i	0.8, 	ihRvbSize
		
		FLsetVal_i	0.2, 	ihamp
		FLsetVal_i	750, 	gihfreq
		FLsetVal_i	.34, 	ihjet
		FLsetVal_i	.1, 	ihatt
		FLsetVal_i	.1, 	ihdek
		FLsetVal_i	.1, 	ihngain
		FLsetVal_i	5, 	ihvibf
		FLsetVal_i	.1, 	ihvibamp
		FLsetVal_i	20, 	ihminfreq
		FLsetVal_i	.08, 	ihjetrf
		FLsetVal_i	1, 	ihendrf

		FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 600,1012, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                         wgflute                             ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"wgflute is a wave guide physical model of a flute based on   ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"work by Perry Cook but re-coded for Csound by John ffitch.   ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"Attack time is the time taken to reach full blowing pressure.", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"The author suggests that 0.1 corresponds to normal playing.  ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"Decay time is the time taken for the system to stop producing", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"sound after blowing has stopped. The author suggests that 0.1", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"produces a smooth natural sounding end to a note.            ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"Air jet defines the strength of the air jet blown into the   ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"flute and therefore controls the playing of overtones.       ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"Values for air jet should be positive and the useful range is", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"approximately 0.08 to 0.56. The author suggests a value of   ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"0.3 as representing an air jet of typical strength. A value  ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"of 0.34 seems to provide the most accurate tuning.           ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"Amplitude of breath noise controls the amount of simulated   ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"wind noise in the composite tone produced. The suggested     ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"range is 0 to 0.5.                                           ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"Vibrato is implemented within the opcode and does not need to", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"be applied separately to the frequency parameter. Natural    ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"vibrato occurs at about 5 hertz.                             ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"Minimum frequency (optional) defines the lowest frequency at ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"which the model will play.                                   ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"Amount of Reflection of Breath Jet (optional, default=0.5)   ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"defines the amount of reflection in the breath jet that.     ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"powers the flute.                                            ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"Breath Jet Reflection Coefficient (optional, default=0.5) is ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"used in conjunction with the Amount of Reflection of Breath  ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"Jet in the calculation of the pressure differential.         ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"This example can also be triggered via MIDI. MIDI note       ", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"number, velocity and pitch bend are interpreted              ", 	1,      5,     14,    490,    15,     5, 560
ih		 	FLbox  	"appropriately.                                               ", 	1,      5,     14,    490,    15,     5, 580

		FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen	0, 0, 131072, 10, 1	;SINE WAVE (USED FOR VIBRATO)
gasendL,gasendR	init	0

instr	1	;MIDI ACTIVATED INSTRUMENT
	if	gkOnOff=1	then ; SENSE FLTK ON/OFF SWITCH
			turnoff	;TURNOFF THIS INSTRUMENT IMMEDIATELY
	endif
	ioct	octmidi		;READ NOTE VALUES FROM MIDI INPUT IN THE 'OCT' FORMAT
	iamp	ampmidi	1	;AMPLITUDE IS READ FROM INCOMING MIDI NOTE
	;kpres	aftouch	1, 5		;AFTERTOUCH CONTROL OF BOW PRESSURE
	;kpres	ctrl7	1, 1, 1, 5	;MOD. WHEEL CONTROL OF BOW PRESSURE
	;kpres	=	gkpres
	;PITCH BEND INFORMATION IS READ
	iSemitoneBendRange = 2		;PITCH BEND RANGE IN SEMITONES (WILL BE DEFINED FURTHER LATER) - SUGGESTION - THIS COULD BE CONTROLLED BY AN FLTK COUNTER
	imin = 0			;EQUILIBRIUM POSITION
	imax = iSemitoneBendRange * .0833333	;MAX PITCH DISPLACEMENT (IN oct FORMAT)
	kbend	pchbend	imin, imax	;PITCH BEND VARIABLE (IN oct FORMAT)
	kfreq	=	cpsoct(ioct+ kbend)
	ifn		=	1	;WAVEFORM FUNCTION TABLE FOR THE SHAPE OF THE VIBRATO - SHOULD NORMALLY JUST BE A SINE WAVE OR SOMETHING SIMILAR
	kSwitch		changed		gkminfreq, gkjetrf, gkendrf, gkatt, gkdek	;GENERATE A MOMENTARY '1' VALUE THROUGH VARIABLE kSwitch IF ANY OF ITS INPUT VARIABLE CHANGE
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	UPDATE			;BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE'
	endif
	kporttime	linseg	0,0.001,0.05

	if i(gkJetEnv)==1 then												; air jet envelope 
	 ; envelope
	 kjet		expsegr	i(gkJlev1),i(gkJtim1),i(gkJlev2),i(gkJtim2),i(gkJSusLev),i(gkJRelTim),i(gkJRelLev)
	else
	 kjet		portk	gkjet, kporttime
	endif

	if i(gkNseEnv)==1 then												; noise gain envelope
	 ; envelope
	 kngain		linsegr	i(gkNAttLev),i(gkNAttTim),i(gkNSusLev),i(gkNRelTim),i(gkNRelLev)
	 kngain		limit	gkngain+kngain,0,1
	else
	 kngain		portk	gkngain, kporttime
	endif

	aenv		expsegr	1,i(gkAAttTim),i(gkASusLev)+0.001,i(gkdek)+i(gkARelTim),0.001				; amplitude envelope
	aenv		=	aenv - 0.001

	UPDATE:

	;; stereo / mono
	if i(gkMonoStereo)==1 then
	 ;AN AUDIO SIGNAL IS CREATED USING THE wgflute OPCODE. NOTE THAT I-RATE VARIABLES MUST BE CONVERTED TO I-RATE FROM K-RATE SLIDERS
	 afluteL		wgflute	gkamp, kfreq, kjet, i(gkatt), i(gkdek), kngain, gkvibf, gkvibamp, gisine, i(gkminfreq), i(gkjetrf), i(gkendrf)
	 afluteR		wgflute	gkamp, kfreq, kjet, i(gkatt), i(gkdek), kngain, gkvibf, gkvibamp, gisine, i(gkminfreq), i(gkjetrf), i(gkendrf)
	 rireturn				;RETURN FROM A REINITIALIZATION PASS TO PERFORMANCE TIME PASSES
	 afluteL		buthp	afluteL,gkHPF
	 afluteL		butlp	afluteL,gkLPF
	 afluteR		buthp	afluteR,gkHPF
	 afluteR		butlp	afluteR,gkLPF
	 afluteL		=	afluteL * aenv
	 afluteR		=	afluteR * aenv
	 		outs 	afluteL, afluteR	;SEND AUDIO OUTPUTS
	 gasendL	=	gasendL + (afluteL * gkRvbSend)
	 gasendR	=	gasendR + (afluteR * gkRvbSend)
	else
	 ;AN AUDIO SIGNAL IS CREATED USING THE wgflute OPCODE. NOTE THAT I-RATE VARIABLES MUST BE CONVERTED TO I-RATE FROM K-RATE SLIDERS
	 aflute			wgflute	gkamp, kfreq, kjet, i(gkatt), i(gkdek), kngain, gkvibf, gkvibamp, gisine, i(gkminfreq), i(gkjetrf), i(gkendrf)
	 rireturn				;RETURN FROM A REINITIALIZATION PASS TO PERFORMANCE TIME PASSES
	 aflute			buthp	aflute,gkHPF
	 aflute			butlp	aflute,gkLPF
	 aflute		=	aflute * aenv
	 		outs 	aflute, aflute	;SEND AUDIO OUTPUTS
	 gasendL	=	gasendL + (aflute * gkRvbSend)
	 gasendR	=	gasendR + (aflute * gkRvbSend)
	endif
endin

instr	2	;FLTK ACTIVATED INSTRUMENT
	if		gkOnOff=0	then		;IF ON/OFF SWITCH IS OFF AND NO MIDI NOTES ARE ACTIVE...
		turnoff					;...TURN THIS INSTRUMENT OFF
	endif						;END OF CONDITIONAL BRANCHING

	kSwitch		changed		gkminfreq, gkjetrf, gkendrf, gkatt, gkdek	;GENERATE A MOMENTARY '1' VALUE THROUGH VARIABLE kSwitch IF ANY OF ITS INPUT VARIABLE CHANGE
	if	kSwitch=1	then	;IF kSwitch=1 THEN...
		reinit	UPDATE		;BEGIN A REINITIALISATION PASS FROM THE GIVEN LABEL
	endif				;LABEL
	
	kporttime	linseg	0,0.001,0.05
	kfreq		portk	gkfreq,kporttime

	if i(gkJetEnv)==1 then												; air jet envelope 
	 ; envelope
	 kjet		expsegr	i(gkJlev1),i(gkJtim1),i(gkJlev2),i(gkJtim2),i(gkJSusLev),i(gkJRelTim),i(gkJRelLev)
	else
	 kjet		portk	gkjet, kporttime
	endif

	if i(gkNseEnv)==1 then												; noise gain envelope
	 ; envelope
	 kngain		linsegr	i(gkNAttLev),i(gkNAttTim),i(gkNSusLev),i(gkNRelTim),i(gkNRelLev)
	 kngain		limit	gkngain+kngain,0,1
	else
	 kngain		portk	gkngain, kporttime
	endif

	aenv		expsegr	1,i(gkAAttTim),i(gkASusLev)+0.001,i(gkdek)+i(gkARelTim),0.001				; amplitude envelope
	aenv		=	aenv - 0.001
	
	UPDATE:
		
	;; stereo / mono
	if i(gkMonoStereo)==1 then
	 ;AN AUDIO SIGNAL IS CREATED USING THE wgflute OPCODE. NOTE THAT I-RATE VARIABLES MUST BE CONVERTED TO I-RATE FROM K-RATE SLIDERS
	 afluteL		wgflute	gkamp, kfreq, kjet, i(gkatt), i(gkdek), kngain, gkvibf, gkvibamp, gisine, i(gkminfreq), i(gkjetrf), i(gkendrf)
	 afluteR		wgflute	gkamp, kfreq, kjet, i(gkatt), i(gkdek), kngain, gkvibf, gkvibamp, gisine, i(gkminfreq), i(gkjetrf), i(gkendrf)
	 rireturn				;RETURN FROM A REINITIALIZATION PASS TO PERFORMANCE TIME PASSES
	 afluteL		buthp	afluteL,gkHPF
	 afluteL		butlp	afluteL,gkLPF
	 afluteR		buthp	afluteR,gkHPF
	 afluteR		butlp	afluteR,gkLPF
	 afluteL		=	afluteL * aenv
	 afluteR		=	afluteR * aenv
	 		outs 	afluteL, afluteR	;SEND AUDIO OUTPUTS
	 gasendL	=	gasendL + (afluteL * gkRvbSend)
	 gasendR	=	gasendR + (afluteR * gkRvbSend)
	else
	 ;AN AUDIO SIGNAL IS CREATED USING THE wgflute OPCODE. NOTE THAT I-RATE VARIABLES MUST BE CONVERTED TO I-RATE FROM K-RATE SLIDERS
	 aflute			wgflute	gkamp, kfreq, kjet, i(gkatt), i(gkdek), kngain, gkvibf, gkvibamp, gisine, i(gkminfreq), i(gkjetrf), i(gkendrf)
	 rireturn				;RETURN FROM A REINITIALIZATION PASS TO PERFORMANCE TIME PASSES
	 aflute			buthp	aflute,gkHPF
	 aflute			buthp	aflute,gkHPF
	 aflute		=	aflute * aenv
	 		outs 	aflute, aflute	;SEND AUDIO OUTPUTS
	 gasendL	=	gasendL + (aflute * gkRvbSend)
	 gasendR	=	gasendR + (aflute * gkRvbSend)
	endif
endin

instr	999
	aL,aR	reverbsc	gasendL, gasendR, gkRvbSize, 3000
		outs		aL,aR
		clear		gasendL,gasendR
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT
i 999 0 3600	

</CsScore>

</CsoundSynthesizer>