-- LaTeX environment snippets
local tex_utils = require('tex.utils')
local utils = require('utils')
return {
  s({ trig = ";mi", dscr = "Enter inline math mode",  name = "inline math environment", snippetType="autosnippet" },
    fmta(
      "$ <> $",
      {
        i(1,"math content")
      }
    ),
    { condition = tex_utils.in_text}
  ),
  s({ trig = ";dm", dscr = "display math environment", snippetType="autosnippet" },
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
  s({ trig = ";beq", dscr = "Equation environment" },
    fmta(
      [[
      \begin{equation*}
        <>
      \end{equation*}
      ]],
      { i(1, "equation" ) }
    ),
    { condition = tex_utils.in_text }
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
    { condition = line_begin }
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
  s({ trig = "pq", dscr = "Question", snippetType="autosnippet" },
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
  
}

