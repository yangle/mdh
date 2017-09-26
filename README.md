# mdh

*mdh* is a convenience wrapper around [pandoc][] for local markdown-to-html
conversion and rendering.

It includes a simple [Yeti][]-inspired [style sheet](static/pandoc.css),
and performs syntax highlighting and LaTeX rendering through
local copies (as git submodules) of [Highlight.js][] and [MathJax][],
with no reliance on internet connectivity.

*mdhmk* is a simple (linux only) script that monitors a markdown file,
defaulting to the most recently modified markdown file in the current folder.
Upon any changes, it calls *mdh* to recompile the markdown file, and opens or
refreshes it in browser.

[pandoc]: http://pandoc.org/index.html
[yeti]: https://bootswatch.com/yeti/
[Highlight.js]: https://highlightjs.org/
[MathJax]: https://www.mathjax.org/
