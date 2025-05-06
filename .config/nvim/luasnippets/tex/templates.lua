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
  s({ trig = "vbd+", dscr = "Volleyball Drill description" },
    fmta(
    [[
    \subsubsection*{<>}
    \textbf{Objective:} <> \\
    \textbf{Explanation:} <> \\
    \textbf{Minimum Requirements: } 
    \begin{center}
      \begin{tabular}[lr]
        Players & <> \\
        Balls   & <> \\
        Space   & <> \\
        Other   & <>
      \end{tabular}
    \end{center}

    <> 
    ]],
      {
        i(1,'Title'),
        i(2),
        i(3),
        i(4),
        i(5),
        i(6),
        i(7),
        -- i(8,"placeholder")
        -- c(8, {
        --   t"hello",
        --   sn(nil, {
        --     i(1),
        --     t"hi!"
        --   })
        -- })
        c(8, {
          i(1),
          sn(nil, {
            fmta(
              [[
              \begin{figure}[h]
                \scalebox{0.6}{\begin{tikzpicture}
                  \begin{scope}[yshift=10cm]
                  \pic (ct) {halfcourt};
                  % Participants
                  <>
                  % Ghosts
                  <>
                  % Paths/Directions
                  <>
                  % Diagram Label
                  \ node [] (title) at (0,-\sidelength\m) {<>};
                  \end{scope}
                  \end{tikzfigure}
                }
              \end{figure}
              ]],
              {
                i(1),
                i(2),
                i(3), 
                i(4)
              }
            ) 
          })
        })
      }
    )
  ),   
}

