FLcount.csd
Written by Iain McCurdy, 2009. Updated 2011, 2012.

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

;DEMONSTRATION OF THE FLcount OPCODE
;CLICKING ON THE SINGLE ARROW BUTTONS INCREMENTS THE OSCILLATOR IN SEMITONE STEPS
;CLICKING ON THE DOUBLE ARROW BUTTONS INCREMENTS THE OSCILLATOR IN OCTAVE STEPS

sr		=	44100
ksmps		=	1
nchnls		=	2
0dbfs		=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

FLcolor	255,255,255,0,0,0	;SET COLOUR SCHEME
;		OPCODE	LABEL       | WIDTH | HEIGHT | X | Y
		FLpanel	"Counter",    1000,     390,   0,  0
		FLscroll              1000,     390,   0,  0
;TEXT BOXES			TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		FLbox  	"", 	1,      5,     14,    1170,    390,   0,  0	;EMPTY BOX SAME SIZE AS PANEL CONTENTS...
FLsetColor	255,255,255,ih							;...COLOURED WHITE

imin		=	0	;MINIMUM VALUE OUTPUT BY COUNTER
imax		=	127	;MAXIMUM VALUE OUTPUT BY COUNTER
istep1		=	1	;SINGLE ARROW STEP SIZE (SEMITONES)
istep2		=	12	;DOUBLE ARROW STEP SIZE (OCTAVE)
itype		=	1	;COUNTER TYPE (1=DOUBLE ARROW COUNTER)
iwidth		=	200	;WIDTH OF THE COUNTER IN PIXELS
iheight		=	30	;HEIGHT OF THE COUNTER IN PIXELS
ix		=	20	;DISTANCE OF THE LEFT EDGE OF THE COUNTER FROM THE LEFT EDGE OF THE PANEL
iy		=	15	;DISTANCE OF THE TOP EDGE OF THE COUNTER FROM THE TOP EDGE OF THE PANEL
iopcode		=	-1	;SCORE EVENT TYPE (-1=IGNORED)
gknotenum,ihandle1 	FLcount  "pitch in MIDI note number format", 	imin, imax, istep1, istep2, itype, iwidth, iheight, ix, iy, iopcode
gkamp,ihandle2 	FLcount  "On/Off", 					0,       1,      1,      1,     2, iwidth, iheight, 255,iy, iopcode

;THE THIRD COUNTER USES THE OPTIONAL ARGUMENTS TO TRIGGER A NOTE EVENT
;                                                                                                                                             p1 p2 p3
gktrig,ihandle3 FLcount  "trigger Note",				0,     127,      1,     12,     1, iwidth, iheight, 490,iy,    0,      2, 0, 8
gklabel,gihlabel FLcount "off", 					0,       3,      1,      1,     2, iwidth, iheight, 725,iy,    0,      3, 0, -1

;COUNTERS					MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkval, gihval 	FLcount  "Rhythmic Value",	0,    512,    1,      1,      2,    iwidth, iheight,960, iy,    -1

;SET INITIAL VALUES OF VALUATOR                                                                                                
		FLsetVal_i	48, ihandle1
		FLsetVal_i	0, ihandle2
		FLsetVal_i	48, ihandle3

;TEXT BOXES							TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 FLbox  	"Type 1 counter has two sets", 	1,      5,     14,    220,    20,    10,  80
ih		 FLbox  	"of arrow buttons for       ", 	1,      5,     14,    220,    20,    10, 100
ih		 FLbox  	"incrementing its output in ", 	1,      5,     14,    220,    20,    10, 120       
ih		 FLbox  	"two step sizes.            ", 	1,      5,     14,    220,    20,    10, 140
ih		 FLbox  	"In this example step 1     ", 	1,      5,     14,    220,    20,    10, 160
ih		 FLbox  	"(inner arrows) step size is", 	1,      5,     14,    220,    20,    10, 180
ih		 FLbox  	"1 and step size 2 (outer   ", 	1,      5,     14,    220,    20,    10, 200
ih		 FLbox  	"arrows) is 12.             ", 	1,      5,     14,    220,    20,    10, 220
ih		 FLbox  	"In this case therefore the ", 	1,      5,     14,    220,    20,    10, 240
ih		 FLbox  	"inner arrows shift the     ", 	1,      5,     14,    220,    20,    10, 260
ih		 FLbox  	"pitch of an oscillator in  ", 	1,      5,     14,    220,    20,    10, 280
ih		 FLbox  	"semitone steps and the     ", 	1,      5,     14,    220,    20,    10, 300
ih		 FLbox  	"outer arrows shift its     ", 	1,      5,     14,    220,    20,    10, 320
ih		 FLbox  	"pitch in octave steps.     ", 	1,      5,     14,    220,    20,    10, 340

