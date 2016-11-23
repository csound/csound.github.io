FLvalue.csd
Written by Iain McCurdy, 2006. Updated 2011.

<CsoundSynthesizer>

<CsOptions>
-odac -d
</CsOptions>

<CsInstruments>

;USING THE OPCODE FLvalue TO DISPLAY THE OUTPUT OF A SLIDER 

sr		=	44100
ksmps		=	64
nchnls		=	2
0dbfs		=	1	;MAXIMUM AMPLITUDE REGARDLESS OF BIT DEPTH

FLcolor	255,255,255,0,0,0	;SET THE COLOUR SCHEME
		FLpanel	"Value Display Box", 900, 400, 50, 50
		
iwidth		=	120	;WIDTH OF THE VALUE DISPLAY BOX IN PIXELS                                            
iheight		=	20	;HEIGHT OF THE VALUE DISPLAY BOX IN PIXELS                                           
ix		=	25	;DISTANCE OF THE LEFT EDGE OF THE VALUE DISPLAY BOX FROM THE LEFT EDGE OF THE PANEL  
iy		=	60	;DISTANCE OF THE TOP EDGE OF THE VALUE DISPLAY BOX FROM THE TOP EDGE OF THE PANEL    
idisp		FLvalue	"Hertz (FLvalue)", iwidth, iheight, ix, iy

gkfreq, ihandle	FLslider	"Frequency", 10, 5000, -1, 5, idisp, 850, 30,  25, 10
		FLsetVal_i	500, ihandle

;THE FREQUENCY VALUE OF THE SLIDER IS PARSED INTO A NOTE NAME AND OCTAVE NUMBER AND PRINTED TO A TEXT BOX FROM INSTR 2		
gihNoteName	 FLbox  "   ", 	3,    1,   14, 100, 20,150,60	;A TEXT BOX - USED TO DISPLAY THE NOTE NAME

ih		 FLbox  "Name (FLbox)",1,  1,   14, 100, 20,150,80	;A TEXT BOX - USED TO DISPLAY THE NOTE NAME

;A VALUE INPUT BOX IS USED, NOT TO INPUT A VALUE, BUT TO DISPLAY ONE BY USING FLsetVal IN INSTR 3
;VALUE INPUT BOX					MIN | MAX | STEP | TYPE | WIDTH | HEIGHT | X | Y
gk, gihNoteNum	FLtext		"Note Num.(FLtext)",	0,    127,   0,     1,    120,      20,   255, 60


gidpch		FLvalue	"'pch' (FLvalue)", 120, 20, 380, 60


FLcolor	200, 200, 255, 0, 0, 50	;SET INTERFACE COLOURS
ih	 FLbox  "                                                          FLvalue                                                              ", 		1,    5,   12, 900, 20,0,120
ih	 FLbox  "-------------------------------------------------------------------------------------------------------------------------------", 		1,    5,   12, 900, 20,0,140
ih	 FLbox  "FLvalue creates a box which outputs, in numerical form, the current value of a valuator widget. It communicates with the       ", 		1,    5,   12, 900, 20,0,160
ih	 FLbox  "valuator via its display handle.                                                                                               ", 		1,    5,   12, 900, 20,0,180
ih	 FLbox  "Normally the slider communicates internally with the value box so cannot pre-process or format the values it outputs. There are", 		1,    5,   12, 900, 20,0,200
ih	 FLbox  "some other options however. We can process its values within an instrument in the orchestra and send them back as numbers to an", 		1,    5,   12, 900, 20,0,220
ih	 FLbox  "FLtext box or as a string to an FLbox. In this example instr 2 converts the frequency values to a text string of the note name ", 		1,    5,   12, 900, 20,0,240
ih	 FLbox  "followed by the octave number and prints it to the 2nd box along. Instr 3 converts the frequency to a MIDI note number (rounded", 		1,    5,   12, 900, 20,0,260
ih	 FLbox  "down to the next integer number) and updates the FLtext box, the third box along.                                              ", 		1,    5,   12, 900, 20,0,280
ih	 FLbox  "The opcodes 'FLprintk' and 'FLprintk2' facilitate direct communication from within an instrument to an FLvalue box using its   ", 		1,    5,   12, 900, 20,0,300
ih	 FLbox  "display handle. FLprintk prints periodically with a user prescribed time gap between printings. FLprintk2 prints a value each  ", 		1,    5,   12, 900, 20,0,320
ih	 FLbox  "time the k-rate changes. In the case of a slider this can lead to many rapid printings which can affect realtime performance.  ", 		1,    5,   12, 900, 20,0,340
ih	 FLbox  "It is not necessary to print more that about 15 times a second so we can limit the maximum rate of reprinting using a 'metro'  ", 		1,    5,   12, 900, 20,0,360
ih	 FLbox  "trigger metronome. This technique is implemented in instr 4 which writes 'pch' format values to the fourth box along.          ", 		1,    5,   12, 900, 20,0,380

		FLpanel_end	;END OF PANEL CONTENTS
		FLrun		;RUN THE WIDGET THREAD!

