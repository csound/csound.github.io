---
layout: post
title: "FMOD Studio and Csound"
date: 2016-07-15 12:30:00
categories: site news 
---

[FMOD Studio](http://www.fmod.org/products/), the popular audio middleware for sound designers and composers of interactive music can 
now host Csound instruments through a new feature available in the latest version of Cabbage. Users can design procedural instruments 
in Csound, and export them from Cabbage as "FMOD Plugin Sound" plugins. Once exported they can picked up by FMOD Studio and used to
generate procedural audio for games. Having access to a low-level synthesis engine within FMOD makes it all the more inviting for 
sound designers looking for a little more from their audio middleware. 

This is only supported with the latest beta release of Cabbage. OSX and Windows users can download the latest packages from [here](http://www.fmod.org/products/). 
A short video showing the simplest of examples can be viewed [here](https://www.youtube.com/watch?v=iw35eeq1yMw&feature=youtu.be). 

**Usage Notes:**
- available for Windows 64 and OSX. Just grab the latest release of Cabbage from:
http://forum.cabbageaudio.com/t/latest-beta-packages-available-here-new-release/114

- only float parameters can be automated in fmod. Therefore all GUI buttons and checkboxes in Cabbage are converted to 
sliders so they can be adequately controlled and automated in fmod.

- when you export your fmod Cabbage plugin, make sure to point fmod to the plugin folder, otherwise it won't be seen.
- 
- When using your plugins in Unity, make sure to add the exported plugin .dll/.dylib to your Unity project folder. They should 
be copied to *Assets\Plugins\x86_64* It is important both the .csd files and the libraries are copied to the same location. 

- When using your plugins in UE4, make sure to add the exported plugin .dll/.dylib to your UE4 project folder. They should be 
copied to *Plugins\FMODStudio\Binaries\Win64*. Once again, it is vital both the .csd files and the libraries are copied to this location.

- To import the FMOD Unity and UE4 Integration packages follow [these](http://www.fmod.org/documentation/#content/generated/common/introduction_web.html) instruction.

- With FMOD in place you will need to add the plugin names (without the file extension) to the FMOD settings. Failure to do so will cause FMOD to complain about missing plugins. 

Questions can be directed to the [Cabbage forum](http://forum.cabbageaudio.com/) or through the project's github page shown below. Note that this beta software and results may vary. Source code is available [here](https://github.com/rorywalsh/csoundfmod), along with some very simple sample instruments. All instruments were written with simplicity in mind. The electricity example comes courtesy of Iain McCurdy.  
