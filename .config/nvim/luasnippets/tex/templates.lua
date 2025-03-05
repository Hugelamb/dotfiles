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
  -- The following assumes you have defined certain volleyball related lengths
  s({ trig = "vballcourt", dscr = "create tikzpicture containing empty halfcourt"},
    fmta(
      [[
      \begin{figure}
        \pagecolor{<>}
        \caption{<>}
        \begin{tikzpicture}
          \begin{scope}[yshift=10cm]
            % define some useful coordinates
            \coordinate (origin) at (0,0);
            \coordinate (leftant) at (-4.5\m,0\m);
            \coordinate(rightant) at (4.5\m,0\m);
            \coordinate (attacklinecenter) at (0,-3\m);
            \draw[fill=brown,draw=black] ([xshift=-.1\m,yshift=-.05\m]leftant) rectangle ++ (0.1\m,0.1\m);
            \draw[fill=brown,draw=black] ([xshift=.1\m,yshift=-.05\m]rightant) rectangle ++ (-0.1\m,0.1\m);
            \draw[draw=none] ([yshift=-\sidelength]leftant) rectangle (rightant); 
            \draw[courtlines] ([yshift=0.5\courtlinewidth]leftant) rectangle ([yshift=-0.5\courtlinewidth]rightant);
            \draw[courtlines] (leftant) rectangle ++ (\courtlinewidth,-\sidelength);
            \draw[courtlines] (rightant) rectangle ++ (-\courtlinewidth,-\sidelength);
            \draw[courtlines] ([yshift=-\sidelength]leftant) rectangle ++ (\baselength,\courtlinewidth);
            \draw[courtlines] ([yshift=-\sidelength/3]leftant) rectangle ++ (\baselength,\courtlinewidth);
            <>
          \end{scope}
        \end{tikzpicture}
      \end{figure}
      ]],
      {
        i(2),i(1),i(0)
      }
      )
    ),  
  }
