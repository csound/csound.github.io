;PIANO PHASE BY STEVE REICH 
;CSOUND IMPLEMENTATION BY IAIN MCCURDY, 2010

<CsoundSynthesizer>

<CsOptions>
;INSERT YOUR CSOUND OPTIONS PREFERENCES HERE
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100
ksmps 		= 	8
nchnls 		= 	2

FLcolor	255, 255, 255, 0, 0, 0
;		LABEL         | WIDTH | HEIGHT | X | Y
	FLpanel	"Piano Phase",  1400,    680,    0,  0

;SWITCHES                                			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff			FLbutton	"On/Off",	1,    0,    22,     140,     25,    5,  5,    0,     1,      0,      -1
gkAutoPhase1,ihAutoPhase1	FLbutton	"Auto Phase 1",	1,    0,    22,     140,     25,    5,320,   -1
gkAutoPhase2,ihAutoPhase2	FLbutton	"Auto Phase 1",	1,    0,    22,     140,     25,  705,320,   -1
gkLinkTempi,ihLinkTempi		FLbutton	"Link Tempi",	1,    0,    22,     140,     25,  630,  5,   -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihAutoPhase1	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihAutoPhase2	;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihLinkTempi	;SET SECONDARY COLOUR TO YELLOW

;NUMBER DISPLAY BOXES			WIDTH | HEIGHT | X | Y
idphs1	  	FLvalue   " ",     	70,       18,    5, 75
idphs2	  	FLvalue   " ",     	70,       18,    5,125
idrate1	  	FLvalue   " ",     	70,       18,  155,345
idrate2	  	FLvalue   " ",     	70,       18,  855,345

;SLIDERS								MIN | MAX | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X   | Y
gkphs1, gihphs1		FLslider	"Phase 1 Offset (semiquavers)",	0,    12,    0,   25,     idphs1,     1400,     25,    0,    50
gkphs2, gihphs2		FLslider	"Phase 2 Offset (semiquavers)",	0,    12,    0,   25,     idphs2,     1400,     25,    0,   100
gkamp1, ihamp1		FLslider	"Piano 1 Gain",			0,    1,     0,   23,     -1,          690,     25,    5,   150
gkamp2, ihamp2		FLslider	"Piano 2 Gain",			0,    1,     0,   23,     -1,          690,     25,  705,   150
gkbal1, ihbal1		FLslider	"Piano 1 Balance",		0,    1,     0,   23,     -1,          690,     25,    5,   200
gkbal2, ihbal2		FLslider	"Piano 2 Balance",		0,    1,     0,   23,     -1,          690,     25,  705,   200
gkrate1, ihrate1	FLslider	"Rate 1",			-1,   1,     0,   23,     idrate1,     540,     25,  155,   320
gkrate2, ihrate2	FLslider	"Rate 2",			-1,   1,     0,   23,     idrate2,     540,     25,  855,   320
;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X  | Y  | OPCODE
gktrans1, ihtrans1 	FLcount  	"Transpose 1 (Semitones)", 	-24,   24,    1,     12,      1,    140,      25,    5, 250,   -1
gktrans2, ihtrans2 	FLcount  	"Transpose 2 (Semitones)", 	-24,   24,    1,     12,      1,    140,      25,  705, 250,   -1
gkfine1, ihfine1 	FLcount  	"Fine Tune 1 (Cents)", 		-100, 100,    1,     10,      1,    140,      25,  155, 250,   -1
gkfine2, ihfine2 	FLcount  	"Fine Tune 2 (Cents)", 		-100, 100,    1,     10,      1,    140,      25,  855, 250,   -1
gktempo1, gihtempo1 	FLcount  	"Tempo 1", 			0,    999,    1,     10,      1,    140,      25,  450,   5,   -1
gktempo2, gihtempo2 	FLcount  	"Tempo 2", 			0,    999,    1,     10,      1,    140,      25,  805,   5,   -1

; INITIAL VALUES OF SLIDERS
;OPCODE		VALUE | HANDLE
FLsetVal_i   	0, 	gihphs1
FLsetVal_i   	0, 	gihphs2
FLsetVal_i   	1, 	ihamp1
FLsetVal_i   	1, 	ihamp2
FLsetVal_i   	0.5, 	ihbal1
FLsetVal_i   	0.5, 	ihbal2
FLsetVal_i   	0, 	ihtrans1
FLsetVal_i   	0, 	ihtrans2
FLsetVal_i   	0, 	ihfine1
FLsetVal_i   	0, 	ihfine2
FLsetVal_i   	120, 	gihtempo1
FLsetVal_i   	120, 	gihtempo2
FLsetVal_i   	0, 	ihrate1
FLsetVal_i   	0, 	ihrate2

