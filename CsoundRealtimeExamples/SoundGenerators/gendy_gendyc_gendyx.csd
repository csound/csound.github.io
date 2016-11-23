gendy_gendyc_gendyx.csd
Written by Iain McCurdy, 2012

<CsoundSynthesizer>

<CsOptions>
-odac --displays -M0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	16	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (1=MONO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0                                                             
;		LABEL                 | WIDTH | HEIGHT | X | Y
	FLpanel	"gendy gendyc gendyx",   500,    550,    0,  0

;BUTTONS					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"On/Off(MIDI)",	1,    0,    22,    120,     30,    5,  5,   -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idamp				FLvalue	"",       50,     17,    5,  65
idadpar				FLvalue	"",       50,     17,    5, 100
idddpar				FLvalue	"",       50,     17,    5, 135
idminfreq			FLvalue	"",       50,     17,    5, 170
idmaxfreq			FLvalue	"",       50,     17,    5, 205
idampscl			FLvalue	"",       50,     17,    5, 240
iddurscl			FLvalue	"",       50,     17,    5, 275
idcurveup			FLvalue	"",       50,     17,    5, 495
idcurvedown			FLvalue	"",       50,     17,    5, 530

;SLIDERS					        			MIN |  MAX | EXP | TYPE |  DISP    | WIDTH | HEIGHT | X   | Y 
gkamp,		ihamp		FLslider 	"Amplitude",			0,      1,    0,   23,   idamp,       490,     15,    5,    50
gkadpar,	ihadpar		FLslider 	"Amp.Dist.Parameter",		0.0001, 1,    0,   23,   idadpar,     490,     15,    5,    85
gkddpar,	ihddpar		FLslider 	"Dur.Dist.Parameter",		0.0001, 1,    0,   23,   idddpar,     490,     15,    5,   120
gkminfreq,	ihminfreq	FLslider 	"Minimum Frequency",		20, 20000,   -1,   23,   idminfreq,   490,     15,    5,   155
gkmaxfreq,	ihmaxfreq	FLslider 	"Maximum Frequency",		20, 20000,   -1,   23,   idmaxfreq,   490,     15,    5,   190
gkampscl,	ihampscl	FLslider 	"Amp.Scaling",			0,      1,    0,   23,   idampscl,    490,     15,    5,   225
gkdurscl,	ihdurscl	FLslider 	"Dur.Scaling",			0,      1,    0,   23,   iddurscl,    490,     15,    5,   260

;COUNTERS					     			MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkinitcps, ihinitcps		FLcount  	"Initial CPS (i-rate)", 1,    2000,   1,     10,     1,     150,     25,   50, 420,   -1 
gknum, ihnum			FLcount  	"Number of Points", 	1,    2000,   1,     10,     1,     150,     25,  300, 420,   -1 

gkcurveup,	ihcurveup	FLslider 	"Curve Up (gendyx)",		0,      2,    0,   23,   idcurveup,   490,     15,    5,   480
gkcurvedown,	ihcurvedown	FLslider 	"Curve Down (gendyx)",		0,      2,    0,   23,   idcurvedown, 490,     15,    5,   515

;GENERAL_TEXT_SETTINGS			isize, ifont, ialign, ired, igreen, iblue
			FLlabel		13,      1,       1,   255,  255,    255		;NUMBERS MADE INVISIBLE

;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkopcode, ihopcode	FLbutBank	13,     1,     3,     25,    3*15,   220,  2,    -1
gkampdist, ihampdist	FLbutBank	13,     1,     7,     25,    7*15,   110,300,    -1
gkdurdist, ihdurdist	FLbutBank	13,     1,     7,     25,    7*15,   340,300,    -1
gkMnoSt, ihMnoSt	FLbutBank	13,     1,     2,     25,    2*15,   320,  2,    -1

;GENERAL_TEXT_SETTINGS			isize, ifont, ialign, ired, igreen, iblue
			FLlabel		13,      5,      4,   0,      0,     0		;LABELS MADE VISIBLE AGAIN

;TEXT BOXES							TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 FLbox  	"Opcode:", 			1,      6,     12,     40,     15,  170,   0
ih		 FLbox  	"gendy ", 			1,      5,     12,     40,     15,  240,   0
ih		 FLbox  	"gendyc", 			1,      5,     12,     40,     15,  240,  15
ih		 FLbox  	"gendyx", 			1,      5,     12,     40,     15,  240,  30
ih		 FLbox  	"Mono  ", 			1,      5,     12,     40,     15,  340,   0+1
ih		 FLbox  	"Stereo", 			1,      5,     12,     40,     15,  340,  15+1
ih		 FLbox  	"Amplitude Distribution:", 	1,      6,     12,    100,     30,   10, 300
ih		 FLbox  	"LINEAR   ", 			1,      5,     12,     70,     15,  125, 300
ih		 FLbox  	"CAUCHY   ", 			1,      5,     12,     70,     15,  125, 315
ih		 FLbox  	"LOGIST   ", 			1,      5,     12,     70,     15,  125, 330
ih		 FLbox  	"HYPERBCOS", 			1,      5,     12,     70,     15,  125, 345
ih		 FLbox  	"ARCSINE  ", 			1,      5,     12,     70,     15,  125, 360
ih		 FLbox  	"EXPON    ", 			1,      5,     12,     70,     15,  125, 375
ih		 FLbox  	"SINUS    ", 			1,      5,     12,     70,     15,  125, 390
ih		 FLbox  	"Duration Distribution: ", 	1,      6,     12,    100,     30,  240, 300
ih		 FLbox  	"LINEAR   ", 			1,      5,     12,     70,     15,  355, 300
ih		 FLbox  	"CAUCHY   ", 			1,      5,     12,     70,     15,  355, 315
ih		 FLbox  	"LOGIST   ", 			1,      5,     12,     70,     15,  355, 330
ih		 FLbox  	"HYPERBCOS", 			1,      5,     12,     70,     15,  355, 345
ih		 FLbox  	"ARCSINE  ", 			1,      5,     12,     70,     15,  355, 360
ih		 FLbox  	"EXPON    ", 			1,      5,     12,     70,     15,  355, 375
ih		 FLbox  	"SINUS    ", 			1,      5,     12,     70,     15,  355, 390

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	0.3,	ihamp		 	
				FLsetVal_i	0, 	ihampdist	
				FLsetVal_i	0, 	ihdurdist	
				FLsetVal_i	0.0001,	ihadpar		                               
				FLsetVal_i	0.0001,	ihddpar		                                   
				FLsetVal_i	230, 	ihminfreq	
				FLsetVal_i	330, 	ihmaxfreq	
				FLsetVal_i	0.3, 	ihampscl	
				FLsetVal_i	0.4, 	ihdurscl
				FLsetVal_i	12, 	ihinitcps
				FLsetVal_i	12, 	ihnum
				FLsetVal_i	0, 	ihcurveup
				FLsetVal_i	0, 	ihcurvedown
				FLsetVal_i	1, 	ihMnoSt
				FLpanel_end             
;INSTRUCTIONS AND INFO PANEL                            
				FLpanel	" ", 512, 545, 512, 0
				FLscroll     512, 545, 0,   0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                    gendy gendyc gendyx                      ", 	1,      6,     14,    490,    20,     5,   2
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      6,     14,    490,    20,     5,  20
ih		 	FLbox  	"'gendy', 'gendyc' and 'gendyx' (from 'Génération Dynamique   ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"Stochastique' (GENDYN)) are implementations of a dynamic     ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"stochastic method of waveform synthesis conceived by Iannis  ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"Xenakis.                                                     ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"A waveform is generated with modulations of pitch, referred  ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"to as perturbations, determined according to their amplitude ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"and duration. Perturbations are governed by a choice made of ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"distribution. There are seven distributions to choose from.  ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"Further to the choice of distribution made, a distribution   ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"parameter for each modifies it nature.                       ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"The range of values from which frequency modulations can be  ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"chosen is restricted using the minimum and maximum frequency ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"sliders.                                                     ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"'Initial CPS' (i-rate) sets the maximum number of control    ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"points (nodes) in a waveform and 'Number of Points' defines  ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"the number of points in a single cycle of the waveform.      ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"'gendy' uses linear interpolation when modulating, 'gendyc'  ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"uses cubic interpolation and 'gendyx' allows the user to     ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"continuously morph between stepped changes, concave curved   ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"changes, linear changes (as 'gendy' and convex changes.      ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"'gendyx' rising curves are defined as follows:               ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"  0 = stepped                                                ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	" <1 = concave                                                ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"  1 = linear                                                 ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	" >1 = convex                                                 ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"falling curves as:                                           ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"  0 = stepped                                                ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	" <1 = convex                                                 ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"  1 = linear                                                 ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	" >1 = concave                                                ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"In MIDI mode frequency is defined by the note played and     ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"frequency modulation away from that frequency is defined     ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"by the separation between 'Minimum Frequency' and 'Maximum   ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"Frequency', precise values are irrelevant.                   ", 	1,      5,     14,    490,    20,     5, 700
				FLscroll_end
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1
	iMIDIActiveValue	=	1		;IF MIDI ACTIVATED
	iMIDIflag		=	0		;IF FLTK ACTIVATED
	mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 

	if iMIDIflag==1 then
	 icps	cpsmidi
	 kminfreq	=	icps
	 kmaxfreq	=	icps*gkmaxfreq/gkminfreq
	else
	 kminfreq	=	gkminfreq
	 kmaxfreq	=	gkmaxfreq
	endif
	
	kEnv	linsegr	0,0.05,1,0.1,0
	kamp	=	gkamp*kEnv
	
	if gkOnOff==0&&iMIDIflag==0 goto SKIP			;IF ON/OFF IS OFF GO TO SKIP LABEL
	kchanged	changed	gkinitcps	;IF INITIAL CPS IS CHANGED GENERATE A TRIGGER...
	if kchanged==1 then 			;IF A TRIGGER IS DETECTED...
	 reinit UPDATE				;BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE'
	endif					
	UPDATE:					;LABEL - REINITIALISATION BEGINS FROM HERE
	if gkopcode==0 then			;IF gendy IS CHOSEN...
	 ares	gendy	kamp, gkampdist, gkdurdist, gkadpar, gkddpar, kminfreq, kmaxfreq, gkampscl, gkdurscl, i(gkinitcps), gknum
	 if gkMnoSt==1 then
	  aR	gendy	kamp, gkampdist, gkdurdist, gkadpar, gkddpar, kminfreq, kmaxfreq, gkampscl, gkdurscl, i(gkinitcps), gknum
	 endif
	elseif gkopcode==1 then			;IF gendyc IS CHOSEN...
	 ares	gendyc	kamp, gkampdist, gkdurdist, gkadpar, gkddpar, kminfreq, kmaxfreq, gkampscl, gkdurscl, i(gkinitcps), gknum
	 if gkMnoSt==1 then
	  aR	gendyc	kamp, gkampdist, gkdurdist, gkadpar, gkddpar, kminfreq, kmaxfreq, gkampscl, gkdurscl, i(gkinitcps), gknum
	 endif
	else					;OTHERWISE gendyx IS CHOSEN
	 ares	gendyx	kamp, gkampdist, gkdurdist, gkadpar, gkddpar, kminfreq, kmaxfreq, gkampscl, gkdurscl,gkcurveup, gkcurvedown, i(gkinitcps), gknum
	 if gkMnoSt==1 then
	  aR	gendyx	kamp, gkampdist, gkdurdist, gkadpar, gkddpar, kminfreq, kmaxfreq, gkampscl, gkdurscl,gkcurveup, gkcurvedown, i(gkinitcps), gknum
	 endif
	endif
	if gkMnoSt==1 then
		outs	ares,aR			;SEND AUDIO TO OUTPUT
	else
		outs	ares,ares			;SEND AUDIO TO OUTPUT
	endif
	SKIP:
endin

</CsInstruments>

<CsScore>                                    
i 1 0 3600	;INSTR 1 PLAYS FOR 1 HOUR. (AND KEEPS PERFORMANCE GOING)
</CsScore>

</CsoundSynthesizer>