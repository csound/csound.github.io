		opcode	cpstun2,k,kk
knote,ktable	xin
ktrig		changed	knote 
kcpsLo 		cpstun	ktrig, int(knote), ktable
kcpsUp 		cpstun	ktrig, int(knote)+1, ktable
koctLo		=	octcps(kcpsLo)
koctUp		=	octcps(kcpsUp)
koct		=	koctLo+((koctUp-koctLo)*frac(knote))
kcps		=	cpsoct(koct)
		xout	kcps
		endop

