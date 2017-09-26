;WRITTEN BY IAIN MCCURDY, 2010

<CsoundSynthesizer>

<CsOptions>
-odevaudio -b200 -M0 -+rtmidi=virtual --nodisplays -m0
</CsOptions>

<CsInstruments>

sr 	= 	44100  
ksmps 	= 	100
nchnls 	= 	2
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0	;SET INTERFACE COLOURS
FLpanel	"Rhythmicon", 500, 710, 0, 0

;VALUE DISPLAY BOXES				WIDTH | HEIGHT | X |  Y
idrate			FLvalue	" ",     	60,       20,    5,  45
idfund			FLvalue	" ",     	60,       20,    5,  95
idgain			FLvalue	" ",     	60,       20,    5, 145
iddur			FLvalue	" ",     	60,       20,  160, 195
idrefl			FLvalue	" ",     	60,       20,    5, 585
idVCOres		FLvalue	" ",     	60,       20,    5, 635
idVCOcf			FLvalue	" ",     	60,       20,    5, 685

;								MIN   |    MAX | EXP | TYPE |    DISP   | WIDTH | HEIGHT | X | Y
gkrate, ihrate		FLslider 	"Fundemental Rate",	0.1,        2,    0,    23,     idrate,    490,     25,    5, 20
gkfund, ihfund		FLslider 	"Fundemental Pitch",	20,      2000,   -1,    23,     idfund,    490,     25,    5, 70
gkgain, ihgain		FLslider 	"Gain",			0,          1,    0,    23,     idgain,    490,     25,    5,120
gkdur, ihdur		FLslider 	"Note Duration",	0.1,        3,    0,    23,     iddur,     335,     25,  160,170
gkrefl, ihrefl		FLslider 	"Pluck Reflection",	0.001,  0.999,    0,    23,     idrefl,    490,     25,    5,560
gkVCOres, ihVCOres	FLslider 	"VCO Resonance",	0,          1,    0,    23,     idVCOres,  490,     25,    5,610
gkVCOcf, ihVCOcf	FLslider 	"VCO Cutoff",		100,    10000,   -1,    23,     idVCOcf,   490,     25,    5,660

;COUNTERS								MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X  | Y  | OPCODE
gkStartNote, ihStartNote 	FLcount  	"Starting Note (MIDI)", 0,    127,    1,     12,      1,    140,      25,   15, 170,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)

