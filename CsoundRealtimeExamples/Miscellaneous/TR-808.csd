TR808.csd (FLTK version)

Ported from the Cabbage version by Tom Gideon 2013

<CsoundSynthesizer>
<CsOptions>
-dm0 -odac -M0 -+rtmidi=virtual
</CsOptions>
<CsInstruments>
sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1


;;FLTK GUI

FLcolor 168, 176, 184
FLcolor2 0, 0, 0
FLpanel  "TR-808", 800, 400, 0, 0
ih  FLbox  "Author: Iain McCurdy |2012| - (FLTK port by Tom Gideon) ", 1, 1, 10, 300,  14, 150, 370
ih  FLbox  "B.Drum", 1, 1, 10,   50,  225,  0,   0-100
gklevel1, ihlevel1 FLknob "Level", 0,  2, 0, 1, -1, 50,  5-5,  25+6
FLsetVal_i  1, ihlevel1
gktune1, ihtune1 FLknob "Tune", -2,  2, 0, 1, -1, 50,  5-5,  75+28
FLsetVal_i  0, ihtune1
gkdur1, ihdur1 FLknob "Decay", 0.25,  2, 0, 1, -1, 50,  5-5, 125+44
FLsetVal_i  1, ihdur1
gkpan1, ihpan1 FLknob "Pan", 0,  1, 0, 1, -1, 50,  5-5, 175+60
FLsetVal_i  0.5, ihpan1
ih  FLbox  "Snare", 1, 1, 10,   50,  225, 50,   0-100
gklevel2, ihlevel2 FLknob "Level", 0,  2, 0, 1, -1, 50, 55-5,  25+6
FLsetVal_i  1, ihlevel2
gktune2, ihtune2 FLknob "Tune", -2,  2, 0, 1, -1, 50, 55-5,  75+28
FLsetVal_i  0, ihtune2
gkdur2, ihdur2 FLknob "Decay", 0.25,  2, 0, 1, -1, 50, 55-5, 125+44
FLsetVal_i  1, ihdur2
gkpan2, ihpan2 FLknob "Pan", 0,  1, 0, 1, -1, 50, 55-5, 175+60
FLsetVal_i  0.5, ihpan2
ih  FLbox  "Open HH", 1, 1, 10,   50,  225, 100,   0-100
gklevel3, ihlevel3 FLknob "Level", 0,  2, 0, 1, -1, 50, 105-5,  25+6
FLsetVal_i  1, ihlevel3
gktune3, ihtune3 FLknob "Tune", -2,  2, 0, 1, -1, 50, 105-5,  75+28
FLsetVal_i  0, ihtune3
gkdur3, ihdur3 FLknob "Decay", 0.25,  2, 0, 1, -1, 50, 105-5, 125+44
FLsetVal_i  1, ihdur3
gkpan3, ihpan3 FLknob "Pan", 0,  1, 0, 1, -1, 50, 105-5, 175+60
FLsetVal_i  0.5, ihpan3
ih  FLbox  "Cl. HH", 1, 1, 10,   50,  225, 150,   0-100
gklevel4, ihlevel4 FLknob "Level", 0,  2, 0, 1, -1, 50, 155-5,  25+6
FLsetVal_i  1, ihlevel4
gktune4, ihtune4 FLknob "Tune", -2,  2, 0, 1, -1, 50, 155-5,  75+28
FLsetVal_i  0, ihtune4
gkdur4, ihdur4 FLknob "Decay", 0.25,  2, 0, 1, -1, 50, 155-5, 125+44
FLsetVal_i  1, ihdur4
gkpan4, ihpan4 FLknob "Pan", 0,  1, 0, 1, -1, 50, 155-5, 175+60
FLsetVal_i  0.5, ihpan4
ih  FLbox  "Hi Tom", 1, 1, 10,   50,  225, 200,   0-100
gklevel5, ihlevel5 FLknob "Level", 0,  2, 0, 1, -1, 50, 205-5,  25+6
FLsetVal_i  1, ihlevel5
gktune5, ihtune5 FLknob "Tune", -2,  2, 0, 1, -1, 50, 205-5,  75+28
FLsetVal_i  0, ihtune5
gkdur5, ihdur5 FLknob "Decay", 0.25,  2, 0, 1, -1, 50, 205-5, 125+44
FLsetVal_i  1, ihdur5
gkpan5, ihpan5 FLknob "Pan", 0,  1, 0, 1, -1, 50, 205-5, 175+60
FLsetVal_i  0.5, ihpan5
ih  FLbox  "Mid Tom", 1, 1, 10,   50,  225, 250,   0-100
gklevel6, ihlevel6 FLknob "Level", 0,  2, 0, 1, -1, 50, 255-5,  25+6
FLsetVal_i  1, ihlevel6
gktune6, ihtune6 FLknob "Tune", -2,  2, 0, 1, -1, 50, 255-5,  75+28
FLsetVal_i  0, ihtune6
gkdur6, ihdur6 FLknob "Decay", 0.25,  2, 0, 1, -1, 50, 255-5, 125+44
FLsetVal_i  1, ihdur6
gkpan6, ihpan6 FLknob "Pan", 0,  1, 0, 1, -1, 50, 255-5, 175+60
FLsetVal_i  0.5, ihpan6
ih  FLbox  "Low Tom", 1, 1, 10,   50,  225, 300,   0-100
gklevel7, ihlevel7 FLknob "Level", 0,  2, 0, 1, -1, 50, 305-5,  25+6
FLsetVal_i  1, ihlevel7
gktune7, ihtune7 FLknob "Tune", -2,  2, 0, 1, -1, 50, 305-5,  75+28
FLsetVal_i  0, ihtune7
gkdur7, ihdur7 FLknob "Decay", 0.25,  2, 0, 1, -1, 50, 305-5, 125+44
FLsetVal_i  1, ihdur7
gkpan7, ihpan7 FLknob "Pan", 0,  1, 0, 1, -1, 50, 305-5, 175+60
FLsetVal_i  0.5, ihpan7
ih  FLbox  "Cymbal", 1, 1, 10,   50,  225, 350,   0-100
gklevel8, ihlevel8 FLknob "Level", 0,  2, 0, 1, -1, 50, 355-5,  25+6
FLsetVal_i  1, ihlevel8
gktune8, ihtune8 FLknob "Tune", -2,  2, 0, 1, -1, 50, 355-5,  75+28
FLsetVal_i  0, ihtune8
gkdur8, ihdur8 FLknob "Decay", 0.25,  2, 0, 1, -1, 50, 355-5, 125+44
FLsetVal_i  1, ihdur8
gkpan8, ihpan8 FLknob "Pan", 0,  1, 0, 1, -1, 50, 355-5, 175+60
FLsetVal_i  0.5, ihpan8
ih  FLbox  "Rim Shot", 1, 1, 10,   50,  225, 400,   0-100
gklevel9, ihlevel9 FLknob "Level", 0,  2, 0, 1, -1, 50, 405-5,  25+6
FLsetVal_i  1, ihlevel9
gktune9, ihtune9 FLknob "Tune", -2,  2, 0, 1, -1, 50, 405-5,  75+28
FLsetVal_i  0, ihtune9
gkdur9, ihdur9 FLknob "Decay", 0.25,  2, 0, 1, -1, 50, 405-5, 125+44
FLsetVal_i  1, ihdur9
gkpan9, ihpan9 FLknob "Pan", 0,  1, 0, 1, -1, 50, 405-5, 175+60
FLsetVal_i  0.5, ihpan9
ih  FLbox  "Claves", 1, 1, 10,   50,  225, 450,   0-100
gklevel10, ihlevel10 FLknob "Level", 0,  2, 0, 1, -1, 50, 455-5,  25+6
FLsetVal_i  1, ihlevel10
gktune10, ihtune10 FLknob "Tune", -2,  2, 0, 1, -1, 50, 455-5,  75+28
FLsetVal_i  0, ihtune10
gkdur10, ihdur10 FLknob "Decay", 0.25,  2, 0, 1, -1, 50, 455-5, 125+44
FLsetVal_i  1, ihdur10
gkpan10, ihpan10 FLknob "Pan", 0,  1, 0, 1, -1, 50, 455-5, 175+60
FLsetVal_i  0.5, ihpan10
ih  FLbox  "Cowbell", 1, 1, 10,   50,  225, 500,   0-100
gklevel11, ihlevel11 FLknob "Level", 0,  2, 0, 1, -1, 50, 505-5,  25+6
FLsetVal_i  1, ihlevel11
gktune11, ihtune11 FLknob "Tune", -2,  2, 0, 1, -1, 50, 505-5,  75+28
FLsetVal_i  0, ihtune11
gkdur11, ihdur11 FLknob "Decay", 0.25,  2, 0, 1, -1, 50, 505-5, 125+44
FLsetVal_i  1, ihdur11
gkpan11, ihpan11 FLknob "Pan", 0,  1, 0, 1, -1, 50, 505-5, 175+60
FLsetVal_i  0.5, ihpan11
ih  FLbox  "Clap", 1, 1, 10,   50,  225, 550,   0-100
gklevel12, ihlevel12 FLknob "Level", 0,  2, 0, 1, -1, 50, 555-5,  25+6
FLsetVal_i  1, ihlevel12
gktune12, ihtune12 FLknob "Tune", -2,  2, 0, 1, -1, 50, 555-5,  75+28
FLsetVal_i  0, ihtune12
gkdur12, ihdur12 FLknob "Decay", 0.25,  2, 0, 1, -1, 50, 555-5, 125+44
FLsetVal_i  1, ihdur12
gkpan12, ihpan12 FLknob "Pan", 0,  1, 0, 1, -1, 50, 555-5, 175+60
FLsetVal_i  0.5, ihpan12
ih  FLbox  "Maraca", 1, 1, 10,   50,  225, 600,   0-100
gklevel13, ihlevel13 FLknob "Level", 0,  2, 0, 1, -1, 50, 605-5,  25+6
FLsetVal_i  1, ihlevel13
gktune13, ihtune13 FLknob "Tune", -2,  2, 0, 1, -1, 50, 605-5,  75+28
FLsetVal_i  0, ihtune13
gkdur13, ihdur13 FLknob "Decay", 0.25,  2, 0, 1, -1, 50, 605-5, 125+44
FLsetVal_i  1, ihdur13
gkpan13, ihpan13 FLknob "Pan", 0,  1, 0, 1, -1, 50, 605-5, 175+60
FLsetVal_i  0.5, ihpan13
ih  FLbox  "Hi Conga", 1, 1, 10,   50,  225, 650,   0-100
gklevel14, ihlevel14 FLknob "Level", 0,  2, 0, 1, -1, 50, 655-5,  25+6
FLsetVal_i  1, ihlevel14
gktune14, ihtune14 FLknob "Tune", -2,  2, 0, 1, -1, 50, 655-5,  75+28
FLsetVal_i  0, ihtune14
gkdur14, ihdur14 FLknob "Decay", 0.25,  2, 0, 1, -1, 50, 655-5, 125+44
FLsetVal_i  1, ihdur14
gkpan14, ihpan14 FLknob "Pan", 0,  1, 0, 1, -1, 50, 655-5, 175+60
FLsetVal_i  0.5, ihpan14
ih  FLbox  "Md Cnga", 1, 1, 10,   50,  225, 700,   0-100
gklevel15, ihlevel15 FLknob "Level", 0,  2, 0, 1, -1, 50, 705-5,  25+6
FLsetVal_i  1, ihlevel15
gktune15, ihtune15 FLknob "Tune", -2,  2, 0, 1, -1, 50, 705-5,  75+28
FLsetVal_i  0, ihtune15
gkdur15, ihdur15 FLknob "Decay", 0.25,  2, 0, 1, -1, 50, 705-5, 125+44
FLsetVal_i  1, ihdur15
gkpan15, ihpan15 FLknob "Pan", 0,  1, 0, 1, -1, 50, 705-5, 175+60
FLsetVal_i  0.5, ihpan15
ih  FLbox  "Lo Cnga", 1, 1, 10,   50,  225, 750,   0-100
gklevel16, ihlevel16 FLknob "Level", 0,  2, 0, 1, -1, 50, 755-5,  25+6
FLsetVal_i  1, ihlevel16
gktune16, ihtune16 FLknob "Tune", -2,  2, 0, 1, -1, 50, 755-5,  75+28
FLsetVal_i  0, ihtune16
gkdur16, ihdur16 FLknob "Decay", 0.25,  2, 0, 1, -1, 50, 755-5, 125+44
FLsetVal_i  1, ihdur16
gkpan16, ihpan16 FLknob "Pan", 0,  1, 0, 1, -1, 50, 755-5, 175+60
FLsetVal_i  0.5, ihpan16
FLcolor2 0, 224, 0
gkOnOff, ihOnOff FLbutton "Run/Stop", 1, 0, 12,  80,  25,  10, 315, 0, 2, 0, -1
FLcolor2 0, 0, 0
;FLsetVal_i 0, ihOnOff
gkclear, ihclear FLbutton "Clear", 1, 0, 11,  80,  20, 462, 305, 0, 200, 0, 0.1
;FLsetVal_i 0, ihclear
gksave, ihsave FLbutton "Save", 1, 0, 11,  38,  20, 462, 328, 0, 201, 0, 0.1;-1

