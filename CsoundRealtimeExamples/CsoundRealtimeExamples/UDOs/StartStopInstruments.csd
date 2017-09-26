StartStopinstruments.csd
Written by Iain McCurdy, 2012

This example demonstrates two UDOs. 
One that starts and stops another numbered instrument using a '!=0'/'0' trigger and one that starts and stops a named instrument in the same way.

The instrument in which the UDO is placed should have a higher number (appear later in the orchestra if named) that the instruments that it starts and stops.


<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr = 44100
ksmps = 1
nchnls = 1
0dbfs = 1

FLcolor	250, 250, 250, 100, 100, 100
FLpanel	"",500, 460, 0, 0
gkOnOff1,ihOnOff  FLbutton   "Numbered",1,0,22,120,25,5,5,-1
gkOnOff2,ihOnOff  FLbutton   "Named",   1,0,22,120,25,5,35,-1

;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"StartStopInstr", 							1,      6,     12,    160,    20,    40,   80
ih		 	FLbox  	"insno,kOnOff", 							1,      5,     12,    120,    20,   170,   80
ih		 	FLbox  	"Initialisation                                                      ", 1,      7,     12,    490,    20,     5,  100
ih		 	FLbox  	"insno  -  Number of the instrument to be started and stopped.       ", 1,      5,     12,    490,    20,     5,  120
ih		 	FLbox  	"Performance                                                         ", 1,      7,     12,    490,    20,     5,  140
ih		 	FLbox  	"kOnOff -  Switch to start and stop the instrument. !=0:start 0:stop ", 1,      5,     12,    490,    20,     5,  160
ih		 	FLbox  	"StartStopNamedInstr", 							1,      6,     12,    190,    20,    40,  200
ih		 	FLbox  	"Sname,kOnOff", 							1,      5,     12,    120,    20,   200,  200
ih		 	FLbox  	"Initialisation                                                      ", 1,      7,     12,    490,    20,     5,  220
ih		 	FLbox  	"Sname  -  Name of the instrument to be started and stopped.         ", 1,      5,     12,    490,    20,     5,  240
ih		 	FLbox  	"Performance                                                         ", 1,      7,     12,    490,    20,     5,  260
ih		 	FLbox  	"kOnOff -  Switch to start and stop the instrument.                  ", 1,      5,     12,    490,    10,     5,  280
ih		 	FLbox  	"                                            non-zero=start 0=stop   ", 1,      5,     12,    490,    10,     5,  300
ih		 	FLbox  	"---", 									1,      5,     12,    490,    20,     5,  315
ih		 	FLbox  	"This example demonstrates two UDOs, one that starts and stops       ", 1,      5,     12,    490,    20,     5,  330
ih		 	FLbox  	"another numbered instrument using a non-zero/zero' trigger and one  ", 1,      5,     12,    490,    20,     5,  350
ih		 	FLbox  	"that starts and stops a named instrument in the same way.           ", 1,      5,     12,    490,    20,     5,  370
ih		 	FLbox  	"The instrument in which the UDO is placed should have a higher      ", 1,      5,     12,    490,    20,     5,  390
ih		 	FLbox  	"number (appear later in the orchestra if named) than the instruments", 1,      5,     12,    490,    20,     5,  410
ih		 	FLbox  	"that it starts and stops.                                           ", 1,      5,     12,    490,    20,     5,  430

FLrun

alwayson "CheckOnOff"

opcode StartStopInstr,0,ik
	insno,kOnOff	xin
  ktrig 	changed	kOnOff
  if ktrig==1 then
   if kOnOff!=0 then 
    event "i",insno,0,-1
   else
    turnoff2	insno,0,1
   endif
  endif
endop

opcode StartStopNamedInstr,0,Sk
	Sname,kOnOff	xin
  insno	nstrnum	Sname
  ktrig 	changed	kOnOff
  if ktrig==1 then
   if kOnOff!=0 then 
    event "i",insno,0,-1
   else
    turnoff2	insno,0,1
   endif
  endif
endop

instr	NamedInstrument
 a1	oscils	0.2,500,0
	out	a1
endin

instr	100
 a1	oscils	0.2,700,0
	out	a1
endin

instr	CheckOnOff
	StartStopInstr		100,              gkOnOff1
	StartStopNamedInstr	"NamedInstrument",gkOnOff2
endin

</CsInstruments>

<CsScore>
f 0 3600
</CsScore>

</CsoundSynthesizer>