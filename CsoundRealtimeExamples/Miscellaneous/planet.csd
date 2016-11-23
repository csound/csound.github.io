planet.csd
Written by Iain McCurdy, 2012

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr 	= 	44100  
ksmps 	= 	32
nchnls 	= 	1	
0dbfs	=	1
	seed	0	;RANDOM NUMBER GENERATORS SEEDED FORM SYSTEM CLOCK. ENSURES A DIFFERENT PLANET AND A DIFFERENT GALAXY EACH TIME THE EXAMPLE IS RUN.

giPlanetSize	init	100	;BASIC SIZE FOR PLANET
giPanelWidth	init	500	;WIDTH OF PANEL FOR PLANET VISUALISATION
giPanelHeight	init	500	;HEIGHT OF PANEL FOR PLANET VISUALISATION

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	0, 0, 0, 0, 0, 0
;			LABEL                        |     WIDTH     |    HEIGHT     | X | Y
		FLpanel	"Planet",     giPanelWidth,   giPanelHeight,  0,  0

;CREATE A STAR BACKGROUND (DISABLE OR LIMIT THE NUMBER OF STARS ON LOW POWERED MACHINES)
icount	=	1			;COUNTER USED IN THE STAR CREATION PROCESS
instars	=	100			;NUMBER OF STARS
loop:					;LOOP BACK TO HERE EACH TIME A NEW STAR IS BORN
ix	random	0,giPanelWidth-2	;RANDOM X POSITION
iy	random	0,giPanelWidth-2	;RANDOM Y POSITION
;						TYPE | FONT |   SIZE       | WIDTH | HEIGHT |  X  |  Y
ihstar			 	FLbox  	".", 	1,      14,    2+rnd(15),      0,       0,    ix,   iy	;DRAW A STAR (A FULL STOP). FONT SIZE IS RANDOMIZED SLIGHTLY.
FLsetTextColor	rnd(55)+200,rnd(55)+200,rnd(55)+200,ihstar	;EACH STAR WILL BE COLOURIZED A SLIGHTLY DIFFERENT COLOUR
loop_le	icount,1,instars,loop		;LOOPING PROCESS TO CREATE MANY RANDOMLY PLACED AND SIZED STARS FROM A FEW LINES OF CODE

;CREATE THE PLANET
;							TYPE | FONT | SIZE |     WIDTH     |     HEIGHT       | X  | Y
gihplanet		 	FLbox  	"@circle", 	1,      14,    12,   giPlanetSize,   giPlanetSize,   0,   0	;PLANET IS DRAWN USING ONE OF THE WIDGET LABEL PRESET SHAPES (A CIRCLE)
ired	random	0,255.999			;RANDOM COLOURS FOR PLANET...
igreen	random	0,255.999			;...
iblue	random	0,255.999			;...
FLsetTextColor	ired,igreen,iblue,gihplanet	;COLOURIZE PLANET
FLsetColor	0,0,0,gihplanet			;COLOUR PLANET BACKGROUND BLACK
FLhide	gihplanet				;HIDE PLANET (UNTIL FIRST RE-DRAW IN INSTR 1)
	FLpanel_end	;END OF PANEL CONTENTS


FLcolor	255, 255, 255, ired, igreen, iblue
;		LABEL      | WIDTH | HEIGHT | X | Y
	FLpanel	"controls",   500,    600,  512,  0
;SWITCHES                                           	ON | OFF | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE | INS | STARTTIM | IDUR
gkreset,ihreset		FLbutton	"Reset Orbit",	1,    0,     1,    100,     25,    5,   5,   -1
;VALUE DISPLAY BOXES			WIDTH | HEIGHT | X |  Y
idmass1			FLvalue	" ",    60,       17,    5,   55
idmass2			FLvalue	" ",    60,       17,    5,   95
idsep			FLvalue	" ",    60,       17,    5,  135
idx			FLvalue	" ",    60,       17,    5,  215
idy			FLvalue	" ",    60,       17,    5,  255
idz			FLvalue	" ",    60,       17,    5,  295
idvx			FLvalue	" ",    60,       17,    5,  335
idvy			FLvalue	" ",    60,       17,    5,  375
idvz			FLvalue	" ",    60,       17,    5,  415
idfric			FLvalue	" ",    60,       17,    5,  455
idscale			FLvalue	" ",    60,       17,    5,  495
idamp			FLvalue	" ",    60,       17,    5,  535
idUpdateRate		FLvalue	" ",    60,       17,    5,  575

