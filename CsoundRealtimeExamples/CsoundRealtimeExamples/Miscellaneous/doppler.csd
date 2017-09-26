doppler.csd
Written by Iain McCurdy, 2010

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;		LABEL     | WIDTH | HEIGHT | X | Y
	FLpanel	"doppler",   500,     500,   0,  0

;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,    0,    22,    150,     25,    5,  5,    0,      1,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;NUMBER DISPLAY BOXES			WIDTH | HEIGHT | X | Y
idRoomSize		FLvalue	"",	80,      20,     5, 175
idfiltercutoff		FLvalue	"",	80,      20,     5, 225
idspeed			FLvalue	"",	80,      20,     5, 325

;SLIDERS									MIN | MAX | EXP | TYPE |    DISP     | WIDTH | HEIGHT |  X   | Y
gksource, gihsource		FLslider	"Source Position",  		0,      1,   0,     3,  -1,             490,     25,     5,    50
gkmicrophone, ihmicrophone	FLslider	"Microphone",  			0,      1,   0,     3,  -1,             490,     25,     5,   100
gkRoomSize, ihRoomSize		FLslider	"Room Size (metres)",		0.1,  100,  -1,    23,  idRoomSize,     490,     25,     5,   150
gkfiltercutoff, ihfiltercutoff	FLslider	"Filter Cutoff",		1,     20,   0,    23,  idfiltercutoff, 490,     25,     5,   200
gkVCOoct, ihVCOoct		FLslider	"VCO Pitch",    		6,     10,   0,    23,  -1,             240,     25,     5,   250
gksiren, ihsiren		FLslider	"Siren Depth",    		0,      1,   0,    23,  -1,             240,     25,   255,   250
gkspeed, ihspeed		FLslider	"LFO Speed",			0.001, 10,  -1,    23,  idspeed,        490,     25,     5,   300
gkdepth, ihdepth		FLslider	"LFO Depth",			0,    0.5,   0,    23,  -1,             490,     25,     5,   350
gkampscale, ihampscale		FLslider	"Distance:Amplitude Scaling",	0,      1,   0,    23,  -1,             490,     25,     5,   400
gkOutAmp, ihOutAmp		FLslider	"Output Amplitude",		0,      1,   0,    23,  -1,             490,     25,     5,   450

;INITIALISATION OF SLIDERS	VALUE | HANDLE
		FLsetVal_i	0.3, 	gihsource
		FLsetVal_i	0.5, 	ihmicrophone
		FLsetVal_i	40, 	ihRoomSize
		FLsetVal_i	6, 	ihfiltercutoff
		FLsetVal_i	9, 	ihVCOoct
		FLsetVal_i	1, 	ihsiren
		FLsetVal_i	0.08, 	ihspeed
		FLsetVal_i	0.5, 	ihdepth
		FLsetVal_i	0.98, 	ihampscale
		FLsetVal_i	0.5, 	ihOutAmp

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL

				FLpanel	" ", 515, 480, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          doppler                            ", 	1,      5,     14,    490,    20,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"The opcode 'doppler' approximates the pitch shifting effect  ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"that occurs when a sound source moves with respect to a point", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"of reception such as a listener or a microphone. Moving the  ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"microphone with respect to a static sound source will also   ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"induce the doppler effect. The doppler opcode will allow the ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"sound source and microphone locations to be moved at control ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"rate. An internal filter smooths stepping that might occur,  ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"particularly when k-rate is low.                             ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"In this implementation the locations of the sound source and ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"the microphone can be moved manually or the movement of the  ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"sound source can be modulated by an LFO. The scale of the    ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"sliders for 'Source Position' and 'Microphone Position' is   ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"set using the 'Room Size' slider.                            ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"In keeping with the classic scenario used to illustrate the  ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"doppler effect, the source sound in this demonstration is an ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"imitation of a  siren that might be heard on a fire engine.  ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"To facilitate manual modulation of the 'Source Position'     ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"slider, reduce 'LFO Depth' to zero.                          ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"Separate additions in this demonstration is panning that     ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"reflects the source position with respect to the microphone  ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"position and amplitude scaling that induces amplitude        ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"reduction as the source sound becomes more distant.          ", 	1,      5,     14,    490,    20,     5, 460
			FLpanel_end
			FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;AMPLITUDE SCALING CURVE
giampcurve	ftgen	0,0,131072,5,0.01,131072*0.5,1,131072*0.5,0.01

