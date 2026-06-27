--- load device specific monitor setup ---
for filename in io.popen([[ls -pa $HOME/.config/hypr/lua/utils | grep -v /]]):lines() do
  file = string.gsub(filename, ".lua","") 
  
  local status = require_humane("lua.utils." .. file)
  if status ~= 1 then
    hl.notification.create({ text = "lua/utils/" .. file .. ".lua failed to load", timeout = 4000, icon = "error" })
  else
    hl.notification.create({ text = "Loaded lua/utils/" .. file .. ".lua successfully.", timeout = 5000, icon = "ok" })
  end
  
end
