<CsoundSynthesizer>

<CsOptions>
-odac -M0 -+rtmidi=virtual -dm0
</CsOptions>

<CsInstruments>

sr 		= 	48000	;SAMPLE RATE
ksmps 		= 	128	;NUMBER OF AUDIO SAMPLES IN EACH CONTROL CYCLE
nchnls 		= 	1	;NUMBER OF CHANNELS (2=STEREO)
0dbfs		=	1

FLcolor	250, 250, 250, 100, 100, 100
			FLpanel	"Mode Synth UDO", 500, 560, 0, 0
;VALUE_DISPLAY_BOXES				WIDTH | HEIGHT | X | Y
idq			FLvalue	"",	 	70,      18,     5,  35
idrel			FLvalue	"",	 	70,      18,   155,  80
;SLIDERS						MIN  | MAX | EXP | TYPE | DISP | WIDTH | HEIGHT | X | Y                            
gkq, ihq		FLslider	"Q",		1,    5000,  -1,    23,   idq,    490,     25,    5, 10
gkrel, ihrel		FLslider	"Release Time",	0.01,   20,   0,    23,   idrel,  340,     20,  155, 60
			FLsetVal_i		500, ihq
			FLsetVal_i		0.1, ihrel
;COUNTERS					MIN | MAX | STEP1 | STEP2 | TYPE | WIDTH | HEIGHT | X | Y | OPCODE
gktype,   ih 	FLcount  "Type:", 		0,    20,     1,      1,      2,    120,      25,   5, 60,   -1
;TEXT BOXES							TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"0  = Dahina                ", 	1,      5,     12,    200,    15,     0, 100         
ih		 	FLbox  	"1  = Banyan                ", 	1,      5,     12,    200,    15,     0, 115
ih		 	FLbox  	"2  = Xylophone             ", 	1,      5,     12,    200,    15,     0, 130
ih		 	FLbox  	"3  = Tibetan Bowl 180      ", 	1,      5,     12,    200,    15,     0, 145
ih		 	FLbox  	"4  = Spinel Sphere         ", 	1,      5,     12,    200,    15,     0, 160
ih		 	FLbox  	"5  = Pot Lid               ", 	1,      5,     12,    200,    15,     0, 175
ih		 	FLbox  	"6  = Red Cedar Wood Plate  ", 	1,      5,     12,    200,    15,     0, 190
ih		 	FLbox  	"7  = Tubular Bell          ", 	1,      5,     12,    200,    15,     0, 205
ih		 	FLbox  	"8  = Redwood Wood Plate    ", 	1,      5,     12,    200,    15,     0, 220
ih		 	FLbox  	"9  = Douglas Fir Wood Plate", 	1,      5,     12,    200,    15,     0, 235
ih		 	FLbox  	"10 = Uniform Wooden Bar    ", 	1,      5,     12,    200,    15,     0, 250
ih		 	FLbox  	"11 = Uniform Aluminium Bar ", 	1,      5,     12,    200,    15,     0, 265
ih		 	FLbox  	"12 = Vibraphone 1          ", 	1,      5,     12,    200,    15,     0, 280
ih		 	FLbox  	"13 = Vibraphone 2          ", 	1,      5,     12,    200,    15,     0, 295
ih		 	FLbox  	"14 = Chalandi Plates       ", 	1,      5,     12,    200,    15,     0, 310            
ih		 	FLbox  	"15 = Tibetan Bowl 152      ", 	1,      5,     12,    200,    15,     0, 325
ih		 	FLbox  	"16 = Tibetan Bowl 140      ", 	1,      5,     12,    200,    15,     0, 340
ih		 	FLbox  	"17 = Wine Glass            ", 	1,      5,     12,    200,    15,     0, 355
ih		 	FLbox  	"18 = Small Hand Bell       ", 	1,      5,     12,    200,    15,     0, 370
ih		 	FLbox  	"19 = Albert Clock Bell     ", 	1,      5,     12,    200,    15,     0, 385
ih		 	FLbox  	"20 = Wood Block            ", 	1,      5,     12,    200,    15,     0, 400
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X |  Y
ih		 	FLbox  	"asig                 ain,kfreq,kq                                  ", 	1,      5,     12,    490,    15,     5,  420
ih		 	FLbox  	"<opcode_name>", 							1,      6,     12,    100,    15,    50,  420
ih		 	FLbox  	"Performance                                                        ", 	1,      7,     12,    490,    15,     5,  440
ih		 	FLbox  	"ain    -  input signal                                             ", 	1,      5,     12,    490,    15,     5,  455
ih		 	FLbox  	"kfreq  -  fundemental frequency                                    ", 	1,      5,     12,    490,    15,     5,  470
ih		 	FLbox  	"kq     -  'quality' of the mode filters                            ", 	1,      5,     12,    490,    15,     5,  485
ih		 	FLbox  	"This example demonstrates a set of 20 UDOs that employ modal       ", 	1,      5,     12,    490,    15,     5,  505
ih		 	FLbox  	"synthesis. Implementing these as UDOs means that they can be easily", 	1,      5,     12,    490,    15,     5,  520
ih		 	FLbox  	"transplanted into other projects.                                  ", 	1,      5,     12,    490,    15,     5,  535

			FLpanel_end
			FLrun		;RUN THE WIDGET THREAD

