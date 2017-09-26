; APPLY A RETROGRADE (REVERSE THE ORDER) OF THE MEMBERS OF A FUNCTION TABLE
; ifn  --  number of table upon which a retrograde will be performed

opcode	tab_retrograde,0,i
	ifn		xin
	iNumItems	=		ftlen(ifn)
	iTableBuffer	ftgentmp	0,0,-iNumItems,-2, 0
	icount		=		0
	loop:
	ival		table		iNumItems-icount-1, ifn
			tableiw		ival, icount, iTableBuffer
			loop_lt		icount,1,iNumItems,loop
	icount		=		0
	loop2:
	ival		table		icount,iTableBuffer
			tableiw		ival,icount,ifn
			loop_lt		icount,1,iNumItems,loop2
endop

