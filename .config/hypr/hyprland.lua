--   _   _                  _                 _ 
--  | | | |                | |               | |
--  | |_| |_   _ _ __  _ __| | __ _ _ __   __| |
--  |  _  | | | | '_ \| '__| |/ _` | '_ \ / _` |
--  | | | | |_| | |_) | |  | | (_| | | | | (_| |
--  \_| |_/\__, | .__/|_|  |_|\__,_|_| |_|\__,_|
--          __/ | |                             
--         |___/|_|                             

--
-- =============================================
-- Functions and Lua Utilities
-- =============================================
--
require("lua.functions")
require("lua.colors")
require("lua.decorations.blur")

-- =============================================
-- Source environment variables
-- =============================================
-- Source: ~/.config/hypr/conf/environments/default.conf — convert this file to Lua and ensure it is on Lua's package.path.
require("lua.environments.default")

-- =============================================
-- Source aliases file
-- =============================================
-- Source: ~/.config/hypr/conf/aliases/default.conf — convert this file to Lua and ensure it is on Lua's package.path.
require("lua.aliases.default")
-- Source: ~/.config/hypr/conf/aliases/laptop.conf — convert this file to Lua and ensure it is on Lua's package.path.
require("lua.aliases.laptop")

-- =============================================
-- Source miscellaneous options
-- =============================================
require("lua.miscellaneous.laptop")

-- =============================================
-- Monitors
-- =============================================
require("lua.monitor")
require("lua.monitors.laptop")
require("lua.monitors.default")

-- =============================================
-- Source layout options
-- =============================================
require("lua.layout.laptop")

require("lua.window")
-- =============================================
-- Source windowrule options
-- =============================================
-- Source: ~/.config/hypr/conf/windows/default.conf — convert this file to Lua and ensure it is on Lua's package.path.
require("lua.windowrules.default")
-- Source: ~/.config/hypr/conf/windows/laptop.conf — convert this file to Lua and ensure it is on Lua's package.path.
require("lua.windowrules.laptop")

-- =============================================
-- Source input settings
-- =============================================
-- Source: ~/.config/hypr/conf/input/laptop.conf — convert this file to Lua and ensure it is on Lua's package.path.
require("lua.inputs.default")
require("lua.inputs.laptop")

-- =============================================
-- Source keybinds
-- =============================================
-- Source: ~/.config/hypr/conf/binds/default.conf — convert this file to Lua and ensure it is on Lua's package.path.
require("lua.binds.default")
-- Source: ~/.config/hypr/conf/binds/laptop.conf — convert this file to Lua and ensure it is on Lua's package.path.
require("lua.binds.laptop")

-- =============================================
-- Source workspace options
-- =============================================
-- Source: ~/.config/hypr/conf/workspaces/laptop.conf — convert this file to Lua and ensure it is on Lua's package.path.
require("lua.workspaces.laptop")

-- =============================================
-- Source autostart programs
-- =============================================
-- Source: ~/.config/hypr/conf/start/laptop.conf — convert this file to Lua and ensure it is on Lua's package.path.
require("lua.start.laptop")