opcode	dahina, a, akk                                                                              
	ain, kbasfrq, kq	xin
	amix	init	0
#define	MODE_PARTIAL(FRQ)
	#
	kfrq	=	kbasfrq*$FRQ
	if sr/kfrq>=$M_PI then
	 asig	mode	ain, kfrq, kq
	 amix	=	amix + asig
	endif
	#
	$MODE_PARTIAL(1   )
	$MODE_PARTIAL(2.89)
	$MODE_PARTIAL(4.95)
	$MODE_PARTIAL(6.99)
	$MODE_PARTIAL(8.01)
	$MODE_PARTIAL(9.02)
		xout	amix/6
		clear	amix
endop

opcode	banyan, a, akk
	ain, kbasfrq, kq	xin
	amix	init	0
#define	MODE_PARTIAL(FRQ)
	#
	kfrq	=	kbasfrq*$FRQ
	if sr/kfrq>=$M_PI then
	 asig	mode	ain, kfrq, kq
	 amix	=	amix + asig
	endif
	#
	$MODE_PARTIAL(1   )
	$MODE_PARTIAL(2.0 )
	$MODE_PARTIAL(3.01)
	$MODE_PARTIAL(4.01)
	$MODE_PARTIAL(4.69)
	$MODE_PARTIAL(5.63)
		xout	amix/6
		clear	amix
endop

opcode	xylophone, a, akk
	ain, kbasfrq, kq	xin
	amix	init	0
#define	MODE_PARTIAL(FRQ)
	#
	kfrq	=	kbasfrq*$FRQ
	if sr/kfrq>=$M_PI then
	 asig	mode	ain, kfrq, kq
	 amix	=	amix + asig
	endif
	#
	$MODE_PARTIAL(1)
	$MODE_PARTIAL(3.932)
	$MODE_PARTIAL(9.538)
	$MODE_PARTIAL(16.688)
	$MODE_PARTIAL(24.566)
	$MODE_PARTIAL(31.147)
		xout	amix/6
		clear	amix
endop

opcode	tibetan_bowl_180, a, akk
	ain, kbasfrq, kq	xin
	amix	init	0
#define	MODE_PARTIAL(FRQ)
	#
	kfrq	=	kbasfrq*$FRQ
	if sr/kfrq>=$M_PI then
	 asig	mode	ain, kfrq, kq
	 amix	=	amix + asig
	endif
	#
	$MODE_PARTIAL(1       )
	$MODE_PARTIAL(2.77828 )
	$MODE_PARTIAL(5.18099 )
	$MODE_PARTIAL(8.16289 )
	$MODE_PARTIAL(11.66063)
	$MODE_PARTIAL(15.63801)
	$MODE_PARTIAL(19.99   )
		xout	amix/7
		clear	amix
endop

opcode	spinel_sphere, a, akk
	ain, kbasfrq, kq	xin
	amix	init	0
