-- Utility functions for lua snippets
-- include using require('luasnippets.utils')
local utils = require('luasnippets.utils')
local cond_obj = require("luasnip.extras.conditions")
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
 -- Some LaTeX-specific conditional expansion functions (requires VimTeX)
local P = {}
util = P
-- Scaffolding for some common snippet types
P.auto_backslash_snippet = function(context, opts)
  opts = opts or {}
  if not context.trig then
    error("context doesn't include a `trig` key which is mandatory",2)
  end
  context.dscr = context.dscr or (context.trig .. "with automatic backslash")
  context.name = context.name or context.trig
  context.docstring = context.docstring or ([[\]] .. context.trig)
  context.trigEngine = "ecma"
  context.trig = "(?<!\\\\)" .. "(" .. context.trig ..")"
    return as(context,
  fmta([[
  \<><>
  ]],
  { f(function(_, snip)
      return snip.captures[1]
      end),
      i(0) }),
    opts)
end

P.generate_cases = function(args, snip)
	local rows = tonumber(snip.captures[1]) or 2 -- default option 2 for cases
	local cols = 2 -- fix to 2 cols
	local nodes = {}
	local ins_indx = 1
	for j = 1, rows do
		table.insert(nodes, r(ins_indx, tostring(j) .. "x1", i(1)))
		ins_indx = ins_indx + 1
		for k = 2, cols do
			table.insert(nodes, t(" & "))
			table.insert(nodes, r(ins_indx, tostring(j) .. "x" .. tostring(k), i(1)))
			ins_indx = ins_indx + 1
		end
		table.insert(nodes, t({ "\\\\", "" }))
	end
	-- fix last node.
    table.remove(nodes, #nodes)
	return sn(nil, nodes)
end

-- local function in_env(name)
--   local is_inside = vim.fn["vimtex#env#is_inside"](name)
--   return (is_inside[1] > 0 and is_inside[2] > 0)
-- end
-- function P.in_preamble()
--   return not in_env("document")
-- end
local function in_mathzone()  -- math context detection
  return vim.api.nvim_eval('vimtex#syntax#in_mathzone()') == 1
  --return vim.fn['vimtex#syntax#in_mathzone']()
end
P.in_mathzone = cond_obj.make_condition(in_mathzone)
local function in_text()
  return not P.in_mathzone()
end
P.in_text = cond_obj.make_condition(in_text)
local function in_comment()  -- comment detection
  return vim.fn['vimtex#syntax#in_comment']() 
end
P.in_comment = cond_obj.make_condition(in_comment)
-- P.in_env = function(name)  -- generic environment detection
--     local is_inside = vim.fn['vimtex#env#is_inside'](name)
--     return (is_inside[1] > 0 and is_inside[2] > 0)
-- end
-- A few concrete environments---adapt as needed
-- local function in_preamble()
--   local is_inside = vim.fn['vimtex#env#is_inside']("document")
--   return not (is_inside[1] > 0 and is_inside[2] > 0)
-- end
-- P.in_preamble = in_preamble()
local function in_enumerate()
  local is_inside = vim.fn['vimtex#env#is_inside']("enumerate")
  return (is_inside[1] > 0 and is_inside[2] > 0)
end
P.in_enumerate = cond_obj.make_condition(in_enumerate)
local function in_equation()  -- equation environment detection
  local is_inside = vim.fn['vimtex#env#is_inside']("equation")
  return (is_inside[1] > 0)
end
P.in_equation = cond_obj.make_condition(in_equation)

local function in_itemize()  -- itemize environment detection
  local is_inside = vim.fn['vimtex#env#is_inside']("itemize")
  return (is_inside[1] > 0 and is_inside[2] > 0)
end
P.in_itemize = cond_obj.make_condition(in_itemize)

local function in_tikz()  -- TikZ picture environment detection
  local is_inside = vim.fn['vimtex#env#is_inside']("tikzpicture")
  return (is_inside[1] > 0)
end
P.in_tikz = cond_obj.make_condition(in_tikz)

return P

