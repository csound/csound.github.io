FLTKPitchBendWheel.csd
Written by Iain McCurdy, 2012

<CsoundSynthesizer>

<CsOptions>
-odac -dm0 -+rtmidi=virtual -M0
</CsOptions>

<CsInstruments>
sr	=	44100	
ksmps	=	32
nchnls	=	1
0dbfs	=	1

;FLTK INTERFACE CODE---------------------------------------------------------------------------------------------------------------------------------------------------------------------
FLcolor	255, 255, 255, 0, 0, 0
		FLpanel	"FLTK Pitch Bend Wheel", 700, 430, 0, 0


;VALUE DISPLAY BOXES		LABEL | WIDTH | HEIGHT | X  | Y
idPB			FLvalue	"",	 50,      18,    5,   40

;SLIDERS					MIN   |  MAX | EXP | TYPE | DISP  | WIDTH | HEIGHT | X  | Y
gkPB, gihPB	FLslider 	"Pitch Bend",	-2,       2,    0,   23,    idPB,    690,     30,    5,   10	;SLIDER HANDLE TO BE SPRING LOADED NEEDS TO BE A GLOBAL VARIABLE

;CREATE A FLTK VIRTUAL KEYBOARD WITHIN THIS WINDOW
FLvkeybd "", 700, 120, 0, 70

;TEXT BOXES															TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                        FLTK Spring Loaded Pitch Bend Wheel                          ", 	1,      5,     14,    690,    20,     5,  210
ih		 	FLbox  	"-------------------------------------------------------------------------------------", 	1,      5,     14,    690,    20,     5,  230
ih		 	FLbox  	"This is a simple demonstration of how to implement a 'spring loaded' slider that     ", 	1,      5,     14,    690,    20,     5,  250
ih		 	FLbox  	"could be used to emulate the functioning of a hardware pitch bend wheel. As the      ", 	1,      5,     14,    690,    20,     5,  270
ih		 	FLbox  	"FLTK virtual keyboard lacks this feature this technique may prove useful.            ", 	1,      5,     14,    690,    20,     5,  290
ih		 	FLbox  	"Although this example implements this contraption in relation to an FLTK slider it   ", 	1,      5,     14,    690,    20,     5,  310
ih		 	FLbox  	"could be easily be adapted for use with widgets constructed using other methods. For ", 	1,      5,     14,    690,    20,     5,  330
ih		 	FLbox  	"example, the '_MouseBut1' reserved channel would be used in CsoundQT to sense        ", 	1,      5,     14,    690,    20,     5,  350
ih		 	FLbox  	"activity with the left mouse button.                                                 ", 	1,      5,     14,    690,    20,     5,  370
ih		 	FLbox  	"*Note that the FLTK virtual keyboard can also be played from the computer's alpha-   ", 	1,      5,     14,    690,    20,     5,  390
ih		 	FLbox  	"-numeric keyboard (when the FLTK keyboard has focus).                                ", 	1,      5,     14,    690,    20,     5,  410


;SET INITIAL VALUES FOR VALUATORS 	VALUE | HANDLE
			FLsetVal_i	0, 	gihPB

		FLpanel_end	; END OF PANEL CONTENTS
		FLrun		;RUN THE WIDGET THREAD

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
	icps	cpsmidi						; INTERPRET MIDI NOTE VALUE PLAYED AS A FREQUENCY VALUE
	kporttime	linseg	0,0.001,0.02			; PORTAMENTO TIME. USE OF LINSEG FROM ZERO PREVENT SLIDES UP TO PITCH UPON EACH NEW NOTE
	kPB	portk	gkPB,kporttime				; APPLY PORTAMENTO TO PITCH BEND PARAMETER
	asig	vco2		0.1,icps*semitone(kPB),4,0.5	; CREATE A TRIANGLE WAVE OSCILLATOR. FREQUENCY OF OSCILLATOR IS DETERMINED BY BOTH MIDI NOT PLAYED AND PITCH BEND (RANGE +/- 2 SEMITONES)
		out	asig					; SEND OSCILLATOR AUDIO TO OUTPUT
endin

instr	2	;SPRING SLIDER (ALWAYS ON)
		spring_slider	gihPB,0				; CALL 'spring_slider' UDO. INPUT ARGS: | HANDLE | DEFAULT_VALUE |
endin

</CsInstruments>

<CsScore>
i 2 0 3600							; SPRING SLIDER INSTRUMENT (ALWAYS ON)
e
</CsScore>

</CsoundSynthesizer>