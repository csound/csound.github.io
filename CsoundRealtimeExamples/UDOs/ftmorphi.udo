			opcode 		ftmorfi,0,iii
iindex,itabs,imorftab	xin
itab1			table		int(iindex),itabs
itab2			table		int(iindex)+1,itabs
ilen			=		ftlen(imorftab)
igain1			=		1-frac(iindex)
igain2			=		frac(iindex)
			tableimix	imorftab,0,ilen,itab1,0,igain1,itab2,0,igain2
			endop

