local palette = {
<* for name, value in colors *>
  {{name}} = "{{value.default.hex}}"
<* endfor *>
  -- background/foreground shades

  base0 = "{{colors.background.default.hex}}",
  base1 = "{{colors.background.default.hex | auto_lightness: 10.0}}",
  base2 = "{{colors.background.default.hex | auto_lightness: 20.0}}",
  base3 = "{{colors.background.default.hex | auto_lightness: 30.0}}",
  base4 = "{{colors.background.default.hex | auto_lightness: 40.0}}",
  base5 = "{{colors.background.default.hex | auto_lightness: 50.0}}",
  base6 = "{{colors.background.default.hex | auto_lightness: 60.0}}",

  -- Primary Shades

  primary1 = "{{colors.primary.default.hex | auto_lightness: 10.0}}",
  primary2 = "{{colors.primary.default.hex | auto_lightness: 20.0}}",
  primary3 = "{{colors.primary.default.hex | auto_lightness: 30.0}}",
  primary4 = "{{colors.primary.default.hex | auto_lightness: 40.0}}",
  primary5 = "{{colors.primary.default.hex | auto_lightness: 50.0}}",
  primary6 = "{{colors.primary.default.hex | auto_lightness: 60.0}}",
  -- Secondary Shades

  secondary1 = "{{colors.secondary.default.hex | auto_lightness: 10.0}}",
  secondary2 = "{{colors.secondary.default.hex | auto_lightness: 20.0}}",
  secondary3 = "{{colors.secondary.default.hex | auto_lightness: 30.0}}",
  secondary4 = "{{colors.secondary.default.hex | auto_lightness: 40.0}}",
  secondary5 = "{{colors.secondary.default.hex | auto_lightness: 50.0}}",
  secondary6 = "{{colors.secondary.default.hex | auto_lightness: 60.0}}",

  -- Tertiary Shades

  tertiary1 = "{{colors.tertiary.default.hex | auto_lightness: 10.0}}",
  tertiary2 = "{{colors.tertiary.default.hex | auto_lightness: 20.0}}",
  tertiary3 = "{{colors.tertiary.default.hex | auto_lightness: 30.0}}",
  tertiary4 = "{{colors.tertiary.default.hex | auto_lightness: 40.0}}",
  tertiary5 = "{{colors.tertiary.default.hex | auto_lightness: 50.0}}",
  tertiary6 = "{{colors.tertiary.default.hex | auto_lightness: 60.0}}",

}
return palette
