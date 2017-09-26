# mdh

*mdh* is a convenience wrapper around [pandoc][] for local markdown-to-html
conversion and rendering.

It includes a simple [Yeti][]-inspired [style sheet](static/pandoc.css),
and performs syntax highlighting and LaTeX rendering through
local copies (as git submodules) of [Highlight.js][] and [MathJax][],
with no reliance on internet connectivity.

*mdhmk* is a simple (linux only) [inotify][]-based script that monitors a
markdown file and continuously recompiles it.
If a file is not specified, it default to the most recently modified markdown
file in the current folder.

Upon any changes to the monitored file, *mdhmk* calls *mdh* to recompile it,
and opens or refreshes the result in browser automatically.

[pandoc]: http://pandoc.org/index.html
[yeti]: https://bootswatch.com/yeti/
[Highlight.js]: https://highlightjs.org/
[MathJax]: https://www.mathjax.org/
[inotify]: https://linux.die.net/man/7/inotify
