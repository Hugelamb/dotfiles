-- LaTeX math environment snippets (

local tex_utils = require('tex.utils')

return {
  s({trig="cf", dscr="calligraphic typeface", snippetType="autosnippet"},
    fmta(
      [[
      \mathcal{<>} <>
      ]],
      { i(1), i(0) }
    ),  
    { condition = tex_utils.in_mathzone }
  ),
  s({trig="frak", dscr="fraktur typeface", snippetType="autosnippet"},
    fmta(
      [[
      \mathfraktur{<>} <>
      ]],
    { i(1), i(0) }
  ),
  { condition = tex_utils.in_mathzone }
),
s({ trig = "bf", dscr = "blackboard typeface", snippetType="autosnippet"},
  fmt(
    [[
    \mathbb{<>}
    ]],
    { i(1) },
    { delimiters = "<>" }
  ),
  { condition = tex_utils.in_mathzone }  
),
s({ trig = "frac", dscr = "trigger fraction environment"},
  fmta(
    [[
    \frac{<>}{<>}
    ]],
    { i(1,"num"), i(2,"den") }
    ),
    { condition = tex_utils.in_mathzone }
  ),
s({ trig = "boo", dscr = "test function", snippetType="autosnippet" },
  fmta([[
    The result of tex_utils.in_mathzone is : <> 
    The result of tex_utils.in_text is : 
  ]],
    {i(1)}
    ),
    { condition=utils.in_mathzone}
),
}
