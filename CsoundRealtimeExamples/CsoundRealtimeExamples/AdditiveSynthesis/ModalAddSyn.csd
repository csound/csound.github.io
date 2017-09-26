ModalAddSyn.csd
Written by Iain McCurdy 2011

<CsoundSynthesizer>

<CsOptions>
;virtual midi device
-odac -M0 -+rtmidi=virtual -dm0

;external midi keyboard (recommended)
;-odac -Ma -dm0
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	256	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1

;FLTK INTERFACE CODE==============================================================================================================================================================
FLcolor	255,255,255,255,255,50
;	LABEL                                    | WIDTH | HEIGHT | X | Y
FLpanel	"additive synthesis using modal ratios",    500,    475,    0,  0
	;COUNTERS							MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE
	gksound, gihsound 			FLcount  "Sound", 	1,     21,     1,      1,      2,   100,     25,   25,   5,   -1
	;TEXT BOXES							TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
	gihSoundName	 	FLbox  	"Tibetan Bowl (180mm)", 	1,      1,     12,    150,    20,     0,   45

	;SWITCHES                                			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | DUR
	gkSusOnOff,ihSusOnOff	FLbutton	"Sustain On/Off",	1,    0,    22,    150,     25,   345, 5,   -1
	gkChoOnOff,ihChoOnOff	FLbutton	"Chorus On/Off",	1,    0,    22,    120,     25,     2,375,  -1

	;VALUE DISPLAY BOXES					WIDTH | HEIGHT |  X  |  Y
	idatt			FLvalue	"",     		60,       20,     5,   100
	iddec			FLvalue	"",     		60,       20,     5,   150
	iddamping		FLvalue	"",     		60,       20,     5,   200
	idbrite			FLvalue	"",     		60,       20,     5,   250
	idvelocity		FLvalue	"",     		60,       20,     5,   300
	idampvar		FLvalue	"",     		60,       20,     5,   350

	;SLIDERS				            			MIN  | MAX | EXP | TYPE | DISP      | WIDTH | HEIGHT | X | Y
	gkatt, gihatt		FLslider 	"Attack Time",			0.001,  50,  -1,   23,   idatt,        490,    25,     5,  75
	gkdec, gihdec		FLslider 	"Decay Time",			0.1,    20,  -1,   23,   iddec,        490,    25,     5, 125
	gkdamping, gihdamping	FLslider 	"Damping",			0.1,   100,  -1,   23,   iddamping,    490,    25,     5, 175
	gkbrite, gihbrite	FLslider 	"Brightness",			-20,    20,   0,   23,   idbrite,      490,    25,     5, 225                                    
	gkvelocity, gihvelocity	FLslider 	"Velocity to Brightness",	0,       1,   0,   23,   idvelocity,   490,    25,     5, 275
	gkampvar, gihampvar	FLslider 	"Timbral Variation",		0,       1,   0,   23,   idampvar,     490,    25,     5, 325
	gkspeed, gihspeed	FLslider 	"Speed",			0.1,     2,  -1,   23,   -1,           120,    25,     125,375
	gkwidth, gihwidth	FLslider 	"Width",			1,       0,   0,   23,   -1,           120,    25,     250,375
	gkchomix, gihchomix	FLslider 	"Mix",				0,       1,   0,   23,   -1,           120,    25,     375,375 
	gkGlobGain, ihGlobGain	FLslider 	"Global Amplitude",		0,       1,   0,   23,   -1,           490,    25,     5, 425
	
	;SET INITIAL VALUES
	FLsetVal_i	5, 	gihsound
	FLsetVal_i	0.002, 	gihatt
	FLsetVal_i	9, 	gihdec                                                                                                                                 
	FLsetVal_i	6, 	gihdamping
	FLsetVal_i	-10, 	gihbrite
	FLsetVal_i	0.1, 	gihvelocity
	FLsetVal_i	0.5, 	gihampvar
	FLsetVal_i	1, 	ihSusOnOff
	FLsetVal_i	1, 	ihChoOnOff
	FLsetVal_i	0.5, 	gihspeed
	FLsetVal_i	1, 	gihwidth
	FLsetVal_i	1, 	gihchomix
	FLsetVal_i	0.3, 	ihGlobGain
	                                                     
