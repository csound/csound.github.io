GEN21.csd
Written by Iain McCurdy, 2011

<CsoundSynthesizer>

<CsOptions>
-odac --displays
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	8	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	1	;NUMBER OF CHANNELS (1=MONO)
0dbfs		=	1	;MAXIMUM AMPLITUDE
                
;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 255, 255, 50
;					LABEL  | WIDTH | HEIGHT | X | Y
				FLpanel	"GEN21",  500,    250,    0,  0
;SWITCHES                       			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"Play Tone",	1,    0,    22,    120,     25,    5,  5,    -1

;TEXT BOXES						TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Distribution Type", 	1,      1,     15,    140,     20,   180, 5
;COUNTERS					     	MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gktype, gihtype		FLcount  	"Type", 	1,    11,     1,       1,      2,    200,     40,   150, 30,   -1 

;VALUE DISPLAY BOXES		LABEL  | WIDTH | HEIGHT | X | Y
idlevel			FLvalue	" ",       50,     17,    5, 125
idarg1			FLvalue	" ",       50,     17,    5, 175
idarg2			FLvalue	" ",       50,     17,    5, 225

;SLIDERS								MIN  | MAX | EXP | TYPE |  DISP  | WIDTH | HEIGHT | X  | Y
gklevel,ihlevel		FLslider 	"Level",			0,      5,    0,    23,   idlevel,  490,     25,    5,  100
gkarg1,iharg1		FLslider 	"Arg.1 (Weibull and Beta)",	-10,   10,    0,    23,   idarg1,   490,     25,    5,  150
gkarg2,iharg2		FLslider 	"Arg.2 (Beta)",			-10,   10,    0,    23,   idarg2,   490,     25,    5,  200

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	1, 	gihtype
				FLsetVal_i	1, 	ihlevel
				FLsetVal_i	1, 	iharg1
				FLsetVal_i	2, 	iharg2
			                                                           
				FLpanel_end
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 380, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                             GEN21                           ", 	1,      5,     14,    490,     20,    5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,     20,    5,  20
ih		 	FLbox  	"GEN21 is used to generate random distributions of various    ", 	1,      5,     14,    490,     20,    5,  40
ih		 	FLbox  	"types. The time domain representation provided should give at", 	1,      5,     14,    490,     20,    5,  60
ih		 	FLbox  	"least some idea of what shape the distribution expresses.    ", 	1,      5,     14,    490,     20,    5,  80
ih		 	FLbox  	"A simple sonification of each distribution is provided.      ", 	1,      5,     14,    490,     20,    5, 100
ih		 	FLbox  	"'Level' scales the amplitude of the distribution contained in", 	1,      5,     14,    490,     20,    5, 120
ih		 	FLbox  	"the function table. (It is required that the GEN routine     ", 	1,      5,     14,    490,     20,    5, 140
ih		 	FLbox  	"number (p4) is given a minus sign in order to defeat post    ", 	1,      5,     14,    490,     20,    5, 160
ih		 	FLbox  	"normalisation for this parameter to work properly.)          ", 	1,      5,     14,    490,     20,    5, 180
ih		 	FLbox  	"Two of the distributions require extra arguments: Weibull    ", 	1,      5,     14,    490,     20,    5, 200
ih		 	FLbox  	"requires one and Beta requires two. Distributions that do not", 	1,      5,     14,    490,     20,    5, 220
ih		 	FLbox  	"require these arguments simply ignore them.                  ", 	1,      5,     14,    490,     20,    5, 240
ih		 	FLbox  	"In the sonification provided in this example values read     ", 	1,      5,     14,    490,     20,    5, 260
ih		 	FLbox  	"(at a-rate) from the table are interpretted (added to a      ", 	1,      5,     14,    490,     20,    5, 280
ih		 	FLbox  	"static value of 8) as pitch of an oscillator in Csound's     ", 	1,      5,     14,    490,     20,    5, 300
ih		 	FLbox  	"'oct' format.                                                ", 	1,      5,     14,    490,     20,    5, 320
ih		 	FLbox  	"When running this example ensure that Csound's displays are  ", 	1,      5,     14,    490,     20,    5, 340
ih		 	FLbox  	"enabled by not employing the -d flag.                        ", 	1,      5,     14,    490,     20,    5, 360
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen	1,0,4096,10,1	;A SINE WAVE FUNCTION (USED BY THE AUDIO OSCILLATOR)

