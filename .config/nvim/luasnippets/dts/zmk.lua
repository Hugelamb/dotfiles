-- Snippets for use with ZMK .dts and .dtsi files
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
}