instr	1
	if gkOnOff=0 then	;IF ON/OFF SWITCH IS OFF...
		turnoff		;TURN THIS INSTRUMENT OFF IMMEDIATELY
	endif			;END OF THIS CONDITIONAL BRANCH
	
	;LFO(modulates source position slider)=================
	klfo	lfo	gkdepth, gkspeed, 1	;SINE WAVE
	klfo	=	klfo + 0.5		;OFFSET INTO THE POSITIVE DOMAIN
	;ktrig	changed	klfo			;UPDATING THE SLIDER EVERY K CYCLE MIGHT BE TOO FREQUENT AND MAY CAUSE PERFORMANCE ISSUE IN WHICH CASE USE A SEPARATE TRIGGER AS SHOWN BELOW	
	ktrig	metro	50			;SLIDER UPDATE RATE
	FLsetVal	ktrig, klfo, gihsource	;UPDATE 'Source Position' SLIDER
	;======================================================
	
	kporttime	linseg	0, 0.001, 0.1		;RAMPING UP PORTAMENTO TIME VARIABLE

	;GENERATE A SOURCE SOUND (siren imitation)=============
	ksiren		lfo	1, 1.3, 2	;UNIPOLAR SQUARE WAVE LFO
	ktrig	changed	ksiren			;GENERATE A TRIGGER EACH TIME LFO VALUE CHANGES
	if ktrig=1 then				;IF LFO VALUE HAS JUST CHANGED...
		reinit SWAP_COLOUR		;BEGIN A REINITIALISATION PASS FROM LABEL 'SWAP_COLOUR'
	endif					;END OF THIS CONDITIONAL BRANCH
	SWAP_COLOUR:				;LABEL 'SWAP_COLOUR'
	if i(ksiren)=1 then			;IF SIREN IS 'HIGH'...
		FLsetColor2	0,0,255,gihsource	;SET SLIDER COLOUR TO BLUE
	else						;OTHERWISE...
		FLsetColor2	255,255,255,gihsource	;SET SLIDER COLOUR TO WHITE
	endif						;END OF THIS CONDITIONAL BRANCH
	rireturn					;RETURN FROM REINITIALISATION PASS
	asig		vco2	1, cpsoct(gkVCOoct+ksiren*(gksiren/12))	;GENERATE SIREN AUDIO
	asig		tone	asig, 1200					;LOW PASS FILTER TO SOFTEN THE TONE
	;=======================================================
	
	;DOPPLER================================================
	ispeedofsound   init	340.29				;SPEED OF SOUND DEFINED
	ksource		portk	gksource, kporttime		;SMOOTH SOURCE POSITION MOVEMENT
	kmicrophone	portk	gkmicrophone, kporttime		;SMOOTH MICROPHOPNE POSITION MOVEMENT
	ktrig		changed	gkfiltercutoff			;IF I-RATE VARIABLE SLIDER IS CHANGED GENERATE A '1'
	if ktrig=1 then						;IF TRIGGER IS '1'...
		reinit UPDATE					;BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE' 
	endif							;END OF THIS CONDITIONAL BRANCH
	UPDATE:							;LABEL CALLED 'UPDATE'
	kdisp		limit	ksource-(kmicrophone-0.5), 0, 1	;CALCULATE DISPLACEMENT (DISTANCE) BETWEEN SOURCE AND MICROPHONE AND LIMIT VALUE TO LIE BETWEEN ZERO AND 1
	kamp		table	kdisp, giampcurve,1		;READ AMPLITUDE SCALING VALUE FROM TABLE
	kamp		ntrpol	1, kamp, gkampscale		;CALCULATE AMOUNT OF AMPLITUDE SCALING DESIRED BY THE USER FROM THE ON SCREEN SLIDER
	aout		doppler	asig*kamp, ksource*gkRoomSize, kmicrophone*gkRoomSize, ispeedofsound, i(gkfiltercutoff)	;APPLY DOPPLER EFFECT
	rireturn						;RETURN FROM REINITIALISATION PASS
	kpan		=	(gksource<gkmicrophone?0.9:0.1)	;CALCULATE PAN VALUE ACCORDING TO SOURCE AND MIC POSITION
	kpan		portk	kpan, kporttime			;APPLY PORTAMENTO SMOOTHING TO PAN POSITION VALUE 
			outs	aout*sqrt(kpan)*gkOutAmp, aout*sqrt(1-kpan)*gkOutAmp	;SEND AUDIO TO OUTPUTSM AND APPLY PANNING
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT - PERMITS REAL-TIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>