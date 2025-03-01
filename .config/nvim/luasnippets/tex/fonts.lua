-- LaTeX font snippets 
local tex_utils = require('tex.utils')
return {
  s({ trig = ";bf", dscr = "bold typeface", snippetType="autosnippet" },
    fmta(
      [[
      \textbf{<>}
      ]],
      {i(1)}
    ),
    { condition = in_text }
  ),
  s({ trig = ";it", dscr = "italic typeface", snippetType="autosnippet" },
    fmta(
      [[
      \textit{<>}
      ]],
      { i(1) }
    ),
    { condition = in_text }
  ),
}
