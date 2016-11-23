FLbox.csd
Written by Iain McCurdy, 2009.

<CsoundSynthesizer>

<CsOptions>
-odac -d
</CsOptions>

<CsInstruments>

sr		=	44100
ksmps		=	64
nchnls		=	1

		FLpanel	"Text Box",1200,800,50,50
gk, ih		FLbutBank	4, 1, 1, 0, 0, 3000, 3000, -1	; a strange bug: including this (not visible) type 4 button bank makes the rounded boxes to display correctly


itype		=	1	;BOX BORDER TYPE (7=EMBOSSED BOX)
ifont		=	10	;FONT TYPE (10='TIMES BOLD')
isize		=	14	;FONT SIZE
iwidth		=	300	;WIDTH OF THE FL BOX
iheight		=	30	;HEIGHT OF THE FL BOX
ix		=	20	;DISTANCE OF THE LEFT EDGE OF THE FL BOX FROM THE LEFT EDGE OF THE PANEL
iy		=	20	;DISTANCE OF THE UPPER EDGE OF THE FL BOX FROM THE UPPER EDGE OF THE PANEL

ih	 FLbox  "Type 1: flat box", 			itype, ifont, isize, iwidth, iheight, ix, iy
iy = iy + 40
ih	 FLbox  "Type 2: up box",   			2,     ifont, isize, iwidth, iheight, ix, iy
iy = iy + 40
ih	 FLbox  "Type 3: down box",   			3,     ifont, isize, iwidth, iheight, ix, iy
iy = iy + 40
ih	 FLbox  "Type 4: thin up box",  		4,     ifont, isize, iwidth, iheight, ix, iy
iy = iy + 40
ih	 FLbox  "Type 5: thin down box",		5,     ifont, isize, iwidth, iheight, ix, iy
iy = iy + 40
ih	 FLbox  "Type 6: engraved box", 		6,     ifont, isize, iwidth, iheight, ix, iy
iy = iy + 40
ih	 FLbox  "Type 7: embossed box", 		7,     ifont, isize, iwidth, iheight, ix, iy
iy = iy + 40
ih	 FLbox  "Type 8: border box",   		8,     ifont, isize, iwidth, iheight, ix, iy
iy = iy + 40
ih	 FLbox  "Type 9: shadow box",   		9,     ifont, isize, iwidth, iheight, ix, iy
iy = iy + 40
ih	 FLbox  "Type 10: rounded box", 		10,    ifont, isize, iwidth, iheight, ix, iy
iy = iy + 40
ih	 FLbox  "Type 11: rounded box with shadow",  	11,    ifont, isize, iwidth, iheight, ix, iy
iy = iy + 40
ih	 FLbox  "Type 12: rounded flat box",  		12,    ifont, isize, iwidth, iheight, ix, iy
iy = iy + 40
ih	 FLbox  "Type 13: rounded up box", 		13,    ifont, isize, iwidth, iheight, ix, iy
iy = iy + 40
ih	 FLbox  "Type 14: rounded down box", 		14,    ifont, isize, iwidth, iheight, ix, iy
iy = iy + 40                                        
ih	 FLbox  "Type 15: diamond up box", 		15,    ifont, isize, iwidth, iheight, ix, iy
iy = iy + 40
ih	 FLbox  "Type 16: diamond down box", 		16,    ifont, isize, iwidth, iheight, ix, iy
iy = iy + 40
ih	 FLbox  "Type 17: oval box", 			17,    ifont, isize, iwidth, iheight, ix, iy
iy = iy + 40
ih	 FLbox  "Type 18: oval shadow box", 		18,    ifont, isize, iwidth, iheight, ix, iy
iy = iy + 40
ih	 FLbox  "Type 19: oval flat box", 		19,    ifont, isize, iwidth, iheight, ix, iy
ix = 350
iwidth = 40
iheight = 40
iy = 20
ih	 FLbox  "@->", 					2,    ifont, isize, iwidth, iheight, ix, iy
ix = ix + 50
ih	 FLbox  "@>", 					2,    ifont, isize, iwidth, iheight, ix, iy
ix = ix + 50
ih	 FLbox  "@>>", 					2,    ifont, isize, iwidth, iheight, ix, iy
ix = ix + 50
ih	 FLbox  "@>|", 					2,    ifont, isize, iwidth, iheight, ix, iy
ix = ix + 50
ih	 FLbox  "@>ÿ", 					2,    ifont, isize, iwidth, iheight, ix, iy	

iy = iy +50
ix =  350
;ih	 FLbox  "@|>", 					2,    ifont, isize, iwidth, iheight, ix, iy
ix = ix + 50
ih	 FLbox  "@<-", 					2,    ifont, isize, iwidth, iheight, ix, iy
ix = ix + 50
ih	 FLbox  "@<", 					2,    ifont, isize, iwidth, iheight, ix, iy
ix = ix + 50
ih	 FLbox  "@<<", 					2,    ifont, isize, iwidth, iheight, ix, iy
ix = ix + 50
ih	 FLbox  "@|<", 					2,    ifont, isize, iwidth, iheight, ix, iy
ix = ix + 50

iy = iy +50
ix =  350
ih	 FLbox  "@y<", 					2,    ifont, isize, iwidth, iheight, ix, iy
ix = ix + 50
ih	 FLbox  "@<|", 					2,    ifont, isize, iwidth, iheight, ix, iy
ix = ix + 50
ih	 FLbox  "@<->", 					2,    ifont, isize, iwidth, iheight, ix, iy
ix = ix + 50
ih	 FLbox  "@-->", 					2,    ifont, isize, iwidth, iheight, ix, iy
ix = ix + 50
ih	 FLbox  "@+", 					2,    ifont, isize, iwidth, iheight, ix, iy
ix = ix + 50

