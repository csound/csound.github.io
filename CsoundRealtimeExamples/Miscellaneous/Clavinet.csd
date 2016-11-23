Clavinet.csd
Written by Iain McCurdy, 2013

<CsoundSynthesizer>

<CsOptions>
-odac -dm0 -M0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>

sr 		= 	44100
ksmps 		= 	16
nchnls 		= 	2
0dbfs		=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL        | WIDTH | HEIGHT | X | Y
		FLpanel	"Clavinet",     500,    620,    0,  0
#define	ON_COLOUR #255, 255,  0# 

;SWITCHES								ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkbrilliant,ih			FLbutton	"Brilliant",		1,    0,     2,     75,     60,    5,  5,    -1
FLsetColor2	$ON_COLOUR, ih	;SET SECONDARY COLOUR TO YELLOW
gktreble,ih			FLbutton	"Treble",		1,    0,     2,     75,     60,    5, 75,    -1
FLsetColor2	$ON_COLOUR, ih	;SET SECONDARY COLOUR TO YELLOW
FLsetVal_i	1,ih
gkmedium,ih			FLbutton	"Medium",		1,    0,     2,     75,     60,    5,145,    -1
FLsetColor2	$ON_COLOUR, ih	;SET SECONDARY COLOUR TO YELLOW
gksoft,ih			FLbutton	"Soft",			1,    0,     2,     75,     60,    5,215,    -1
FLsetColor2	$ON_COLOUR, ih	;SET SECONDARY COLOUR TO YELLOW

gkC_D,ih			FLbutton	"C/D",			1,    0,     2,     75,     60,   270,  5,    -1
FLsetColor2	$ON_COLOUR, ih	;SET SECONDARY COLOUR TO YELLOW
FLsetVal_i	1,ih
gkA_B,ih			FLbutton	"A/B",			1,    0,     2,     75,     60,   350,  5,    -1
FLsetColor2	$ON_COLOUR, ih	;SET SECONDARY COLOUR TO YELLOW
FLsetVal_i	1,ih

;VALUE_DISPLAY_BOXES			WIDTH | HEIGHT | X | Y
idfco1		FLvalue	" ",		40,     16,     95, 50
idgain1		FLvalue	" ",		40,     16,    145, 50
idQ1		FLvalue	" ",		40,     16,    195, 50
idfco2		FLvalue	" ",		40,     16,     95,120
idgain2		FLvalue	" ",		40,     16,    145,120
idQ2		FLvalue	" ",		40,     16,    195,120
idfco3		FLvalue	" ",		40,     16,     95,190
idgain3		FLvalue	" ",		40,     16,    145,190
idQ3		FLvalue	" ",		40,     16,    195,190
idfco4		FLvalue	" ",		40,     16,     95,260
idgain4		FLvalue	" ",		40,     16,    145,260
idQ4		FLvalue	" ",		40,     16,    195,260
idpickA		FLvalue	" ",		50,     16,      5,340
idModA		FLvalue	" ",		50,     16,     65,340
idRateA		FLvalue	" ",		50,     16,    125,340
idEnvA		FLvalue	" ",		50,     16,    185,340
idTimeA		FLvalue	" ",		50,     16,    245,340
idpickB		FLvalue	" ",		50,     16,      5,420
idModB		FLvalue	" ",		50,     16,     65,420
idRateB		FLvalue	" ",		50,     16,    125,420
idEnvB		FLvalue	" ",		50,     16,    185,420
idTimeB		FLvalue	" ",		50,     16,    245,420
idRelAmpl	FLvalue	" ",		50,     16,     05,500
idTone		FLvalue	" ",		50,     16,     65,500
idRelDTime	FLvalue	" ",		50,     16,    125,500
idRelDamp	FLvalue	" ",		50,     16,    185,500
idRelATime	FLvalue	" ",		50,     16,    245,500
idplk		FLvalue	" ",		50,     16,     05,580
idSusDamp	FLvalue	" ",		50,     16,     65,580
idHPF		FLvalue	" ",		50,     16,    125,580
idLPF		FLvalue	" ",		50,     16,    185,580
idinharm	FLvalue	" ",		50,     16,    245,580

