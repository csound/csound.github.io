---
layout: post
title:  "Csound6 for Android now supports HTML5 user interfaces"
date:   2014-07-02 13:00:00
categories: site news 
---

*Michael Gogins has reported an update to the Csound6 Android application to the Csound Mailing list.  His original email is below.*

---

I have uploaded to SourceForge a new package for Csound6 for Android at:

[http://sourceforge.net/projects/csound/files/csound6/Csound6.03/Csound6.apk/download](http://sourceforge.net/projects/csound/files/csound6/Csound6.03/Csound6.apk/download)

And a new archive of examples at:

[http://sourceforge.net/projects/csound/files/csound6/Csound6.03/Csound6AndroidExamples.zip/download](http://sourceforge.net/projects/csound/files/csound6/Csound6.03/Csound6AndroidExamples.zip/download ) 

These files have replaced the existing files for 6.03. The only major change is here is new support for user-defined user interfaces which can be implemented in HTML5 code stored in a new <CsHtml5> element in the CSD file.

The Gogins/Drone-HTML5.csd example demonstrates how to create a user-defined interface with custom widgets, a flexible table-based layout with a style sheet, and JavaScript event handling. A screen shot of this example running on my Galaxy Tab S may be found below. This example was coded on my tablet right in the Csound6 app.

<img src="{{HOME_PATH}}/images/2014_07_02_csound6_android_html5.png" width=800 height="1280"/>

There is as yet minimal documentation and no example of using JavaScript for anything but pushing control values from the user interface to Csound control channels. It should however be possible to send score events to Csound from the HTML5 code, and even to write score generators in JavaScript. It should also be possible to read control channel values from Csound in JavaScript code.

Please note, if the CSD file does not contain a <CsHtml5> element, the behavior of the Csound6 is the same as it used to be, with pre-defined sliders, buttons, and trackpad.

I had hoped to be able to use WebGL on Android, but apparently the Android WebKit support for WebGL is not yet functional. This is sad because the "Internet" browser on both of my Android devices is quite capable of showing rather sophisticated WebGL demos. But I am hopeful that full support for WebGL in the WebKit will be coming reasonably soon to the Android operating system.

WebGL puts the entire functionality of a full-fledged, state of the art, GPU-accelerated, OpenGL-based scene graph with textures and shaders and what-all right into the browser and thus, when support is mature, right into Csound6 for Android.

It should still be possible to draw on the HTML5 canvas and much can be done in this way as well.

Regards,

Mike
