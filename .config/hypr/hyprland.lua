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
require("lua.functions") -- load several useful functions for loading lua files gracefully
-- require_humane("lua.util") -- loads all files in lua/utils/, containing any libraries of extra lua functions required such as json interpretation.
require("lua.utils")
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
-- require("lua.aliases.laptop")
-- hl.notification.create({text = "hostname is currently " .. hostname, timeout = 4000, icon = "warning"})
-- =============================================
-- Source miscellaneous options
-- =============================================
require("lua.miscellaneous.laptop")

-- =============================================
-- Monitors
-- =============================================
require("lua.monitor")

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

-- =============================================
-- Source input settings
-- =============================================
require("lua.input")

-- =============================================
-- Source keybinds
-- =============================================
require("lua.bind")

-- =============================================
-- Source workspace options
-- =============================================
-- Source: ~/.config/hypr/conf/workspaces/laptop.conf — convert this file to Lua and ensure it is on Lua's package.path.
require_humane("lua.workspace")

-- =============================================
-- Source autostart programs
-- =============================================
-- Source: ~/.config/hypr/conf/start/laptop.conf — convert this file to Lua and ensure it is on Lua's package.path.
-- require("lua.start.laptop")
require("lua.start")


-- =============================================
-- Source event handlers
-- =============================================

require("lua.event")
