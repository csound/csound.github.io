Analogue Style Vocoder
Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>

;CSOUND'S VIRTUAL MIDI KEYBOARD (COMMENT/UNCOMMENT AS REQUIRED)
-iadc -odac -M0 -+rtmidi=virtual -dm0 -b400

;EXTERNAL MIDI KEYBOARD (COMMENT/UNCOMMENT AS REQUIRED)
;-iadc -odac -b256 -Ma -dm0

</CsOptions>

<CsInstruments>

sr 	= 	44100  
ksmps 	= 	64
nchnls 	= 	2
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL                    | WIDTH | HEIGHT | X | Y
		FLpanel	"Analogue Style Vocoder",   500,    480,    0,  0
		
;BORDERS				TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	" ", 	6,      9,     15,    496,     78,    2, 250	;BORDER AROUND MODULATOR PANEL
ih		 	FLbox  	" ", 	6,      9,     15,    496,    150,    2, 330	;BORDER AROUND CARRIER PANEL


;TEXT BOXES							TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Modulator",			1,       4,    14,     80,     20,    3,  251
ih		 	FLbox  	"Vocal Sample             ",	1,       5,    12,    190,     20,   110, 255
ih		 	FLbox  	"Drum Loop                ",	1,       5,    12,    190,     20,   110, 275
ih		 	FLbox  	"Microphone (left channel)",	1,       5,    12,    190,     20,   110, 295
ih		 	FLbox  	"Carrier",			1,       4,    14,     60,     20,    3,  331
ih		 	FLbox  	"Internal Synth ---------->",	1,       5,    12,    190,     20,   110,  335
ih		 	FLbox  	"External (right channel)  ",	1,       5,    12,    190,     20,   110,  355
ih		 	FLbox  	"Sawtooth",			1,       5,    12,     60,     20,   320,  335
ih		 	FLbox  	"Square  ",			1,       5,    12,     60,     20,   320,  355
ih		 	FLbox  	"Pulse   ",			1,       5,    12,     60,     20,   320,  375
ih		 	FLbox  	"Noise   ",			1,       5,    12,     60,     20,   320,  395


;COUNTERS					     	MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkbase, ihbase		FLcount  	"Base Note", 	24,    80,   1,     12,     1,     120,     25,    10,  5,   -1 
gknum, ihnum		FLcount  	"Num. Bands", 	1,    100,   1,     10,     1,     120,     25,   190,  5,   -1 
gk12_24, ih12_24	FLcount  	"dB per Oct", 	12,    24,  12,     12,     2,     140,     25,   350,  5,   -1 

;VALUE_DISPLAY_BOXES		 	WIDTH | HEIGHT | X | Y
idbw			FLvalue	" ",      80,    20,     5,   75
idincr			FLvalue	" ",      80,    20,     5,  125
idBPGain		FLvalue	" ",      80,    20,     5,  175
idHPGain		FLvalue	" ",      80,    20,     5,  225

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS				TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkModIn, ihModIn	FLbutBank	14,     1,     3,     18,      60,    90,255,  -1   
gkCarIn, ihCarIn	FLbutBank	14,     1,     2,     18,      40,    90,335,  -1   
gkSynType, ihSynType	FLbutBank	14,     1,     4,     18,      80,   300,335,  -1   
                                                                                                   
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN   

			;SLIDERS					MIN | MAX | EXP | TYPE |  DISP | WIDTH | HEIGHT | X | Y
gkbw,ihbw		FLslider 	"Bandwidth (octaves)",		0.01,   1,  -1,    23,   idbw,    490,     25,    5,  50
gkincr,ihincr		FLslider 	"Band Spacing (semitones)",	1,     12,  -1,    23,   idincr,  490,     25,    5, 100
gkBPGain,ihBPGain	FLslider 	"Bandpass Filters Gain",	0.1,   50,  -1,    23,   idBPGain,490,     25,    5, 150
gkHPGain,ihHPGain	FLslider 	"Highpass Filter Gain",		0.1,   50,  -1,    23,   idHPGain,490,     25,    5, 200
gkLPF,ihLPF		FLslider 	"LPF",				40,  10000, -1,    23,   -1,      190,     12,  300, 415
gkres,ihres		FLslider 	"Res",				0,       1,  0,    23,   -1,      190,     12,  300, 445