gkload, ihload FLbutton "Load", 1, 0, 11,  38,  20, 502, 328, 0, 202, 0, 0.1;-1
;FLsetVal_i 0, ihload
ih  FLbox  "PATTERNs", 1, 1, 16,  48,  10, 20, 370
gkAccLev, ihAccLev FLknob "Accent", 0,  1, 0, 1, -1, 50, 650, 316
FLsetVal_i  0.4, ihAccLev
gktempo,   gihtempo   FLcount      "BPM",  1, 999, 1, 10,  21, 100, 25, 550, 305, -1
;gktempo, ihtempo FLknob "Tempo", 10,  500, 0, 1, -1, 50, 643-5, 310+6
FLsetVal_i  70, gihtempo
gkswing, ihswing FLknob "Swing", 0,  0.5, 0, 1, -1, 50, 700, 316
FLsetVal_i  0, ihswing
gklevel, ihlevel FLknob "Level", 0,  2, 0, 1, -1, 50, 745, 316
FLsetVal_i  1, ihlevel
ih  FLbox  "1", 1, 1, 10,  12,  10, 143, 312
ih  FLbox  "2", 1, 1, 10,  12,  10, 163, 312
ih  FLbox  "3", 1, 1, 10,  12,  10, 183, 312
ih  FLbox  "4", 1, 1, 10,  12,  10, 203, 312
ih  FLbox  "5", 1, 1, 10,  12,  10, 223, 312
ih  FLbox  "6", 1, 1, 10,  12,  10, 243, 312
ih  FLbox  "7", 1, 1, 10,  12,  10, 263, 312
ih  FLbox  "8", 1, 1, 10,  12,  10, 283, 312
ih  FLbox  "9", 1, 1, 10,  12,  10, 303, 312
ih  FLbox  "10", 1, 1, 10,  12,  10, 320, 312
ih  FLbox  "11", 1, 1, 10,  12,  10, 340, 312
ih  FLbox  "12", 1, 1, 10,  12,  10, 360, 312
ih  FLbox  "13", 1, 1, 10,  12,  10, 380, 312
ih  FLbox  "14", 1, 1, 10,  12,  10, 400, 312
ih  FLbox  "15", 1, 1, 10,  12,  10, 420, 312
ih  FLbox  "16", 1, 1, 10,  12,  10, 440, 312
ih  FLbox  "On", 1, 1, 10,  36,  12, 114,  325
gkOn1, gihOn1 FLbutton "", 1, 0, 4,  12,  12, 140,  325, -1
FLsetVal_i 0, gihOn1
gkOn2, gihOn2 FLbutton "", 1, 0, 4,  12,  12, 160,  325, -1
FLsetVal_i 0, gihOn2
gkOn3, gihOn3 FLbutton "", 1, 0, 4,  12,  12, 180,  325, -1
FLsetVal_i 0, gihOn3
gkOn4, gihOn4 FLbutton "", 1, 0, 4,  12,  12, 200,  325, -1
FLsetVal_i 0, gihOn4
gkOn5, gihOn5 FLbutton "", 1, 0, 4,  12,  12, 220,  325, -1
FLsetVal_i 0, gihOn5
gkOn6, gihOn6 FLbutton "", 1, 0, 4,  12,  12, 240,  325, -1
FLsetVal_i 0, gihOn6
gkOn7, gihOn7 FLbutton "", 1, 0, 4,  12,  12, 260,  325, -1
FLsetVal_i 0, gihOn7
gkOn8, gihOn8 FLbutton "", 1, 0, 4,  12,  12, 280,  325, -1
FLsetVal_i 0, gihOn8
gkOn9, gihOn9 FLbutton "", 1, 0, 4,  12,  12, 300,  325, -1
FLsetVal_i 0, gihOn9
gkOn10, gihOn10 FLbutton "", 1, 0, 4,  12,  12, 320,  325, -1
FLsetVal_i 0, gihOn10
gkOn11, gihOn11 FLbutton "", 1, 0, 4,  12,  12, 340,  325, -1
FLsetVal_i 0, gihOn11
gkOn12, gihOn12 FLbutton "", 1, 0, 4,  12,  12, 360,  325, -1
FLsetVal_i 0, gihOn12
gkOn13, gihOn13 FLbutton "", 1, 0, 4,  12,  12, 380,  325, -1
FLsetVal_i 0, gihOn13
gkOn14, gihOn14 FLbutton "", 1, 0, 4,  12,  12, 400,  325, -1
FLsetVal_i 0, gihOn14
gkOn15, gihOn15 FLbutton "", 1, 0, 4,  12,  12, 420,  325, -1
FLsetVal_i 0, gihOn15
gkOn16, gihOn16 FLbutton "", 1, 0, 4,  12,  12, 440,  325, -1
FLsetVal_i 0, gihOn16
ih  FLbox  "Accent", 1, 1, 10,  40,  12,  102,  345
gkAcc1, gihAcc1 FLbutton "", 1, 0, 4,  12,  12, 140,  345, -1
FLsetVal_i 0, gihAcc1
gkAcc2, gihAcc2 FLbutton "", 1, 0, 4,  12,  12, 160,  345, -1
FLsetVal_i 0, gihAcc2
gkAcc3, gihAcc3 FLbutton "", 1, 0, 4,  12,  12, 180,  345, -1
FLsetVal_i 0, gihAcc3
gkAcc4, gihAcc4 FLbutton "", 1, 0, 4,  12,  12, 200,  345, -1
FLsetVal_i 0, gihAcc4
gkAcc5, gihAcc5 FLbutton "", 1, 0, 4,  12,  12, 220,  345, -1
FLsetVal_i 0, gihAcc5
gkAcc6, gihAcc6 FLbutton "", 1, 0, 4,  12,  12, 240,  345, -1
FLsetVal_i 0, gihAcc6
gkAcc7, gihAcc7 FLbutton "", 1, 0, 4,  12,  12, 260,  345, -1
FLsetVal_i 0, gihAcc7
gkAcc8, gihAcc8 FLbutton "", 1, 0, 4,  12,  12, 280,  345, -1
FLsetVal_i 0, gihAcc8
gkAcc9, gihAcc9 FLbutton "", 1, 0, 4,  12,  12, 300,  345, -1
FLsetVal_i 0, gihAcc9
gkAcc10, gihAcc10 FLbutton "", 1, 0, 4,  12,  12, 320,  345, -1
FLsetVal_i 0, gihAcc10
gkAcc11, gihAcc11 FLbutton "", 1, 0, 4,  12,  12, 340,  345, -1
FLsetVal_i 0, gihAcc11
gkAcc12, gihAcc12 FLbutton "", 1, 0, 4,  12,  12, 360,  345, -1
FLsetVal_i 0, gihAcc12
gkAcc13, gihAcc13 FLbutton "", 1, 0, 4,  12,  12, 380,  345, -1
FLsetVal_i 0, gihAcc13
gkAcc14, gihAcc14 FLbutton "", 1, 0, 4,  12,  12, 400,  345, -1
FLsetVal_i 0, gihAcc14
gkAcc15, gihAcc15 FLbutton "", 1, 0, 4,  12,  12, 420,  345, -1
FLsetVal_i 0, gihAcc15
gkAcc16, gihAcc16 FLbutton "", 1, 0, 4,  12,  12, 440,  345, -1
FLsetVal_i 0, gihAcc16
;                                  ion, ioff, itype,  iw, ih,  ix, iy, iopcode, instr, start, dur
gkExit, gihExit  FLbutton  "EXIT",   1,  1,    11,   100, 25, 462, 350,     105,  1000,     0, 0.1

