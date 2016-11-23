;WRITTEN BY IAIN MCCURDY, 2010

<CsoundSynthesizer>

<CsOptions>
-odevaudio -b2048 -B4096
</CsOptions>

<CsInstruments>

sr	= 	44100
ksmps	= 	1
nchnls	= 	2
0dbfs	=	1


;       LABEL     | WIDTH | HEIGHT | X | Y
FLpanel	"FLmouse",   500,    500,    50, 50

;TEXT BOXES										TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih	FLbox  	"                         FLmouse 2                           ", 	1,      5,     14,    490,    15,     5,  0
ih	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih	FLbox  	"This is a practical demonstration of the FLmouse opcode.     ", 	1,      5,     14,    490,    15,     5,  40
ih	FLbox  	"A tone is produced, moving the mouse pointer up the y-axis   ", 	1,      5,     14,    490,    15,     5,  60
ih	FLbox  	"of this FLTK panel increases the amplitude of this tone,     ", 	1,      5,     14,    490,    15,     5,  80
ih	FLbox  	"movement along the x-axis increases frequency. Holding the   ", 	1,      5,     14,    490,    15,     5, 100
ih	FLbox  	"left mouse button introduces a delay effect. Holding the     ", 	1,      5,     14,    490,    15,     5, 120
ih	FLbox  	"right mouse button introduces a reverb effect. Pressing the  ", 	1,      5,     14,    490,    15,     5, 140
ih	FLbox  	"middle mouse button (if available) introduces a vibrato      ", 	1,      5,     14,    490,    15,     5, 160
ih	FLbox  	"effect.                                                      ", 	1,      5,     14,    490,    15,     5, 180
FLpanel_end
FLrun

giwave	ftgen	0,0,1024,10,1,.1,.05,.025,.0125,.00625	;A HARMONIC WAVEFORM WITH SOME OVERTONES

instr	1		;READ CONTROLLERS, SCAN FOR THRESHOLD CROSSING, OUTPUT CONTROLLER VALUES TO DISPLAY
	iporttime	=	0.05				;PORTAMENTO TIME	
	imode	=	2	;MODE 0 (SCREEN DISPLAY NORMALISED 0-1)
				;MODE 1 (RAW SCREEN PIXEL VALUE)
				;MODE 2 (PIXEL VALUE RELATIVE TO FLTK PANEL)
	kx, ky, kb1, kb2, kb3 FLmouse	imode
	koct	=	(kx/250)+7	;DERIVE PITCH, IN OCTAVE FORMAT, FROM MOUSE x-axis LOCATION OVER FLTK PANEL. PITCH VALUES WILL BE WITHIN THE RANGE 7-9
	kvib	lfo	0.1, 5, 1		;VIBRATO FUNCTION
	koct	=	koct + (kvib * kb2)	;VIBRATO WILL BE ADDED TO PITCH (OCT FORMAT) VALUE ONLY IF MOUSE BUTTON 2 HAS BEEN PRESSED
	kcps	=	cpsoct(koct)	;CONVERT OCT FORMAT PITCH VALUE TO CYCLES-PER-SECOND FORMAT
	kcps	port	kcps,iporttime	;APPLY PORTAMENTO SMOOTHING TO PITCH VALUE
	kamp	port	1-(ky/500), iporttime	;DERIVE AMPLITUDE FROM AN INVERTED VERSION OF y_axis MOUSE POSITION
		a1	oscili	kamp*0.2, kcps, giwave	;CREATE AN AUDIO OSCILLATOR
	outs	a1,a1	;SEND AUDIO TO OUTPUTS
	kDelaySendAmount	port	kb1, iporttime	;DERIVE DELAY SEND AMOUNT VARIABLE FROM MOUSE 1 STATUS. APPLY PORTAMENTO
	gaDelaySend	=	a1 * kDelaySendAmount	;CREATE DELAY SEND AUDIO SIGNAL
	kRvbSendAmount	port	kb3, iporttime		;DERIVE DELAY SEND AMOUNT VARIABLE FROM MOUSE 1 STATUS. APPLY PORTAMENTO
	gaRvbSend	=	a1 * kRvbSendAmount     ;CREATE DELAY SEND AUDIO SIGNAL                                         
endin

instr	2	;DELAY
	aBuffer	delayr	1				;ESTABLISH DELAY BUFFER
	aDlySig	deltapi	0.3				;TAP DELAY BUFFER
		delayw	gaDelaySend+(aDlySig*0.3)	;WRITE INTO DELAY BUFFER. INCLUDE A FEEDBACK SIGNAL INTO THE INPUT.
	outs	aDlySig, aDlySig			;SWND AUDIO TO THE OUTPUTS
endin

instr	3	;REVERB
	aL, aR	reverbsc	gaRvbSend, gaRvbSend, 0.9, 10000	;CREATE REVERB SIGNAL USING reverbsc OPCODE
	outs	aL, aR							;SEND AUDIO TO OUTPUTS
endin

</CsInstruments>

<CsScore>
i 1 0 3600	;TONE PRODUCING INSTRUMENT
i 2 0 3600	;DELAY EFFECT
i 3 0 3600	;REVERB EFFECT
</CsScore>

</CsoundSynthesizer>
<MacOptions>
Version: 3
Render: Real
Ask: Yes
Functions: ioObject
Listing: Window
WindowBounds: 72 179 400 200
CurrentView: io
IOViewEdit: On
Options:
</MacOptions>
<MacGUI>
ioView nobackground {65535, 65535, 65535}
ioSlider {5, 5} {20, 100} 0.000000 1.000000 0.000000 slider1
ioSlider {45, 5} {20, 100} 0.000000 1.000000 0.000000 slider2
ioSlider {85, 5} {20, 100} 0.000000 1.000000 0.000000 slider3
ioSlider {125, 5} {20, 100} 0.000000 1.000000 0.000000 slider4
ioSlider {165, 5} {20, 100} 0.000000 1.000000 0.000000 slider5
</MacGUI>