;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	40, 	ihbase
		FLsetVal_i	50, 	ihnum
		FLsetVal_i	0.25, 	ihbw
		FLsetVal_i	1.5, 	ihincr
		FLsetVal_i	2, 	ihBPGain
		FLsetVal_i	15, 	ihHPGain
		FLsetVal_i	5000, 	ihLPF
		FLsetVal_i	0, 	ihres
		FLsetVal_i	24, 	ih12_24

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 550, 512, 0
				FLscroll     515, 550, 0,   0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                   Analogue Style Vocoder                    ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"This is an implementation of a traditional analogue style    ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"vocoder.                                                     ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"Two audio signals, referred to as a modulator and a carrier, ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"are passed into the vocoder effect. The modulator typically  ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"typically a voice and the carrier is typically a synthesizer,", 	1,      5,     14,    490,    20,     5, 120
ih	  	 	FLbox  	"The modulator is analysed by being passed into a multiband   ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"filter (a bank of bandpass filters), the amplitude envelope  ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"of each band is tracked and a control function for each band ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"generated. The carrier signal is also passed through a       ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"a matching multiband filter, the set of amplitude envelopes  ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"derived from the modulator analysis is applied to outputs of ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"this second multiband filter.                                ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"In this implementation the user can vary the 'Base Note' or  ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"the frequency of the lowermost filter expressed as a MIDI    ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"note value. The number of filters in both filter banks can be", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"varied as can the spacing between adjacent filters, expressed", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"in semitones, and the bandwidth of the filters, expressed as ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"a fraction of an octave. Whenever changes are made to these  ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"controls the vocoder instrument reinitializes itself and     ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"at the same time checks if any of the filter frequencies will", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"exceed the nyquist frequency, in which case they will be     ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"omitted. For this reason the actual number of filters        ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"implemented may not be the number asked for using the GUI    ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"counter. Filter frequency data is printed to the terminal    ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"each time a change is made.                                  ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"The uppermost band of the filter bank is always a highpass   ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"filter. This is to allow high frequency sibilants in the     ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"modulator signal to be accurately represented.               ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"In this implementation the user can choose between two       ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"internal sound files and the computer's live audio input as  ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"modulator source. If 'microphone' is chosen then audio is    ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"read from the computer's left input channel.                 ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"For carrier signal there is a simple built-in synth with four", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"waveform options and a resonant lowpass filter (moogladder). ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"This internal synth is ideally played from an external MIDI  ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"keyboard - modify <CsOptions> accordingly.                   ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"If 'External' is chosen then audio is taken from the         ", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"computer's right channel input. You can connect you own      ", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"hardware synthesizer here.                                   ", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"Filter creation is controlled using a UDO with recursion so  ", 	1,      5,     14,    490,    20,     5, 820
ih		 	FLbox  	"that the number of filters can be changed without having to  ", 	1,      5,     14,    490,    20,     5, 840
ih		 	FLbox  	"rewrite code.                                                ", 	1,      5,     14,    490,    20,     5, 860
ih		 	FLbox  	"The filter slopes are switchable between 12 dB per octave and", 	1,      5,     14,    490,    20,     5, 880
ih		 	FLbox  	"24 dB per octave. Choosing 24 dB per octave effectively      ", 	1,      5,     14,    490,    20,     5, 900
ih		 	FLbox  	"doubles the number of filters used as for each band two      ", 	1,      5,     14,    490,    20,     5, 920
ih		 	FLbox  	"series filters are used instead of one. Older computers may  ", 	1,      5,     14,    490,    20,     5, 940
ih		 	FLbox  	"struggle in realtime with 24 dB per octave when combined with", 	1,      5,     14,    490,    20,     5, 960
ih		 	FLbox  	"large number of filters.                                     ", 	1,      5,     14,    490,    20,     5, 980
                                                           
				FLscroll_end
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen	0,0,4096,10,1
gaCar	init	0

