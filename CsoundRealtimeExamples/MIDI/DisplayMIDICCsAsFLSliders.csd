;DisplayMIDICCsAsFLSliders.csd
;Written by Iain McCurdy, 2012

<CsoundSynthesizer>

<CsOptions>
;external hardware midi (all devices)
-odac -dm0 -M8 -+raw_controller_mode=1 
;internal virtual device
;-odac -dm0 -M0 -+rtmidi=virtual -+raw_controller_mode=1 
</CsOptions>

<CsInstruments>

sr	= 	44100
ksmps	= 	16
nchnls	= 	2

giwidth=50
giheight=500
giValBoxHeight=20
FLcolor	234,243,147,234-100,243-100,147-100

		FLpanel	"MIDI CCs",180+giwidth*16, 60+giheight+giValBoxHeight+giValBoxHeight, 0, 0

;TEXT BOXES					TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"Value", 	1,      1,     14,     80,     20,    5,  giheight+20
ih		 	FLbox  	"CC Num.", 	1,      1,     14,     80,     20,    5,  giheight+40
ih		 	FLbox  	"Channel", 	1,      1,     14,     80,     20,    5,  giheight+60

gix	init	80

#define	CONTROLLER(N)	#
;VALUE DISPLAY BOXES		LABEL | WIDTH |     HEIGHT      | X |  Y
gid$N			FLvalue	"",    giwidth, giValBoxHeight,  gix,  giheight+giValBoxHeight
;					   	MIN  | MAX | EXP | TYPE | DISP |  WIDTH  | HEIGHT  |      X      |    Y
gk$N,gih$N		FLslider 	"$N",	0,     127,   0,    4,     -1,   giwidth,    giheight,   gix,      0
FLsetColor2	rnd(255),rnd(255),rnd(255),gih$N
gkCCNum$N, gihCCNum$N 		FLcount  "", 	0,    127,  1,      10,      2,   giwidth,      20,    gix, giheight+40,   -1
FLsetTextSize	12, gihCCNum$N
FLsetVal_i	$N,gihCCNum$N                                               
gkChan$N, gihChan$N 		FLcount  "", 	1,    16,  1,      10,      2,   giwidth,      20,    gix, giheight+60,   -1
FLsetTextSize	12, gihChan$N
FLsetVal_i	1,gihChan$N
gix	=	gix + giwidth
#

$CONTROLLER(1)
$CONTROLLER(2)              
$CONTROLLER(3)
$CONTROLLER(4)
$CONTROLLER(5)
$CONTROLLER(6)
$CONTROLLER(7)
$CONTROLLER(8)
$CONTROLLER(9)                                   
$CONTROLLER(10)
$CONTROLLER(11)
$CONTROLLER(12)
$CONTROLLER(13)
$CONTROLLER(14)
$CONTROLLER(15)
$CONTROLLER(16)

gkCCNumGlobal, ihCCNumGlobal 		FLcount  "", 	  	0,    127,  1,      10,      1,   80,      20,    gix, giheight+40,    0, 2, 0, 0
gkChanGlobal, ihChanGlobal 		FLcount  "Global", 	1,     16,  1,      10,      1,   80,      20,    gix, giheight+60,    0, 3, 0, 0
FLsetTextSize	14, ihChanGlobal

FLrun

instr		1

#define	ControllerChannel(N)
	#                                                                        
	k$N	ctrl7	i(gkChan$N),i(gkCCNum$N) ,0,127
	kupdatetrig	metro	20
	if kupdatetrig==1 then
	 kt$N	changed	k$N
	 FLsetVal	kt$N , 127-k$N, gih$N
	 if kt$N==1 then
	  FLprintk2	k$N, gid$N
	 endif
	endif
	#
                                                                                                                                       
	ktrig	changed	gkChan1,  gkCCNum1,\
			gkChan2,  gkCCNum2,\
			gkChan3,  gkCCNum3,\
			gkChan4,  gkCCNum4,\
			gkChan5,  gkCCNum5,\
			gkChan6,  gkCCNum6,\
			gkChan7,  gkCCNum7,\
			gkChan8,  gkCCNum8,\
			gkChan9,  gkCCNum9,\
			gkChan10, gkCCNum10,\
			gkChan11, gkCCNum11,\
			gkChan12, gkCCNum12,\
			gkChan13, gkCCNum13,\                                          
			gkChan14, gkCCNum14,\
			gkChan15, gkCCNum15,\
			gkChan16, gkCCNum16\
			
	if ktrig==1 then
	 reinit	UPDATE
	endif
	UPDATE:
$ControllerChannel(1)
$ControllerChannel(2)
$ControllerChannel(3)
$ControllerChannel(4)
$ControllerChannel(5)
$ControllerChannel(6)
$ControllerChannel(7)
$ControllerChannel(8)
$ControllerChannel(9)
$ControllerChannel(10)
$ControllerChannel(11)
$ControllerChannel(12)
$ControllerChannel(13)
$ControllerChannel(14)
$ControllerChannel(15)
$ControllerChannel(16)
	rireturn
endin

instr	2	;set all midi CC numbers 
FLsetVal_i	i(gkCCNumGlobal),	gihCCNum1                                     
FLsetVal_i	i(gkCCNumGlobal),	gihCCNum2
FLsetVal_i	i(gkCCNumGlobal),	gihCCNum3
FLsetVal_i	i(gkCCNumGlobal),	gihCCNum4
FLsetVal_i	i(gkCCNumGlobal),	gihCCNum5
FLsetVal_i	i(gkCCNumGlobal),	gihCCNum6
FLsetVal_i	i(gkCCNumGlobal),	gihCCNum7
FLsetVal_i	i(gkCCNumGlobal),	gihCCNum8
FLsetVal_i	i(gkCCNumGlobal),	gihCCNum9
FLsetVal_i	i(gkCCNumGlobal),	gihCCNum10
FLsetVal_i	i(gkCCNumGlobal),	gihCCNum11
FLsetVal_i	i(gkCCNumGlobal),	gihCCNum12
FLsetVal_i	i(gkCCNumGlobal),	gihCCNum13
FLsetVal_i	i(gkCCNumGlobal),	gihCCNum14
FLsetVal_i	i(gkCCNumGlobal),	gihCCNum15
FLsetVal_i	i(gkCCNumGlobal),	gihCCNum16
endin
        
instr	3	;set all midi CC numbers 
FLsetVal_i	i(gkChanGlobal),	gihChan1                                     
FLsetVal_i	i(gkChanGlobal),	gihChan2
FLsetVal_i	i(gkChanGlobal),	gihChan3
FLsetVal_i	i(gkChanGlobal),	gihChan4
FLsetVal_i	i(gkChanGlobal),	gihChan5
FLsetVal_i	i(gkChanGlobal),	gihChan6
FLsetVal_i	i(gkChanGlobal),	gihChan7
FLsetVal_i	i(gkChanGlobal),	gihChan8
FLsetVal_i	i(gkChanGlobal),	gihChan9
FLsetVal_i	i(gkChanGlobal),	gihChan10
FLsetVal_i	i(gkChanGlobal),	gihChan11
FLsetVal_i	i(gkChanGlobal),	gihChan12
FLsetVal_i	i(gkChanGlobal),	gihChan13
FLsetVal_i	i(gkChanGlobal),	gihChan14
FLsetVal_i	i(gkChanGlobal),	gihChan15
FLsetVal_i	i(gkChanGlobal),	gihChan16
endin

</CsInstruments>

<CsScore>
i 1 0 3600
</CsScore>

</CsoundSynthesizer>

