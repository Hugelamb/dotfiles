hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 2,
    border_size = 1,
    col = {
      active_border = { colors = {"rgb(ffffff)", on_primary}, angles = 90},
      inactive_border = on_primary,
    },
    resize_on_border = true,
    allow_tearing = false,
    layout = "dwindle",
  }
})
hl.config({
  decoration = {
    inactive_opacity = 0.8,

    blur = {
      enabled = true,
      size = 7,
      passes = 2,
      new_optimizations = true,
      xray = false,
      vibrancy = 0.5
    },

  }
})
hl.layer_rule({ match = { namespace = "waybar" }, blur = true })
