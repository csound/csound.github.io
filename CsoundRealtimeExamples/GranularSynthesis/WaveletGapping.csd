WaveletGapping.csd
Written by Iain McCurdy, 2012

<CsoundSynthesizer>

<CsOptions>
-odac  
</CsOptions>

<CsInstruments>
sr = 44100
ksmps = 32
nchnls = 2 
0dbfs = 1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL            | WIDTH | HEIGHT | X | Y
	FLpanel	"Wavelet Gapping",  500,    250,    0,  0

;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,    0,    22,    120,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW
;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gknwavelets, ihnwavelets	FLcount  "N.Wavelets", 		1,    100,     1,     10,     1,    120,    25,   130, 5,    -1
gkmode, ihmode			FLcount  "Mode", 		0,      1,     1,     10,     2,    120,    25,   255, 5,    -1
                                   
;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idgap				FLvalue	" ",       70,    20,     5,  75
idspeed				FLvalue	" ",       70,    20,     5, 125

;SLIDERS						MIN   | MAX | EXP | TYPE |  DISP  | WIDTH | HEIGHT | X | Y
gkgap, ihgap		FLslider "Gap (+0.001)",	0.001,  100,  -1,    23,  idgap,     490,     25,    5,  50
gkspeed, ihspeed	FLslider "Speed/Pitch",		0.1,      2,  -1,    23,  idspeed,   490,     25,    5, 100

;GENERAL_TEXT_SETTINGS			isize, ifont, ialign, ired, igreen, iblue
			FLlabel		13,      1,       1,   255,  255,   255		;NUMBERS MADE INVISIBLE

;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkinput, ihinput	FLbutBank	4,     1,     5,     20,     20*5,  55, 150,   -1

;GENERAL_TEXT_SETTINGS			isize, ifont, ialign, ired, igreen, iblue
			FLlabel		13,      5,      4,   0,      0,     0		;LABELS MADE VISIBLE AGAIN
;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Input:", 		1,      6,     12,     50,    20,     5,  150
ih		 	FLbox  	"Classical Guitar", 	1,      5,     12,    120,    20,    75,  150
ih		 	FLbox  	"Synth Pad       ", 	1,      5,     12,    120,    20,    75,  170
ih		 	FLbox  	"Voice           ", 	1,      5,     12,    120,    20,    75,  190
ih		 	FLbox  	"Drum Loop       ", 	1,      5,     12,    120,    20,    75,  210
ih		 	FLbox  	"Songpan         ", 	1,      5,     12,    120,    20,    75,  230

FLsetVal_i	1,ihnwavelets
FLsetVal_i	0,ihgap
FLsetVal_i	1,ihspeed



FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 440, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                       Wavelet Gapping                       ", 	1,      6,     16,    490,    20,     5,   3
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"This example fragments a soundfile into a sequence of        ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"wavelets (fragments of a waveform bounded by zero crossings) ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"and allows the user to specify a gap time to be inserted     ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"between these wavelets during playback. This gap can be      ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"either a fixed time (mode 0) or relative to the wavelet      ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"duration (mode 1).                                           ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"The number of zero crossings within each wavelet             ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"('N.Wavelets') can be increased from the default setting of  ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"'1' to create longer wavelets.                               ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"The 'Speed/Pitch' control varies playback speed and will also", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"influence gap duration when mode 1 is chosen.                ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"This process will only really work in mono - stereo can be   ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"implemented but sync. between the left and right channel will", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"be quickly lost.                                             ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"Sound input is via function tables ('flooper' is used for    ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"playback). Processing of streaming audio would require a     ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"slightly different approach.                                 ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"The critical code for this process is placed within a UDO so ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"the user can easily transplant the effect into other         ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"projects.                                                    ", 	1,      5,     14,    490,    20,     5, 420
		FLpanel_end

			FLrun	;RUN THE FLTK WIDGET THREAD

