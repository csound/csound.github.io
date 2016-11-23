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
