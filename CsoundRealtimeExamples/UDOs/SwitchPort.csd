SwitchPort.csd
Written by Iain McCurdy, 2012

<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>
sr	=	44100	
ksmps	=	32
nchnls	=	1
0dbfs	=	1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255, 0, 0, 0
		FLpanel	"UDO - Switch Port", 500, 430, 0, 0

;VALUE DISPLAY BOXES		LABEL | WIDTH | HEIGHT | X  | Y
idoct			FLvalue	"",	 50,      16,    5,   35
idUpPort		FLvalue	"",	 50,      16,    5,   85
idDnPort		FLvalue	"",	 50,      16,    5,  135

;SLIDERS				            				MIN   |  MAX | EXP | TYPE |   DISP   | WIDTH | HEIGHT | X  | Y
gkoct, ihoct		FLslider 	"Octave (input / kin)",			6,       12,    0,   23,    idoct,      490,     25,    5,   10
gkUpPort, ihUpPort	FLslider 	"Portamento Time (Up / kUpPort)",	0.0001,   5,   -1,   23,    idUpPort,   490,     25,    5,   60
gkDnPort, ihDnPort	FLslider 	"Portamento Time (Down / kDnPort)",	0.0001,   5,   -1,   23,    idDnPort,   490,     25,    5,  110
gkgain, ihgain		FLslider 	"Gain",					0,        1,    0,   23,    -1,         490,     25,    5,  160

;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"kout", 								1,      5,     12,     25,    20,    20,  210
ih		 	FLbox  	"SwitchPort", 								1,      6,     12,     90,    20,    50,  210
ih		 	FLbox  	"kin,kUpPort,kDnPort", 							1,      5,     12,    160,    20,   140,  210
ih		 	FLbox  	"Performance                                                         ", 1,      7,     12,    490,    20,     5,  230
ih		 	FLbox  	"kin     --  Input signal.                                           ", 1,      5,     12,    490,    20,     5,  250
ih		 	FLbox  	"kUpPort --  Portamento time when the input signal is rising.        ", 1,      5,     12,    490,    20,     5,  270
ih		 	FLbox  	"kDnPort --  Portamento time when the input signal is falling.       ", 1,      5,     12,    490,    20,     5,  290
ih		 	FLbox  	"---", 									1,      5,     12,    490,    10,     5,  310
ih		 	FLbox  	"Applies portamento filtering to a k-rate signal. The portamento time", 1,      5,     12,    490,    20,     5,  320
ih		 	FLbox  	"employed will switch between two values depending upon whether the  ", 1,      5,     12,    490,    20,     5,  340
ih		 	FLbox  	"input value is rising or falling.                                   ", 1,      5,     12,    490,    20,     5,  360
ih		 	FLbox  	"This UDO can be useful when using more unusual sensors or           ", 1,      5,     12,    490,    20,     5,  380
ih		 	FLbox  	"controllers for data input.                                         ", 1,      5,     12,    490,    20,     5,  400
                                                                                                      
;SET INITIAL VALUES FOR VALUATORS 	VALUE | HANDLE
			FLsetVal_i	8, 	ihoct
			FLsetVal_i	0.01, 	ihUpPort
			FLsetVal_i	5, 	ihDnPort
			FLsetVal_i	0.5, 	ihgain

		FLpanel_end	; END OF PANEL CONTENTS


		FLrun		;RUN THE WIDGET THREAD

; Performance
; kin     -- Input signal.
; kUpPort -- Portamento time when the input signal is rising.
; kDnPort -- Portamento time when the input signal is falling.
opcode	SwitchPort, k, kkk
	kin,kUpPort,kDnPort	xin
	kold			init	0
	kporttime		=	(kin<kold?kDnPort:kUpPort)
	kout			portk	kin, kporttime
	kold			=	kout
				xout	kout
endop

instr	1
	koct	SwitchPort	gkoct,gkUpPort,gkDnPort
	asig	vco2		0.2*gkgain,cpsoct(koct),4,0.5
		out		asig
endin

</CsInstruments>

<CsScore>
i 1 0 3600	  
</CsScore>

</CsoundSynthesizer>
