-- LaTeX environment snippets
require('luasnippets.utils')

return {
  s({ trig = "mi", dscr = "Enter inline math mode",  name = "mi" },
    fmta(
      "$ <> $",
      {
        i(0)
      }
    ),
    { condition = in_text }
  ),
  s({ trig = "dm", dscr = "Enter display math mode" },
    fmta(
      [[
      $$ <> $$
      ]],
      {i(0)}
    ),
    { condition = in_text }
  ),
  s({ trig = "beq", dscr = "Equation environment" },
    fmta(
      [[
      \begin{equation*}
        <>
      \end{equation*}
      ]],
      { i(0) }
    ),
    { condition = in_text }
  ),

  s({ trig = "document", dscr = "begin/end document" },
    fmta(
      [[
      \begin{document}
        <>
      \end{document}
      ]],
      { i(0) }
    ),
    { condition = line_begin } 
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
        i(0),
        rep(1),
      }
    ),
    { condition = line_begin }
  ),
}

