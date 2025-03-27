-- LuaScript snippets
return {
  s({trig="cs", dscr="conditional snippet"},    -- conditional snippet
   fmta(
      [[
      s({ trig = "<>", dscr = "<>" },
        fmta(
        <>
        ),
        { condition = <> }
      ),
      ]],
      { i(2), i(3), i(4), i(1) }   
    )
  ),
  s({trig="snpt", dscr="snippet",snippetType="autosnippet"},     -- normal snippet
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
  s({trig="asnpt", dscr="snippet",snippetType="autosnippet"},     -- normal snippet
    fmta(
      [[
      s({ trig = "<>", dscr = "<>", snippetType="autosnippet" },
        fmta(
        <>
        ),
      { <> }
      ),  
      ]],
      { i(1, "trigger" ), i( 2, "description" ), i( 3, "snippet" ), i( 4, "condition" )}
    )
  ),
  s({ trig = "sspc", dscr = "spec table entry", snippetType="autosnippet" },
    fmta("['<>'] = { context = { name = '<>' }, command = [[<>]] },<>"
    ,
      {
        i(1),
        i(2),
        i(3),
        i(0)
      }
    )
  
  ),  
}
