-- Utility functions for lua snippets
-- include using require('luasnippets.utils')
local utils = require('luasnippets.utils')
local cond_obj = require("luasnip.extras.conditions")
 -- Some LaTeX-specific conditional expansion functions (requires VimTeX)
local P = {}
util = P

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

