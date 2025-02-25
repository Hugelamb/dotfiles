utils = require('luasnippets.tex.utils')
return {

  s({trig="test", dscr= "test snippet", snippetType= "autosnippet"},
    fmta([[
  hello, I'm the test snippet?
  this is the function value in (): (<>)
  ]],
      { f(utils.in_text, {})}

    ),
    { condition = utils.in_text }

  ),

}