gkpattern, gihpattern      FLbutBank 4, 16, 1, 800, 20, 0, 380, -1
FLsetVal_i 0, gihpattern
FLcolor2 0, 224, 0
gksound, gihsound      FLbutBank 1, 16, 1, 800, 12, 0, 20, -1
FLsetVal_i 0, gihsound
FLpanel_end
FLrun





giTR808RimShot	ftgen	0,0,1024,10,	0.971,0.269,0.041,0.054,0.011,0.013,0.08,0.0065,0.005,0.004,0.003,0.003,0.002,0.002,0.002,0.002,0.002,0.001,0.001,0.001,0.001,0.001,0.002,0.001,0.001	;WAVEFORM FOR TR808 RIMSHOT
gkOnOff init 0
gisine		ftgen	0,0,1024,10,1	;A SINE WAVE
gicos		ftgen	0,0,65536,9,1,1,90	;A COSINE WAVE
gkoff	init	0
;			1, 2, 3, 4, 5, 6, 7, 8, 9,10,11,12,13,14,15,16
giOn1	ftgen	0,0,16,2,	1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0	;BD
giOn2	ftgen	0,0,16,2,	0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0	;SN
giOn3	ftgen	0,0,16,2,	0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0  ;HHO
giOn4	ftgen	0,0,16,2,	1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1  ;HHCl
giOn5	ftgen	0,0,16,2,	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  ;Hi Tom
giOn6	ftgen	0,0,16,2,	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  ;Mid Tom
giOn7	ftgen	0,0,16,2,	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  ;Lo Tom
giOn8	ftgen	0,0,16,2,	0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 0  ;Cym
giOn9	ftgen	0,0,16,2,	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  ;Rimshot
giOn10	ftgen	0,0,16,2,	1, 0, 0, 1, 0, 0, 1, 0, 1, 0, 0, 1, 0, 0, 1, 0  ;Claves
giOn11	ftgen	0,0,16,2,	1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 1  ;Cowbell
giOn12	ftgen	0,0,16,2,	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  ;Clap
giOn13	ftgen	0,0,16,2,	1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0  ;Maraca
giOn14	ftgen	0,0,16,2,	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 0, 0  ;Hi Conga
giOn15	ftgen	0,0,16,2,	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0  ;Mid Conga
giOn16	ftgen	0,0,16,2,	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1  ;Lo Conga
giAcc1	ftgen	0,0,16,2,	1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0	;BD
giAcc2	ftgen	0,0,16,2,	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0	;SN
giAcc3	ftgen	0,0,16,2,	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  ;HHO
giAcc4	ftgen	0,0,16,2,	1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0  ;HHCl
giAcc5	ftgen	0,0,16,2,	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1  ;Hi Tom
giAcc6	ftgen	0,0,16,2,	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0  ;Mid Tom
giAcc7	ftgen	0,0,16,2,	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0  ;Lo Tom
giAcc8	ftgen	0,0,16,2,	0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0  ;Cym
giAcc9	ftgen	0,0,16,2,	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  ;Rimshot
giAcc10	ftgen	0,0,16,2,	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  ;Claves
giAcc11	ftgen	0,0,16,2,	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  ;Cowbell
giAcc12	ftgen	0,0,16,2,	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  ;Clap
giAcc13	ftgen	0,0,16,2,	1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0, 1, 0, 0, 0  ;Maraca
giAcc14	ftgen	0,0,16,2,	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0  ;Hi Conga
giAcc15	ftgen	0,0,16,2,	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0  ;Mid Conga
giAcc16	ftgen	0,0,16,2,	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0  ;Lo Conga
giblank	ftgen	0,0,16,2,	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0  ;blank

#define	UPDATE_TABLE(N)
	#
	ktrig	changed	gkOn$N
	if ktrig==1 then
	 tablewkt	gkOn$N, $N-1, giOn1+gksound
	endif
	ktrig	changed	gkAcc$N
	if ktrig==1 then
	 tablewkt	gkAcc$N, $N-1, giAcc1+gksound
	endif
	#
#define	UPDATE_SEQUENCE(N)
	 #
	 gkOn	tablekt	$N-1, giOn1+gksound
	 FLsetVal 1, gkOn, gihOn$N
	 ;chnset	kval,"On$N"
	 gkAcc	tablekt	$N-1, giAcc1+gksound
	 FLsetVal 1, gkAcc, gihAcc$N
	 ;chnset	kval,"Acc$N"
	 ;kval	tablekt	$N-1,giOn1+gksound-1
	 ;chnset	kval,"On$N"
	 ;kval	tablekt	$N-1,giAcc1+gksound-1
	 ;chnset	kval,"Acc$N"	
	 #
#define	VOICE(N)	
	#
	iOnOff$N	table	gindx, giOn$N
	if iOnOff$N==1 then
	 iAcc	table	gindx, giAcc$N
	 event_i	"i", 100+$N, 0, 0.001, 0.4 + (iAcc*i(gkAccLev))
	endif
	#

