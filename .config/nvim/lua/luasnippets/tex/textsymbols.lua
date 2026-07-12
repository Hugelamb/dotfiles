-- autosnippets for inserting common symbols into regular text (compatible with Luatex)
local utils = require('luasnippets.utils')
local tex_utils = require('luasnippets.tex.utils')
-- Table snippet definitions
return {
  s({ trig = "`~", dscr = "insert a tilde", snippetType="autosnippet" },
    fmta(
    [[\char`~<>]],
      i(0)
    ),
  { condition = tex_utils.in_text }
  ),  
}
