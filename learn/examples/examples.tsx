import { Csound, CsoundObj } from "@csound/browser";
import plingCsd from "./pling.csd?raw";
import { useEffect, useState } from "react";

import { FontAwesomeIcon } from "@fortawesome/react-fontawesome";
import {
  faPlay,
  faPause,
  faVolumeMute,
  faVolumeHigh,
  faVolumeLow,
} from "@fortawesome/free-solid-svg-icons";
import * as Slider from "@radix-ui/react-slider";

const startCsound = async (csound: CsoundObj) => {
  console.log("Starting Csound...");
  await csound.setOption("-b1024")
  await csound.setOption("-B1024")

  await csound.compileCsd(plingCsd);
  await csound.start();

  const context = await csound.getAudioContext();
  if (context) {
    context.resume();
  }
};

const App = () => {
  const [csound, setCsound] = useState<CsoundObj>();
  const [playing, setPlaying] = useState<boolean>(false);
  const [gain, setGain] = useState<number>(1);
  const [gainNode, setGainNode] = useState<GainNode>();

  const startPling = async () => {
    if (!csound) {

      const ac = new AudioContext({
        sampleRate: 44100,
        latencyHint: "playback",
      });

      const cs = await Csound({
        inputChannelCount: 0,
        outputChannelCount: 2,
        audioContext: ac,
      });
      setCsound(cs);

      const context = await cs?.getAudioContext();

      if (cs && context) {
        const gainNode = context.createGain();
        const csNode = await cs.getNode();

        if (csNode) {
          csNode.disconnect();
          csNode.connect(gainNode);
          gainNode.connect(context.destination);
          setGainNode(gainNode);
        }
      }

      if (cs) {
        await startCsound(cs);

        setPlaying(true);
      } else {
        console.error("Could not create Csound object");
      }
    } else {
      const audioContext = await csound.getAudioContext();
      if (audioContext?.state === "running") {
        audioContext.suspend();
        setPlaying(false);
      } else {
        audioContext?.resume();
        setPlaying(true);
      }
    }
  };

  useEffect(() => {
    if (gainNode) {
      gainNode.gain.setTargetAtTime(gain, 0, .01);
      // gainNode.gain.value = gain;
    }
  }, [gain, gainNode]);

  return (
    <div className="flex h-screen w-screen justify-center items-center bg-orange-200">
      <div className="justify-center text-center m-8">
        <div className="text-3xl">Sound Bath (2024)</div>
        <div className="text-md">Steven Yi &lt;stevenyi@gmail.com&gt;</div>
        <p className="mt-4">
          A meditative sound bath using the Solfeggio Frequencies.
        </p>
        <div className="flex mt-4">
          <div className="grow" />
          <ul className="list-disc text-left w-fit">
            <li>Root Chakra: 396 Hz</li>
            <li>Sacral Chakra: 417 Hz </li>
            <li>Solar Plexus Chakra: 528 Hz </li>
            <li>Heart Chakra: 639 Hz </li>
            <li>Throat Chakra: 741 Hz </li>
            <li>Third Eye Chakra: 852 Hz </li>
            <li>Crown Chakra: 963 Hz </li>
          </ul>
          <div className="grow" />
        </div>
        <div className="my-8 flex gap-4 items-center">
          <button
            className="w-14 bg-orange-500 hover:bg-orange-600 text-white font-bold py-2 px-4 rounded"
            onClick={startSoundBath}
          >
            <FontAwesomeIcon icon={playing ? faPause : faPlay} />
          </button>
          <Slider.Root
            className="relative flex items-center select-none touch-none w-full h-5"
            min={0}
            value={[gain]}
            max={1}
            step={0.01}
            onValueChange={(value) => {
              setGain(value[0]);
            }}
          >
            <Slider.Track className="bg-orange-500/70 relative grow rounded-full h-[3px]">
              <Slider.Range className="absolute bg-orange-500/30 rounded-full h-full" />
            </Slider.Track>
            <Slider.Thumb
              className="block w-5 h-5 bg-orange-400 rounded-[10px] hover:bg-violet3 focus:outline-none"
              aria-label="Volume"
            />
          </Slider.Root>

          <button
            className="w-14 bg-orange-500 hover:bg-orange-600 text-white font-bold py-2 px-3 rounded"
            onClick={() => {
              setGain(gain > 0 ? 0 : 1);
            }}
          >
            <FontAwesomeIcon
              icon={
                gain == 0
                  ? faVolumeMute
                  : gain < 0.5
                  ? faVolumeLow
                  : faVolumeHigh
              }
            />
          </button>
        </div>
      </div>
    </div>
  );
};

export default App;