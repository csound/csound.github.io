Arduino_Processing_OSC_Csound.csd
Written by Iain McCurdy 2011

<CsoundSynthesizer>

<CsOptions>
-o dac -dm0
</CsOptions>
                                                       
<CsInstruments>

sr = 44100
ksmps = 8
nchnls = 1
0dbfs = 1

;FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
FLcolor	255, 255, 255,  0, 0, 0
;		LABEL          | WIDTH | HEIGHT | X | Y
	FLpanel	"Arduino OSC",    500,    330,    0,  0
                                              
#define	ANALOG_OUTPUT(N)
#
;VALUE DISPLAY BOXES	LABEL | WIDTH | HEIGHT | X | Y
idana$N		FLvalue	"",      60,      17,    5,  iy+20                               
;SLIDERS				            	MIN |  MAX | EXP | TYPE |  DISP   | WIDTH | HEIGHT | X  | Y
gk, gihana$N		FLslider 	"Analog $N",	0,    1024,   0,     1,   idana$N,   490,     20,    5,   iy
FLsetColor2	rnd(255),rnd(255),rnd(255),gihana$N
iy	=	iy+40
#
iy	=	0
$ANALOG_OUTPUT(0)
$ANALOG_OUTPUT(1)
$ANALOG_OUTPUT(2)
$ANALOG_OUTPUT(3)
$ANALOG_OUTPUT(4)
$ANALOG_OUTPUT(5)

#define	DIGITAL_OUTPUT(N)
#
;VALUE DISPLAY BOXES	LABEL | WIDTH | HEIGHT | X | Y
iddig$N		FLvalue	"",      41,      17,   ix, iy+37                               
;SLIDERS				            	MIN | MAX | EXP | TYPE | DISP   | WIDTH | HEIGHT | X  | Y
gk, gihdig$N		FLslider 	"Dig. $N",	0,     1,    0,     1,  iddig$N,   41,      20,   ix,  iy
FLsetColor2	rnd(255),rnd(255),rnd(255),gihdig$N
ix	=	ix+41
#
ix	=	2
iy	=	250
;FLlabel isize, ifont, ialign, ired, igreen, iblue
FLlabel    11,    0,     0,    0, 0, 0
$DIGITAL_OUTPUT(2)
$DIGITAL_OUTPUT(3)
$DIGITAL_OUTPUT(4)
$DIGITAL_OUTPUT(5)
$DIGITAL_OUTPUT(6)
$DIGITAL_OUTPUT(7)
$DIGITAL_OUTPUT(8)
$DIGITAL_OUTPUT(9)
$DIGITAL_OUTPUT(10)
$DIGITAL_OUTPUT(11)
$DIGITAL_OUTPUT(12)
$DIGITAL_OUTPUT(13)
iy	=	iy+70
ix	=	40

			FLpanel_end

;INSTRUCTIONS AND INFO PANEL                 WIDTH | HEIGHT | X | Y
				FLpanel	" ", 500,     560,   512, 0
