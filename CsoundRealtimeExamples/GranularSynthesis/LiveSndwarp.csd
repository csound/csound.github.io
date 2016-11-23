LiveSndwarp.csd
Written by Iain McCurdy, 2012.

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -dm0
</CsOptions>

<CsInstruments>
 
sr	=	44100  
ksmps	=	32
nchnls	=	2
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL          | WIDTH | HEIGHT | X | Y
	FLpanel	"Live sndwarp",  1000,    515,    0,  0

#define	COLOUR	#200,200,255#		;RGB colour macro
;BORDERS					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"", 		6,       9,    15,    490,    125,    5, 250	;DELAY BOX
FLsetColor	$COLOUR,ih									;set colour
ih		 	FLbox  	"Grain Delay", 	1,       2,    15,    200,     20,  150, 252	;DELAY LABEL
FLsetColor	$COLOUR,ih									;set colour

#define	COLOUR	#200,255,200#		;RGB colour macro
ih		 	FLbox  	"", 		6,       9,    15,    190,     85,     2, 428	;GRAIN SHAPE BOX
FLsetColor	$COLOUR,ih									;set colour
gihwfnLabel	 	FLbox  	"", 		1,      1,     14,    180,    20,     10,480	;grain shape label
FLsetColor	$COLOUR,gihwfnLabel								;set colour

ih		 	FLbox  	"", 		6,       9,    15,    304,     85,   195, 428	;FREEZE BOX
FLsetColor	255,200,200,ih								;set colour

;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X  | Y  | OPCODE 
gkolap, iholap			FLcount  "Number of Overlaps",	1,    200,    1,      10,     1,    150,      25,  155,  5,   -1
gkwfn, ihwfn			FLcount  "Grain Envelope:", 	1,    6,      1,     100,     2,    140,      25,   30, 433,   0,  99, 0, 0
gkmonostereo, gihmonostereo	FLcount  "mono", 		1,    3,      1,     100,     2,     90,      25,  310,  5,    0,  99, 0, 0
FLsetFont 2, ihwfn

;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkbalance,ihbalance		FLbutton	"Balance",	1,    0,    22,    90,      25,   405, 5,    -1
gkclip,ihclip			FLbutton	"clip",		1,    0,    22,    60,      25,   435,380,   -1
gkpch2uni,ih			FLbutton	"to unison",	1,    0,    21,    80,      20,   415,225,   0, 100,0,0
gkfreeze,ihfreeze		FLbutton	"freeze",	1,    0,    22,   100,      22,   199,434,   -1

;set button 'on' colours to yellow
FLsetColor2	255,255,0,ihbalance
FLsetColor2	255,255,0,gihmonostereo
FLsetColor2	255,255,0,ihclip
FLsetColor2	255,0,0,ihfreeze

;NUMBER DISPLAY BOXES		WIDTH | HEIGHT | X | Y
idamp		FLvalue   " ",	 70,      20,    5,  75
idwsize		FLvalue   " ",	 70,      20,    5, 125
idrnd		FLvalue   " ",	 70,      20,    5, 175
idpch		FLvalue   " ",	 70,      20,    5, 225
iddly		FLvalue   " ",	 70,      20,   10, 300
idbeta		FLvalue   " ",	 70,      20,   10, 350
idfback		FLvalue   " ",	 70,      20,    5, 405

;SLIDERS					      							MIN |  MAX  | EXP | TYPE |   DISP   | WIDTH | HEIGHT | X   | Y
gkInGain,ihInGain		FLslider	"Input Gain",						0,        1,   0,    23,   -1,         145,     25,    5,     5
gkamp,ihamp			FLslider	"Output Gain",						0,        1,   0,    23,   idamp,      240,     25,    5,    50
gkmix,ihmix			FLslider	"Dry/Wet Mix",						0,        1,   0,    23,   -1,         240,     25,  255,    50
gkwsize,ihwsize			FLslider	"Window (Grain) Size in samples (i-rate)",		1,     sr*2,  -1,    23,   idwsize,    490,     25,    5,   100
gkrnd,ihrnd			FLslider	"Window (Grain) Size Randomization Factor (i-rate)",	0,    10000,   0,    23,   idrnd,      490,     25,    5,   150
gkpch,gihpch			FLslider	"Pitch Ratio",						0.01,     8,  -1,    23,   idpch,      490,     25,    5,   200
gkdly,ihdly			FLslider	"Range (seconds)",					0,        5,   0,    23,   iddly,      480,     25,   10,   275
gkbeta,ihbeta			FLslider	"Distribution Shape (Uniform - Linear - Exponential)",	1,       16,  -1,    23,   idbeta,     480,     25,   10,   325
gkfback,ihfback			FLslider	"Feedback (caution!)",					0,        1,   0,    23,   idfback,    430,     25,    5,   380
gkManPtrPort,ihManPtrPort	FLslider	"Portamento",						0,        1,   0,     3,   -1,         190,     15,  303,   434
gkManPtr,gihManPtr		FLslider	"Manual Pointer Offset",				-1,       0,   0,    1,    -1,         295,     30,  199,   465
FLsetColor	0,255,0,gihManPtr	;green
FLsetColor2	255,0,0,gihManPtr	;red