instr	2
	;START/STOP SEQUENCER
	ktrig	changed	gkOnOff		;if Run/Stop button is changed...
	if ktrig==1 then		;
	 if gkOnOff==1 then		;...if Run/Stop has been changed to 'Run'...
	  event	"i",3,0,-1		;...start instr 3 playing a held note
	 else				;otherwise...
	 event	"i",-3,0,0		;...stop instr 3 playing
	 endif
	endif
	;UPDATE SEQUENCE DISPLAY
	ktrig	changed	gksound, gkload
	if ktrig==1 then
	 $UPDATE_SEQUENCE(1)
	 $UPDATE_SEQUENCE(2)
	 $UPDATE_SEQUENCE(3)
	 $UPDATE_SEQUENCE(4)
	 $UPDATE_SEQUENCE(5)
	 $UPDATE_SEQUENCE(6)
	 $UPDATE_SEQUENCE(7)
	 $UPDATE_SEQUENCE(8)
	 $UPDATE_SEQUENCE(9)
	 $UPDATE_SEQUENCE(10)
	 $UPDATE_SEQUENCE(11)
	 $UPDATE_SEQUENCE(12)
	 $UPDATE_SEQUENCE(13)
	 $UPDATE_SEQUENCE(14)
	 $UPDATE_SEQUENCE(15)
	 $UPDATE_SEQUENCE(16)
	endif
	;UPDATE TABLE IF SEQUENCE BUTTON CHANGED
	$UPDATE_TABLE(1)
	$UPDATE_TABLE(2)
	$UPDATE_TABLE(3)
	$UPDATE_TABLE(4)
	$UPDATE_TABLE(5)
	$UPDATE_TABLE(6)
	$UPDATE_TABLE(7)
	$UPDATE_TABLE(8)
	$UPDATE_TABLE(9)
	$UPDATE_TABLE(10)
	$UPDATE_TABLE(11)
	$UPDATE_TABLE(12)
	$UPDATE_TABLE(13)
	$UPDATE_TABLE(14)
	$UPDATE_TABLE(15)
	$UPDATE_TABLE(16)
endin

instr	1	;READ MIDI AND TRIGGER NOTES
	inum	notnum					;READ IN MIDI NOTE NUMBER
	idb	veloc	-30,0				;READ IN MIDI NOTE VELOCITY (WILL BE USED AS A DECIBEL VALUE)
	iinstr	wrap	inum,0,16			;MAP MIDI NOTE NUMBERS (RANGE: 0 - 127) TO DRUM SOUND NUMBER (0 - 15)
	event_i	"i",101+iinstr,0,0.001,ampdbfs(idb)	;CALL THE RELEVANT INSTRUMENT AND SEND AMPLITUDE VALUE AS p4
endin

instr	3	;PLAY SEQUENCE	
	gindx	init	0
	ktick	metro	(gktempo*4)/60
	
	;SWING
	kSwingBeat init	0
	kSwingTime	=	(kSwingBeat==1?(60*gkswing)/(gktempo*4):0)
	if ktick==1 then
	 kSwingBeat	=	abs(kSwingBeat-1)	;FLIP BETWEEN ZERO AND 1
	endif
	
		schedkwhen	ktick, 0, 0, 4, kSwingTime, 0.001
		;schedkwhen	ktick, 0, 0, 4, 0, 0.001
endin

instr	4	;TEST FOR NOTE ON SEQUENCE STEP
$VOICE(1)
$VOICE(2)
$VOICE(3)
$VOICE(4)
$VOICE(5)
$VOICE(6)
$VOICE(7)
$VOICE(8)
$VOICE(9)
$VOICE(10)
$VOICE(11)
$VOICE(12)
$VOICE(13)
$VOICE(14)
$VOICE(15)
$VOICE(16)
	gindx		wrap	gindx+1, 0, 16
			turnoff
endin

instr	101	;BASS DRUM
	p3	=	2*i(gkdur1)							;NOTE DURATION. SCALED USING GUI 'Decay' KNOB
	;SUSTAIN AND BODY OF THE SOUND
	kmul	transeg	0.2,p3*0.5,-15,0.01, p3*0.5,0,0					;PARTIAL STRENGTHS MULTIPLIER USED BY GBUZZ. DECAYS FROM A SOUND WITH OVERTONES TO A SINE TONE.
	kbend	transeg	0.5,1.2,-4, 0,1,0,0						;SLIGHT PITCH BEND AT THE START OF THE NOTE 
	asig	gbuzz	0.5,50*octave(gktune1)*semitone(kbend),20,1,kmul,gicos		;GBUZZ TONE
	aenv	transeg	1,p3-0.004,-6,0							;AMPLITUDE ENVELOPE FOR SUSTAIN OF THE SOUND
	aatt	linseg	0,0.004,1							;SOFT ATTACK
	asig	=	asig*aenv*aatt

	;HARD, SHORT ATTACK OF THE SOUND
	aenv	linseg	1,0.07,0							;AMPLITUDE ENVELOPE (FAST DECAY)						
	acps	expsega	400,0.07,0.001,1,0.001						;FREQUENCY OF THE ATTACK SOUND. QUICKLY GLISSES FROM 400 Hz TO SUB-AUDIO
	aimp	oscili	aenv,acps*octave(gktune1*0.25),gisine				;CREATE ATTACK SOUND
	
	amix	=	((asig*0.5)+(aimp*0.35))*gklevel1*p4*gklevel			;MIX SUSTAIN AND ATTACK SOUND ELEMENTS AND SCALE USING GUI 'Level' KNOB
	
	aL,aR	pan2	amix,gkpan1							;PAN THE MONOPHONIC SOUND
		outs	aL,aR								;SEND AUDIO TO OUTPUTS
endin

instr	102	;SNARE DRUM
	;SOUND CONSISTS OF TWO SINE TONES, AN OCTAVE APART AND A NOISE SIGNAL
	ifrq  	=	342		;FREQUENCY OF THE TONES
	iNseDur	=	0.3 * i(gkdur2)	;DURATION OF THE NOISE COMPONENT
	iPchDur	=	0.1 * i(gkdur2)	;DURATION OF THE SINE TONES COMPONENT
	p3	=	iNseDur 	;p3 DURATION TAKEN FROM NOISE COMPONENT DURATION (ALWATS THE LONGEST COMPONENT)
	
	;SINE TONES COMPONENT
	aenv1	expseg	1,iPchDur,0.0001,p3-iPchDur,0.0001		;AMPLITUDE ENVELOPE
	apitch1	oscili	1,ifrq*octave(gktune2),gisine			;SINE TONE 1
	apitch2	oscili	0.25,ifrq*0.5*octave(gktune2),gisine		;SINE TONE 2 (AN OCTAVE LOWER)
	apitch	=	(apitch1+apitch2)*0.75				;MIX THE TWO SINE TONES

	;NOISE COMPONENT
	aenv2	expon	1,p3,0.0005					;AMPLITUDE ENVELOPE
	anoise	noise	0.75,0						;CREATE SOME NOISE
	anoise	butbp	anoise,10000*octave(gktune2),10000		;BANDPASS FILTER THE NOISE SIGNAL
	anoise	buthp	anoise,1000					;HIGHPASS FILTER THE NOISE SIGNAL
	kcf	expseg	5000,0.1,3000,p3-0.2,3000			;CUTOFF FREQUENCY FOR A LOWPASS FILTER
	anoise	butlp	anoise,kcf					;LOWPASS FILTER THE NOISE SIGNAL
	amix	=	((apitch*aenv1)+(anoise*aenv2))*gklevel2*p4*gklevel	;MIX AUDIO SIGNALS AND SCALE ACCORDING TO GUI 'Level' CONTROL
	aL,aR	pan2	amix,i(gkpan2)					;PAN THE MONOPHONIC AUDIO SIGNAL
		outs	aL,aR						;SEND AUDIO TO OUTPUTS
endin

