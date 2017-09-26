; TukeyWindow
; -----------
; Generates a Tukey window with a variable width.
; A Tukey window is a rectangular window bounded by sigmoids ramping up from zero at the beginning and back down to zero at the end.
; This UDO allows the user to set the ratio between the duration of the sigmoids and the rectangular elements.
;
;  TukeyWindow  ifn, isize, iratio
;
; Initialisation
; --------------
; ifn    --  function table number of the outputted Tukey table.
; isize  --  size of the table (should be a power of two).
; iratio --  ratio between the duration of the sigmoids to the rectangular element. Should be between zero (all rectangular) to 0.5 (all sigmoids).

opcode TukeyWindow,0,iii
 ifn,isize,iratio	xin
 iratio		limit	iratio,2/isize,0.5
 i1	ftgen	0,0,isize,19, 0.5,0.5,270, 0.5
 i2	ftgen	0,0,isize,7, 1,isize,1
 i3	ftgen	0,0,isize,19, 0.5,0.5,90, 0.5
 i_	ftgen	ifn, 0, isize, -18, i1, 1, 0, (isize*iratio), i2, 1, (isize*iratio)+1, (isize-1-(isize*iratio)), i3, 1, (isize-(isize*iratio)), isize-1
 ftfree i1, 0
 ftfree i2, 0
 ftfree i3, 0
endop
