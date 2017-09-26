StretchedHarmonicPartials.csd
Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-odac -dm0 -M0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>

sr	= 	44100
ksmps	= 	64
nchnls	= 	1
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL                          | WIDTH | HEIGHT | X | Y
	FLpanel	"Stretched Harmonic Partials",    500,    500,    0,  0

;SWITCHES                                					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff		FLbutton	"FLTK/MIDI",				1,    0,    22,    120,     25,    5,  5,   -1
gkStrTun,ihStrTun	FLbutton	"Stretched Octave Tuning On/Off",	1,    0,    22,    250,     25,    5, 50,   -1
FLsetColor2	255,255,0,ihOnOff
FLsetColor2	255,255,0,ihStrTun

;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gknparts, ihnparts 		FLcount  "N.Partials", 		1,    100,     1,     10,      1,    120,    25,   130, 5,    -1
gkpartsOS, ihpartsOS 		FLcount  "Partials Offset", 	0,     30,     1,     10,      2,    120,    25,   255, 5,    -1

;VALUE INPUT BOXES				 		MIN |  MAX  |  STEP   | TYPE | WIDTH | HEIGHT | X  | Y
gkstretch, ihstretch		FLtext		"Stretch",	-9999, 9999,   0.0001,   1,      80,     25,  380,   5

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idbrite				FLvalue	" ",       70,    20,     5, 125
iddamp				FLvalue	" ",       70,    20,     5, 175
iddur				FLvalue	" ",       70,    20,     5, 275
idrel				FLvalue	" ",       70,    20,     5, 325
idfundfrq			FLvalue	" ",       70,    20,     5, 375
idgain				FLvalue	" ",       70,    20,     5, 475

;SLIDERS								MIN | MAX | EXP | TYPE |  DISP    | WIDTH | HEIGHT | X | Y
gkbrite, ihbrite		FLslider "Attenuate Higher Partials",	0,   100,    0,    23,  idbrite,     490,     25,    5, 100
gkdamp, ihdamp			FLslider "Damping",			0,    50,    0,    23,  iddamp,      490,     25,    5, 150
gkattstr, ihattstr		FLslider "Attack Stretch",		0,   0.2,    0,    23,  -1,          490,     25,    5, 200
gkdur, ihdur			FLslider "Decay Time",			1,    30,    0,    23,  iddur,       490,     25,    5, 250
gkrel, ihrel			FLslider "Release Time",		0.01, 10,   -1,    23,  idrel,       490,     25,    5, 300
gkfundfrq, ihfundfrq		FLslider "Fundemental Frequency (FLTK)",20, 8000,   -1,    23,  idfundfrq,   490,     25,    5, 350      
gkvelsens, ihvelsens		FLslider "Velocity Sensitivity (MIDI)",	0,     1,    0,    23,  -1,          490,     25,    5, 400
gkgain, ihgain			FLslider "Gain",			0.001,10,   -1,    23,  idgain,      490,     25,    5, 450