;BUTTON BANKS					TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkvoice, ihvoice		FLbutBank	14,     1,     2,     18,      40,   55,480,   -1
gkwave, ihwave			FLbutBank	14,     1,     3,     18,      60,  255,480,   -1

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"VOICE:", 	1,       6,    14,     50,      20,   5, 480
ih		 	FLbox  	"Pluck",	1,       5,    12,     40,      20,  75, 480
ih		 	FLbox  	"VCO  ", 	1,       5,    12,     40,      20,  75, 500
ih		 	FLbox  	"VCO WAVE:", 	1,       6,    14,     80,      20, 175, 480
ih		 	FLbox  	"Saw   ",	1,       5,    12,     40,      20, 275, 480
ih		 	FLbox  	"Square", 	1,       5,    12,     40,      20, 275, 500
ih		 	FLbox  	"Tri.  ", 	1,       5,    12,     40,      20, 275, 520
                                        
                                     
FLcolor2	255, 255, 50	;SET SECONDARY COLOUR
ix	=	10                      
iwidth	=	50                   
iheight	=	100                  
iy	=	350                     
itype	=	2                    
FLcolor		255, 255, 255	;SET PRIMARY COLOUR
FLcolor2	255, 255, 50	;SET SECONDARY COLOUR
;FLlabel isize, ifont, ialign, ired, igreen, iblue
FLlabel    14,    1,      1,    0,     0,     0	;MAKE LABELS BLACK
;SWITCHES                                	ON | OFF | TYPE |  WIDTH | HEIGHT   | X | Y  | OPCODE | INS | STARTTIM | DUR | p4
gkC,ihC			FLbutton	"1",	1,    0,  itype,  iwidth,  iheight,  ix, iy,    0,      11,      0,      -1, 1
ix = ix + iwidth
gkD,ihD			FLbutton	"3",	1,    0,  itype,  iwidth,  iheight,  ix,  iy,   0,      13,      0,      -1, 3
ix = ix + iwidth
gkE,ihE			FLbutton	"5",	1,    0,  itype,  iwidth,  iheight,  ix, iy,    0,      15,      0,      -1, 5
ix = ix + iwidth
gkF,ihF			FLbutton	"6",	1,    0,  itype,  iwidth,  iheight,  ix, iy,    0,      16,      0,      -1, 6
ix = ix + iwidth
gkG,ihG			FLbutton	"8",	1,    0,  itype,  iwidth,  iheight,  ix, iy,    0,      18,      0,      -1, 8
ix = ix + iwidth
gkA,ihA			FLbutton	"10",	1,    0,  itype,  iwidth,  iheight,  ix, iy,    0,      20,      0,      -1, 10
ix = ix + iwidth
gkB,ihB			FLbutton	"12",	1,    0,  itype,  iwidth,  iheight,  ix, iy,    0,      22,      0,      -1, 12
ix = ix + iwidth
gkC2,ihC2		FLbutton	"13",	1,    0,  itype,  iwidth,  iheight,  ix, iy,    0,      23,      0,      -1, 13
ix = ix + iwidth
gkD2,ihD2		FLbutton	"15",	1,    0,  itype,  iwidth,  iheight,  ix, iy,    0,      25,      0,      -1, 15

ix = 35
iy = iy - iheight
FLcolor		0, 0, 0		;SET PRIMARY COLOUR
FLcolor2	255, 255, 50	;SET SECONDARY COLOUR
;FLlabel isize, ifont, ialign, ired, igreen, iblue
FLlabel    14,    1,      1,    255,   255,   255	;MAKE LABELS WHITE
gkCsh,ihCsh		FLbutton	"2",	1,    0,  itype,  iwidth,  iheight,  ix, iy,    0,      12,      0,      -1, 2
ix = ix + iwidth
gkDsh,ihDsh		FLbutton	"4",	1,    0,  itype,  iwidth,  iheight,  ix, iy,    0,      14,      0,      -1, 4
ix = ix + iwidth
ix = ix + iwidth
gkFsh,ihFsh		FLbutton	"7",	1,    0,  itype,  iwidth,  iheight,  ix, iy,    0,      17,      0,      -1, 7
ix = ix + iwidth
gkGsh,ihGsh		FLbutton	"9",	1,    0,  itype,  iwidth,  iheight,  ix, iy,    0,      19,      0,      -1, 9
ix = ix + iwidth
gkAsh,ihAsh		FLbutton	"11",	1,    0,  itype,  iwidth,  iheight,  ix, iy,    0,      21,      0,      -1, 11
ix = ix + iwidth
ix = ix + iwidth
gkCsh2,ihCsh2		FLbutton	"14",	1,    0,  itype,  iwidth,  iheight,  ix, iy,    0,      24,      0,      -1, 14
ix = ix + iwidth
gkDsh2,ihDsh2		FLbutton	"16",	1,    0,  itype,  iwidth,  iheight,  ix, iy,    0,      26,      0,      -1, 16
        
;INITIALIZE VALUATORS
FLsetVal_i	0.5, 	ihrate
FLsetVal_i	0.6, 	ihrefl
FLsetVal_i	50, 	ihfund
FLsetVal_i	0.3, 	ihgain
FLsetVal_i	59, 	ihStartNote
FLsetVal_i	1, 	ihdur
FLsetVal_i	0.1, 	ihVCOres
FLsetVal_i	8000, 	ihVCOcf

FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
FLcolor	255,255,255,0,0,0	;SET PRIMARY AND SECONDARY
;FLlabel isize, ifont, ialign, ired, igreen, iblue
FLlabel    14,    1,      1,    0,      0,     0	;MAKE LABELS BLACK
				FLpanel	" ", 500, 800, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                         Rhythmicon                          ", 	1,      5,     14,    490,    15,     5,  0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"This example is an implmentation of the 'Rhythmicon', an     ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"instrument designed an built by the inventor Leon Theremin   ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"and commissioned by the composer Henry Cowell.               ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"This instrument presented users with a short 17 note         ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"keyboard. The first 16 notes produced a sequence of pitches  ", 	1,      5,     14,    490,    15,     5, 120
ih	  	 	FLbox  	"the fundementals of which followed a harmonic series based on", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"on the pitch produced by the first note. Therefore if the    ", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"first note played 100 Hz, the second played 200 Hz, the third", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"300 Hz, the fourth 400 Hz etc. Each note sounded as a        ", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"rhythmical pulse rising in speed up the keyboard. The ratios ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"of these pulsation speeds ascending the keyboard also        ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"followed the ratios of the harmonic series therefore the     ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"second key played a pulse twice that of the first, the third ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"three time that of the first and so on. The 17th note        ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"produced no sound but instead acted as a switch that added a ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"'syncopation effect' (I am not sure exactly what this means  ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"so I have omitted it from my instrument). More information   ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"on the Rhythmicon can be found by searching on the internet. ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"In my example the fundemental rate of pulsation defaults to  ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"0.5 Hz. The user can modulate this using the 'Rate' slider.  ", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"This example can be played either from a MIDI keyboard or by ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"using the on-screen buttons.                                 ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"The numbers on the FLTK buttons indicate the rhythmic        ", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"subdivisions of that note with respect to the pulsation rate ", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"of the first note. These numbers therefore also indicate the ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"ratios of frequencies of the tones they produce.             ", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"Two methods of tone generation are provided which can be     ", 	1,      5,     14,    490,    15,     5, 560
ih		 	FLbox  	"chosen using the 'VOICE' radio button selector. Firstly a    ", 	1,      5,     14,    490,    15,     5, 580
ih		 	FLbox  	"plucked string physical model can be used (although certain  ", 	1,      5,     14,    490,    15,     5, 600
ih		 	FLbox  	"tuning anomalies may be encountered). The reflectivity of the", 	1,      5,     14,    490,    15,     5, 620
ih		 	FLbox  	"fixings at either end of the string (damping) can be changed ", 	1,      5,     14,    490,    15,     5, 640
ih		 	FLbox  	"using the 'Pluck Reflection' slider. Secondly a VCO can be   ", 	1,      5,     14,    490,    15,     5, 660
ih		 	FLbox  	"employed. Waveform, filter cutoff and resonance can be       ", 	1,      5,     14,    490,    15,     5, 680
ih		 	FLbox  	"modulated here.                                              ", 	1,      5,     14,    490,    15,     5, 700
ih		 	FLbox  	"The frequency of the lowest tone that the Rhythmicon will    ", 	1,      5,     14,    490,    15,     5, 720
ih		 	FLbox  	"produce can be set using the 'Fundemental Freq.' slider.     ", 	1,      5,     14,    490,    15,     5, 740
ih		 	FLbox  	"The user can also define the lowest MIDI note that will      ", 	1,      5,     14,    490,    15,     5, 760
ih		 	FLbox  	"activate the Rhythmicon with the 'Starting Note' counter.    ", 	1,      5,     14,    490,    15,     5, 780

				FLpanel_end
		FLrun		;RUN THE WIDGET THREAD!

gisine	ftgen	0,0,131072,10,1