iscal	ftgen	0,0,1024,-16,20,1024,-8,0
;SLIDERS						MIN | MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y
gklevel, ihlevel	FLslider "Level",		0,     1,  iscal,  24,    -1,     30,     170,  333, 80

;KNOBS							MIN    | MAX | EXP|  TYPE |  DISP    | WIDTH | X  | Y
gkfco1,  ihfco1		FLknob		"FCO.1",	50,     5000,   -1,    4,   idfco1,      30,  100,   5             
gkgain1, ihgain1	FLknob		"Gain.1",	0.5,      30,   -1,    4,   idgain1,     30,  150,   5
gkQ1,    ihQ1		FLknob		"Q.1",		0.5,      30,   -1,    4,   idQ1,        30,  200,   5
gkfco2,  ihfco2		FLknob		"FCO.2",	50,     5000,   -1,    4,   idfco2,      30,  100,  75             
gkgain2, ihgain2	FLknob		"Gain.2",	0.5,      30,   -1,    4,   idgain2,     30,  150,  75
gkQ2,    ihQ2		FLknob		"Q.2",		0.5,      30,   -1,    4,   idQ2,        30,  200,  75
gkfco3,  ihfco3		FLknob		"FCO.3",	50,     5000,   -1,    4,   idfco3,      30,  100, 145             
gkgain3, ihgain3	FLknob		"Gain.3",	0.5,      30,   -1,    4,   idgain3,     30,  150, 145
gkQ3,    ihQ3		FLknob		"Q.3",		0.5,      30,   -1,    4,   idQ3,        30,  200, 145
gkfco4,  ihfco4		FLknob		"FCO.4",	50,     5000,   -1,    4,   idfco4,      30,  100, 215             
gkgain4, ihgain4	FLknob		"Gain.4",	0.5,      30,   -1,    4,   idgain4,     30,  150, 215
gkQ4,    ihQ4		FLknob		"Q.4",		0.5,      30,   -1,    4,   idQ4,        30,  200, 215
gkpickA,  ihpickA	FLknob		"Pick A",	0,         1,    0,    3,   idpickA,     40,   10, 285
gkModA,   ihModA	FLknob		"Mod.A",	0,       0.5,    0,    3,   idModA,      40,   70, 285
gkRateA,   ihRateA	FLknob		"Rate.A",	0.001,    20,    0,    3,   idRateA,     40,  130, 285
gkEnvA,   ihEnvA	FLknob		"Env.A",	0,       0.5,    0,    3,   idEnvA,      40,  190, 285
gkTimeA,   ihTimeA	FLknob		"Time.A",	0,       0.5,    0,    3,   idTimeA,     40,  250, 285
gkpickB,  ihpickB	FLknob		"Pick B",	0,         1,    0,    3,   idpickB,     40,   10, 365
gkModB,   ihModB	FLknob		"Mod.B",	0,       0.5,    0,    3,   idModB,      40,   70, 365
gkRateB,   ihRateB	FLknob		"Rate.B",	0.001,    20,    0,    3,   idRateB,     40,  130, 365
gkEnvB,   ihEnvB	FLknob		"Env.B",	0,       0.5,    0,    3,   idEnvB,      40,  190, 365
gkTimeB,   ihTimeB	FLknob		"Time.B",	0,       0.5,    0,    3,   idTimeB,     40,  250, 365
gkRelAmpl, ihRelAmpl	FLknob		"Ampl.",	0,        20,    0,    4,   idRelAmpl,   40,   10, 445
gkRelTone, ihRelTone	FLknob		"Tone",		100,    8000,    0,    4,   idTone,      40,   70, 445
gkRelDTime, ihRelDTime	FLknob		"D.Time",	0.001,     1,   -1,    4,   idRelDTime,  40,  130, 445
gkRelDamp, ihRelDamp	FLknob		"Damp",		0.1,    0.99,   -1,    4,   idRelDamp,   40,  190, 445
gkRelATime, ihRelATime	FLknob		"A.Time",	0.01,      2,   -1,    4,   idRelATime,  40,  250, 445
gkplk, ihplk		FLknob		"Pluck",	0,         1,    0,    4,   idplk,       40,   10, 525
gkSusDamp, ihSusDamp	FLknob		"Damp",		0,         1,    0,    4,   idSusDamp,   40,   70, 525
gkHPF, ihHPF		FLknob		"HPF",		0,        16,    0,    4,   idHPF,       40,  130, 525
gkLPF, ihLPF		FLknob		"LPF",		1,        72,    0,    4,   idLPF,       40,  190, 525
gkinharm, ihinharm	FLknob		"Inharm.",	-0.99,  0.99,    0,    4,   idinharm,    40,  250, 525

