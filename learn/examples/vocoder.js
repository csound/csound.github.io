// play "vocoder-orig-cs6-no-midi.csd" with @csound/browser 7.0.0

const csoundjs = "https://cdn.jsdelivr.net/npm/@csound/browser@7.0.0/dist/csound.js";
let csound = null;
let isOn = false;
const csd = "/learn/examples/vocoder-orig-cs6-no-midi.csd";
const speechSample = "/learn/examples/fox.wav";

async function start() {
  const consoleEl = document.getElementById("console");
  if (csound == null) {
    const { Csound } = await import(csoundjs);
    consoleEl.value += "loading Csound 7.0.0 WASM...\n";
    consoleEl.scrollTop = consoleEl.scrollHeight;
    csound = await Csound();
    await csound.on("message", handleMessage);
    await csound.setOption("-odac");
    await copyUrlToLocal(speechSample, "fox.wav");
    await copyUrlToLocal(csd, "vocoder.csd");
    await csound.compileCSD("vocoder.csd", 0);
    await csound.start();
    isOn = true;
    consoleEl.value += "running...\n";
    consoleEl.scrollTop = consoleEl.scrollHeight;
    return;
  }
  if (!isOn) {
    consoleEl.value += "resuming...\n";
    consoleEl.scrollTop = consoleEl.scrollHeight;
    await csound.resume();
    isOn = true;
  }
}

let count = 0;
function handleMessage(message) {
  const element = document.getElementById("console");
  if (!element) return;
  if (count >= 1000) {
    count = 0;
    element.value = "";
  }
  element.value += message + "\n";
  element.scrollTop = element.scrollHeight;
  count += 1;
}

async function copyUrlToLocal(src, dest) {
  const srcfile = await fetch(src);
  const dat = await srcfile.arrayBuffer();
  await csound.fs.writeFile(dest, new Uint8Array(dat));
}

async function pause() {
  const consoleEl = document.getElementById("console");
  if (csound != null) {
    if (isOn) {
      consoleEl.value += "pausing...\n";
      consoleEl.scrollTop = consoleEl.scrollHeight;
      await csound.pause();
      isOn = false;
    } else {
      consoleEl.value += "resuming...\n";
      consoleEl.scrollTop = consoleEl.scrollHeight;
      await csound.resume();
      isOn = true;
    }
  }
}
