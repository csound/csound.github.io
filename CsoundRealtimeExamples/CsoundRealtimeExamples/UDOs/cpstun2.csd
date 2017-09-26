cpstun2.csd
A elaboration of the 'cpstun' opcode which facilitates glissandi between notes.

kcps cpstun2 knote,ktable

kcps - ouputted cycles per second value
knote - midi note number
ktable - table which contains the tuning ratios (see cpstun opcode)

<CsoundSynthesizer>
  
<CsOptions>

;FLTK (NO HARDWARE MIDI)
-odac -dm0 -+rtmidi=virtual -M0

;HARDWARE MIDI
;-odac -dm0 -Ma

</CsOptions>

<CsInstruments>
sr = 44100
ksmps = 64
nchnls = 1
0dbfs = 1

;FLTK INTERFACE CODE---------------------------------------------------------------------------------------------------------------------------------------------------------------------
FLcolor	255, 255, 255, 0, 0, 0
		FLpanel	"FLTK Pitch Bend Wheel", 700, 610, 0, 0


;VALUE DISPLAY BOXES		LABEL | WIDTH | HEIGHT | X  | Y
idPB			FLvalue	"",	 50,      18,    5,   40
                                                  
;SLIDERS							MIN   |  MAX | EXP | TYPE | DISP  | WIDTH | HEIGHT | X  | Y
gkPB, gihPB	FLslider 	"Pitch Bend (in steps)",	-1,       1,    0,   23,    idPB,    690,     30,    5,   10	;SLIDER HANDLE TO BE SPRING LOADED NEEDS TO BE A GLOBAL VARIABLE

;CREATE A FLTK VIRTUAL KEYBOARD WITHIN THIS WINDOW
FLvkeybd "", 624, 120, (700-624)/2, 70

;TEXT BOXES															TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                                   UDO - cpstun2                                     ", 	1,      5,     14,    690,    20,     5,  210
ih		 	FLbox  	"-------------------------------------------------------------------------------------", 	1,      5,     14,    690,    20,     5,  230
ih		 	FLbox  	"This UDO implements a development of the 'cpstun' opcode (used for deriving non-     ", 	1,      5,     14,    690,    20,     5,  250
ih		 	FLbox  	"standard tunings from MIDI note numbers).                                            ", 	1,      5,     14,    690,    20,     5,  270
ih		 	FLbox  	"Whereas 'cpstun' will only interpret whole number note numbers, 'cpstun2' will also  ", 	1,      5,     14,    690,    20,     5,  290
ih		 	FLbox  	"interpret fractional components that will be interpretted as fractions of note       ", 	1,      5,     14,    690,    20,     5,  310
ih		 	FLbox  	"'steps' from the current note number. This example also uses another UDO,            ", 	1,      5,     14,    690,    20,     5,  330
ih		 	FLbox  	"'spring_slider', to implement the spring loaded FLTK slider used for pitch bend. The ", 	1,      5,     14,    690,    20,     5,  350
ih		 	FLbox  	"code for instr 1 includes a commented out block of code for use with hardware MIDI.  ", 	1,      5,     14,    690,    20,     5,  370
ih		 	FLbox  	"Re-introduce this code and amend <CsOptions> to use an external keyboard. Note that  ", 	1,      5,     14,    690,    20,     5,  390
ih		 	FLbox  	"the FLTK virtual keyboard can be played from the computer's alphanumeric keyboard    ", 	1,      5,     14,    690,    20,     5,  410
ih		 	FLbox  	"when it has focus.                                                                   ", 	1,      5,     14,    690,    20,     5,  430
ih		 	FLbox  	"                                                                                     ", 	1,      5,     14,    690,    20,     5,  450
ih		 	FLbox  	"   kcps             knote, ktable                                                    ", 	1,      5,     14,    690,    20,     5,  470
ih		 	FLbox  	"cpstun2", 											1,      6,     14,     90,    20,    75,  470
ih		 	FLbox  	"                                                                                     ", 	1,      5,     14,    690,    20,     5,  490
ih		 	FLbox  	"Performance:                                                                         ", 	1,      7,     14,    690,    20,     5,  510
ih		 	FLbox  	"kcps   -  cycles per second frequency                                                ", 	1,      5,     14,    690,    20,     5,  530
ih		 	FLbox  	"knote  -  note number (as in MIDI). Non integer values accepted and interpretted.    ", 	1,      5,     14,    690,    20,     5,  550
ih		 	FLbox  	"ktable -  number of the GEN02 function table used to store data for the user defined-", 	1,      5,     14,    690,    20,     5,  570
ih		 	FLbox  	"                                        -tuning. See cpstun opcode manual entry.     ", 	1,      5,     14,    690,    20,     5,  590

;SET INITIAL VALUES FOR VALUATORS 	VALUE | HANDLE
			FLsetVal_i	0, 	gihPB

		FLpanel_end	; END OF PANEL CONTENTS
		FLrun		;RUN THE WIDGET THREAD

