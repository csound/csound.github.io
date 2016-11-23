vco_with_PWM_and_LPF.csd
Written by Iain McCurdy, 2006

<CsoundSynthesizer>

<CsOptions>
-odac -dm0 -M0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>                                                           

sr 	= 	44100  
ksmps 	= 	32
nchnls 	= 	2	
0dbfs	=	1	;MAXIMUM AMPLITUDE
                                                                                           
;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL   | WIDTH | HEIGHT | X | Y
		FLpanel	"VCO with PWM LFO and Moog Low Pass Filter",     512,    600,    0,  0
;				FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkFLTK_MIDI, ihFLTK_MIDI	FLbutBank	4,      1,     2,     20,      40,    5,  5,     0,     2,    0,  -1
;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"MIDI", 	1,      6,     17,     50,     20,   23,   4
ih		 	FLbox  	"FLTK", 	1,      6,     17,     50,     20,   23,  24

;VALUE DISPLAY BOXES			WIDTH | HEIGHT | X | Y                                 
idcps			FLvalue	" ",      70,     20,    5, 125
idleak			FLvalue	" ",      70,     20,    5, 175
idnyx			FLvalue	" ",      70,     20,    5, 225
idpw			FLvalue	" ",      70,     20,    5, 275
idPWMamt		FLvalue	" ",      70,     20,    5, 325
idPWMspd		FLvalue	" ",      70,     20,    5, 375
idMVCFcf		FLvalue	" ",      70,     20,    5, 425
idMVCFres		FLvalue	" ",      70,     20,    5, 475
idgain			FLvalue	" ",      70,     20,    5, 525

;SLIDERS				     					MIN | MAX | EXP | TYPE | DISP    | WIDTH | HEIGHT | X | Y
gkcps, ihcps		FLslider	"Frequency",  				2,   10000,  -1,   23,   idcps,      490,    25,     5, 100
gkleak, ihleak		FLslider	"Integrator Leak",			0,       1,   0,   23,   idleak,     490,    25,     5, 150
gknyx, ihnyx		FLslider	"Number of Harmonics",			0,       1,   0,   23,   idnyx,      490,    25,     5, 200
gkpw, ihpw		FLslider	"Pulse Width",    			0,       1,   0,   23,   idpw,       490,    25,     5, 250
gkPWMamt, ihPWMamt	FLslider	"PWM Modulation Amount",		0,       1,   0,   23,   idPWMamt,   490,    25,     5, 300
gkPWMspd, ihPWMspd	FLslider	"PWM Modulation Speed",			0.001,  50,   0,   23,   idPWMspd,   490,    25,     5, 350
gkMVCFcf, gihMVCFcf	FLslider	"Moog VCF Cutoff Frequency (CC#1)",	4,      14,   0,   23,   idMVCFcf,   490,    25,     5, 400
gkMVCFres, ihMVCFres	FLslider	"Moog VCF Resonance",			0,      .9,   0,   23,   idMVCFres,  490,    25,     5, 450
gkgain, ihgain		FLslider	"Output Gain",				0,       1,   0,   23,   idgain,     490,    25,     5, 500

;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkwave,ihwave 		FLcount  "VCO Waveform:", 		1,      3,   1,       1,      2,   140,     25,    175, 5,    -1
gkPWMwave,ihPWMwave	FLcount  "PWM Modulation Source:", 	0,      8,   1,       1,      2,   140,     25,    350, 5,    -1

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
gihwavename		 	FLbox  	"", 		1,      1,     13,    140,    15,    175, 50
gihPWMwavename	 		FLbox  	"", 		1,      1,     13,    140,    15,    350, 70

;kout,ihandle		FLtext	"label",   imin, imax, istep, itype, iwidth, iheight, ix, iy
gkAttTim,ihAttTim	FLtext	"Att.Tim.",0,    1,    0.01,  0,     70,     20,      5,  550
gkAttLev,ihAttLev	FLtext	"Att.Lev.",0,    1,    0.01,  0,     70,     20,     75,  550
gkDecTim,ihDecTim	FLtext	"Dec.Tim.",0,    1,    0.01,  0,     70,     20,    145,  550
gkSusLev,ihSusLev	FLtext	"Sus.Lev.",0,    1,    0.01,  0,     70,     20,    215,  550
gkRelTim,ihRelTim	FLtext	"Rel.Tim.",0,    1,    0.01,  0,     70,     20,    285,  550
gkRelLev,ihRelLev	FLtext	"Rel.Lev.",0,    1,    0.01,  0,     70,     20,    355,  550