instr	103	;OPEN HIGH HAT
	kFrq1	=	296*octave(gktune3) 	;FREQUENCIES OF THE 6 OSCILLATORS
	kFrq2	=	285*octave(gktune3) 	
	kFrq3	=	365*octave(gktune3) 	
	kFrq4	=	348*octave(gktune3) 	
	kFrq5	=	420*octave(gktune3) 	
	kFrq6	=	835*octave(gktune3) 	
	p3	=	0.5*i(gkdur3)		;DURATION OF THE NOTE
	
	;SOUND CONSISTS OF 6 PULSE OSCILLATORS MIXED WITH A NOISE COMPONENT
	;PITCHED ELEMENT
	aenv	linseg	1,p3-0.05,0.1,0.05,0		;AMPLITUDE ENVELOPE FOR THE PULSE OSCILLATORS
	ipw	=	0.25				;PULSE WIDTH
	a1	vco2	0.5,kFrq1,2,ipw			;PULSE OSCILLATORS...
	a2	vco2	0.5,kFrq2,2,ipw
	a3	vco2	0.5,kFrq3,2,ipw
	a4	vco2	0.5,kFrq4,2,ipw
	a5	vco2	0.5,kFrq5,2,ipw
	a6	vco2	0.5,kFrq6,2,ipw
	amix	sum	a1,a2,a3,a4,a5,a6		;MIX THE PULSE OSCILLATORS
	amix	reson	amix,5000*octave(gktune3),5000,1	;BANDPASS FILTER THE MIXTURE
	amix	buthp	amix,5000			;HIGHPASS FILTER THE SOUND...
	amix	buthp	amix,5000			;...AND AGAIN
	amix	=	amix*aenv			;APPLY THE AMPLITUDE ENVELOPE
	
	;NOISE ELEMENT
	anoise	noise	0.8,0				;GENERATE SOME WHITE NOISE
	aenv	linseg	1,p3-0.05,0.1,0.05,0		;CREATE AN AMPLITUDE ENVELOPE
	kcf	expseg	20000,0.7,9000,p3-0.1,9000	;CREATE A CUTOFF FREQ. ENVELOPE
	anoise	butlp	anoise,kcf			;LOWPASS FILTER THE NOISE SIGNAL
	anoise	buthp	anoise,8000			;HIGHPASS FILTER THE NOISE SIGNAL
	anoise	=	anoise*aenv			;APPLY THE AMPLITUDE ENVELOPE
	
	;MIX PULSE OSCILLATOR AND NOISE COMPONENTS
	amix	=	(amix+anoise)*gklevel3*p4*0.55*gklevel
	aL,aR	pan2	amix,gkpan3			;PAN MONOPHONIC SIGNAL
		outs	aL,aR				;SEND TO OUTPUTS
endin

instr	104	;CLOSED HIGH HAT
	kFrq1	=	296*octave(gktune4) 	;FREQUENCIES OF THE 6 OSCILLATORS
	kFrq2	=	285*octave(gktune4) 	
	kFrq3	=	365*octave(gktune4) 	
	kFrq4	=	348*octave(gktune4) 	
	kFrq5	=	420*octave(gktune4) 	
	kFrq6	=	835*octave(gktune4) 	
	idur	=	0.088*i(gkdur4)		;DURATION OF THE NOTE
	p3	limit	idur,0.1,10		;LIMIT THE MINIMUM DURATION OF THE NOTE (VERY SHORT NOTES CAN RESULT IN THE INDICATOR LIGHT ON-OFF NOTE BEING TO0 SHORT)

	iactive	active	p1-1			;SENSE ACTIVITY OF PREVIOUS INSTRUMENT (OPEN HIGH HAT) 
	if iactive>0 then			;IF 'OPEN HIGH HAT' IS ACTIVE...
	 turnoff2	p1-1,0,0		;TURN IT OFF (CLOSED HIGH HAT TAKES PRESIDENCE)
	 chnset	gkoff,"Act3"       	;TURN OFF ACTIVE LIGHT FOR OPEN HIGH HAT
	endif

	;PITCHED ELEMENT
	aenv	expsega	1,idur,0.001,1,0.001		;AMPLITUDE ENVELOPE FOR THE PULSE OSCILLATORS
	ipw	=	0.25				;PULSE WIDTH
	a1	vco2	0.5,kFrq1,2,ipw			;PULSE OSCILLATORS...			
	a2	vco2	0.5,kFrq2,2,ipw
	a3	vco2	0.5,kFrq3,2,ipw
	a4	vco2	0.5,kFrq4,2,ipw
	a5	vco2	0.5,kFrq5,2,ipw
	a6	vco2	0.5,kFrq6,2,ipw
	amix	sum	a1,a2,a3,a4,a5,a6		;MIX THE PULSE OSCILLATORS
	amix	reson	amix,5000*octave(gktune4),5000,1	;BANDPASS FILTER THE MIXTURE
	amix	buthp	amix,5000			;HIGHPASS FILTER THE SOUND...
	amix	buthp	amix,5000			;...AND AGAIN
	amix	=	amix*aenv			;APPLY THE AMPLITUDE ENVELOPE
	
	;NOISE ELEMENT
	anoise	noise	0.8,0				;GENERATE SOME WHITE NOISE
	aenv	expsega	1,idur,0.001,1,0.001		;CREATE AN AMPLITUDE ENVELOPE
	kcf	expseg	20000,0.7,9000,idur-0.1,9000	;CREATE A CUTOFF FREQ. ENVELOPE
	anoise	butlp	anoise,kcf			;LOWPASS FILTER THE NOISE SIGNAL
	anoise	buthp	anoise,8000			;HIGHPASS FILTER THE NOISE SIGNAL
	anoise	=	anoise*aenv			;APPLY THE AMPLITUDE ENVELOPE
	
	;MIX PULSE OSCILLATOR AND NOISE COMPONENTS
	amix	=	(amix+anoise)*gklevel4*p4*0.55*gklevel
	aL,aR	pan2	amix,gkpan4			;PAN MONOPHONIC SIGNAL
		outs	aL,aR				;SEND TO OUTPUTS
endin

instr	105	;HIGH TOM
	ifrq     	=	200 * octave(i(gktune5))	;FREQUENCY
	p3	  	=	0.5 * i(gkdur5)			;DURATION OF THIS NOTE

	;SINE TONE SIGNAL
	aAmpEnv	transeg	1,p3,-10,0.001				;AMPLITUDE ENVELOPE FOR SINE TONE SIGNAL
	afmod	expsega	5,0.125/ifrq,1,1,1			;FREQUENCY MODULATION ENVELOPE. GIVES THE TONE MORE OF AN ATTACK.
	asig	oscili	-aAmpEnv*0.6,ifrq*afmod,gisine		;SINE TONE SIGNAL

	;NOISE SIGNAL
	aEnvNse	transeg	1,p3,-6,0.001				;AMPLITUDE ENVELOPE FOR NOISE SIGNAL
	anoise	noise	1, 0.4			;GENERATE NOISE SIGNAL
	anoise	reson	anoise,400*octave(i(gktune5)),800,1	;BANDPASS FILTER THE NOISE SIGNAL
	anoise	buthp	anoise,100*octave(i(gktune5))		;HIGHPASS FILTER THE NOSIE SIGNAL
	anoise	butlp	anoise,1000*octave(i(gktune5))		;LOWPASS FILTER THE NOISE SIGNAL
	anoise	=	anoise * aEnvNse			;SCALE NOISE SIGNAL WITH AMPLITUDE ENVELOPE
	
	;MIX THE TWO SOUND COMPONENTS
	amix	=	(asig + anoise)*gklevel5*p4*gklevel
	aL,aR	pan2	amix,gkpan5				;PAN MONOPHONIC SIGNAL
		outs	aL,aR					;SEND AUDIO TO OUTPUTS
endin

instr	106	;MID TOM
	ifrq     	=	133*octave(i(gktune6)) 		;FREQUENCY
	p3	  	=	0.6 * i(gkdur6)			;DURATION OF THIS NOTE

	;SINE TONE SIGNAL
	aAmpEnv	transeg	1,p3,-10,0.001				;AMPLITUDE ENVELOPE FOR SINE TONE SIGNAL
	afmod	expsega	5,0.125/ifrq,1,1,1			;FREQUENCY MODULATION ENVELOPE. GIVES THE TONE MORE OF AN ATTACK.
	asig	oscili	-aAmpEnv*0.6,ifrq*afmod,gisine		;SINE TONE SIGNAL

	;NOISE SIGNAL
	aEnvNse	transeg	1,p3,-6,0.001				;AMPLITUDE ENVELOPE FOR NOISE SIGNAL
	anoise	noise	1, 0.4				;GENERATE NOISE SIGNAL
	anoise	reson	anoise, 400*octave(i(gktune6)),800,1	;BANDPASS FILTER THE NOISE SIGNAL
	anoise	buthp	anoise,100*octave(i(gktune6))		;HIGHPASS FILTER THE NOSIE SIGNAL
	anoise	butlp	anoise,600*octave(i(gktune6))		;LOWPASS FILTER THE NOISE SIGNAL
	anoise	=	anoise * aEnvNse			;SCALE NOISE SIGNAL WITH AMPLITUDE ENVELOPE
	
	;MIX THE TWO SOUND COMPONENTS
	amix	=	(asig + anoise)*gklevel6*p4*gklevel
	aL,aR	pan2	amix,i(gkpan6)				;PAN MONOPHONIC SIGNAL
		outs	aL,aR					;SEND AUDIO TO OUTPUTS