FLcolor	220, 255, 220, 0, 0, 0
;TEXT BOXES											                                                        					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                                                                             Piano Phase                                                                    ", 	1,      5,     14,   1400,    20,     5,  400
ih		 	FLbox  	"------------------------------------------------------------------------------------------------------------------------------------------------------------", 	1,      5,     14,   1400,    20,     5,  420
ih		 	FLbox  	"This example is an implementation of the piece 'Piano Phase' by the composer Steve Reich in which two pianos loop the same 1 bar motif but with one of the  ", 	1,      5,     14,   1400,    20,     5,  440
ih		 	FLbox  	"pianists occasionionally increasing his own tempo with respect to that of the other pianist so that his pattern 'overtakes' that of the other pianist to    ", 	1,      5,     14,   1400,    20,     5,  460
ih		 	FLbox  	"create a new phase relationship. This Csound implementation uses FFT resynthesis of an analysis of a recording of the pattern in order to allow the user to ", 	1,      5,     14,   1400,    20,     5,  480
ih		 	FLbox  	"freely warp tempo and phase without inducing pitch warping. The two voices feature source recordings of the pattern played on two different pianos in order ", 	1,      5,     14,   1400,    20,     5,  500
ih		 	FLbox  	"to prevent artificiality when both pianos are exactly in phase with one another. Firstly the user should explore different phase relationships by dragging  ", 	1,      5,     14,   1400,    20,     5,  520
ih		 	FLbox  	"the Phase Offset slider of one of the pianos to different locations. Phase offset values are given in semiquavers from 0 - 12 in order to reflect the 12    ", 	1,      5,     14,   1400,    20,     5,  540
ih		 	FLbox  	"semiquaver motif from which the piece derives. It will be noticed that when both phase offset values are a whole number apart a rhythmic coherence results. ", 	1,      5,     14,   1400,    20,     5,  560
ih		 	FLbox  	"Phase offset for each voice can be automated by activating 'Auto Phase' and setting the 'Rate' slider. A constantly shifting phase relationship between the ", 	1,      5,     14,   1400,    20,     5,  580
ih		 	FLbox  	"two voices can also be achieved by slightly offsetting the tempo of one of the voices with respect to the other. The two tempi can also by synchronized by  ", 	1,      5,     14,   1400,    20,     5,  600
ih		 	FLbox  	"activating the 'Link Tempi' button.                                                                                                                         ", 	1,      5,     14,   1400,    20,     5,  620
ih		 	FLbox  	"The relationships between the two voices can be further explored through the individual 'Gain', 'Balance', 'Transpose' and 'Fine Tune' controls for each    ", 	1,      5,     14,   1400,    20,     5,  640
ih		 	FLbox  	"voice.                                                                                                                                                      ", 	1,      5,     14,   1400,    20,     5,  660

	FLpanel_end

	FLrun

