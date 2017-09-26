FLkybd.csd
Written by Iain McCurdy, 2010

<CsoundSynthesizer>

<CsOptions>
-odac -d -m0 -+rtmidi=virtual -M0
</CsOptions>

<CsInstruments>

sr		=	44100
ksmps		=	8
nchnls		=	2
0dbfs		=	1


		FLpanel	"FLkybd", 1280, 240, 0,0
FLvkeybd "", 1280, 240, 0, 0

		FLpanelEnd	;END OF PANEL CONTENTS

FLcolor	255, 255, 255, 0, 0, 0		
;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     220,    0, 290
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                            FLkybd                           ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"FLkybd can be used to create an FLTK keyboard widget that    ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"functions in a similar fashion to the virtual keyboard (but  ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"without the continuous controllers).                         ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"The command line flags '-M(number)' and '-+rtmidi=virtual'   ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"are still required.                                          ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"The advantages of using FLkybd over the virtual device is    ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"that FLkybd can be embedded within an FL panel along with    ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"other widgets and it can be resized, as this example         ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"demonstrates.                                                ", 	1,      5,     14,    490,    15,     5, 200

		FLrun		;RUN THE WIDGET THREAD

giwave		ftgen	3, 0, 4096, 10, 1,1/2,1/4,1/8,1/16,1/32,1/64,1/128,1/256,1/512,1/1024	;A RICH HARMONIC WAVEFORM

instr	1
	icps	cpsmidi
	iamp	ampmidi	1
	aenv	linsegr	0,0.01,1,0.01,0
	a1	poscil	0.1*aenv*iamp, icps, giwave
	outs	a1, a1 
endin

</CsInstruments>

<CsScore>
f 0 3600
</CsScore>

</CsoundSynthesizer>