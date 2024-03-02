# Internals / Questions

## Relative paths
Settings are done relative, without a BASE_PATH, as this works for me (JH) locally and in a testing github project page. In case of issues, it should be changed.

For instance, in _layouts/default.html the css link is set as "css/main.css", wheras in the previous Csound site is was set as "/css/style.css".
