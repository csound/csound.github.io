;Written by Iain McCurdy, 2006

;DEMONSTRATION OF THE wgclar OPCODE. THIS IS A PHYSICALLY MODELLED CLARINET - SOUNDS MORE LIKE PAN PIPES AT TIMES... YUCK!
;	- THE ALGORITHM USED IS SIMILAR TO THAT USED BY THE wgflute OPCODE

;kamp - AMPLITUDE

;kfreq - THE FUNDEMENTAL OF THE TONE PRODUCED

;kstiff - THE STIFFNESS OF THE REED - BUT I CAN'T GET IT TO DO ANYTHING! CAN YOU PROVE ME WRONG?

;iatt/idek - ATTACK AND DECAY TIMES.
;	NOTE THAT THESE CONTROLS WILL IMPLEMENT AN ATTACK AND DECAY CHARACTERISTIC THAT IS MORE ELABORATE 
;	-THAN JUST AN AMPLITUDE ENVELOPE STYLE ATTACK AND DECAY
;	IN ORDER FOR THE DECAY TIME PARAMETER TO WORK PROPERLY NOTE DURATION MUST BE EXTENDED.
;	IN A MIDI SITUATION THIS COULD BE DONE USING linenr, linsegr OR expsegr.

;kngain - AMPLITUDE OF BREATH/WIND NOISE. THE FLUTE SOUND CONSISTS OF 2 MAIN ELEMENTS:
;	THE RESONANT TONE AND THE BREATH NOISE. 
;	THIS PARAMETER CONTROLS THE STRENGTH OF THE BREATH/WIND NOISE.
;	A USEFUL RANGE FOR THIS IS ABOUT 0-1
;	0=NO BREATH NOISE, 1=BREATH NOISE ONLY

;kvibf/kvibamp - THIS OPCODE IMPLEMENTS VIBRATO THAT GOES BEYOND JUST FREQUENCY MODULATION AND INCLUDES MODULATION 
;	-UPON SEVERAL OTHER ASPECTS OF THE SOUND INCLUDING AMPLITUDE MODULATION
;	A USEFUL RANGE FOR kvibamp (AMPLITUDE OF VIBRATO) IS 0-.25 WHERE 0=NO VIBRATO AND .25=A LOT OF VIBRATO
;	kvibf IS USED TO CONTROL VIBRATO FREQUENCY, A NATURAL VIBRATO FREQUENCY IS ABOUT 5 HZ

;ifn - A FUNCTION TABLE WAVEFORM MUST BE GIVEN TO DEFINE THE SHAPE OF THE VIBRATO, 
;	-THIS SHOULD NORMALLY BE A SINE WAVE.

;THE OPCODE OFFERS 3 FURTHER *OPTIONAL* PARAMETERS:

;iminfreq - A MINIMUM FREQUENCY SETTING GIVEN TO THE ALGORITHM
;	- TYPICALLY THIS IS SET TO A VALUE BELOW THE FREQUENCY SETTING GIVEN BY kfreq
;	- IF kfreq GOES BELOW iminfreq IS CAN HAVE A STRANGE EFFECT ON THE SOUND AND THE SETTING FOR kfreq NO LONGER 
;	-REFLECTS THE PITCH THAT IS ACTUALLY HEARD.


<CsoundSynthesizer>

<CsOptions>
-odevaudio -M0 -b400 -+rtmidi=virtual
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	100	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1	;MAXIMUM AMPLITUDE = 1, REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL   | WIDTH | HEIGHT | X | Y
		FLpanel	"wgclar",  500,    500,    0,  0

;BUTTONS                              			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkOnOff,ihOnOff	FLbutton	"Blow / Off (MIDI)",	1,    0,    22,    150,     25,    5,  5,    0,      2,      0,      -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;VALUE DISPLAY BOXES	LABEL  | WIDTH | HEIGHT | X |  Y
idamp		FLvalue	" ",      100,     18,    5,   75
idfreq		FLvalue	" ",      100,     18,    5,  125
idstiff		FLvalue	" ",      100,     18,    5,  175
idngain		FLvalue	" ",      100,     18,    5,  225
idatt		FLvalue	" ",      100,     18,    5,  275
iddetk		FLvalue	" ",      100,     18,    5,  325
idvibf		FLvalue	" ",      100,     18,    5,  375
idvibamp	FLvalue	" ",      100,     18,    5,  425
idminfreq	FLvalue	" ",      100,     18,    5,  475