FLpanel_end

	;INSTRUCTIONS AND INFO PANEL
	FLpanel	"", 500, 660, 512, 0
	;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
	ih		 	FLbox  	"          additive synthesis using modal ratios              ", 	1,      5,     14,    490,    20,     5,    0
	ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    20,     5,   20
	ih		 	FLbox  	"This example implements additive synthesis based on tables of", 	1,      5,     14,    490,    20,     5,   40
	ih		 	FLbox  	"modal frequency ratios. Most of the data for these tables was", 	1,      5,     14,    490,    20,     5,   60
	ih		 	FLbox  	"taken from the appendix of the Csound Manual, the rest I are ", 	1,      5,     14,    490,    20,     5,   80
	ih		 	FLbox  	"the results of my own analyses.                              ", 	1,      5,     14,    490,    20,     5,  100
	ih		 	FLbox  	"A common problem with additive synthesis implementations is  ", 	1,      5,     14,    490,    20,     5,  120
	ih		 	FLbox  	"that the user is confronted with an overwhelming number of   ", 	1,      5,     14,    490,    20,     5,  140
	ih		 	FLbox  	"controls. In this example I have tried to limit the GUI to a ", 	1,      5,     14,    490,    20,     5,  160                                                         
	ih		 	FLbox  	"minimum number of controls which still provide power to      ", 	1,      5,     14,    490,    20,     5,  180
	ih		 	FLbox  	"produce a wide range of sounds.                              ", 	1,      5,     14,    490,    20,     5,  200
	ih		 	FLbox  	"The focus here is on sounds of struck resonant objects.      ", 	1,      5,     14,    490,    20,     5,  220
	ih		 	FLbox  	"This instrument is intended to played from a MIDI keyboard.  ", 	1,      5,     14,    490,    20,     5,  240
	ih		 	FLbox  	"'Decay Time' controls the duration of the partial after      ", 	1,      5,     14,    490,    20,     5,  260
	ih		 	FLbox  	"maximum amplitude has been achieved.                         ", 	1,      5,     14,    490,    20,     5,  280
	ih		 	FLbox  	"'Attack Time' varies the attack time of each partial but     ", 	1,      5,     14,    490,    20,     5,  300
	ih		 	FLbox  	"lower partials attack time will be longer than those for     ", 	1,      5,     14,    490,    20,     5,  320
	ih		 	FLbox  	"higher partials. This creates the impression of the resonant ", 	1,      5,     14,    490,    20,     5,  340
	ih		 	FLbox  	"object being bowed or rubbed.                                ", 	1,      5,     14,    490,    20,     5,  360
	ih		 	FLbox  	"'Damping' varies the rate at which partials decay, higher    ", 	1,      5,     14,    490,    20,     5,  380
	ih		 	FLbox  	"partials decay quicker.                                      ", 	1,      5,     14,    490,    20,     5,  400
	ih		 	FLbox  	"'Brightness' controls the basic brightness of the tone.      ", 	1,      5,     14,    490,    20,     5,  420
	ih		 	FLbox  	"'Velocity to Brightness' controls the degree to which key    ", 	1,      5,     14,    490,    20,     5,  440
	ih		 	FLbox  	"velocity increases brightness.                               ", 	1,      5,     14,    490,    20,     5,  460
	ih		 	FLbox  	"'Timbral Variation' introduces a randomisation of the        ", 	1,      5,     14,    490,    20,     5,  480
	ih		 	FLbox  	"amplitude of each partial which can give a more realistic    ", 	1,      5,     14,    490,    20,     5,  500
	ih		 	FLbox  	"responding instrument when notes are repeated.               ", 	1,      5,     14,    490,    20,     5,  520
	ih		 	FLbox  	"An integrated stereo chorus effect may prove useful in adding", 	1,      5,     14,    490,    20,     5,  540
	ih		 	FLbox  	"movement and width to the sounds produced.                   ", 	1,      5,     14,    490,    20,     5,  560
	ih		 	FLbox  	"The number in brackets after the name of the modal           ", 	1,      5,     14,    490,    20,     5,  580
	ih		 	FLbox  	"frequencies algorithm indicates the number of frequency      ", 	1,      5,     14,    490,    20,     5,  600
	ih		 	FLbox  	"ratios used in the algorithm. Algorithms with high numbers of", 	1,      5,     14,    490,    20,     5,  620
	ih		 	FLbox  	"frequency ratios will be more CPU hungry.                    ", 	1,      5,     14,    490,    20,     5,  640

