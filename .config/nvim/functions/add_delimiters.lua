local P = {}
local tbl = require('functions.table')
local delims = require('lua.user.delimiters')
P.surroundWord = function (opts) 
  --vim.cmd.normal([[vec]]) -- enter visual mode, go to end of current word, then move selection to register and enter insert mode
  vim.ui.input({ prompt = 'Enter desired delimiter: '}, function(input)
    local mode = vim.fn.mode()
    --print(mode)
    if input == '' then
      return "No delimiter selected, aborting now ..."
    end
    local startInsert = ''
    local endInsert = ''
    if tbl.contains(delims.delimiters,input) then -- check if entered delimiter is a known option
      if string.len(delims.delimiters[input]) == 1 then -- if only 1 character in value, then duplicate for both ends of selection
        startInsert = delims.delimiters[input]
        endInsert = startInsert
      elseif string.len(delims.delimiters[input]) == 2 then -- if two characters, set startInsert to first, endInsert to second
        startInsert = string.sub(delims.delimiters[input], 1, 1) -- should be first character of delimiter string
        endInsert = string.sub(delims.delimiters[input], 2) -- should be last char of delimiter string
      end
      -- Now we can insert the values into the buffer at cursor, then exit and paste in the original text
      if mode == 'n' then
        vim.cmd.normal([[vec]]) -- enter visual mode, go to end of current word, then move selection to register and enter insert mode
        vim.api.nvim_put({ startInsert .. vim.fn.getreg('"') .. endInsert }, 'c', true, true)
      elseif mode == 'v' or mode == 'x' then
        -- use existing visual selection instead of register contents

        local start_pos = vim.fn.getpos("v")
        local end_pos = vim.fn.getpos(".")
        -- following conditional block swaps start and end positions if end position is before start, as it is calculated from cursor position
        if end_pos[2] < start_pos[2] then
          local tmp = end_pos
          end_pos = start_pos
          start_pos = end_pos
        elseif end_pos[2] == start_pos[2] and end_pos[3] < start_pos[3] then
          local tmp = end_pos
          end_pos = start_pos
          start_pos = end_pos
        end

        --local start_pos = vim.fn.getpos("'<")
        --local startRow = tonumber(start_pos[2]) - 1
        --local end_pos = vim.fn.getpos("'>")
        local bufnr = vim.api.nvim_get_current_buf()  -- get correct buffer id
        --print("Visual Selection starts on line " .. start_pos[2] .. " at col " .. start_pos[3])
        --print("Visual Selection ends on line " .. end_pos[2] .. " at col " .. end_pos[3])
        vim.api.nvim_buf_set_text(bufnr, start_pos[2] - 1, start_pos[3] - 1, start_pos[2] - 1, start_pos[3] - 1,{startInsert})
        vim.api.nvim_buf_set_text(bufnr, end_pos[2] - 1 , end_pos[3] + 1, end_pos[2] - 1, end_pos[3] + 1,{endInsert})
      end
    else 
      vim.print(" The provided character \"" .. input .. "\" is not a valid delimiter.")
    end
  end
  )
end


return P


