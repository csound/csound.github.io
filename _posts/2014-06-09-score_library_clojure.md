---
layout: post
title:  "New Project: Score Library in Clojure"
date:   2014-06-09 15:00:00
categories: site news 
---

Hi All,

I'd like to announce a score generation library written in Clojure
called "score":

[https://github.com/kunstmusik/score](https://github.com/kunstmusik/score)

This library is currently a work in progress. I am planning to put all
general composition functions that I use or plan to explore within
this library.

Some notes:

The library currently offers two styles of score generation.  One is
styled after SuperCollider's Patterns. Patterns in SC generate values
without context, and map directly to standard Clojure sequences.
gen-notes and gen-score in src/score/core.clj are functions for use
with the score generation style. With this it is simple enough to
emulate any feature in SC Patterns using standard Clojure
sequence-related functions.

The other score generation style is CMask-based.  In CMask, rather
than have sequences, generator functions are used that function within
a context of time.  (The start time of the current event being
generated is passed-in as an argument.) That difference of having time
as an argument allows to express things like time-varying masks,
frequencies, etc.  So far, I have completed porting all of the
features of CMask and have done light testing.

As for the future of this library, I will be using this in my pieces
moving forward, and expect to maintain this library, adding features
as required. I would warn that the library is still a little volatile,
so functions may move namespaces and users may need to update code
between these early versions. I hope to clean up and stabilize the API
soon so backwards compatibility can be maintained.  (The library is
version 0.1.0 at the moment; it will be bumped to 1.0.0 when the API
is stable.)

Also to note, the library is purposely designed to be generic.  I am
targeting Csound score generation at the moment, but the core of the
library works to generate simply lists of lists (see core.clj, and
note the difference between gen-notes and gen-score, or gen-notes2 and
gen-score2).  This allows the library to be used beyond Csound. For
example, you could always create a formatting function to send the
notes as MIDI, OSC, etc.  (I have some plans to do some interesting
event exploration using score with a Clojure music system I'm working
on.)

For examples, I have some demo clj files I used while developing
within a REPL ([https://github.com/kunstmusik/score/tree/master/src/score/demo](https://github.com/kunstmusik/score/tree/master/src/score/demo)).
They show a bit of what using the library would look like. There is also 
an example that demonstrates live-coding with the score library and
the Csound API.

Comments and contributions would be very welcome.

Thanks!

Steven Yi