FLpanel_end

FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE=======================================================================================================================================================

gisine		ftgen	0,0,129,10,1

;FUNCTION TABLES STORING MODAL FREQUENCY RATIOS===================================================================================================================================
;plucked string
girtos1		ftgen	0,0,-20, -2,	1,     2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20

;dahina
girtos2		ftgen	0,0,-6,-2,	1,	2.89,	4.95,	6.99,	8.01,	9.02

;banyan
girtos3		ftgen	0,0,-6,-2,	1, 	2.0, 	3.01, 	4.01, 	4.69, 	5.63

;xylophone
girtos4		ftgen	0,0,-6,-2,	1, 	3.932, 	9.538,	16.688,	24.566,	31.147

;tibetan bowl (180mm)
girtos5		ftgen	0,0,-7,-2,	1, 	2.77828,	5.18099, 	8.16289,	11.66063,	15.63801,	19.99

;spinel sphere with diameter of 3.6675mm
girtos6		ftgen	0,0,-24,-2,	1,	1.026513174725,	1.4224916858532,	1.4478690202098,	1.4661959580455,	1.499452545408,	1.7891839345101,	1.8768994627782,	1.9645945254541,	1.9786543873113,	2.0334612432847,	2.1452852391916,	2.1561524686621,	2.2533435661294,	2.2905090816065,	2.3331798413917,	2.4567715528268,	2.4925556408289,	2.5661806088514,	2.6055768738808,	2.6692760296751,	2.7140956766436,	2.7543617293425,	2.7710411870043 

;pot lid
girtos7		ftgen	0,0,-6,-2,	1, 	3.2, 	6.23, 	6.27, 	9.92, 	14.15

;red cedar wood plate
girtos8		ftgen	0,0,-4,-2,	1, 	1.47, 	2.09, 	2.56

;tubular bell
girtos9		ftgen	0,0,-10,-2,	272/437,	538/437,	874/437,	1281/437,	1755/437,	2264/437,	2813/437,	3389/437,	4822/437,	5255/437

;redwood wood plate
girtos10	ftgen	0,0,-4,-2,	1, 1.47, 2.11, 2.57

;douglas fir wood plate
girtos11	ftgen	0,0,-4,-2,	1, 1.42, 2.11, 2.47

;uniform wooden bar
girtos12	ftgen	0,0,-6,-2,	1, 2.572, 4.644, 6.984, 9.723, 12

;uniform aluminum bar
girtos13	ftgen	0,0,-6,-2,	1, 2.756, 5.423, 8.988, 13.448, 18.680

;vibraphone 1
girtos14	ftgen	0,0,-6,-2,	1, 3.984, 10.668, 17.979, 23.679, 33.642

;vibraphone 2
girtos15	ftgen	0,0,-6,-2,	1, 3.997, 9.469, 15.566, 20.863, 29.440

;Chalandi plates
girtos16	ftgen	0,0,-5,-2,	1, 1.72581, 5.80645, 7.41935, 13.91935

;tibetan bowl (152 mm)
girtos17	ftgen	0,0,-7,-2,	1, 2.66242, 4.83757, 7.51592, 10.64012, 14.21019, 18.14027

;tibetan bowl (140 mm)	
girtos18	ftgen	0,0,-5,-2,	1, 2.76515, 5.12121, 7.80681, 10.78409

;wine glass
girtos19	ftgen	0,0,-5,-2,	1, 2.32, 4.25, 6.63, 9.38

;small handbell
girtos20	ftgen	0,0,-22,-2,	1, 1.0019054878049, 1.7936737804878, 1.8009908536585, 2.5201981707317, 2.5224085365854, 2.9907012195122, 2.9940548780488, 3.7855182926829, 3.8061737804878, 4.5689024390244, 4.5754573170732, 5.0296493902439, 5.0455030487805, 6.0759908536585, 5.9094512195122, 6.4124237804878, 6.4430640243902, 7.0826219512195, 7.0923780487805, 7.3188262195122, 7.5551829268293 

;albert clock bell, belfast
girtos21	ftgen	0,0,-22,-2, 2.043260,1.482916,1.000000,3.328848,4.761811,1.477056,0.612007,2.661295,1.002793,4.023776,0.254139,2.043916,4.032463,2.659438,4.775560,5.500494,3.331014,0.809697,2.391301, 0.254098,1.901476,2.366563    ;,0.614968,2.046543,1.814887,3.130744,2.484426,0.558874,0.801697,0.070870,3.617036,2.782656
;=================================================================================================================================================================================