;SET INITIAL VALUES		VALUE | HANDLE 
		FLsetVal_i	0.01, 	ihAttTim
		FLsetVal_i	0.9, 	ihAttLev
		FLsetVal_i	0.1, 	ihDecTim
		FLsetVal_i	0.1, 	ihSusLev
		FLsetVal_i	0.1, 	ihRelTim
		FLsetVal_i	0, 	ihRelLev
		FLsetVal_i	100, 	ihcps
		FLsetVal_i	2, 	ihwave
		FLsetVal_i	0, 	ihleak
		FLsetVal_i	0.5, 	ihnyx
		FLsetVal_i	0.5, 	ihpw
		FLsetVal_i	1, 	ihPWMamt
		FLsetVal_i	0.15, 	ihPWMspd
		FLsetVal_i	12, 	gihMVCFcf
		FLsetVal_i	0.4, 	ihMVCFres
		FLsetVal_i	0.5, 	ihgain
		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 400, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"           VCO with PWM LFO and Moog Low Pass Filter         ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"This example adds a number of features onto a basic VCO audio", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"oscillator. For an explanation of the 'vco' opcode please    ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"look at the previous example.                                ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"As well as being able to modulate the pulse width manually   ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"with a single slider, a variety of modulation sources can be ", 	1,      5,     14,    490,    15,     5, 120
ih	  	 	FLbox  	"emplyed to automate this task. PWM modulation can be from an ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"LFO using a variety of waveform shapes, from a sample-and-   ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"hold random function, from an interpolating random function, ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"or from a ADSR envelope. Envelope modulation of PWM is       ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"sometimes used to simulate the attack of a note played by,   ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"for example, a trumpet or a violin.                          ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"A Moog-style resonant lowpass filter has also been added to  ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"allow the user to explore the timbral possibilities from the ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"vco opcode.                                                  ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"This example can also be played from an external MIDI        ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"keyboard. Pitch, note velocity and pitch bend and represented", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"appropriately. MIDI controller 1 (the modulation wheel) can  ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"be used to modulate 'Moog VCF Cutoff Frequency'.             ", 	1,      5,     14,    490,    20,     5, 380
                                                           
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen	0, 0, 131072, 10, 1  ; audio function

instr	1	;MIDI INPUT INSTRUMENT
	if	gkFLTK_MIDI=1	then	;IF FLTK/MIDI SWITCH IS SET TO 'FLTK'...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	icps	cpsmidi			;READ CYCLES PER SECOND VALUE FROM MIDI INPUT
	iamp	ampmidi	1		;READ IN A NOTE VELOCITY VALUE FROM THE MIDI INPUT
	;				P1 | P4 | P5
	aoutL, aoutR	subinstr	2,  icps, iamp	;ACTIVATE A SUB-INSTRUMENT
		outs	aoutL, aoutR	;SEND AUDIO TO SPEAKERS
endin

