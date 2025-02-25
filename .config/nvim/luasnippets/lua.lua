-- LuaScript snippets
utils=require('luasnippets.tex.utils')
return {
  s({trig="cs", dscr="conditional snippet"},    -- conditional snippet
   fmta(
      [[
      s({ trig = "<>", dscr = "<>" },
        fmt(<>),
        { condition = <> }
      ),
      ]],
      { i(2), i(3), i(4), i(1) }   
    )
  ),
  s({trig="snip", dscr="snippet"},     -- normal snippet
    fmta(
      [[
      s({ trig = "<>", dscr = "<>" },
        fmta(
        <>
        )
      ),  
      ]],
      { i(1, "trigger" ), i( 2, "description" ), i( 3, "snippet" )}
    )
  ),
}