endin

instr	107	;LOW TOM
	ifrq     	=	90 * octave(i(gktune7))	;FREQUENCY
	p3 	 	=	0.7*i(gkdur7) 		;DURATION OF THIS NOTE

	;SINE TONE SIGNAL
	aAmpEnv	transeg	1,p3,-10,0.001				;AMPLITUDE ENVELOPE FOR SINE TONE SIGNAL
	afmod	expsega	5,0.125/ifrq,1,1,1			;FREQUENCY MODULATION ENVELOPE. GIVES THE TONE MORE OF AN ATTACK.
	asig	oscili	-aAmpEnv*0.6,ifrq*afmod,gisine		;SINE TONE SIGNAL

	;NOISE SIGNAL
	aEnvNse	transeg	1,p3,-6,0.001				;AMPLITUDE ENVELOPE FOR NOISE SIGNAL
	anoise	noise	1,0.4				;GENERATE NOISE SIGNAL
	anoise	reson	anoise,40*octave(gktune7),800,1		;BANDPASS FILTER THE NOISE SIGNAL
	anoise	buthp	anoise,100*octave(i(gktune7))		;HIGHPASS FILTER THE NOSIE SIGNAL
	anoise	butlp	anoise,600*octave(i(gktune7))		;LOWPASS FILTER THE NOISE SIGNAL
	anoise	=	anoise * aEnvNse			;SCALE NOISE SIGNAL WITH AMPLITUDE ENVELOPE
	
	;MIX THE TWO SOUND COMPONENTS
	amix	=	(asig + anoise)*gklevel7*p4*gklevel
	aL,aR	pan2	amix,i(gkpan7)				;PAN MONOPHONIC SIGNAL
		outs	aL,aR					;SEND AUDIO TO OUTPUTS
endin

instr	108	;CYMBAL
	kFrq1	=	296*octave(gktune8) 	;FREQUENCIES OF THE 6 OSCILLATORS
	kFrq2	=	285*octave(gktune8)
	kFrq3	=	365*octave(gktune8)
	kFrq4	=	348*octave(gktune8)     
	kFrq5	=	420*octave(gktune8)
	kFrq6	=	835*octave(gktune8)
	p3	=	2*i(gkdur8)		;DURATION OF THE NOTE

	;SOUND CONSISTS OF 6 PULSE OSCILLATORS MIXED WITH A NOISE COMPONENT
	;PITCHED ELEMENT
	aenv	expon	1,p3,0.0001		;AMPLITUDE ENVELOPE FOR THE PULSE OSCILLATORS 
	ipw	=	0.25			;PULSE WIDTH      
	a1	vco2	0.5,kFrq1,2,ipw		;PULSE OSCILLATORS...  
	a2	vco2	0.5,kFrq2,2,ipw
	a3	vco2	0.5,kFrq3,2,ipw
	a4	vco2	0.5,kFrq4,2,ipw
	a5	vco2	0.5,kFrq5,2,ipw                                                                   
	a6	vco2	0.5,kFrq6,2,ipw
	amix	sum	a1,a2,a3,a4,a5,a6		;MIX THE PULSE OSCILLATORS
	amix	reson	amix,5000 *octave(gktune8),5000,1	;BANDPASS FILTER THE MIXTURE
	amix	buthp	amix,10000			;HIGHPASS FILTER THE SOUND
	amix	butlp	amix,12000			;LOWPASS FILTER THE SOUND...
	amix	butlp	amix,12000			;AND AGAIN...
	amix	=	amix*aenv			;APPLY THE AMPLITUDE ENVELOPE
	
	;NOISE ELEMENT
	anoise	noise	0.8,0				;GENERATE SOME WHITE NOISE
	aenv	expsega	1,0.3,0.07,p3-0.1,0.00001	;CREATE AN AMPLITUDE ENVELOPE
	kcf	expseg	14000,0.7,7000,p3-0.1,5000	;CREATE A CUTOFF FREQ. ENVELOPE
	anoise	butlp	anoise,kcf			;LOWPASS FILTER THE NOISE SIGNAL
	anoise	buthp	anoise,8000			;HIGHPASS FILTER THE NOISE SIGNAL
	anoise	=	anoise*aenv			;APPLY THE AMPLITUDE ENVELOPE            

	;MIX PULSE OSCILLATOR AND NOISE COMPONENTS
	amix	=	(amix+anoise)*gklevel8*p4*0.85*gklevel
	aL,aR	pan2	amix,i(gkpan8)			;PAN MONOPHONIC SIGNAL
		outs	aL,aR				;SEND TO OUTPUTS
endin

instr	109	;RIM SHOT
	idur 	=	0.027*i(gkdur9) 		;NOTE DURATION
	p3	limit	idur,0.1,10			;LIMIT THE MINIMUM DURATION OF THE NOTE (VERY SHORT NOTES CAN RESULT IN THE INDICATOR LIGHT ON-OFF NOTE BEING TO0 SHORT)

	;RING
	aenv1	expsega	1,idur,0.001,1,0.001		;AMPLITUDE ENVELOPE FOR SUSTAIN ELEMENT OF SOUND
	ifrq1	=	1700*octave(i(gktune9))		;FREQUENCY OF SUSTAIN ELEMENT OF SOUND
	aring	oscili	1,ifrq1,giTR808RimShot,0		;CREATE SUSTAIN ELEMENT OF SOUND	
	aring	butbp	aring,ifrq1,ifrq1*8	
	aring	=	aring*(aenv1-0.001)*0.5			;APPLY AMPLITUDE ENVELOPE

	;NOISE
	anoise	noise	1,0					;CREATE A NOISE SIGNAL
	aenv2	expsega	1, 0.002, 0.8, 0.005, 0.5, idur-0.002-0.005, 0.0001, 1, 0.0001	;CREATE AMPLITUDE ENVELOPE
	anoise	buthp	anoise,800			;HIGHPASS FILTER THE NOISE SOUND
	kcf	expseg	4000,p3,20				;CUTOFF FREQUENCY FUNCTION FOR LOWPASS FILTER
	anoise	butlp	anoise,kcf			;LOWPASS FILTER THE SOUND
	anoise	=	anoise*(aenv2-0.001)	;APPLY ENVELOPE TO NOISE SIGNAL

	;MIX
	amix	=	(aring+anoise)*gklevel9*p4*0.8*gklevel
	aL,aR	pan2	amix,gkpan9			;PAN MONOPHONIC SIGNAL  
		outs	aL,aR				;SEND TO OUTPUTS
endin

instr	110	;CLAVES
	ifrq	=	2500*octave(i(gktune10))	;FREQUENCY OF OSCILLATOR
	idur	=	0.045 	* i(gkdur10)		;DURATION OF THE NOTE
	p3	limit	idur,0.1,10			;LIMIT THE MINIMUM DURATION OF THE NOTE (VERY SHORT NOTES CAN RESULT IN THE INDICATOR LIGHT ON-OFF NOTE BEING TO0 SHORT)			
	aenv	expsega	1,idur,0.001,1,0.001		;AMPLITUDE ENVELOPE
	afmod	expsega	3,0.00005,1,1,1			;FREQUENCY MODULATION ENVELOPE. GIVES THE SOUND A LITTLE MORE ATTACK.
	asig	oscili	-(aenv-0.001),ifrq*afmod,gisine,0	;AUDIO OSCILLATOR
	asig	=	asig*0.4*gklevel10*p4*gklevel		;RESCALE AMPLITUDE
	aL,aR	pan2	asig,gkpan10			;PAN MONOPHONIC AUDIO SIGNAL
		outs	aL,aR				;SEND AUDIO TO OUTPUTS
endin

