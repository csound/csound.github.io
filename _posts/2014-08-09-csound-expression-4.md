---
layout: post
title:  "csound-expression-4 for Haskell"
date:   2014-08-09 13:30:00
categories: site news android 
---
Anton Kholomiov announced the new version of [csound-expression](http://hackage.haskell.org/package/csound-expression-4.0.0):

"The main thing that is done is a detailed guide to the library.
The Csound is huge so the haskell library is huge also.
It strives to be simple and minimal at its core but there are
many things that can lead astray. 

To help the novice along the way there is a Guide 
 
[https://github.com/anton-k/csound-expression/blob/master/tutorial/Index.md]
(https://github.com/anton-k/csound-expression/blob/master/tutorial/Index.md)

While writing the guide I've found many things to improve.
The most prominent are:

- better support for writing and reading sound-files

- support for monophonic synths.
  We can get the midi freqeuncy and the amplitude as 
   a continuous signal

- liveness analysis. Memory allocation optimization. 
  The copiler reuses the variables. The memory allocation is minimal.

Cheers,

Anton"