giwave		ftgen	3, 0, 4096, 10, 1,1/2,1/4,1/8,1/16,1/32,1/64,1/128,1/256,1/512,1/1024	;A RICH HARMONIC WAVEFORM

instr 1
	kporttime	linseg	0,0.001,0.005,1,0.005	;CREATE A VARIABLE FUNCTION THAT RAPIDLY RAMPS UP TO A SET VALUE
	kfreq		portk	gkfreq, kporttime	;SMOOTH SLIDER VARIABLE
	afreq		interp	kfreq		;INTERPOLATE AND CREATE AN AUDIO RATE VERSION OF K-RATE VARIABLE
	ifn		=	1
	asig		oscili	0.1, afreq, giwave
			outs	asig, asig
endin	


instr	2	;WRITE FREQUENCY AS NOTE NAME AND OCTAVE NUMBER
	koct		=	octcps(gkfreq)		;CONVERT FREQUENCY TO 'OCT' FORMAT
	kpch		=	pchoct(koct)		;CONVERT 'OCT' FORMAT TO 'PCH' FORMAT
	kOctNum		=	int(kpch)		;REMOVE FRACTIONAL PART OF 'PCH' VALUE TO DERIVE OCTAVE NUMBER
	kSemiNum	=	int(frac(kpch)*100)	;REMOVE NON-FRACTIONAL PART OF 'PCH' VALUE, MULTIPLY BY 100, THEN INTEGERIZE TO DERIVE THE SEMITONE STEPS ABOVE C
	ktrig		changed	kSemiNum,kOctNum	;IF SEMITONE STEP NUMBER OR OCTAVE NUMBER CHANGES GENERATE A TRIGGER IMPULSE
	if ktrig==1 then				;IF SEMITONE STEP NUMBER OR OCTAVE NUMBER CHANGE...
	  reinit	UPDATE				;BEGIN A REINITIALISATION FROM LABEL 'UPDATE'
	endif						;END OF CONDITIONAL BRANCH
	UPDATE:						;LABEL 'UPDATE'. REINITIALISATION BEGINS FROM HERE.
	iOctNum	init	i(kOctNum)			;CREATE INIT TIME VERSION
	iSemiNum	init	i(kSemiNum)		;CREATE INIT TIME VERSION
	;GO THROUGH A SERIES OF CONDITIONALS TO DERIVE A STRING VARIABLE OF THE NOTE NAME
	if iSemiNum==0 then				
	  SNoteName	=	"C"
	elseif iSemiNum==1 then
	  SNoteName	=	"C#"
	elseif iSemiNum==2 then
	  SNoteName	=	"D"
	elseif iSemiNum==3 then
	  SNoteName	=	"D#"
	elseif iSemiNum==4 then
	  SNoteName	=	"E"
	elseif iSemiNum==5 then
	  SNoteName	=	"F"
	elseif iSemiNum==6 then
	  SNoteName	=	"F#"
	elseif iSemiNum==7 then
	  SNoteName	=	"G"
	elseif iSemiNum==8 then
	  SNoteName	=	"G#"
	elseif iSemiNum==9 then
	  SNoteName	=	"A"
	elseif iSemiNum==10 then
	  SNoteName	=	"A#"
	elseif iSemiNum==11 then
	  SNoteName	=	"B"
	endif
	SNoteNameOct	sprintf	"%s%d",SNoteName,iOctNum	;CONCATONATE THE NOTE NAME AND THE OCTAVE NUMBER
	FLsetText	SNoteNameOct, gihNoteName		;UPDATE THE TEXT IN THE FLTK BOX
endin

instr	3	;WRITE FREQUENCY AS MIDI NOTE NUMBER
	koct		=	octcps(gkfreq)				;CONVERT FREQUENCY TO 'OCT' FORMAT
	kNoteNum	=	int((koct-3)*12)			;CONVERT 'OCT' FORMAT TO MIDI NOTE NUMBER AND INTEGERIZE (REMOVE FRACTIONAL PART)
	ktrig		changed	kNoteNum				;IF NOTE NUMBER CHANGES GENERATE A TRIGGER IMPULSE
			FLsetVal	ktrig,kNoteNum,gihNoteNum	;UPDATE THE NUMBER IN THE FLtext BOX
endin

instr	4	;WRITE FREQUENCY AS 'PCH' FORMAT
	koct		=	octcps(gkfreq)		;CONVERT FREQUENCY TO 'OCT' FORMAT
	kpch		=	pchoct(koct)		;CONVERT 'OCT' FORMAT TO 'PCH' FORMAT
	kmetro	metro	15		;LIMIT REPRINTINGS TO 15 PER SECOND
	if kmetro==1 then
	  FLprintk2	kpch,gidpch	;PRINT kpch TO VALUE BOX IF IT HAS CHANGED
	endif
endin

</CsInstruments>

<CsScore>
i 1 0 3600		;PLAYS TONE
i 2 0 3600		;CONVERTS TO NOTE NAME AND OCTAVE NUMBER
i 3 0 3600		;CONVERTS TO MIDI NOTE NUMBER
i 4 0 3600		;CONVERTS TO MIDI 'PCH'
</CsScore>

</CsoundSynthesizer>