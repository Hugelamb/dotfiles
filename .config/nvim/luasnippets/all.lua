local utils = require('luasnippets.utils')
local get_date = utils.get_ISO_8601_date 
local get_custom_date_fmt = utils.get_custom_date_fmt 
return {
  s({ trig = "iso", dscr = "Today's date, in YYYY-MM-DD (ISO 8601) format" },
    {f(get_date)}
  ),  
--  s({ trig = "datelong", dscr = "Today's date, in long word format, ie 'fri 28 feb 2025 12:00' " })
  s({ trig = "date_fmt", dscr = "User formatted date" },
    d(1, get_custom_date_fmt, {}, { user_args = { "%a %d %b %Y %H:%M" }})
  ),
}

