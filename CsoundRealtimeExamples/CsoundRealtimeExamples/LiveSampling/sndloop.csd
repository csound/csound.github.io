sndloop.csd
Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
;COMMENT/UNCOMMENT AS REQUIRED
;-odac -iadc -dm0 -M0			;EXTERNAL MIDI CONTROL
-odac -iadc -dm0 -M0 -+rtmidi=virtual	;VIRTUAL MIDI CONTROL
;-odac -iadc -dm0			;NO MIDI
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	8	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	1	;NUMBER OF CHANNELS (1=MONO)
0dbfs		=	1	;MAXIMUM AMPLITUDE

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;					LABEL   | WIDTH | HEIGHT | X | Y
				FLpanel	"sndloop",   500,  300,    0,  0

;BUTTONS								ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gktrig,ihtrig		FLbutton	"Rec-Play/Stop",		1,   0,     22,    140,     25,     5,  5,    -1
gkmute,ihmute		FLbutton	"Mute Live Input",		1,   0,     22,    140,     25,   150,  5,    -1
gkrec,gihrec		FLbutton	"RECORDING",			1,   0,      1,     90,     25,   405,  5,    -1
gkMIDIplay,ihMIDIplay	FLbutton	"Only Play on MIDI Note",	1,   0,     22,    200,     25,     5,250,    -1
FLsetColor2	255, 255, 50, ihtrig		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihmute		;SET SECONDARY COLOUR TO YELLOW
FLsetColor2	255, 255, 50, ihMIDIplay	;SET SECONDARY COLOUR TO YELLOW
;		RED | GREEN | BLUE | HANDLE
FLsetColor2	255,     0,     0,   gihrec	;SET SELECTION COLOUR OF WIDGET. IN THIS CASE 'RED'
;		RED | BLUE | GREEN | HANDLE
FLsetTextColor	255,   255,   255,   gihrec	;SET COLOUR OF WIDGET LABEL. IN THIS CASE 'WHITE' - THE SAME COLOUR AS THE WIDGET AND THEREFORE INVISIBLE

;VALUE DISPLAY BOXES			LABEL  | WIDTH | HEIGHT | X | Y
iddur				FLvalue	" ",       70,    15,     5,  75
idpitch				FLvalue	" ",      100,    20,     5, 125
idfad				FLvalue	" ",      100,    20,     5, 175
idInGain			FLvalue	" ",      100,    20,     5, 225

;SLIDERS					            				MIN | MAX | EXP | TYPE |    DISP | WIDTH | HEIGHT | X | Y
gkdur, ihdur			FLslider 	"Duration of Recording (seconds)",	0,     10,   0,    23,     iddur,   490,     25,    0,  50
gkpitch, gihpitch		FLslider 	"Pitch (ratio)",			-4,     4,   0,    23,   idpitch,   490,     25,    0, 100
gkfad, ihfad			FLslider 	"Crossfade (seconds)",			0,      5,   0,    23,     idfad,   490,     25,    0, 150
gkInGain, ihInGain		FLslider 	"Input Gain",				0,      1,   0,    23,  idInGain,   490,     25,    0, 200

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	3, 	ihdur
				FLsetVal_i	1, 	gihpitch
				FLsetVal_i	0, 	ihfad
				FLsetVal_i	1, 	ihmute
				FLsetVal_i	0.5, 	ihInGain

				FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 560, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                          sndloop                            ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"'sndloop' is an opcode that offers a straightforward method  ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"of sampling some live audio and immediately playing it back  ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"in a loop with pitch control.                                ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"The duration of the recording to be undertaken must be       ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"defined before recording is activated.                       ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"A crossfade time can be defined which will create a crossfade", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"between the end and the beginning of the loop which may      ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"smooth the transition between the end and the beginning of   ", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"the loop and therefore prevent clicks.                       ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"In addition to the audio output from the opcode there is a   ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"k-rate switch which indicates when recording has begun and   ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"then when playback begins. In this example, this variable is ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"used to activate the red 'RECORDING' indicator.              ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"Negative values for 'Pitch' result in reverse playback.      ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"This instrument also allows the user to shift the pitch of   ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"the loop by playing keys on a connected MIDI keyboard.       ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"The 'Input Gain' control controls the level of audio reaching", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"the sndloop opcode therefore must be greater than zero.      ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"When not in playback mode after recording the sndloop opcode ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"normally outputs the audio reaching its input, if you wish to", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"mute live audio while recording (and also before recording   ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"has first taken place) activate the 'Mute Live Input' button.", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"If 'Only Play on MIDI Note' is active then playback will only", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"occur while a MIDI note is held. Playback always restarts    ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"from where it left off. There is no way to access sndrec's   ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"internal playback pointer.                                   ", 	1,      5,     14,    490,    15,     5, 540

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	1	;MIDI ACTIVATED INSTRUMENT - READS MIDI NOTE VALUES
	icps	cpsmidi		;READ PITCH VALUES (IN HERTZ) FROM A CONNECTED MIDI KEYBOARD
	ifreqratio	=	icps/cpsoct(8)	;DERIVE A FREQUENCY RATI0 (BASE FREQUENCY IS MIDDLE C)
	FLsetVal_i	ifreqratio, gihpitch	;SEND FRQUENCY RATIO VALUE TO 'Pitch' FADER.
	gkpitch	init	ifreqratio	;SET gkpitch TO ifreqratio.