#define	MODE_PARTIAL(FRQ)
	#
	kfrq	=	kbasfrq*$FRQ
	if sr/kfrq>=$M_PI then
	 asig	mode	ain, kfrq, kq
	 amix	=	amix + asig
	endif
	#
	$MODE_PARTIAL(1              )
	$MODE_PARTIAL(1.026513174725 )
	$MODE_PARTIAL(1.4224916858532)
	$MODE_PARTIAL(1.4478690202098)
	$MODE_PARTIAL(1.4661959580455)
	$MODE_PARTIAL(1.499452545408 )
	$MODE_PARTIAL(1.7891839345101)
	$MODE_PARTIAL(1.8768994627782)
	$MODE_PARTIAL(1.9645945254541)
	$MODE_PARTIAL(1.9786543873113)
	$MODE_PARTIAL(2.0334612432847)
	$MODE_PARTIAL(2.1452852391916)
	$MODE_PARTIAL(2.1561524686621)
	$MODE_PARTIAL(2.2533435661294)
	$MODE_PARTIAL(2.2905090816065)
	$MODE_PARTIAL(2.3331798413917)
	$MODE_PARTIAL(2.4567715528268)
	$MODE_PARTIAL(2.4925556408289)
	$MODE_PARTIAL(2.5661806088514)
	$MODE_PARTIAL(2.6055768738808)
	$MODE_PARTIAL(2.6692760296751)
	$MODE_PARTIAL(2.7140956766436)
	$MODE_PARTIAL(2.7543617293425)
	$MODE_PARTIAL(2.7710411870043)
		xout	amix/24
		clear	amix
endop

opcode	pot_lid, a, akk
	ain, kbasfrq, kq	xin
	amix	init	0
#define	MODE_PARTIAL(FRQ)
	#
	kfrq	=	kbasfrq*$FRQ
	if sr/kfrq>=$M_PI then
	 asig	mode	ain, kfrq, kq
	 amix	=	amix + asig
	endif
	#
	$MODE_PARTIAL(1    )
	$MODE_PARTIAL(3.2  )
	$MODE_PARTIAL(6.23 )
	$MODE_PARTIAL(6.27 )
	$MODE_PARTIAL(9.92 )
	$MODE_PARTIAL(14.15)
		xout	amix/6
		clear	amix
endop

opcode	red_cedar_wood_plate, a, akk
	ain, kbasfrq, kq	xin
	amix	init	0
#define	MODE_PARTIAL(FRQ)
	#
	kfrq	=	kbasfrq*$FRQ
	if sr/kfrq>=$M_PI then
	 asig	mode	ain, kfrq, kq
	 amix	=	amix + asig
	endif
	#
	$MODE_PARTIAL(1   )
	$MODE_PARTIAL(1.47)
	$MODE_PARTIAL(2.09)
	$MODE_PARTIAL(2.56)
		xout	amix/4
		clear	amix
endop

opcode	tubular_bell, a, akk
	ain, kbasfrq, kq	xin
	amix	init	0
#define	MODE_PARTIAL(FRQ)
	#
	kfrq	=	kbasfrq*$FRQ
	if sr/kfrq>=$M_PI then
	 asig	mode	ain, kfrq, kq
	 amix	=	amix + asig
	endif
	#
	$MODE_PARTIAL(272/437 )
	$MODE_PARTIAL(538/437 )
	$MODE_PARTIAL(874/437 )
	$MODE_PARTIAL(1281/437)
	$MODE_PARTIAL(1755/437)
	$MODE_PARTIAL(2264/437)
	$MODE_PARTIAL(2813/437)
	$MODE_PARTIAL(3389/437)
	$MODE_PARTIAL(4822/437)
	$MODE_PARTIAL(5255/437)
		xout	amix/10
		clear	amix
endop

opcode	redwood_wood_plate, a, akk
	ain, kbasfrq, kq	xin
	amix	init	0