giDampCurve	ftgen	1,0,-20000,-16,1,20000,-10,0.001	;DAMPING CURVE SCALES DURATIONS OF THE DECAY OF EACH PARTIAL
giAmpCurve	ftgen	2,0,128,-16,1,128,-10,0			;AMPLITUDE SCALING FOR PARTIALS - A BRIGHTNESS CONTROL
giVelCurve	ftgen	0,0,128,-16,0,128,20,1			;VELOCITY RESPONSE CURVE
giAttTime	ftgen	0,0,128,-16,1,128,0,0.001		;ATTACT TIME CURVE FOR PARTIALS
gilfoshape	ftgen	0, 0, 131072, 19, 0.5, 1, 180, 1	;U-SHAPE PARABOLA

opcode	ModalAddSyn,	a,iiiiiiiii
icps,ivel,iVelSens,iatt,iampvar,isus,ifn,icount,iNRatios	xin
	iratio	table	icount-1,ifn								;RATIO FOR THIS PARTIAL
	idur	table	icps*iratio,giDampCurve							;DAMPING VALUE FOR THIS PARTIAL - USED TO SCALE THE AMPLITUDE DECAY TIME
	
	iampNdx	table	ivel,giVelCurve,1							;AMPLITUDE SCALING FOR THIS PARTIAL - A BRIGHTNESS CONTROL
	iamp	table	(icount-1)/(iNRatios-1),giAmpCurve,1					
	iamp	ntrpol	iamp,1,ivel*iVelSens

	iattScl	table	(icount-1)/(iNRatios-1),giAttTime,1					;ATTACK TIME SCALING FOR *THIS* PARTIAL

	if isus==1 then
	  adec	linsegr	0,iattScl*iatt,0,(p3*idur)-(iattScl*iatt),-98,(p3*idur)-(iattScl*iatt),-98	;AMPLITUDE DECAY ENVELOPE
	else
	  adec	linsegr	0,iattScl*iatt,0,(p3*idur)-(iattScl*iatt),-98,idur*0.4,-98		;AMPLITUDE DECAY ENVELOPE
	endif
	
	aatt	linseg	0,iattScl*iatt,1							;AMPLITUDE ATTACK ENVELOPE
	
	iampvar	random	1-iampvar,1
	iampvar	pow	iampvar,2
	a1	oscili	ampdb(adec)*iamp*ivel*aatt*iampvar,icps*iratio,gisine			;CREATE THE AUDIO FOR THIS PARTIAL
	if icount<iNRatios then									;IF THERE ARE STILL MORE PARTIALS TO BE CREATED...
	 icount	=	icount+1								;INCREMENT COUNTER
	 amix	ModalAddSyn	icps,ivel,iVelSens,iatt,iampvar,isus,ifn,icount,iNRatios	;CALL THE UDO AGAIN                
	endif
		xout		(a1/iNRatios) + amix						;SEND ALL AUDIO BACK TO THE CALLER INSTRUMENT
endop                          

