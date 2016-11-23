<CsoundSynthesizer>

<CsOptions>
-odac -dm0
</CsOptions>

<CsInstruments>

sr = 44100
ksmps = 1
nchnls = 1
0dbfs = 1



opcode	AmpLimit,a,aiii
 asig,imax,iatt,irel	xin
 krms		init	0			; RMS value initialised for first control period
 kGainCtrl	init	1			; amplitude gain initially set to unity
 if krms>(imax*0.5) then				; if RMS of input signal exceeds maximum allowed value...
  kGainCtrl	limit	kGainCtrl - iatt, 0, 1	; ...reduce amplitude gain value (within the limits: total attenuation and unity)
 else						; otherwise...
  kGainCtrl	limit	kGainCtrl + irel, 0, 1	; increase the amplitude gain value (within the limits: total attenuation and unity)
 endif
 aGainCtrl	interp	kGainCtrl		; interpolate amplitude gain control to create a smoother a-rate version 
 aGainCtrl	tone	aGainCtrl,100		; damp amplitude gain control changes
 asig	=	asig * aGainCtrl		; apply amplitude gain
 krms		rms	asig, 1000		; measure RMS of output signal for use in the next control cycle
 printk 0.1,krms
	xout	asig
endop



instr	1
 icos	ftgen		0,0,131072,11,1
 kamp	expseg		0.001, p3*0.5, 8, p3*0.5, 0.001
 asig	gbuzz		kamp, 40,80,1,0.7,icos
 aout	AmpLimit	asig, 0.9, 0.1, 0.1
 	out		aout
endin


</CsInstruments>  

<CsScore>
i 1 0 10
</CsScore>

</CsoundSynthesizer>