-- LaTeX environment snippets
local conds = require("luasnip.extras.expand_conditions")
return {
  s({ trig = "bcolor", dscr = "insert \\usebeamercolor command" },
    fmta(
    [[
    \usebeamercolor{<>}
    <>
    ]],
      {
        i(1),
        i(2)
      }
    ),
    { condition = conds.in_beamer }
  ),   
--   s({ trig = "env", dscr = "Generic new environment" },
--     fmta(
--       [[
--       \begin{<>}
--         <>
--       \end{<>}
--       ]],
--       {
--         i(1),
--         i(2),
--         rep(1),
--       }
--     ),
--    { condition = conds.line_begin }
--  ),
    
}