;SLIDERS				            						MIN |   MAX  | EXP | TYPE |  DISP    | WIDTH | HEIGHT | X  | Y
gkamp, ihamp			FLslider	"Amplitude",					0,       1,     0,    23,   idamp,      490,     25,    5,   50
gkfreq, ihfreq			FLslider	"Frequency",					20,   20000,   -1,    23,   idfreq,     490,     25,    5,  100
gkstiff, ihstiff		FLslider	"Reed Stiffness",				-.44,  -.18,    0,    23,   idstiff,    490,     25,    5,  150
gkngain, ihngain		FLslider	"Noise Gain",					0,        5,    0,    23,   idngain,    490,     25,    5,  200
gkatt, ihatt			FLslider	"Attack Time (i-rate in seconds)",		0,     	  1,    0,    23,   idatt,      490,     25,    5,  250
gkdetk,ihdetk			FLslider 	"Decay Time (i-rate in seconds)",  		0,        1,    0,    23,   iddetk,     490,     25,    5,  300
gkvibf,ihvibf			FLslider 	"Vibrato Frequency",  				0,       30,    0,    23,   idvibf,     490,     25,    5,  350
gkvibamp,ihvibamp		FLslider 	"Vibrato Amplitude",  				0,       .3,    0,    23,   idvibamp,   490,     25,    5,  400
gkminfreq,ihminfreq		FLslider 	"Minimum Frequency (i-rate)",			20,   20000,   -1,    23,   idminfreq,  490,     25,    5,  450

;SET INITIAL VALUES FOR SLIDERS |VALUE |HANDLE
		FLsetVal_i	0.3, 	ihamp
		FLsetVal_i	750, 	ihfreq
		FLsetVal_i	.3, 	ihstiff
		FLsetVal_i	.1, 	ihngain
		FLsetVal_i	.03, 	ihatt
		FLsetVal_i	.03, 	ihdetk
		FLsetVal_i	.1, 	ihngain
		FLsetVal_i	5, 	ihvibf
		FLsetVal_i	.1, 	ihvibamp
		FLsetVal_i	20, 	ihminfreq
		FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 420, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          wgclar                             ", 	1,      5,     14,    490,     20,    5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,     20,    5,  20
