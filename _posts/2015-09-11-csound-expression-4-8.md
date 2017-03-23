---
layout: post
title:  "Csound-expression 4.8 is out"
date:   2015-09-11 9:00:00
categories: site news 
---

The 4.8.3 is out! New features:

github: [https://github.com/spell-music/csound-expression](https://github.com/spell-music/csound-expression)

hackage: [https://hackage.haskell.org/package/csound-expression](https://hackage.haskell.org/package/csound-expression)

This is a very important release to me.
It tries to solve the problem present in the most open source music-production libraries.
It's often the pack of beautiful sounds/timbres is missing. User is presented with
many audio primitives but no timbres are present to show the real power of the framework.
This release solves this problem. See the friend package csound-catalog on Hackage.
It defines 200+ beautiful instruments ready to be used. 

The csound-expression defines a new type called `Patch` for description of an instrument 
with  a chain of effects. It's good place to start the journey to the world of music production.

There are new functions for synchronized reaction on events. The triggering of events 
can be synchronized with given BPM.

There examples are fixed and should work.

The library is updated for GHC-7.10!