instr	2
	ktrig1	changed	gkdamping						;IF 'DAMPING' CURVE PARAMETER IS CHANGED GENERATE A TRIGGER IMPULSE
	if ktrig1==1 then							;IF 'DAMPING' CURVE PARAMETER HAS BEEN CHANGED...
	  reinit update1							;...BEGIN A REINITIALISATION PASS FROM LABEL 'update1'
	endif									;END OF CONDITIONAL BRANCH
	update1:								;LABEL - REINITIALISATION BEGINS FROM HERE
	giDampCurve	ftgen	1,0,-20000,-16,1,20000,-i(gkdamping),0.001	;DAMPING CURVE FUNCTION TABLE CREATED WITH NEW CURVATURE VALUE
	rireturn								;RETURN FROM REINITIALISATION PASS
	
	ktrig2	changed	gkbrite							;IF 'BRIGHTNESS' CURVE PARAMETER IS CHANGED GENERATE A TRIGGER IMPULSE
	if ktrig2==1 then							;IF 'BRIGHTNESS' CURVE PARAMETER HAS BEEN CHANGED...
	  reinit update2							;...BEGIN A REINITIALISATION PASS FROM LABEL 'update2'
	endif									;END OF CONDITIONAL BRANCH
	update2:								;LABEL - REINITIALISATION BEGINS FROM HERE
	giAmpCurve	ftgen	2,0,128,-16,1,128,i(gkbrite),0			;DAMPING CURVE FUNCTION TABLE CREATED WITH NEW CURVATURE VALUE
	rireturn								;RETURN FROM REINITIALISATION PASS

	ktrig3	changed	gksound							;IF 'SOUND' TYPE SELECTER IS CHANGED GENERATE A TRIGGER IMPULSE
	if ktrig3==1 then							;IF 'SOUND' TYPE SELECTER HAS BEEN CHANGED...
	  reinit update3							;...BEGIN A REINITIALISATION PASS FROM LABEL 'update3'
	endif									;END OF CONDITIONAL BRANCH
	update3:								;LABEL - REINITIALISATION BEGINS FROM HERE
	iN	=	ftlen(i(gksound)-1+girtos1)				;DERIVE NUMBER OF FREQUENCY RATIOS USED IN THE SELECTED ALGORITHM
		FLhide	gihSoundName						;HIDE SOUND TYPE DESCRIPTION
	if	i(gksound)==1	then						;IF SOUND TYPE 1...
	  Sname	sprintf	"Plucked String (%d)",iN				;CREATE A STRING FOR THE NAME OF THIS ALGORITHM. APPEND THE NUMBER OF RATIOS USED IN BRACKETS.
	  FLsetVal_i	20,gihdec						;SET DECAY TIME
	  FLsetVal_i	15,gihdamping						;SET DAMPING FACTOR
	elseif	i(gksound)==2	then						;...AND SO ON...
	  Sname	sprintf	"Dahina (%d)",iN
	  FLsetVal_i	5,gihdec
	  FLsetVal_i	35,gihdamping
	elseif	i(gksound)==3	then
	  Sname	sprintf	"Banyan (%d)",iN
	  FLsetVal_i	5.3,gihdec
	  FLsetVal_i	52,gihdamping
	elseif	i(gksound)==4	then
	  Sname	sprintf	"Xylophone (%d)",iN
	  FLsetVal_i	4,gihdec
	  FLsetVal_i	30,gihdamping
	elseif	i(gksound)==5	then	
	  Sname	sprintf	"Tibetan Bowl (180mm) (%d)",iN
	  FLsetVal_i	12,gihdec
	  FLsetVal_i	5.4,gihdamping
	elseif	i(gksound)==6	then
	  Sname	sprintf	"Spinel Sphere (%d)",iN
	  FLsetVal_i	1.5,gihdec
	  FLsetVal_i	50,gihdamping
	elseif	i(gksound)==7	then
	  Sname	sprintf	"Pot Lid (%d)",iN
	  FLsetVal_i	12,gihdec
	  FLsetVal_i	14,gihdamping
	elseif	i(gksound)==8	then
	  Sname	sprintf	"Red Cedar Wood Plate (%d)",iN
	  FLsetVal_i	4.5,gihdec
	  FLsetVal_i	50,gihdamping
	elseif	i(gksound)==9	then
	  Sname	sprintf	"Tubular Bell (%d)",iN
	  FLsetVal_i	12,gihdec
	  FLsetVal_i	5.4,gihdamping
	elseif	i(gksound)==10	then
	  Sname	sprintf	"Redwood Wood Plate (%d)",iN
	  FLsetVal_i	4.5,gihdec
	  FLsetVal_i	50,gihdamping
	elseif	i(gksound)==11	then
	  Sname	sprintf	"Douglas Fir Wood Plate (%d)",iN
	  FLsetVal_i	4.5,gihdec
	  FLsetVal_i	50,gihdamping
	elseif	i(gksound)==12	then
	  Sname	sprintf	"Uniform Wooden Bar (%d)",iN
	  FLsetVal_i	4.5,gihdec
	  FLsetVal_i	25,gihdamping
	elseif	i(gksound)==13	then
	  Sname	sprintf	"Uniform Aluminium Bar (%d)",iN
	  FLsetVal_i	12,gihdec
	  FLsetVal_i	5.4,gihdamping
	elseif	i(gksound)==14	then
	  Sname	sprintf	"Vibraphone 1 (%d)",iN
	  FLsetVal_i	15,gihdec
	  FLsetVal_i	8.4,gihdamping
	elseif	i(gksound)==15	then
	  Sname	sprintf	"Vibraphone 2 (%d)",iN
	  FLsetVal_i	15,gihdec
	  FLsetVal_i	8.4,gihdamping
	elseif	i(gksound)==16	then
	  Sname	sprintf	"Chalandi Plates (%d)",iN
	  FLsetVal_i	8.5,gihdec
	  FLsetVal_i	23,gihdamping
	elseif	i(gksound)==17	then
	  Sname	sprintf	"Tibetan Bowl (152mm) (%d)",iN
	  FLsetVal_i	12,gihdec
	  FLsetVal_i	5.4,gihdamping
	elseif	i(gksound)==18	then
	  Sname	sprintf	"Tibetan Bowl (140mm) (%d)",iN
	  FLsetVal_i	12,gihdec
	  FLsetVal_i	5.4,gihdamping
	elseif	i(gksound)==19	then
	  Sname	sprintf	"Wine Glass (%d)",iN
	  FLsetVal_i	12,gihdec
	  FLsetVal_i	5.4,gihdamping
	elseif	i(gksound)==20	then
	  Sname	sprintf	"Small Hand Bell (%d)",iN
	  FLsetVal_i	12,gihdec
	  FLsetVal_i	5.4,gihdamping
	elseif	i(gksound)==21	then
	  Sname	sprintf	"Albert Clock Bell (%d)",iN
	  FLsetVal_i	12,gihdec
	  FLsetVal_i	5.4,gihdamping
	endif
		FLsetText	Sname,gihSoundName				;SET NEW SOUND TYPE DESCRITION TO FL WIDGET
		FLshow	gihSoundName						;REVEAL THE WIDGET (AND THEREFORE THE LABEL)
		rireturn							;RETURN FROM REINITIALISATION PASS