ih		 	FLbox  	"wgclar is a wave guide physical model of a clarinet based on ", 	1,      5,     14,    490,     20,    5,  40
ih		 	FLbox  	"work by Perry Cook but re-coded for Csound by John ffitch.   ", 	1,      5,     14,    490,     20,    5,  60
ih		 	FLbox  	"Attack time is the time taken to reach full blowing pressure.", 	1,      5,     14,    490,     20,    5,  80
ih		 	FLbox  	"The author suggests that 0.1 corresponds to normal playing.  ", 	1,      5,     14,    490,     20,    5, 100
ih		 	FLbox  	"Decay time is the time taken for the system to stop producing", 	1,      5,     14,    490,     20,    5, 120
ih		 	FLbox  	"sound after blowing has stopped. The author suggests that 0.1", 	1,      5,     14,    490,     20,    5, 140
ih		 	FLbox  	"produces a smooth natural sounding end to a note.            ", 	1,      5,     14,    490,     20,    5, 160
ih		 	FLbox  	"Values for reed stiffness should be negative. The useful     ", 	1,      5,     14,    490,     20,    5, 160
ih		 	FLbox  	"range is approximately -0.44 to -0.18. The author suggests a ", 	1,      5,     14,    490,     20,    5, 180
ih		 	FLbox  	"value of -0.3 as representing normal reed stiffness.         ", 	1,      5,     14,    490,     20,    5, 200
ih		 	FLbox  	"Noise gain controls the amount of simulated wind noise in the", 	1,      5,     14,    490,     20,    5, 220
ih		 	FLbox  	"composite tone produced. The suggested range is 0 to 0.5.    ", 	1,      5,     14,    490,     20,    5, 240
ih		 	FLbox  	"Vibrato is implemented within the opcode and does not need to", 	1,      5,     14,    490,     20,    5, 260
ih		 	FLbox  	"be applied separately to the frequency parameter. Natural    ", 	1,      5,     14,    490,     20,    5, 280
ih		 	FLbox  	"vibrato occurs at about 5 hertz.                             ", 	1,      5,     14,    490,     20,    5, 300
ih		 	FLbox  	"Minimum frequency (optional) defines the lowest frequency at ", 	1,      5,     14,    490,     20,    5, 320
ih		 	FLbox  	"which the model will play.                                   ", 	1,      5,     14,    490,     20,    5, 340
ih		 	FLbox  	"This example can also be triggered via MIDI. MIDI note       ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"number, velocity and pitch bend are interpreted              ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"appropriately.                                               ", 	1,      5,     14,    490,    15,     5, 400

		FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1	;MIDI ACTIVATED INSTRUMENT
	if	gkOnOff=1	then ; SENSE FLTK ON/OFF SWITCH
			turnoff	;TURNOFF THIS INSTRUMENT IMMEDIATELY
	endif
	ioct	octmidi		;READ NOTE VALUES FROM MIDI INPUT IN THE 'OCT' FORMAT
	iamp	ampmidi	1	;AMPLITUDE IS READ FROM INCOMING MIDI NOTE
	;kpres	aftouch	1, 5		;AFTERTOUCH CONTROL OF BOW PRESSURE
	;kpres	ctrl7	1, 1, 1, 5	;MOD. WHEEL CONTROL OF BOW PRESSURE
	;kpres	=	gkpres
	;PITCH BEND INFORMATION IS READ
	iSemitoneBendRange = 2		;PITCH BEND RANGE IN SEMITONES (WILL BE DEFINED FURTHER LATER) - SUGGESTION - THIS COULD BE CONTROLLED BY AN FLTK COUNTER
	imin = 0			;EQUILIBRIUM POSITION
	imax = iSemitoneBendRange * .0833333	;MAX PITCH DISPLACEMENT (IN oct FORMAT)
	kbend	pchbend	imin, imax	;PITCH BEND VARIABLE (IN oct FORMAT)
	kfreq	=	cpsoct(ioct+ kbend)
	aenv		linsegr	1,3600,1,i(gkdetk),0	;THIS ENVELOPE, ALTHOUGH NOT USED AS A CONTROL SIGNAL FOR ANYTHING, SERVES TO KEEP THE INSTRUMENT RUNNING AFTER A NOTE OF HAS BEEN RECEIVED TO FACILITATE THE DECCAY TIME FOR wgclar
	ifn		=	1	;WAVEFORM FUNCTION TABLE FOR THE SHAPE OF THE VIBRATO - SHOULD NORMALLY JUST BE A SINE WAVE OR SOMETHING SIMILAR
	kSwitch		changed		gkminfreq, gkatt, gkdetk
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	UPDATE			;BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE'
	endif
	UPDATE:
	;AN AUDIO SIGNAL IS CREATED USING THE wgclar OPCODE. NOTE THAT I-RATE VARIABLES MUST BE CONVERTED FROM K-RATE TO I-RATE SLIDERS
	aclarinet 	wgclar	gkamp*iamp, kfreq, gkstiff, i(gkatt), i(gkdetk), gkngain,gkvibf, gkvibamp, ifn, i(gkminfreq)
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
	outs 	aclarinet * aenv, aclarinet * aenv
endin

instr	2	;FLTK TRIGGERED INSTRUMENT
	if	gkOnOff=0	then	;IF On/Off SWITCH IS SET TO 'OFF'...
		turnoff			;TURN THIS INSTRUMENT OFF
	endif				;END OF CONDITIONAL BRANCHING

	kSwitch		changed		gkminfreq, gkatt, gkdetk
	if	kSwitch=1	then		;IF I-RATE VARIABLE CHANGE TRIGGER IS '1'...
		reinit	UPDATE			;BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE'
	endif
	UPDATE:
	aenv		linsegr	1,3600,1,i(gkdetk),0	;THIS ENVELOPE, ALTHOUGH NOT USED AS A CONTROL SIGNAL FOR ANYTHING, SERVES TO KEEP THE INSTRUMENT RUNNING AFTER A NOTE OF HAS BEEN RECEIVED TO FACILITATE THE DECCAY TIME FOR wgclar
	ifn		=	1	;WAVEFORM FUNCTION TABLE FOR THE SHAPE OF THE VIBRATO - SHOULD NORMALLY JUST BE A SINE WAVE OR SOMETHING SIMILAR
	;AN AUDIO SIGNAL IS CREATED USING THE wgclar OPCODE. NOTE THAT I-RATE VARIABLES MUST BE CONVERTED FROM K-RATE TO I-RATE SLIDERS
	aclarinet 	wgclar	gkamp, gkfreq, gkstiff, i(gkatt), i(gkdetk), gkngain,gkvibf, gkvibamp, ifn, i(gkminfreq)
	rireturn	;RETURN FROM REINITIALISATION PASS TO PERFORMANCE TIME PASSES
	outs 	aclarinet * aenv, aclarinet * aenv
endin

</CsInstruments>

<CsScore>
f 1 0 131072 10 1	;SINE WAVE (USED FOR VIBRATO)
f 0 3600	;DUMMY SCORE EVENT SUSTAINS REALTIME PERFORMANCE FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>