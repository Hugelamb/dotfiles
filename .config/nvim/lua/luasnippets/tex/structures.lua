-- Structures such as paragraphs, sections etc etc
local tex_utils = require('luasnippets.tex.utils')
local utils = require('luasnippets.utils')
local conds = require('luasnip.extras.expand_conditions')
return {
  s({ trig = "hl", dscr = "add hline", snippetType="autosnippet" },
    fmta(
    [[
    \hline <>
    ]],
      {i(0)}
    ),
  { condition = tex_utils.in_tab }
  ),      
}
