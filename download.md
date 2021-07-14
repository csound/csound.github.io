---
layout: sidebar_links
title: Download
---

This page provides download links to the current version of Csound compiled for
different platforms. You can also find them on GitHub:
[https://github.com/csound/csound/releases/latest/](https://github.com/csound/csound/releases/latest/)

<!--
If you want to update the links to Csound distributions on this page,
please, do it in the 'download.yaml' file located in '_data' directory':
https://github.com/csound/csound.github.io/blob/master/_data/
-->


<!-- Desktop -->

<div class="nine columns">
    <h2 class="align-center">Desktop</h2>
</div>

<div style="line-height: 1.1em">
    <div class="three columns align-center">
    <i class="fa fa-4x fa-windows"></i><br/>
	<a href="{{ site.data.download.windows_64_full.link }}">64bit Full Installer v{{ site.data.download.windows_64_full.ver }}</a><br/>
	<a href="{{ site.data.download.windows_64.link }}">64bit Binaries
    v{{ site.data.download.windows_64.ver }}</a><br/>
    <a href="{{ site.data.download.windows_64beta.link }}">Windows 64
    beta builds v{{ site.data.download.windows_64beta.ver }}</a>
    <a href="{{ site.data.download.windows_XP64.link }}">Windows XP 64bit binaries v{{ site.data.download.windows_X64.ver }}</a><br/>
	<a href="{{ site.data.download.windows_XP32.link }}">Windows XP
    32bit binaries v{{ site.data.download.windows_XP32.ver }}</a>
    </div>
    <div class="three columns align-center">
        <i class="fa fa-4x fa-apple"></i><br/>
	<a href="{{ site.data.download.osx.link }}">OS X (dmg archive) v{{site.data.download.osx.ver }}</a><br/>
    </div>
    <div class="three columns align-center">
        <i class="fa fa-4x fa-linux"></i><br/>
	<a href="{{ site.data.download.linux.debian_link }}">Debian</a>,
	<a href="{{ site.data.download.linux.ubuntu_link }}">Ubuntu</a>,
	<a href="{{ site.data.download.linux.fedora_link }}">Fedora</a>,
	<a href="{{ site.data.download.linux.arch_link }}">Arch</a>,
	or <a href="#building-from-source">build</a> Csound from source
    </div>
</div>


<!-- Mobile and Web -->
<div class="nine columns"><br/></div>

<div class="nine columns">
    <h2 class="align-center">Mobile and web</h2>
</div>

<div style="line-height: 1.1em">
    <div class="three columns align-center">
        <i class="fa fa-4x fa-android"></i><br/>
	<a href="{{ site.data.download.android_app.link }}">Android App</a>
	<br/>
	<a href="{{ site.data.download.android_sdk.link }}">Android SDK v{{ site.data.download.android_sdk.ver }}</a>
    </div>
    <div class="three columns align-center">
        <i class="fa fa-4x fa-apple"></i><br/>
	<a href="{{ site.data.download.ios_sdk.link }}">iOS SDK v{{ site.data.download.ios_sdk.ver }}</a>
    </div>
    <div class="three columns align-center">
        <i class="fa fa-4x fa-html5"></i><br/>

	<a href="{{ site.data.download.web.link }}">Web v{{ site.data.download.web.ver }}</a>
    </div>
</div>


<!-- Other -->
<div class="nine columns"><br/></div>

<div class="nine columns">
    <h2 class="align-center">Other</h2>
</div>

<div style="line-height: 1.1em">
    <div class="three columns align-center">
        <i class="fa fa-4x fa-bicycle"></i><br/>
	<a href="{{ site.data.download.max.win_link }}">csound~ (Win)</a>
	<a href="{{ site.data.download.max.osx_link }}">csound~ (Mac)</a>
    </div>
    <div class="three columns align-center">
        <i class="fa fa-4x fa-file-code-o"></i><br/>
	<a href="{{ site.data.download.source.zip_link }}">Sources v{{ site.data.download.source.ver }} (.zip)</a>
	<a href="{{ site.data.download.source.tgz_link }}">Sources v{{ site.data.download.source.ver }} (.tar.gz)</a>
    </div>
    <div class="three columns align-center">
        <i class="fa fa-4x fa-archive"></i><br/>
	<a href="olderversions.html">Older versions</a>
    </div>
</div>


<div class="nine columns"><br/></div>
<div class="eleven columns">
    <h2 name="building-from-source">Building from source</h2>
    <p>
	Building Csound from source or from the git develop branch is not very difficult on Linux,
	and can also be done on Mac and Windows. How-to descriptions can be found in the BUILD.md
	file included with the Csound sources, also available online:
	<a href="https://github.com/csound/csound/blob/develop/BUILD.md">https://github.com/csound/csound/blob/develop/BUILD.md</a>.	
    </p>
</div>

