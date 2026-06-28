hl.config({
  general = {
    gaps_in = 50,
    gaps_out = 20,
    border_size=1,
    col = {
      active_border = { colors = {primary, surface_tint}, angles = 45},
      inactive_border = on_primary,
    },
    resize_on_border = true,
    allow_tearing = false,
    layout = "dwindle",
  }
})

hl.config({
  decoration = {
    dim_inactive = true,
    dim_strength = 0.1,
    active_opacity = 1,
    inactive_opacity = 1,

    glow = {
      enabled = true,
      range = 5,
      render_power = 1,
      color = surface_tint,
      color_inactive = surface_dim
    }

  }
})

hl.layer_rule({ match = { namespace = "waybar" }, blur = false })
