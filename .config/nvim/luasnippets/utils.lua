-- Utility functions for lua snippets
-- include using require('luasnippets.utils')

 -- Some LaTeX-specific conditional expansion functions (requires VimTeX)
local utils = { }
utils.in_mathzone = function()  -- math context detection
  return vim.fn['vimtex#syntax#in_mathzone']() 
  
end
utils.in_text = function()
  return not utils.in_mathzone()
end
utils.in_comment = function()  -- comment detection
  return vim.fn['vimtex#syntax#in_comment']() 
end
utils.in_env = function(name)  -- generic environment detection
    local is_inside = vim.fn['vimtex#env#is_inside'](name)
    return (is_inside[1] > 0 and is_inside[2] > 0)
end
-- A few concrete environments---adapt as needed
utils.in_equation = function()  -- equation environment detection
    return utils.in_env('equation')
end
utils.in_itemize = function()  -- itemize environment detection
    return utils.in_env('itemize')
end
utils.in_tikz = function()  -- TikZ picture environment detection
    return utils.in_env('tikzpicture')
end
return utils