;			FN_NUM | INIT_TIME | SIZE | GEN_ROUTINE | NUM_GRADES | REPEAT |  BASE_FREQ     | BASE_KEY_MIDI | TUNING_RATIOS:-0-|----1----|---2----|----3----|----4----|----5----|----6----|----7----|----8----|----9----|----10-----|---11----|---12---|---13----|----14---|----15---|---16----|----17---|---18----|---19---|----20----|---21----|---22----|---23---|----24----|----25----|----26----|----27----|----28----|----29----|----30----|----31----|----32----|----33----|----34----|----35----|----36----|
giTTable1	ftgen     1,         0,       64,        -2,         12,        13,    cpsmidinn(60),        60,                      1/5,   2/5,     3/5,      4/5,      5/5,      6/5,      7/5,      8/5,      9/5,      10/5,     11/5,      12/5,     13/5
;giTTable1	ftgen     1,         0,       64,        -2,         12,         2,     cpsmidinn(60),        60,                       1, 1.059463,1.1224619,1.1892069,1.2599207,1.33483924,1.414213,1.4983063,1.5874001,1.6817917,1.7817962, 1.8877471,     2	;STANDARD



;  kcps  cpstun2  knote,ktable
; INPUT ARGS:
; knote - note number (as in MIDI). Fractional values will be interpretted appropriately.
; ktable - function table number containing tuning ratios (see manual entry or my example for 'cpstun' for further details)
; OUPUT ARG:                                                                               
; kcps - CYCLES-PER-SECOND FREQUENCY
		opcode	cpstun2,k,kk
knote,ktable	xin
ktrig		changed	knote					; create a trigger if note value changes 
kcpsLo 		cpstun	ktrig, int(knote), ktable		; define a cps value for the integer note value beneath the fractional note value
kcpsUp 		cpstun	ktrig, int(knote)+1, ktable		; define a cps value for the integer note value above the fractional note value
koctLo		=	octcps(kcpsLo)				; lower pitch in oct format
koctUp		=	octcps(kcpsUp)				; upper pitch in oct format
koct		=	koctLo+((koctUp-koctLo)*frac(knote)) 	; linearly interpoloated pitch according to fractional note value in oct format
kcps		=	cpsoct(koct)				; oct format pitch converted to cps format
		xout	kcps					; return cps value to caller instrument
endop




; SPRING-LOADED FLTK SLIDER CONTRAPTION CREATED AS A UDO FOR EASY TRANSPLANTATION
; INPUT ARGS:
; ihandle - handle used to commumicate with slider
; idefault_val - value to which the slider will 'spring back'
opcode spring_slider,0,ii
	gihandle,idefault_val	xin				; READ IN INPUT VALUES
	kx, ky, kb1, kb2, kb3 FLmouse				; READ MOUSE DATA (WE WILL ONLY USE THE LEFT BUTTON DATA)
	kButtonChange	changed	kb1				; IF LEFT MOUSE BUTTON IS CLICKED ON OR OFF GENERATE A '1' TRIGGER AT THE OUTPUT
	if kButtonChange==1 then				; IF LEFT MOUSE BUTTON HAS CHANGED STATE...
	 if kb1==0 then						; IF LEFT MOUSE BUTTON HAS JUST BEEN RELEASED...
	  FLsetVal kButtonChange, idefault_val, gihandle	; ...SET SPRING-LOADED SLIDER TO IT DEFAULT VALUE AND POSITION
	 endif							; END OF CONDITIONAL BRANCH
	endif							; END OF CONDITIONAL BRANCH
endop								; END OF OPCODE




instr	1
	kporttime	linseg	0,0.01,0.02
	ktable	init	giTTable1
	inote	notnum
	
	/*
	; HARDWARE MIDI (UNCOMMENT THIS BLOCK OF CODE FOR USE WITH AN EXTERNAL HARDWARE MIDI DEVICE. YOU WILL ALSO NEED TO AMEND THE <CsOptions>)
	kbend	pchbend	imin,imax		; THIS WILL OUTPUT A RANGE FROM -1 TO +1 WITH ZERO AT THE EQUILIBRIUM POSITION. 
	irange	=	1			; RANGE OF THE HARDWARE PITCH BEND CONTROL (-irange to +irange)
	gkPB	=	kbend*irange
	*/
	
	kPB	portk	gkPB,kporttime		; APPLY PORTAMENTYO SMOOTHING TO CHANGED IN THE PITCH BEND VALUE
	kcps	cpstun2	inote+kPB,ktable	; DERIVE A CPS VALUE FROM NOTE PLAYED AND PITCH BEND USING THE USER DEFINED TUNING SYSTEM
	aenv	linsegr	0,0.02,1,0.02,0		; AMPLITUDE ENVELOPE (RELEASE SENSING)
	asig	vco2	0.2,kcps,4,0.5		; CREATE A TRIANGLE WAVE OSCILLATOR
		out	asig*aenv		; SEND AUDIO TO OUTPUT
endin

instr	2	;SPRING SLIDER (ALWAYS ON)
		spring_slider	gihPB,0		; CALL 'spring_slider' UDO. INPUT ARGS: | HANDLE | DEFAULT_VALUE |
endin

</CsInstruments>
<CsScore>
i 2 0 3600							; SPRING SLIDER INSTRUMENT (ALWAYS ON)
e
</CsScore>

</CsoundSynthesizer>