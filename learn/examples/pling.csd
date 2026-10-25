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

// by joachim heintz

instr Pling
  // generate one sound in a wide range between short/noisy and long/pitched
  plg:a = mode(mpulse(ampdb(random(-22,0)),p3),mtof(random(80,100)),10^(p3-1))
  // distribute anywhere in the stereo field and output
  out(pan2:a[](plg,random(0,1)))
  // call the next instance of this instrument
  schedule(Pling,rnd(1),random(1,4))
endin
schedule(Pling,0,1)

</CsInstruments>
<CsScore>
</CsScore>
</CsoundSynthesizer>
