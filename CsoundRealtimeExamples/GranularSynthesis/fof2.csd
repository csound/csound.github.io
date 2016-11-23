fof2.csd
Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
-odac -dm0 -M0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;			LABEL  | WIDTH | HEIGHT | X | Y
		FLpanel	"fof2",   515,     500,   0,  0	;780
		FLscroll          512,     500,   0,  0
;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,    0,    22,    150,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;NUMBER DISPLAY BOXES			WIDTH | HEIGHT | X | Y
idamp			FLvalue	" ",	80,      20,     5,  75
idoct			FLvalue	" ",	80,      20,     5, 455
idband			FLvalue	" ",	80,      20,     5, 505
iddur			FLvalue	" ",	80,      20,     5, 555
idris			FLvalue	" ",	80,      20,     5, 605
iddec			FLvalue	" ",	80,      20,     5, 655
idphs			FLvalue	" ",	80,      20,     5, 705
idgliss			FLvalue	" ",	80,      20,     5, 755

;SLIDERS					      			MIN |  MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X   | Y
gkamp, ihamp		FLslider	"Amplitude",  			0,        1,  0,    23,    idamp,     490,     25,    5,    50
gkoct, gihoct		FLslider	"Octaviation Factor (CC#2)",	0,        8,  0,    23,    idoct,     490,     25,    5,   430
gkband, ihband		FLslider	"Bandwidth",			0,      100,  0,    23,    idband,    490,     25,    5,   480
gkdur, ihdur		FLslider	"Duration",			0.017,    1,  0,    23,    iddur,     490,     25,    5,   530
gkris, ihris		FLslider	"Rise Time",			0.001, 0.05,  0,    23,    idris,     490,     25,    5,   580
gkdec, ihdec		FLslider	"Decay Time",			0.001, 0.05,  0,    23,    iddec,     490,     25,    5,   630
gkphs, ihphs		FLslider	"Phase",			0,        1,  0,    23,    idphs,     490,     25,    5,   680
gkgliss, gihgliss	FLslider	"Glissando (octaves) (CC#1)",	-5,       5,  0,    23,    idgliss,   490,     25,    5,   730

;NUMBER DISPLAY BOXES			WIDTH | HEIGHT | X | Y
idfund			FLvalue	"Fund.",70,      20,     5,  380
idform			FLvalue	"Form.",70,      20,   420,  380

;XY PANELS									MINX | MAXX | MINY | MAXY | EXPX | EXPY | DISPX | DISPY | WIDTH | HEIGHT | X | Y
gkfund, gkform, ihfund, ihform	FLjoy	"X - Fundemental  Y - Formant",	1,     5000,   20,   5000,   -1,    -1,  idfund, idform,   490,    280,    5, 100
FLsetColor2	255, 0, 0, ihfund		;SET SECONDARY COLOUR TO RED
FLsetColor2	255, 0, 0, ihform		;SET SECONDARY COLOUR TO RED

; INITIALISATION OF SLIDERS	VALUE | HANDLE
		FLsetVal_i	0.05, 	ihamp
		FLsetVal_i	14, 	ihfund
		FLsetVal_i	277, 	ihform
		FLsetVal_i	0.5, 	gihoct
		FLsetVal_i	5.4, 	ihband
		FLsetVal_i	0.13, 	ihdur
		FLsetVal_i	.003, 	ihris
		FLsetVal_i	.007, 	ihdec
		FLsetVal_i	0, 	ihphs
		FLsetVal_i	3, 	gihgliss
		FLscroll_end
		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL

				FLpanel	" ", 515, 280, 512, 0

;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           fof2                              ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"fof2 is an elaboration of the fof opcode. For a description  ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"of most of the parameters of fof2 I recommend to study the   ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"fof example first.                                           ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"The principle innovations of fof2 over fof is the ability to ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"modulate starting phase of each grain at k-rate and the      ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"inclusion of a gliss parameter which glissandos each grain up", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"or down a given interval (defined in octaves). This type of  ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"granular synthesis is called 'glisson' synthesis.            ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"The instrument can also be triggered from a MIDI keyboard.   ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"MIDI notes translate to the fundemental of the tone. MIDI    ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"controller 1 can be used to modulate glissando depth and CC#2", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"can be used to modulate octaviation factor.                  ", 	1,      5,     14,    490,    20,     5, 260

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen	0, 0, 4096, 10, 1			;SINE WAVE
gifile	ftgen	0, 0, 1048576, 1, "ClassicalGuitar.wav", 0, 4, 1 
giexp	ftgen	0, 0, 1024, 19, 0.5, 0.5, 270, 0.5	;EXPONENTIAL CURVE

