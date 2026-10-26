<CsoundSynthesizer>
<CsOptions>
-odac -m128
</CsOptions>
<CsInstruments>
sr = 44100
ksmps = 32
nchnls = 2
0dbfs = 1
seed(0)

// by iain mccurdy (Csound Haiku III, 2011)
// small code modifcations by joachim heintz 2024 / 2026

Impls@global:i = ftgen(0,0,4097,10,1,1/2,1/4,1/8)
MixL@global:a,MixR@global:a,SendL@global:a,SendR@global:a init 0    
     
instr start_sequences
  rate:k = scale(rspline:k(0,1,0.1,2)^2,10,0.3)
  cps:k = cpsoct(rspline:k(4.3,9.5,0.1,1))
  pan:k = rspline(0.1,4,0.1,1)
  wgoct1:k = rspline(6,9,0.05,1)
  wgoct2:k = rspline(6,9,0.05,1)
  schedkwhen(metro(rate),0,0,wguide2_note,0,4,cps,wgoct1,wgoct2,pan)
endin
schedule(start_sequences,0,-1)

instr wguide2_note
  dur:i,cps:i,wgoct1:i,wgoct2:i,pan:i = p3,p4,p5,p6,p7
  env:a = expon(1,10/cps,0.001) - 0.001
  impulse:a = poscil(env,cps,Impls)
  oct1:i,oct2:i = random(5,11),random(5,11)
  plk1:a = transeg(1+rnd(0.2),0.1,-15,1)
  plk2:a = transeg(1+rnd(0.2),0.1,-15,1)
  dmptim:i = random(0.1,3)
  cutoff:k = expseg(20000,dur-dmptim,20000,dmptim,200,1,200)
  wg2:a = wguide2(impulse,cpsoct(wgoct1)*plk1,
                 cpsoct(wgoct2)*plk2,cutoff,cutoff,0.27,0.23)
  wg2 = dcblock2(wg2)
  rel:a = linseg(1,dur-dmptim,1,dmptim,0)
  wg2 = wg2 * rel / (rnd(4)+3)
  l:a,r:a = pan2(wg2,pan)
  SendL += l*0.05
  SendR += r*0.05
  MixL += l
  MixR += r
endin

instr spatialise
  dlytim1:a = rspline(0.1,5,0.1,0.4)
  dlytim2:a = rspline(0.1,5,0.1,0.4)
  l:a = vdelay(MixL,dlytim1,50)
  r:a = vdelay(MixR,dlytim2,50)
  out(l/2,r/2)
  SendL += l*0.05
  SendR += r*0.05
  clear(MixL,MixR)
endin
schedule(spatialise,0,-1)

instr rvrb
  l:a,r:a = reverbsc(SendL,SendR,0.95,10000)
  out(l/2,r/2)
  clear(SendL,SendR)
endin
schedule(rvrb,0,-1)

</CsInstruments>
<CsScore>
</CsScore>
</CsoundSynthesizer>