;VALUE INPUT BOXES			MIN | MAX | STEP   | TYPE | WIDTH | HEIGHT | X  | Y         
gk, gihdelta		FLtext	"", 	0,     1,  0.00001,   1,     60,     17,     5,  175

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)
;BUTTON BANKS						TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
gkSonificationMode, ihSonificationMode	FLbutBank	11,     1,      2,    18,    2*15,   250, 5,  -1
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN
;TEXT BOXES							TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"Sonification Mode:", 		1,       6,    12,    130,     15,   120,  5
ih		 	FLbox  	"Data Sonification  ",		1,       5,    12,    150,     15,   270,  5
ih		 	FLbox  	"Direct Sonification",		1,       5,    12,    150,     15,   270, 20

;SLIDERS									MIN  |   MAX | EXP | TYPE |  DISP        | WIDTH | HEIGHT | X | Y
gkmass1, ihmass1		FLslider 	"Mass 1 (k-rate)",		0.001,   10,   -1,     3,   idmass1,        490,     15,    5, 40
gkmass2, ihmass2		FLslider 	"Mass 2 (k-rate)",		0.001,   10,   -1,     3,   idmass2,        490,     15,    5, 80
gksep, ihsep			FLslider 	"Separation (k-rate)",		0.001,   10,   -1,     3,   idsep,          490,     15,    5,120
gkdelta, ihdelta		FLslider 	"Delta (i-rate)",		0,        1,    0,     3,   -1,             490,     15,    5,160
gkx, ihx			FLslider 	"Init. Coord. X (i-rate)",	-1,       1,    0,     3,   idx,            490,     15,    5,200
gky, ihy			FLslider 	"Init. Coord. Y (i-rate)",	-1,       1,    0,     3,   idy,            490,     15,    5,240
gkz, ihz			FLslider 	"Init. Coord. Z (i-rate)",	-1,       1,    0,     3,   idz,            490,     15,    5,280
gkvx, ihvx			FLslider 	"Init. Vector X (i-rate)",	-1,       1,    0,     3,   idvx,           490,     15,    5,320
gkvy, ihvy			FLslider 	"Init. Vector Y (i-rate)",	-1,       1,    0,     3,   idvy,           490,     15,    5,360
gkvz, ihvz			FLslider 	"Init. Vector Z (i-rate)",	-1,       1,    0,     3,   idvz,           490,     15,    5,400
gkfric, ihfric			FLslider 	"Friction (i-rate)",		0,        4,    0,     3,   idfric,         490,     15,    5,440
gkScalDisp, ihScalDisp		FLslider 	"Scale Display/Data Sonification",	1,      100,   -1,     3,   idscale,        490,     15,    5,480
gkamp, ihamp			FLslider 	"Sonification Amplitude",	0,       1,     0,     3,   idamp,          490,     15,    5,520
gkUpdateRate, ihUpdateRate	FLslider 	"Display Update Rate",		2,     100,    -1,     3,   idUpdateRate,   490,     15,    5,560

		FLsetVal_i	0.1, 	ihmass1
		FLsetVal_i	0.7, 	ihmass2
		FLsetVal_i	0.5, 	ihsep
		FLsetVal_i	0.2, ihdelta
		FLsetVal_i	-0.5, 	ihx
		FLsetVal_i	0.3, 	ihy
		FLsetVal_i	-0.1, 	ihz
		FLsetVal_i	-0.69, 	ihvx
		FLsetVal_i	0.5, 	ihvy
		FLsetVal_i	0.22, 	ihvz
		FLsetVal_i	0, 	ihfric                                
		FLsetVal_i	5, 	ihScalDisp
		FLsetVal_i	0.1, 	ihamp
		FLsetVal_i	40, 	ihUpdateRate

	FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	"info", 512, 550, 1012, 0
				FLscroll        512, 550, 0,    0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                           planet                            ", 	1,      6,     14,    490,    25,     5,   0
