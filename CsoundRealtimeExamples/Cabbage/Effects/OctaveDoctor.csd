; clfilt.csd
; Written by Iain McCurdy, 2012.

; Port.		-	portamento applied to changes that are made to 'Freq.'

<Cabbage>
form caption("Octave Doctor") size(500,250), pluginID("OcDo")
image bounds(0, 0, 500,250), colour(100,40, 40), shape("rounded"), outlinecolour("white"), outlinethickness(4);, file("BrushedMetal.png") 

image bounds(  4,  4, 50,242), colour(0,0,0,0), outlinecolour("grey"), outlinethickness(2), plant("Voice1") {
label   bounds(  6,  2, 40, 12), text("Voice 1"), align("centre")
vslider bounds( 15, 16, 20,120), channel("Level1"), range(0,1,0.6), trackercolour("silver")
label   bounds(  6,130, 40, 12), text("Level"), align("centre")
hslider bounds(  2,150, 48, 10), channel("Pan1"), range(0,1,0.3), trackercolour("silver")
label   bounds(  6,160, 40, 12), text("Pan"), align("centre")
numberbox bounds( 5,180, 40, 30), channel("Divider1"), range(1,16,2,1,1), text("Div.")
}

image bounds(  56,  4, 50,242), colour(0,0,0,0), outlinecolour("grey"), outlinethickness(2), plant("Voice2") {
label   bounds(  6,  2, 40, 12), text("Voice 2"), align("centre")
vslider bounds( 15, 16, 20,120), channel("Level2"), range(0,1,0.6), trackercolour("silver")
label   bounds(  6,130, 40, 12), text("Level"), align("centre")
hslider bounds(  2,150, 48, 10), channel("Pan2"), range(0,1,0.7), trackercolour("silver")
label   bounds(  6,160, 40, 12), text("Pan"), align("centre")
numberbox bounds( 5,180, 40, 30), channel("Divider2"), range(1,16,4,1,1), text("Div.")
}

image bounds( 108,  4, 50,242), colour(0,0,0,0), outlinecolour("grey"), outlinethickness(2), plant("Live") {
label   bounds(  6,  2, 40, 12), text("Live"), align("centre")
vslider bounds( 15, 16, 20,120), channel("LevelLive"), range(0,1,0.6), trackercolour("silver")
label   bounds(  6,130, 40, 12), text("Level"), align("centre")
hslider bounds(  2,150, 48, 10), channel("PanLive"), range(0,1,0.5), trackercolour("silver")
label   bounds(  6,160, 40, 12), text("Pan"), align("centre")
}

image bounds( 160,  4, 50,242), colour(0,0,0,0), outlinecolour("grey"), outlinethickness(2), plant("Filter") {
label   bounds(  6,  2, 40, 12), text("Filter"), align("centre")
vrange  bounds( 10, 16, 30,120), channel("FiltMin","FiltMax"), range(4,14,8:13,1,0.01), trackercolour("silver")
label   bounds(  6,130, 40, 12), text("Cutoff"), align("centre")
}

</Cabbage>

<CsoundSynthesizer>

<CsOptions>
-d -n
</CsOptions>

<CsInstruments>

sr 		= 	44100	;SAMPLE RATE
ksmps 		= 	32	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	2	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1

;Author: Iain McCurdy (2016)

opcode	SwitchPort, k, kii
	kin,iupport,idnport	xin
	kold			init	0
	kporttime		=	(kin<kold?idnport:iupport)
	kout			portk	kin, kporttime
	kold			=	kout
				xout	kout
endop