opcode VocoderChannel, a, aaiiiii				;MODE UDO (K-RATE BASE FREQUENCY) - USED FOR NON-MIDI MODE 
	aMod,aCar,ibase,ibw,iincr,icount,inum  xin		;NAME INPUT VARIABLES
	amix	init	0
	icf	=	cpsmidinn(ibase+(icount*iincr))		;DERIVE FREQUENCY FOR *THIS* BANDPASS FILTER BASED ON BASE FREQUENCY AND FILTER NUMBER (icount)
	icount	=	icount + 1				;INCREMENT COUNTER IN PREPARTION FOR NEXT FILTER
		prints "Band: %d %t Freq: %f %n",icount,icf	;PRINT DATA ABOUT FILTER NUMBER AND FREQUENCY TO THE TERMINAL

	if	icf>15000 goto SKIP				;IF FILTER FREQUENCY EXCEEDS A SENSIBLE LIMIT SKIP THE CREATION OF THIS FILTER AND END RECURSION
	
	aModF	butbp	aMod,icf,ibw*icf			;BANDPASS FILTER MODULATOR
	if gk12_24=24 then					;IF 24DB PER OCT MODE IS CHOSEN...
	  aModF	butbp	aModF,icf,ibw*icf			;...BANDPASS FILTER AGAIN TO SHARPEN CUTOFF SLOPES
	endif							;END OF THIS CONDITIONAL BRANCH
	aEnv 	follow2	aModF, 0.01, 0.01			;FOLLOW THE ENVELOPE OF THE FILTERED AUDIO

	aCarF	butbp	aCar,icf,ibw*icf			;BANDPASS FILTER CARRIER
	if gk12_24=24 then					;IF 24 DB PER OCT IS CHOSEN...
	  aCarF	butbp	aCarF,icf,ibw*icf			;...BANDPASS FILTER AGAIN TO SHARPEN CUTOFF SLOPES
	endif							;END OF THIS CONDITIONAL BRANCH
	
	if	icount < inum	then					;IF MORE FILTERS STILL NEED TO BE CREATED...
		amix	VocoderChannel	aMod,aCar,ibase,ibw,iincr,icount,inum	;...CALL UDO AGAIN WITH INCREMENTED COUNTER
	endif								;END OF THIS CONDITIONAL BRANCH
	SKIP:							;LABEL
		xout	(aCarF*aEnv) + amix
endop								;END OF UDO

instr	1	;SIMPLE SYNTH
	icps	cpsmidi				;READ MIDI NOTE IN CPS FORMAT
	aenv	linsegr	0,0.01,1,0.02,0		;CREATE A SIMPLE GATE-TYPE ENVELOPE

	if gkSynType=0 then			;IF SYNTH TYPE CHOSEN FROM BUTTON BANK GUI IS SAWTOOTH...
	  a1	vco2	1,icps			;...CREATE A SAWTOOTH WAVE TONE
	elseif gkSynType=1 then			;IF SYNTH TYPE CHOSEN FROM BUTTON BANK GUI IS SQUARE...
	  a1	vco2	1,icps,2,0.5		;...CREATE A SQUARE WAVE TONE
	elseif gkSynType=2 then			;IF SYNTH TYPE CHOSEN FROM BUTTON BANK GUI IS PULSE...
	  a1	vco2	1,icps,2,0.1		;...CREATE A PULSE WAVE TONE
	else					;OTHERWISE...
	  a1	pinkish	1			;...CREATE SOME PINK NOISE
	endif					;END OF THIS CONDITIONAL BRANCH
	gaCar	=	gaCar + (a1*aenv)	;APPLY ENVELOPE
endin

