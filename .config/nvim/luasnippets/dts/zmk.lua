-- Snippets for use with ZMK .dts and .dtsi files
local extras = require("luasnip.extras")
local rep = extras.rep
local m = extras.match


return {
s({ trig = "js", dscr = "ZMK_UNICODE_SINGLE macro",snippetType="autosnippet" },
  fmta(
  [[
  ZMK_UNICODE_SINGLE(<>,  N<>,N<>,N<>,N<>)
  ]],
    {i(1),i(2),i(3),i(4),i(5)}
  )
),
  s({ trig = "jd", dscr = "ZMK_UNICODE_PAIR macro",snippetType="autosnippet"  },
    fmta(
    [[
    ZMK_UNICODE_PAIR(<>,  N<>, N<>, N<>, N<>,     N<>, N<>, N<>, N<>)	
    ]],
      {
       i(1,"name"),
        i(2),
        i(3),
        i(4),
        i(5),

        i(6),
        i(7),
        i(8),
        i(9),

      }
    )
  ),  
  s({ trig = "jt", dscr = "ZMK_THUMB_SHIFT_TRIO macro",snippetType="autosnippet" },
    fmta(
    [[
    ZMK_THUMB_SHIFT_TRIO(<>,  N<>, N<>, N<>, N<>,  N<>, N<>, N<>, N<>,  N<>, N<>, N<>, N<>)
    ]],
      {
        i(1,"name"),
        i(2),i(3),i(4),i(5),
        i(6),i(7),i(8),i(9),
        i(10),i(11),i(12),i(13)
      }
    )
  ),  
  s({ trig = "jr", dscr = "ZMK_THUMB_SHIFT_RIGHT macro",snippetType="autosnippet" },
    fmta(
    [[
    ZMK_THUMB_SHIFT_RIGHT(<>, N3, N0, <><>, <><>,  N3,  N0, <><>, <><>,  N3, N0, <><>, <><>)
    ]],
      {
        i(1,"name"),
        m(2, "%d","N"),i(2), m(3, "%d","N"),i(3), m(4, "%d","N"),i(4), m(5, "%d","N"),i(5),     
        m(6, "%d","N"),i(6), m(7, "%d","N"),i(7)
      }
    )
  ),
  s({ trig = "jl", dscr = "ZMK_THUMB_SHIFT_LEFT macro",snippetType="autosnippet" },
    fmta(
    [[
    ZMK_THUMB_SHIFT_LEFT(<>,  N3, N0, <><>, <><>,  N3,  N0, <><>, <><>,  N3, N0, <><>, <><>)

    ]],
      {
        i(1,"name"),
        m(2, "%d","N"),i(2), m(3, "%d","N"),i(3), m(4, "%d","N"),i(4), m(5, "%d","N"),i(5),     
        m(6, "%d","N"),i(6), m(7, "%d","N"),i(7)
      }
    )
  ),
}
