HarmonicAdditiveSynthesis1.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-odac -M0 -+rtmidi=virtual -dm0
;DISABLE VIRTUAL MIDI FOR EXTERNAL MIDI CONTROL
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM SOUND INTENSITY LEVEL

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL                 | WIDTH | HEIGHT | X | Y
		FLpanel	"Additive Synthesis 1",  500,    500,    0,  0

;SWITCHES                                            				ON | OFF | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE | INS | STARTTIM | DUR	p4	p5	p6	p7	p8	p9	p10	p11	p12	p13	p14	p15	p16	p17	p18	p19	p20	p21	p22	p23	p24	p25	p26	p27	p28	p29	p30	p31	p32	p33
gkFLTK_MIDI,ihFLTK_MIDI		FLbutton	"ON (FLTK) / OFF (MIDI)",	1,    0,    22,    180,     25,    5,    5,    0,     1,      0,      3600
FLsetColor2	255, 255, 50, ihFLTK_MIDI	;SET SECONDARY COLOUR TO YELLOW
gkReset,ihReset			FLbutton	"Reset",		1,    0,    21,     80,     22,  415,  420,    0,      4,      0,      0.01

;VALUE_DISPLAY_BOXES			 WIDTH | HEIGHT | X | Y
idfund			FLvalue	" ",     50,     18,     5, 320
idamp			FLvalue	" ",     50,     18,     5, 370
idwarp			FLvalue	" ",     50,     18,     5, 420
idrnd			FLvalue	" ",     50,     18,     5, 470

;SLIDERS					            				MIN | MAX | EXP | TYPE | DISP  | WIDTH | HEIGHT | X   | Y
gkPartAmp1, ihPartAmp1		FLslider 	"1",					0,     1,    0,    24,    -1,      25,    245,   120,   35
gkPartAmp2, ihPartAmp2		FLslider 	"2",					0,     1,    0,    24,    -1,      25,    245,   145,   35
gkPartAmp3, ihPartAmp3		FLslider 	"3",					0,     1,    0,    24,    -1,      25,    245,   170,   35
gkPartAmp4, ihPartAmp4		FLslider 	"4",					0,     1,    0,    24,    -1,      25,    245,   195,   35
gkPartAmp5, ihPartAmp5		FLslider 	"5",					0,     1,    0,    24,    -1,      25,    245,   220,   35
gkPartAmp6, ihPartAmp6		FLslider 	"6",					0,     1,    0,    24,    -1,      25,    245,   245,   35
gkPartAmp7, ihPartAmp7		FLslider 	"7",					0,     1,    0,    24,    -1,      25,    245,   270,   35
gkPartAmp8, ihPartAmp8		FLslider 	"8",					0,     1,    0,    24,    -1,      25,    245,   295,   35
gkPartAmp9, ihPartAmp9		FLslider 	"9",					0,     1,    0,    24,    -1,      25,    245,   320,   35
gkPartAmp10,ihPartAmp10		FLslider 	"10",					0,     1,    0,    24,    -1,      25,    245,   345,   35
gkfund, ihfund			FLslider 	"Fundemental (Hertz)",			20,   10000,-1,    23,  idfund,   490,     20,     5,  300
gkamp,  ihamp			FLslider 	"Global Amplitude",			0,     1,    0,    23,  idamp,    490,     20,     5,  350
gkwarp, gihwarp			FLslider 	"Warp Partial Spacings",		0,     2,    0,    23,  idwarp,   490,     20,     5,  400
gkrnd, ihrnd			FLslider 	"Partial Spacings Random Factor",	0,     1,    0,    23,  idrnd,    490,     20,     5,  450

;TEXT BOXES              			TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y 
ih		 FLbox  "Partial Strength:", 	1,      9,     12,    90,     10,    25, 281

