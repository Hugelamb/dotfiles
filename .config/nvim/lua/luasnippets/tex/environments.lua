-- LaTeX environment snippets
local tex_utils = require('luasnippets.tex.utils')
local utils = require('luasnippets.utils')
local conds = require("luasnip.extras.expand_conditions")
return {
  s({ trig = "mk", dscr = "Enter inline math mode",  name = "inline math environment", snippetType="autosnippet" },
    fmta(
      "$ <> $<>",
      {
        i(1,"math content"),
        i(0)

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
  s({ trig = "tab", dscr = "Basic tabular environment" },
    fmta(
      [[
    \begin{tabular}{<>}
    <> 
    \end{tabular}
    ]],
      {
        i(1, "c"),
        d(2, tex_utils.open_tab, {1}, {
          user_args = {
            function(snip) snip.rows = snip.rows + 1 end,
            -- don't drop below one
            function(snip) snip.rows = math.max(snip.rows - 1, 1) end
          }
        })})
  ),
  s({ trig = "tabc", dscr = "Bordered (closed) tabular environment", snippetType="autosnippet" },
    fmta(
      [[
    \begin{tabular}{|<>|}
    <> 
    \end{tabular}
    ]],
      {
        i(1, "c"),
        d(2, tex_utils.close_tab, {1}, {
          user_args = {
            function(snip) snip.rows = snip.rows + 1 end,
            -- don't drop below one
            function(snip) snip.rows = math.max(snip.rows - 1, 1) end
          }
        })})
  ),  
  s({ trig = "tabo", dscr = "Open tabular environment", snippetType="autosnippet", name = "open_table" },
    fmta(
      [[
    \begin{tabular}{<>}
    <> 
    \end{tabular}
    ]],
      {
        i(1, "c"),
        d(2, tex_utils.open_tab, {1}, {
          user_args = {
            function(snip) snip.rows = snip.rows + 1 end,
            -- don't drop below one
            function(snip) snip.rows = math.max(snip.rows - 1, 1) end
          }
        })})
  ),  
  s({ trig = "incfig", dscr = "include figure command", snippetType="autosnippet" },
    fmta(
    [[
    \incfig{<>}<>
    ]],
      {
        i(1),
        i(0)
      }
    ),
  { condition = tex_utils.in_text }
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
  -- enumerate
  s({ trig = "enn", dscr = "enumerate environment", snippetType="autosnippet" },
    fmta(
    [[
    \begin{enumerate}<>
      \item <>
    \end{enumerate}<>
    ]],
      {
        c(1,{
          t(""),
          t("[label = {\\ensquared{\\Alph*}}]"),
          t("[label = {\\textbf{\\arabic*}}]"),
          t("[label = {\\textbf{\\alph*}}]"),
          { t("[label = {"), i(1), t("}]") },
        }),
        i(2),
        i(0)
      }
    ),
    { condition = tex_utils.in_text }
  ),
  s({ trig = "itt", dscr = "itemize environment", snippetType="autosnippet" },
    fmta(
    [[
    \begin{itemize}<>
      \item <>
    \end{itemize}<>
    ]],
      {
        c(1,{
          t(""),
          { t("[label = {"), i(1), t("}]") },
          t("[label = {\\arrowheadbullet}]"),
          t("[label = {\\PaperPortrait}]")
        }),
        i(2),
        i(0)
      }
    ),
    { condition = tex_utils.in_text }
  ),  
  s({ trig = "itn", dscr = "enum item", snippetType="autosnippet" },
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
  s({ trig = "itn", dscr = "itemize item", snippetType="autosnippet" },
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
  s({ trig = "itd", dscr = "item w/ description", snippetType="autosnippet" },
    fmta(
    [[
    \item[<>] <>
    ]],
      {
        i(1),
        i(0)
      }
    ),
  { condition = tex_utils.in_itemize * conds.line_begin }
  ),  
  -- Sectioning environments

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
  s({ trig = "subs+", dscr = "New Subsubsection", snippetType="autosnippet", priority = 1000 },
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
  s({ trig = "tutn", dscr = "tutorial",snippetType="autosnippet" },
    fmta(
      [[
    \tutorial{<>}{<>}{<>}
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
      \begin{definition}{<>}{<>}
      <>
      \end{definition}
      <>
      ]],
      {
        i(1,'Defined'),
        i(2),
        i(3),
        i(0)
      }
    ),
    { condition = tex_utils.in_text + conds.line_begin }
  ),
  s({ trig = "propn", dscr = "property", snippetType="autosnippet" },
    fmta(
      [[
      \begin{property}{<>}{<>}
      <>
      \end{property}
      <>
      ]],
      {
        i(1,'Property Name'),
        i(2),
        i(3),
        i(0)
      }
    ),
    { condition = tex_utils.in_text + conds.line_begin }
  ),
  s({ trig = "rdn", dscr = "new reading note", snippetType="autosnippet" },
    fmta(
      [[
      \begin{reading}{<>}{<>}
      <>
      \end{reading}
      <>
      ]],
      {
        i(1,'Text Name'),
        i(2),
        i(3),
        i(0)
      }
    ),
    { condition = tex_utils.in_text + conds.line_begin }
  ),
  s({ trig = "thmn", dscr = "theorem", snippetType="autosnippet" },
    fmta(
      [[
      \begin{theorem}{<>}{<>}
      <>
      \end{theorem}
      <>
      ]],
      {
        i(1,'Theorem Name'),
        i(2),
        i(3),
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
    { condition = tex_utils.in_text + conds.line_begin }
  ),
}

