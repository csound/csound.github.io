; ifn  --  number of table to be shuffled

opcode	tab_shuffle,0,i
	ifn		xin
	iNumItems	=	ftlen(ifn)
	icount 		= 	0
	loop:
	ival1	table	icount, ifn
	irndndx	random	0,iNumItems-0.001
	ival2	table	irndndx, ifn
		tableiw	ival2, icount, ifn
		tableiw	ival1, irndndx, ifn
		loop_lt	icount,1,iNumItems,loop
endop

