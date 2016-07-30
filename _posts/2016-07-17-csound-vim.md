---
layout: post
title:  "csound-vim and csound-repl"
date:   2016-07-17 22:00:00
categories: site news 
---

Luis Jure has released an updated version of his csound-vim plugin, and Steven
Yi has released a new csound-repl plugin for live coding with Csound.

Luis' email to the Csound mailing list describes the changes for csound-vim:

After a long time of relative inactivity, I'm happy to announce a new major
release of csound-vim, a set of tools for editing Csound files with Vim.

csound-vim provides syntax recognition and highlighting, folding, auto
completion, on-line reference, and templates, plus a set of macros to compile
your orchestra and listen to the results without leaving the editor. These
tools turn Vim, with all its editing power, into a simple but efficient Csound
development environment.

Major changes in this release:

 * It's on github! now it's not only easy to install and update, but also to
   contribute code. just visit
   [https://github.com/luisjure/csound](https://github.com/luisjure/csound);

 * It's pathogen-compatible, making it very easy to install and update with
   pathogen or any other plugin manager, like Vundle, NeoBundle, or VimPlug;

 * now it has a formal license: it's released under the MIT license.

Improvements, updates and new features include:

 * General clean up and update of the syntax file. lots remain to be done
   there, though;

 * The list of opcodes was updated to the latest release;

 * NEW FEATURE: auto-completion of opcode names with Ctl-n / Ctl-p;

 * Several minor changes and fixes.

 I hope that csounders who also use vim will find it useful.  comments,
 suggestions, ideas (and patches!) are most welcome.

Steven's plugin is available at
[https://github.com/kunstmusik/csound-repl](https://github.com/kunstmusik/csound-repl)
and includes Vim documentation that describes the usage of the plugin.



