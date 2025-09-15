---
layout: post
title:  "CsoundQt7 alpha including Csound 7"
date:   2025-01-24 00:00:00
categories: site news
---

Tarmo Johannes published a pre-release of CsoundQt 7.0.0 on Github, including Csound 7 in the packages for Mac, Windows and Linux AppImage:
[https://github.com/CsoundQt/CsoundQt/releases/tag/v7.0.0-alpha](https://github.com/CsoundQt/CsoundQt/releases/tag/v7.0.0-alpha)

There has been a myriad of changes to the code to get it building with Qt 6 and Csound 7, so  there might be hidden issues. Yet, it might be the easiest way to try out Csound 7 at the moment.

From the users' point of view there has not been so many changes yet (some things like PythonQt and Live Event Sheets are dropped), internally much more. See a summary here: [https://github.com/CsoundQt/CsoundQt/blob/csoundqt7/Changes%20to%20CsoundQt7.md](https://github.com/CsoundQt/CsoundQt/blob/csoundqt7/Changes%20to%20CsoundQt7.md)

The Windows build was the most problematic and does not have Virtual MIDI keyboard nor recording support at the moment. 
None of the packages contains html support yet.

Who builds CsoundQt from sources, the main development branch is csoundqt7 [https://github.com/CsoundQt/CsoundQt/tree/csoundqt7](https://github.com/CsoundQt/CsoundQt/tree/csoundqt7)

Please try and report back!
