-- File templates for latex

local tex_utils = require('tex.utils')

return {
  s({ trig = "template", dscr = "Basic template" },
    fmta(
    [[
    \documentclass[12pt,a4paper]{article}

    \usepackage[utf8]{inputenc}
    \usepackage[T1]{fontenc}
    \usepackage{textcomp}
    \usepackage{amsmath, amssymb}

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
    { condition = conds.line_begin }
  ),  

}
