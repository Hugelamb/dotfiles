local P = { }
--utils = P


-- function to dump table contents to terminal output
P.dump_table = function(table)
  if type(table) == 'table' then
    local s = '{ '
    for k,v in pairs(table) do
      if type(k) ~= 'number' then
        k = '"'..k..'"' 
      end
      s = s .. '['..k..'] = ' .. P.dump_table(v) .. ','
    end
    return s .. '} '
  else
    return tostring(table)
  end
end

P.print_table = function(table)
  if type(table) == 'table' then
    local s = '{ '
    for k,v in pairs(table) do
      s = s .. '"'..k..'" = ' .. P.print_table(v) .. ',' 
    end
    s = s ..'} '
    print(s)
    return s
  else
    return tostring(table)
  end
end
-- End Function List --
P.my_table = {
    name = "test",
    test = "dummy",
    inner = { "tables", "in", "tables" }
}
return P

