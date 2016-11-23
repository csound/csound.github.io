GEN20.csd
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
FLcolor	255, 255, 255, 0, 0, 0
;					LABEL  | WIDTH | HEIGHT | X | Y
				FLpanel	"GEN20",  500,    150,    0,  0
;SWITCHES                       			ON | OFF | TYPE | WIDTH | HEIGHT | X | Y | OPCODE | INS | STARTTIM | IDUR
gkOnOff,ihOnOff		FLbutton	"Play Tone",	1,    0,    22,    120,     25,    5,  5,   -1
FLsetColor2	255, 255, 50, ihOnOff		;SET SECONDARY COLOUR TO YELLOW

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Window Type", 	1,      1,     15,    120,     20,   190, 5
;COUNTERS					     		MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE 
gkwindow, gihwindow		FLcount  	"Window", 	1,    9,     1,       1,      2,    200,     40,   150, 30,   -1 

;VALUE DISPLAY BOXES		LABEL  | WIDTH | HEIGHT | X | Y
idopt			FLvalue	" ",       50,     17,    5, 125

;SLIDERS									MIN  | MAX | EXP | TYPE |  DISP  | WIDTH | HEIGHT | X  | Y
gkopt,ihopt		FLslider 	"Optional (Gaussian and Kaiser)",	0,     20,    0,    23,   idopt,    490,     25,    5,  100

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	1, 	ihopt

;0-10

;SET INITIAL VALUES OF FLTK VALUATORS		VALUE | HANDLE
				FLsetVal_i	1, 	gihwindow
			                                                           
				FLpanel_end
;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 220, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                             GEN20                           ", 	1,      5,     14,    490,     20,    5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,     20,    5,  20
ih		 	FLbox  	"GEN20 can be used to generate window functions that might be ", 	1,      5,     14,    490,     20,    5,  40
ih		 	FLbox  	"useful in enveloping grains or in the masking of random      ", 	1,      5,     14,    490,     20,    5,  60
ih		 	FLbox  	"distributions.                                               ", 	1,      5,     14,    490,     20,    5,  80
ih		 	FLbox  	"The example does not produce any sound but provides visual   ", 	1,      5,     14,    490,     20,    5, 100
ih		 	FLbox  	"confirmation of each window shape provided Csound displays   ", 	1,      5,     14,    490,     20,    5, 120
ih		 	FLbox  	"are enabled (i.e. the -d flag is not used).                  ", 	1,      5,     14,    490,     20,    5, 140
ih		 	FLbox  	"Nine window types are available.                             ", 	1,      5,     14,    490,     20,    5, 160
ih		 	FLbox  	"Gaussian and Kaiser windows require an additional argument   ", 	1,      5,     14,    490,     20,    5, 180
ih		 	FLbox  	"which defines how 'open' the window is.                      ", 	1,      5,     14,    490,     20,    5, 200
				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
                                                                               
instr	1	;UPDATES FUNCTION TABLE                    
	ktrig	changed	gkwindow,gkopt		;SENSE IF ONE OF THE INPUT PARAMETERS FOR CREATING THE FUNCTION TABLE HAS BEEN CHANGED, OUTPUT A MOMENTARY 1 IF ONE HAS
	if ktrig=1 then				;IF A PARAMETER FOR THE FUNCTION TABLE HAS BEEN CHANGED...
	  reinit	UPDATE			;...BEGIN A REINITIALISATION PASS FROM LABEL 'UPDATE' IN ORDER TO CREATE THE FUNCTION TABLE. (THIS CANNOT BE DONE AT PERFORMANCE TIME)
	  UPDATE:				;A LABEL. BEGIN REINITIALISATION FROM HERE.
	  ;CREATE THE GEN20 FUNCTION TABLE. 
	  ;FUNCTION TABLE NUMBER IS DEFINED EXPLICITLY (I.E. NOT ZERO) SO THAT THE OLD TABLE WILL BE OVER-WRITTEN EACH TIME A CHANGE IS MADE
	  iwindow	ftgen	1,0,4096,20,i(gkwindow),1,i(gkopt)
	  ;MODIFY COUNTER LABEL DEPENDING ON WHICH WINDOW HAS BEEN CHOSEN
	  if i(gkwindow)==1 then
	    FLsetText	"                                           ", gihwindow	  
	    FLsetText	"Hamming", gihwindow
	  elseif i(gkwindow)==2 then
	    FLsetText	"                                           ", gihwindow	  
	    FLsetText	"Hanning", gihwindow
	  elseif i(gkwindow)==3 then
	    FLsetText	"                                           ", gihwindow	  
	    FLsetText	"Bartlett (Triangle)", gihwindow
	  elseif i(gkwindow)==4 then
	    FLsetText	"                                           ", gihwindow	  
	    FLsetText	"Blackman (3-term)", gihwindow
	  elseif i(gkwindow)==5 then
	    FLsetText	"                                           ", gihwindow	  
	    FLsetText	"Blackman-Harris (4-term)", gihwindow
	  elseif i(gkwindow)==6 then
	    FLsetText	"                                           ", gihwindow	  
	    FLsetText	"Gaussian", gihwindow
	  elseif i(gkwindow)==7 then
	    FLsetText	"                                           ", gihwindow	  
	    FLsetText	"Kaiser", gihwindow
	  elseif i(gkwindow)==8 then
	    FLsetText	"                                           ", gihwindow	  
	    FLsetText	"Rectangle", gihwindow
	  elseif i(gkwindow)==9 then
	    FLsetText	"                                           ", gihwindow	  
	    FLsetText	"Sync", gihwindow
	  endif
	    rireturn				;RETURN FROM REINITIALIZATION PASS
	endif					;END OF THIS CONDITIONAL BRANCH
	
	aenv	oscili	1,1,iwindow
	asig	oscils	0.5,300,0
	asig	=	asig*aenv
	kamp	port	gkOnOff,0.02	
		out	asig*kamp
endin

</CsInstruments>

<CsScore>
i 1 0 3600	;INSTRUMENT 1 PLAYS A NOTE FOR 1 HOUR (AND KEEPS PERFORMANCE GOING)
</CsScore>

</CsoundSynthesizer>
