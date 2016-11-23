		opcode	cpstuni2,i,ii
inote,itable	xin
icpsLo 		cpstuni	int(inote), itable
icpsUp 		cpstuni	int(inote)+1, itable
ioctLo		=	octcps(icpsLo)
ioctUp		=	octcps(icpsUp)
icps		=	cpsoct(ioctLo+((ioctUp-ioctLo)*frac(inote)))
			xout	icps			
endop

