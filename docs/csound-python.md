---
layout: page
title: Csound Python
permalink: /csound-python.html
---

François Pinot's ctcsound (= Ctypes Csound) is a very effective and powerful binding for the Csound host API in Python.  
Each release of Csound has it's own version of ctcsound named *ctcsound.py*, which is installed in the Python path. So, if Python is already installed on your system and if Csound is correctly installed, you only have to install [numpy](https://numpy.org/install/), which is needed by ctcsound, to get it working.

<div>
  <a href="https://csound.com/docs/ctcsound" class="btn btn-lg btn-secondary">ctcsound Docs for Csound 6.x</a>
</div>

<br>

In Csound 7.0, the host API has been entirely refactored, breaking backward compatibility. To emphasize this, it has been decided to rewrite ctcsound for Csound 7.0 following the naming convention of the [PEP 8 – Style Guide for Python Code](https://peps.python.org/pep-0008/#naming-conventions).  
So now, functions name are lowercase, with words separated by underscores (e.g. `SetOption` in ctcsound 6.x becomes `set_option` in ctcsound 7.0).  
Examples for this new version of ctcsound can be seen [here](https://github.com/csound/csoundAPI_examples/tree/master/7.x/python).  
Victor Lazzarini wrote a [document](https://github.com/csound/csound/blob/develop/doc/API_Migration_Guide_Csound_6_to_7.md) about the host API migration from 6.x to 7.0.

<br>

Eduardo Moguillansky has used ctcsound for an own wrapper called [`libcsound`](https://github.com/csound-plugins/libcsound) which attempts to work for both, Csound 6.18 and Csound 7, and is installable via [pip](https://pypi.org/project/libcsound/).

<div>
  <a href="https://libcsound.readthedocs.io/en/latest/index.html" class="btn btn-lg btn-secondary">libcsound Docs</a>
</div>


On top of ctcsound, Eduardo Moguillansky has written [csoundengine](https://pypi.org/project/csoundengine/).

<div>
  <a href="https://csoundengine.readthedocs.io/en/latest/index.html" class="btn btn-lg btn-secondary">csoundengine Docs</a>
</div>