;SET_INITIAL_VALUES		VALUE 	       | HANDLE
		FLsetVal_i	1-.55, 		ihPartAmp1	
		FLsetVal_i	1-.55, 		ihPartAmp2	
		FLsetVal_i	1-.9, 		ihPartAmp3	
		FLsetVal_i	1-.45, 		ihPartAmp4	
		FLsetVal_i	1-.5,		ihPartAmp5	
		FLsetVal_i	1-.5, 		ihPartAmp6	
		FLsetVal_i	1-.8, 		ihPartAmp7	
		FLsetVal_i	1-.3, 		ihPartAmp8	
		FLsetVal_i	1-.3, 		ihPartAmp9	
		FLsetVal_i	1-.3, 		ihPartAmp10     
		FLsetVal_i	440, 		ihfund
		FLsetVal_i	0.05, 		ihamp     
		FLsetVal_i	1, 		gihwarp
		FLsetVal_i	0, 		ihrnd

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 560, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"           Additive Synthesis 1 - 10 Harmonics               ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"Additive synthesis is the technique whereby sine waves of    ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"different frequencies are mixed and manipulated in such a way", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"that they are perceived fused and seem to form a new, more   ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"complex tone. The inspiration for additive synthesis comes   ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"from Fourier theory that states that any sound can be        ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"replicated as a composite of sine waves of various           ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"frequencies and phases.                                      ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"In harmonic additive synthesis the sequence of frequencies   ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"followed by the different sine wave oscillators follows that ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"of the harmonic series in that each harmonic is a product of ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"the fundemental. For example: if the fundemental of a        ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"harmonic tone is 100 Hz. then its 1st harmonic will be at    ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"200 Hz. its 2nd at 300 Hz and so on.                         ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"This example offers the user manipulation of the first 10    ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"harmonics but to synthesize bright timbres rich in higher    ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"harmonics such as a violin this number will be insufficient. ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"The next example which utilises more partials, demonstrates  ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"ways in which the fusion of partials can be enhanced but also", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"draws attention to the shortcomings of additive synthesis.   ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"Note that the fundemental can also be referred to as the 1st ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"partial, the 1 harmonic as the 2nd partial and so on.        ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"Partial spacings can be modified in two ways. 'Warp Partial  ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"Spacings' compresses or expands partials spacings depending  ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"upon whether its value is less than or greater than 1.       ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"'Partial Spacings Random Factor' multiplies a unique random  ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"value to each partial frequency.                             ", 	1,      5,     14,    490,    15,     5, 540

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen	0, 0, 4096, 10, 1	;A SINE WAVE

instr	2	;PARTIAL SPACINGS RANDOM FACTORS (ALWAYS ON)
	irnd1	gauss	1	;RANDOM FACTORS
	irnd2	gauss	1	;RANDOM FACTORS
	irnd3	gauss	1	;RANDOM FACTORS
	irnd4	gauss	1	;RANDOM FACTORS
	irnd5	gauss	1	;RANDOM FACTORS
	irnd6	gauss	1	;RANDOM FACTORS
	irnd7	gauss	1	;RANDOM FACTORS
	irnd8	gauss	1	;RANDOM FACTORS
	irnd9	gauss	1	;RANDOM FACTORS
	irnd10	gauss	1	;RANDOM FACTORS

	gkrnd1	=	1+(irnd1*gkrnd) 
	gkrnd2	=	1+(irnd2*gkrnd) 
	gkrnd3	=	1+(irnd3*gkrnd) 
	gkrnd4	=	1+(irnd4*gkrnd) 
	gkrnd5	=	1+(irnd5*gkrnd) 
	gkrnd6	=	1+(irnd6*gkrnd) 
	gkrnd7	=	1+(irnd7*gkrnd) 
	gkrnd8	=	1+(irnd8*gkrnd) 
	gkrnd9	=	1+(irnd9*gkrnd) 
	gkrnd10	=	1+(irnd10*gkrnd) 
endin

