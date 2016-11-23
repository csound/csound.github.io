; hsboscil.csd
; Written by Iain McCurdy, 2009, updated 2012, 2015

<CsoundSynthesizer>

<CsOptions>
;COMMENT/UNCOMMENT AS REQUIRED
;-odevaudio				; NO MIDI
;-odevaudio -M0				; EXTERNAL MIDI
-odevaudio -M0 -+rtmidi=virtual -dm0	; VIRTUAL MIDI KEYBOARD
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	4	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;					LABEL      | WIDTH | HEIGHT | X | Y
				FLpanel	"hsboscil",   500,    465,    0,  0
;TEXT BOXES							TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"", 				7,      1,     14,    490,    118,    5,  340
FLsetColor	150,255,200,ih
ih		 	FLbox  	"Waveform partial strengths", 	7,      1,     14,     90,    118,    5,  340
FLsetColor	150,255,200,ih

iinsno	nstrnum	"UpdateWaveform"	;DERIVE INSTRUMENT NUMBER OF NAMED INSTRUMENT (NEEDED FOR INSTRUMENT TRIGGERING BY FLbutton
;SWITCHES  	                                  				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkUpdateWfnOnOff,ih			FLbutton	"Update",		1,    0,    22,     80,     20,   10, 350,   0,   iinsno,     0,      -1
FLsetColor2	255, 255, 50, ih	;SET SECONDARY COLOUR TO YELLOW
FLsetVal_i	1,ih	;BUTTON INITIALLY ON

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
idShepFreq			FLvalue	"",        70,    17,   210,  54
idamp				FLvalue	"",        80,    20,     5, 105
idtone				FLvalue	"",        80,    20,     5, 155
idbrite				FLvalue	"",        80,    20,     5, 205
idbasfreq			FLvalue	"",        80,    20,     5, 255
idphs				FLvalue	"",        80,    20,   135, 305

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gkoctcnt, ihoctcnt		FLcount  "Blending Range (octaves)", 	2,    10,     1,      1,      2,    120,     25,    0, 280,   -1

;SLIDERS					            			MIN | MAX | EXP | TYPE |   DISP   | WIDTH | HEIGHT | X | Y
gkShepFreq,ihShepFreq		FLslider 	"Rate (Hz):",			-50,    50,  0,    23,   idShepFreq,  150,     15,  130,  40
gkamp,ihamp			FLslider 	"Amplitude",			0.0001,  1, -1,    23,       idamp,   490,     25,    5,  80
gktone,gihtone			FLslider 	"Tone",				0,       1,  0,    23,      idtone,   490,     25,    5, 130
gkbrite,gihbrite		FLslider 	"Brightness (CC#1)",		-7,      7,  0,    23,     idbrite,   490,     25,    5, 180
gkbasfreq,gihbasfreq		FLslider 	"Base Frequency (i-rate)",	20,  20000, -1,    23,    idbasfreq,  490,     25,    5, 230
gkphs,ihphs			FLslider 	"Initial Phase (i-rate)",	-1,      1,  0,    23,        idphs,  350,     25,  135, 280

FLsetAlign	8, ihShepFreq	;ALIGN LABEL BOTTOM LEFT

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      1,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

FLcolor2	255, 255, 50	;SET SECONDARY COLOUR TO YELLOW
;BUTTON BANKS			 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkinput, ihinput	FLbutBank	2,      1,      3,     30,     60,    0,  0,    -1;0,      2,      0,      0.01
gkwindow, ihwindow	FLbutBank	2,      1,      4,     30,     60,  350,  0,    -1;0,      2,      0,      0.01

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      4,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"MIDI/(Off)    ", 	1,       5,    12,    100,      20,   30,   0
ih		 	FLbox  	"No MIDI       ", 	1,       5,    12,    100,      20,   30,  20
ih		 	FLbox  	"Shepard Gliss.", 	1,       5,    12,    100,      20,   30,  40
ih		 	FLbox  	"Window:", 		1,       5,    12,     50,      15,  300,   0
ih		 	FLbox  	"Hanning     ", 	1,       5,    12,     87,      15,  380,   0
ih		 	FLbox  	"Triangle    ", 	1,       5,    12,     87,      15,  380,  15
ih		 	FLbox  	"Gaussian    ", 	1,       5,    12,     87,      15,  380,  30
ih		 	FLbox  	"GEN16 curve:", 	1,       5,    12,     87,      15,  380,  45

;VALUE INPUT BOXES				 	MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X  | Y
gkcurve, ihcurve		FLtext		"",	-20, 100,     1,    1,     30,      17,   467,  45

#define SLIDER(N)
#
gk$N, ih$N		FLslider	"$N",    			0,       1,   0,   24,      -1,   15,    90,    ix, 350
ix = ix +20
FLsetVal_i	1,ih$N
#
ix=107
$SLIDER(1)
$SLIDER(2)
$SLIDER(3)
$SLIDER(4)
$SLIDER(5)
$SLIDER(6)
$SLIDER(7)
$SLIDER(8)
$SLIDER(9)
$SLIDER(10)
$SLIDER(11)
$SLIDER(12)
$SLIDER(13)
$SLIDER(14)
$SLIDER(15)
$SLIDER(16)
$SLIDER(17)
$SLIDER(18)
$SLIDER(19)
FLsetVal_i	0,ih1

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	0.1, 	ihamp
				FLsetVal_i	0, 	gihtone
				FLsetVal_i	0, 	gihbrite
				FLsetVal_i	200, 	gihbasfreq
				FLsetVal_i	0.1, 	ihShepFreq
				FLsetVal_i	3, 	ihoctcnt
				FLsetVal_i	0, 	ihphs
				FLsetVal_i	4, 	ihcurve
			
				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 512, 525, 512, 0
				FLscroll     512, 525, 0, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                         hsboscil                            ", 	1,      5,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"hsboscil generates a tone composed of partials derived from  ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"a stack of octaves.                                          ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"Partials above and below the fundemental can be generated.   ", 	1,      5,     14,    490,    20,     5,  80 
ih		 	FLbox  	"The strengths of these partials are enveloped spectrally     ", 	1,      5,     14,    490,    20,     5, 100 
ih		 	FLbox  	"according to a user defined window function and the value for", 	1,      5,     14,    490,    20,     5, 120 
ih		 	FLbox  	"'Blending Range'. If 'Blending Range' is 2 (the minimum      ", 	1,      5,     14,    490,    20,     5, 140 
ih		 	FLbox  	"allowed value) and 'Base Frequency' is 200 hz then partials  ", 	1,      5,     14,    490,    20,     5, 160 
ih		 	FLbox  	"are created at 200 and 100 hz, if 'Blending Range' is 3 then ", 	1,      5,     14,    490,    20,     5, 180 
ih		 	FLbox  	"partials are created 200, 100 and 400 hz. This pattern of    ", 	1,      5,     14,    490,    20,     5, 200 
ih		 	FLbox  	"partial addition continues as 'Blending Range' increases.    ", 	1,      5,     14,    490,    20,     5, 220 
ih		 	FLbox  	"Four window options are provided in this example. 'Hanning'  ", 	1,      5,     14,    490,    20,     5, 240 
ih		 	FLbox  	"provides probably the smoothest crossfades. 'Gaussian'       ", 	1,      5,     14,    490,    20,     5, 260 
ih		 	FLbox  	"provides a sharper envelope with more partial selectively.   ", 	1,      5,     14,    490,    20,     5, 280 
ih		 	FLbox  	"The 'GEN16' allows the user to modify the shape of the window", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"(see GEN16 example) using the curve parameter. 0 will provide", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"a triangle window, positive values will result in an         ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"increasingly broad (inclusive) window, negative values in an ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"incresingly narrow window. NB. as the window is narrowed     ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"amplitude may increase, necessitating a reduction of the GUI ", 	1,      5,     14,    490,    20,     5, 400 
ih		 	FLbox  	"control on account of the action of the amplitude balancing  ", 	1,      5,     14,    490,    20,     5, 420 
ih		 	FLbox  	"algorithm contained within hsboscil.                         ", 	1,      5,     14,    490,    20,     5, 440 
ih		 	FLbox  	"'Brightness' (gkbrite) shifts the partial architecture and   ", 	1,      5,     14,    490,    20,     5, 460 
ih		 	FLbox  	"the window up and down the spectrum.                         ", 	1,      5,     14,    490,    20,     5, 480 
ih		 	FLbox  	"'Tone' shifts the frequencies of the partials up or down in  ", 	1,      5,     14,    490,    20,     5, 500 
ih		 	FLbox  	"parallel whilst the window remains fixed. If 'Tone' is       ", 	1,      5,     14,    490,    20,     5, 520 
ih		 	FLbox  	"modulated such that partials disappear beyond the edge of the", 	1,      5,     14,    490,    20,     5, 540 
ih		 	FLbox  	"spectral window they are replaced by new partials at the     ", 	1,      5,     14,    490,    20,     5, 560 
ih		 	FLbox  	"opposite edge of the window.                                 ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"It is this behaviour that allows us to create the Shepard    ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"glissando effect in which a tone appears to simultaneously   ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"be constantly rising (or falling) but never actually get any ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"higher (lower) in pitch. A visual analogue is that of the    ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"spinning barber-pole.                                        ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"hsboscil's octave spaced partials tends to produce organ-like", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"tones.                                                       ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"The waveform employed by the oscillators within hsboscil is  ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"normally a sine wave but any other waveform could be used.   ", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"To allow the user to experiment with this aspect, GUI is     ", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"provided to allow the use to modify the partial strengths of ", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"a GEN10 generated waveform used by hsboscil.                 ", 	1,      5,     14,    490,    20,     5, 820
ih		 	FLbox  	"This example offers three methods of activating hsboscil.    ", 	1,      5,     14,    490,    20,     5, 840
ih		 	FLbox  	"Firstly, via MIDI (in which case 'Base Frequency' is         ", 	1,      5,     14,    490,    20,     5, 860
ih		 	FLbox  	"determined by the MIDI note number with the 'Base Frequency' ", 	1,      5,     14,    490,    20,     5, 880
ih		 	FLbox  	"slider becoming inoperative). Secondly, without MIDI (slider ", 	1,      5,     14,    490,    20,     5, 900
ih		 	FLbox  	"becomes operative again) and thirdly, a method which produces", 	1,      5,     14,    490,    20,     5, 920
ih		 	FLbox  	"the Shepard glissando effect by modulating the 'Tone'        ", 	1,      5,     14,    490,    20,     5, 940
ih		 	FLbox  	"control using an LFO.                                        ", 	1,      5,     14,    490,    20,     5, 960
ih		 	FLbox  	"In the original Roger Shepard experiment the tones moved     ", 	1,      5,     14,    490,    20,     5, 980
ih		 	FLbox  	"stepwise. Jean-Claude Risset introduced the idea of the      ", 	1,      5,     14,    490,    20,     5,1000
ih		 	FLbox  	"tone moving smoothly leading to the name Shepard Glissando or", 	1,      5,     14,    490,    20,     5,1020
ih		 	FLbox  	"Shepard-Risset Glissando.                                    ", 	1,      5,     14,    490,    20,     5,1040
ih		 	FLbox  	"In MIDI mode the modulation wheel can be used to control     ", 	1,      5,     14,    490,    20,     5,1060
ih		 	FLbox  	"'Brightness'                                                 ", 	1,      5,     14,    490,    20,     5,1080
ih		 	FLbox  	"This opcode was written by Peter Neubacker who is also the   ", 	1,      5,     14,    490,    20,     5,1100
ih		 	FLbox  	"author of the Melodyne software.                             ", 	1,      5,     14,    490,    20,     5,1120
				FLscroll_end
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

giwfn	ftgen	1, 0, 131072, 10, 1				; WAVEFORM USED BY THE HSBOSCIL OSCILLATOR
gioctfn1	ftgen	2, 0, 1024, -19, 1, 0.5, 270, 0.5	; A HANNING-TYPE WINDOW
gioctfn2	ftgen	3, 0, 1024, -7, 0, 512, 1, 512, 0	; A TRIANGLE WINDOW
gioctfn3	ftgen	4, 0, 1024, -20, 6, 1, 1		; GAUSSIAN
icurve		=	4
gioctfn4	ftgen	5,0,1024,-16,0,512,-icurve,1,512,icurve,0		; GEN16
	


instr	1	;MIDI ACTIVATED HSBOSCIL INSTRUMENT
        ;MIDI INPUT============================================================================================================================================================
        ;OUTPUT                 OPCODE          CHANNEL | CC.NUMBER | MIN | MAX
        kbrite                  ctrl7           1,            1,       0,    1
        ktrig                   changed         kbrite  ;IF THE VARIABLE 'kptr' CHANGES FROM ITS PREVIOUS VALUE,
                                                        ;I.E. IF THE MIDI SLIDER IS MOVED THEN THE VARIABLE ktrig WILL ASSUME THE VALUE '1', OTHERWISE IT WILL BE ZERO.
        kbrite          	scale           kbrite, 7, -7      ;VARIBALE HAS TO BE RESCALED HERE, DOING IT IN THE ctrl7 LINE UPSETS THE WORKING OF THE changed OPCODE ABOVE
;                       OPCODE      |   TRIGGER | VALUE | HANDLE
                                FLsetVal        ktrig,   kbrite,  gihbrite
        ;======================================================================================================================================================================
	iporttime	=	0.1				;PORTAMENTO TIME (CONSTANT) 
	kporttime	linseg	0,0.001,iporttime,1,iporttime	;PORTAMENTO TIME (AN ENVELOPE FUNCTION THAT RAMPS UP FROM ZERO) 
	kamp		portk		gkamp, kporttime	;APPLY PORTAMENTO
	kbrite		portk		gkbrite, kporttime      ;APPLY PORTAMENTO
	ktone		portk		gktone, kporttime	;APPLY PORTAMENTO
	ibasfreq	cpsmidi					;READ MIDI NOTE VALUES (IN HERTZ/CPS) FROM MIDI INPUT
	FLsetVal_i	ibasfreq, gihbasfreq			;SEND MIDI NOTE VALUES TO 'BASE FREQUENCY' SLIDER
	kSwitch	changed	gkoctcnt, gkphs, gkwindow, gkcurve	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then
		reinit	START
	endif
	START:
	ioctfn		=		gioctfn1 + i(gkwindow)
		ares 		hsboscil	kamp, ktone, kbrite, ibasfreq, giwfn, ioctfn, i(gkoctcnt), i(gkphs)	;CREATE AN hsboscil TONE
	rireturn
	aenv	linsegr		0,0.01,1,3600,1,0.01,0	;CREATE A BASIC ENVELOPE TO PREVENT CLICKS AT THE START AND ENDS OF NOTES
	outs	ares*aenv, ares*aenv	;SEND AUDIO TO OUTPUTS, APPLY ENVELOPE
endin
	
instr	2	;INTERROGATE VALUE OF BUTTON BANK. THIS INSTRUMENT IS ALSO INSTIGATED BY THE BUTTON BANK
	ktrig	changed	gkinput
	if ktrig==1 then
	 reinit	UPDATE
	endif
	UPDATE:
	if	i(gkinput)	=1	then	;IF 'NO MIDI' INPUT MODE IS SELECTED...
		turnon 3	;...TURNON INSTRUMENT 4
	elseif	i(gkinput)	=2	then	;IF 'SHEPARD GLISSANDO' INPUT MODE IS SELECTED...
		turnon 4	;...TURNON INSTRUMENT 5
	endif

	; BUILD GEN16 WINDOW
	if changed(gkcurve)==1 then
	 reinit REBUILD_GEN16
	endif
	REBUILD_GEN16:
	gioctfn4	ftgen	5,0,1024,-16,0,512,-i(gkcurve),1,512,i(gkcurve),0		; GEN16

endin	
	

instr	3	;FLTK ONLY HSBOSCIL INSTRUMENT - SLIDER CONTROLS BASE FREQUENCY
	if	gkinput!=1	then	;IF SWITCH BANK IS *NOT* 1 THEN...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	iporttime	=	0.1				;PORTAMENTO TIME (CONSTANT)                                    
	kporttime	linseg	0,0.001,iporttime,1,iporttime   ;PORTAMENTO TIME (AN ENVELOPE FUNCTION THAT RAMPS UP FROM ZERO)
	kamp		portk		gkamp, kporttime	;APPLY PORTAMENTO
	kbrite		portk		gkbrite, kporttime      ;APPLY PORTAMENTO
	ktone		portk		gktone, kporttime       ;APPLY PORTAMENTO
	aenv		linsegr		0,0.001,1,3600,1,0.01,0	;CREATE A BASIC ENVELOPE TO PREVENT CLICKS AT THE START AND ENDS OF NOTES
	kSwitch	changed	gkbasfreq, gkoctcnt, gkphs, gkwindow, gkcurve	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then
		reinit	START
	endif
	START:
	ioctfn		=		gioctfn1 + i(gkwindow)
	ares 		hsboscil	kamp, ktone, kbrite, i(gkbasfreq), giwfn, ioctfn, i(gkoctcnt), i(gkphs)	;CREATE AN hsboscil TONE
	rireturn		
		outs	ares*aenv, ares*aenv	;SEND AUDIO TO OUTPUTS, APPLY ENVELOPE
endin

instr	4	;HSBOSCIL INSTRUMENT - SHEPARD GLISSANDO 
	if	gkinput!=2	then	;IF SWITCH BANK IS *NOT* 2 THEN...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING
	iporttime	=	0.1				;PORTAMENTO TIME (CONSTANT)                                    
	kporttime	linseg	0,0.001,iporttime,1,iporttime   ;PORTAMENTO TIME (AN ENVELOPE FUNCTION THAT RAMPS UP FROM ZERO)
	kamp		portk		gkamp, kporttime	;APPLY PORTAMENTO                                              
	kbrite		portk		gkbrite, kporttime      ;APPLY PORTAMENTO                                              
	ktone		phasor		gkShepFreq              ;CREATE A MOVING PHASE VALUE THAT WILL BE USED TO MODULATE 'TONE' PARAMETER                                              
	ktrigger	metro	50				;CREATE A METRONIC PULSE OF '1' VALUES. 50 PER SECOND
	FLsetVal	ktrigger, ktone, gihtone		;UPDATE 'TONE; SLIDER (THIS WILL BE FOR VISUAL FEEDBACK ONLY)
	aenv		linsegr		0,0.001,1,3600,1,0.01,0	;CREATE A BASIC ENVELOPE TO PREVENT CLICKS AT THE START AND ENDS OF NOTES
	kSwitch	changed	gkbasfreq, gkoctcnt, gkphs, gkwindow, gkcurve	;GENERATE A MOMENTARY '1' PULSE IN OUTPUT 'kSwitch' IF ANY OF THE SCANNED INPUT VARIABLES CHANGE. (OUTPUT 'kSwitch' IS NORMALLY ZERO)
	if	kSwitch=1	then
		reinit	START
	endif
	START:
	ioctfn		=		gioctfn1 + i(gkwindow)
	ares 		hsboscil	kamp, ktone, kbrite, i(gkbasfreq), giwfn, ioctfn, i(gkoctcnt), i(gkphs)	;CREATE AN hsboscil TONE
	rireturn
			outs	ares * aenv, ares * aenv	;SEND AUDIO TO OUTPUTS, APPLY ENVELOPE
endin

instr	UpdateWaveform	;REDIFINE THE OSCILLATOR WAVEFORM WHENEVER A CHANGE IS MADE
	if gkUpdateWfnOnOff==0 then
	 turnoff
	endif
	ktrig	changed	gk1,gk2,gk3,gk4,gk5,gk6,gk7,gk8,gk9,gk10,gk11,gk12,gk13,gk14,gk15,gk16,gk17,gk18,gk19
	if ktrig==1 then
	 reinit	UPDATE_WAVEFORM
	endif
	UPDATE_WAVEFORM:
	giwfn	ftgen 1, 0, 131072, 10, 1-i(gk1),1-i(gk2),1-i(gk3),1-i(gk4),1-i(gk5),1-i(gk6),1-i(gk7),1-i(gk8),1-i(gk9),1-i(gk10),1-i(gk11),1-i(gk12),1-i(gk13),1-i(gk14),1-i(gk15),1-i(gk16),1-i(gk17),1-i(gk18),1-i(gk19)
	rireturn
endin

</CsInstruments>

<CsScore>
i 2 0 3600
f 0 3600
</CsScore>

</CsoundSynthesizer>



