ih		 FLbox  	"Type 2 counter has just a  ", 	1,      5,     14,    220,    20,   245,  80
ih		 FLbox  	"single set of arrow buttons", 	1,      5,     14,    220,    20,   245, 100
ih		 FLbox  	"in this case only two      ", 	1,      5,     14,    220,    20,   245, 120
ih		 FLbox  	"values have been allowed: 1", 	1,      5,     14,    220,    20,   245, 140
ih		 FLbox  	"or zero which will turn the", 	1,      5,     14,    220,    20,   245, 160
ih		 FLbox  	"oscillator on or off.      ", 	1,      5,     14,    220,    20,   245, 180      

ih		 FLbox  	"FLcount can optionally also", 	1,      5,     14,    220,    20,   480,  80
ih		 FLbox  	"output a note event.       ", 	1,      5,     14,    220,    20,   480, 100
ih		 FLbox  	"The above counter triggers ", 	1,      5,     14,    220,    20,   480, 120
ih		 FLbox  	"a note each time it        ", 	1,      5,     14,    220,    20,   480, 140
ih		 FLbox  	"changes.                   ", 	1,      5,     14,    220,    20,   480, 160
ih		 FLbox  	"The pitch played is derived", 	1,      5,     14,    220,    20,   480, 180
ih		 FLbox  	"from the value of the      ", 	1,      5,     14,    220,    20,   480, 200
ih		 FLbox  	"counter at the moment it   ", 	1,      5,     14,    220,    20,   480, 220
ih		 FLbox  	"was changed.               ", 	1,      5,     14,    220,    20,   480, 240

ih		 FLbox  	"By updating FLcount's label", 	1,      5,     14,    220,    20,   715,  80
ih		 FLbox  	"using 'FLsetText' whenever ", 	1,      5,     14,    220,    20,   715, 100
ih		 FLbox  	"it is changed we can create", 	1,      5,     14,    220,    20,   715, 120
ih		 FLbox  	"a sort of FLTK drop down   ", 	1,      5,     14,    220,    20,   715, 140
ih		 FLbox  	"menu.                      ", 	1,      5,     14,    220,    20,   715, 160

ih		 FLbox  	"Non sequential counters can", 	1,      5,     14,    220,    20,   950,  80
ih		 FLbox  	"be created by using        ", 	1,      5,     14,    220,    20,   950, 100
ih		 FLbox  	"'trigger' and 'FLsetVal_i' ", 	1,      5,     14,    220,    20,   950, 120
ih		 FLbox  	"to skip the unwanted       ", 	1,      5,     14,    220,    20,   950, 140
ih		 FLbox  	"values.                    ", 	1,      5,     14,    220,    20,   950, 160

		FLscroll_end
		FLpanel_end	;END OF PANEL CONTENTS
		FLrun		;RUN THE WIDGET THREAD

giwave		ftgen	3, 0, 4096, 10, 1,1/2,1/4,1/8,1/16,1/32,1/64,1/128,1/256,1/512,1/1024	;A RICH HARMONIC WAVEFORM
gisine		ftgen	0,0,4096,10,1	;A SINE WAVE

instr 	1
	kcps		=	cpsmidinn(gknotenum)
	kcps		port	kcps, 0.001	;SMOOTH COUNTER STEPS A TINY BIT
	kamp		port	gkamp, 0.005	;SMOOTH COUNTER STEPS A TINY BIT
	acps		interp	kcps		;INTERPOLATE AND CREATE AN AUDIO RATE VERSION OF K-RATE VARIABLE
	aamp		interp	kamp		;INTERPOLATE AND CREATE AN AUDIO RATE VERSION OF K-RATE VARIABLE
	;OUTPUT		OPCODE	AMPLITUDE |  FREQUENCY   | FUNCTION_TABLE
	asig		poscil	0.1*aamp,       acps,         giwave	;cpsoct() CONVERTS A pch FORMAT PITCH EXPRESSION TO A cps FORMAT PITCH EXPRESSION
			outs	asig,asig		;SEND AUDIO TO OUTPUTS
endin