; INITIALISATION OF SLIDERS AND COUNTERS
		FLsetVal_i   	0.5, 	ihInGain
		FLsetVal_i   	0.7, 	ihamp
		FLsetVal_i   	1, 	ihmix
		FLsetVal_i   	10, 	iholap
		FLsetVal_i   	1, 	ihwfn
		FLsetVal_i   	7000, 	ihwsize
		FLsetVal_i   	1000, 	ihrnd
		FLsetVal_i   	1, 	gihpch
		FLsetVal_i   	0, 	ihdly
		FLsetVal_i   	1, 	ihbeta
		FLsetVal_i   	0, 	ihfback
		FLsetVal_i   	1, 	ihclip
		FLsetVal_i   	1, 	gihmonostereo
		FLsetVal_i   	0, 	gihManPtr
		FLsetVal_i   	0.5, 	ihManPtrPort

;INSTRUCTIONS AND INFO PANEL
				FLscroll     500, 515, 500, 0

;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                       Live sndwarp                        ", 	1,      6,     14,    475,    20,  500+5,   0
ih		 	FLbox  	"-----------------------------------------------------------", 	1,      6,     14,    475,    20,  500+5,  20
ih		 	FLbox  	"This example implements live granulation of an audio input ", 	1,      5,     14,    475,    20,  500+5,  40
ih		 	FLbox  	"stream using the sndwarp opcode. It is recommended to first", 	1,      5,     14,    475,    20,  500+5,  60
ih		 	FLbox  	"investigate the example 'sndwarp.csd' for an understanding ", 	1,      5,     14,    475,    20,  500+5,  80
ih		 	FLbox  	"of how sndwarp works.                                      ", 	1,      5,     14,    475,    20,  500+5, 100 
ih		 	FLbox  	"Live audio from the first input channel (left input if     ", 	1,      5,     14,    475,    20,  500+5, 120
ih		 	FLbox  	"stereo) is written into the function table from which      ", 	1,      5,     14,    475,    20,  500+5, 140
ih		 	FLbox  	"sndwarp reads audio. The key is that manual pointer read   ", 	1,      5,     14,    475,    20,  500+5, 160
ih		 	FLbox  	"mode is used with sndwarp (as opposed to time-stretch mode)", 	1,      5,     14,    475,    20,  500+5, 180
ih		 	FLbox  	"and that the read pointer follows on behind the pointer    ", 	1,      5,     14,    475,    20,  500+5, 200
ih		 	FLbox  	"which is used to write audio into the function table. Some ", 	1,      5,     14,    475,    20,  500+5, 220
ih		 	FLbox  	"care is needed to ensure that the read pointer does not    ", 	1,      5,     14,    475,    20,  500+5, 240
ih		 	FLbox  	"'overtake' the write pointer (which would result in        ", 	1,      5,     14,    475,    20,  500+5, 260
ih		 	FLbox  	"dicontinuities in the audio it reads). This could be       ", 	1,      5,     14,    475,    20,  500+5, 280
ih		 	FLbox  	"possible if pitch transposition upwards of grains is used. ", 	1,      5,     14,    475,    20,  500+5, 300
ih		 	FLbox  	"This example prevents this from happening internally. The  ", 	1,      5,     14,    475,    20,  500+5, 320
ih		 	FLbox  	"user can also define a random offset for the grain read    ", 	1,      5,     14,    475,    20,  500+5, 340
ih		 	FLbox  	"pointer using the 'Grain Delay' settings. Delay times are  ", 	1,      5,     14,    475,    20,  500+5, 360
ih		 	FLbox  	"randomly chosen according to a 'betarand'                  ", 	1,      5,     14,    475,    20,  500+5, 380
ih		 	FLbox  	"distribution the 'beta' of which the user can set: if      ", 	1,      5,     14,    475,    20,  500+5, 400
ih		 	FLbox  	"distribution shape is 1 the distribution is uniform, if it ", 	1,      5,     14,    475,    20,  500+5, 420
ih		 	FLbox  	"is 2 the distribution is linear and beyond 2 it is         ", 	1,      5,     14,    475,    20,  500+5, 440
ih		 	FLbox  	"increasingly exponential.                                  ", 	1,      5,     14,    475,    20,  500+5, 460
ih		 	FLbox  	"Sound output from sndwarp can be fed back into the input to", 	1,      5,     14,    475,    20,  500+5, 480
ih		 	FLbox  	"be mixed with the live audio in. The amount of feedback can", 	1,      5,     14,    475,    20,  500+5, 500
ih		 	FLbox  	"be controlled using the 'Feedback' slider. Using high      ", 	1,      5,     14,    475,    20,  500+5, 520
ih		 	FLbox  	"levels of feedback can result in overloading but this will ", 	1,      5,     14,    475,    20,  500+5, 540
ih		 	FLbox  	"also be dependent upon other factors such as random delay  ", 	1,      5,     14,    475,    20,  500+5, 560
ih		 	FLbox  	"time, grain size (window size) and transposition so user   ", 	1,      5,     14,    475,    20,  500+5, 580
ih		 	FLbox  	"caution is recommended. If the 'clip' button is activated  ", 	1,      5,     14,    475,    20,  500+5, 600
ih		 	FLbox  	"the feedback signal will be clipped at maximum amplitude   ", 	1,      5,     14,    475,    20,  500+5, 620
ih		 	FLbox  	"providing at least some control over a runaway feedback    ", 	1,      5,     14,    475,    20,  500+5, 640
ih		 	FLbox  	"loop.                                                      ", 	1,      5,     14,    475,    20,  500+5, 660
ih		 	FLbox  	"If 'balance' is activated the output of sndwarp is         ", 	1,      5,     14,    475,    20,  500+5, 680
ih		 	FLbox  	"dynamically balanced with the input signal. This can be    ", 	1,      5,     14,    475,    20,  500+5, 700
ih		 	FLbox  	"useful for compensating for increases in amplitude caused  ", 	1,      5,     14,    475,    20,  500+5, 720
ih		 	FLbox  	"when 'Number of Overlaps' (grain density) is increased.    ", 	1,      5,     14,    475,    20,  500+5, 740
ih		 	FLbox  	"There are 3 mono/stereo modes: 'mono in - mono out (x2)',  ", 	1,      5,     14,    475,    20,  500+5, 760
ih		 	FLbox  	"'mono in - stereo out' (stereo effect is created using     ", 	1,      5,     14,    475,    20,  500+5, 780
ih		 	FLbox  	"sndwarp's built-in window/grain size randomisation, and    ", 	1,      5,     14,    475,    20,  500+5, 800
ih		 	FLbox  	"'stereo in - stereo out' mode.                             ", 	1,      5,     14,    475,    20,  500+5, 820
ih		 	FLbox  	"The buffer size used in the example is just under 23       ", 	1,      5,     14,    475,    20,  500+5, 840
ih		 	FLbox  	"seconds long (function table size 1048576 at sr=44100).    ", 	1,      5,     14,    475,    20,  500+5, 860
ih		 	FLbox  	"This could be enlarged if required but bear in mind that   ", 	1,      5,     14,    475,    20,  500+5, 880
ih		 	FLbox  	"sndwarp needs a power of two table size.                   ", 	1,      5,     14,    475,    20,  500+5, 900
ih		 	FLbox  	"Activating 'Freeze' will pause writing of live audio to the", 	1,      5,     14,    475,    20,  500+5, 920
ih		 	FLbox  	"function table and allow the user to manually navigate     ", 	1,      5,     14,    475,    20,  500+5, 940
ih		 	FLbox  	"through the buffered audio. The feedback loop will also be ", 	1,      5,     14,    475,    20,  500+5, 960
ih		 	FLbox  	"deactivated when 'freeze' is active.                       ", 	1,      5,     14,    475,    20,  500+5, 980
                                
				FLscroll_end

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gibuffer	ftgen	0, 0, 1048576, 2, 0	;Buffer table. Roughly 23 seconds duration.
gibufferR	ftgen	0, 0, 1048576, 2, 0	;right channel