instr 	1	;SYNTHESIS INSTRUMENT (FLTK AND MIDI)
	kporttime	linseg	0,0.01,0.05		;PORTAMENTO TIME RAMPS UP QUICKLY FROM ZERO
	iMIDIActiveValue	=	1		;IF MIDI ACTIVATED
	iMIDIflag		=	0		;IF FLTK ACTIVATED
	mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 

	icps	cpsmidi				;READ MIDI PITCH VALUES - THIS VALUE CAN BE MAPPED TO GRAIN DENSITY AND/OR PITCH DEPENDING ON THE SETTING OF THE MIDI MAPPING SWITCHES
	ivel	veloc		0,1		;READ NOTE VELOCITY. WILL BE WITHIN THE RANGE 0 AND 1
	kbend	pchbend		0,2		;PITCH BEND VARIABLE (IN oct FORMAT)

	if gkFLTK_MIDI==0&&iMIDIflag==0 then 	;SENSE FLTK ON/OFF SWITCH & WHETHER THIS IS A MIDI NOTE ITS STATUS WILL BE IGNORED
	 turnoff				;TURN OFF THIS INSTRUMENT IMMEDIATELY
	endif					;END OF THIS CONDITIONAL BRANCH

	if iMIDIflag==1 then				;IF THIS IS A MIDI ACTIVATED NOTE...
		kfund	=	icps*semitone(kbend)	;MAP MIDI NOTE VALUE TO WGUIDE1 FREQUENCY
		kamp	=	gkamp * ivel
	else						;OTHERWISE...
		kfund		portk	gkfund, kporttime		;SMOOTH VARIABLE CHANGES WITH PORTK
		kamp		portk	gkamp, kporttime		;APPLY PORTAMENTO SMOOTHING
	endif						;END OF THIS CONDITIONAL BRANCH

	;SEPARATE OSCILLATORS CREATE EACH OF THE PARTIALS. EACH PARTIAL FOLLOWS THE HARMONIC SERIES 
	;OUTPUT		OPCODE	AMPLITUDE             | FREQUENCY                      | FUNCTION_TABLE
	apart1		oscili	kamp*(1-gkPartAmp1),   kfund * gkrnd1, 		             gisine		;FUNDEMENTAL
	apart2		oscili	kamp*(1-gkPartAmp2),  (kfund+(kfund*gkwarp)) * gkrnd2, 	     gisine		;1ST HARMONIC
	apart3		oscili	kamp*(1-gkPartAmp3),  (kfund+(kfund*2*gkwarp)) * gkrnd3,      gisine       	;2ND HARMONIC
	apart4		oscili	kamp*(1-gkPartAmp4),  (kfund+(kfund*3*gkwarp)) * gkrnd4,      gisine       	;3RD HARMONIC
	apart5		oscili	kamp*(1-gkPartAmp5),  (kfund+(kfund*4*gkwarp)) * gkrnd5,      gisine       	;4TH HARMONIC
	apart6		oscili	kamp*(1-gkPartAmp6),  (kfund+(kfund*5*gkwarp)) * gkrnd6,      gisine       	;5TH HARMONIC
	apart7		oscili	kamp*(1-gkPartAmp7),  (kfund+(kfund*6*gkwarp)) * gkrnd7,      gisine       	;6TH HARMONIC
	apart8		oscili	kamp*(1-gkPartAmp8),  (kfund+(kfund*7*gkwarp)) * gkrnd8,      gisine       	;7TH HARMONIC
	apart9		oscili	kamp*(1-gkPartAmp9),  (kfund+(kfund*8*gkwarp)) * gkrnd9,      gisine       	;8TH HARMONIC
	apart10      	oscili	kamp*(1-gkPartAmp10), (kfund+(kfund*9*gkwarp)) * gkrnd10,     gisine       	;9TH HARMONIC
	
	;SUM THE 10 OSCILLATORS:
	amix		sum	apart1,\
				apart2,\
				apart3,\
				apart4,\
				apart5,\
				apart6,\
				apart7,\
				apart8,\
				apart9,\
				apart10
	aenv	linsegr	0,0.01,1,0.1,0	;CREATE AN AMPLITUDE ENVELOPE WITH 'ANTI CLICK' ATTACK AND A RELEASE SEGMENT 
	outs	amix*aenv, amix*aenv	;SEND MIXED SIGNAL MULTIPLIED BY THE AMPLITUDE ENVELOPE TO THE OUTPUTS
endin		

instr	4	;SET WARP SLIDER TO '1'
	FLsetVal_i	1, gihwarp
endin

</CsInstruments>

<CsScore>
i 2 0 3600	;PARTIAL SPACINGS RANDOM FACTORS INSTRUMENTS PLAYS A NOTE FOR 1 HOUR (AND KEEPS PERFORMANCE GOING)
</CsScore>

</CsoundSynthesizer>