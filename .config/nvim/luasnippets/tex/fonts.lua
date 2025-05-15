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
    { condition = tex_utils.in_text }
  ),
  s({ trig = ";it", dscr = "italic typeface", snippetType="autosnippet" },
    fmta(
      [[
      \textit{<>}
      ]],
      { i(1) }
    ),
    { condition = tex_utils.in_text }
  ),
  ms({      
    common = { dscr = "Enter \\textcolor{}{} command", snippetType = "autosnippet", condition = tex_utils.in_mathzone },
    "colour",
    "color",
    { trig = "colour", snippetType = "snippet", condition = tex_utils.in_text },
    { trig = "color", snippetType = "snippet", condition = tex_utils.in_text },
    ";clr",
    { trig = ";clr", condition = tex_utils.in_text },
  }, {
      -- Snippet contents?
      t"\\textcolor{",
      i(1),
      t"}{",
      i(2),
      t"}"
    }
  ),



}
