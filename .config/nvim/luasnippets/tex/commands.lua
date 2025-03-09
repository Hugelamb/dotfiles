-- contains snippets for using specific commands
local tex_utils = require('luasnippets.tex.utils')
local utils = require('luasnippets.utils')
local conds = require("luasnip.extras.expand_conditions")
return {
  s({ trig = "pac", dscr = "", snippetType="autosnippet" },
    fmta(
    [[
    \usepackage[<>]{<>}
    <>
    ]],
      {
        i(1,"options"),
        i(2,"package"),
        i(0)
      }
    ),
    { condition = tex_utils.in_preamble }
  ),

}
