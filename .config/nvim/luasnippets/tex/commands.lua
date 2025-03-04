local utils = require('luasnippets.utils')
local tex_utils = require('tex.utils')
local conds = require('luasnip.extras.expand_conditions')

return {
  s({ trig = "pac", dscr = "package include", snippetType="autosnippet" },
    fmta(
    [[
    \usepackage[<>]{<>} <>
    ]],
      {
        i(2,"options"),i(1,"package"),i(0)
      }
    ),
    { condition = conds.line_begin}
  ),  
  s({ trig = "inn", dscr = "TeX file input", snippetType="autosnippet" },
    fmta(
    [[
    \input{<><>}
    ]],
      {
        i(1),
        i(2)
      }
    ),
    { condition = conds.line_begin }
  ),

}