instr	1	;UPDATES FUNCTION TABLE                    
	ktrig	changed	gktype,gklevel,gkarg1,gkarg2	;SENSE IF ONE OF THE INPUT PARAMETERS FOR CREATING THE FUNCTION TABLE HAS BEEN CHANGED, OUTPUT A MOMENTARY 1 IF ONE HAS
	if ktrig=1 then				;IF A PARAMETER FOR THE FUNCTION TABLE HAS BEEN CHANGED...
	  reinit	UPDATE			;...BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE' IN ORDER TO CREATE THE FUNCTION TABLE. (THIS CANNOT BE DONE AT PERFORMANCE TIME)
	  UPDATE:				;A LABEL. BEGIN REINITIALIZATION FROM HERE.
	  ;CREATE THE GEN21 FUNCTION TABLE. 
	  ;FUNCTION TABLE NUMBER IS DEFINED EXPLICITLY (I.E. NOT ZERO) SO THAT THE OLD TABLE WILL BE OVER-WRITTEN EACH TIME A CHANGE IS MADE
	  gidist	ftgen	2,0,4096,-21,i(gktype),i(gklevel),i(gkarg1),i(gkarg2) 
	  ;MODIFY COUNTER LABEL DEPENDING ON WHICH DISTRIBUTION HAS BEEN CHOSEN
	  FLsetText	"                                    ", gihtype
	  if i(gktype)==1 then
	    FLsetText	"Uniform", gihtype
	  elseif i(gktype)==2 then
	    FLsetText	"Linear", gihtype
	  elseif i(gktype)==3 then
	    FLsetText	"Triangular", gihtype
	  elseif i(gktype)==4 then
	    FLsetText	"Exponential", gihtype
	  elseif i(gktype)==5 then
	    FLsetText	"Biexponential", gihtype
	  elseif i(gktype)==6 then
	    FLsetText	"Gaussian", gihtype
	  elseif i(gktype)==7 then
	    FLsetText	"Cauchy", gihtype
	  elseif i(gktype)==8 then
	    FLsetText	"Positive Cauchy", gihtype
	  elseif i(gktype)==9 then
	    FLsetText	"Beta", gihtype
	  elseif i(gktype)==10 then
	    FLsetText	"Weibull", gihtype
	  elseif i(gktype)==11 then
	    FLsetText	"Poisson", gihtype
	  endif
	  rireturn				;RETURN FROM REINITIALIZATION PASS
	endif					;END OF THIS CONDITIONAL BRANCH
	andx	random	0,1			;CREATE A UNIFORMLY RANDOM VALUE BETWEEN 0 AND 1 AT A-RATE THAT WILL BE USED AS AN INDEX INTO THE TABLE (RESCALED TO TABLE SIZE)  
	aoct	table	andx,gidist,1		;READ A VALUE FROM THE RANDOM DISTRIBUTION (GIVING P3 A VALUE OF 1 ALLOWS US TO PROVIDE AN INDEX WITHIN THE RANGE 0 - 1, RESCALING OF THIS VALUE IS DONE INTERNALLY)
	asig	oscili	0.2*gkOnOff,cpsoct(aoct+8),gisine	;CREATE AN AUDIO OSCILLATOR - AMPLITUDE CAN BE SWITCHED OFF USING THE ON-SCREEN BUTTON.
		out	asig			;SEND AUDIO TO THE OUTPUT
endin

</CsInstruments>

<CsScore>
i 1 0 3600	;INSTRUMENT 1 PLAYS A NOTE FOR 1 HOUR (AND KEEPS PERFORMANCE GOING)
</CsScore>

</CsoundSynthesizer>
