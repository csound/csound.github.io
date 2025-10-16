---
layout: post
title:  "csound-vscode-extension 0.7.0"
date:   2025-10-16 00:00:00
categories: site news
---

Steven Yi released csound-vscode-extension 0.7.0 that has an initial
implementation of rendering Csound in the browser when used as a web
extension.

This means that if you have a github repo with a csound project, you
can open that in github.dev, install the csound extension, then render
your project in-browser. You'll get a web panel on the left tab that
shows up when you use the "Csound: Play Active Document" command.
You'll need to start the audio context to audio going using that
panel, and you can use the play/pause and stop buttons to control
Csound.  You should be able to live code using this extension in the
web browser.

The main goal is to leverage github for project management, while also
having the convenience of zero-install for working with Csound.

