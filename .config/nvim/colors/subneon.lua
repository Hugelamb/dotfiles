--------------------------------
--- Subdued Neon Colorscheme ---
--------------------------------

-- local c = 








local M = {}

local keys = {
	'fg', 'bg', 'sp',
	'blend',
	'bold', 'italic',
	'standout', 'strikethrough', 'reverse',
	'underline', 'undercurl', 'underdouble', 'underdotted', 'underdashed',
	'nocombine',
	'default',
	'ctermfg', 'ctermbg', 'cterm',
}

M.dark = {
    --- base colours from darkest to lightest
    base1       = 0x17132a,
    base2       = 0x221c40,
    base3       = 0x2f2758,
    base4       = 0x4b3f8d,
    base5       = 0x978ccb,
    --- highlight colours
    blossom     = 0xddb1c7,
    green       = 0xb2dcc7,
    ylwdull     = 0xdbdcb2,
    blulite     = 0xb2c7dc,
    bluppl      = 0xb9b2dc,
    cyan        = 0x36f9f6,
    sand        = 0xdccdb2,
    lavndr      = 0x5c40e8,
    magenta     = 0xe24091,
    purpheart   = 0x8c57ff,
    wldstwbry   = 0xf70a89,
    berylgreen  = 0xd9dcb2,
    crete       = 0x7f8c40,
    woodland    = 0x545827,
    undrgrwth   = 0x222211,
    yellowdngr  = 0xe8b41a,
}

M.light = {
    --- invert base colours
    base1       = M.dark.base5,
    base2       = M.dark.base4,
    base3       = M.dark.base3,
    base4       = M.dark.base2,
    base5       = M.dark.base1,
    --- highlight colours 
     blossom     = 0xddb1c7,
    green       = 0xb2dcc7,
    ylwdull     = 0xdbdcb2,
    blulite     = 0xb2c7dc,
    bluppl      = 0xb9b2dc,
    cyan        = 0x36f9f6,
    sand        = 0xdccdb2,
    lavndr      = 0x5c40e8,
    magenta     = 0xe24091,
    purpheart   = 0x8c57ff,
    wldstwbry   = 0xf70a89,
    berylgreen  = 0xd9dcb2,
    crete       = 0x7f8c40,
    woodland    = 0x545827,
    undrgrwth   = 0x222211,
    yellowdngr  = 0xe8b41a,

}

local function set_hl(group, spec, palette)
    --- if attr is a singular string, assume that it is a linking call
    if type(spec) == "string" then
        vim.api.nvim_set_hl(0,group,{link=spec})
        return
    end
    
    -- Value table of highlight options 
    local kwargs = {}
    for _,key in ipairs(keys) do 
        kwargs[key] = spec[key]
    end
    vim.api.nvim_set_hl(0,group,kwargs)
end



return M
