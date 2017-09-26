; wgbowedbar.csd
; Written by Iain McCurdy, 2006. Updated 2014.

<CsoundSynthesizer>

<CsOptions>
-odac -M0 -dm0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;CONTROL SAMPLES
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0

;			LABEL |      WIDTH | HEIGHT | X | Y
		FLpanel	"wgbowedbar", 500,    550,    0,  0

;				FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkFLTK_MIDI, ihFLTK_MIDI	FLbutBank	4,      1,     2,     20,      40,    5,  5,     0,     1,    0,  -1
;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"MIDI", 	1,      6,     17,     50,     20,   23,   4
ih		 	FLbox  	"FLTK", 	1,      6,     17,     50,     20,   23,  24

;BUTTONS							ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkAmpLim,ihAmpLim	FLbutton	"Amplitude Limit",	1,    0,    22,    130,     23,   365,  5,    0,     1,      0,       -1
FLsetColor2	255, 255, 50, ihAmpLim		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES	LABEL  | WIDTH | HEIGHT | X |  Y
idamp		FLvalue	" ",      80,      18,    5,   75
idfreq		FLvalue	" ",      80,      18,    5,  125
idpos		FLvalue	" ",      80,      18,    5,  175
idbowpres	FLvalue	" ",      80,      18,    5,  225
idgain		FLvalue	" ",      80,      18,    5,  275
idconst		FLvalue	" ",      80,      18,    5,  325
idbowpos	FLvalue	" ",      80,      18,    5,  425
idlow		FLvalue	" ",      80,      18,    5,  475
idOutGain	FLvalue	" ",      80,      18,    5,  525

;SLIDERS				            						MIN |   MAX  | EXP | TYPE |  DISP    | WIDTH | HEIGHT | X  | Y
gkamp, ihamp			FLslider	"Amplitude",					0,        1,    0,    23,   idamp,      490,     25,    5,   50
gkfreq, ihfreq			FLslider	"Frequency",					20,   20000,   -1,    23,   idfreq,     490,     25,    5,  100
gkpos, ihpos			FLslider	"Bow Position On Bar",				0,        1,    0,    23,   idpos,      490,     25,    5,  150
gkbowpres, ihbowpres		FLslider	"Bow Pressure",					.1,        5,    0,    23,   idbowpres,  490,     25,    5,  200
gkgain,ihgain			FLslider 	"Gain Of Filter",  				0,       1,    0,    23,   idgain,     490,     25,    5,  250
gkconst,ihconst			FLslider 	"Integration Constant",				-1,       1,    0,    23,   idconst,    490,     25,    5,  300
gkbowpos,ihbowpos		FLslider 	"Bow Position Affecting Velocity Trajectory",	-1,       1,    0,    23,   idbowpos,   490,     25,    5,  400
gklow,ihlow			FLslider 	"Lowest Frequency Required",			20,    2000,    0,    23,   idlow,      490,     25,    5,  450
gkOutGain,ihOutGain		FLslider 	"Output Gain",					0,        1,    0,    23,   idOutGain,  490,     25,    5,  500

;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gktvel, ihtvel	FLcount  "Bow Velocity: 0=ADSR 1=Exponential",	0,     1,    1,       1,     2,     235,     30,   150,350,   -1


;SET_INITIAL_VALUES		VALUE | HANDLE
		FLsetVal_i	0.3, 	ihamp
		FLsetVal_i	400, 	ihfreq
		FLsetVal_i	.7, 	ihpos
		FLsetVal_i	3,	ihbowpres
		FLsetVal_i	.95, 	ihgain
		FLsetVal_i	0.2, 	ihconst
		FLsetVal_i	0, 	ihtvel
		FLsetVal_i	0, 	ihbowpos
		FLsetVal_i	20, 	ihlow
		FLsetVal_i	0.4, 	ihOutGain
		FLsetVal_i	1, 	ihAmpLim

		FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 400, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                       wgbowedbar                            ", 	1,      5,     14,    490,     20,    5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,     20,    5,  20
