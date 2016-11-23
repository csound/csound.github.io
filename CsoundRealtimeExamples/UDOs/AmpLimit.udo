; AmpLimit
; ----------------
; Amplitude limiter.
; Intended use is in situations where vast increases in amplitude may be possible such as when working with filters and physical models.
;

; aout  AmpLimit  ain,imax,iatt,irel

; Performance
; -----------
; ain   -  audio input signal

; Initialisation
; --------------
; imax  -  maximum amplitude level before limiting is applied
; iatt  -  rate at which amplitude gain is reduced when imax is exceeded. The actual rate will also depend upon the control rate.
; irel  -  rate at which amplitude gain is increased once the amplitude of the input signal return below imax. 
;            The actual rate will also depend upon the control rate.


opcode	AmpLimit,a,aiii
 asig,imax,iatt,irel	xin
 krms		init	0			; RMS value initialised for first control period
 kGainCtrl	init	1			; amplitude gain initially set to unity
 if krms>(imax*0.17) then				; if RMS of input signal exceeds maximum allowed value...
  kGainCtrl	limit	kGainCtrl - iatt, 0, 1	; ...reduce amplitude gain value (within the limits: total attenuation and unity)
 else						; otherwise...
  kGainCtrl	limit	kGainCtrl + irel, 0, 1	; increase the amplitude gain value (within the limits: total attenuation and unity)
 endif
 aGainCtrl	interp	kGainCtrl		; interpolate amplitude gain control to create a smoother a-rate version 
 aGainCtrl	tone	aGainCtrl,1		; damp amplitude gain control changes
 asig	=	asig * aGainCtrl		; apply amplitude gain
 krms		rms	asig, 1000		; measure RMS of output signal for use in the next control cycle
	xout	asig
endop