;GRAIN ENVELOPE WINDOW FUNCTION TABLES:
giwfn1	ftgen	0,  0, 131072,  9,   .5, 1, 	0 				; HALF SINE
giwfn2	ftgen	0,  0, 131072,  7,    0, 3072,  1, 128000,     0		; PERCUSSIVE - STRAIGHT SEGMENTS
giwfn3	ftgen	0,  0, 131072,  5, .001, 3072,  1, 128000, 0.001		; PERCUSSIVE - EXPONENTIAL SEGMENTS
giwfn4	ftgen	0,  0, 131072,  7,    0, 1536,  1, 128000,     1, 1536, 0	; GATE - WITH ANTI-CLICK RAMP UP AND RAMP DOWN SEGMENTS
giwfn5	ftgen	0,  0, 131072,  7,    0, 128000,1, 3072,       0		; REVERSE PERCUSSIVE - STRAIGHT SEGMENTS
giwfn6	ftgen	0,  0, 131072,  5, .001, 128000,1, 3072,   0.001		; REVERSE PERCUSSIVE - EXPONENTIAL SEGMENTS

instr	1
	ain	inch	1						;read audio input from the left input channel
	ain	=	ain*gkInGain
		outch	1,ain*(1-gkmix)
	aFBackSig,aFBackSigR	init	0				;audio feedback signal (initialised for first performance iteration)
	aFBackSig	dcblock2	aFBackSig			;filter dc offset from feedback signal
	if gkclip==1 then						;if clip switch is on...
	 aFBackSig	clip	aFBackSig, 0, 0dbfs			;clip feedback signal at maximum amplitude using bram de jong method
	 if gkmonostereo==3 then					;and if stereo in/out mode is also chosen
	  aFBackSigR	clip	aFBackSigR, 0, 0dbfs			;clip right channel feedback signal
	 endif
	endif
	aphsW	phasor	(sr*(1-gkfreeze))/ftlen(gibuffer)		;pointer 0 - 1	;create a moving phase value that will be used to point to locations in a function table where input audio signal will be written

	/*write audio from left input to function table*/
	if gkfreeze==0 then
		tablew	ain+aFBackSig,aphsW,gibuffer,1			;write input audio to table
	endif
	
	/*if stereo in - stereo out mode*/
	if gkmonostereo==3 then						;if stereo in/out mode has been chosen...
	 aR	inch	2						;read right channel audio input
	 aR	=	aR*gkInGain					;rescale its amplitude with 'Input Gain' slider
	if gkfreeze==0 then
		tablew	aR+aFBackSigR,aphsW,gibufferR,1			;write right channel audio input audio to table
	endif
		outch	2,aR*(1-gkmix)
	else
		outch	2,ain*(1-gkmix)	
	endif
	
	kporttime	linseg	0,0.001,0.03				;portamento time. Rises quickly from zero to a held value.
	kpch		portk	gkpch,kporttime				;Apply portamento smoothing to changes made to the pitch multiplier
	apch	interp	kpch						;interpolate pitch multiplier variable to create an a-rate version. This will produce higher quality results when pitch is modulated.
	
	kManPtr	portk	gkManPtr,kporttime*10*gkfreeze*gkManPtrPort

	ktrig	changed	gkwsize,gkrnd,gkolap,gkwfn			;if any of the list of input args. change, generate a trigger impulse (momentary '1'). The input args are all i-rate in sndwarp so reinitialisation will be required for their changes to register.
	if ktrig==1 then						;if a trigger hass been generated... 
	 reinit	UPDATE_SNDWARP						;... begin a reinitialisation pass from the given label
	endif
	UPDATE_SNDWARP:							;a label. Reinitialisation begins from here.
	imode	=	1						;sndwarp mode. (1=pointer mode, timestretch mode not so useful in a live audio in application)
	ibeg	=	0						;point in the function table from which to begin reading audio (0=beginning)
	iwsize	=	i(gkwsize)					;window (grain) size in samples
	irnd	=	i(gkrnd)					;window (grain) size randomisation bandwidth in samples
	iolap	=	i(gkolap)					;number of grain overlaps
	kRndDly	betarand	gkdly,1,gkbeta				;random grain delay time
	
	iMaxDur	=	(iwsize+irnd)/sr					;maximum grain duration in seconds
	kTransComp	limit	iMaxDur*(gkpch-1),0,ftlen(gibuffer)/sr
	kdelay	=	(kTransComp+kRndDly) / (ftlen(gibuffer)/sr)		;delay time required when reading grains from the function table
	if gkfreeze==1 then
	 kdelay	=	kdelay + (sr/(ftlen(gibuffer))*1.75*iwsize/sr)		;if freeze mode is active regress the read pointer a small amount
	endif
	aphsR	wrap	aphsW-kdelay+kManPtr,0,1				;location from which to read grain. This is always directly related to the poistion of the write pointer.
	iwfn	=	giwfn1+i(gkwfn)-1					;Grain amplitude windowing shape

	asig,ac	sndwarp 1, aphsR*(ftlen(gibuffer)/sr), apch, gibuffer, ibeg, iwsize, irnd, iolap, iwfn, imode
	if gkbalance==1 then							;if 'balance switch is on...
	 asig	balance	asig,ac							;... amplitude balance the signal
	endif
	if gkmonostereo==1 then							;if 'mono' mode seleced...
	 aFBackSig	=	asig*gkfback					;create feedback signal for next iteration. (This will be written into the function table along with the live audio in.)
	 aR	=	asig
	elseif gkmonostereo==2 then						;or if 'stereo out' mode
	 aR,acR	sndwarp 1, aphsR*(ftlen(gibuffer)/sr), apch, gibuffer, ibeg, iwsize, irnd, iolap, iwfn, imode
	 if gkbalance==1 then
	  aR	balance	aR,acR
	 endif
	 aFBackSig	=	(asig+aR)*gkfback				;create feedback signal, a mixture of the left and right sndwarp output channels
	else									;otherwise 'stereo in/out' mode
	 aR,acR	sndwarp 1, aphsR*(ftlen(gibufferR)/sr), apch, gibufferR, ibeg, iwsize, irnd, iolap, iwfn, imode
	 if gkbalance==1 then
	  aR	balance	aR,acR
	 endif
	 aFBackSig	=	asig*gkfback					;left channel feedback signal
	 aFBackSigR	=	aR*gkfback					;right channel feedback signal
	endif	
	rireturn								;return from reinitialisation
		outs	asig*gkamp*gkmix, aR*gkamp*gkmix		;send audio to outputs
