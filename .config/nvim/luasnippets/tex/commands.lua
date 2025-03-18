-- contains snippets for using specific commands
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet

-- Personal imports
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
  s({ trig = "href", dscr = "insert hidden reference here", snippetType="autosnippet" },
    fmta(
      [[
      \href{<>}{<>}<>
      ]],
      {
        i(1,'Display text'),
        i(2,'Link location'),
        i(0)
      }
    ),
  { condition= tex_utils.in_text }
  ),  
  s({ trig = "lbl", dscr = "insert label", snippetType="autosnippet" },
    fmta(
      [[
      \label{<>:<>}<>
      ]],
      {
        i(1,'type'),
        i(2,'name'),
        i(0)
      }
    ),
  { condition = tex_utils.in_text }
  ),  
  s({ trig = "ref+", dscr = "add reference", snippetType="autosnippet" },
    fmta(
      [[
      \ref{<>:<>}<>
      ]],
      {
        i(1,'type'),
        i(2,'name'),
        i(0)
      }
    ),
  { condition = tex_utils.in_text }
  ),  
}
