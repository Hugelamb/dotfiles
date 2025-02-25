-- Utility functions for lua snippets
-- include using require('luasnippets.utils')

 -- Some LaTeX-specific conditional expansion functions (requires VimTeX)
local P = {}
utils = P

P.in_mathzone = function()  -- math context detection
  return vim.api.nvim_eval['vimtex#syntax#in_mathzone']() 
end
P.in_text = function()
  return not P.in_mathzone()
end
P.in_comment = function()  -- comment detection
  return vim.fn['vimtex#syntax#in_comment']() 
end
P.in_env = function(name)  -- generic environment detection
    local is_inside = vim.fn['vimtex#env#is_inside'](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end
-- A few concrete environments---adapt as needed
P.in_equation = function()  -- equation environment detection
    return P.in_env('equation')
end
P.in_itemize = function()  -- itemize environment detection
    return P.in_env('itemize')
end
P.in_tikz = function()  -- TikZ picture environment detection
    return P.in_env('tikzpicture')
end
return P
