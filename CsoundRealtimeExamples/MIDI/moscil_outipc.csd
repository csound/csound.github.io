moscil_outipc.csd
Written by Iain McCurdy, 2012.

<CsoundSynthesizer>

<CsOptions>
; amend device number accordingly
-Q1
</CsOptions>

<CsInstruments>

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
;		LABEL  | WIDTH | HEIGHT | X | Y
	FLpanel	"",       500,     450,   0,  0

;SWITCHES                       				ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"On/Off",		1,    0,    22,    150,     25,    5,  5,    0,      1,      0,      3600
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;COUNTERS					MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT  | X | Y | OPCODE
gkNoteMin, ihNoteMin 	FLcount  "Note Min.", 	0,    127,     1,     12,      1,   120,      25,    5, 50,   -1
gkNoteMax, ihNoteMax 	FLcount  "Note Max.", 	0,    127,     1,     12,      1,   120,      25,  125, 50,   -1
gkChnMin, ihChnMin 	FLcount  "Channel Min.",1,     16,     1,      1,      2,   120,      25,  250, 50,   -1
gkChnMax, ihChnMax 	FLcount  "Channel Max.",1,     16,     1,      1,      2,   120,      25,  375, 50,   -1
gkProg1,  ihProg1 	FLcount  "Prog.Chn.1",	1,    127,     1,     10,      1,   120,      25,    5,250,   -1
gkProg2,  ihProg2 	FLcount  "Prog.Chn.2",	1,    127,     1,     10,      1,   120,      25,  125,250,   -1
gkProg3,  ihProg3 	FLcount  "Prog.Chn.3",	1,    127,     1,     10,      1,   120,      25,  250,250,   -1
gkProg4,  ihProg4 	FLcount  "Prog.Chn.4",	1,    127,     1,     10,      1,   120,      25,  375,250,   -1
gkProg5,  ihProg5 	FLcount  "Prog.Chn.5",	1,    127,     1,     10,      1,   120,      25,    5,300,   -1
gkProg6,  ihProg6 	FLcount  "Prog.Chn.6",	1,    127,     1,     10,      1,   120,      25,  125,300,   -1
gkProg7,  ihProg7 	FLcount  "Prog.Chn.7",	1,    127,     1,     10,      1,   120,      25,  250,300,   -1
gkProg8,  ihProg8 	FLcount  "Prog.Chn.8",	1,    127,     1,     10,      1,   120,      25,  375,300,   -1
gkProg9,  ihProg9 	FLcount  "Prog.Chn.9",	1,    127,     1,     10,      1,   120,      25,    5,350,   -1
gkProg10, ihProg10 	FLcount  "Prog.Chn.10",	1,    127,     1,     10,      1,   120,      25,  125,350,   -1
gkProg11, ihProg11 	FLcount  "Prog.Chn.11",	1,    127,     1,     10,      1,   120,      25,  250,350,   -1
gkProg12, ihProg12 	FLcount  "Prog.Chn.12",	1,    127,     1,     10,      1,   120,      25,  375,350,   -1
gkProg13, ihProg13 	FLcount  "Prog.Chn.13",	1,    127,     1,     10,      1,   120,      25,    5,400,   -1
gkProg14, ihProg14 	FLcount  "Prog.Chn.14",	1,    127,     1,     10,      1,   120,      25,  125,400,   -1
gkProg15, ihProg15 	FLcount  "Prog.Chn.15",	1,    127,     1,     10,      1,   120,      25,  250,400,   -1
gkProg16, ihProg16 	FLcount  "Prog.Chn.16",	1,    127,     1,     10,      1,   120,      25,  375,400,   -1

;NUMBER DISPLAY BOXES			WIDTH | HEIGHT | X | Y
idPauseMin		FLvalue	" ",       80,    20,    5, 130
idPauseMax		FLvalue	" ",       80,    20,  415, 130
idDurMin		FLvalue	" ",       80,    20,    5, 180
idDurMax		FLvalue	" ",       80,    20,  415, 180
idVelMin		FLvalue	" ",       80,    20,    5, 230
idVelMax		FLvalue	" ",       80,    20,  415, 230