FLsetVal_i	20,ihnparts
FLsetVal_i	0,ihpartsOS                                       
FLsetVal_i	1.003,ihstretch
FLsetVal_i	0.2,ihbrite
FLsetVal_i	5,ihdamp                                            
FLsetVal_i	0,ihattstr
FLsetVal_i	12,ihdur
FLsetVal_i	0.5,ihrel
FLsetVal_i	150,ihfundfrq
FLsetVal_i	1,ihvelsens
FLsetVal_i	1,ihgain

			FLpanel_end
	;INSTRUCTIONS AND INFO PANEL
	FLpanel	"", 512, 600, 515, 0
	FLscroll    512, 600, 0,   0
	;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
	ih		 	FLbox  	"                 Stretched Harmonic Partials                 ", 	1,      5,     14,    490,    20,     5,    0
	ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,   20
	ih		 	FLbox  	"This example exemplifies the phenomenon whereby certain      ", 	1,      5,     14,    490,    20,     5,   40
	ih		 	FLbox  	"supposedly harmonic resonators, such as a piano string,      ", 	1,      5,     14,    490,    20,     5,   60
	ih		 	FLbox  	"actually exhibit a series of partial frequencies that are    ", 	1,      5,     14,    490,    20,     5,   80
	ih		 	FLbox  	"increasingly warped upwards above their expected frequencies.", 	1,      5,     14,    490,    20,     5,  100
	ih		 	FLbox  	"Instead of a precise sequence of ratios: 1:2:3 ... the       ", 	1,      5,     14,    490,    20,     5,  120
	ih		 	FLbox  	"actual ratios might be something like 1:2.01:3.02 ...        ", 	1,      5,     14,    490,    20,     5,  140
	ih		 	FLbox  	"This warping of the partial frequencies is caused by the     ", 	1,      5,     14,    490,    20,     5,  160                                                         
	ih		 	FLbox  	"stiffness of the string, therefore different degrees of      ", 	1,      5,     14,    490,    20,     5,  180
	ih		 	FLbox  	"warping will result from different thickness of strings under", 	1,      5,     14,    490,    20,     5,  200
	ih		 	FLbox  	"different amounts of tension - the effect therefore will not ", 	1,      5,     14,    490,    20,     5,  220
	ih		 	FLbox  	"be uniform across the keyboard.                              ", 	1,      5,     14,    490,    20,     5,  240
	ih		 	FLbox  	"In order to simulate a piano tone it will be necessary to    ", 	1,      5,     14,    490,    20,     5,  260
	ih		 	FLbox  	"incorporate this phenomenon to some degree.                  ", 	1,      5,     14,    490,    20,     5,  280
	ih		 	FLbox  	"In this example the ratio interval between partials is       ", 	1,      5,     14,    490,    20,     5,  300
	ih		 	FLbox  	"defined using the control 'Stretch'. If this is '1', then    ", 	1,      5,     14,    490,    20,     5,  320
	ih		 	FLbox  	"a precise harmonic tone is produced. As this is raised beyond", 	1,      5,     14,    490,    20,     5,  340
	ih		 	FLbox  	"'1' the tone becomes first piano-like and then increasingly  ", 	1,      5,     14,    490,    20,     5,  360
	ih		 	FLbox  	"inharmonic eventually resembling a marimba or vibraphone     ", 	1,      5,     14,    490,    20,     5,  380
	ih		 	FLbox  	"note. The notes on a vibraphone or marimba can in a way be   ", 	1,      5,     14,    490,    20,     5,  400
	ih		 	FLbox  	"imagined as very stiff strings.                              ", 	1,      5,     14,    490,    20,     5,  420
	ih		 	FLbox  	"As 'Attenuate Higher Partials' is increased, higher partials ", 	1,      5,     14,    490,    20,     5,  440
	ih		 	FLbox  	"are increasingly weaker in amplitude so that this functions  ", 	1,      5,     14,    490,    20,     5,  460
	ih		 	FLbox  	"like a tone control.                                         ", 	1,      5,     14,    490,    20,     5,  480
	ih		 	FLbox  	"Increasing the 'Damping' damping control causes higher       ", 	1,      5,     14,    490,    20,     5,  500
	ih		 	FLbox  	"partials to decay increasingly quicker.                      ", 	1,      5,     14,    490,    20,     5,  520
	ih		 	FLbox  	"The total number of partials employed and the partial number ", 	1,      5,     14,    490,    20,     5,  540
	ih		 	FLbox  	"offset for the first partial can also be adjusted. These     ", 	1,      5,     14,    490,    20,     5,  560
	ih		 	FLbox  	"controls are similar to ones found with the 'gbuzz' opcode.  ", 	1,      5,     14,    490,    20,     5,  580
	ih		 	FLbox  	"'Decay Time' controls the length of time it takes for a note ", 	1,      5,     14,    490,    20,     5,  600
	ih		 	FLbox  	"to decay while it is being held. 'Release Time' controls the ", 	1,      5,     14,    490,    20,     5,  620
	ih		 	FLbox  	"length of time it takes for a note to decay once a note has  ", 	1,      5,     14,    490,    20,     5,  640
	ih		 	FLbox  	"been released. Note that higher partials always decay quicker", 	1,      5,     14,    490,    20,     5,  660
	ih		 	FLbox  	"in the release stage.                                        ", 	1,      5,     14,    490,    20,     5,  680
	ih		 	FLbox  	"It is common practice to tune a piano so that the 1st        ", 	1,      5,     14,    490,    20,     5,  700
	ih		 	FLbox  	"harmonic (2nd partial), which would be normally expected an  ", 	1,      5,     14,    490,    20,     5,  720
	ih		 	FLbox  	"octave above the fundamental, is in tune with the fundamental", 	1,      5,     14,    490,    20,     5,  740
	ih		 	FLbox  	"of the note an octave above. This practice can be emulated by", 	1,      5,     14,    490,    20,     5,  760
	ih		 	FLbox  	"activating the 'Stretched Octave Tuning' button. This control", 	1,      5,     14,    490,    20,     5,  780
	ih		 	FLbox  	"in only employed when MIDI keyboard control, as opposed to   ", 	1,      5,     14,    490,    20,     5,  800
	ih		 	FLbox  	"FLTK control, is used.                                       ", 	1,      5,     14,    490,    20,     5,  820
	FLscroll_end
	FLpanel_end

			FLrun	;RUN THE FLTK WIDGET THREAD