;TEXT BOXES												TYPE | FONT | SIZE | WIDTH | HEIGHT | X | Y
ih		 	FLbox  	"                        Arduino OSC                          ", 	1,      5,     14,    490,    15,     5,   0
ih		 	FLbox  	"-------------------------------------------------------------", 	1,      5,     14,    490,    15,     5,  20
ih		 	FLbox  	"This example displays Arduino sensor input data received via ", 	1,      5,     14,    490,    15,     5,  40
ih		 	FLbox  	"OSC through 'Processing' (http://processing.org/).           ", 	1,      5,     14,    490,    15,     5,  60
ih		 	FLbox  	"The Arduino board suggested for use with this example is an  ", 	1,      5,     14,    490,    15,     5,  80
ih		 	FLbox  	"Uno (formerly known as a Diecimilia). The example could      ", 	1,      5,     14,    490,    15,     5, 100
ih		 	FLbox  	"easily be modified for use with other boards.                ", 	1,      5,     14,    490,    15,     5, 120 
ih		 	FLbox  	"You will need to ensure that the Arduino library for         ", 	1,      5,     14,    490,    15,     5, 140 
ih		 	FLbox  	"Processing:                                                  ", 	1,      5,     14,    490,    15,     5, 160 
ih		 	FLbox  	"http://www.arduino.cc/playground/Interfacing/Processing      ", 	1,      5,     14,    490,    15,     5, 180 
ih		 	FLbox  	"and the oscP5 library:                                       ", 	1,      5,     14,    490,    15,     5, 200 
ih		 	FLbox  	"http://www.sojamo.de/libraries/oscP5/                        ", 	1,      5,     14,    490,    15,     5, 220 
ih		 	FLbox  	"Run the Processing sketch included on my website simultaneous", 	1,      5,     14,    490,    15,     5, 240 
ih		 	FLbox  	"with this csd. You will also need to ensure that the correct ", 	1,      5,     14,    490,    15,     5, 260
ih		 	FLbox  	"serial device number has been selected in the Processing     ", 	1,      5,     14,    490,    15,     5, 280
ih		 	FLbox  	"sketch. By default device zero is selected.                  ", 	1,      5,     14,    490,    15,     5, 300
ih		 	FLbox  	"The Arduino should be programmed with a Standard Formata     ", 	1,      5,     14,    490,    15,     5, 320
ih		 	FLbox  	"sketch. All pins (both analog and digital) will be set as    ", 	1,      5,     14,    490,    15,     5, 340
ih		 	FLbox  	"inputs by the Processing sketch. Unused inputs that are not  ", 	1,      5,     14,    490,    15,     5, 360
ih		 	FLbox  	"connected to ground may pick up interference and output      ", 	1,      5,     14,    490,    15,     5, 380
ih		 	FLbox  	"random values - if you are unclear about this you should     ", 	1,      5,     14,    490,    15,     5, 400
ih		 	FLbox  	"first explore some of the basic Arduino examples on their    ", 	1,      5,     14,    490,    15,     5, 420           
ih		 	FLbox  	"website.                                                     ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"Analog inputs are represented as 8-bit integers (range 0 -   ", 	1,      5,     14,    490,    15,     5, 440
ih		 	FLbox  	"1023) and digital input values will be either a zero or a 1. ", 	1,      5,     14,    490,    15,     5, 460
ih		 	FLbox  	"This example produces no sound. It is suggested to disable or", 	1,      5,     14,    490,    15,     5, 480
ih		 	FLbox  	"quantize displaying of OSC data as FLTK or to the terminal in", 	1,      5,     14,    490,    15,     5, 500
ih		 	FLbox  	"a realtime performance.                                      ", 	1,      5,     14,    490,    15,     5, 520
ih		 	FLbox  	"The Processing sketch used is largely the work of Liam Lacey ", 	1,      5,     14,    490,    15,     5, 540
ih		 	FLbox  	"(http://liamtmlacey.tumblr.com).                             ", 	1,      5,     14,    490,    15,     5, 560
				FLpanel_end

;				FLrun	;RUN THE FLTK WIDGET THREAD
;END OF FLTK INTERFACE CODE;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

gihandle OSCinit 12001

instr   1	;READ OSC DATA

#define	READ_ANALOG_OSC(N)						;DEFINE A MACRO FOR INPUT OF ANALOG SENSOR DATA VIA OSC
	#
	gkana$N init 0							;INITIALISE ANALOG VARIABLE
	gktrigana$N  OSClisten gihandle, "/analog/$N", "i", gkana$N	;READ IN OSC VARIABLE
	#
	$READ_ANALOG_OSC(0)						;EXPAND MACRO, ONCE FOR EACH ANALOG INPUT
	$READ_ANALOG_OSC(1)
	$READ_ANALOG_OSC(2)
	$READ_ANALOG_OSC(3)
	$READ_ANALOG_OSC(4)
	$READ_ANALOG_OSC(5)

#define	READ_DIGITAL_OSC(N)						;DEFINE A MACRO FOR INPUT OF DIGITAL SENSOR DATA VIA OSC
	#
	gkdig$N init 0							;INITIALISE ANALOG VARIABLE
	gktrigdig$N  OSClisten gihandle, "/digital/$N", "i", gkdig$N	;READ IN OSC VARIABLE
	#
	$READ_DIGITAL_OSC(2)
	$READ_DIGITAL_OSC(3)
	$READ_DIGITAL_OSC(4)
	$READ_DIGITAL_OSC(5)
	$READ_DIGITAL_OSC(6)
	$READ_DIGITAL_OSC(7)
	$READ_DIGITAL_OSC(8)
	$READ_DIGITAL_OSC(9)
	$READ_DIGITAL_OSC(10)
	$READ_DIGITAL_OSC(11)
	$READ_DIGITAL_OSC(12)
	$READ_DIGITAL_OSC(13)
endin

instr	2	;PRINT TO TERMINAL
	;ANALOG                
	printf "analog 0: %d\n", gkana0+1, gkana0				;printf STATEMENTS ARE UPDATED EACH TIME THE INPUT VALUE CHANGES
	printf "analog 1: %d\n", gkana1+1, gkana1
	printf "analog 2: %d\n", gkana2+1, gkana2
	printf "analog 3: %d\n", gkana3+1, gkana3
	printf "analog 4: %d\n", gkana4+1, gkana4
	printf "analog 5: %d\n", gkana5+1, gkana5
	;DIGITAL
	printf "digital 2: %d\n", gkdig2+1, gkdig2
	printf "digital 3: %d\n", gkdig3+1, gkdig3         
	printf "digital 4: %d\n", gkdig4+1, gkdig4
	printf "digital 5: %d\n", gkdig5+1, gkdig5
	printf "digital 6: %d\n", gkdig6+1, gkdig6
	printf "digital 7: %d\n", gkdig7+1, gkdig7
	printf "digital 8: %d\n", gkdig8+1, gkdig8
	printf "digital 9: %d\n", gkdig9+1, gkdig9                     
	printf "digital 10: %d\n", gkdig10+1, gkdig10
	printf "digital 11: %d\n", gkdig11+1, gkdig11
	printf "digital 12: %d\n", gkdig12+1, gkdig12
	printf "digital 13: %d\n", gkdig13+1, gkdig13
endin


instr	3	;DISPLAY USING FLTK WIDGETS
#define	OUTPUT_ANALOG_AS_FLTK(N)
	#
	FLsetVal	gktrigana$N,gkana$N,gihana$N
	#
	$OUTPUT_ANALOG_AS_FLTK(0)
	$OUTPUT_ANALOG_AS_FLTK(1)
	$OUTPUT_ANALOG_AS_FLTK(2)
	$OUTPUT_ANALOG_AS_FLTK(3)
	$OUTPUT_ANALOG_AS_FLTK(4)
	$OUTPUT_ANALOG_AS_FLTK(5)
#define	OUTPUT_DIGITAL_AS_FLTK(N)
	#
	FLsetVal	gktrigdig$N,gkdig$N,gihdig$N
	#
	$OUTPUT_DIGITAL_AS_FLTK(2)
	$OUTPUT_DIGITAL_AS_FLTK(3)
	$OUTPUT_DIGITAL_AS_FLTK(4)
	$OUTPUT_DIGITAL_AS_FLTK(5)
	$OUTPUT_DIGITAL_AS_FLTK(6)
	$OUTPUT_DIGITAL_AS_FLTK(7)
	$OUTPUT_DIGITAL_AS_FLTK(8)
	$OUTPUT_DIGITAL_AS_FLTK(9)
	$OUTPUT_DIGITAL_AS_FLTK(10)
	$OUTPUT_DIGITAL_AS_FLTK(11)
	$OUTPUT_DIGITAL_AS_FLTK(12)
	$OUTPUT_DIGITAL_AS_FLTK(13)
endin

instr	4	;DISPLAY OSC RECEIVED DATA USING CSOUNDQT WIDGETS
	outvalue "ana0",gkana0
	outvalue "ana1",gkana1
	outvalue "ana2",gkana2
	outvalue "ana3",gkana3
	outvalue "ana4",gkana4
	outvalue "ana5",gkana5
	outvalue "dig2",gkdig2*1023
	outvalue "dig3",gkdig3*1023
	outvalue "dig4",gkdig4*1023
	outvalue "dig5",gkdig5*1023
	outvalue "dig6",gkdig6*1023
	outvalue "dig7",gkdig7*1023
	outvalue "dig8",gkdig8*1023
	outvalue "dig9",gkdig9*1023
	outvalue "dig10",gkdig10*1023
	outvalue "dig11",gkdig11*1023
	outvalue "dig12",gkdig12*1023
	outvalue "dig13",gkdig13*1023

endin

</CsInstruments>

<CsScore>
i 1 0 300	;READ IN OSC DATA
i 2 0 300	;PRINT TO TERMINAL
i 3 0 300	;DISPLAY USING FLTK WIDGETS
i 4 0 300	;DISPLAY USING QT WIDGETS
</CsScore>

</CsoundSynthesizer>
<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>26</x>
 <y>103</y>
 <width>569</width>
 <height>457</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="nobackground">
  <r>231</r>
  <g>46</g>
  <b>255</b>
 </bgcolor>
 <bsbObject version="2" type="BSBController">
  <objectName>hor1</objectName>
  <x>1</x>
  <y>1</y>
  <width>60</width>
  <height>130</height>
  <uuid>{cd6b12dc-9bfb-46ca-a35c-c2a28a62c5e4}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <objectName2>ana0</objectName2>
  <xMin>0.00000000</xMin>
  <xMax>1.00000000</xMax>
  <yMin>0.00000000</yMin>
  <yMax>1023.00000000</yMax>
  <xValue>0.46666667</xValue>
  <yValue>0.00000000</yValue>
  <type>fill</type>
  <pointsize>1</pointsize>
  <fadeSpeed>0.00000000</fadeSpeed>
  <mouseControl act="press">jump</mouseControl>
  <color>
   <r>0</r>
   <g>234</g>
   <b>0</b>
  </color>
  <randomizable mode="both" group="0">false</randomizable>
  <bgcolor>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </bgcolor>
 </bsbObject>
 <bsbObject version="2" type="BSBDisplay">
  <objectName/>
  <x>0</x>
  <y>132</y>
  <width>60</width>
  <height>27</height>
  <uuid>{50eda9ce-0a24-4926-bd2c-bf4f7fdbcc16}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>Analog 0</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBScrollNumber">
  <objectName>ana0</objectName>
  <x>0</x>
  <y>160</y>
  <width>61</width>
  <height>23</height>
  <uuid>{9873a359-3416-4792-b946-14f9b7114d5f}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="background">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <value>0.00000000</value>
  <resolution>1.00000000</resolution>
  <minimum>0.00000000</minimum>
  <maximum>1023.00000000</maximum>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
  <randomizable group="0">false</randomizable>
  <mouseControl act="continuous"/>
 </bsbObject>
 <bsbObject version="2" type="BSBController">
  <objectName>hor1</objectName>
  <x>63</x>
  <y>1</y>
  <width>60</width>
  <height>130</height>
  <uuid>{466327f2-c03f-4137-9374-7dd69d5c3444}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <objectName2>ana1</objectName2>
  <xMin>0.00000000</xMin>
  <xMax>1.00000000</xMax>
  <yMin>0.00000000</yMin>
  <yMax>1023.00000000</yMax>
  <xValue>0.46666667</xValue>
  <yValue>0.00000000</yValue>
  <type>fill</type>
  <pointsize>1</pointsize>
  <fadeSpeed>0.00000000</fadeSpeed>
  <mouseControl act="press">jump</mouseControl>
  <color>
   <r>0</r>
   <g>234</g>
   <b>0</b>
  </color>
  <randomizable mode="both" group="0">false</randomizable>
  <bgcolor>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </bgcolor>
 </bsbObject>
 <bsbObject version="2" type="BSBDisplay">
  <objectName/>
  <x>63</x>
  <y>132</y>
  <width>60</width>
  <height>27</height>
  <uuid>{4b27d23a-3f77-4b3c-ae6d-107e562c458f}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>Analog 1</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBScrollNumber">
  <objectName>ana1</objectName>
  <x>62</x>
  <y>160</y>
  <width>61</width>
  <height>23</height>
  <uuid>{94771a5c-5e7a-4510-a8df-9fb87076aaa3}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="background">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <value>0.00000000</value>
  <resolution>1.00000000</resolution>
  <minimum>0.00000000</minimum>
  <maximum>1023.00000000</maximum>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
  <randomizable group="0">false</randomizable>
  <mouseControl act=""/>
 </bsbObject>
 <bsbObject version="2" type="BSBController">
  <objectName>hor1</objectName>
  <x>125</x>
  <y>1</y>
  <width>60</width>
  <height>130</height>
  <uuid>{fe353ae6-19b1-4437-aa97-ea3c77514dbe}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <objectName2>ana2</objectName2>
  <xMin>0.00000000</xMin>
  <xMax>1.00000000</xMax>
  <yMin>0.00000000</yMin>
  <yMax>1023.00000000</yMax>
  <xValue>0.46666667</xValue>
  <yValue>0.00000000</yValue>
  <type>fill</type>
  <pointsize>1</pointsize>
  <fadeSpeed>0.00000000</fadeSpeed>
  <mouseControl act="press">jump</mouseControl>
  <color>
   <r>0</r>
   <g>234</g>
   <b>0</b>
  </color>
  <randomizable mode="both" group="0">false</randomizable>
  <bgcolor>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </bgcolor>
 </bsbObject>
 <bsbObject version="2" type="BSBDisplay">
  <objectName/>
  <x>125</x>
  <y>132</y>
  <width>60</width>
  <height>27</height>
  <uuid>{0f72f460-c09a-49c5-8a67-70f661843de6}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>Analog 2</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBScrollNumber">
  <objectName>ana2</objectName>
  <x>124</x>
  <y>160</y>
  <width>61</width>
  <height>23</height>
  <uuid>{54715751-97eb-4392-86e8-f738dfab55ad}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="background">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <value>0.00000000</value>
  <resolution>1.00000000</resolution>
  <minimum>0.00000000</minimum>
  <maximum>1023.00000000</maximum>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
  <randomizable group="0">false</randomizable>
  <mouseControl act=""/>
 </bsbObject>
 <bsbObject version="2" type="BSBController">
  <objectName>hor1</objectName>
  <x>187</x>
  <y>1</y>
  <width>60</width>
  <height>130</height>
  <uuid>{90c95429-bbed-4ed8-8460-31f3991a4691}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <objectName2>ana3</objectName2>
  <xMin>0.00000000</xMin>
  <xMax>1.00000000</xMax>
  <yMin>0.00000000</yMin>
  <yMax>1023.00000000</yMax>
  <xValue>0.46666667</xValue>
  <yValue>0.00000000</yValue>
  <type>fill</type>
  <pointsize>1</pointsize>
  <fadeSpeed>0.00000000</fadeSpeed>
  <mouseControl act="press">jump</mouseControl>
  <color>
   <r>0</r>
   <g>234</g>
   <b>0</b>
  </color>
  <randomizable mode="both" group="0">false</randomizable>
  <bgcolor>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </bgcolor>
 </bsbObject>
 <bsbObject version="2" type="BSBDisplay">
  <objectName/>
  <x>187</x>
  <y>132</y>
  <width>60</width>
  <height>27</height>
  <uuid>{91a4721d-f088-429b-b5a7-26a117a3d3ba}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>Analog 3</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBScrollNumber">
  <objectName>ana3</objectName>
  <x>186</x>
  <y>160</y>
  <width>61</width>
  <height>23</height>
  <uuid>{bab13dc3-b139-49a3-979a-8eaf1a445006}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="background">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <value>0.00000000</value>
  <resolution>1.00000000</resolution>
  <minimum>0.00000000</minimum>
  <maximum>1023.00000000</maximum>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
  <randomizable group="0">false</randomizable>
  <mouseControl act=""/>
 </bsbObject>
 <bsbObject version="2" type="BSBController">
  <objectName>hor1</objectName>
  <x>249</x>
  <y>1</y>
  <width>60</width>
  <height>130</height>
  <uuid>{78aae59e-cb73-4c99-b590-43d6229c0ed9}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <objectName2>ana4</objectName2>
  <xMin>0.00000000</xMin>
  <xMax>1.00000000</xMax>
  <yMin>0.00000000</yMin>
  <yMax>1023.00000000</yMax>
  <xValue>0.46666667</xValue>
  <yValue>0.00000000</yValue>
  <type>fill</type>
  <pointsize>1</pointsize>
  <fadeSpeed>0.00000000</fadeSpeed>
  <mouseControl act="press">jump</mouseControl>
  <color>
   <r>0</r>
   <g>234</g>
   <b>0</b>
  </color>
  <randomizable mode="both" group="0">false</randomizable>
  <bgcolor>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </bgcolor>
 </bsbObject>
 <bsbObject version="2" type="BSBDisplay">
  <objectName/>
  <x>249</x>
  <y>132</y>
  <width>60</width>
  <height>27</height>
  <uuid>{a82b8ad3-d624-4420-8a82-c4510309ff72}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>Analog 4</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBScrollNumber">
  <objectName>ana4</objectName>
  <x>248</x>
  <y>160</y>
  <width>61</width>
  <height>23</height>
  <uuid>{f8250744-955b-449a-81fc-0fc4aa01fc6c}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="background">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <value>0.00000000</value>
  <resolution>1.00000000</resolution>
  <minimum>0.00000000</minimum>
  <maximum>1023.00000000</maximum>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
  <randomizable group="0">false</randomizable>
  <mouseControl act=""/>
 </bsbObject>
 <bsbObject version="2" type="BSBController">
  <objectName>hor1</objectName>
  <x>311</x>
  <y>1</y>
  <width>60</width>
  <height>130</height>
  <uuid>{a3eca0da-ebe3-42be-930d-575db09f1c6b}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <objectName2>ana5</objectName2>
  <xMin>0.00000000</xMin>
  <xMax>1.00000000</xMax>
  <yMin>0.00000000</yMin>
  <yMax>1023.00000000</yMax>
  <xValue>0.46666667</xValue>
  <yValue>270.00000000</yValue>
  <type>fill</type>
  <pointsize>1</pointsize>
  <fadeSpeed>0.00000000</fadeSpeed>
  <mouseControl act="press">jump</mouseControl>
  <color>
   <r>0</r>
   <g>234</g>
   <b>0</b>
  </color>
  <randomizable mode="both" group="0">false</randomizable>
  <bgcolor>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </bgcolor>
 </bsbObject>
 <bsbObject version="2" type="BSBDisplay">
  <objectName/>
  <x>311</x>
  <y>132</y>
  <width>60</width>
  <height>27</height>
  <uuid>{3cc8e725-70d8-49b6-bd61-851380cfeb03}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>Analog 5</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBScrollNumber">
  <objectName>ana5</objectName>
  <x>310</x>
  <y>160</y>
  <width>61</width>
  <height>23</height>
  <uuid>{ed34ab42-aed1-40ce-be01-60e478c48e6b}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="background">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <value>270.00000000</value>
  <resolution>1.00000000</resolution>
  <minimum>0.00000000</minimum>
  <maximum>1023.00000000</maximum>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
  <randomizable group="0">false</randomizable>
  <mouseControl act=""/>
 </bsbObject>
 <bsbObject version="2" type="BSBController">
  <objectName>hor1</objectName>
  <x>0</x>
  <y>236</y>
  <width>60</width>
  <height>33</height>
  <uuid>{be195476-2ba7-429f-b77b-514b3871dff5}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <objectName2>dig2</objectName2>
  <xMin>0.00000000</xMin>
  <xMax>1.00000000</xMax>
  <yMin>0.00000000</yMin>
  <yMax>1024.00000000</yMax>
  <xValue>0.46666667</xValue>
  <yValue>0.00000000</yValue>
  <type>fill</type>
  <pointsize>1</pointsize>
  <fadeSpeed>0.00000000</fadeSpeed>
  <mouseControl act="press">jump</mouseControl>
  <color>
   <r>233</r>
   <g>234</g>
   <b>18</b>
  </color>
  <randomizable mode="both" group="0">false</randomizable>
  <bgcolor>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </bgcolor>
 </bsbObject>
 <bsbObject version="2" type="BSBDisplay">
  <objectName/>
  <x>0</x>
  <y>271</y>
  <width>60</width>
  <height>27</height>
  <uuid>{5d83d2cc-2e3d-48b1-9e17-9f0488bd38e7}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>Digital 2</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBScrollNumber">
  <objectName>dig2</objectName>
  <x>0</x>
  <y>299</y>
  <width>61</width>
  <height>23</height>
  <uuid>{a4be386d-428c-4500-b58a-8fd560f90966}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="background">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <value>0.00000000</value>
  <resolution>1.00000000</resolution>
  <minimum>0.00000000</minimum>
  <maximum>1.00000000</maximum>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
  <randomizable group="0">false</randomizable>
  <mouseControl act=""/>
 </bsbObject>
 <bsbObject version="2" type="BSBController">
  <objectName>hor1</objectName>
  <x>62</x>
  <y>236</y>
  <width>60</width>
  <height>33</height>
  <uuid>{c889d569-8b48-48a0-9b40-74ade106444a}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <objectName2>dig3</objectName2>
  <xMin>0.00000000</xMin>
  <xMax>1.00000000</xMax>
  <yMin>0.00000000</yMin>
  <yMax>1024.00000000</yMax>
  <xValue>0.46666667</xValue>
  <yValue>0.00000000</yValue>
  <type>fill</type>
  <pointsize>1</pointsize>
  <fadeSpeed>0.00000000</fadeSpeed>
  <mouseControl act="press">jump</mouseControl>
  <color>
   <r>233</r>
   <g>234</g>
   <b>18</b>
  </color>
  <randomizable mode="both" group="0">false</randomizable>
  <bgcolor>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </bgcolor>
 </bsbObject>
 <bsbObject version="2" type="BSBDisplay">
  <objectName/>
  <x>62</x>
  <y>271</y>
  <width>60</width>
  <height>27</height>
  <uuid>{419530e7-3945-420d-9ef1-51fa06ecdb42}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>Digital 3</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBScrollNumber">
  <objectName>dig3</objectName>
  <x>62</x>
  <y>299</y>
  <width>61</width>
  <height>23</height>
  <uuid>{fe9a6dec-38ff-4643-9bf5-f39d4d0eec00}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="background">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <value>0.00000000</value>
  <resolution>1.00000000</resolution>
  <minimum>0.00000000</minimum>
  <maximum>1.00000000</maximum>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
  <randomizable group="0">false</randomizable>
  <mouseControl act=""/>
 </bsbObject>
 <bsbObject version="2" type="BSBController">
  <objectName>hor1</objectName>
  <x>123</x>
  <y>235</y>
  <width>60</width>
  <height>33</height>
  <uuid>{7562c027-b90f-4373-beff-7d578f6d4e74}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <objectName2>dig4</objectName2>
  <xMin>0.00000000</xMin>
  <xMax>1.00000000</xMax>
  <yMin>0.00000000</yMin>
  <yMax>1024.00000000</yMax>
  <xValue>0.46666667</xValue>
  <yValue>0.00000000</yValue>
  <type>fill</type>
  <pointsize>1</pointsize>
  <fadeSpeed>0.00000000</fadeSpeed>
  <mouseControl act="press">jump</mouseControl>
  <color>
   <r>233</r>
   <g>234</g>
   <b>18</b>
  </color>
  <randomizable mode="both" group="0">false</randomizable>
  <bgcolor>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </bgcolor>
 </bsbObject>
 <bsbObject version="2" type="BSBDisplay">
  <objectName/>
  <x>123</x>
  <y>271</y>
  <width>60</width>
  <height>27</height>
  <uuid>{18148f3f-ea67-4c11-85cb-af7cd8a06801}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>Digital 4</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBScrollNumber">
  <objectName>dig4</objectName>
  <x>123</x>
  <y>299</y>
  <width>61</width>
  <height>23</height>
  <uuid>{57aea1c7-79ce-441a-8b4d-6cfd460a4ab4}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="background">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <value>0.00000000</value>
  <resolution>1.00000000</resolution>
  <minimum>0.00000000</minimum>
  <maximum>1.00000000</maximum>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
  <randomizable group="0">false</randomizable>
  <mouseControl act=""/>
 </bsbObject>
 <bsbObject version="2" type="BSBController">
  <objectName>hor1</objectName>
  <x>185</x>
  <y>235</y>
  <width>60</width>
  <height>33</height>
  <uuid>{25fd9b6c-15b4-4b8c-be80-d5e2f4797e90}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <objectName2>dig5</objectName2>
  <xMin>0.00000000</xMin>
  <xMax>1.00000000</xMax>
  <yMin>0.00000000</yMin>
  <yMax>1024.00000000</yMax>
  <xValue>0.46666667</xValue>
  <yValue>0.00000000</yValue>
  <type>fill</type>
  <pointsize>1</pointsize>
  <fadeSpeed>0.00000000</fadeSpeed>
  <mouseControl act="press">jump</mouseControl>
  <color>
   <r>233</r>
   <g>234</g>
   <b>18</b>
  </color>
  <randomizable mode="both" group="0">false</randomizable>
  <bgcolor>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </bgcolor>
 </bsbObject>
 <bsbObject version="2" type="BSBDisplay">
  <objectName/>
  <x>185</x>
  <y>271</y>
  <width>60</width>
  <height>27</height>
  <uuid>{d355f6e1-d571-40b8-968e-adc130e4674c}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>Digital 5</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBScrollNumber">
  <objectName>dig5</objectName>
  <x>185</x>
  <y>299</y>
  <width>61</width>
  <height>23</height>
  <uuid>{d6336a4b-fd09-49e3-90ea-ac93237abff5}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="background">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <value>0.00000000</value>
  <resolution>1.00000000</resolution>
  <minimum>0.00000000</minimum>
  <maximum>1.00000000</maximum>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
  <randomizable group="0">false</randomizable>
  <mouseControl act=""/>
 </bsbObject>
 <bsbObject version="2" type="BSBController">
  <objectName>hor1</objectName>
  <x>246</x>
  <y>236</y>
  <width>60</width>
  <height>33</height>
  <uuid>{60d0b502-e9fe-4bf0-a60c-16ab2766be00}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <objectName2>dig6</objectName2>
  <xMin>0.00000000</xMin>
  <xMax>1.00000000</xMax>
  <yMin>0.00000000</yMin>
  <yMax>1024.00000000</yMax>
  <xValue>0.46666667</xValue>
  <yValue>0.00000000</yValue>
  <type>fill</type>
  <pointsize>1</pointsize>
  <fadeSpeed>0.00000000</fadeSpeed>
  <mouseControl act="press">jump</mouseControl>
  <color>
   <r>233</r>
   <g>234</g>
   <b>18</b>
  </color>
  <randomizable mode="both" group="0">false</randomizable>
  <bgcolor>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </bgcolor>
 </bsbObject>
 <bsbObject version="2" type="BSBDisplay">
  <objectName/>
  <x>246</x>
  <y>271</y>
  <width>60</width>
  <height>27</height>
  <uuid>{5ca8185e-5dd4-4b49-9026-faf28b90601f}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>Digital 6</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBScrollNumber">
  <objectName>dig6</objectName>
  <x>246</x>
  <y>299</y>
  <width>61</width>
  <height>23</height>
  <uuid>{1e357e0e-fabe-4c19-8aba-2ee36acdc323}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="background">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <value>0.00000000</value>
  <resolution>1.00000000</resolution>
  <minimum>0.00000000</minimum>
  <maximum>1.00000000</maximum>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
  <randomizable group="0">false</randomizable>
  <mouseControl act=""/>
 </bsbObject>
 <bsbObject version="2" type="BSBController">
  <objectName>hor1</objectName>
  <x>308</x>
  <y>236</y>
  <width>60</width>
  <height>33</height>
  <uuid>{8a216695-9f53-4502-b409-c7cbf492434b}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <objectName2>dig7</objectName2>
  <xMin>0.00000000</xMin>
  <xMax>1.00000000</xMax>
  <yMin>0.00000000</yMin>
  <yMax>1024.00000000</yMax>
  <xValue>0.46666667</xValue>
  <yValue>0.00000000</yValue>
  <type>fill</type>
  <pointsize>1</pointsize>
  <fadeSpeed>0.00000000</fadeSpeed>
  <mouseControl act="press">jump</mouseControl>
  <color>
   <r>233</r>
   <g>234</g>
   <b>18</b>
  </color>
  <randomizable mode="both" group="0">false</randomizable>
  <bgcolor>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </bgcolor>
 </bsbObject>
 <bsbObject version="2" type="BSBDisplay">
  <objectName/>
  <x>308</x>
  <y>271</y>
  <width>60</width>
  <height>27</height>
  <uuid>{25fc2fe3-af54-4f73-bf09-91d052379215}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>Digital 7</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBScrollNumber">
  <objectName>dig7</objectName>
  <x>308</x>
  <y>299</y>
  <width>61</width>
  <height>23</height>
  <uuid>{8d20f452-a6ee-46ad-8601-a403301487b3}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="background">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <value>0.00000000</value>
  <resolution>1.00000000</resolution>
  <minimum>0.00000000</minimum>
  <maximum>1.00000000</maximum>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
  <randomizable group="0">false</randomizable>
  <mouseControl act=""/>
 </bsbObject>
 <bsbObject version="2" type="BSBController">
  <objectName>hor1</objectName>
  <x>369</x>
  <y>236</y>
  <width>60</width>
  <height>33</height>
  <uuid>{5b3fad13-0862-4326-9113-be17783a8825}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <objectName2>dig8</objectName2>
  <xMin>0.00000000</xMin>
  <xMax>1.00000000</xMax>
  <yMin>0.00000000</yMin>
  <yMax>1024.00000000</yMax>
  <xValue>0.46666667</xValue>
  <yValue>0.00000000</yValue>
  <type>fill</type>
  <pointsize>1</pointsize>
  <fadeSpeed>0.00000000</fadeSpeed>
  <mouseControl act="press">jump</mouseControl>
  <color>
   <r>233</r>
   <g>234</g>
   <b>18</b>
  </color>
  <randomizable mode="both" group="0">false</randomizable>
  <bgcolor>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </bgcolor>
 </bsbObject>
 <bsbObject version="2" type="BSBDisplay">
  <objectName/>
  <x>369</x>
  <y>271</y>
  <width>60</width>
  <height>27</height>
  <uuid>{3e64b540-a3a8-4a71-bf51-4e23457a51fb}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>Digital 8</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBScrollNumber">
  <objectName>dig8</objectName>
  <x>369</x>
  <y>299</y>
  <width>61</width>
  <height>23</height>
  <uuid>{f62bc3db-f851-451d-adaa-53bde21771ee}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="background">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <value>0.00000000</value>
  <resolution>1.00000000</resolution>
  <minimum>0.00000000</minimum>
  <maximum>1.00000000</maximum>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
  <randomizable group="0">false</randomizable>
  <mouseControl act=""/>
 </bsbObject>
 <bsbObject version="2" type="BSBController">
  <objectName>hor1</objectName>
  <x>431</x>
  <y>235</y>
  <width>60</width>
  <height>33</height>
  <uuid>{132ebc62-1e61-43a9-8d9e-e48f0071f96d}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <objectName2>dig9</objectName2>
  <xMin>0.00000000</xMin>
  <xMax>1.00000000</xMax>
  <yMin>0.00000000</yMin>
  <yMax>1024.00000000</yMax>
  <xValue>0.46666667</xValue>
  <yValue>0.00000000</yValue>
  <type>fill</type>
  <pointsize>1</pointsize>
  <fadeSpeed>0.00000000</fadeSpeed>
  <mouseControl act="press">jump</mouseControl>
  <color>
   <r>233</r>
   <g>234</g>
   <b>18</b>
  </color>
  <randomizable mode="both" group="0">false</randomizable>
  <bgcolor>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </bgcolor>
 </bsbObject>
 <bsbObject version="2" type="BSBDisplay">
  <objectName/>
  <x>431</x>
  <y>271</y>
  <width>60</width>
  <height>27</height>
  <uuid>{671284eb-eac9-4c6b-bd3b-1ae02339b64e}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <label>Digital 9</label>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <precision>3</precision>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="nobackground">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
 </bsbObject>
 <bsbObject version="2" type="BSBScrollNumber">
  <objectName>dig9</objectName>
  <x>431</x>
  <y>299</y>
  <width>61</width>
  <height>23</height>
  <uuid>{b8794bec-9d4d-48c2-96cd-aabd73f1888e}</uuid>
  <visible>true</visible>
  <midichan>0</midichan>
  <midicc>0</midicc>
  <alignment>left</alignment>
  <font>Arial</font>
  <fontsize>10</fontsize>
  <color>
   <r>0</r>
   <g>0</g>
   <b>0</b>
  </color>
  <bgcolor mode="background">
   <r>255</r>
   <g>255</g>
   <b>255</b>
  </bgcolor>
  <value>0.00000000</value>
  <resolution>1.00000000</resolution>
  <minimum>0.00000000</minimum>
  <maximum>1.00000000</maximum>
  <bordermode>border</bordermode>
  <borderradius>1</borderradius>
  <borderwidth>1</borderwidth>
  <randomizable group="0">false</randomizable>
  <mouseControl act=""/>
 </bsbObject>
</bsbPanel>
<bsbPresets>
</bsbPresets>