ih		 	FLbox  	"============================oOOo=============================", 	1,      6,     14,    490,    20,     5,  20
ih		 	FLbox  	"'planet' generates cartesian coordinates (x,y and z) based on", 	1,      5,     14,    490,    20,     5,  40
ih		 	FLbox  	"a simulation of a binary star system (two stars orbited by a ", 	1,      5,     14,    490,    20,     5,  60
ih		 	FLbox  	"single planet). The nature of the planet's orbit is          ", 	1,      5,     14,    490,    20,     5,  80
ih		 	FLbox  	"determined by a number of initial conditions and also some   ", 	1,      5,     14,    490,    20,     5, 100
ih		 	FLbox  	"performance time conditions which can be modified while      ", 	1,      5,     14,    490,    20,     5, 120
ih	  	 	FLbox  	"orbiting is underway.                                        ", 	1,      5,     14,    490,    20,     5, 140
ih		 	FLbox  	"The masses of the stars defined as ratios with respect to one", 	1,      5,     14,    490,    20,     5, 160
ih		 	FLbox  	"another and their separation can be modified during          ", 	1,      5,     14,    490,    20,     5, 180
ih		 	FLbox  	"performance.                                                 ", 	1,      5,     14,    490,    20,     5, 200
ih		 	FLbox  	"The initial location of the planet in terms of its x, y and z", 	1,      5,     14,    490,    20,     5, 220
ih		 	FLbox  	"coordinates, and its initial vector similarly defined is     ", 	1,      5,     14,    490,    20,     5, 240
ih		 	FLbox  	"defined at i-time but moving the relevant sliders will cause ", 	1,      5,     14,    490,    20,     5, 260
ih		 	FLbox  	"the orbiting to be restarted. 'Friction' greater than zero   ", 	1,      5,     14,    490,    20,     5, 280
ih		 	FLbox  	"will increasingly damp the system resulting in a decaying    ", 	1,      5,     14,    490,    20,     5, 300
ih		 	FLbox  	"orbits. 'Delta' determines the rate of change of position    ", 	1,      5,     14,    490,    20,     5, 320
ih		 	FLbox  	"(i.e. speed) of the planet.                                  ", 	1,      5,     14,    490,    20,     5, 340
ih		 	FLbox  	"In this example the planet's orbit is represented through the", 	1,      5,     14,    490,    20,     5, 360
ih		 	FLbox  	"x and y positioning of a moving FLTK widget. The z-plane is  ", 	1,      5,     14,    490,    20,     5, 380
ih		 	FLbox  	"used to determine the widget's size and therefore its        ", 	1,      5,     14,    490,    20,     5, 400
ih		 	FLbox  	"apparent distance from the viewpoint.                        ", 	1,      5,     14,    490,    20,     5, 420
ih		 	FLbox  	"The planet's orbit can be sonified in one of two ways. If    ", 	1,      5,     14,    490,    20,     5, 440
ih		 	FLbox  	"'Data Sonification' has been selected the cartesian          ", 	1,      5,     14,    490,    20,     5, 460
ih		 	FLbox  	"coordinate data is used to control an FM synthesis tone. X   ", 	1,      5,     14,    490,    20,     5, 480
ih		 	FLbox  	"values control basic frequency, y values control modulator   ", 	1,      5,     14,    490,    20,     5, 500
ih		 	FLbox  	"freq. ratio and z values control the index of modulation.    ", 	1,      5,     14,    490,    20,     5, 520
ih		 	FLbox  	"Speed of planetary movement (in any direction) controls the  ", 	1,      5,     14,    490,    20,     5, 540
ih		 	FLbox  	"amplitude of the resulting tone.                             ", 	1,      5,     14,    490,    20,     5, 560
ih		 	FLbox  	"If 'Direct Sonification' is chosen the three functions for   ", 	1,      5,     14,    490,    20,     5, 580
ih		 	FLbox  	"x, y and z are simply used as audio waveforms and ring -     ", 	1,      5,     14,    490,    20,     5, 600
ih		 	FLbox  	"modulated together. In this mode 'Delta' will need to be     ", 	1,      5,     14,    490,    20,     5, 620
ih		 	FLbox  	"higher in order for the results to be audible.               ", 	1,      5,     14,    490,    20,     5, 640
ih		 	FLbox  	"The rate of update of the FLTK widget can be modified in     ", 	1,      5,     14,    490,    20,     5, 660
ih		 	FLbox  	"order to troubleshoot realtime performnace issues.           ", 	1,      5,     14,    490,    20,     5, 680
ih		 	FLbox  	"The 'Scale Display' factor can bring the planet back within  ", 	1,      5,     14,    490,    20,     5, 700
ih		 	FLbox  	"the display if it escapes beyond the edges. Bear in mind that", 	1,      5,     14,    490,    20,     5, 720
ih		 	FLbox  	"the results of an orbit can be unpredicatable and that a     ", 	1,      5,     14,    490,    20,     5, 740
ih		 	FLbox  	"planet can, under certain conditions, escape captured orbit  ", 	1,      5,     14,    490,    20,     5, 760
ih		 	FLbox  	"completely.                                                  ", 	1,      5,     14,    490,    20,     5, 780
                                FLscroll_end                                                                                                               
				FLpanel_end                                                                                                       
	FLrun                                                                                  

gisine	ftgen	0,0,4097,10,1	;A SINE WAVE

