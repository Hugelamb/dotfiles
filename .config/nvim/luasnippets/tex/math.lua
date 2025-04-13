-- LaTeX math environment snippets (
local utils = require('luasnippets.utils')
local tex_utils = require('tex.utils')
-- Table snippet definitions
M = {
-- Symbols
  s({ trig = "iff", dscr = "Latex \\iff", snippetType="autosnippet" },
    t"\\iff",
  { condition = tex_utils.in_mathzone }
  ),        
-- Fonts
  s({ trig = "rm", dscr = "normal text", snippetType="autosnippet" },
    fmta(
      [[
      \textrm{ <> } <>
      ]],
      {
        i(1),
        i(0)
      }
    ),
  { condition = tex_utils.in_mathzone }
  ),  

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
  -- Operations 
  s({ trig = "==", dscr = "equals", snippetType="autosnippet" },
    t"&=",
    { condition = tex_utils.in_mathzone }
  ),    
  s({ trig = "neq", dscr = "not equal", snippetType="autosnippet" },
    t"\\neq",
    { condition = tex_utils.in_mathzone }
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
    }),
  s({ trig = "tr", dscr = "transpose of Matrix", snippetType="autosnippet" },
    fmta(
      [[
    <>^\intercal <>
    ]],
      {
        i(1,"A"),
        i(0)
      }
    ),
    { condition = tex_utils.in_mathzone }
  ),  
  s({ trig = "norm", dscr = "matrix norm" },
    fmta(
      [[
      \norm{<>}
      ]],
      {
        i(1)
      }
    ),
    { condition = tex_utils.in_mathzone}
  ), 
-- Auto backslash snippets from evesdropper


-- Cases and matrices
  s({ trig = "(%d?)cases", name = "cases", dscr = "cases", regTrig = true, hidden = true, snippetType="autosnippet" },
    fmta(
    [[
    \begin{cases}
    <>
    .\end{cases}
    ]],
      { d(1, tex_utils.generate_cases) }),
  { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),  
-- Matrices
  s({ trig = "([bBpvV])mat(%d+)x(%d+)([ar])", dscr = "Matrices", trigEngine="pattern",hidden="true", snippetType="autosnippet" },
    fmta(
    [[
    \begin{<>}<>
    <>
    \end{<>}]],
      {
        f(function(_, snip)
          return snip.captures[1] .. "matrix"
        end),
        f(function(_, snip)
        if snip.captures[4] == "a" then
            out = string.rep("c", tonumber(snip.captures[3]) - 1)
            return "[" .. out .. "|c]"
        end
        return ""
    end),
    d(1, tex_utils.mat),
    f(function(_, snip)
        return snip.captures[1] .. "matrix"
    end)
      }),
    { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone }
  ),      
  s({ trig = "lr([aAbBcmp])", dscr = "left right delimiters", trigEngine = "pattern", hidden = "true", snippetType="autosnippet" },
    fmta(
    [[
    \left<> <> \right<><>
    ]],
        {f(function(_, snip)
        cap = snip.captures[1]
        if brackets[cap] == nil then
            cap = "p"
        end -- set default to parentheses
        return brackets[cap][1]
    end),
    d(1, get_visual),
    f(function(_, snip)
        cap = snip.captures[1]
        if brackets[cap] == nil then
            cap = "p"
        end
        return brackets[cap][2]
    end),
    i(0)}),
  { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone}
  ),  
  s({ trig = "([clvda])%.", trigEngine = "pattern", dscr = "dots", snippetType="autosnippet" },
    fmta([[
    \<>dots
      ]],
         { f(get_capture, {}, { user_args = { 1 } }) }
    ),
  { condition = tex_utils.in_mathzone, show_condition = tex_utils.in_mathzone}
  ),  
  s({ trig='tr(%d)', name='table row', dscr='table row', trigEngine="pattern", hidden=true},
    fmta([[
    <>,
    ]],
    { d(1, tr) }
    )),

}

local auto_backslash_specs = {
	"arcsin",
	"sin",
	"arccos",
	"cos",
	"arctan",
	"tan",
	"cot",
	"csc",
	"sec",
	"log",
	"ln",
	"exp",
	"ast",
	"star",
	"perp",
	"sup",
	"inf",
	"det",
	"max",
	"min",
	"argmax",
	"argmin",
        "deg",
        "angle",
    "pi",
}


return M
