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
  - url: '#game'
    name: 'Game music'
  - url: '#raspberry_pi'
    name: 'Embedded Applications with Raspberry Pi and Csound'
#  - url: '#python'
#    name: 'Do Scientific Computing with Python and Csound'
---

Csound has developed a lot since its early days. It's now being used in a host of different applications. From desktop audio software to hand held synthesisers, Csound can run on just about anything, or in anything these days. This page attempts to provide a snapshot of the various different ways Csound can be used.  

<h2 id="music_with_timelines">Music with Timelines</h2>

<img src="/images/blue_score.png" alt="Blue - Score" style="width: 400px;"/>
<img src="/images/blue_orc.png" alt="Blue - Orchestra" style="width: 400px;"/>


Many musicians and producers work with DAWs that present timelines of their tracks. Blue is a Csound-based integrated music environment that provides a timeline based approach to developing and composing music, as well as tools for realtime music performance and exploration. Blue provides high-level tools for coordinating and developing musical ideas, built-in scripting language support, a mixer system with user-definable graphical instruments and effects, and more. Users can choose the best tool for their work, whether that's a purely graphical tool or coding directly in Csound code. More information about Blue cn be found [here](http://blue.kunstmusik.com). 

<br>
<br>
<h2 id="music_in_daw">Music Using Csound in a DAW</h2>

There are several different ways of using Csound in a DAW. 

