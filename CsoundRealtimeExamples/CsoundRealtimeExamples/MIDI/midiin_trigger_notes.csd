midiin_trigger_notes.csd
Written by Iain McCurdy, 2012

<CsoundSynthesizer>

<CsOptions>
;START REALTIME AUDIO OUT USING THE DEFAULT DEVICE, OPEN ALL AVAILABLE MIDI INPUT DEVICES AND DISABLE DISPLAYS
;-odac -Ma -dm0

;VIRTUAL MIDI
-odac -M0 -+rtmidi=virtual -dm0
</CsOptions>

<CsInstruments>

sr	=	44100
ksmps 	= 	32
nchnls	=	1
0dbfs	=	1
massign 0, 0	;USING MASSIGN WITH THESE ARGUMENTS DISABLES CSOUND'S DEFAULT INSTRUMENT TRIGGERING

;FLTK INTERFACE CODE==============================================================================================================================================================
FLcolor	255,255,255,255,255,50
;INSTRUCTIONS AND INFO PANEL                                     WIDTH | HEIGHT | X | Y
				FLpanel	"midiin - Trigger Notes", 515,    600,    0,  0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                   midiin - Trigger Notes                    ", 	1,      6,     14,    490,    25,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"Csound's default mechanism for triggering instruments from   ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"MIDI can be diabled using the line: 'massign 0,0' in the     ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"orchestra header. Notes can still be started and stopped from", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"MIDI using the midiin opcode and some 'if','else'... queries.", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"It can be useful to use this method instead of the default   ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"system to implement more complex MIDI interactions.          ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"One issue that should be borne in mind is that some MIDI     ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"keyboards describe note offs using the note off status byte  ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"(128) whereas others merely define them as note ons with zero" , 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"velocity. MIDI receiving hardware and software should        ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"normally be prepared to understand both of these - in        ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"designing our own mechanism we should allow it to be         ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"compatible with both these systems to so that it will        ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"function correctly with a variety of hardware.               ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"In order to be able to distinguish notes within a chord so   ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"that the correct note is turned off when a particular note is", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"released, fractional note numbers are used. The note number  ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"divided by 1000 will be added to the note number of the      ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"instrument that will be triggered. For example instrument 2  ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"playing note number 60 will be triggered with an instrument  ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"number (p1) of (2 + (60/1000))    =    2.06                  ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"In this example the code used to implement note triggering   ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"in designed within a UDO to facilitate easy transplantation  ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"into other Csound projects.                                  ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"This UDO can also trigger notes on a specific MIDI channel by", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"sending the UDO the number of the MIDI channel required.     ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"Alternatively it can be instructed to respond to notes on    ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"any channel by setting this value to zero.                   ", 	1,      5,     14,    490,    20,     5, 580
				FLpanel_end
FLrun

opcode	MIDI_trigger_instrument,0,	ii				;INPUT ARGUMENT FOR INSTRUMENT NUMBER OF THE INSTRUMENT TO BE TRIGGERED AND THE MIDI CHANNEL ON WHICH TRIGGERING WILL OCCUR (VALUE OF ZERO HERE MEANS THAT NOTES WILL BE TRIGGERED ON ALL CHANNELS)
	insno,ichan	xin						;READ IN INPUT ARGUMENTS
	kstatus, kchan, kdata1, kdata2  midiin				;READ IN MIDI
	if kchan==ichan||ichan==0 then					;IF A MESSAGE ON THE CORRECT CHANNEL HAS BEEN RECEIVED (OR ON ANY CHANNEL IF CHANNEL WAS DEFINED AS ZERO)
	 if kstatus==144 then						;IF MIDI MESSAGE IS A NOTE...
	  if kdata2>0 then						;IF VELOCITY IS MORE THAN ZERO, I.E. NOT A NOTE OFF
	 	event "i",insno+(kdata1*0.001),0,-1,kdata1,kdata2	;TRIGGER INSTRUMENT WITH A HELD NOTE. NOTE NUMBER TRANSMITTED AS p4, VELOCITY AS p5
	  else								;OTHERWISE (I.E. MUST BE A NOTE OFF / ZERO VELOCITY)
	   turnoff2	insno+(kdata1*0.001),4,1			;TURN OFF INSTRUMENT WITH THIS SPECIFIC FRACTIONAL NOTE NUMBER
	  endif								;END OF CONDITIONAL BRANCH
	 elseif kstatus==128 then					;IF MESSAGE USES A 'NOTE OFF' STATUS BYTE (128)
	  turnoff2	insno+(kdata1*0.001),4,1			;TURN OFF INSTRUMENT WITH THIS SPECIFIC FRACTIONAL NOTE NUMBER
	 endif								;END OF CONDITIONAL BRANCH
	endif								;END OF CONDITIONAL BRANCH
endop

instr 	1	;INSTRUMENT THAT SCANS MIDI AND STARTS AND STOPS NOTES
	insno	=	2					;INSTRUMENT NUMBER OF INSTRUMENT TO BE TRIGGERED
	MIDI_trigger_instrument	insno,0				;CALL UDO FOR STARTING AND STOPPING NOTE VIA MIDI
endin

instr	2	;SIMPLE SYNTH TO VERIFY NOTE TRIGGERING
	asig	vco2	p5/127,cpsmidinn(p4),4,0.5
	aenv	linsegr	0,0.01,1,0.01,0
		out	(asig*aenv)/5
endin

</CsInstruments>

<CsScore>
i 1 0 3600; run midi scanning for 1 hour
</CsScore>

</CsoundSynthesizer>