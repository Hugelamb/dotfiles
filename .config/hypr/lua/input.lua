--- load device specific monitor setup ---
local status = load_variant_humane(hostname,"inputs")
if status ~= 1 then
  load_variant_humane("default","inputs")
  hl.notification.create({ text = "inputs/" .. hostname .. ".lua failed to load, using inputs/default.lua as fallback", timeout = 4000, icon = "warning" })
  if load_variant_humane("default","inputs") ~= 1 then
    hl.notification.create({ text = "inputs/default.lua failed to load, emergency binds should be active as a fallback", timeout = 4000, icon = "error"})
  end
end