endin

instr	2	;SOUND RECORDING AND PLAYING INSTRUMENT
	kMIDIactive	active	1						;SENSE NUMBER OF MIDI NOTES ACTIVE
	krecflag	init	0						;THIS FLAG IS ZERO BEFORE RECORDING HAS BEEN ACTIVATED (USING gktrig)
	krec		init	0						;INITIAL STATE OF krec. (NEEDED FOR THE CONDITIONAL IN THE NEXT LINE)
	kchanged	changed	gktrig						;IF REC-PLAY/STOP BUTTON HAS CHANGED OUTPUT A MOMENTARY '1'
	if gkMIDIplay=0||kMIDIactive>0||krecflag=0||krec=1||kchanged=1 then	;CONDITIONS NEEDED TO PERFORM PLAYBACK - THIS IMPLEMENTS THE PLAYBACK BY MIDI NOTE FEATURE
	  ain	inch	1							;READ AUDIO FROM LIVE INPUT CHANNEL 1
	  asig,krec	sndloop	ain*gkInGain,gkpitch,gktrig,i(gkdur),i(gkfad)	;'krec' OUTPUTS A FLAG TO TELL US WHETHER WE ARE RECORDING (1) OR PLAYING BACK (0)
	  krecflag	max	krec, krecflag					;krecflag WILL BE THE HIGHER VALUE BETWEEN krecflag AND krec
	  if	gkmute=1&&krec=0&&krecflag=1&&gktrig=1 then			;IF MUTE BUTTON IS ON...
			out	asig						;SEND AUDIO TO OUTPUT
	  elseif	gkmute=0 then						;OR IF LIVE MUTE IS NOT ACTIVE...
			out	asig						;...SEND AUDIO TO OUTPUT (DURING BOTH RECORDING AND PLAYBACK)
	  endif									;END OF CONDITIONAL BRANCH
	endif									;END OF CONDITIONAL BRANCH
	kupdate		changed	krec						;IF krec CHANGES, (I.E. STATE CHANGES FROM RECORDING TO PLAYBACK), kupdate WILL BE MOMENTARILY 1 
	FLsetVal	kupdate, krec, gihrec					;UPDATE 'RECORDING' INDICATOR: TURN ON WHEN RECORDING STARTS, TURN OFF WHEN RECORDING FINISHES
endin

</CsInstruments>                         
                                         
<CsScore>
;INSTR | START | DURATION                
i  2       0      3600	;INSTRUMENT PLAYS FOR 1 HOUR (AND SUSTAINS REALTIME PERFORMANCE)                    
</CsScore>                               
                                         
</CsoundSynthesizer>