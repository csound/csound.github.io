Written by Iain McCurdy

<CsoundSynthesizer>

<CsOptions>
-iadc -odac -b32 -dm0
</CsOptions>

<CsInstruments>

sr	= 	44100
ksmps	= 	8
nchnls	= 	2

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;		LABEL | WIDTH | HEIGHT | X | Y
	FLpanel	"ins",   500,    70,    0,  0

;VALUE DISPLAY BOXES		LABEL | WIDTH | HEIGHT | X | Y
idgain			FLvalue	" ",	 80,      20,    5, 45

;SLIDERS				            	MIN   | MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X  | Y
gkgain, ihgain		FLslider 	"Gain",		0,       4,    0,    23,   idgain,    490,     25,    5,  20

;SET INITIAL VALUES FOR SLIDERS 	|VALUE | HANDLE
			FLsetVal_i	.2, 	ihgain

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     480,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                             ins                             ", 	1,      5,     14,    490,     20,    5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,     20,    5,  20
ih		 	FLbox  	"This example is a simple demonstration of the 'ins' opcode   ", 	1,      5,     14,    490,     20,    5,  40
ih		 	FLbox  	"which reads audio information from the computer's default    ", 	1,      5,     14,    490,     20,    5,  60
ih		 	FLbox  	"audio input. It doesn't do anything spectacular other than   ", 	1,      5,     14,    490,     20,    5,  80
ih		 	FLbox  	"merely output the audio to the speakers. It will allow you to", 	1,      5,     14,    490,     20,    5, 100
ih		 	FLbox  	"monitor the latency of your system. (The time delay between  ", 	1,      5,     14,    490,     20,    5, 120
ih		 	FLbox  	"an impulse sound entering the computer and it being replayed ", 	1,      5,     14,    490,     20,    5, 140
ih		 	FLbox  	"out the speakers again.) Latency can be reduced by reducing  ", 	1,      5,     14,    490,     20,    5, 160
ih		 	FLbox  	"the size and the number of audio buffers used by Csound. This", 	1,      5,     14,    490,     20,    5, 180
ih		 	FLbox  	"is done using command line flags in the <CsOptions> section  ", 	1,      5,     14,    490,     20,    5, 200
ih		 	FLbox  	"of the csd file. Refer to the Csound manual for further      ", 	1,      5,     14,    490,     20,    5, 220
ih		 	FLbox  	"information. If buffer sizes are too small audio underruns   ", 	1,      5,     14,    490,     20,    5, 240
ih		 	FLbox  	"(glitches) will occur.                                       ", 	1,      5,     14,    490,     20,    5, 260
ih		 	FLbox  	"The audio hardware that you are using with your computer and ", 	1,      5,     14,    490,     20,    5, 280
ih		 	FLbox  	"its related drivers will also have an effect upon the        ", 	1,      5,     14,    490,     20,    5, 300
ih		 	FLbox  	"latencies that you can achieve.                              ", 	1,      5,     14,    490,     20,    5, 320
ih		 	FLbox  	"Typically some sort of audio processing would be performed   ", 	1,      5,     14,    490,     20,    5, 340
ih		 	FLbox  	"upon the audio signal created by the ins opcode before it    ", 	1,      5,     14,    490,     20,    5, 360
ih		 	FLbox  	"would be passed to the output. The only processing that is   ", 	1,      5,     14,    490,     20,    5, 380
ih		 	FLbox  	"applied in this example is a gain control.                   ", 	1,      5,     14,    490,     20,    5, 400
ih		 	FLbox  	"Also useful is the 'inch' opcode which allows you to select  ", 	1,      5,     14,    490,     20,    5, 420
ih		 	FLbox  	"audio from a specific channel. This might be useful if you   ", 	1,      5,     14,    490,     20,    5, 440
ih		 	FLbox  	"are using a soundcard with a multi-channel audio in.         ", 	1,      5,     14,    490,     20,    5, 460

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen	0,0,4096,10,1

instr	1	;ALWAYS ON - SEE SCORE
	ainL, ainR	ins					;READ STEREO INPUT FROM THE COMPUTERS AUDIO INPUT
			outs	ainL * gkgain, ainR * gkgain	;SEND AUDIO TO STEREO OUTPUT AND APPLY gkgain RESCALING
endin

</CsInstruments>

<CsScore>
i 1 0 3600	;INSTRUMENT 1 PLAYS FOR 1 HOUR (AND KEEPS PERFORMANCE GOING)
</CsScore>

</CsoundSynthesizer>