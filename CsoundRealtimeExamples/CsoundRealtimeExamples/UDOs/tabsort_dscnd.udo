; SORT THE MEMBERS OF A FUNCTION TABLE INTO DESCENDING ORDER
; ifn  --  number of table upon which will be sorted

opcode	tabsort_dscnd,0,i
	ifn		xin
	iNumItems	=		ftlen(ifn)
	imax		table		0,ifn
	icount		=		1
	loop1:
	  ival		table		icount,ifn
	  imax = (ival>=imax?ival:imax)
	  		loop_lt		icount,1,iNumItems,loop1
	iTableBuffer	ftgentmp	0,0,-iNumItems,-2, 0
	icount1	init	0
	loop2:
	  icount2	=		0
	  imin		=		imax
	  loop3:
	    ival	table		icount2,ifn
	    if ival<=imin then			
	      imin 	= 		ival
	      iloc 	= 		icount2 
	    endif
	    		loop_lt		icount2,1,iNumItems,loop3
			tableiw		imin,iNumItems-icount1-1,iTableBuffer
			tableiw		imax,iloc,ifn
	  		loop_lt		icount1,1,iNumItems,loop2
	icount		=		0
	loop4:
	ival		table		icount,iTableBuffer
			tableiw		ival,icount,ifn
			loop_lt		icount,1,iNumItems,loop4
endop