iy = iy +50
ix =  350
ih	 FLbox  "@-->", 					2,    ifont, isize, iwidth, iheight, ix, iy
ix = ix + 50
ih	 FLbox  "@||", 					2,    ifont, isize, iwidth, iheight, ix, iy
ix = ix + 50
ih	 FLbox  "@arrow", 					2,    ifont, isize, iwidth, iheight, ix, iy
ix = ix + 50
ih	 FLbox  "@returnarrow", 					2,    ifont, isize, iwidth, iheight, ix, iy
ix = ix + 50
ih	 FLbox  "@square", 					2,    ifont, isize, iwidth, iheight, ix, iy
ix = ix + 50

iy = iy +50
ix =  350
ih	 FLbox  "@circle", 					2,    ifont, isize, iwidth, iheight, ix, iy
ix = ix + 50
ih	 FLbox  "@line", 					2,    ifont, isize, iwidth, iheight, ix, iy
ix = ix + 50
ih	 FLbox  "@menu", 					2,    ifont, isize, iwidth, iheight, ix, iy
ix = ix + 50
ih	 FLbox  "@UpArrow", 					2,    ifont, isize, iwidth, iheight, ix, iy
ix = ix + 50
ih	 FLbox  "@DnArrow", 					2,    ifont, isize, iwidth, iheight, ix, iy
ix = ix + 50

ix = 350
iy = 300
iwidth = 800
iheight = 13
ifont = 1
isize = 13
igap = 30
ih	 FLbox  "Font 1: helvetica abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", 		itype, ifont, isize, iwidth, iheight, ix, iy
iy = iy + igap
ih	 FLbox  "Font 2: helvetica bold abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", 		itype,   2,   isize, iwidth, iheight, ix, iy
iy = iy + igap
ih	 FLbox  "Font 3: helvetica italic abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", 	itype,   3,   isize, iwidth, iheight, ix, iy
iy = iy + igap
ih	 FLbox  "Font 4: helvetica bold italic abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", 	itype,   4,   isize, iwidth, iheight, ix, iy
iy = iy + igap
ih	 FLbox  "Font 5: courier abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", 		itype,   5,   isize, iwidth, iheight, ix, iy
iy = iy + igap
ih	 FLbox  "Font 6: courier bold abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", 		itype,   6,   isize, iwidth, iheight, ix, iy
iy = iy + igap
ih	 FLbox  "Font 7: courier italic abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", 		itype,   7,   isize, iwidth, iheight, ix, iy
iy = iy + igap
ih	 FLbox  "Font 8: courier bold italic abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", 	itype,   8,   isize, iwidth, iheight, ix, iy
iy = iy + igap
ih	 FLbox  "Font 9: times abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", 			itype,   9,   isize, iwidth, iheight, ix, iy
iy = iy + igap
ih	 FLbox  "Font 10: times bold abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", 		itype,   10,   isize, iwidth, iheight, ix, iy
iy = iy + igap                                                                                           
ih	 FLbox  "Font 11: times italic abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", 		itype,   11,   isize, iwidth, iheight, ix, iy
iy = iy + igap
ih	 FLbox  "Font 12: times bold italic abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", 	itype,   12,   isize, iwidth, iheight, ix, iy
iy = iy + igap
ih	 FLbox  "Font 13: symbol abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", 		itype,   13,   isize, iwidth, iheight, ix, iy
iy = iy + igap
ih	 FLbox  "Font 14: screen abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", 		itype,   14,   isize, iwidth, iheight, ix, iy
iy = iy + igap
ih	 FLbox  "Font 15: screen bold abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", 		itype,   15,   isize, iwidth, iheight, ix, iy
iy = iy + igap
ih	 FLbox  "Font 16: dingbats abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ", 		itype,   16,   isize, iwidth, iheight, ix, iy
iy = iy + igap
FLcolor	230, 230, 255, 0, 0, 50	;SET INTERFACE COLOURS
ih	 FLbox  "", 											7,        5,   isize, 600,180, 595, 18
ih	 FLbox  "                               FLbox                                  ", 		itype,    5,   isize, 590, 20, 602, 20
ih	 FLbox  "----------------------------------------------------------------------", 		itype,    5,   isize, 590, 20, 602, 40
ih	 FLbox  "FLbox is useful for creating borders and areas of text for labelling. ", 		itype,    5,   isize, 590, 20, 602, 60
ih	 FLbox  "A number of symbols are also available.                               ", 		itype,    5,   isize, 590, 20, 602, 80
ih	 FLbox  "This window catalogues the types of boxes, the fonts and the special  ", 		itype,    5,   isize, 590, 20, 602,100
ih	 FLbox  "symbols that are available with this opcode.                          ", 		itype,    5,   isize, 590, 20, 602,120
ih	 FLbox  "The 'type' descriptions are taken from the Csound Reference Manual.   ", 		itype,    5,   isize, 590, 20, 602,140
ih	 FLbox  "You will notice that many of the types advertised are not implemented.", 		itype,    5,   isize, 590, 20, 602,160
                                             

		FLpanel_end	;END OF PANEL CONTENTS
		FLrun		;RUN THE WIDGET THREAD!

		instr	1	;NO SOUND IS PRODUCED
		endin

</CsInstruments>                       

<CsScore>
f 0 3600                                 
</CsScore>

</CsoundSynthesizer>