;SET_INITIAL_VALUES	VALUE | HANDLE
FLsetVal_i		0.5,	ihlevel
FLsetVal_i		2500,	ihfco1
FLsetVal_i		3,	ihgain1
FLsetVal_i		1.25,	ihQ1
FLsetVal_i		1000,	ihfco2
FLsetVal_i		2.3,	ihgain2
FLsetVal_i		1,	ihQ2
FLsetVal_i		500,	ihfco3
FLsetVal_i		1.3,	ihgain3
FLsetVal_i		1,	ihQ3
FLsetVal_i		200,	ihfco4
FLsetVal_i		1.4,	ihgain4
FLsetVal_i		2,	ihQ4
FLsetVal_i		0.25,	ihpickA
FLsetVal_i		0.03,	ihModA
FLsetVal_i		0.2,	ihRateA
FLsetVal_i		0,	ihEnvA
FLsetVal_i		0.05,	ihTimeA
FLsetVal_i		0.07,	ihpickB
FLsetVal_i		0.03,	ihModB
FLsetVal_i		0.15,	ihRateB
FLsetVal_i		0,	ihEnvB
FLsetVal_i		0.05,	ihTimeB
FLsetVal_i		0.005,	ihplk
FLsetVal_i		0,	ihSusDamp
FLsetVal_i		0,	ihHPF
FLsetVal_i		72,	ihLPF
FLsetVal_i		2,	ihRelAmpl
FLsetVal_i		1000,	ihRelTone
FLsetVal_i		0.01,	ihRelDTime
FLsetVal_i		0.95,	ihRelDamp
FLsetVal_i		0.05,	ihRelATime
FLsetVal_i		0,	ihinharm

	FLpanel_end                                                                                                       