instr	2	;SQUELCHY PERCUSSIVE SYNTH                                                                                   
	itime 	times		;TIME SINCE THE START OF THE PERFORMANCE - THE FOLLOWING 4 LINES ARE TO PREVENT THE INITIAL TRIGGERING BY THE THIRD FLCOUNT WHEN IT IS INITIALIZED BY FLsetVal_i IN instr 0
	if itime<0.1 then	;IF WE ARE LESS THAN 0.1 SECONDS INTO CSOUND PERFORMANCE...
	  turnoff		;TURN THIS INSTRUMENT OFF, THEREFORE DONE PRODUCE A SOUND THIS TIME
	endif			;
	
	icps	init	cpsmidinn(i(gktrig))		;READ IN MIDI NOTE NUMBER OUTPUT BY COUNTER AT THE MOMENT IT TRIGGERED THE NOTE. CONVERT INTO CYCLES PER SECOND 
	;TWO OSCILLATORS
	a1	vco2	0.1,icps			;SAWTOOTH
	a2	vco2	0.1,icps/(2+rnd(0.02)),2,0.1	;SQUARE WAVE. AN OCTAVE LOWER THAN THE SAWTOOTH. A LITTLE BIT DETUNED ALSO.
	asig	sum	a1,a2				;MIX THE TWO OSCILLATORS
	acf	expsega	200,0.02,8000,p3-0.02,20	;CREATE A FILTER CUTOFF FREQUENCY ENVELOPE
	asig	moogvcf	asig,acf,0.7			;RESONANT LOWPASS FILTER
	aL	delay	asig,abs(rnd(0.01)+0.0001)	;DELAY THE LEFT CHANNEL BY A SMALL RANDOM TIME AMOUNT
	aR	delay	asig,abs(rnd(0.01)+0.0001)	;DELAY THE RIGHT CHANNEL BY A SMALL RANDOM TIME AMOUNT
	aenv	expsega	0.001,0.005,1,p3-0.005,0.001	;CREATE AN AMPLITUDE ENVELOPE
		out	aL*aenv,aR*aenv			;SEND AUDIO TO THE OUTPUTS. APPLY AMPLITUDE ENVELOPE
endin

instr	3	;UPDATE LABEL OF THE COUNTER
	ilabel	init	i(gklabel)
	if ilabel==1 then
	  iwave=0
	  Slabel	=	"saw"
	elseif ilabel=2 then
	  iwave=2
	  Slabel	=	"square"
	elseif ilabel=3 then
	  iwave=4
  	  Slabel	=	"triangle"
	else
  	  Slabel	=	"off"
	  FLhide	gihlabel
	  FLsetText	Slabel,gihlabel
	  FLshow	gihlabel
	  turnoff
	endif
	FLhide	gihlabel
	FLsetText	Slabel,gihlabel
	FLshow	gihlabel
	asig	vco2	0.1,300,iwave,0.5
		outs	asig,asig
endin

instr	NonSequential
	ivals	ftgentmp	0,0,-11,-2, 0,1,2,4,8,16,32,64,128,256,512	;TABLE THAT STORES THE NON-SEQUENTIAL VALUES
	indx	init	i(gkval)					;INDEX USED TO REFERENCE VALUES IN THE ABOVE TABLE
	ival	table	indx,ivals					;INITIAL VALUE FOR THE COUNTER AT START-UP
	
	kup	trigger	gkval,ival,0					;TRIGGER GENERATED WHEN COUNTER IS INCREASED
	kdn	trigger	gkval,ival,1					;TRIGGER GENERATED WHEN COUNTER IS DECREASED
	
	if kup==1 then							;IF STEPPING UP...
	 reinit UPDATE1							;REINITIALISE STARTING FROM THE NEXT LINE
	 UPDATE1:							
	 indx = indx + 1						;INCREMENT INDEX
	 ival	table	indx,ivals					;READ NEW VALUE FROM NON SEQUENTIAL LIST TABLE
	 FLsetVal_i	ival,gihval					;WRITE VALUE TO COUNTER
	 rireturn							;RETURN FROM REINITIALISATION
	elseif kdn==1 then						;SIMILAR PROCEDURE FOR WHENEVER COUNTER IS STEPPING DOWN
	 reinit UPDATE2
	 UPDATE2:
	 indx = indx - 1
	 ival	table	indx,ivals
	 FLsetVal_i	ival,gihval	
	 rireturn
	endif

	;DRIVE A METRONOME
	itempo	=	45
	kmetro	metro	itempo*gkval/60, 0.99
	schedkwhen	kmetro,0,0,"metronome",0,0.02
endin

instr	metronome
	aenv	expon	0.5,p3,0.001
	acps	expon	2000,p3,20
	asig	oscili	aenv,acps,gisine
		outs	asig,asig
endin

</CsInstruments>

<CsScore>
i 1 0 3600
i "NonSequential" 0 3600
</CsScore>

</CsoundSynthesizer>