instr	1
	if	gkOnOff=0	then	;IF ON/OFF SWITCH IS 'OFF'...
		turnoff			;TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif				;END OF CONDITIONAL BRANCHING

	if	gkLinkTempi==1	then	;IF 'LINK TEMPI' IS ACTIVE...
		ktrig1	changed	gktempo1	;IF TEMPO 1 IS CHANGED ktrig1 IS A MOMENTARY '1'
		ktrig2	changed	gktempo2	;IF TEMPO 2 IS CHANGED ktrig2 IS A MOMENTARY '1'
		FLsetVal	ktrig1, gktempo1, gihtempo2	;UPDATE TEMPO 2 WITH THE VALUE OF TEMPO 1 IF TEMPO 1 HAS BEEN CHANGED
		FLsetVal	ktrig2, gktempo2, gihtempo1	;UPDATE TEMPO 1 WITH THE VALUE OF TEMPO 2 IF TEMPO 2 HAS BEEN CHANGED
	endif
	
	kporttime	linseg		0,.01,.01,1, .01	;RAPMING UP VALUE THAT WILL BE USED FOR PORTAMENTO TIME
	
	ilen		=		1.636			;LENGTH OF LOOP
	
	;LOOP 1===================================================================================================================================
	kPBratio1	=	gktempo1/120				;PLAYBACK SPEED RATIO
	if		gkAutoPhase1==0	then				;IF 'AUTO PHASE' IS NOT ACTIVE...
		kphs1		portk		gkphs1/12, kporttime	;PHASE WILL BE SLIDER PHASE VALUE (WITH PORTAMENTO SMOOTHING)
	elseif		gkAutoPhase1==1	then				;IF 'AUTO PHASE' IS ACTIVE...
		kphs1	phasor	gkrate1					;PHASE WILL BE DERIVE FROM A MOVING PHASE VALUE GENERATOR
		kupdate1	metro	20				;RATE OF SLIDER UPDATE (USED FOR VISUAL FEEDBACK ONLY)
		FLsetVal	kupdate1, kphs1*12, gihphs1		;UPDATE ON-SCREEN SLIDER
	endif								;END OF CONDITIONAL BRANCHING
	aptr1		osciliktp 	kPBratio1/ilen, 1, kphs1	;CREATE POINTER FOR READING FFT ANALYSIS FILE
	kptr1		downsamp	aptr1				;DOWN-SAMPLE TO K-RATE
	fsig1L  	pvsfread	kptr1*ilen, "PPhase1.pvx", 0					;READ FFT ANALYSIS FILE         
	fsig1L2		pvscale		fsig1L, cpsoct(8+(gktrans1/12)+(gkfine1/1200))/cpsoct(8)	;RESCALE PITCH                  
	asig1L 		pvsynth  	fsig1L2								;RESYNTHESIZE TO AN AUDIO SIGNAL
	fsig1R  	pvsfread	kptr1*ilen, "PPhase1.pvx", 1					;READ FFT ANALYSIS FILE         
	fsig1R2		pvscale		fsig1R, cpsoct(8+(gktrans1/12)+(gkfine1/1200))/cpsoct(8)        ;RESCALE PITCH                  
	asig1R 		pvsynth  	fsig1R2                                                         ;RESYNTHESIZE TO AN AUDIO SIGNAL
	;=========================================================================================================================================
	
	;LOOP 1===================================================================================================================================
	kPBratio2	=	gktempo2/120				;PLAYBACK SPEED RATIO                                        
	if		gkAutoPhase2==0	then                            ;IF 'AUTO PHASE' IS NOT ACTIVE...                            
		kphs2		portk		gkphs2/12, kporttime    ;PHASE WILL BE SLIDER PHASE VALUE (WITH PORTAMENTO SMOOTHING)
	elseif		gkAutoPhase2==1	then                            ;IF 'AUTO PHASE' IS ACTIVE...                                
		kphs2	phasor	gkrate2                                 ;PHASE WILL BE DERIVE FROM A MOVING PHASE VALUE GENERATOR    
		kupdate2	metro	20                              ;RATE OF SLIDER UPDATE (USED FOR VISUAL FEEDBACK ONLY)       
		FLsetVal	kupdate2, kphs2*12, gihphs2             ;UPDATE ON-SCREEN SLIDER                                     
	endif                                                           ;END OF CONDITIONAL BRANCHING                                
	aptr2		osciliktp 	kPBratio2/ilen, 1, kphs2        ;CREATE POINTER FOR READING FFT ANALYSIS FILE                
	kptr2		downsamp	aptr2                           ;DOWN-SAMPLE TO K-RATE                                       
	fsig2L  	pvsfread	kptr2*ilen, "PPhase2.pvx", 0					;READ FFT ANALYSIS FILE         
	fsig2L2		pvscale		fsig2L, cpsoct(8+(gktrans2/12)+(gkfine2/1200))/cpsoct(8)        ;RESCALE PITCH                  
	asig2L 		pvsynth  	fsig2L2                                                         ;RESYNTHESIZE TO AN AUDIO SIGNAL
	fsig2R  	pvsfread	kptr2*ilen, "PPhase2.pvx", 1                                        ;READ FFT ANALYSIS FILE         
	fsig2R2		pvscale		fsig2R, cpsoct(8+(gktrans2/12)+(gkfine2/1200))/cpsoct(8)        ;RESCALE PITCH                  
	asig2R 		pvsynth  	fsig2R2                                                         ;RESYNTHESIZE TO AN AUDIO SIGNAL
	;=========================================================================================================================================
	
	kamp1		lineto		gkamp1, 0.05	;SMOOTH VARIABLE FROM FLTK SLIDER
	kamp2		lineto		gkamp2, 0.05    ;SMOOTH VARIABLE FROM FLTK SLIDER
	kbal1		lineto		gkbal1, 0.05    ;SMOOTH VARIABLE FROM FLTK SLIDER
	kbal2		lineto		gkbal2, 0.05    ;SMOOTH VARIABLE FROM FLTK SLIDER	
		
	gamixL		sum		asig1L*kamp1*(1-kbal1), asig2L*kamp2*(1-kbal2)	;CREATE LEFT CHANNEL MIX 
	gamixR		sum		asig1R*kamp1*kbal1,     asig2L*kamp2*kbal2	;CREATE RIGHT CHANNEL MIX 
endin

instr		2	;REVERB
	gkRoomSize	=		.85
	gkHFDamp	=		.5
	gkmix		=		.5
			denorm		gamixL, gamixR		;DENORMALIZE BOTH CHANNELS OF AUDIO SIGNAL
	arvbL, arvbR 	freeverb 	gamixL, gamixR, gkRoomSize, gkHFDamp , sr
	amixL		ntrpol		gamixL, arvbL, gkmix	;CREATE A DRY/WET MIX BETWEEN THE DRY AND THE REVERBERATED SIGNAL
	amixR		ntrpol		gamixR, arvbR, gkmix	;CREATE A DRY/WET MIX BETWEEN THE DRY AND THE REVERBERATED SIGNAL
			outs		amixL, amixR
	clear		gamixL, gamixR
endin

</CsInstruments>

<CsScore>
f 1 0 1048576 7 0 1048576 1	;A SINGLE CYCLE OF A RISING SAWTOOTH
i 2 0 3600	;REVERB INSTRUMENT PLAYS A NOTE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>