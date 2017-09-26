;Written by Iain McCurdy, 2010

<CsoundSynthesizer>

<CsOptions>
-odevaudio -b400 -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
kr 		= 	4410	;CONTROL RATE
ksmps 		= 	10	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE WILL BE 1

;FLTK INTERFACE CODE=================================================================================================================================================================================
FLcolor	255, 255, 255, 0, 0, 0
FLpanel	"trigger",   500,    150,    0,  0


	;VALUE DISPLAY BOXES	LABEL | WIDTH | HEIGHT | X | Y
	idsignal	FLvalue	" ",	 70,      20,    0,  25
	idthreshold	FLvalue	" ",	 70,      20,    0,  75

	;SLIDERS     					LABEL                 	MIN   | MAX | EXP | TYPE |  DISP      | WIDTH | HEIGHT | X  | Y
	gksignal, ihsignal		FLslider	"Trigger Signal",       0,        1,    0,   3,   idsignal,      500,    25,     0,   0
	gkthreshold, ihthreshold	FLslider	"Threshold",    	0,        1,    0,   1,   idthreshold,   500,    25,     0,  50
	FLsetColor2	255, 100, 100, ihthreshold
	FLsetColor2	100, 100, 255, ihsignal

	;GENERAL_TEXT_SETTINGS		SIZE | FONT |  ALIGN | RED | GREEN | BLUE
		FLlabel			13,      4,      1,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

	;BUTTON BANKS			TYPE | NUMX | NUMY | WIDTH | HEIGHT | X  |  Y  | OPCODE
	gkmode,ihmode	FLbutBank	4,      1,     3,      25,     45,    40,  100,   -1

	;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

	;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
	ih		 	FLbox  	"Mode:",      		1,       4,    12,     40,     15,     0, 100
	ih		 	FLbox  	"Up     ", 		1,       5,    11,     70,     15,    70, 100
	ih		 	FLbox  	"Down   ", 		1,       5,    11,     70,     15,    70, 115
	ih		 	FLbox  	"Up/Down", 		1,       5,    11,     70,     15,    70, 130

	;SET INITIAL VALUES FOR SLIDERS |VALUE | HANDLE
	FLsetVal_i	0.5,    ihthreshold
	FLsetVal_i	0,      ihsignal

FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     260,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          trigger                            ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"The trigger opcode can be used to output a momentary '1' if a", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"k-rate signal crosses a user defined threshold. It can be    ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"asked to sense upward crossings, downward crossings or both  ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"upward and downward crossings.                               ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"In this example the momentary '1' (called a 'bang' in MaxMSP)", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"is used to trigger a sounding instrument using schedkwhen.   ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"The sounding instrument itself checks whether it is an upward", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"or a downward crossing and generates a high or a low tone    ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"accordingly.                                                 ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"This opcode can be useful in using a MIDI continuous         ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"controller to trigger a Csound instrument.                   ", 	1,      5,     14,    490,    15,     5, 240

				FLpanel_end
                                                                                        
				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE==========================================================================================================================================================================

gisine	ftgen	0, 0, 1024, 10, 1	;A SINE WAVE

instr	1	;
	ain	inch	1
	afollow 	follow2 	ain, 0.01, 0.01		;CREATE A AMPLITUDE FOLLOWING UNIPOLAR SIGNAL
	kfollow		downsamp	afollow			;DOWNSAMPLE TO CREATE A K-RATE VERSION OF THE AMPLITUDE FOLLOWING SIGNAL
	kbang 	trigger gksignal, gkthreshold, gkmode		;OUTPUT A MOMENTARY 1 IF 'gksignal' crosses 'gkthreshold' IN THE DIRECTION(S) ACCORDING TO 'gkmode'
	;OPCODE	 	KTRIGGER, KMINTIME, KMAXNUM, KINSNUM, KWHEN, KDUR
	schedkwhen	kbang,       0,        0,      2,       0,     1	;INSTRUCT instr 2 TO PLAY A NOTE WHENEVER 'kbang' IS 1
endin

instr 2		;
	icps	=	(i(gksignal)>i(gkthreshold)?500:300)	;DEFINE THE PITCH OF THE NOTE ACCORDING TO WHETHER THIS NOTE WAS GENERATED BY AN UPWARD OR A DOWNWARD CROSSING
	aenv	expon	0.5,p3,0.0001				;PERCUSSIVE ENVELOPE
	asig	oscili	aenv, icps, gisine			;AUDIO OSCILLATOR
	outs	asig, asig					;SEND AUDIO TO OUTPUTS
endin
		
</CsInstruments>

<CsScore>
i 1 0 3600	;THRESHOLD CROSSING TESTING INSTRUMENT PLAYS FOR 1 HOUR (AND KEEPS REALTIME PERFORMANCE GOING)
</CsScore>

</CsoundSynthesizer>