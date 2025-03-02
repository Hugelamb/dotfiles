-- LaTeX math environment snippets (
local utils = require('luasnippets.utils')
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
      \mathfrak{<>} <>
      ]],
      { i(1), i(0) }
    ),
    { condition = tex_utils.in_mathzone }
  ),
  s({ trig = "bf", dscr = "math bold typeface", snippetType="autosnippet" },
    fmta(
      [[
    \mathbf{<>} <>
    ]],
      {
        i(1), i(0)
      }
    ),
    { condition = tex_utils.in_mathzone }
  ),
  s({ trig = "bb", dscr = "blackboard typeface", snippetType="autosnippet"},
    fmt(
      [[
    \mathbb{<>}
    ]],
      { i(1) },
      { delimiters = "<>" }
    ),
    { condition = tex_utils.in_mathzone }  
  ),
  s({ trig = "ff", dscr = "trigger fraction environment", snippetType="autosnippet"},
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
      {
        i(1)
      }
    ),
    { condition=utils.in_mathzone}
  ),
-- Superscript snippet
  s({ trig = "([%w%)%]%}])'", dscr = "Superscript", wordTrig=false, regTrig=true,snippetType="autosnippet" },
    fmta(
    "<>^{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, utils.get_visual),
      }
    ),
    { condition = tex_utils.in_mathzone }
  ),  
-- Subscript snippet
  s({trig = "([%w%)%]%}])_", wordTrig=false, regTrig = true, snippetType="autosnippet"},
    fmta(
      "<>_{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        d(1, utils.get_visual),
      }
    ),
    {condition = tex_utils.in_mathzone}
  ),
  s({trig = "([%w%)%]%}])\"", wordTrig=false, regTrig = true, snippetType="autosnippet"},
    fmta(
      "<>^{<>}_{<>}",
      {
        f( function(_, snip) return snip.captures[1] end ),
        i(1),
        i(2),
      }
    ),
    {condition = tex_utils.in_mathzone}
  ),
  
  ms({ 
    common = {
      snippetType="autosnippet", condition=tex_utils.in_mathzone
    },
    "cnr",
    "binom",
    "ncr"
  }, {
      t"\\binom{",
      i(1),
      t"}{",
      i(2),
      t"}",
      i(0)
  })
}