gisine	ftgen	0,0,4096,10,1
giTTable	ftgen	1, 0, 128, -2, 12, 2, cpsmidinn(60), 60

;USER DEFINED OPCODE USED TO FORM PARTIAL - THIS IS DONE TO ALLOW RECURSION AND A DYNAMIC NUMBER OF PARTIALS 
opcode	partial,a,iiiiiikkkk
	idur,icount,inparts,idamp,irel,iattstr,kfund,kpartsOS,kstretch,kbrite	xin	;INPUT ARGS
	idecay	=	idur/(1+(((icount-1)^2)*idamp))					;DECAY TIME FOR THIS PARTIAL
	aenv	transeg	1,idur,0-(idamp*icount),0					;AMPLITUDE DECAY ENVELOPE FOR THIS PARTIAL
	aatt	expseg	0.001, (iattstr*(inparts-icount)) + 0.0001,1,1,1
	arel	expsegr	1,irel/icount,0.001						;AMPLITUDE RELEASE ENVELOPE FOR THIS PARTIAL 
	kcps	=	kfund*(icount+kpartsOS)*(kstretch^(icount-1))			;DERIVE FUNDEMENTAL FREQUENCY
	if abs(kcps)<=sr/2 then								;IF FREQUENCY FOR THIS PARTIAL IS BELOW NYQUIST... (PROTECTION AGAINST ALIASING)
	 asig 	oscil	(0.1*aenv*arel*aatt)/(1+((icount-1)*kbrite)),kcps,gisine		;...CREATE AUDIO FOR PARTIAL
	else										;OTHERWISE...
	 asig	=	0								;...MUTE THIS PARTIAL
	endif										;END OF CONDITIONAL
	if icount<inparts then								;IF FULL COMPLEMENT OF PARTIALS IS NOT YET REACHED...
	 amix 	partial	idur,icount+1,inparts,idamp,irel,iattstr,kfund,kpartsOS,kstretch,kbrite	;CALL UDO AGAIN FOR THE NEXT PARTIAL
	endif										;END OF CONDITIONAL
	xout	asig+amix								;SEND MIX OF ALL AUDIO BACK TO THE CALLER INSTRUMENT
endop

