--- load device specific workspace setup ---
local status = load_variant_humane("host","workspaces")
if status ~= 1 then
  hl.notification.create({ text = "workspaces/host.lua failed to load, using workspaces/default.lua as fallback", timeout = 4000, icon = "warning" })
  if load_variant_humane("default","workspaces") then
    hl.notification.create({ text = "workspaces/default.lua fallback failed!!!", timeout = 4000, icon = "error" })
  end
end
