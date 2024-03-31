<CsoundSynthesizer>
<CsOptions>
-odac -m128
</CsOptions>
<CsInstruments>
sr = 44100
ksmps = 64
nchnls = 2
0dbfs = 1
seed 0

instr Pling
  aMode = mode(mpulse(ampdb(random:i(-22,0)),p3),mtof:i(random:i(80,100)),10^(p3-1))
  aL,aR pan2 aMode,random:i(0,1)
  out(aL,aR)
  schedule("Pling",rnd:i(1),random:i(1,4))
endin
schedule("Pling",0,3)

</CsInstruments>
<CsScore>
</CsScore>
</CsoundSynthesizer>