instr	99	;SENSE FLTK ON/OFF BUTTON (ALWAYS ON)
	ktrig	changed	gkOnOff	;IF BUTTON STATUS HAS CHANGED GENERATE A MOMENTARY '1'
	if ktrig==1 then	;IF TRIGGER IS '1'
	 if gkOnOff==1 then	;IF BUTTON IS ON...
	  event	"i",1,0,-1	;TRIGGER A HELD NOTE IN INSTR 1
	 else			;OTHERWISE...
	  turnoff2	1,0,1	;TURN OFF ALL INSTANCES OF INSTR 1, ALLOWING RELEASE SEGMENTS TO COMPLETE
	 endif			;END OF CONDITIONAL
	endif			;END OF CONDITIONAL
endin

instr	100	;UPDATE TUNING TABLE
	ktrig	changed	gkstretch
	if ktrig==1 then
	 reinit	update
	endif
	update:
	giTTable	ftgen	1, 0, 128, -2, 12, 1+i(gkstretch), cpsmidinn(60), 60
	icount	=	0						;LOOP COUNTER / TABLE LOCATION
	iratio	=	1						;FIRST RATIO
		tableiw	iratio,4,giTTable				;WRITE FIRST RATIO TO TABLE
	icount	=	1                                               ;LOOP COUNTER / TABLE LOCATION
	loop:								;LOOP BEGINNING
	iratio	=	iratio*((1+i(gkstretch))^(1/12))		;DERIVE RATIO FOR THIS TABLE LOCATION
		tableiw	iratio,icount+4,giTTable			;WRITE RATIO VALUE TO TABLE
		loop_le	icount,1,12,loop				;CONDITIONALLY LOOP BACK TO LABEL 'loop' UNTIL ALL RATIOS (AS DEFINED BY 'Num.Grades') ARE COMPLETED
endin

instr	1
	iMIDIActiveValue	=	1		;IF MIDI ACTIVATED
	iMIDIflag		=	0		;IF FLTK ACTIVATED
	mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 
	
	if iMIDIflag=1 then				;IF THIS IS A MIDI NOTE
	 if i(gkStrTun)==1 then				;IF STRETCHED TUNING HAS BEEN CHOSEN...
	  icps	cpstmid	1				;...READ CPS VALUE TRANSFERRED BY THE GIVEN FUNCTION TABLE 
	 else
	  icps cpsmidi
	 endif
	 kcps	init	icps				;READ PITCH (CYCLES PER SECOND FORM MIDI KEYBOARD)
	 iampmidi	ampmidi	i(gkbrite)		;READ MIDI VELOCITY
	 kbrite		=	gkbrite-(iampmidi*gkvelsens)	;CREATE MIDI VELOCITY DEPENDENT 'BRIGHTNESS' VALUE. DEPENDENT ALSO UPON VELOCITY SENSITIVITY.
	elseif iMIDIflag=0 then				;OTHERWISE (FLTK)...
	 kcps	=	gkfundfrq			;TAKE FUNDEMENTAL FREQUENCY FROM FLTK SLIDER
	 kbrite		=	gkbrite			;'BRIGHTNESS' TAKEN FROM SOLELY FLTK SLIDER
	endif						;END OF CONDITIONAL BRANCH

	idur		=	i(gkdur)		;NOTE DURATION (DECAY TIME) TAKEN FROM FLTK SLIDER
	icount		=	1			;INITIALISE PARTIAL COUNTER
	inparts		=	i(gknparts)		;NUMBER OF PARTIALS TAKEN FROM FLTK COUNTER
	asig 	partial	idur,icount,inparts,i(gkdamp),i(gkrel),i(gkattstr),kcps,gkpartsOS,gkstretch,kbrite
		out	asig*gkgain
endin

</CsInstruments>

<CsScore>
i 99  0 3600
i 100 0 3600
f 0 3600	;DUMMY SCORE EVENT KEEPS PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>