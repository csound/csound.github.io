; Layer Instruments
; ----------------
; Dynamically add or remove layers of the same instrument
; layers can be identified in the called instrument via a counter in their p4: 1,2,3,4 ...
;
; LayerInstruments  klayers,iInstr,idur
; 
; Initialisation
; --------------
; iInstr --  the number of the instrument to be called
; idur   --  the duration of the instrument to be called
;
; Performance
; -----------
; klayers--  number of instrument layers required
;            changing klayers will automatically stop all instances of the instrumnt currently playing and start the new required number
;            only integers are relevant and negative numbers are interpretted as zeroes

opcode	LayerInstruments,0,Kii
	klayers,iInstr,idur	xin			;READ IN INPUT ARGUMENTS
	klayers	=	int(klayers)			;CONVERT NUMBER OF LAYERS VARIABLE TO AN INTEGER
	klayers =       (klayers<0?0:klayers)		;NEGATIVE NUMBERS WILL BE INTERPRETTED AS ZERO
	ktime	timeinsts				;TIME ELAPSED SINCE THIS INSTRUMET STARTED
	ktrig	changed	klayers				;TRIGGER GENBERATED IF klayers CHANGES
	ktrig	=		(ktime<0.1?0:ktrig)	;OVERWRITE FIRST K-PASS TRIGGER WITH A ZERO (ERONEOUS)
	if ktrig=1 then					;IF A TRIGGER IS RECEIVED (CHANGE IN klayers)...
	 turnoff2	iInstr,0,0			;TURN OFF ALL INSTANCES OF THE CALLED INSTRUMENT IMMEDIATELY (TRUNCATING RELEASE SEGMENTS)
	 reinit	DelayedTrigger				;BEGIN A REINITIALISATION PASS FROM THE LABEL 'DelayedTrigger' (THIS IS IDONE IN CASE TWO TRIGGERINGS OCCUR WITHIN A SINGLE DELAY PERIOD)
	endif						;END OF CONDITIONAL BRANCH
	DelayedTrigger:					;A LABEL
	ktrigdelay	delayk	ktrig,0.01		;DELAYED VERSION OF THE 'TURN OFF LAYERS' TRIGGER. INSTRUMENT RESTART MUST HAPPEN AFTER A SMALL DELAY.
	rireturn					;RETURN FROM REINITIALISATION BACK TO NORMAL PERFORMANCE (k-time)
	if ktrigdelay=1 then				;IF THE DELAYED TRIGGER IS RECEIVED (0.01 SECONDS AFTER THE TURN OFF TRIGGER)
	 reinit RESTART					;REINITIALISE FROM THE LABEL 'RESTART', TO START A NEW INSTRUMENT LAYER STACK
	endif						;END OF CONDITIONAL BRANCH
	RESTART:					;A LABEL. INSTRUMENT LAYERING BEGINS FROM HERE
	icount	=	1				;COUNTER
	ilayers	=	i(klayers)			;I-TIME VERSION OF klayers
	if ilayers=0 igoto SKIP				;IF klayers=0 - I.E. NO LAYERS - SKIP INSTRUMENT LAYER CREATION COMPLETELY
	LOOP:						;A LABEL, LOOPING JUMPS BACK TO HERE
	event_i "i",iInstr,0,idur,icount		;CALL AN INSTRUMENT LAYER. SEND THE INSTRUMENT ITS LAYER NUMBER VIA p4
	loop_le	icount,1,ilayers,LOOP			;LOOP BACK UNTIL WE HAVE COMPLETED STARTING ALL LAYERS
	SKIP:						;SKIP TO HERE IF ZERO LAYERS WAS CHOSEN
endop