endin

instr	99	;Update GUI labels
	iwfn	=	i(gkwfn)		;window shape choice
	if iwfn==1 then
	 Slabel	=	"Half Sine"
	elseif iwfn==2 then
	 Slabel	=	"Percussive (linear segments)"
	elseif iwfn==3 then
	 Slabel	=	"Percussive (exponential segments)"
	elseif iwfn==4 then
	 Slabel	=	"Gate"
	elseif iwfn==5 then
	 Slabel	=	"Reverse Percussive (linear segments)"
	elseif iwfn==6 then
	 Slabel	=	"Reverse Percussive (exponential segments)"
	endif
	FLsetText	Slabel, gihwfnLabel	;write window shape description to GUI
	
	imonostereo	init	i(gkmonostereo)	;mono/stereo mode choice
	if imonostereo==1 then
	 Slabel2	=	"mono"
	elseif  imonostereo==2 then
	 Slabel2	=	"stereo out"
	else
	 Slabel2	=	"stereo in/out"
	endif
	FLsetText	Slabel2, gihmonostereo	;write mono/stereo choice description to GUI
	
endin

instr	100
	FLsetVal_i	1,gihpch
endin

instr	101	;reset manual pointer when freeze is unfrozen
	ktrigger	trigger	gkfreeze,0.5,1
	FLsetVal	ktrigger,0,gihManPtr
endin

</CsInstruments>
<CsScore>
i 1 0 3600	;live sndwarp instrument
i 101 0 3600
e
</CsScore>
</CsoundSynthesizer>
 