;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 515, 770, 512, 0
				FLscroll     515, 770, 0, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"     Clavinet - an emulation of the Hohner Clavinet D6       ", 	1,      6,     15,    490,    25,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,  20
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"Pickup Selection                                             ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"----------------                                             ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"CA - neck pickup only (pickup A).                            ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"CB - bridge pickup only (pickup B).                          ", 	1,      5,     14,    490,    20,     5, 120
ih		 	FLbox  	"DA - both pickups in phase.                                  ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"DB - bridge pickup (pickup B) 180 degrees out of phase w.r.t ", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"                                             the neck pickup.", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"Setup                                                        ", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"-----                                                        ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"Pick A - position of the first pickup (range 0 - 1).         ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"                  Typically referred to as the 'neck' pickup.", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"Pick B - position of the second pickup (range 0 - 1).        ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"                Typically referred to as the 'bridge' pickup.", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	" (NB. the relevant pickup has to be 'active' according to the", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	" CD AB switches in order for you to be able to here changes  ", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	" to it pickup position.)                                     ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"Mod.A - the pickup position can also modulated by an LFO.    ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"          This control controls the depth of this modulation.", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"Mod.B - Depth of this modulation for the second pickup       ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"Rate A - Rate of modulation for the first pickup             ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"Rate B - Rate of modulation for the second pickup            ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"Env.A - The pickup position can be modulated by a simple     ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"        single segment envelope. This is typically used to   ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"        add an particular attack nuance to the sound. This   ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"        control controls the initial amplitude of this       ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"        envelope (can be positive or negative). The envelope ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"        always ends at zero.                                 ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"Env.B - Envelope amplitude for the second pickup.            ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"Time A - Duration of the envelope segment for the first      ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"         pickup.                                             ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"Time B - Duration of the envelope segment for the second     ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"         pickup.                                             ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"Pluck - location of the 'pluck' (range 0 - 1). Should be     ", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"        close to zero for a typical clavinet behaviour.      ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"Damp - string vibration damping that is applied while a note ", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"       is being held. String damping is also dependent upon  ", 	1,      5,     14,    490,    20,     5, 780
ih		 	FLbox  	"       the note played using a 'key tracking' function table ", 	1,      5,     14,    490,    20,     5, 800
ih		 	FLbox  	"       'girefl'. In general lower notes should experience    ", 	1,      5,     14,    490,    20,     5, 820
ih		 	FLbox  	"       greater damping.                                      ", 	1,      5,     14,    490,    20,     5, 840
ih		 	FLbox  	"HPF - this controls the cutoff frequency of a highpass filter", 	1,      5,     14,    490,    20,     5, 860
ih		 	FLbox  	"      that the signal passes through.                        ", 	1,      5,     14,    490,    20,     5, 880
ih		 	FLbox  	"      The value supplied here is multiplied by the           ", 	1,      5,     14,    490,    20,     5, 900
ih		 	FLbox  	"      fundemental frequency of the note played to derive the ", 	1,      5,     14,    490,    20,     5, 920
ih		 	FLbox  	"      cutoff frequency.                                      ", 	1,      5,     14,    490,    20,     5, 940
ih		 	FLbox  	"      Therefore if a value of '2' is supplied the cutoff will", 	1,      5,     14,    490,    20,     5, 960
ih		 	FLbox  	"      always by twice the fundemental, i.e. the frequency of ", 	1,      5,     14,    490,    20,     5, 980
ih		 	FLbox  	"      the first harmonic/second partial.                     ", 	1,      5,     14,    490,    20,     5,1000
ih		 	FLbox  	"      This control can be used to remove the emphasis of the ", 	1,      5,     14,    490,    20,     5,1020
ih		 	FLbox  	"      fundemental partial.                                   ", 	1,      5,     14,    490,    20,     5,1040
ih		 	FLbox  	"      If this control is at its minimum setting the filter is", 	1,      5,     14,    490,    20,     5,1060
ih		 	FLbox  	"      bypassed.                                              ", 	1,      5,     14,    490,    20,     5,1080
ih		 	FLbox  	"LPF - behaves in a similar way to HPF but in respect to a    ", 	1,      5,     14,    490,    20,     5,1100
ih		 	FLbox  	"      lowpass filter. This control, if reduced, can be used  ", 	1,      5,     14,    490,    20,     5,1120
ih		 	FLbox  	"      to soften the brightness of a note's attack.           ", 	1,      5,     14,    490,    20,     5,1140
ih		 	FLbox  	"      If this control is at its maximum setting the filter is", 	1,      5,     14,    490,    20,     5,1160
ih		 	FLbox  	"      bypassed.                                              ", 	1,      5,     14,    490,    20,     5,1180
ih		 	FLbox  	"Inharm - applies inharmonicity to the spectrum produced by   ", 	1,      5,     14,    490,    20,     5,1200
ih		 	FLbox  	"         Negative values compress the spectrum, positive     ", 	1,      5,     14,    490,    20,     5,1220
ih		 	FLbox  	"         values expand the spectrum and zero leaves the      ", 	1,      5,     14,    490,    20,     5,1240
ih		 	FLbox  	"         spectrum unaffected.                                ", 	1,      5,     14,    490,    20,     5,1260
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5,1280
ih		 	FLbox  	"Release                                                      ", 	1,      5,     14,    490,    20,     5,1300
ih		 	FLbox  	"-------                                                      ", 	1,      5,     14,    490,    20,     5,1320
ih		 	FLbox  	"   Poorly maintained clavinets exhibit a release 'pluck' as  ", 	1,      5,     14,    490,    20,     5,1340
ih		 	FLbox  	"   the rubber pad which strikes and frets is lifted from the ", 	1,      5,     14,    490,    20,     5,1360
ih		 	FLbox  	"   string when the key is released. The is on account of the ", 	1,      5,     14,    490,    20,     5,1380
ih		 	FLbox  	"   rubber pad wearing out.                                   ", 	1,      5,     14,    490,    20,     5,1400
ih		 	FLbox  	"Ampl - amplitude of the release 'pluck'                      ", 	1,      5,     14,    490,    20,     5,1420
ih		 	FLbox  	"Tone - a tone control applied to the release 'pluck' (this   ", 	1,      5,     14,    490,    20,     5,1440
ih		 	FLbox  	"       will also affect amplitude).                          ", 	1,      5,     14,    490,    20,     5,1460
ih		 	FLbox  	"D.Time - time it takes for full damping to be applied (this  ", 	1,      5,     14,    490,    20,     5,1480
ih		 	FLbox  	"         control has a subtle effect).                       ", 	1,      5,     14,    490,    20,     5,1500
ih		 	FLbox  	"Damp - amount of damping that is applied to string vibrations", 	1,      5,     14,    490,    20,     5,1520
ih		 	FLbox  	"       whenever a key is released (this amount of damping is ", 	1,      5,     14,    490,    20,     5,1540
ih		 	FLbox  	"       achieved after 'D.Time' seconds). Note that the 'Damp'", 	1,      5,     14,    490,    20,     5,1560
ih		 	FLbox  	"       control in the 'Setup' pop-up panel also has an impact", 	1,      5,     14,    490,    20,     5,1580
ih		 	FLbox  	"       upon the release damping.                             ", 	1,      5,     14,    490,    20,     5,1600
ih		 	FLbox  	"A.Time - amplitude release time. If this is too short,       ", 	1,      5,     14,    490,    20,     5,1620
ih		 	FLbox  	"         vibration damping may not be heard and the above    ", 	1,      5,     14,    490,    20,     5,1640
ih		 	FLbox  	"         controls may not appear to do anything.             ", 	1,      5,     14,    490,    20,     5,1660
ih		 	FLbox  	"                                                             ", 	1,      5,     14,    490,    20,     5,1680
ih		 	FLbox  	"Filters                                                      ", 	1,      5,     14,    490,    20,     5,1700
ih		 	FLbox  	"-------                                                      ", 	1,      5,     14,    490,    20,     5,1720
ih		 	FLbox  	"The D6 Clavinet design incorporates four bandpass filters    ", 	1,      5,     14,    490,    20,     5,1740
ih		 	FLbox  	"which can be switched in or out of the circuit.              ", 	1,      5,     14,    490,    20,     5,1760
ih		 	FLbox  	"Emphasising four different frequency bands from high to low, ", 	1,      5,     14,    490,    20,     5,1780
ih		 	FLbox  	"they are named 'brilliant', 'treble', 'medium' and 'soft'    ", 	1,      5,     14,    490,    20,     5,1800
ih		 	FLbox  	"Cutoff frequencies (fco), levels and Q values for each of the", 	1,      5,     14,    490,    20,     5,1820
ih		 	FLbox  	"four filters can be adjusted.                                ", 	1,      5,     14,    490,    20,     5,1840
ih		 	FLbox  	"Obviously the relevant filter has to be activated in order to", 	1,      5,     14,    490,    20,     5,1860
ih		 	FLbox  	"be able to hear changes made to its settings.                ", 	1,      5,     14,    490,    20,     5,1880
ih		 	FLbox  	"The four filters are in a parallel arrangement as opposed to ", 	1,      5,     14,    490,    20,     5,1900
ih		 	FLbox  	"being in series.                                             ", 	1,      5,     14,    490,    20,     5,1920
				FLscrollEnd                                                                                                       
				FLpanel_end                                                                                                       
                                                                                                                                                 
				FLrun	;RUN THE FLTK WIDGET THREAD                                                                              