endin

instr	1	;MIDI TRIGGERED INSTRUMENT - CALLS UDO MULTIPLE TIMES
	ifn		=	girtos1 + i(gksound) - 1			;DERIVE FUNCTION TABLE NUMBER
	ivel		veloc	0,1						;READ IN MIDI VELOCITY
	iNRatios	=	ftlen(ifn)					;DERIVE THE NUMBER OF MODAL FREQUENCY RATIOS FROM THE SELECTED FUNCTION TABLE
	
	p3		= 	i(gkatt)+i(gkdec)				;DERIVE DURATION FROM ATTACK TIME AND DECAY TIME
	                
	icps		cpsmidi							;READ IN MIDI PITCH
	                                                                               	
	icount		=	1						;INITIAL VALUE OF COUNTER
	
	aout		ModalAddSyn	icps,ivel,i(gkvelocity),i(gkatt),i(gkampvar),i(gkSusOnOff),ifn,icount,iNRatios	;CALL UDO - WILL BE CALLED WITHIN THE UDO ITSELF RECURSIVELY

	;STEREO CHORUS----------------------------------------------------------
	if gkChoOnOff==1 then
	  adly1		oscili	1,gkspeed,gilfoshape				;CHORUS DELAY TIME LFO 1
	  adly2		oscili	1,gkspeed,gilfoshape,0.5			;CHORUS DELAY TIME LFO 2
	  acho1		vdelay	aout*gkGlobGain,adly1+0.1,2			;CHORUS SIGNAL 1 (MODULATING DELAY TIME AND THEREFORE MODULATING PITCH ALSO)
	  acho2		vdelay	aout*gkGlobGain,adly2+0.1,2			;CHORUS SIGNAL 2
	  aL		sum	aout, acho1*gkchomix, acho2*gkchomix*gkwidth 	;CREATE LEFT CHANNEL MIX
	  aR		sum	aout, acho1*gkchomix*gkwidth, acho2*gkchomix 	;CREATE RIGHT CHANNEL MIX
	  ;SEND STEREO AUDIO TO OUTPUTS
	  		outs	acho1*gkchomix + acho2*gkchomix*gkwidth, acho1*gkchomix*gkwidth + acho2*gkchomix
	endif
	;-----------------------------------------------------------------------

			outs	aout*gkGlobGain,aout*gkGlobGain
endin

</CsInstruments>

<CsScore>
i 2 0 3600	;ALWAYS ON INSTRUMENT UPDATES FUNCTION TABLES WHEN REQUIRED
</CsScore>

</CsoundSynthesizer>