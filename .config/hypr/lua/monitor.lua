--- load device specific monitor setup ---
local status = load_variant_humane("host","monitors")
if status ~= 1 then
  hl.notification.create({ text = "monitors/host.lua failed to load, using monitors/default.lua as fallback", timeout = 4000, icon = "warning" })
  if load_variant_humane("default","monitors") then
    hl.notification.create({ text = "monitors/default.lua fallback failed!!!", timeout = 4000, icon = "error" })
  end
end
