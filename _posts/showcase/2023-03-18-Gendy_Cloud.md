---
title: Gendy Cloud
layout: project
image: /images/showcase/GendyCloud-WORC-ensemble.png
website: https://serkansevilgen.com/projects/gendy-cloud
categories: showcase
tags: [networked music, web interface, multichannel]
---

The "Gendy Cloud" is a networked, multichannel music piece created by Serkan Sevilgen that would be realized in real time by a telematic ensemble. Performers are composers, researchers, interface designers, and musicians. The ensemble members could control their instruments remotely by either using their interfaces, custom-built devices, live coding, or a web interface. Any performer can control one or more instances of the Gendy-based instrument. The control parameters are limited to reduce the learning curve and increase the adaptability to the existing interfaces. However, extensive use of stochastic processes in the instrument allows performers to create varied timbre, patterns, and textures in a multichannel diffusion system.  

The Gendy Cloud has three components:  

- A computer in the concert venue that hosts the audio software which is built on the Csound programming language.
- An interface that can produce OSC messages. Performers that can join from any physical location. They would use either the existing web interface or their interfaces.
- Remote OSC, a library that works as a server/client architecture and manages the data traffic between the performers and the host computer. Thanks to Remote OSC, there is no need to configure a router, IP, etc. to communicate over the Internet.  

The main proposition is instead of streaming audio between the peers and then to the audience, to build instruments that can be performed remotely only by sending OSC messages over the Internet. Since the amount of data is very small in terms of bytes even without a broadband Internet connection the performance will be possible without compromising audio quality. The goal of the performance is to create a dynamic "cloud" of stochastic noises.  

You can see the video of a concert at **XNPM22: Xenakis Networked Performance Marathon**  
<https://www.youtube.com/watch?v=bKlwMrMdlnI>  