instr	111	;COWBELL
	ifrq1	=	562 * octave(i(gktune11))	;FREQUENCIES OF THE TWO OSCILLATORS
	ifrq2	=	845 * octave(i(gktune11))	;
	ipw  	=	0.5 				;PULSE WIDTH OF THE OSCILLATOR	
	idur 	=	0.7 				;NOTE DURATION
	ishp 	=	-30 	
	idur 	=	0.7 				;NOTE DURATION
	p3	=	idur*i(gkdur11)			;LIMIT THE MINIMUM DURATION OF THE NOTE (VERY SHORT NOTES CAN RESULT IN THE INDICATOR LIGHT ON-OFF NOTE BEING TO0 SHORT)
	ishape	=	-30				;SHAPE OF THE CURVES IN THE AMPLITUDE ENVELOPE
	kenv1	transeg	1,p3*0.3,ishape,0.2, p3*0.7,ishape,0.2	;FIRST AMPLITUDE ENVELOPE - PRINCIPALLY THE ATTACK OF THE NOTE
	kenv2	expon	1,p3,0.0005				;SECOND AMPLITUDE ENVELOPE - THE SUSTAIN PORTION OF THE NOTE
	kenv	=	kenv1*kenv2			;COMBINE THE TWO ENVELOPES
	itype	=	2				;WAVEFORM FOR VCO2 (2=PULSE)
	a1	vco2	0.65,ifrq1,itype,ipw		;CREATE THE TWO OSCILLATORS
	a2	vco2	0.65,ifrq2,itype,ipw
	amix	=	a1+a2				;MIX THE TWO OSCILLATORS 
	iLPF2	=	10000				;LOWPASS FILTER RESTING FREQUENCY
	kcf	expseg	12000,0.07,iLPF2,1,iLPF2	;LOWPASS FILTER CUTOFF FREQUENCY ENVELOPE
	alpf	butlp	amix,kcf			;LOWPASS FILTER THE MIX OF THE TWO OSCILLATORS (CREATE A NEW SIGNAL)
	abpf	reson	amix, ifrq2, 25			;BANDPASS FILTER THE MIX OF THE TWO OSCILLATORS (CREATE A NEW SIGNAL)
	amix	dcblock2	(abpf*0.06*kenv1)+(alpf*0.5)+(amix*0.9)	;MIX ALL SIGNALS AND BLOCK DC OFFSET
	amix	buthp	amix,700			;HIGHPASS FILTER THE MIX OF ALL SIGNALS
	amix	=	amix*0.08*kenv*p4*gklevel11*gklevel	;RESCALE AMPLITUDE
	aL,aR	pan2	amix,i(gkpan11)			;PAN THE MONOPHONIC AUDIO SIGNAL
		outs	aL,aR				;SEND AUDIO TO OUTPUTS
endin


instr	112	;CLAP
	krelease	release				;SENSE RELEASE OF THIS NOTE ('1' WHEN RELEASED, OTHERWISE ZERO)   
	chnset	1-krelease,"Act12"              	;TURN ON ACTIVE LIGHT WHEN NOTE STARTS, TURN IT OFF WHEN NOTE ENDS
	iTimGap	=	0.01				;GAP BETWEEN EVENTS DURING ATTACK PORTION OF CLAP
	idur1  	=	0.02				;DURING OF THE THREE INITIAL 'CLAPS'
	idur2  	=	2*i(gkdur12)			;DURATION OF THE FOURTH, MAIN, CLAP
	idens  	=	8000				;DENSITY OF THE NOISE SIGNAL USED TO FORM THE CLAPS
	iamp1  	=	0.5				;AMPLITUDE OF AUDIO BEFORE BANDPASS FILTER IN OUTPUT
	iamp2  	=	1				;AMPLITUDE OF AUDIO AFTER BANDPASS FILTER IN OUTPUT
	if frac(p1)==0 then				;IF THIS IS THE INITIAL NOTE (p1 WILL BE AN INTEGER)
	 ;	        del.  dur  env.shape
	 event_i	"i", p1+0.1, 0,          idur1, p4	;CALL THIS INSTRUMENT 4 TIMES. ADD A FRACTION ONTO p1 TO BE ABLE TO DIFFERENTIATE THESE SUBSEQUENT NOTES
	 event_i	"i", p1+0.1, iTimGap,    idur1, p4
	 event_i	"i", p1+0.1, iTimGap*2,  idur1, p4
	 event_i	"i", p1+0.1, iTimGap*3,  idur2, p4
	else
	 kenv	transeg	1,p3,-25,0				;AMPLITUDE ENVELOPE
	 iamp	random	0.7,1					;SLIGHT RANDOMISATION OF AMPLITUDE	
	 anoise	pinkish	kenv*iamp
	 iBPF   	=	1100*octave(i(gktune12))	;FREQUENCY OF THE BANDPASS FILTER
	 ibw    	=	2000*octave(i(gktune12))	;BANDWIDTH OF THE BANDPASS FILTER
	 iHPF   	=	1000				;FREQUENCY OF A HIGHPASS FILTER
	 iLPF   	=	1				;SCALER FOR FREQUENCY OF A LOWPASS FILTER
	 kcf	expseg	8000,0.07,1700,1,800,2,500,1,500	;CREATE CUTOFF FREQUENCY ENVELOPE
	 asig	butlp	anoise,kcf*iLPF				;LOWPASS FILTER THE SOUND
	 asig	buthp	asig,iHPF				;HIGHPASS FILTER THE SOUND
	 ares	reson	asig,iBPF,ibw,1				;BANDPASS FILTER THE SOUND (CREATE A NEW SIGNAL)
	 asig	dcblock2	(asig*iamp1)+(ares*iamp2)	;MIX BANDPASS FILTERED AND NON-BANDPASS FILTERED SOUND ELEMENTS
	 asig	=	asig*p4*i(gklevel12)*1.75*gklevel	;SCALE AMPLITUDE
	 aL,aR	pan2	asig,i(gkpan12)				;PAN MONOPHONIC SIGNAL
		outs	aL,aR					;SEND AUDIO TO OUTPUTS
	endif
endin



instr	113	;MARACA
	idur	=	0.07*i(gkdur13)		;DURATION 3
	p3	limit	idur,0.1,10			;LIMIT THE MINIMUM DURATION OF THE NOTE (VERY SHORT NOTES CAN RESULT IN THE INDICATOR LIGHT ON-OFF NOTE BEING TO0 SHORT)
	iHPF 	limit	6000*octave(i(gktune13)),20,sr/2	;HIGHPASS FILTER FREQUENCY	
	iLPF 	limit	12000*octave(i(gktune13)),20,sr/3	;LOWPASS FILTER FREQUENCY. (LIMIT MAXIMUM TO PREVENT OUT OF RANGE VALUES)
	;AMPLITUDE ENVELOPE
	iBP1 	=	0.4			;BREAK-POINT 1
	iDur1	=	0.014*i(gkdur13) 		;DURATION 1
	iBP2 	=	1			;BREAKPOINT 2
	iDur2	=	0.01 *i(gkdur13)		;DURATION 2
	iBP3 	=	0.05 			;BREAKPOINT 3
	p3	limit	idur,0.1,10			;LIMIT THE MINIMUM DURATION OF THE NOTE (VERY SHORT NOTES CAN RESULT IN THE INDICATOR LIGHT ON-OFF NOTE BEING TO0 SHORT)
	aenv	expsega	iBP1,iDur1,iBP2,iDur2,iBP3	;CREATE AMPLITUDE ENVELOPE
	anoise	noise	0.75,0			;CREATE A NOISE SIGNAL
	anoise	buthp	anoise,iHPF			;HIGHPASS FILTER THE SOUND
	anoise	butlp	anoise,iLPF			;LOWPASS FILTER THE SOUND
	anoise	=	anoise*aenv*p4*gklevel13*gklevel	;SCALE THE AMPLITUDE
	aL,aR	pan2	anoise,i(gkpan13)		;PAN THE MONOPONIC SIGNAL
		outs	aL,aR			;SEND AUDIO TO OUTPUTS
endin

instr	114	;HIGH CONGA
	ifrq  	=	420*octave(i(gktune14))		;FREQUENCY OF NOTE
	p3  	=	0.22*i(gkdur14)		;DURATION OF NOTE
	aenv	transeg	0.7,1/ifrq,1,1,p3,-6,0.001	;AMPLITUDE ENVELOPE
	afrq	expsega	ifrq*3,0.25/ifrq,ifrq,1,ifrq	;FREQUENCY ENVELOPE (CREATE A SHARPER ATTACK)
	asig	oscili	-aenv*0.25,afrq,gisine		;CREATE THE AUDIO OSCILLATOR
	asig	=	asig*p4*gklevel14*gklevel	;SCALE THE AMPLITUDE
	aL,aR	pan2	asig,gkpan14		;PAN THE MONOPHONIC AUDIO SIGNAL
		outs	aL,aR			;SEND AUDIO TO THE OUTPUTS
endin

