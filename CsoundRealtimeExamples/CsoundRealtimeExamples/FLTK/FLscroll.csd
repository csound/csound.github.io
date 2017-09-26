;Written by Iain McCurdy, 2009

<CsoundSynthesizer>

<CsOptions>
</CsOptions>

<CsInstruments>

;DEMONSTRATION OF THE FLscroll OPCODE WHICH ENABLES THE USE OF WIDGET SIZES AND PLACINGS BEYOND THE DIMENSIONS OF THE CONTAINING PANEL  

sr		=	44100
kr		=	441
ksmps		=	100
nchnls		=	2


FLcolor	255,255,255,0,0,0	;SET THE COLOUR SCHEME
		FLpanel	"FLscroll",430,200,50,50

;NORMALLY JUST APPLY THE SAME WIDTH AND HEIGHT VALUES AS USED BY THE CONTAINER THAT HOLDS THE SCROLL BARS
;EITHER HORIZONTAL OR VERTICAL (OR BOTH HORIZONTAL AND VERTICAL) SCROLLBARS WILL BE AUTOMATICALLY BE ADDED AS REQUIRED
iwidth		=	430
iheight		=	200
ix		=	0
iy		=	0
		FLscroll   iwidth, iheight, ix, iy
		
;SOME TEXT THAT WILL EXTEND BEYOND THE RIGHT HAND LIMIT OF THE PANEL...
ih	 FLbox  "DRAG THE SCROLL BAR TO THE RIGHT IN ORDER TO READ THE REST OF THIS TEXT. DRAG THE VERTICAL BAR DOWN...", 1, 10, 20, 1200, 30, 10, 100

ih	 FLbox  "...TO READ THIS OTHER BIT OF TEXT", 1, 10, 20, 400, 30,  800, 300

		FLscrollEnd	;FLscroll, LIKE ALL CONTAINER WIDGETS, NEEDS A 'CLOSING' OPCODE

		FLpanelEnd	;END OF PANEL CONTENTS





		FLpanel	"FLscroll within a panel",500,500,500,50
;TEXT BOXES											TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"FLscroll areas can also exist within a larger panel.", 	1,      10,    20,    480,    20,    10, 10

FLcolor	255,255,220
FLlabel 20, 11, 1, 100, 100, 100
		FLscroll                          400,400, 50,50
iy=50
isize=20
;TEXT BOXES								TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
#define VERSE	#
ih		FLbox  	"Lorem ipsum dolor sit amet, consectetur ", 	1,      11,   isize,    382,     20,    50, iy
iy=iy+20
ih		FLbox  	"adipisicing elit, sed do eiusmod tempor ", 	1,      11,   isize,    382,     20,    50, iy
iy=iy+20
ih		FLbox  	"incididunt ut labore et dolore magna    ", 	1,      11,   isize,    382,     20,    50, iy
iy=iy+20
ih		FLbox  	"aliqua. Ut enim ad minim veniam, quis   ", 	1,      11,   isize,    382,     20,    50, iy
iy=iy+20
ih		FLbox  	"nostrud exercitation ullamco laboris    ", 	1,      11,   isize,    382,     20,    50, iy
iy=iy+20
ih		FLbox  	"nisi ut aliquip ex ea commodo consequat.", 	1,      11,   isize,    382,     20,    50, iy
iy=iy+20
ih		FLbox  	"Duis aute irure dolor in reprehenderit  ", 	1,      11,   isize,    382,     20,    50, iy
iy=iy+20
ih		FLbox  	"in voluptate velit esse cillum dolore eu", 	1,      11,   isize,    382,     20,    50, iy
iy=iy+20
ih		FLbox  	"fugiat nulla pariatur. Excepteur sint   ", 	1,      11,   isize,    382,     20,    50, iy
iy=iy+20
ih		FLbox  	"occaecat cupidatat non proident, sunt in", 	1,      11,   isize,    382,     20,    50, iy
iy=iy+20
ih		FLbox  	"culpa qui officia deserunt mollit anim  ", 	1,      11,   isize,    382,     20,    50, iy
iy=iy+20
ih		FLbox  	"est laborum.                            ", 	1,      11,   isize,    382,     20,    50, iy
iy=iy+20#
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
$VERSE
		FLscrollEnd
		FLpanelEnd	;END OF PANEL CONTENTS





		FLrun		;RUN THE WIDGET THREAD

		instr	1
		endin

</CsInstruments>

<CsScore>
f 0 3600	;DUMMY SCORE EVENT ALLOWS REALTIME PERFORMANCE FOR UP TO 1 HOUR
</CsScore>

</CsoundSynthesizer>