instr	2
	ktrig	changed	gkbase,gkbw,gknum,gkincr	;IF ANY OF THE INPUT VARIABLE ARE CHANGED GENERATE A MOMENTARY '1' VALUE (A BANG IN MAX-MSP LANGUAGE)
	if ktrig=1 then					;IF A CHANGED VALUE TRIGGER IS RECEIVED...
	  reinit UPDATE					;REINITIALISE THIS INSTRUMENT FROM THE LABEL 'UPDATE'
	endif						;END OF THIS CONDITIONAL BRANCH
	UPDATE:						;LABEL
	ibase	init	i(gkbase)			;CREATE AN INITIALISATION TIME VARIABLE FROM FLTK GUI CONTROL
	inum	init	i(gknum)			;CREATE AN INITIALISATION TIME VARIABLE FROM FLTK GUI CONTROL
	ibw	init	i(gkbw)				;CREATE AN INITIALISATION TIME VARIABLE FROM FLTK GUI CONTROL
	iincr	init	i(gkincr)			;CREATE AN INITIALISATION TIME VARIABLE FROM FLTK GUI CONTROL
	
	if gkModIn=0 then				;IF MODULATOR INPUT CHOSEN IS 'Vocal Sample'...
	  aMod	diskin2	"AndItsAll.wav",1,0,1		;...READ IN A SOUND FILE FROM HARD DISK
	elseif gkModIn=1 then				;IF MODULATOR INPUT CHOSEN IS 'Drum Loop'...
	  aMod	diskin2	"loop.wav",1,0,1		;...READ IN A SOUND FILE FROM HARD DISK
	else						;OTHERWISE...
	  aMod	inch	1				;READ LIVE AUDIO FROM THE COMPUTER'S LEFT INPUT CHANNEL
	endif						;END OF THIS CONDITIONAL BRANCH                                        
				
	if gkCarIn=0 then				;IF 'Internal Synth' IS CHOSEN FOR CARRIER INPUT... 
	  aCar	moogladder	gaCar,gkLPF,gkres	;... USE INTERNAL SYNTH AUDIO FROM INSTR 1 AND APPLY A LOW PASS FILTER
	else						;OTHERWISE...
	  aCar	inch	2				;READ LIVE AUDIO FROM THE COMPUTER'S RIGHT CHANNEL INPUT CHANNEL
	endif						;END OF THIS CONDITIONAL BRANCH

	icount	init	0				;INITIALISE THE FILTER COUNTER TO ZERO
		amix	VocoderChannel	aMod,aCar,ibase,ibw,iincr,icount,inum	;CALL 'VocoderChannel' UDO - (WILL RECURSE WITHIN THE UDO ITSELF FOR THEW REQUIRED NUMBER OF FILTERS
		
	;HIGH-PASS CHANNEL
	iHPcf	=	cpsmidinn(ibase+(inum*iincr)+1)	;HIGHPASS FILTER CUTOFF (ONE INCREMENT ABOVE THE HIGHEST BANDPASS FILTER)
	iHPcf	limit	iHPcf,2000,18000		;LIMIT THE HIGHPASS FILTER TO BE WITHIN SENSIBLE LIMITS
		prints "HPF %t%t Freq: %f %n",iHPcf	;PRINT INFORMATION ABOUT THE HIGHPASS FILTER CUROPFF TO THE TERMINAL

	aModHP	buthp	aMod, iHPcf			;HIGHPASS FILTER THE MODULATOR
	aEnv	follow2	aModHP,0.01,0.01		;FOLLOW THE HIGHPASS FILTERED MODULATOR'S AMPLITUDE ENVELOPE
	aCarHP	buthp	aCar, iHPcf			;HIGHPASS FILTER THE CARRIER
	amix	=	(amix*gkBPGain)+(aCarHP*aEnv*gkHPGain)	;MIX THE HIGHPASS FILTERED CARRIER WITH THE BANDPASS FILTERS. APPLY THE MODULATOR'S ENVELOPE.

		outs	amix,amix			;SEND AUDIO TO THE OUTPUTS
		clear	gaCar				;CLEAR THE INTERNAL SYNTH ACCUMULATING GLOBAL VARIABLE, READ FOR THE NEXT PERF. PASS
	rireturn					;RETURN FROM REINITIALISATION PASS. (NOT REALLY NEED AS THE endin FULFILS THE SAME FUNCTION.)
endin

</CsInstruments>

<CsScore>
i 2 0 3600	;VOCODER PLAYS FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>