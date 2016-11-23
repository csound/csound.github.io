; adsynt_adsynt2.csd
; Written by Iain McCurdy, 2015.

<CsoundSynthesizer>

<CsOptions>
-odac -dm0 -M0 -+rtmidi=virtual
; --displays
</CsOptions>

<CsInstruments>

sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
;			LABEL            | WIDTH | HEIGHT | X | Y
		FLpanel	"adsynt asdynt2",   500,    300,    0,  0

;SWITCHES                                            	ON | OFF | TYPE | WIDTH | HEIGHT | X  | Y | OPCODE | INS | STARTTIM | DUR	p4	p5	p6	p7	p8	p9	p10	p11	p12	p13	p14	p15	p16	p17	p18	p19	p20	p21	p22	p23	p24	p25	p26	p27	p28	p29	p30	p31	p32	p33
gkOnOff, ihOnOff	FLbutton	"On/Off(MIDI)",	1,    0,    22,    120,     25,    5,    5,    0,     1,      0,      3600
FLsetColor2	255, 255, 50, ihOnOff	;SET SECONDARY COLOUR TO YELLOW

;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,    255,   255,   255		;LABELS MADE INVISIBLE (I.E. SAME COLOR AS PANEL)
;			FLBUTBANK 	TYPE | NUMX | NUMY | WIDTH | HEIGHT | X | Y | IOPCODE | P1 | P2 | P3
gkOpcode, ihOpcode	FLbutBank	1,      1,     2,     20,      40,  200,  5,    -1
;GENERAL_TEXT_SETTINGS			SIZE | FONT |  ALIGN | RED | GREEN | BLUE
			FLlabel		13,      1,      3,     0,     0,     0			;LABELS MADE VISIBLE AGAIN
;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"adsynt ", 	1,      5,     14,    60,     20,    225, 5
ih		 	FLbox  	"adsynt2", 	1,      5,     14,    60,     20,    225,25

;VALUE DISPLAY BOXES					WIDTH | HEIGHT | X | Y
idamp			FLvalue	"",     		40,       17,    5, 75
idfrq			FLvalue	"",     		40,       17,    5,125
idmorf			FLvalue	"",     		40,       17,    5,175
idpeak			FLvalue	"",     		40,       17,    5,225
idshift			FLvalue	"",     		40,       17,    5,275

;SLIDERS				       	MIN  | MAX | EXP | TYPE | DISP   | WIDTH | HEIGHT | X | Y
gkamp, ihamp		FLslider "Amplitude",	0,      1,    0,    23,   idamp,    490,     25,    5,  50
gkfrq, ihfrq		FLslider "Frequency",	20,    5000, -1,    23,   idfrq,    490,     25,    5, 100
gkmorf, ihmorf		FLslider "Morph",	0,      1,    0,    23,   idmorf,   490,     25,    5, 150
gkpeak, ihpeak		FLslider "Peak",	0,    200,    0,    23,   idpeak,   490,     25,    5, 200
gkshift, ihshift	FLslider "Shift",	0,      1,    0,    23,   idshift,  490,     25,    5, 250

;SET INITIAL VALUES
FLsetVal_i	0.1,  ihamp
FLsetVal_i	300,  ihfrq
FLsetVal_i	0,    ihmorf
FLsetVal_i	50,   ihpeak
FLsetVal_i	0.5,  ihshift


		FLpanel_end	;END OF PANEL CONTENTS

;INSTRUCTIONS AND INFO PANEL
				FLpanel	" ", 500, 140, 512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                        adsynt adsynt2                       ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"adsynt and adsynt2 are used to conveniently implement        ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"additive synthesis particularly with inharmonic spectra.     ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"The two opcodes are very similar; the sole difference being  ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"that adsynt2 employs linear interpolation to smooth changes  ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"in amplitude.                                                ", 	1,      5,     14,    490,    15,     5, 120
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 140
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 160
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 180
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 200
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 220
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 240
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 420
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"", 	1,      5,     14,    490,    15,     5, 540

				FLpanel_end

				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gisine	ftgen	0,0,131072,10,1

;albert clock bell belfast
girtos21	ftgen	0,0,-22,-2, 	2.043260,1.482916,1.000000,3.328848,4.761811,1.477056,0.612007,2.661295,1.002793,4.023776,0.254139,2.043916,4.032463,2.659438,4.775560,5.500494,3.331014,0.809697,2.391301, 0.254098,1.901476,2.366563    ;,0.614968,2.046543,1.814887,3.130744,2.484426,0.558874,0.801697,0.070870,3.617036,2.782656
giamps21_1	ftgen	0,0,-22,-7,	1,22,1	; flat amplitude response curve
giFiltTab	ftgen	1,0,-22,20,7,1,50	; kaiser window curve
giTabs4Morf21	ftgen	0,0,2,-2,giamps21_1,giFiltTab

instr	2
 ktrig	changed	gkpeak,gkshift
 if ktrig==1 then
  reinit REBUILD_TABLE
 endif
 REBUILD_TABLE:
 giPeakTab	ftgen	1,0,-22,20,7,1,i(gkpeak)
 icount	=	0
 loop:
 ;print	ftlen(giFiltTab)
 ival	tablei	(icount/(ftlen(giFiltTab)-1)) - 0.5 + i(gkshift),giPeakTab,1,0,1	; raw index, no wrap
 	tableiw	ival, icount, giFiltTab
 ival	table	icount,giFiltTab
 ;printf_i	"count:%d  val:%f\n", 1, icount, ival 
 loop_lt	icount,1,ftlen(giPeakTab),loop
 
endin

instr	1
 iMIDIActiveValue	=	1		;IF MIDI ACTIVATED
 iMIDIflag		=	0		;IF FLTK ACTIVATED
 mididefault	iMIDIActiveValue, iMIDIflag	;IF NOTE IS MIDI ACTIVATED REPLACE iMIDIflag WITH iMIDIActiveValue 
 if gkOnOff==0&&iMIDIflag==0 then
  turnoff
 endif
 kamp	transeg	1,p3,-4,1
 if iMIDIflag==0 then
  kcps	=	gkfrq
  kmorf	=	gkmorf
 else
  kcps	init	cpsmidi:i()
  kmorf	init	ampmidi:i(1)
 endif
 iwfn	=	gisine
 ifreqfn=	girtos21
 icnt	=	ftlen(ifreqfn)
 iMorfTab	ftgentmp	0,0,-ftlen(ifreqfn),-2,0	
 ktrig	changed	gkpeak,gkshift
 if ktrig==1 then
  reinit REINIT_FTMORF
 endif
 REINIT_FTMORF:
 	ftmorf	kmorf, giTabs4Morf21, iMorfTab				; MORPH BETWEEN UNSCALED SPECTRUM AND SCALED SPECTRUM
 rireturn
 kEnv	linsegr	0,0.01,1,0.05,0	
 if gkOpcode==0 then
  asig	adsynt	gkamp*0.1*kEnv, kcps, iwfn, ifreqfn, iMorfTab, icnt
 else
  asig	adsynt2	gkamp*0.1*kEnv, kcps, iwfn, ifreqfn, iMorfTab, icnt
 endif
	outs	asig, asig
endin


</CsInstruments>

<CsScore>
i 2 0 3600
e
</CsScore>

</CsoundSynthesizer>