####Cabbage
<img src="/images/cabbage.png" alt="Cabbage" style="width: 400px;"/>
Cabbage is a framework for developing audio plugins that use Csound as their processing engine. All the power of Csound can be wrapped into a VST plugin that can then be loaded in a variety of different host software. Cabbage provides users with a fully integrated IDE that allows drag and drop editing of GUI interfaces, real-time compilation, Csound debugger. Cabbage also ships with over 100 ready made audio effects and synthesisers. More information about Cabbage can be found [here](http://cabbageaudio.com) 

####Csound for Live
![Csound4Live](/images/csound4live.jpg)
Csound For Live is a suite of audio plugins that combines the real time performance capabilities of Ableton Live, the stable and customizable interface design of Max/MSP (through Max For Live), and the synthesis power of Csound. More information can be found [here](http://csoundforlive.com/). Note: users must have Max4Live. 

At the core of Csound4Live is the Max/MSP csound~ object which is distributed free with the OSX and Windows installers of Csound. Although not as extensive as the above mentioned csound4Live packages, it does provide a set of simple examples to get you started. You can read more about it [here](http://floss.booktype.pro/csound/b-csound-in-maxmsp/)  

####csLADSPA
<img src="/images/csLADSPA.jpg" alt="Cabbage" style="width: 400px;"/>
csLADSPA is a simple interface that lets users run Csound as a LADSPA plugin. csLADSPA come pre-built with Csound and can be used with any software that can load LADSPA plugins. Note that it does not offer any real-time control of processes.  

####Jack
[Jack](http://www.jackaudio.org/) is an API that enables complex routing of audio signals across applications. It can be used to route out of Csound and into any number of digital audio workstations. Jack runs on Linux, OSX and Windows. More information on using Csound and Jack can be found [here](http://csound.github.io/docs/manual/JackoOpcodes.html) 

####Csound and Logic
[Routing audio and MIDI between Csound and a DAW](http://www.csoundjournal.com/issue16/audiorouting.html) In this article Andreas Russo outlines the steps need in order to route Csound signals around your OSX desktop and into Logic using OSX's IAC driver and Soundflower.

<br>
<br>
<h2 id="realtime_works">Realtime Works</h2>

Realtime works with Csound can be created in many different ways. The most straightforward is to use a MIDI controller to manipulate sounds during a performance. Basic information about how to work with MIDI controlers and Csound can be found in the Csound Reference Manual [here](http://csound.github.io/docs/manual/MidiTop.html). Composer and Csounder Art Hunkin's has also written a review of some of his favourite MIDI controllers to use with Csound in this [article](http://www.csounds.com/journal/issue10/MIDI_Controller.html)

Csound can also be controlled in real-time using a language wrapper that lets you host the Csound library in another language. Francois Pinot presents one such approach in his article [Real-time Coding Using the Python API](http://www.csounds.com/journal/issue14/realtimeCsoundPython.html)

Another approach is to use the Pure Data csoundapi~ tilde object that ships with Csound. THis lets you harness the power of the Csound library within Pd. You can read more about this approach [here](http://floss.booktype.pro/csound/a-csound-in-pd/) 

For a more customised approach, users can build hardware with tools such as an [Arduino](https://www.arduino.cc/) electronic prototyping system. THis hardware can then be used to send messages to Csound in realtime. More information on using an Arduino with Csound can be found [here](http://floss.booktype.pro/csound/b-csound-and-arduino/). 

Don't forget that Csound can send and receive OSC(Open Sound Control) messages. This opens a plethora of further options for realtime control. Read more about OSC and Csound [here](http://floss.booktype.pro/csound/a-open-sound-control/)

<br>
<br>
<h2 id="desktop_apps">Desktop Applications</h2>

Desktop applications can be created using the Csound host API. The Csound API is a programming application interface that provides access to most of Csound's library functions. In order to develop standalone desktop applications with Csound you will need to have some experience with programming, or be willing to learn. Here are some useful links and resources. 

[Csound API reference manual](https://csound.github.io/docs/api/index.html) The first port of call for most developers. Although presented in C, the same functions and methods are accessible in the 
various different language wrappers.  

[Introduction to using the Csound host API](http://www.csounds.com/articles/RoryWalsh_CsoundAPI.pdf). In this article Rory Walsh outlines basic usage of the C-language version of the Csound API. Although written with C in mind, the approaches outlined in this article still apply to other languages.

[Developing standalone applications using the Csound API and wxWidgets](http://csoundjournal.com/2006summer/wxCsound.html) In this article Rory Walsh shows how the wxWidgets GUI framework can be used to create standalone graphical front-ends for Csounds instrument using C++. 

[Csound API Examples](https://github.com/csound/csoundAPI_examples)

[The Csound API](http://booki.flossmanuals.net/csound/the-csound-api/) This chapters from the Csound FLOSS manual provides a great overview of the API. 

<br>
<br>
<h2 id="android_apps">Android Applications</h2>

You do not have to be an Android developers, or even a master Csound coder to get started with Csound on Android. The Csound on Android package provides a basic example .csd player that can easily be hacked and mistreated any way you wish! Provided below are the best resources available to get you started.

[Kaoss Droid](http://csoundjournal.com/issue19/kaoss_droid.html): In this article Brain Redfern guides you through the setting up and development of a Csound based Android app. Project files are provided.

[Android Devices as MIDI Controllers](http://csoundjournal.com/issue20/android_midi.html): In this article Art Hunkins writes about using an Android handset as a MIDI controller for realtime composition.

[The Android .csd player](http://www.csoundjournal.com/issue17/android_csd_player.html) Brain Redfern discusses the stock Android CSD Player and provides examples of how to control instruments in realtime using on screens widgets. Project files are provided.
Link 4: This could be you!

<br>
<br>
<h2 id="ios_apps">iOS Applications</h2>

Csound has been used successfully on a host different iOS software. You can check out examples of these apps in the [Projects](projects.html) page. See the links below for details on how best to start creating apps. 

####AudioKit
The quickest entry to Csound on iOS is through AudioKit, an open-source audio synthesis, processing, and analysis platform developed with Csound at its core. Users don't need to know Csound in order to start developing with AudioKit. It ships with a host of tools to aid in the creation of iOS based audio software. Check out their website for more details and great demos. [AudioKit](http://audiokit.io/)
[![IMAGE ALT TEXT](http://img.youtube.com/vi/oJkGgQKUCmM/0.jpg)](https://youtu.be/oJkGgQKUCmM "Video Title")

<br>
<br>
<h2 id="raspberry_pi">Embedded Applications with Raspberry Pi/BeagleBone and Csound</h2>

Pocket sizes computers are becoming more and more popular. Because most of them run some flavour of Linux, Csound can easily be installed. Below are some resources to get you started. 

[An Introductory Guide to Csound on the BeagleBone and the Raspberry Pi, as well other Linux-powered tinyware](http://www.csounds.com/journal/issue18/beagle_pi.html) 

In this article Paul Batchelor and Trev Wignall show how to get Csound up and running on a host of different micro devices.

[Building an FM oscillator in the Eurorack format using Csound, a Raspberry Pi, and an Arduino Uno](http://www.csounds.com/journal/issue18/eurorack.html) 

Andrew Ikenberry and Jason Lim, whom you can read more about in the [Projects](projects.html) page, present a comprehensive overview of how a Raspberry PI, an Arduino and Csound can all be pulled together to create a standard Eurorack module.

[Csound GUI for a Headless Raspberry Pi](http://csoundjournal.com/issue21/csound_gui.html)

This article by Ricahrd van Bemmelen, otherwise known as Zappfinger, describes how a web server can be set up to take control of an instance of Csound running on a Raspberry PI.  


[The COSMO Project (Csound On Stage Music Operator](http://cosmoproject.github.io/) 

<img src="/images/COSMO-box-small.png" alt="a COSMO Box" style="width: 400px;"/>

The COSMO Project web page gives you instructions on how you can run Csound on a Raspberry Pi to create a standalone musical device specifically designed for live performance. You can read more about this project by Alex Hofmann, Bernt Isak Wærstad and Kristoffer Koch on the [Projects](projects.html) page



<br>
<br>
<h2 id="games">Music for Games</h2>

Csound can obviously be used to create game music, but it's also possible to link games directly to Csound. One approach is to use OSC to send information back and forth between the game and Csound. Examples of how to do this are outlined in Marte E. Roel Lesur's article [Interfacing Csound and Unity](http://csoundjournal.com/issue19/InterfacingCsoundUnity.html)

If you wish to embed Csound directly into the Unity game engine you can use [CsoundUnity](http://rorywalsh.github.io/CsoundUnity/). CsoundUnity provides a Unity C# interface to the Csound library meaning Unity can call Csound function directly without having to use a communication protocol such as OSC. 

<br>
<br>
<h2 id="webapps">Web Applications</h2>

Csound can be run through a browser in two different ways. The first is through the Csound PNaCl interface. Portable Native Client is a technology developed by Google that allows C/C++ modules to run natively through Google's Chrome browser. This is a very efficient way of running Csound in a browser, but must be done using Google Chrome. 

The other method for running Csound in a browser is [CsoundEmscripten](http://eddyc.github.io/CsoundEmscripten/). Emscripten is a tool that allows C/C++ programs to be more or less converted into Javascript. CsoundEmscripten takes advantage of this and provides a Csound Javascript library that can be embedded directly into any browser. CsoundEmscripten does not perform as well as the PNaCl interface, but has the advantage of being able to run in any browser, on any platform. 

You can find out more about both of these interfaces in a paper presented at the Linux Audio Conference in 2014, titled [Csound on the Web](http://lac.linuxaudio.org/2014/papers/23.pdf)

<br>
<br>
