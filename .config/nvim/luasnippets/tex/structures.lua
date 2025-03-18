-- Structures such as paragraphs, sections etc etc
local tex_utils = require('tex.utils')
local utils = require('utils')
local conds = require('luasnip.extras.expand_conditions')
return {
--   s({ trig = {";q"}, dscr = "Question" },
--     fmta(
--     [[
--     \paragraph{Question <>} <>
--     ]],
--       {
--         i(1,"A"),
--         i(0)
--       }
--     ),
--     { condition = (tex_utils.in_text) }
--   ),
--s({ trig = "fpar", dscr = "Create framed paragraph" },
--  fmta(
--  snippet
--  )
--),    
}
