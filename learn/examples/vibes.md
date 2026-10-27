---
layout: examples
title: "Examples: Vibes"
subtitle: Algorithmic chord progressions using 2D parameter arrays and Csound's vibes physical model (by Luís Antunes Pena, modified by Joachim Heintz).
permalink: /examples/vibes.html
---

<script src="{{ '/assets/js/csound-example-player.js' | relative_url }}"
        data-csd="{{ '/learn/examples/vibes.csd' | relative_url }}"
        data-sample="{{ '/learn/examples/marmstk1.wav' | relative_url }}"></script>

<div class="cs-example-player-box">
  <div class="cs-example-toolbar">
    <button id="play" type="button" class="cs-play-btn" onclick="start()">
      <i class="fa fa-play" aria-hidden="true"></i> Play
    </button>
    <button id="pause" type="button" class="cs-stop-btn" onclick="pause()">
      <i class="fa fa-pause" aria-hidden="true"></i> Pause / Resume
    </button>
    <a href="{{ '/learn/examples/vibes.csd' | relative_url }}" class="btn btn-cs-outline btn-sm ms-auto" download>
      <i class="fa fa-download" aria-hidden="true"></i> Download vibes.csd
    </a>
  </div>
  <label for="console" class="visually-hidden">Csound Console Output</label>
  <textarea class="console" cols="80" rows="5" id="console" readonly placeholder="Click Play to start the Csound WebAssembly engine..."></textarea>
</div>

```csound
// load function tables
Strike@global:i = ftgen(1,0,256,1,"marmstk1.wav",0,0,0)
Sine@global:i = ftgen(2,0,128,10,1)

// initialize globale reverb variables
Rev1@global:a,Rev2@global:a init 0

// custom function for random integer
opcode RndInt(min:i,max:i):(i)
  xout(int(random:i(min,max+.9999)))
endop

opcode RndInt(min:k,max:k):(k)
  xout(int(random:k(min,max+.9999)))
endop


// generate a 2-dimensional global array with the parameters of each section
instr Params

  AllParams@global:k[][] init 9,8
  AllParams = fillarray(-15,5,1, 110,110,5,5,4,
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
schedule(Params,0,1)

// create one section
instr MakeChord
  
  Arr@global:k[] init 8
  durs:k[] = fillarray(20,10,10,10,20,10,30,10,10) //durations of sections
  time:k,count:k init 0
  
  // for each new section
  if time <= 0 then
    // play rows of AllParams as sequence, afterwards choose one randomly
    indx:k = (count < 9) ? count : RndInt:k(0,8)
    // get time and row according to the count index
    time = durs[indx]
    Arr = getrow(AllParams,indx)
    printks("Playing row %d for %d seconds\n",0,indx,time)
    count += 1
  endif
   
  // slight irregularity in metro ticks
  fm:k = randomi(Arr[1],Arr[1]*1.05,1)
  // frequency shift if ifreq1 != ifreq2
  freq:k = Arr[3] + phasor:k(1/Arr[2]) * (Arr[4]-Arr[3])
  // generate chord for each metro tick
  schedkwhen(metro(fm),0,0,Chord,0,1/Arr[1],freq)
  
  // count time (decrease like in a sandglass)
  time -= 1/kr
  
endin
schedule(MakeChord,0,-1)

// create one chord
instr Chord

  // get and adjust parameters
  p3 *= random:i(2,4)
  db:i = i(Arr,0)
  amp:i = ampdb(db)
  int1 = i(Arr,5)
  int2 = i(Arr,6)
  nnotes:i = i(Arr,7)
  freq:i = p4

  // loop for number of notes in chord
  indx = 0  
  while (indx < nnotes) do
    
    int = round(random:i(int1,int2))
    int = (indx > 0) ? int : 0
    ffactor:i = semitone(int)
    freq:i *= ffactor
    amp:i = random(amp,amp*1.05)
    schedule(Tone, 0, p3, amp, freq*ffactor)
  
    indx += 1
  od
    
endin

// create one tone with the vibes physical model
instr Tone
  
  amp:i = p4
  freq:i = p5
  hrd:i = random(0.1,0.9)
  pos:i = random(0,1)
  
  res:a = vibes(amp,freq,hrd,pos,1,6,0.05,2,0.1)

  // panning and dry output
  dryl:a,dryr:a = pan2(linen(res,0,p3,p3/2),random:i(0,1))
  out(dryl,dryr)
    
  // send part of it to reverb
  rsend:i = random(0.2, 0.4)
  Rev1 += rsend * dryl
  Rev2 += rsend * dryr
    
endin

// add reverb
instr Reverb

  rev1:a, rev2:a = reverbsc(Rev1, Rev2, 0.85, sr/2)
  out(rev1/2,rev2/2)
  clear(Rev1,Rev2)
  
endin
schedule(Reverb,0,-1)
```