;SLIDERS				 		MIN   | MAX | EXP | TYPE |  DISP     | WIDTH | HEIGHT | X   | Y
gkPauseMin, ihPauseMin	FLslider	"", 		0,        2,   0,   23,   idPauseMin,   490,     15,    5,   100
gkPauseMax, ihPauseMax	FLslider	"Pause", 	0,        2,   0,   23,   idPauseMax,   490,     15,    5,   115
gkDurMin, ihDurMin	FLslider	"", 		0,        2,   0,   23,   idDurMin,     490,     15,    5,   150
gkDurMax, ihDurMax	FLslider	"Duration", 	0,        2,   0,   23,   idDurMax,     490,     15,    5,   165
gkVelMin, ihVelMin	FLslider	"", 		0,      127,   0,   23,   idVelMin,     490,     15,    5,   200
gkVelMax, ihVelMax	FLslider	"Velocity", 	0,      127,   0,   23,   idVelMax,     490,     15,    5,   215

;INITIALISATION OF SLIDERS	VALUE | HANDLE
		FLsetVal_i	60, 	ihNoteMin
		FLsetVal_i	72, 	ihNoteMax
		FLsetVal_i	0, 	ihPauseMin
		FLsetVal_i	0, 	ihPauseMax
		FLsetVal_i	0.1, 	ihDurMin
		FLsetVal_i	0.1, 	ihDurMax
		FLsetVal_i	60, 	ihVelMin
		FLsetVal_i	100, 	ihVelMax
		FLsetVal_i	1, 	ihChnMin
		FLsetVal_i	1, 	ihChnMax

		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 360, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                       moscil outipc                         ", 	1,      6,     14,    490,    20,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      6,     14,    490,    20,     5,  20
ih		 	FLbox  	"The moscil opcode can be used to generate streams of MIDI    ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"notes which will be sent to a selected MIDI output. To use   ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"MIDI out with Csound use the -Q command line flag followed by", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"an appropriate device number. The MIDI notes generated can be", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"played by an external synth if if one is not available a     ", 	1,      5,     14,    490,    20,     5, 120                     
ih		 	FLbox  	"software synth could be used. On Windows you could use the GS", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"wavetable synth, on Mac you could use the internal IAC bus to", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"route MIDI into Garageband.                                  ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"The rate at which new notes will be generated is controlled  ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"by defining a note duration and a pause until the next note. ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"Additionally moscil is supplied with a MIDI channel, note    ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"number and velocity.                                         ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"This example uses random functions to continually modulate   ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"note number, velocity, duration and pause from note to note. ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"The sound program used by the device can also be modulated.  ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"In the code this is implemented using the 'outipc' opcode.   ", 	1,      5,     14,    490,    20,     5, 340
		FLpanel_end


			FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


seed 0; random number generators seeded by system clock

  instr 1
if gkOnOff==0 then
 turnoff
endif
#define	UpdateProgramme(N)#ktrig$N	changed	gkProg$N
if ktrig$N==1 then
 reinit UPDATE$N
endif
UPDATE$N:
outipc $N, i(gkProg$N), 0, 127
rireturn#
$UpdateProgramme(1)
$UpdateProgramme(2)
$UpdateProgramme(3)
$UpdateProgramme(4)
$UpdateProgramme(5)
$UpdateProgramme(6)
$UpdateProgramme(7)
$UpdateProgramme(8)
$UpdateProgramme(9)
$UpdateProgramme(10)
$UpdateProgramme(11)
$UpdateProgramme(12)
$UpdateProgramme(13)
$UpdateProgramme(14)
$UpdateProgramme(15)
$UpdateProgramme(16)

kchn    random	gkChnMin,gkChnMax+0.999999
knum    random    gkNoteMin,gkNoteMax+0.999999  	;NOTE NUMBERS CHOSEN RANDOMLY
kvel    random    gkVelMin, gkVelMax   			;VELOCITIES ARE CHOSEN RANDOMLY
kdur    random    gkDurMin, gkDurMax    		;NOTE DURATIONS CHOSEN RANDOMLY
kpause  random    gkPauseMin, gkPauseMax    		;PAUSES BETWEEN NOTES CHOSEN RANDOMLY
        moscil    kchn, knum, kvel, kdur, kpause	;SEND A STREAM OF MIDI NOTES
	endin

</CsInstruments>

<CsScore>
f 0 3600
</CsScore>

</CsoundSynthesizer>