#define	MODE_PARTIAL(FRQ)
	#
	kfrq	=	kbasfrq*$FRQ
	if sr/kfrq>=$M_PI then
	 asig	mode	ain, kfrq, kq
	 amix	=	amix + asig
	endif
	#
	$MODE_PARTIAL(1   )
	$MODE_PARTIAL(1.47)
	$MODE_PARTIAL(2.11)
	$MODE_PARTIAL(2.57)
		xout	amix/4
		clear	amix
endop

opcode	douglas_fir_wood_plate, a, akk
	ain, kbasfrq, kq	xin
	amix	init	0
#define	MODE_PARTIAL(FRQ)
	#
	kfrq	=	kbasfrq*$FRQ
	if sr/kfrq>=$M_PI then
	 asig	mode	ain, kfrq, kq
	 amix	=	amix + asig
	endif
	#
	$MODE_PARTIAL(1   )
	$MODE_PARTIAL(1.42)
	$MODE_PARTIAL(2.11)
	$MODE_PARTIAL(2.47)
		xout	amix/4
		clear	amix
endop

opcode	uniform_wooden_bar, a, akk
	ain, kbasfrq, kq	xin
	amix	init	0
#define	MODE_PARTIAL(FRQ)
	#
	kfrq	=	kbasfrq*$FRQ
	if sr/kfrq>=$M_PI then
	 asig	mode	ain, kfrq, kq
	 amix	=	amix + asig
	endif
	#
	$MODE_PARTIAL(1    )
	$MODE_PARTIAL(2.572)
	$MODE_PARTIAL(4.644)
	$MODE_PARTIAL(6.984)
	$MODE_PARTIAL(9.723)
	$MODE_PARTIAL(12   )
		xout	amix/6
		clear	amix
endop

opcode	uniform_aluminium_bar, a, akk
	ain, kbasfrq, kq	xin
	amix	init	0
#define	MODE_PARTIAL(FRQ)
	#
	kfrq	=	kbasfrq*$FRQ
	if sr/kfrq>=$M_PI then
	 asig	mode	ain, kfrq, kq
	 amix	=	amix + asig
	endif
	#
	$MODE_PARTIAL(1     )
	$MODE_PARTIAL(2.756 )
	$MODE_PARTIAL(5.423 )
	$MODE_PARTIAL(8.988 )
	$MODE_PARTIAL(13.448)
	$MODE_PARTIAL(18.680)
		xout	amix/6
		clear	amix
endop

opcode	vibraphone_1, a, akk
	ain, kbasfrq, kq	xin
	amix	init	0
#define	MODE_PARTIAL(FRQ)
	#
	kfrq	=	kbasfrq*$FRQ
	if sr/kfrq>=$M_PI then
	 asig	mode	ain, kfrq, kq
	 amix	=	amix + asig
	endif
	#
	$MODE_PARTIAL(1     )
	$MODE_PARTIAL(3.984 )
	$MODE_PARTIAL(10.668)
	$MODE_PARTIAL(17.979)
	$MODE_PARTIAL(23.679)
	$MODE_PARTIAL(33.642)
		xout	amix/6
		clear	amix
endop

opcode	vibraphone_2, a, akk
	ain, kbasfrq, kq	xin
	amix	init	0
#define	MODE_PARTIAL(FRQ)
	#
	kfrq	=	kbasfrq*$FRQ
	if sr/kfrq>=$M_PI then
	 asig	mode	ain, kfrq, kq
	 amix	=	amix + asig
	endif
	#
	$MODE_PARTIAL(1     )
	$MODE_PARTIAL(3.997 )
	$MODE_PARTIAL(9.469 )
	$MODE_PARTIAL(15.566)
	$MODE_PARTIAL(20.863)
	$MODE_PARTIAL(29.440)
		xout	amix/6
		clear	amix
endop

opcode	chalandi_plates, a, akk
	ain, kbasfrq, kq	xin
	amix	init	0
#define	MODE_PARTIAL(FRQ)
	#
	kfrq	=	kbasfrq*$FRQ
	if sr/kfrq>=$M_PI then
	 asig	mode	ain, kfrq, kq
	 amix	=	amix + asig
	endif
	#                    
	$MODE_PARTIAL(1       )
	$MODE_PARTIAL(1.72581 )
	$MODE_PARTIAL(5.80645 )
	$MODE_PARTIAL(7.41935 )
	$MODE_PARTIAL(13.91935)
		xout	amix/5
		clear	amix
