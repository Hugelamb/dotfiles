--#########################
--## WORKSPACE DEFAULTS ###
--#########################
--- Work out number of currently connected monitors ---
monitors = hl.get_monitors()
local mcount = #monitors


--- Using number of connected monitors, distribute workspaces 0-9 roughly evenly between them
--- If uneven, disperse from first monitor onwards
wCount = 10 -- number of workspaces to assign (0-9, but in order of 1-9, then 0)
wPerMonitor, remainder = math.modf(wCount/mcount)
wkspcTable = {}
currWI = 1 -- current maximum index of assigned workspaces (treat 0 as 10)
for k,v in ipairs(monitors) do
  if remainder > 0 then
    workspaces = wPerMonitor + 1
    remainder = remainder - 1
  else
    workspaces = wPerMonitor
  end
  wCount = wCount - workspaces -- track how many have been given out.
  -- assign workspaces to that monitor
  for w = currWI, currWI + wCount do
    hl.workspace_rule({
      workspace = tostring(w),
      monitor = tostring(v.name),
      decorate = true,
      gaps_in = 1,
      gaps_out = 3,
      persistent = true,
    })
  end
  currWI = currWI + wCount
  

end


