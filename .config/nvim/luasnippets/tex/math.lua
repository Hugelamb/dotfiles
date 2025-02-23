-- LaTeX math environment snippets (
require('luasnippets.utils')
return {
  s({trig="cf", dscr="calligraphic typeface", snippetType="autosnippet"},
    fmta(
      [[
      \mathcal{<>} <>
      ]],
      { i(1), i(0) }
    ),  
    { condition = in_mathzone }
  ),
  s({trig="ff", dscr="fraktur typeface", snippetType="autosnippet"},
    fmta(
      [[
      \mathfraktur{<>} <>
      ]],
    { i(1), i(0) }
  ),
  { condition = in_mathzone }
),
s({ trig = "bf", dscr = "blackboard typeface", snippetType="autosnippet"},
  fmt(
    [[
    \mathbb{<>}
    ]],
    { i(1) },
    { delimiters = "<>" }
  ),
  { condition = in_mathzone }  
),
s({ trig = "frac", dscr = "trigger fraction environment"},
  fmta(
    [[
    \frac{<>}{<>}
    ]],
    { i(1,"num"), i(2,"den") }
    ),
    { condition = in_mathzone }
  ),
}
