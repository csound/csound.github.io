---
layout: sidebar_links
title: Download
---

This page provides links to the most current pre-compiled versions
of Csound for different platforms. You can also find them GitHub:
[https://github.com/csound/csound/releases/latest/](https://github.com/csound/csound/releases/latest/)

<!--
If you want to update the links to Csound distributions on this page,
please, do it in the 'download.yaml' file located in '_data' directory'.
-->


<!-- Deskto -->

<div class="container">
     <div class="nine columns">
         <h2 class="align-center">Desktop</h2>
     </div>
</div>

<div class="container" style="line-height: 1.1em">
    <div class="three columns align-center">
        <i class="fa fa-4x fa-windows"></i><br/>
	<a href="{{ site.data.download.windows.link }}">Windows v.{{ site.data.download.windows.ver }}</a>
    </div>
    <div class="three columns align-center">
        <i class="fa fa-4x fa-apple"></i><br/>
	<a href="{{ site.data.download.osx.link }}">OS X v.{{ site.data.download.osx.ver }}</a>
    </div>
    <div class="three columns align-center">
        <i class="fa fa-4x fa-linux"></i><br/>
	<a href="{{ site.data.download.linux.debian_link }}">Debian</a>,
	<a href="{{ site.data.download.linux.ubuntu_link }}">Ubuntu</a>,
	<a href="{{ site.data.download.linux.fedora_link }}">Fedora</a>
	or <a href="#build-from-source">build</a> Csound from source
    </div>
</div>


<!-- Mobile and Web -->

<br/>
<div class="container">
     <div class="nine columns">
         <h2 class="align-center">Mobile and web</h2>
     </div>
</div>

<div class="container" style="line-height: 1.1em">
    <div class="three columns align-center">
        <i class="fa fa-4x fa-android"></i><br/>
	<a href="{{ site.data.download.android_app.link }}">Android App</a>
	<a href="{{ site.data.download.android_sdk.link }}">Android SDK {{ site.data.download.android_sdk.ver }}</a>
    </div>
    <div class="three columns align-center">
        <i class="fa fa-4x fa-apple"></i><br/>
	<a href="{{ site.data.download.ios_sdk.link }}">iOS SDK {{ site.data.download.ios_sdk.ver }}</a>
    </div>
    <div class="three columns align-center">
        <i class="fa fa-4x fa-html5"></i><br/>
	<a href="{{ site.data.download.linux.web_emscripten.link }}">Emscripten {{ site.data.download.linux.web_emscripten.ver }}</a>
	<a href="{{ site.data.download.linux.web_pnacl.link }}">PNaCl {{ site.data.download.linux.web_pnacl.ver }}</a>
    </div>
</div>


<!-- Other -->

<br/>
<div class="container">
     <div class="nine columns">
         <h2 class="align-center">Other</h2>
     </div>
</div>

<div class="container" style="line-height: 1.1em">
    <div class="three columns align-center">
        <i class="fa fa-4x fa-bicycle"></i><br/>
	<a href="{{ site.data.download.max.win_link }}">csound~ (Win)</a>
	<a href="{{ site.data.download.max.osx_link }}">csound~ (Mac)</a>
    </div>
    <div class="three columns align-center">
        <i class="fa fa-4x fa-file-code-o"></i><br/>
	<a href="{{ site.data.download.source.zip_link }}">Sources {{ site.data.download.source.ver }} (.zip)</a>
	<a href="{{ site.data.download.source.tgz_link }}">Sources {{ site.data.download.source.ver }} (.tar.gz)</a>
    </div>
    <div class="three columns align-center">
        <i class="fa fa-4x fa-archive"></i><br/>
	<a href="{{ site.data.download.archives.link }}">Older versions</a>
    </div>
</div>


<br/>

## Building from source

Building Csound from source or from the git develop branch is not very difficult on Linux,
and can also be done on Mac and Windows. How-to descriptions can be found in the BUILD.md
file included with the Csound sources, also available online
[here](https://github.com/csound/csound/blob/develop/BUILD.md).