instr	1	;MIDI
	inum	notnum					;READ IN MIDI NOTE NUMBER
	iStartNote	init	i(gkStartNote)		;STARTING NOTE FOR THE RHYTHMICON
	if	inum<=iStartNote	then			;IF A NOTE BELOW THE STARTING NOTE IS PLAYED...
		turnoff					;...IT WILL BE IGNORED AND THIS INSTRUMENT WILL BE TURNED OFF
	endif						;END OF CONDITIONAL BRANCHING
	inum	=	inum - iStartNote		;CREATE A NEW VALUE FOR inum. I.E. COUNTING BEGINS AT RHYTHMICON START NOTE FROM 1
	krate	=	gkrate * inum			;RATE IS A PRODUCT OF RHYTHMICON NOTE COUNT AND 'RATE' SLIDER
	ktrigger	metro	krate			;GENERATE A METRONOME TRIGGER FOR THIS NOTE
	schedkwhen	ktrigger, 0, 0, 30, 0, gkdur, gkfund * inum	;SCHEDULE NOTE PULSE (INSTR 30)
endin

;DEFINE A MACRO FOR AN FLTK TRIGGERED NOTE
#define	FLTK_NOTE(NAME'I)
#	
instr	$I
	if	gk$NAME=0	then			;IF THE BUTTON CORRESPONDING TO THIS NOTE IS OFF...
		turnoff					;TURN INSTRUMENT OFF
	endif						;END OF CONDITIONAL BRANCH
	inum	=	p4				;READ p4 VALUE
	krate	=	gkrate * inum			;RATE IS A PRODUCT OF RHYTHMICON NOTE COUNT AND 'RATE' SLIDER
	ktrigger	metro	krate			;GENERATE A METRONOME TRIGGER FOR THIS NOTE
	schedkwhen	ktrigger, 0, 0, 30, 0, gkdur, gkfund * inum	;SCHEDULE NOTE PULSE (INSTR 30)		
endin
#
;CREATE INSTRUMENTS 11-26 USING A MACRO EXPANSION OF 'FLTK_NOTE' WITH ARGUMENTS
$FLTK_NOTE(C   '11)
$FLTK_NOTE(Csh '12)
$FLTK_NOTE(D   '13)
$FLTK_NOTE(Dsh '14)
$FLTK_NOTE(E   '15)
$FLTK_NOTE(F   '16)
$FLTK_NOTE(Fsh '17)
$FLTK_NOTE(G   '18)
$FLTK_NOTE(Gsh '19)
$FLTK_NOTE(A   '20)
$FLTK_NOTE(Ash '21)
$FLTK_NOTE(B   '22)
$FLTK_NOTE(C2  '23)
$FLTK_NOTE(Csh2'24)
$FLTK_NOTE(D2  '25)
$FLTK_NOTE(Dsh2'26)


instr	30	;SOUND PRODUCING INSTRUMENT
	aenv	linseg	0,0.005,1, p3-0.005, 0		;AMPLITUDE ENVELOPE
	ipick	init	0.1				;PICK-UP POSITION
	iplk	random	0.85,0.98			;PLUCK POSITION
	iamp	init	1				;AMPLITUDE

	if	gkvoice=0	then
		asig 	wgpluck2 iplk, 1, p4, ipick, gkrefl	;PLUCKED STRING PHYSICAL MODEL
		asig	=	asig  * aenv * gkgain		;SCALE AUDIO SIGNAL USING AMPLITUDE ENVELOPE AND OUTPUT GAIN SLIDER
	elseif	gkvoice=1	then
		asig 	vco 	aenv * i(gkgain), p4, i(gkwave)+1, 0.5, gisine
		kcf	expon	i(gkVCOcf),p3,20
		asig	moogvcf	asig, kcf, gkVCOres
	endif
	outs	asig, asig				;SEND AUDIO TO OUTPUTS
endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT TO KEEP REAL-TIME PERFORMANCE GOING FOR 1 HOUR
</CsScore>

</CsoundSynthesizer>