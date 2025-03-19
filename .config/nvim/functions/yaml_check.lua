#!/usr/local/env lua
local P = {}
P.read_yaml = function(filename)
  local file = io.open(filename, "r")
  if not file then 
    return nil, "FAILED: no file found named " .. filename
  end
  
  local data = {}
  for line in file:lines() do
    local key, value = line:match("(%w+):%s*(.+)")
    if key and value then
      data[key] = value
    end
  end
  
  file:close()
  return data
end
      
P.dump_table = function(obj)
  if type(obj) ~= 'table' then
    return tostring(obj)
  end
  local s = ''
  for k,v in pairs(obj) do
    if type(k) ~= 'number' then
      k = '"' ..k..'"'
    end
    s = s .. '['..k..'] = ' .. P.dump_table(v) .. ','
  end
  return '{ ' .. string.sub(s,1,-2) .. ' } '
end



P.is_JA = function()
  local cwd = vim.fn.getcwd() -- get current working directory
  local file_path = cwd .. "/info.yaml"   -- construct file path of desired info.yaml file

  -- Check if file_path points to a valid file
  if vim.fn.filereadable(file_path) ~= 1 then
    print("info.yaml not found in " .. cwd)
    return
  end

  -- Try to load and parse the YAML file
  local data = P.read_yaml(file_path)
  if not data then
    return nil, "FAILED: file at " .. file_path .. " not parsable as YAML."
  end 
  -- Check for desired key and value
  local ja = "JA"

  if data['short'] == ja then
    vim.cmd("setlocal spell spelllang=en_au,en_gb,cjk")
    return -- success
  else 
    vim.cmd("set nospell ")
    return data['short']
  end
end



return P
