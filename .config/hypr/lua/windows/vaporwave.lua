-- Window styling 
hl.config({
    general = {
        gaps_in = 2,
        gaps_out = 6,
        border_size = 2,
        -- https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
        col = {
            active_border = { colors = { "rgba(8c57ffee)", "rgba(36f9f6ee)" }, angle = 45 },
            inactive_border = "rgba(d9dcb2cc)",
        },
        -- colour gradient
        --8c57ff
        --ff3387
        --e99727 
        --89d86b
        --36f9f6
        -- Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = true,
        -- Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
        allow_tearing = false,
    },
    decoration = {
        rounding = 5,
        active_opacity = 1.0,
        inactive_opacity = 0.9,
        shadow = {
            enabled = true,
            range = 4,
            render_power = 3,
            color = "rgba(1a1a1aee)",
        },
        blur = {
            enabled = false,
            size = 3,
            passes = 1,
            vibrancy = 0.1696,
        },
    },
    animations = {
        enabled = true,
        -- animation types
        -- animation instances
    },
    misc = {
        force_default_wallpaper = 0, -- setting to 0 or 1 disables inbuilt anime mascots wallpapers
        disable_hyprland_logo = true, -- setting to true disables the randomized hyprland logo/anime girl background.
    },
})