endop

opcode	tibetan_bowl_152, a, akk
	ain, kbasfrq, kq	xin
	amix	init	0
#define	MODE_PARTIAL(FRQ)
	#
	kfrq	=	kbasfrq*$FRQ
	if sr/kfrq>=$M_PI then
	 asig	mode	ain, kfrq, kq
	 amix	=	amix + asig
	endif
	#                    
	$MODE_PARTIAL(1       )
	$MODE_PARTIAL(2.66242 )
	$MODE_PARTIAL(4.83757 )
	$MODE_PARTIAL(7.51592 )
	$MODE_PARTIAL(10.64012)
	$MODE_PARTIAL(14.21019)
	$MODE_PARTIAL(18.14027)
		xout	amix/7
		clear	amix
endop

opcode	tibetan_bowl_140, a, akk
	ain, kbasfrq, kq	xin
	amix	init	0
#define	MODE_PARTIAL(FRQ)
	#
	kfrq	=	kbasfrq*$FRQ
	if sr/kfrq>=$M_PI then
	 asig	mode	ain, kfrq, kq
	 amix	=	amix + asig
	endif
	#                    
	$MODE_PARTIAL(1       )
	$MODE_PARTIAL(2.76515 )
	$MODE_PARTIAL(5.12121 )
	$MODE_PARTIAL(7.80681 )
	$MODE_PARTIAL(10.78409)
		xout	amix/5
		clear	amix
endop

opcode	wine_glass, a, akk
	ain, kbasfrq, kq	xin
	amix	init	0
#define	MODE_PARTIAL(FRQ)
	#
	kfrq	=	kbasfrq*$FRQ
	if sr/kfrq>=$M_PI then
	 asig	mode	ain, kfrq, kq
	 amix	=	amix + asig
	endif
	#                    
	$MODE_PARTIAL(1   )
	$MODE_PARTIAL(2.32)
	$MODE_PARTIAL(4.25)
	$MODE_PARTIAL(6.63)
	$MODE_PARTIAL(9.38)
		xout	amix/5
		clear	amix
endop

opcode	small_hand_bell, a, akk
	ain, kbasfrq, kq	xin
	amix	init	0
#define	MODE_PARTIAL(FRQ)
	#
	kfrq	=	kbasfrq*$FRQ
	if sr/kfrq>=$M_PI then
	 asig	mode	ain, kfrq, kq
	 amix	=	amix + asig
	endif
	#                    
	$MODE_PARTIAL(1              )
	$MODE_PARTIAL(1.0019054878049)
	$MODE_PARTIAL(1.7936737804878)
	$MODE_PARTIAL(1.8009908536585)
	$MODE_PARTIAL(2.5201981707317)
	$MODE_PARTIAL(2.5224085365854)
	$MODE_PARTIAL(2.9907012195122)
	$MODE_PARTIAL(2.9940548780488)
	$MODE_PARTIAL(3.7855182926829)
	$MODE_PARTIAL(3.8061737804878)
	$MODE_PARTIAL(4.5689024390244)
	$MODE_PARTIAL(4.5754573170732)
	$MODE_PARTIAL(5.0296493902439)
	$MODE_PARTIAL(5.0455030487805)
	$MODE_PARTIAL(6.0759908536585)
	$MODE_PARTIAL(5.9094512195122)
	$MODE_PARTIAL(6.4124237804878)
	$MODE_PARTIAL(6.4430640243902)
	$MODE_PARTIAL(7.0826219512195)
	$MODE_PARTIAL(7.0923780487805)
	$MODE_PARTIAL(7.3188262195122)
	$MODE_PARTIAL(7.5551829268293)
		xout	amix/22
		clear	amix
endop

opcode	albert_clock_bell, a, akk
	ain, kbasfrq, kq	xin
	amix	init	0