;END OF FLTK INTERFACE CODE-------------------------------------------------------------------------------------------------------------------------
                                                                                                                                                 
                                                                                                                                                 
                                 
; table used to map of note played to bridge relection
girefl	ftgen	0,0,128,-27, 0,0.4, 36,0.4, 72,0.01, 127,0.01
gisine	ftgen	0,0,4096,10,1    
gitri	ftgen	0,0,4096,7,0,1024,1,2046,-1,1024,0

opcode	FreqShifter,a,aki
	ain,kfshift,ifn	xin					;READ IN INPUT ARGUMENTS
	areal, aimag hilbert ain				;HILBERT OPCODE OUTPUTS TWO PHASE SHIFTED SIGNALS, EACH 90 OUT OF PHASE WITH EACH OTHER
	asin 	oscili       1,    kfshift,     ifn,          0
	acos 	oscili       1,    kfshift,     ifn,          0.25	
	;RING MODULATE EACH SIGNAL USING THE QUADRATURE OSCILLATORS AS MODULATORS
	amod1	=		areal * acos
	amod2	=		aimag * asin	
	;UPSHIFTING OUTPUT
	aFS	= (amod1 - amod2)
		xout	aFS				;SEND AUDIO BACK TO CALLER INSTRUMENT
endop

instr	1                        
ibrilliant	init	i(gkbrilliant)	; filter switch
itreble		init	i(gktreble)	; filter switch
imedium		init	i(gkmedium)	; filter switch
isoft		init	i(gksoft)	; filter switch
iC_D		init	i(gkC_D)	; single/dual pickup selector
iA_B		init	i(gkA_B)	; neck/bridge pickup selector

