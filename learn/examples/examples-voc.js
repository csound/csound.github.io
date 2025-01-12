

// csound is the Csound engine object (null as we start)
let csoundvoc = null;

// instrument on/off state
let isOnVoc = false;
// CSD file name
const csdvoc = '/learn/examples/vocoder-orig-cs6-no-midi.csd'
// this is the JS function to start Csound
// and resume performance if needed
async function startvoc() {
// if the Csound object is not initialised
if(csoundvoc == null) {
// import the Csound method from csound.js
const { Csound } = await import(csoundjs);
// create a Csound engine object inside the context actx
csoundvoc = await Csound();
// copy the CSD file to the Csound local filesystem
await copyUrlToLocal(csdvoc,csd)
// compile the code in the CSD file
await csoundvoc.compileCsd(csdvoc)
// handle Csound messages
await csoundvoc.on("message", handleMessage);
// start the engine
await csoundvoc.start();
isOnVoc = true;
document.getElementById('console-voc').innerHTML += "running" + '\n';
document.getElementById('console-voc').scrollTop = 99999;
}
// start performance if paused
if(!isOnVoc) {
 document.getElementById('console-voc').innerHTML += "running again" + '\n';
 document.getElementById('console-voc').scrollTop = 99999;
 await csound.resume();
 isOnVoc = true;
}
}

let countVoc = 0;
function handleMessage(message) {
// get the display element (called console in the page)
let elementVoc = document.getElementById('console-voc');
// add the message to HTML content (plus a newline)
element.innerHTML += message + '\n';
// focus on bottom, new messages make the display scroll down
element.scrollTop = 99999;
// clear display every 1000 lines
if(countVoc == 1000) {    
countVoc = 0;
element.innerHTML == "";
}
countVoc += 1;
};

// toggle performance on/off
async function pausevoc() {
if(csoundvoc != null) {
if(isOnVoc) {
 document.getElementById('console-voc').innerHTML += "pausing" + '\n'; 
 document.getElementById('console-voc').scrollTop = 99999;
 await csound.pause();
 isOnVoc = false;
} else  {
 document.getElementById('console-voc').innerHTML += "running again" + '\n';
 document.getElementById('console-voc').scrollTop = 99999;
 await csound.resume();
 isOnVoc = true;
}
}
}

