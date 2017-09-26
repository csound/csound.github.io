;Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
-odevaudio -b400
</CsOptions>

<CsInstruments>

;A SINGLE OSCILLATOR WITH FREQUENCY, AMPLITUDE AND PANNING CONTROLS ON SEPARATE TAB CARDS

sr		=	44100
kr		=	441
ksmps		=	100
nchnls		=	2
0dbfs		=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

;		OPCODE	 LABEL | WIDTH | HEIGHT | X | Y
		FLpanel	"Tabs",   500,    400,   100, 100

FLcolor	255,200,255

itabswidth	=	480	
itabsheight	=	330
ix		=	5
iy		=	5
	FLtabs	itabswidth,itabsheight, ix,iy

itab1width	=	480	
itab1height	=	300
itab1x		=	10
itab1y		=	40
		FLgroup	"Tab 1: Frequency", itab1width, itab1height, itab1x, itab1y
gkfreq,i1	FLknob	"Frequency", 200, 5000, -1, 1, -1, 70, 70, 130, 20
		FLsetVal_i	400, i1
		FLgroupEnd

FLcolor	 200,255,255

itab2width	=	480	
itab2height	=	300
itab2x		=	10
itab2y		=	40
		FLgroup	"Tab 2: Amplitude", itab2width, itab2height, itab2x, itab2y
gkamp,i2	FLknob	"Amplitude", 0, 0.1, 0, 2, -1, 70, 70, 130, 20
		FLsetVal_i	0.03, i2
		FLgroupEnd

FLcolor	255,255, 200

itab3width	=	480	
itab3height	=	300
itab3x		=	10
itab3y		=	40
		FLgroup	"Tab 3: Pan", itab3width, itab3height, itab3x, itab3y
gkpan,i3	FLknob	"Pan position", 0, 1, 0, 3, -1, 70, 70, 130, 20
		FLsetVal_i	.5, i3
		FLgroupEnd

		FLtabsEnd

FLcolor	190,190, 190

;TEXT BOXES											TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 FLbox  	"Using FLtabs (and FLgroup) we can layer sub-panels of FLTK", 	1,      5,     14,    500,    20,     0, 350
ih		 FLbox  	"widgets and better organize large numbers of controls.    ", 	1,      5,     14,    500,    20,     0, 370

		FLpanelEnd
		FLrun		;RUN THE WIDGET THREAD

gisine	ftgen 0, 0, 65536, 10, 1		;FUNCTION TABLE THAT DEFINES A SINGLE CYCLE OF A SINE WAVE

instr 1
	kporttime	linseg	0,0.001,0.005,1,0.005	;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A SET VALUE
	kfreq		portk	gkfreq, kporttime	;SMOOTH SLIDER VARIABLE
	kamp		portk	gkamp, kporttime	;SMOOTH SLIDER VARIABLE
	kpan		portk	gkpan, kporttime	;SMOOTH SLIDER VARIABLE
	afreq		interp	kfreq		;INTERPOLATE AND CREATE AN AUDIO RATE VERSION OF K-RATE VARIABLE
	aamp		interp	kamp		;INTERPOLATE AND CREATE AN AUDIO RATE VERSION OF K-RATE VARIABLE
	apan		interp	kpan		;INTERPOLATE AND CREATE AN AUDIO RATE VERSION OF K-RATE VARIABLE
	asig		oscil	aamp, afreq, gisine	;SINE WAVE OSCILLATOR
	aL, aR		pan2	asig, apan		;PAN MONO SIGNAL - CREATE STEREO OUTPUT
			outs	aL, aR			;SEND AUDIO TO OUTPUTS
endin	

</CsInstruments>

<CsScore>
f 1 0 1024 10 1		;FUNCTION TABLE THAT DEFINES A SINGLE CYCLE OF A SINE WAVE
i 1 0 3600		;INSTRUMENT 1 WILL PLAY A NOTE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>