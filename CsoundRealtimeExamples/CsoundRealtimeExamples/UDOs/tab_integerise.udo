; INTEGERISE MEMBERS OF A FUNCTION TABLE INTO DESCENDING ORDER
; ifn  --  number of table which will be modified

opcode	tab_integerise,0,i
	ifn		xin
	iNumItems	=	ftlen(ifn)
	icount		=	0
	loop:
	ival		table	icount,ifn
	ival		=	int(ival)
			tableiw	ival,icount,ifn
			loop_lt	icount,1,iNumItems,loop
endop

