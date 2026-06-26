--- specific lua config files to include on for startup programs ---

-- require_humane("start.default")
local status = load_variant_humane(hostname,"start") 
if status ~= 1 then
  hl.notification.create({ text = "start/" .. hostname .. ".lua failed to load, falling back to start/default.lua", timeout = 4000, icon = "error" })
  load_variant_humane("default","start")
end
-- load_variant_humane("host-specific", "start")