instr	1
	ktrig	changed	gkdelta,gkvx,gkvy,gkvz,gkfric,gkx,gky,gkz,gkreset	;SENSE CHANGES IN SLIDERS THAT CONTROL I-TIME INPUT ARGUMENTS
	if ktrig==1 then						;IF A 'CHANGED' TRIGGER HAS BEEN SENSED
	 reinit UPDATE_PLANET						;BEGIN A REINITIALISATION PASS
	endif								;END OF CONDITIONAL BRANCH
	UPDATE_PLANET:							;LABEL CALLED 'UPDATE_PLANET'. REINITIALISATION BEGINS FROM HERE
	gkreset	init	0
	idelta	=	(i(gkdelta)^6)*(1-0.00001) + 0.00001		;CREATE idelta VALUE FROM 0 - 1 INPUT VALUE (THIS IS DONE IN THIS WAY DUE TO PROBLEMS WITH EXPONENTIALLY SCALED FLTK VALUATORS WITH VERY LOW MINIMUM VALUES)
	FLsetVal_i	idelta,gihdelta					;SEND VALUE TO FLtext WIDGET THAT IMITATES AN FLvalue
	ax, ay, az planet gkmass1, gkmass2, gksep, i(gkx), i(gky), i(gkz), i(gkvx), i(gkvy), i(gkvz), idelta, i(gkfric)	;] [, iskip]
	rireturn							;RETURN FROM REINITIALISATION

	kx	downsamp	ax					;CREATE K-RATE VERSION OF OUTPUT X COORD
	ky	downsamp	ay					;CREATE K-RATE VERSION OF OUTPUT Y COORD
	kz	downsamp	az					;CREATE K-RATE VERSION OF OUTPUT Z COORD	
	
	;MOVE AND RESIZE THE FLTK 'PLANET'-------------------------------------------------------------------------------------------------
	kmetro	metro	gkUpdateRate				;METRONOME THAT TRIGGERS UPDATING OF THE FLTK 'PLANET'
	kx		=	(kx+(gkScalDisp/2))/gkScalDisp	;RESCALE X - COORD
	ky		=	(ky+(gkScalDisp/2))/gkScalDisp	;RESCALE Y - COORD
	kz		=	(kz+(gkScalDisp/2))/gkScalDisp	;RESCALE Z - COORD
	if kmetro=1 then					;IF A METRONOME IMPULSE IS RECEIVED...
	  reinit UPDATE						;BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE'
	endif							;END OF CONDITIONAL BRANCH
	UPDATE:							;A LABEL. REINITIALISATION TO RESET THE WIDGET POSITION BEGINS FROM HERE.
	FLhide gihplanet					;HIDE THE 'PLANET'. TO FACILITATE RESIZING AND REPOSITIONING.
	iPlanetSize	=	i(kz)*giPlanetSize		;PLANET SIZE RESCALED ACCORDING TO DISTANCE (z-plane) VALUE
	FLsetPosition i(kx)*(giPanelWidth-(iPlanetSize)),i(ky)*(giPanelHeight-(iPlanetSize)),gihplanet	;UPDATE FLTK 'PLANET' POSITION
	FLsetSize	i(kz)*giPlanetSize, i(kz)*giPlanetSize, gihplanet				;UPDATE FLTK 'PLANET' SIZE
	itextsize	limit	iPlanetSize,0.0001,800	
	FLsetTextSize	itextsize, gihplanet				;UPDATE FLTK 'PLANET' SIZE
	FLshow gihplanet					;SHOW THE PLANET
	rireturn						;RETURN FROM REINITIALISATION PASS
	;----------------------------------------------------------------------------------------------------------------------------------
	
	
	if gkSonificationMode==0 then
	 ;DATA-SONIFICATION------------------------------------------------------
	 kdelx	delayk	kx,0.2							;
	 kdely	delayk	ky,0.2							;
	 kdelz	delayk	kz,0.2							;
	 kchngx	=	abs(kx-kdelx)						;
	 kchngy	=	abs(ky-kdely)						;
	 kchngz	=	abs(kz-kdelz)						;
	 kamp	limit	kchngx+kchngy+kchngz,gkamp/10,gkamp			;
	 kporttime	linseg	0,0.001,0.1					;
	 kamp	portk	kamp,kporttime						;                        
	 aamp	 interp	kamp							;
	 kcps	=	cpsoct( ((kx-0.5) * 2) + 8)				;
	 kcar	=	1							;
	 kmod	=	1+(ky*6)						;
	 kndx	=	(kz^3)*6						;         
	 ifn	=	gisine							;
	 asig	foscili		aamp, kcps, kcar, kmod, kndx, ifn; [, iphs]	;                     
	 	out	asig							;
	 ;-----------------------------------------------------------------------
	else
	 ;DIRECT SONIFICATION----------------------------------------------------
	 asig	clip	(ax*ay*az)*gkamp,0,0dbfs				;CLIP OUT OF RANGE AUDIO TO PROTECT BLOWN SPEAKERS AND EARS  
		out	asig                         				;                            
	 ;-----------------------------------------------------------------------
	endif
endin


</CsInstruments>
                                                  
<CsScore>
i 1 0 3600
</CsScore>

</CsoundSynthesizer>