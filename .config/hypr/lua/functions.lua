-- Load Variant
function load_variant(variant_file, variant_name)
  variant_file = variant_file:gsub(".lua","")
  require("lua." .. variant_name .. "." .. variant_file)
end

-- Soft load function (continue on error without exiting)
function require_humane(required_file)
  local status, value = pcall(require, required_file)
  if status then
    return 1
  else
    print("failed to load module, its error message was:", value)
    return 0
  end
end

-- humane variant
function load_variant_humane(variant_file, variant_name)
  variant_file = variant_file:gsub(".lua","")
  local status = require_humane(".lua." .. variant_name .. "." .. variant_file)
  return status -- ensures that it has the same output as require_humane() 
end

-- count ipairs of lua table
function countTableEntries(t)
  if type(t) ~= 'table' then
    print("Invalid type passed to function countTableEntries(), should be a table.")
    return -1
  end
  n = 0
  for i, d in ipairs(t) do
    n = n + 1
  end
  return n
end
  --
-- return table as a formatted string
function table2string(t)
  ts = "{ "
  k, v = next(t)  -- get first pair
  while k do
    print(k,v)
    ts = ts .. '"' .. tostring(k) .. '": ' -- add key to string
    if type(v) == 'table' then
      ts = ts .. table2string(v) 
    elseif type(v) == 'string' then -- otherwise at innermost level of current table entry, must be a string, number or boolean
      ts = ts .. '"' .. tostring(v) .. '"' 
    else
      ts = ts .. tostring(v)   
    end
    k, v = next(t, k)
    if k ~= nil then
      ts = ts .. ', '
    end
  end
  ts = ts .. "}"
  return ts
end
