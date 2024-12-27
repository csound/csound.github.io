
// csound is the Csound engine object (null as we start)
let csound = null;

// csound synthesis code
const code = `
instr 1
  out linenr(oscili(0dbfs*p4,p5),0.01,0.5,0.01)
endin
schedule(1,0,1,0.2,A4)
`;

// this is the JS function to run Csound
async function play() {
// if the Csound object is not initialised
if(csound == null) {
// import the Csound method from csound.js
const { Csound } = await import('https://www.unpkg.com/@csound/browser@6.18.7/dist/csound.js');
// create a Csound engine object
csound = await Csound();
// set realtime audio (dac) output  
await csound.setOption("-odac");
// compile csound code
await csound.compileOrc(code);
// start the engine
await csound.start();
} else
// if not just send an event to play a sound
await csound.inputMessage('i1 0 1 0.2 440');
}