;INITIALIZE MIDI CONTROLLERS
initc7	1,1,4/5
initc7	1,2,1/16

instr	1
	iporttime	=	0.2			; CREATE A VARIABLE THAT WILL BE USED FOR PORTAMENTO TIME
	kporttime	linseg	0,0.001,iporttime	; CREATE A VARIABLE THAT WILL BE USED FOR PORTAMENTO TIME
	kgliss		portk	gkgliss, kporttime	;APPLY PORTAMENTO SMOOTHING TO FLTK SLIDER PARAMETER
	iMIDIActiveValue	=	1		;IF MIDI ACTIVATED
	iMIDIflag		=	0		;IF FLTK ACTIVATED
	mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 
	icps	cpsmidi		;READ MIDI PITCH VALUES - THIS VALUE CAN BE MAPPED TO GRAIN DENSITY AND/OR PITCH DEPENDING ON THE SETTING OF THE MIDI MAPPING SWITCHES

	if	gkOnOff=0&&iMIDIflag=0	then ;SENSE FLTK ON/OFF SWITCH & WHETHER THIS IS A MIDI NOTE ITS STATUS WILL BE IGNORED
				turnoff	;TURNOFF THIS INSTRUMENT IMMEDIATELY
	endif

	if iMIDIflag=1 then	;IF THIS IS A MIDI ACTIVATED NOTE AND MIDI-TO-DENSITY SWITCH IS ON... 
		kfund	=	icps		;MAP TO MIDI NOTE VALUE TO DENSITY
	else					;OTHERWISE...
		kfund		portk	gkfund, kporttime	;USE THE FLTK SLIDER VALUE
	endif					;END OF THIS CONDITIONAL BRANCH

	kamp	portk	gkamp, kporttime	;APPLY PORTAMENTO TO SELECTED FLTK SLIDER VARIABLE AND CREATE NEW NON-GLOBAL VARIABLES TO BE USED BY THE FOF OPCODE
	kform	portk	gkform, kporttime       ;APPLY PORTAMENTO TO SELECTED FLTK SLIDER VARIABLE AND CREATE NEW NON-GLOBAL VARIABLES TO BE USED BY THE FOF OPCODE
	
	iolaps	=	500		;MAXIMUM ALLOWED NUMBER OF GRAIN OVERLAPS (THE BEST IDEA IS TO SIMPLY OVERESTIMATE THIS VALUE)
	ifna	=	gisine		;WAVEFORM USED BY THE GRAINS (NORMALLY A SINE WAVE)
	ifnb	=	giexp		;WAVEFORM USED IN THE DESIGN OF THE EXPONENTIAL ATTACK AND DECAY OF THE GRAINS
	itotdur	=	3600		;TOTAL DURATION OF THE FOF NOTE. IN NON-REALTIME THIS WILL BE p3. IN REALTIME OVERESTIMATE THIS VALUE, IN THIS CASE 1 HOUR - PERFORMANCE CAN STILL BE INTERRUPTED PREMATURELY
	
	;THE FOF2 OPCODE:
	asig	fof2	gkamp, kfund, kform, gkoct, gkband, gkris, gkdur, gkdec, iolaps, ifna, ifnb, itotdur, gkphs, kgliss
	aenv	linsegr	1,0.1,0
		outs	asig*aenv, asig*aenv	;OUTPUT OF fof OPCODE IS SENT TO THE OUTPUTS  
endin

instr	2	;UPDATE FLTK SLIDERS FROM MIDI CONTROLLER VALUES
        ;MIDI CONTROLLER SYNCHRONISATION
#define CONTROLLER(NAME'NUMBER'MIN'MAX)
        #
        k$NAME          ctrl7           1,$NUMBER,0,1           ;READ MIDI CONTROLLER
        ktrig$NAME      changed         k$NAME                  ;CREATE A TRIGGER PULSE IF MIDI CONTROLLER IS MOVED
        k$NAME          scale           k$NAME, $MAX, $MIN      ;VARIBALE HAS TO BE RESCALED HERE, DOING IT IN THE ctrl7 LINE UPSETS THE WORKING OF THE changed OPCODE ABOVE
        FLsetVal        ktrig$NAME,     k$NAME, gih$NAME                ;UPDATE FLTK VALUATOR IF MIDI CONTROLLER HAS BEEN MOVED
        #
        ;           NAME    NUM MIN MAX
        $CONTROLLER(gliss'   1 '-5 ' 5)
        $CONTROLLER(oct'     2 ' 0 ' 8)
endin


</CsInstruments>

<CsScore>
i 2 0 3600	;UPDATE FLTK SLIDERS FROM MIDI CONTROLLER VALUES
</CsScore>

</CsoundSynthesizer>