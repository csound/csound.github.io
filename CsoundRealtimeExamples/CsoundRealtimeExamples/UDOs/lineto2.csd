<CsoundSynthesizer>

<CsOptions>
-odac -dm0 -M0 -+rtmidi=virtual
</CsOptions>

<CsInstruments>

sr = 44100
ksmps = 64
nchnls = 2
0dbfs = 1
maxalloc	2,1					; restrict polyphony of instr 2 to '1'/monophonic.
gicos	ftgen	0,0,131072,11,1				; cosine wave needed by gbuzz



opcode	lineto2,k,kk
 kinput,ktime	xin
 ktrig	changed	kinput,ktime				; reset trigger
 if ktrig==1 then					; if new note has been received or if portamento time has been changed...
  reinit RESTART
 endif
 RESTART:						; restart 'linseg' envelope
 if i(ktime)==0 then					; 'linseg' fails if duration is zero...
  koutput	=	i(kinput)			; ...in which case output simply equals input
 else
  koutput	linseg	i(koutput),i(ktime),i(kinput)	; linseg envelope from old value to new value
 endif
 rireturn
 		xout	koutput
endop



gknote	init	60

instr	1				; note on/off and note number registering instrument. this instrument will be triggered by notes played on the midi keyboard
	inote		notnum		; read in midi note number	
	gknote	=	inote		; create a k-rate global variable version of midi note number that will be used in instrument 2.
	event_i	"i",2,0,-1		; the very first midi note played will trigger an infinitely held note in instr 2. the maxalloc setting in the orchestra header will prevent any further triggerings. 
endin

instr	2				;sound producing instrument
	kactive	active	1		; sense number of active instances of instr 1
	if kactive==0 then		; all no instances of instr 1 are playing, i.e. if all midi notes have been released...
	 turnoff			; turn this instrument off
	endif
	
	; create portamento on pitch parameter
	kporttime	linseg	0,0.01,0.1					;portamento time rises quickly to a held value (0.1)
	knote		lineto2	gknote, kporttime				;apply portamento to note changes
	aenv	linsegr	0,0.01,1,0.01,0						;amplitude envelope. senses note release
	asig		gbuzz	0.3*aenv,cpsmidinn(knote),50,1,0.6,gicos	;gbuzz oscillator

			outs	asig,asig	
endin


</CsInstruments>  

<CsScore>
</CsScore>

</CsoundSynthesizer>