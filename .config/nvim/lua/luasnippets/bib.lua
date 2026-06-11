-- Contains biblatex commands 
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
local cond_obj = require("luasnip.extras.conditions")

-- User imports

local tex_utils = require('luasnippets.tex.utils')
local utils = require('luasnippets.utils')

return {
  s({ trig = "e+", dscr = "new bibliography entry", snippetType="autosnippet" },
    fmta(
      [[
      @<>{<>,
        <>
      },
      <>
      ]]
      ,{
        i(1,"entry-type"),
        i(2,"key-identifier"),
        i(3,"field = {key}"),
        i(0)
      }
    ),
  { condition = utils.in_text * conds.line_begin }
  ),  
  s({trig = "bks", name = "book"},
    {
        t("@book{"), i(1,"key-identifier"), t(","),
		t({"",""}), t("    "), t("author = \""), i(2), t("\","),
		t({"",""}), t("    "), t("editor = \""), i(3), t("\","),
		t({"",""}), t("    "), t("title = \""), i(4), t("\","),
		t({"",""}), t("    "), t("publisher = \""), i(5), t("\","),
		t({"",""}), t("    "), t("year = \""), i(6), t("\","),
		t({"",""}), t("    "), t("volume = \""), i(7), t("\","),
		t({"",""}), t("    "), t("number = \""), i(8), t("\","),
		t({"",""}), t("    "), t("series = \""), i(9), t("\","),
		t({"",""}), t("    "), t("address = \""), i(10), t("\","),
		t({"",""}), t("    "), t("edition = \""), i(11), t("\","),
		t({"",""}), t("    "), t("month = \""), i(12), t("\","),
		t({"",""}), t("    "), t("note = \""), i(13), t("\""),
		t({"",""}), t("}")
    }
),
  s({ trig = "atcl", dscr = "article" },
    fmta(
    [[
    @article{<>,
      title = {<>},
      author = {<>},
      publisher = {<>},
      year = {<>},
      isbn = {<>},
      % optional fields can be omitted using choice node
      <><><>
    },
    <>
    ]],
      {
        i(1),
        i(2),
        i(3),
        i(4),
        i(5),
        i(6),
        i(7),
        i(8),
        i(9),
        i(0)
      }
    )
  ),   

}

