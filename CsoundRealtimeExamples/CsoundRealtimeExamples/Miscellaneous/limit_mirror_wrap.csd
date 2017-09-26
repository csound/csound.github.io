;WRITTEN BY IAIN MCCURDY, 2009

<CsoundSynthesizer>

<CsOptions>
-odevaudio -b400
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	100	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 150, 150, 150
;				LABEL                 | WIDTH | HEIGHT | X | Y
			FLpanel	"limit,mirror,wrap",     500,    275,    0,  0

;VALUE DISPLAY BOXES		LABEL  | WIDTH | HEIGHT | X | Y
idinput			FLvalue	"",       100,     20,    0, 100
idmin			FLvalue	"",       100,     20,    0, 150
idmax			FLvalue	"",       100,     20,    0, 200
idoutput		FLvalue	"",       100,     20,    0, 250

;SLIDERS				            		MIN | MAX | EXP | TYPE |  DISP     | WIDTH | HEIGHT | X  | Y
gkinput, ihinput		FLslider 	"Input Value",	-2,    2,    0,    5,    idinput,     500,     25,    0,  75
gkmin, ihmin			FLslider 	"Minimum",	-2,    2,    0,    1,    idmin,       500,     25,    0, 125
gkmax, ihmax			FLslider 	"Maximum",	-2,    2,    0,    1,    idmax,       500,     25,    0, 175
gkoutput, gihoutput		FLslider 	"Output Value",	-2,    2,    0,    5,    idoutput,    500,     25,    0, 225

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)
FLcolor2	0, 0, 0

;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkmode, ihmode			FLbutBank	14,     1,     3,     18,      60,    5,  5,   -1
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"limit ", 		1,       5,    14,     70,      20,   20,  5
ih		 	FLbox  	"mirror", 		1,       5,    14,     70,      20,   20, 25
ih		 	FLbox  	"wrap  ", 		1,       5,    14,     70,      20,   20, 45


;SET INITIAL VALUES FOR SLIDERS		|VALUE  | HANDLE
			FLsetVal_i	  0, 	  ihinput
			FLsetVal_i	  0, 	  ihmin
			FLsetVal_i	  1, 	  ihmax
			FLsetVal_i	  0, 	  gihoutput

				FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     460,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                    limit, mirror, wrap                      ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"       koutput    limit     kinput, kminimum, kmaximum       ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"       koutput    mirror    kinput, kminimum, kmaximum       ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"       koutput    wrap      kinput, kminimum, kmaximum       ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"Limit, mirror and wrap are opcodes that prevent a variable   ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"going beyond a user defined maximum and minimum. How out of  ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"range values are dealt with varies between opcodes.          ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"'Limit' applies a 'brick wall' style limitation by freezing  ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"excessively large or small value at the maxima and minima.   ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"'Mirror' reflects back out of range values by the amount by  ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"which thay have exceeded the boundary. If reflections        ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"attempt to go beyond the opposite boundary they are reflected", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"again.                                                       ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"'Wrap' forces out of range values to re-emerge next to the   ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"opposite boundary.                                           ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"All three opcodes can operate at i, k or a rate.             ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"These opcodes can be useful in algorithmic composition, for  ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"preventing filter cutoff frequencies from exceeding sensible ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"limits and when dealing with function table indexes.         ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"Use the radio buttons to choose between 'limit', 'mirror' and", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"'wrap'.                                                      ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"THIS EXAMPLE PRODUCES NO SOUND.                              ", 	1,      5,     14,    490,    20,     5, 440

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1	;ALWAYS ON - SEE SCORE
	ktrigger	changed	gkinput	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'ktrigger' IF gkinput CHANGES (gkoutput SLIDER WILL BE UPDATED)
	if	gkmode=0	then			;IF MODE 0 (limit) IS SELECTED..
		koutput	limit	gkinput, gkmin, gkmax	;APPLY 'limit' TO gkinput VALUES
	elseif	gkmode=1	then			;IF MODE 1 (mirror) IS SELECTED..
		koutput	mirror	gkinput, gkmin, gkmax   ;APPLY 'mirror' TO gkinput VALUES
	else						;IF MODE 2 (wrap) IS SELECTED..
		koutput	wrap	gkinput, gkmin, gkmax   ;APPLY 'wrap' TO gkinput VALUES
	endif						;END OF CONDITIONAL BRANCHING
	FLsetVal	ktrigger, koutput, gihoutput	;UPDATE gkoutput SLIDER
endin

</CsInstruments>

<CsScore>
i 1 0 3600	;INSTRUMENT 1 PLAYS FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>
