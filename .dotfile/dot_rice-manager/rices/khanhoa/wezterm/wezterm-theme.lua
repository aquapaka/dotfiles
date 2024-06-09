local wezterm = require 'wezterm'

local module = {}

function module.apply_to_config(config)
  config.font = wezterm.font_with_fallback {
    { family = 'CaskaydiaCove Nerd Font Mono', weight = "DemiBold"},
  }
  config.font_size = 13.5
  config.cell_width = 1
  config.line_height = 1
  config.window_padding = {
    left = 16,
    right = 16,
    top = 16,
    bottom = 16,
  }
  config.window_background_opacity = 0.9

  config.colors = {
    -- The default text color
    foreground = '#fdf9f3',
    -- The default background color
    background = '#221f22',

    -- Overrides the cell background color when the current cell is occupied by the
    -- cursor and the cursor style is set to Block
    cursor_bg = '#ff6188',
    -- Overrides the text color when the current cell is occupied by the cursor
    cursor_fg = '#fdf9f3',
    -- Specifies the border color of the cursor when the cursor style is set to Block,
    -- or the color of the vertical or horizontal bar when the cursor style is set to
    -- Bar or Underline.
    cursor_border = '#ff6188',

    -- the foreground color of selected text
    selection_fg = '#665C51',
    -- the background color of selected text
    selection_bg = '#273136',

    ansi = {
      "#665C51",
      "#ff6188",
      "#a9dc76",
      "#ffd866",
      "#78dce8",
      "#ab9df2",
      "#78dce8",
      "#fdf9f3"
    },
    brights = {
      "#b2a18d",
      "#f77188",
      "#a9dc76",
      "#ffd866",
      "#78dce8",
      "#ab9df2",
      "#78dce8",
      "#fdf9f3"
    },

    -- Arbitrary colors of the palette in the range from 16 to 255
    indexed = { [136] = "#a9dc76" },

    -- Since: 20220319-142410-0fcdea07
    -- When the IME, a dead key or a leader key are being processed and are effectively
    -- holding input pending the result of input composition, change the cursor
    -- to this color to give a visual cue about the compose state.
    compose_cursor = "#ffd866"
  }
end

return module
