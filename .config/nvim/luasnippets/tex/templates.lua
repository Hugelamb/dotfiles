-- contains snippets for instantly creating tex preambles for various topics
local tex_utils = require('luasnippets.tex.utils')
local utils = require('luasnippets.utils')
local conds = require("luasnip.extras.expand_conditions")
return {

  s({ trig = "template", dscr = "Basic template" },
    fmta(
      [[
      \documentclass[12pt,a4paper]{article}

      % packages
      \usepackage[utf8]{inputenc}
      \usepackage[T1]{fontenc}
      \usepackage{textcomp}
      \usepackage[english]{babel}
      \usepackage{amsmath,amssymb}
      \usepackage{xcolor}

      % figure support
      \usepackage{import}
      \usepackage{xifthen}
      \pdfminorversion=7
      \usepackage{pdfpages}
      \usepackage{transparent}
      \newcommand{\incfig}[1]{%
        \def\svgwidth{\columnwidth}
        \import{./figures/}{#1.pdf_tex}
      }

      \pdfsuppresswarningpagegroup=1

      \begin{document}
      <>
      \end{document}
      ]],
      {
        i(0)
      }
    ),
    { condition = tex_utils.in_text + conds.line_begin }
  ),
}

