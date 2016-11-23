VelocityCurve.csd
Written by Iain McCurdy 2011     

<CsoundSynthesizer>

<CsOptions>
-odac -Ma -m0
</CsOptions>

<CsInstruments>

sr 	= 	44100                                                                                                                                                          
ksmps 	= 	16
nchnls 	= 	1	
0dbfs	=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL     | WIDTH | HEIGHT | X | Y
	FLpanel	"Velocity Curve",    300,     75,    0,  0

;VALUE DISPLAY BOXES					WIDTH | HEIGHT | X |  Y
idCurveShape			FLvalue	" ",     	60,       18,    5,   35

;SLIDERS				            			MIN  | MAX | EXP | TYPE |   DISP     | WIDTH | HEIGHT | X | Y
gkCurveShape,ihCurveShape	FLslider 	"Curve Shape",		-10,    10,   0,    23,  idCurveShape,  290,     25,    5,  10

;SET INITIAL VALUES			VALUE | HANDLE                                                                                    
			FLsetVal_i	0,	ihCurveShape

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL
				FLpanel	"info", 515, 420, 312, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                         Velocity Curve                      ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"It may sometimes be necessary to adjust the MIDI velocity    ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"response curve in order to adjust to a particular playing    ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"style or to compensate for the different mechanical          ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"properties of different keyboards.                           ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"Sometimes this is possible on the keyboard itself using its  ", 	1,      5,     14,    490,    15,     5, 120
ih	  	 	FLbox  	"own built in software (firmware), but it may prove easier to ", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"do this within Csound.                                       ", 	1,      5,     14,    490,    15,     5, 160           
ih		 	FLbox  	"In this example this is achieved by remapping velocity values", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"using a table lookup in the style of a transfer function with", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"a GEN16 curve function table.                                ", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"The user can adjust the curvature of this function table and ", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"provided Csound's function table displays are enabled (-d    ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"flag is not used) the curve can be viewed also with realtime ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"update of changes made.                                      ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"The function table used to transform velocities could be any ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"GEN routine and any shape but the one used here should cover ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"most standard requirements.                                  ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"In this example key velocity maps to both amplitude and      ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"brightness of the tone produced.                             ", 	1,      5,     14,    490,    15,     5, 400

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr	2	;CREATES THE VELOCITY CURVE TABLE AND SCANS FOR CHANGES (MUST COME BEFORE INSTR 1 AS IT CREATES FUNCTION TABLES THAT INSTR 2 NEEDS!)
	ktrig	changed	gkCurveShape					;CREATE A TRIGGER WHICH INFORMS WHENEVER CURVE SHAPE SLIDER CHANGED
	if ktrig=1 then							;IF CURVE SHAPE SLIDER HAS BEEN MOVED... 
	  reinit	UPDATE_TABLE					;...BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE_TABLE' 
	endif								;END OF CONDITIONAL BRANCH
	UPDATE_TABLE:							;LABEL CALLED 'UPDATE_TABLE'. REINITIALISATION PASS BEGINS FROM HERE.
	gicurve		ftgen	1,0,128,-16,0,128,i(gkCurveShape),1	;CREATE THE VELOCITY CURVE TABLE (AT I-TIME AND ALSO DURING REINITIALISATION PASSES)
	rireturn							;RETURN FROM REINITIALISATION PASS
	gicos		ftgen 	2,0,16384,11,1				;A COSINE WAVE - USED BY THE gbuzz OPCODE (AT I-TIME ONLY)	
endin

instr		1
	icps	cpsmidi						;PITCH VALUES ARE READ IN FROM THE MIDI KEYBOARD
	ivel	veloc	0,1					;MIDI VELOCITY. RESCALED TO BE WITHIN THE RANGE 0 - 1. 
	ivel	table	ivel,gicurve,1
	kmul	linsegr	0,0.05,ivel*0.9,0.1,0			;PARTIAL STRENGTHS MULTIPLIER FOR GBUZZ - LIKE A TONE CONTROL
	kwobble	jspline	0.02,8,40				;A LITTLE BIT OF WOBBLE WHICH WILL BE ADDED TO THE TONE CONTROL TO MAKE IT SOUND A LITTLE MORE NATURAL
	aenv	linsegr	0,0.01,ivel*0.3,0.1,0			;DE-CLICKING AMPLITUDE ENVELOPE
	asig	gbuzz	aenv,icps,40,1,kmul-kwobble,gicos	;A GBUZZ RICH HARMONIC TONE GENERATOR
		out	asig					;SEND THE AUDIO SIGNAL CREATED BY gbuzz TO THE OUTPUT
endin

</CsInstruments>

<CsScore>
i 2 0 3600	;INSTRUMENT 2 (CREATES FUNCTION TABLES AND SCANS FOR CHANGES)
</CsScore>

</CsoundSynthesizer>