instr	115	;MID CONGA
	ifrq   	=	310*octave(i(gktune15))		;FREQUENCY OF NOTE
	p3   	=	0.33*i(gkdur15)		;DURATION OF NOTE
	aenv	transeg	0.7,1/ifrq,1,1,p3,-6,0.001	;AMPLITUDE ENVELOPE	
	afrq	expsega	ifrq*3,0.25/ifrq,ifrq,1,ifrq	;FREQUENCY ENVELOPE (CREATE A SHARPER ATTACK)
	asig	oscili	-aenv*0.25,afrq,gisine		;CREATE THE AUDIO OSCILLATOR
	asig	=	asig*p4*gklevel15*gklevel	;SCALE THE AMPLITUDE
	aL,aR	pan2	asig,gkpan15		;PAN THE MONOPHONIC AUDIO SIGNAL
		outs	aL,aR			;SEND AUDIO TO THE OUTPUTS
endin

instr	116	;LOW CONGA
	ifrq   	=	227*octave(i(gktune16))		;FREQUENCY OF NOTE
	p3   	=	0.41*i(gkdur16)			;DURATION OF NOTE 	
	aenv	transeg	0.7,1/ifrq,1,1,p3,-6,0.001	;AMPLITUDE ENVELOPE	
	afrq	expsega	ifrq*3,0.25/ifrq,ifrq,1,ifrq	;FREQUENCY ENVELOPE (CREATE A SHARPER ATTACK)
	asig	oscili	-aenv*0.25,afrq,gisine		;CREATE THE AUDIO OSCILLATOR
	asig	=	asig*p4*gklevel16*gklevel	;SCALE THE AMPLITUDE
	aL,aR	pan2	asig,gkpan16			;PAN THE MONOPHONIC AUDIO SIGNAL
		outs	aL,aR				;SEND AUDIO TO THE OUTPUTS
endin

instr 200
	 tablecopy	giOn1,	giblank	 ;copy blank table over existing sequence for voice 1
	 tablecopy	giOn2,	giblank	 ;repeat for every other voice
	 tablecopy	giOn3,	giblank	 
	 tablecopy	giOn4,	giblank	 
	 tablecopy	giOn5,	giblank	 
	 tablecopy	giOn6,	giblank	 
	 tablecopy	giOn7,	giblank	 
	 tablecopy	giOn8,	giblank	 
	 tablecopy	giOn9,	giblank	 
	 tablecopy	giOn10,	giblank	 
	 tablecopy	giOn11,	giblank	 
	 tablecopy	giOn12,	giblank	 
	 tablecopy	giOn13,	giblank	 
	 tablecopy	giOn14,	giblank	 
	 tablecopy	giOn15,	giblank	 
	 tablecopy	giOn16,	giblank	 
	 tablecopy	giAcc1,	giblank	 
	 tablecopy	giAcc2,	giblank	 
	 tablecopy	giAcc3,	giblank	 
	 tablecopy	giAcc4,	giblank	 
	 tablecopy	giAcc5,	giblank	 
	 tablecopy	giAcc6,	giblank	 
	 tablecopy	giAcc7,	giblank	 
	 tablecopy	giAcc8,	giblank	 
	 tablecopy	giAcc9,	giblank	 
	 tablecopy	giAcc10,	giblank	 
	 tablecopy	giAcc11,	giblank	 
	 tablecopy	giAcc12,	giblank	 
	 tablecopy	giAcc13,	giblank	 
	 tablecopy	giAcc14,	giblank	 
	 tablecopy	giAcc15,	giblank	 
	 tablecopy	giAcc16,	giblank      
	$UPDATE_SEQUENCE(1)
	$UPDATE_SEQUENCE(2)
	$UPDATE_SEQUENCE(3)
	$UPDATE_SEQUENCE(4)
	$UPDATE_SEQUENCE(5)
	$UPDATE_SEQUENCE(6)
	$UPDATE_SEQUENCE(7)
	$UPDATE_SEQUENCE(8)
	$UPDATE_SEQUENCE(9)
	$UPDATE_SEQUENCE(10)
	$UPDATE_SEQUENCE(11)
	$UPDATE_SEQUENCE(12)
	$UPDATE_SEQUENCE(13)
	$UPDATE_SEQUENCE(14)
	$UPDATE_SEQUENCE(15)
	$UPDATE_SEQUENCE(16)
	$UPDATE_TABLE(1)
	$UPDATE_TABLE(2)
	$UPDATE_TABLE(3)
	$UPDATE_TABLE(4)
	$UPDATE_TABLE(5)
	$UPDATE_TABLE(6)
	$UPDATE_TABLE(7)
	$UPDATE_TABLE(8)
	$UPDATE_TABLE(9)
	$UPDATE_TABLE(10)
	$UPDATE_TABLE(11)
	$UPDATE_TABLE(12)
	$UPDATE_TABLE(13)
	$UPDATE_TABLE(14)
	$UPDATE_TABLE(15)
	$UPDATE_TABLE(16)
endin

instr 201
	SFileName sprintf "TR-808_pattern.%d.txt", i(gkpattern)	;create the file name (string variable) that will be used to name the text file that will contain the pattern data
	print i(gkpattern)
	ftsave SFileName, 1, giOn1, giOn2, giOn3, giOn4, giOn5, giOn6, giOn7, giOn8, giOn9, giOn10, giOn11, giOn12, giOn13, giOn14, giOn15, giOn16, giAcc1, giAcc2, giAcc3, giAcc4, giAcc5, giAcc6, giAcc7, giAcc8, giAcc9, giAcc10, giAcc11, giAcc12, giAcc13, giAcc14, giAcc15, giAcc16	;save all tables (on information and accents) to a text file in the pwd
            Sfile sprintf "snapshot_simple.%d.snap", i(gkpattern)
            inumsnap, inumval FLsetsnap 0
            FLsavesnap Sfile   
endin

instr 202
	SFileName sprintf "TR-808_pattern.%d.txt", i(gkpattern)	;create the file name (string variable) that will be the name of the file from which data will be retrieved
	ftload SFileName, 1, giOn1, giOn2, giOn3, giOn4, giOn5, giOn6, giOn7, giOn8, giOn9, giOn10, giOn11, giOn12, giOn13, giOn14, giOn15, giOn16, giAcc1, giAcc2, giAcc3, giAcc4, giAcc5, giAcc6, giAcc7, giAcc8, giAcc9, giAcc10, giAcc11, giAcc12, giAcc13, giAcc14, giAcc15, giAcc16	;load all tables (on information and accents) to a text file in the pwd
            Sfile sprintf "snapshot_simple.%d.snap", i(gkpattern)
            FLloadsnap Sfile
            inumload FLgetsnap 0            
	$UPDATE_SEQUENCE(1)
	$UPDATE_SEQUENCE(2)
	$UPDATE_SEQUENCE(3)
	$UPDATE_SEQUENCE(4)
	$UPDATE_SEQUENCE(5)
	$UPDATE_SEQUENCE(6)
	$UPDATE_SEQUENCE(7)
	$UPDATE_SEQUENCE(8)
	$UPDATE_SEQUENCE(9)
	$UPDATE_SEQUENCE(10)
	$UPDATE_SEQUENCE(11)
	$UPDATE_SEQUENCE(12)
	$UPDATE_SEQUENCE(13)
	$UPDATE_SEQUENCE(14)
	$UPDATE_SEQUENCE(15)
	$UPDATE_SEQUENCE(16)
	$UPDATE_TABLE(1)
	$UPDATE_TABLE(2)
	$UPDATE_TABLE(3)
	$UPDATE_TABLE(4)
	$UPDATE_TABLE(5)
	$UPDATE_TABLE(6)
	$UPDATE_TABLE(7)
	$UPDATE_TABLE(8)
	$UPDATE_TABLE(9)
	$UPDATE_TABLE(10)
	$UPDATE_TABLE(11)
	$UPDATE_TABLE(12)
	$UPDATE_TABLE(13)
	$UPDATE_TABLE(14)
	$UPDATE_TABLE(15)
	$UPDATE_TABLE(16)
endin

instr	203	;set pattern on/off and accents initial state
	iftlen	=	ftlen(giOn1+i(gksound))		; length of pattern
	icount	init	1				; counter starting value
	loop:						; loop begin label
	iOnOff	table	icount-1,giOn1+i(gksound)	; read on/off state for this step of the pattern
	iAcc	table	icount-1,giAcc1+i(gksound)	; read accent state for this step of the pattern
	FLsetVal_i	iOnOff,gihOn1+icount-1		; set widget
	FLsetVal_i	iAcc,gihAcc1+icount-1		; set widget
	loop_lt	icount,1,iftlen,loop			; loop back for each step of the pattern
endin


instr 1000
  exitnow
endin

</CsInstruments>

<CsScore>
f 0 3600
i 203 0 0.001	; set pattern on/off and accents initial state
e
</CsScore>

</CsoundSynthesizer>