icps	cpsmidi			; cps read from midi
inum	notnum			; note number read from midi
ivel	veloc		0,1	; velocity read from midi

; pluck position is an i-rate variable so a mechanism is created to re-initialise the instrument if it is changed in realtime
ktrig	changed	gkplk		; if GUI knob changes, generate a trigger
if ktrig==1 then		; if triggered...
 reinit	UPDATE			; reinitialise...
endif				
UPDATE:				; ...from here (until the end of the instrument)
iplk	=	i(gkplk)	; cast k-rate pluck position to i-rate variable

; string vibration damping / reflectivity
irefl	table		inum,girefl			; read reflectivity for this note from function table (lower notes will experience more damping)
iRelDTime	init	i(gkRelDTime)			; release damping time: time for damping state to be established
iRelDamp	init	i(gkRelDamp)			; amount of damping upon release
krefl		linsegr	irefl,iRelDTime,iRelDamp	; upon note release vibrations are damped quickly and dramatically
krefl		limit	krefl+gkSusDamp,0.001,0.999	; limit possible values for reflection/damping to prevent out of range values

iamp	=		ivel*0.3
kenv	expseg		1, 0.01,0.001,1,0.001	; create an amplitude envelope for the noise burst
axcite	pinkish		kenv-0.001		; create a pink noise signal
axcite	tone		axcite,icps*2
krelease	release				; sense release of note
iRelAmpl	init	i(gkRelAmpl)		; release pluck amplitude
iRelTone	init	i(gkRelTone)		; tone of the release pluck
if krelease==1 then				; if key is released...
 axcite	mpulse	iRelAmpl,0			; audio impulse is created as an implementation of the release pluck impulse 
 axcite	butlp	axcite,iRelTone			; lowpass filter the impulse
endif


iEnvA	init		i(gkEnvA)		; pickup position envelope modulation depth
iEnvB	init		i(gkEnvB)
iTimeA	init		i(gkTimeA)		; pickup position envelope modulation time
iTimeB	init		i(gkTimeB)

kenv1	transeg		iEnvA,iTimeA,-4,0		; envelope applied to the pickup position (pickup A)
kenv2	transeg		iEnvB,iTimeB,-4,0		; envelope applied to the pickup position (pickup B)
kmod1	oscili		gkModA,gkRateA,gitri		; lfo used to modulate pickup position (pickup A)
kmod2	oscili		gkModB,gkRateB,gitri		; lfo used to modulate pickup position (pickup B)
kpickA	limit		gkpickA + kmod1 + kenv1, 0, 1	; consolidate pickup position between fixed value, lfo and envelope. Also protect against out of range values. (pickup A)
kpickB	limit		gkpickB + kmod2 + kenv2, 0, 1	; consolidate pickup position between fixed value, lfo and envelope. Also protect against out of range values. (pickup B)