#define	MODE_PARTIAL(FRQ)
	#
	kfrq	=	kbasfrq*$FRQ
	if sr/kfrq>=$M_PI then
	 asig	mode	ain, kfrq, kq
	 amix	=	amix + asig
	endif
	#                    
	$MODE_PARTIAL(2.043260)
	$MODE_PARTIAL(1.482916)
	$MODE_PARTIAL(1.000000)
	$MODE_PARTIAL(3.328848)
	$MODE_PARTIAL(4.761811)
	$MODE_PARTIAL(1.477056)
	$MODE_PARTIAL(0.612007)
	$MODE_PARTIAL(2.661295)
	$MODE_PARTIAL(1.002793)
	$MODE_PARTIAL(4.023776)
	$MODE_PARTIAL(0.254139)
	$MODE_PARTIAL(2.043916)
	$MODE_PARTIAL(4.032463)
	$MODE_PARTIAL(2.659438)
	$MODE_PARTIAL(4.775560)
	$MODE_PARTIAL(5.500494)
	$MODE_PARTIAL(3.331014)
	$MODE_PARTIAL(0.809697)
	$MODE_PARTIAL(2.391301)
	$MODE_PARTIAL(0.254098)
	$MODE_PARTIAL(1.901476)
	$MODE_PARTIAL(2.366563)
		xout	amix/22
		clear	amix
endop

opcode	wood_block, a, akk
	ain, kbasfrq, kq	xin
	amix	init	0
#define	MODE_PARTIAL(FRQ)
	#
	kfrq	=	kbasfrq*$FRQ
	if sr/kfrq>=$M_PI then
	 asig	mode	ain, kfrq, kq
	 amix	=	amix + asig
	endif
	#                    
	$MODE_PARTIAL(915/915 )
	$MODE_PARTIAL(1540/915)
	$MODE_PARTIAL(1863/915)
	$MODE_PARTIAL(3112/915)
		xout	amix/4
		clear	amix
endop

instr	1
	ifilt	veloc			6,13
	icps	cpsmidi
	asig	mpulse			1, 0
	asig	butlp			asig,cpsoct(ifilt)
	itype	init			i(gktype)
	if     itype==0 then
	 aout	dahina			asig,icps,gkq
	elseif itype==1 then                      
	 aout	banyan			asig,icps,gkq
	elseif itype==2 then
	 aout	xylophone		asig,icps,gkq
	elseif itype==3 then
	 aout	tibetan_bowl_180	asig,icps,gkq
	elseif itype==4 then
	 aout	spinel_sphere		asig,icps,gkq
	elseif itype==5 then
	 aout	pot_lid			asig,icps,gkq
	elseif itype==6 then
	 aout	red_cedar_wood_plate	asig,icps,gkq
	elseif itype==7 then
	 aout	tubular_bell		asig,icps,gkq
	elseif itype==8 then
	 aout	redwood_wood_plate	asig,icps,gkq
	elseif itype==9 then
	 aout	douglas_fir_wood_plate	asig,icps,gkq
	elseif itype==10 then
	 aout	uniform_wooden_bar	asig,icps,gkq
	elseif itype==11 then
	 aout	uniform_aluminium_bar	asig,icps,gkq
	elseif itype==12 then
	 aout	vibraphone_1		asig,icps,gkq
	elseif itype==13 then
	 aout	vibraphone_2		asig,icps,gkq
	elseif itype==14 then
	 aout	chalandi_plates		asig,icps,gkq
	elseif itype==15 then
	 aout	tibetan_bowl_152	asig,icps,gkq
	elseif itype==16 then
	 aout	tibetan_bowl_140	asig,icps,gkq
	elseif itype==17 then
	 aout	wine_glass		asig,icps,gkq
	elseif itype==18 then
	 aout	small_hand_bell		asig,icps,gkq
	elseif itype==19 then
	 aout	albert_clock_bell	asig,icps,gkq
	elseif itype==20 then
	 aout	wood_block		asig,icps,gkq
	endif
	aenv	linsegr			1, i(gkrel), 0
		out			aout * aenv
endin

</CsInstruments>

<CsScore>
f 0 3600
</CsScore>

</CsoundSynthesizer>