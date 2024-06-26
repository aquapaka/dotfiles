local wezterm = require 'wezterm'

local module = {}

function module.apply_to_config(config)
  config.font = wezterm.font_with_fallback {
    { family = 'Pixelcraft Nerd Font' },
    { family = 'Pixelcraft Nerd Font', assume_emoji_presentation = true}
  }
  config.font_size = 13.5
  config.cell_width = 1
  config.line_height = 0.75
  config.window_padding = {
    left = 16,
    right = 16,
    top = 16,
    bottom = 16,
  }
  config.window_background_opacity = 0.9

  config.colors = {
    -- The default text color
    foreground = '#EBDBB2',
    -- The default background color
    background = '#1D2021',

    -- Overrides the cell background color when the current cell is occupied by the
    -- cursor and the cursor style is set to Block
    cursor_bg = '#FB4934',
    -- Overrides the text color when the current cell is occupied by the cursor
    cursor_fg = '#1D2021',
    -- Specifies the border color of the cursor when the cursor style is set to Block,
    -- or the color of the vertical or horizontal bar when the cursor style is set to
    -- Bar or Underline.
    cursor_border = '#FB4934',

    -- the foreground color of selected text
    selection_fg = '#EBDBB2',
    -- the background color of selected text
    selection_bg = '#606a6d',

    ansi = {
      "#665C51",
      "#FB4934",
      "#B8BB26",
      "#FABD2F",
      "#83A598",
      "#D3869B",
      "#8EC07C",
      "#EBDBB2"
    },
    brights = {
      "#756D60",
      "#FF4A35",
      "#DADE2D",
      "#FFC130",
      "#92B8A9",
      "#F29AB2",
      "#ACE896",
      "#FFEEC1"
    },

    -- Arbitrary colors of the palette in the range from 16 to 255
    indexed = { [136] = "#FB4934" },

    -- Since: 20220319-142410-0fcdea07
    -- When the IME, a dead key or a leader key are being processed and are effectively
    -- holding input pending the result of input composition, change the cursor
    -- to this color to give a visual cue about the compose state.
    compose_cursor = "#FFC130"
  }
end

return module
