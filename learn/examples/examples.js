// play "pling.csd"

// csound.js is the Csound WASM module
const csoundjs = "https://www.unpkg.com/@csound/browser@6.18.7/dist/csound.js";
// csound is the Csound engine object (null as we start)
let csound = null;

// instrument on/off state
let isOn = false;
// CSD file name
const csd = '/learn/examples/pling.csd'
// this is the JS function to start Csound
// and resume performance if needed
async function start() {
// if the Csound object is not initialised
if(csound == null) {
// import the Csound method from csound.js
const { Csound } = await import(csoundjs);
// create a Csound engine object inside the context actx
csound = await Csound();
// copy the CSD file to the Csound local filesystem
await copyUrlToLocal(csd,csd)
// compile the code in the CSD file
await csound.compileCsd(csd)
// handle Csound messages
await csound.on("message", handleMessage);
// start the engine
await csound.start();
isOn = true;
document.getElementById('console').innerHTML += "running" + '\n';
document.getElementById('console').scrollTop = 99999;
}
// start performance if paused
if(!isOn) {
 document.getElementById('console').innerHTML += "running again" + '\n';
 document.getElementById('console').scrollTop = 99999;
 await csound.resume();
 isOn = true;
}
}

let count = 0;
function handleMessage(message) {
// get the display element (called console in the page)
let element = document.getElementById('console');
// add the message to HTML content (plus a newline)
element.innerHTML += message + '\n';
// focus on bottom, new messages make the display scroll down
element.scrollTop = 99999;
// clear display every 1000 lines
if(count == 1000) {    
count = 0;
element.innerHTML == "";
}
count += 1;
};

// Copy file to local filesystem
async function copyUrlToLocal(src, dest) {
// fetch the file
let srcfile = await fetch(src)
// get the file data as an array
let dat = await srcfile.arrayBuffer();
// write the data as a new file in the filesystem
await csound.fs.writeFile(dest, new Uint8Array(dat));
}

// toggle performance on/off
async function pause() {
if(csound != null) {
if(isOn) {
 document.getElementById('console').innerHTML += "pausing" + '\n'; 
 document.getElementById('console').scrollTop = 99999;
 await csound.pause();
 isOn = false;
} else  {
 document.getElementById('console').innerHTML += "running again" + '\n';
 document.getElementById('console').scrollTop = 99999;
 await csound.resume();
 isOn = true;
}
}
}

