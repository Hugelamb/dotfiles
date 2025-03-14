-- LaTeX environment snippets
local tex_utils = require('tex.utils')
local utils = require('utils')
local conds = require("luasnip.extras.expand_conditions")
return {
  s({ trig = "mk", dscr = "Enter inline math mode",  name = "inline math environment", snippetType="autosnippet" },
    fmta(
      "$ <> $",
      {
        i(1,"math content")
      }
    ),
    { condition = tex_utils.in_text}
  ),
  s({ trig = "dm", dscr = "display math environment", snippetType="autosnippet" },
    fmta(
      [[
      $$ <> $$
      ]],
      {
        i(1,"displayed content")
      }
    ),
    { condition = tex_utils.in_text }
  ),
  s({ trig = "beq", dscr = "Equation environment" },
    fmta(
      [[
      \begin{equation*}
        <>
      \end{equation*}
      ]],
      { i(1, "equation" ) }
    ),
    { condition = tex_utils.in_text + conds.line_begin }
  ),
  s({ trig = "env", dscr = "Generic new environment" },
    fmta(
      [[
      \begin{<>}
        <>
      \end{<>}
      ]],
      {
        i(1),
        i(2),
        rep(1),
      }
    ),
    { condition = conds.line_begin }
  ),
  s({ trig = "tab", dscr = "Table environment" },
    fmta(
    [[
    \begin{tabular}{<>}
    <> 
    \end{tabular}
    ]],
      {
        i(1, "c"),
        d(2, utils.tab, {1}, {
          user_args = {
            function(snip) snip.rows = snip.rows + 1 end,
            -- don't drop below one
            function(snip) snip.rows = math.max(snip.rows - 1, 1) end
          }
        })})
  ),  
  s({ trig = ";fig", dscr = "new figure environment" },
    fmta(
    [[
    \begin{figure}[<>]
    <>
    \end{figure}
    ]],
      {
        i(1, "htb!"), i(0) 
      }
    )
  ),
  s({ trig = ";img", dscr = "insert image in figure environment", snippetType="autosnippet" },
    fmta(
    [[
    \begin{figure}[<>]
    \centering
    \includegraphics[width=<>\textwidth]{<>}\caption{<>}
    \end{figure}
    <>
    ]],
      { 
        i(1,"htb!"),
        i(2,"0.5"),
        i(3),
        i(4),
        i(0)
      }
    )
  ),    
-- Lists and bullet points
  s({ trig = "enn", dscr = "enumerate", snippetType="autosnippet" },
    fmta(
    [[
    \begin{enumerate}
      
      \item <>
    \end{enumerate}
    ]],
      { 
        i(0) 
      }
    ),
    { condition = tex_utils.in_text }
  ),  
  s({ trig = "itt", dscr = "itemize", snippetType="autosnippet" },
    fmta(
    [[
    \begin{itemize}
      
      \item <>
    
    \end{itemize}
    ]], 
      {
        i(0),
      }
    ),
    { condition = tex_utils.in_text }
  ),
  s({ trig = "en", dscr = "enum item", snippetType="autosnippet" },
    fmta(
    [[
    \item <>
    ]],
      {
        i(0)
      }
    ),
    { condition = tex_utils.in_enumerate * conds.line_begin }
  ),
  s({ trig = "it", dscr = "itemize item", snippetType="autosnippet" },
    fmta(
    [[
    \item <>
    ]],
      {
        i(0),
      }
    ),
    { condition = tex_utils.in_itemize * conds.line_begin }
  ),  
-- Sectioning environments
  s({ trig = "qa", dscr = "Answer", snippetType="autosnippet" },
    fmta(
    [[
    \paragraph*{Answer } <>
    ]],
      { 
        i(0)
      }
    ), 
    { condition = tex_utils.in_text }
  ),
  s({ trig = "qq", dscr = "Question", snippetType="autosnippet" },
    fmta(
    [[
    \paragraph{Question <>} <>
    ]],
      { i(1, "A"),
        i(0)
      }
    ), 
    { condition = tex_utils.in_text }
  ),  
  s({ trig = "chp+", dscr = "Chapter", priority = 1000, snippetType="autosnippet", hidden = false, name = "chapter"  },
    fmta(
    [[
    \chapter{<>}
    ]],
      {i(1)}
    ),
    { condition = conds.line_begin - tex_utils.in_mathzone }
  ),
  s({ trig = "chp*", dscr = "Unmarked Chapter", priority = 1000, snippetType="autosnippet", hidden = false, name = "unmarked chapter"  },
    fmta(
    [[
    \chapter*{<>}
    ]],
      {i(1)}
    ),
    { condition = conds.line_begin - tex_utils.in_mathzone }
  ),
  s({ trig = "sec+", dscr = "Section", priority = 1000, snippetType="autosnippet", hidden = false, name = "section"  },
    fmta(
    [[
    \section{<>}
    ]],
      {i(1)}
    ),
    { condition = conds.line_begin - tex_utils.in_mathzone }
  ), 
  s({ trig = "sec*", dscr = "Unmarked Section", snippetType="autosnippet" },
    fmta(
    [[
    \section*{<>}
    ]],
      {i(1)}
    ),
    { condition = conds.line_begin - tex_utils.in_mathzone }
  ),
  s({ trig = "sub+", dscr = "New Subsection", snippetType="autosnippet" , priority=1000},
    fmta(
    [[
    \subsection{<>}
    ]],
      {i(1)}
    ),
    { condition = conds.line_begin - tex_utils.in_mathzone }
  ),
  s({ trig = "sub*", dscr = "Unmarked Subsection", snippetType="autosnippet" },
    fmta(
    [[
    \subsection*{<>}
    ]],
      {i(1)}
    ),
    { condition = conds.line_begin - tex_utils.in_mathzone }
  ),
  s({ trig = "subs", dscr = "New Subsubsection", snippetType="autosnippet", priority = 1000 },
    fmta(
    [[
    \subsubsection{<>}
    ]],
      {i(1)}
    ),
    { condition = conds.line_begin - tex_utils.in_mathzone }
  ),
  s({ trig = "subs*", dscr = "Unmarked Subsubsection", snippetType="autosnippet" },
    fmta(
    [[
    \subsubsection*{<>}
    ]],
      {i(1)}
    ),
    { condition = conds.line_begin - tex_utils.in_mathzone }
  ),
  s({ trig = "par+", dscr = "New Paragraph", snippetType="autosnippet" },
    fmta(
    [[
    \paragraph{<>}
    ]],
      {i(1)}
    ),
    { condition = conds.line_begin - tex_utils.in_mathzone }
  ),
  s({ trig = "par*", dscr = "Unmarked paragraph", snippetType="autosnippet" },
    fmta(
    [[
    \paragraph*{<>}
    ]],
      {i(1)}
    ),
    { condition = conds.line_begin - tex_utils.in_mathzone }
  ),   
  -- Custom environments requiring specific preamble definitions
  s({ trig = "lecn", dscr = "lecture",snippetType="autosnippet" },
    fmta(
    [[
    \lecture{<>}{<>}{<>}
    <>
    ]],
      {
        i(1),
        d(2, utils.get_custom_date_fmt, {}, { user_args = { "%a %d %b %Y %H:%M" }}),
        i(3),
        i(0)
      }
    ),
    { condition = tex_utils.in_text + conds.line_begin }
  ),
  s({ trig = "defn", dscr = "definition", snippetType="autosnippet" },
    fmta(
      [[
      \definition[<>]{
        <>
      }
      ]],
      {
        i(1),
        i(0)
      }
    ),
    { condition = tex_utils.in_text + conds.line_begin }
  ),
  s({ trig = "exn", dscr = "exercise", snippetType="autosnippet" },
    fmta(
      [[
      \exercise{<>}
      \textbf{Question: }<> \\
      \paragraph*{Solution: }<>
      <>
      ]],
      {
        i(1,"Title"),
        i(2,"Question"),
        i(3,"Solution"),
        i(0)
      }
    ),
    { condition = tex_utils.in_text + conds+line_begin }
  ),
  
}

