local M = {}
-- returns the value associated with the provided key in the provided table if it exists, otherwise returns nil 
M.find = function (tbl, key)
  for k, v in pairs(tbl) do
    if k == key then
      -- print(k," == ", key) -- debugging helper
      return v
    else
      -- print(k," != ", key) -- debugging helper
    end
  end
  return nil
end
-- M.contains searches a given table for the provided key, and returns true if successful, nil if not found (essentially a wrapper for M.find(tbl,key) ~= nil)
M.contains = function (tbl, key)
  return M.find(tbl,key) ~= nil
end

M.dump_table = function(table)
  if type(table) == 'table' then
    local s = '{ '
    for k,v in pairs(table) do
      if type(k) ~= 'number' then
        k = '"'..k..'"' 
      end
      s = s .. '['..k..'] = ' .. M.dump_table(v) .. ','
    end
    return s .. '} '
  else
    return tostring(table)
  end
end

M.print_table = function(table)
  if type(table) == 'table' then
    local s = '{ '
    for k,v in pairs(table) do
      s = s .. '"'..k..'" = ' .. M.print_table(v) .. ',' 
    end
    s = s ..'} '
    print(s)
    return s
  else
    return tostring(table)
  end
end
return M