;THE INPUT SOUND FILES
gifile1	ftgen	0,0,0,1,"ClassicalGuitar.wav",0,0,1
gifile2	ftgen	0,0,0,1,"SynthPad.wav",0,0,1
gifile3	ftgen	0,0,0,1,"AndItsAll.wav",0,0,1
gifile4	ftgen	0,0,0,1,"Loop.wav",0,0,1
gifile5	ftgen	0,0,0,1,"Songpan.wav",0,0,1

opcode	WaveletGapper,a,ikkkk
	ifn,knwavelets,kgap,kmode,kspeed	xin			;READ IN INPUT ARGUMENTS
		setksmps	1					;SET ksmps TO 1 SAMPLE (kr = sr). WE WILL CONVERT THE AUDIO RATE SIGNAL TO K-RATE BUT WE DON'T WANT TO LOSE ANY DATA.
	icount	init	0						;COUNTER USED TO COUNT THE NUMBERS OF WAVELETS IN A TRAINLET
	ktime	init	0						;TIME FOR THIS GAP (INITIALLY NO GAP)
	ksig	init	0						;K-RATE VERSION OF THE AUDIO SIGNAL
	ktrig	trigger ksig,0,2					;SENSE IF THE AUDIO SIGNAL (K-RATE VERSION) HAS CROSSED ZERO IN EITHER DIRECTION 
	if ktrig==1 then						;IF A TRIGGER HAS BEEN GENERATED (BECAUSE OF A ZERO CROSSING)...
	 reinit	gap							;BEGIN A REINITIALISATION PASS FROM LABEL: 'gap'
	endif								;
	gap:								;LABEL CALLED 'gap'
	icount	wrap	icount+1,0,i(knwavelets)+1			;COUNTER FOR THE REQUIRED NUMBER OF WAVELETS INCREMENTED
	if icount==0 then						;IF WE ARE AT THE END OF A WAVELET TRAIN (COUNTER HAS *JUST* WRAPPED AROUND TO ZERO)...
	 if i(kmode)==0 then						;...IF MODE 1 (FIXED GAP DURATION) HAS BEEN CHOSEN...
	  timout 0, i(kgap), skip					;SUSPEND PERFORMANCE FOR A FIXED GAP DURATION
	 else								;OTHERWISE (A GAP TIME DEPENDENT UPON THE WAVELET DURATION WILL BE CHOSEN)
	  timout 0, (i(ktime)*i(knwavelets)*i(kgap))/i(kspeed), skip	;SUSPEND PERFORMANCE FOR A DURATION RELATIVE TO DURATION OF WAVELET, SPEED AND NUMBER OF WAVELETS IN A TRAIN
	 endif
	endif
	ktime	timeinsts						;START TIMER
	rireturn
	asig	flooper		1, kspeed, 0, ftlen(ifn)/sr, 0, ifn	;PLAY AUDIO IN A LOOP
	ksig	downsamp	asig					;CREATE K-RATE VERSION OF THE AUDIO
skip:
		xout		asig					;SEND AUDIO BACK TO CALLER INSTRUMENT
endop

instr 1
	if gkOnOff==0 then			;IF ON/OFF SWITCH IS OFF...
	 turnoff				;TURN THIS INSTRUMENT OFF
	endif
	ktrig	changed	gkinput			;IF INPUT SELECTOR HAS BEEN CHANGED GENERATE A TRIGGER
	if ktrig==1 then			;IF TRIGGER HAS BEEN GENERATED...
	 reinit	UPDATE				;...BEGIN A REINITIALISATION PASS FROM THE GIVEN LABEL
	endif					
	UPDATE:					;LABEL CALLED 'UPDATE'
	aout	WaveletGapper	gifile1+i(gkinput),gknwavelets,gkgap-0.001,gkmode,gkspeed	;CALL THE UDO
	rireturn
	outs	aout/4,aout/4			;SEND AUDIO TO OUTPUTS, ATTENUATE SLIGHTLY.
endin

</CsInstruments>

<CsScore>
f 0 3600
e
</CsScore>

</CsoundSynthesizer>