iinharm	init	i(gkinharm)				; inharmonicity of the tone. negative values compress the spectrum, positive values expand it. Compensation will be applied to the fundemental so that it will remain consistent.
iFShift	=	icps*iinharm				; amount of frequency shift (in CPS)

a1 	repluck 	iplk, iamp, icps, kpickA, krefl, axcite	; employ plucked string model (pickup A)
a2 	repluck 	iplk, iamp, icps, kpickB, krefl, axcite	; employ plucked string model (pickup B)

if(iinharm!=0) then				; only apply frequency shifting if inharmonicity is anything other than zero
 a1	FreqShifter	a1,iFShift,gisine	; call frequency shifting UDO
 a2	FreqShifter	a2,iFShift,gisine
endif

if(iC_D==0&&iA_B==0) then	;CA - neck pickup only
 asig	=	a1
elseif(iC_D==0&&iA_B==1) then	;CB - bridge pickup only
 asig	=	a2
elseif(iC_D==1&&iA_B==0) then	;DA - both pickups in phase
 asig	=	a1 + a2
elseif(iC_D==1&&iA_B==1) then	;DB - both pickups. Pickup B 180 degrees out of phase
 asig	=	a1 - a2
endif

; velocity to brightness
icf	=		(ivel*6)+8		; cutoff frequency in 'oct' format
asig	butlp		asig,cpsoct(icf)	; lowpass filter audio signal

amix	=	0	; audio mix of filter outputs (reset to silence upon each iteration)
if(ibrilliant==1) then ; if 'brilliant' selected...
 afilt	rbjeq 	asig, gkfco1, 1, gkQ1, 1, 4		; bandpass filter sound
 amix	=	amix + (afilt * gkgain1)			; add a scaled amount of filtered signal to filter mix signal
endif
if(itreble==1) then ; if 'treble' selected...
 afilt	rbjeq 	asig, gkfco2, 1, gkQ2, 1, 4		; bandpass filter sound                                      
 amix	=	amix + (afilt * gkgain2)                 ; add a scaled amount of filtered signal to filter mix signal
endif	
if(imedium==1) then ; if 'medium' selected...
 afilt	rbjeq 	asig, gkfco3, 1, gkQ3, 1, 4		; bandpass filter sound                                      
 amix	=	amix + (afilt * gkgain3)                 ; add a scaled amount of filtered signal to filter mix signal
endif
if(isoft==1) then ; if 'soft' selected...
 afilt	rbjeq 	asig, gkfco4, 1, gkQ4, 1, 4		; bandpass filter sound                                      
 amix	=	amix + (afilt * gkgain4)                 ; add a scaled amount of filtered signal to filter mix signal
endif
if((ibrilliant + itreble + imedium + isoft)==0) then	; if no filters selected...
 amix	=	asig					; ...just send unfiltered audio to filter section output
endif

if gkHPF>0 then				; if HPF control is greater than 1...
 kcf	limit	icps*gkHPF,20,sr/2	; prevent out of range values which would cause the filter to 'blow up'
 amix	buthp	amix,kcf		; filter tone relative to note fundemental
endif

if gkLPF<72 then				; if LPF control is greater than 1...
 kcf	limit	icps*gkLPF,20,sr/2	; prevent out of range values which would cause the filter to 'blow up'
 amix	butlp	amix,kcf		; filter tone relative to note fundemental
endif

; release envelope
iRelATime	init	i(gkRelATime)	; amplitude release time
aenv		linsegr	1, iRelATime, 0	; amplitude release envelope (senses key release before entering final/only segment)

; output signal
aout	=	amix * aenv * gklevel	; apply release envelope and level control
	outs	aout, aout		; send audio to outputs
endin

</CsInstruments>

<CsScore>
f 0 [60*60*24*7]	; keep performance going for up to a week
</CsScore>

</CsoundSynthesizer>