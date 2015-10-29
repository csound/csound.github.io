---
layout: sidebar_toc
title: Applications of Csound 
sidebar_toc:
  - url: '#music_with_timelines'
    name: 'Music with Timelines'
  - url: '#music_in_daw'
    name: 'Music Using Csound in a DAW'
  - url: '#realtime_works'
    name: 'Realtime Works'
  - url: '#desktop_apps'
    name: 'Desktop Applications'
  - url: '#android_apps'
    name: 'Android Applications'
  - url: '#ios_apps'
    name: 'iOS Applications'
  - url: '#raspberry_pi'
    name: 'Embedded Applications with Raspberry Pi and Csound'
  - url: '#python'
    name: 'Do Scientific Computing with Python and Csound'
---

Csound has developed a lot since its early days. It's now being used in a host of different applications. From desktop audio software to hand held synthesisers, Csound can run on just about anything, or in anything these days. This page attempts to provide a snapshot of the various different ways Csound can be used. 

<h2 id="music_with_timelines">Music with Timelines</h2>

Many musicians and producers work with DAWs that present timelines of their tracks. Blue is Csound frontend that provides a timeline based approach to developing and composing music...Steven???

<h2 id="music_in_daw">Music Using Csound in a DAW</h2>

There are several different ways of using Csound in a DAW. 

####Cabbage
<img src="/images/cabbage.png" alt="Cabbage" style="width: 400px;"/>
Cabbage is a framework for developing audio plugins that use Csound as their processing engine. All the power of Csound can be wrapped into a VST plugin that can then be loaded in a variety of different host software. Cabbage provides users with a fully integrated IDE that allows drag and drop editing of GUI interfaces, real-time compilation, Csound debugger. Cabbage also ships with over 100 ready made audio effects and synthesisers. More information about Cabbage can be found [here](http://cabbageaudio.com) 

####Csound for Live
![Csound4Live](/images/csound4live.jpg)
Csound For Live is a suite of audio plugins that combines the real time performance capabilities of Ableton Live, the stable and customizable interface design of Max/MSP (through Max For Live), and the synthesis power of Csound. More information can be found [here](http://csoundforlive.com/). Note: users must have Max4Live. 

####Jack
[Jack](http://www.jackaudio.org/) is an API that enables complex routing of audio signals across applications. It can be used to route out of Csound and into any number of digital audio workstations. Jack runs on Linux, OSX and Windows. More information on using Csound and Jack can be found [here](http://csound.github.io/docs/manual/JackoOpcodes.html) 

####Csound and Logic
[Routing audio and MIDI between Csound and a DAW](http://www.csoundjournal.com/issue16/audiorouting.html) In this article Andreas Russo outlines the steps need in order to route Csound signals around your OSX desktop and into Logic using OSX's IAC driver and Soundflower.

<h2 id="realtime_works">Realtime Works</h2>

<h2 id="desktop_apps">Desktop Applications</h2>

<h2 id="android_apps">Android Applications</h2>

You do not have to be an Android developers, or even a master Csound coder to get started with Csound on Android. The Csound on Android package provides a basic example .csd player that can easily be hacked and mistreated any way you wish! Provided below are the best resources available to get you started.

[Kaoss Droid](http://csoundjournal.com/issue19/kaoss_droid.html): In this article Brain Redfern guides you through the setting up and development of a Csound based Android app. Project files are provided.

[Android Devices as MIDI Controllers](http://csoundjournal.com/issue20/android_midi.html): In this article Art Hunkins writes about using an Android handset as a MIDI controller for realtime composition.

[The Android .csd player](http://www.csoundjournal.com/issue17/android_csd_player.html) Brain Redfern discusses the stock Android CSD Player and provides examples of how to control instruments in realtime using on screens widgets. Project files are provided.
Link 4: This could be you!

<h2 id="ios_apps">iOS Applications</h2>

Csound has been used successfully on a host different iOS software. Keep reading for more details. 

####AudioKit

 The quickest entry to Csound on iOS is through AudioKit, an open-source audio synthesis, processing, and analysis platform developed with Csound at its core. Users don't need to know Csound in order to start developing with AudioKit. It ships with a host of tools to aid in the creation of iOS based audio software. Check out their website for more details and great demos. [AudioKit](http://audiokit.io/)
 [![IMAGE ALT TEXT](http://img.youtube.com/vi/oJkGgQKUCmM/0.jpg)](https://youtu.be/oJkGgQKUCmM "Video Title")


<h2 id="raspberry_pi">Embedded Applications with Raspberry Pi and Csound</h2>

<h2 id="python">Do Scientific Computing with Python and Csound</h2>