ih		 	FLbox  	"wgbowedbar is a wave guide physical model of a bowed bar     ", 	1,      5,     14,    490,     20,    5,  40
ih		 	FLbox  	"based on work by Perry Cook but re-coded for Csound by John  ", 	1,      5,     14,    490,     20,    5,  60
ih		 	FLbox  	"ffitch.                                                      ", 	1,      5,     14,    490,     20,    5,  80
ih		 	FLbox  	"The amplitude of the output created by wgbowedbar can be a   ", 	1,      5,     14,    490,     20,    5, 100
ih		 	FLbox  	"little unpredictable. I have therefore included an 'Amplitude", 	1,      5,     14,    490,     20,    5, 120
ih		 	FLbox  	"Limit' feature to protect against runaway amplitudes.        ", 	1,      5,     14,    490,     20,    5, 140
ih		 	FLbox  	"Increasing 'Gain of Filter' will create the sustained sound  ", 	1,      5,     14,    490,     20,    5, 160
ih		 	FLbox  	"associated with a bowed metal bar and it will also reduce the", 	1,      5,     14,    490,     20,    5, 180
ih		 	FLbox  	"attack of the note. Other parameters, such as 'Bow Position',", 	1,      5,     14,    490,     20,    5, 200
ih		 	FLbox  	"'Frequency' (note played), 'Amplitude', 'Bow Pressure' and   ", 	1,      5,     14,    490,     20,    5, 220
ih		 	FLbox  	"'Integration Value', also have an impact upon the model's    ", 	1,      5,     14,    490,     20,    5, 240
ih		 	FLbox  	"ability to self oscillate'. 'Bow Pressure' and, in           ", 	1,      5,     14,    490,     20,    5, 260
ih		 	FLbox  	"particular, 'Bow Position' influence the overtone that will  ", 	1,      5,     14,    490,     20,    5, 280
ih		 	FLbox  	"be driven from the bowed bar.                                ", 	1,      5,     14,    490,     20,    5, 300
ih		 	FLbox  	"The resulting sound from any particular combination of       ", 	1,      5,     14,    490,     20,    5, 320
ih		 	FLbox  	"parameters will always be somewhat unpredictable so          ", 	1,      5,     14,    490,     20,    5, 340
ih		 	FLbox  	"experimentation is recommended and caution, in respect to    ", 	1,      5,     14,    490,     20,    5, 360
ih		 	FLbox  	"ears and loudspeakers is advised.                            ", 	1,      5,     14,    490,     20,    5, 380
		FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

opcode	AmpLimit,a,aiii
 asig,imax,iatt,irel	xin
 krms		init	0
 kGainCtrl	init	1
 if krms>imax then
  kGainCtrl	limit	kGainCtrl - iatt, 0, 1
 else
  kGainCtrl	limit	kGainCtrl + irel, 0, 1
 endif
 asig	=	asig * kGainCtrl
 krms		rms	asig
	xout	asig
endop


instr	1		;wgbowedbar INSTRUMENT

	iMIDIActiveValue	=	1		;IF MIDI ACTIVATED
	iMIDIflag		=	0		;IF FLTK ACTIVATED
	mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 

	icps	cpsmidi				;READ MIDI PITCH VALUES - THIS VALUE CAN BE MAPPED TO GRAIN DENSITY AND/OR PITCH DEPENDING ON THE SETTING OF THE MIDI MAPPING SWITCHES
	ivel	veloc		0,1		;READ NOTE VELOCITY. WILL BE WITHIN THE RANGE 0 AND 1
	kbend	pchbend		0,2		;PITCH BEND VARIABLE (IN oct FORMAT)

	if gkFLTK_MIDI==0&&iMIDIflag==0 then 	;SENSE FLTK ON/OFF SWITCH & IF THIS IS NOT A MIDI NOTE
	 turnoff				;TURN OFF THIS INSTRUMENT IMMEDIATELY
	endif					;END OF THIS CONDITIONAL BRANCH
	if iMIDIflag==1&&gkFLTK_MIDI==1 then
	 turnoff
	endif				
	
	if iMIDIflag==1 then				;IF THIS IS A MIDI ACTIVATED NOTE...
	 icps	cpsmidi
	 iamp	ampmidi	1
	 kfreq = icps				;SET FUNDEMENTAL TO RECEIVED p4 RECEIVED FROM INSTR 1. I.E. MIDI PITCH
	 kamp = iamp * gkamp			;SET AMPLITUDE TO RECEIVED p5 RECEIVED FROM INSTR 1 (I.E. MIDI VELOCITY) MULTIPLIED BY FLTK SLIDER gkamp.
	else						;OTHERWISE...
		kamp = gkamp			;SET kamp TO FLTK SLIDER VALUE gkamp
		kfreq = gkfreq			;SET FUNDEMENTAL TO FLTK SLIDER gkfund
	endif						;END OF THIS CONDITIONAL BRANCH

	kSwitch		changed		gkconst, gktvel, gkbowpos, gklow
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	UPDATE			;BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE'
	endif
	UPDATE:
	
	abowedbar      	wgbowedbar 	kamp, kfreq, gkpos, gkbowpres, gkgain, i(gkconst), i(gktvel), i(gkbowpos), i(gklow)
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
	aenv	linsegr	1, 0.05, 0		;ANTI-CLICK ENVELOPE

	abowedbar	=	abowedbar * aenv
		
	if gkAmpLim==1 then
	 ;				INPUT     | AMP_LIMIT | ATTACK | RELEASE
	 abowedbar	AmpLimit	abowedbar,     0.9,      0.01,    0.01
	endif

	outs 		abowedbar * gkOutGain, abowedbar * gkOutGain
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT SUSTAINS REALTIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>