opcode	OctaveDivider,a,akkkk
	ain,kdivider,krms,kInputFilt,kRes	xin
		setksmps	1		;SET kr=sr, ksmps=1 (sample)
	kcount	init		0		;COUNTER USED TO COUNT ZERO CROSSINGS
	kout	init		-1		;INITIAL DISPOSITION OF OUTPUT SIGNAL
	ain	butlp		ain,kInputFilt	;LOWPASS FILTER THE INPUT SIGNAL (TO REMOVE SOME HF OVERTONE MATERIAL)
	ain	butlp		ain,kInputFilt	;LOWPASS FILTER THE INPUT SIGNAL (TO REMOVE SOME HF OVERTONE MATERIAL)
	ain	butlp		ain,kInputFilt	;LOWPASS FILTER THE INPUT SIGNAL (TO REMOVE SOME HF OVERTONE MATERIAL)
	ksig	downsamp	ain		;CREATE A K-RATE VERSION OF THE INPUT AUDIO SIGNAL
	ktrig	trigger		ksig,0,2	;IF THE INPUT AUDIO SIGNAL (K-RATE VERSION) CROSSES ZERO IN EITHER DIRECTION, GENERATE A TRIGGER
	if ktrig==1 then			;IF A TRIGGER HAS BEEN GENERATED...
	 kcount	wrap	kcount+1,0,kdivider	;INCREMENT COUNTER BUT WRAPAROUND ACCORDING TO THE NUMBER OF FREQUENCY DIVISIONS REQUIRED
	 if kcount=0 then			;IF WE HAVE COMPLETED A DIVISION BLOCK (I.E. COUNTER HAS JUST WRAPPED AROUND)...
	  kout =	(kout=-1?1:-1)		;FLIP THE OUTPUT SIGNAL BETWEEN -1 AND 1 (THIS WILL CREATE A SQUARE WAVE)
	 endif
	endif
	aout	upsamp		kout		;CREATE A-RATE SIGNAL FROM K-RATE SIGNAL

; aout		moogladder		aout, cpsoct(8+(6*(krms^0.5)))/kdivider, kRes

			xout		aout*krms	;SEND AUDIO BACK TO CALLER INSTRUMENT, SCALE ACCORDING TO THE ENVELOPE FOLLOW OF THE INPUT SIGNAL

endop

giPanFnL	ftgen	0,0,4096,9,0.25,1,90
giPanFnR	ftgen	0,0,4096,9,0.25,1,0
giRMSshape	ftgen	0,0,4096,16,0,4096,4,1

instr	1	; widgets input
 kLevel1	chnget	"Level1"
 kLevel2	chnget	"Level2" 
 kLevelLive	chnget	"LevelLive" 
 kPan1		chnget	"Pan1"
 kPan2		chnget	"Pan2" 
 kPanLive	chnget	"PanLive" 
 kDivider1	chnget	"Divider1"
 kDivider2	chnget	"Divider2"
 kFiltMin	chnget	"FiltMin"
 kFiltMax	chnget	"FiltMax"

 aInL,aInR	ins
 
 ;aInL,aInR	diskin2	"flute.wav",1,0,1
 
 krmsL	rms		aInL
 krmsPL	SwitchPort	krmsL,0.05,0.3
 krmsR	rms		aInR
 krmsPR	SwitchPort	krmsR,0.05,0.3
 
 kInputFilt	=				800
 kRes		=				0.4
 aOut1L		OctaveDivider	aInL,kDivider1,krmsPL,kInputFilt,kRes
 aOut1R		OctaveDivider	aInR,kDivider1,krmsPR,kInputFilt,kRes

 aOut2L		OctaveDivider	aInL,kDivider2,krmsPL,kInputFilt,kRes
 aOut2R		OctaveDivider	aInR,kDivider2,krmsPR,kInputFilt,kRes

 aMixL		sum				aInL*table(kPanLive,giPanFnL,1)*kLevelLive, aOut1L*table(kPan1,giPanFnL,1)*kLevel1, aOut2L*table(kPan2,giPanFnL,1)*0.7*kLevel2
 aMixR		sum				aInR*table(kPanLive,giPanFnR,1)*kLevelLive, aOut1R*table(kPan1,giPanFnR,1)*kLevel1, aOut2R*table(kPan2,giPanFnR,1)*0.3*kLevel2
 
 ; vrange not working right in current Cabbage distro
 ;kCF		=				cpsoct(kFiltMin+( (kFiltMax-kFiltMin) * (krmsL^0.5) ) )
 kCF		=				cpsoct(kFiltMin+(          6          * (krmsL^0.5) ) )
 aMixL		moogladder		aMixL, a(kCF), kRes
 aMixR		moogladder		aMixR, a(kCF), kRes

 aMixL		buthp			aMixL, 50
 aMixR		buthp			aMixR, 50

 kampL		tablei			krmsL, giRMSshape, 1
 kampR		tablei			krmsR, giRMSshape, 1
 
   			outs	aMixL*kampL, aMixR*kampR
endin
		
</CsInstruments>

<CsScore>
i 1 0 [3600*24*7]
</CsScore>

</CsoundSynthesizer>
