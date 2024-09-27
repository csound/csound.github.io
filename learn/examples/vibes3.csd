<CsoundSynthesizer>
<CsOptions>
-odac -m128
</CsOptions>
<CsInstruments>

// version 3: better solution with 2dim array

sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1
seed 0

giStrike = ftgen(1,0,256,1,"marmstk1.wav",0,0,0)
giSine = ftgen(2,0,128,10,1)

garev1,garev2 init 0,0

opcode RndInt,i,ii
  iMin,iMax xin
  xout int(random:i(iMin,iMax+.9999))
endop

opcode RndInt,k,kk
  kMin,kMax xin
  xout int(random:k(kMin,kMax+.9999))
endop

instr Params

  gkAllParams[][] init 9,8
  gkAllParams = fillarray(-15,5,1, 110,110,5,5,4,
                          -15,5,1,  55,220,4,5,6,
                          -15,5,10,220,220,4,4,2,
                          -15,5,10,220,220,3,5,3,
                          -18,5,20,220, 55,2,8,7,
                          -12,2,10, 55, 55,3,5,3,
                           -9,6,30,330,330,2,3,2,
                          -18,6,10,330,330,1,4,5,
                          -18,2,10, 30, 20,4,8,6)

  turnoff
  
endin
schedule("Params",0,1)

instr MakeChord
   
  gkArr[] init 8
  kDurs[] = fillarray(20,10,10,10,20,10,30,10,10)
  kTime init 0
  kCount init 0
  
  if kTime <= 0 then
    kIndx = (kCount < 9) ? kCount : RndInt:k(0,8)
    kTime = kDurs[kIndx]
    gkArr = getrow(gkAllParams,kIndx)
    printks("Playing row %d for %d seconds\n",0,kIndx,kTime)
    kCount += 1
  endif
   
  // slight irregularity in metro ticks
  kfm = randomi:k(gkArr[1],gkArr[1]*1.05,1)
  // frequency shift if ifreq1 != ifreq2
  kfreq = gkArr[3] + phasor:k(1/gkArr[2]) * (gkArr[4]-gkArr[3])
  // generate chord for each metro tick
  schedkwhen(metro(kfm),0,0,"Chord",0,1/gkArr[1],kfreq)
  
  // count time
  kTime -= 1/kr
  
endin
schedule("MakeChord",0,-1)


instr Chord

  p3 *= random:i(2,4)
  idb = i(gkArr,0)
  iamp = ampdb(idb)
  iint1 = i(gkArr,5)
  iint2 = i(gkArr,6)
  innotes = i(gkArr,7)
  ifreq = p4

  indx = 0  
  while (indx < innotes) do
    
    iint = round(random:i(iint1,iint2))
    iint = (indx > 0) ? iint : 0
    iffactor = semitone(iint)
    ifreq *= iffactor
    iamp = random:i(iamp,iamp*1.05)
    schedule "Tone", 0, p3, iamp, ifreq*iffactor
  
    indx += 1
  od
    
endin

instr Tone
  
  iamp = p4
  ifreq = p5
  ihrd = random:i(0.1,0.9)
  ipos = random:i(0,1)
  
  ares = vibes(iamp,ifreq,ihrd,ipos,1,6,0.05,2,0.1)

  // panning and dry output
  adryl,adryr pan2 linen:a(ares,0,p3,p3/2),random:i(0,1)
  out(adryl,adryr)
    
  // send part of it to reverb
  irsend random 0.2, 0.4
  garev1 += irsend * adryl
  garev2 += irsend * adryr
    
endin

instr Reverb
  arev1, arev2 reverbsc garev1, garev2, 0.85, sr/2
  out(arev1,arev2)
  clear(garev1,garev2)
endin
schedule("Reverb",0,-1)

</CsInstruments>
<CsScore>

</CsScore>
</CsoundSynthesizer>

<bsbPanel>
 <label>Widgets</label>
 <objectName/>
 <x>100</x>
 <y>100</y>
 <width>320</width>
 <height>240</height>
 <visible>true</visible>
 <uuid/>
 <bgcolor mode="background">
  <r>240</r>
  <g>240</g>
  <b>240</b>
 </bgcolor>
</bsbPanel>
<bsbPresets>
</bsbPresets>
