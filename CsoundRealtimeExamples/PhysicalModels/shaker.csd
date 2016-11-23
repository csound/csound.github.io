;Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
-odevaudio -b400
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	100	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL    | WIDTH | HEIGHT | X | Y
		FLpanel	"shaker",   500,    400,    0,  0

;BUTTONS					ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff	FLbutton	"Shake!",	1,    0,    21,    200,     30,   150, 10,    0,     1,      0,       -1


;VALUE DISPLAY BOXES	LABEL  | WIDTH | HEIGHT | X |  Y
idamp		FLvalue	" ",       70,     18,    5,   75
idfreq		FLvalue	" ",       70,     18,    5,  125
idbeans		FLvalue	" ",       70,     18,    5,  175
iddamp		FLvalue	" ",       70,     18,    5,  225
iddecay		FLvalue	" ",       70,     18,    5,  275
idoutgain	FLvalue	" ",       70,     18,    5,  375

;SLIDERS				            					MIN | MAX    | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X   | Y
gkamp, ihamp			FLslider	"Amplitude",				0,        1,    0,    23,   idamp,        490,     25,    5,    50
gkfreq, ihfreq			FLslider	"Frequency",				.5,   20000,   -1,    23,   idfreq,       490,     25,    5,   100
gkbeans, ihbeans		FLslider	"Number of Beans",			1,      500,    0,    23,   idbeans,      490,     25,    5,   150
gkdamp, ihdamp			FLslider	"Damping",				0.98,     1,    0,    23,   iddamp,       490,     25,    5,   200
gkdecay,ihdecay			FLslider 	"Decay Time (i-rate)",			0,        1,    0,    23,   iddecay,      490,     25,    5,   250
gkoutgain,ihoutgain		FLslider 	"Output Gain",				0,       10,    0,    23,   idoutgain,    490,     25,    5,   350

;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gktimes, ihtimes 		FLcount  "Number of Shakes", 	0,    50,    1,      10,      1,    140,     25,   180,300,    -1

;SET INITIAL VALUES OF FLTK VALUATORS
;				VALUE | HANDLE
		FLsetVal_i	0.2, 	ihamp
		FLsetVal_i	1, 	ihfreq
		FLsetVal_i	30, 	ihbeans
		FLsetVal_i	0.99, 	ihdamp
		FLsetVal_i	5, 	ihtimes
		FLsetVal_i	0, 	ihdecay
		FLsetVal_i	0.5, 	ihoutgain

		FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 340, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           shaker                            ", 	1,       5,    14,    490,     20,    5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,       5,    14,    490,     20,    5,  20
ih		 	FLbox  	"'shaker' is a semi-physical model of the sound of a maraca   ", 	1,       5,    14,    490,     20,    5,  40
ih		 	FLbox  	"being shaken.                                                ", 	1,       5,    14,    490,     20,    5,  60
ih		 	FLbox  	"'Frequency' controls the resonance of the maraca.            ", 	1,       5,    14,    490,     20,    5,  80
ih		 	FLbox  	"'Number of Beans' seems to offer inverse control of the      ", 	1,       5,    14,    490,     20,    5, 100
ih		 	FLbox  	"number of beans in the shaker. High values here result in a  ", 	1,       5,    14,    490,     20,    5, 120
ih		 	FLbox  	"shaker containing fewer beans.                               ", 	1,       5,    14,    490,     20,    5, 140
ih		 	FLbox  	"'Damping' simulates the internal mechanical damping of the   ", 	1,       5,    14,    490,     20,    5, 160
ih		 	FLbox  	"shaker. Higher values closer to 1 result in less damping.    ", 	1,       5,    14,    490,     20,    5, 180
ih		 	FLbox  	"'Amplitude' controls the speed of shaking as well as the     ", 	1,       5,    14,    490,     20,    5, 200
ih		 	FLbox  	"amplitude. For this reason a separate output gain is         ", 	1,       5,    14,    490,     20,    5, 220
ih		 	FLbox  	"provided.                                                    ", 	1,       5,    14,    490,     20,    5, 240
ih		 	FLbox  	"'Number of Shakes' works as expected except that one extra   ", 	1,       5,    14,    490,     20,    5, 260
ih		 	FLbox  	"shake is given for the number indicated, e.g. given a value  ", 	1,       5,    14,    490,     20,    5, 280
ih		 	FLbox  	"zero, one shake will result.                                 ", 	1,       5,    14,    490,     20,    5, 300
ih		 	FLbox  	"'Decay Time' appears to have no effect.                      ", 	1,       5,    14,    490,     20,    5, 320
                                                                                                                                                 
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1
	kSwitch		changed		gkdecay	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if kSwitch=1	then
		reinit	BEGIN
	endif
	BEGIN:
	ashaker shaker 		gkamp, gkfreq, gkbeans, gkdamp, gktimes , i(gkdecay)
	rireturn
		outs 		ashaker * gkoutgain, ashaker * gkoutgain
endin

</CsInstruments>

<CsScore>
f 0 3600	;'DUMMY' SCORE EVENT KEEPS REALTIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>