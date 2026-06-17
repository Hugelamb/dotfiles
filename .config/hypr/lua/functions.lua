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
  require_humane(".lua." .. variant_name .. "." .. variant_file)
end
