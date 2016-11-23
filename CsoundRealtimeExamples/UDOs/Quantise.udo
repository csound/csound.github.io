; Quantise
; -------------
; Quantises a value according to a user-defined grid value and offset
;
; kOutVal   Quantise   kInVal, kQVal, kQOffset
;
; Performance
; --------------
; kInVal  --  raw value to which quantisation is to be applied 
; kQVal   --  quantisation or 'grid pitch' value
; kQffset --  an offset value. This value will also correspond to a quantisation node.

opcode	Quantise,k,kkk
 kInVal, kQVal, kQOffset    xin
 kOutVal			        =		 (round((kInVal - kQOffset)/kQVal) * kQVal) + kQOffset
		 			xout	kOutVal
endop