instr	2		;GBUZZ INSTRUMENT
	;MIDI INPUT============================================================================================================================================================
        ;OUTPUT                 OPCODE          CHANNEL | CC.NUMBER | MIN | MAX
        kMVCFcf                 ctrl7           1,            1,      0,    1	;READ IN MIDI CONTROLLER
        ktrig                   changed         kMVCFcf    ;IF THE VARIABLE 'kptr' CHANGES FROM ITS PREVIOUS VALUE,
                                                        ;I.E. IF THE MIDI SLIDER IS MOVED THEN THE VARIABLE ktrig WILL ASSUME THE VALUE '1', OTHERWISE IT WILL BE ZERO.
	kMVCFcf			scale		kMVCFcf, 14, 4	;RESCALE VARIABLE
        ;                       OPCODE      |   TRIGGER | VALUE | HANDLE
                                FLsetVal        ktrig,     kMVCFcf,  gihMVCFcf	;UPDATE WIDGET WHEN A TRIGGER IS RECEIVED
        ;======================================================================================================================================================================

	kactive1	active	1	;SENSE NUMBER OF ACTIVE INSTANCES OF INSTRUMENT 1 (I.E. MIDI ACTIVATED INSTRUMENT) 
	if	gkFLTK_MIDI=0&&kactive1=0	then	;IF FLTK/MIDI SWITCH IS SET TO 'MIDI' AND NO MIDI NOTES ARE ACTIVE...
		turnoff					;TURN THIS INSTRUMENT
	endif						;END OF CONDITIONAL BRANCHING
	if	gkFLTK_MIDI = 1	then			;IF FLTK/MIDI SWITCH IS SET TO 'FLTK'...
		kgain = gkgain			;SET kamp TO FLTK SLIDER VALUE gkamp
		kcps = gkcps			;SET FUNDEMENTAL TO FLTK SLIDER gkfund
	else						;OTHERWISE...
		kcps = p4				;SET FUNDEMENTAL TO RECEIVED p4 RECEIVED FROM INSTR 1. I.E. MIDI PITCH
		kgain = p5 * gkgain			;SET AMPLITUDE TO RECEIVED p5 RECEIVED FROM INSTR 1 (I.E. MIDI VELOCITY) MULTIPLIED BY FLTK SLIDER gkamp.
	endif						;END OF CONDITIONAL BRANCHING

	;PITCH BEND===========================================================================================================================================================
	iSemitoneBendRange = 2		;PITCH BEND RANGE IN SEMITONES (WILL BE DEFINED FURTHER LATER) - SUGGESTION - THIS COULD BE CONTROLLED BY AN FLTK COUNTER
	imin = 0			;EQUILIBRIUM POSITION
	imax = iSemitoneBendRange * .0833333	;MAX PITCH DISPLACEMENT (IN oct FORMAT)
	kbend	pchbend	imin, imax	;PITCH BEND VARIABLE (IN oct FORMAT)
	koct	=	octcps(kcps)
	kcps	=	cpsoct(koct + kbend)
	;=====================================================================================================================================================================

	kporttime	linseg	0,0.001,0.03	
	kpw		portk	gkpw, kporttime
	kcps		portk	kcps, kporttime
	kMVCFcf		portk	gkMVCFcf, kporttime
	
	ifn	=	gisine
	imaxd	=	1
	kSwitch		changed	gkleak, gknyx, gkwave, gkPWMwave
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	UPDATE			;BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE'
	endif
	UPDATE:
	if i(gkPWMwave)==6 then
	 kPWMmod	randomh	-gkPWMamt, gkPWMamt, gkPWMspd
	elseif i(gkPWMwave)==7 then
	 kPWMmod	randomi	-gkPWMamt, gkPWMamt, gkPWMspd
	elseif i(gkPWMwave)==8 then
	 kPWMmod	linsegr	0, i(gkAttTim)+0.0001, i(gkAttLev),  i(gkDecTim)+0.0001, i(gkSusLev), i(gkRelTim)+0.0001, i(gkRelLev)
	 kPWMmod	=	kPWMmod*gkPWMamt
	else
	 kPWMmod	lfo	gkPWMamt, gkPWMspd, i(gkPWMwave)
	endif
	kpw	mirror	kpw+((kPWMmod+gkPWMamt)*.5), 0, 1	;REFLECT OUT OF RANGE VALUES
	aenv	linsegr	0,0.01,1,0.01+i(gkRelTim)+0.0001,0		;ANTI-CLICK ENVELOPE
	asig	vco 	gkgain*aenv, kcps, i(gkwave), kpw, ifn, imaxd, i(gkleak), i(gknyx);, 0, 0
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
	iscale 		= 	1
	asig		moogvcf	asig, cpsoct(kMVCFcf), gkMVCFres, iscale
		outs	asig, asig
endin

instr	3	;UPDATE FLTK LABELS
	ktrig	changed	gkPWMwave
	if ktrig==1 then
	 reinit update
	endif
	update:
	if i(gkPWMwave)==0 then
	 SPWMwavename	=	"sine"
	elseif i(gkPWMwave)==1 then
	 SPWMwavename	=	"triangle"
	elseif i(gkPWMwave)==2 then
	 SPWMwavename	=	"square (bipolar)"
	elseif i(gkPWMwave)==3 then
	 SPWMwavename	=	"square (unipolar)"
	elseif i(gkPWMwave)==4 then
	 SPWMwavename	=	"sawtooth (up)"
	elseif i(gkPWMwave)==5 then
	 SPWMwavename	=	"sawtooth (down)"
	elseif i(gkPWMwave)==6 then
	 SPWMwavename	=	"random (samp+hold)"
	elseif i(gkPWMwave)==7 then
	 SPWMwavename	=	"random (interp.)"
	elseif i(gkPWMwave)==8 then
	 SPWMwavename	=	"envelope"
	endif
	FLsetText	SPWMwavename,gihPWMwavename
	rireturn
	
	ktrig2	changed	gkwave
	if ktrig2==1 then
	 reinit update2
	endif
	update2:
	if i(gkwave)==1 then
	 Swavename	=	"saw"
	elseif i(gkwave)==2 then
	 Swavename	=	"square/PWM"
	else
	 Swavename	=	"Triangle/Saw/Ramp"
	endif
	FLsetText	Swavename,gihwavename
endin

</CsInstruments>


<CsScore>
f 0 3600	;DUMMY SCORE EVENT - ALLOWS REAL-TIME PERFORMANCE FOR 1 HOUR
i 3 0 3600
</CsScore>

</CsoundSynthesizer>