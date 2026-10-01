-- LaTeX bibliography creation/management & citation/referencing snippets
local tex_utils = require('luasnippets.tex.utils')
local utils = require('luasnippets.utils')
local conds = require("luasnip.extras.expand_conditions")
local cond_obj = require("luasnip.extras.conditions")
local is = require("luasnip").insert_node
local s = require("luasnip").snippet
local t = require("luasnip").text_node
--



return {
  s({ trig = "tct+", dscr = "\\textcite insertion", snippetType="autosnippet" },
  fmta(
    [[
    \textcite[][<>]{<>}<>
    ]],
    {
      i(1),
      i(2,"C-X C-O for options"),
      i(0)
    }
  ),
  { condition = tex_utils.in_text }
),  
s({ trig = "Tct+", dscr = "\\Textcite insertion", snippetType="autosnippet" },
fmta(
  [[
  \Textcite[][<>]{<>}<>
  ]],
  {
    i(1),
    i(2,"C-X C-O for options"),
    i(0)
  }
),
{ condition = tex_utils.in_text }
),
s({ trig = "cttl", dscr = "\\citetitle insertion", snippetType="autosnippet" },
fmta(
  [[
  \citetitle[][<>]{<>}<>
  ]],
  {
    i(1),
    i(2,"C-X C-O for options"),
    i(0)
  }
),
{ condition = tex_utils.in_text }
),  
}
-- local function load_bib_keys()
  --   local bib_path = vim.fn.expand("%:p:h") .. "/master.bib" -- adjustments may be needed
  --   local keys = {}
  --   
  --   for line in io.lines(bib_path) do
  --     local key = line:match("@%w+{%s*([^,}]+)")
  --     if key then
  --       if not vim.tbl_contains(keys, key) then
  --         table.insert(keys, key)
  --       end
  --     end
  --   end
  --   return keys
  -- end
  -- 
  -- local bib_keys = load_bib_keys() -- populated on load
  -- 
  -- ----------------------------------
  -- -- Build a list of insert nodes, one per citation key
  -- ----------------------------------
  -- local choice_items = {}
  -- for _, k in ipairs(bib_keys) do
  --   table.insert(choice_items, is(k, k))
  -- end
  -- 
  -- return {
    -- 
    --   s({ trig = "c+", dscr = "Insert a \\cite{} command with selectable bibliography keys", snippetType="autosnippet" },
    --     fmta(
      --     [[
      --     \cite[<>][<>]{<>}<>
      --     ]],
      --     --i(1, table.concat(bib_keys, ",")),
      --       {
        --         i(1),
        --         i(2),
        --         c(3, choice_items),
        --         i(0)
        --       }
        --     ),
        --     { condition = tex_utils.in_text }
        --   ),  
        -- }
