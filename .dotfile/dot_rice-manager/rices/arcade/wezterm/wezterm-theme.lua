local wezterm = require 'wezterm'

local module = {}

function module.apply_to_config(config)
  config.font = wezterm.font_with_fallback {
    {
      family = 'scientifica', weight = 'Medium'
    },
    { family = 'Pixelcraft Nerd Font', assume_emoji_presentation = true}
  }
  config.font_size = 16.5
  config.cell_width = 1.1
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
    foreground = '#27fbfe',
    -- The default background color
    background = '#070219',

    -- Overrides the cell background color when the current cell is occupied by the
    -- cursor and the cursor style is set to Block
    cursor_bg = '#F29AB2',
    -- Overrides the text color when the current cell is occupied by the cursor
    cursor_fg = '#070219',
    -- Specifies the border color of the cursor when the cursor style is set to Block,
    -- or the color of the vertical or horizontal bar when the cursor style is set to
    -- Bar or Underline.
    cursor_border = '#F29AB2',

    -- the foreground color of selected text
    selection_fg = '#d9d9d9',
    -- the background color of selected text
    selection_bg = '#310eb1',

    ansi = {
      "#626483",
      "#fb007a",
      "#a6e22e",
      "#f3e430",
      "#19bffe",
      "#6800d2",
      "#43fbff",
      "#d9d9d9"
    },
    brights = {
      "#626483",
      "#fb007a",
      "#a6e22e",
      "#f3e430",
      "#19bffe",
      "#6800d2",
      "#43fbff",
      "#d9d9d9"
    },

    -- Arbitrary colors of the palette in the range from 16 to 255
    indexed = { [136] = "#fb007a" },

    -- Since: 20220319-142410-0fcdea07
    -- When the IME, a dead key or a leader key are being processed and are effectively
    -- holding input pending the result of input composition, change the cursor
    -- to this color to give a visual cue about the compose state.
    compose_cursor = "#f3e430"
  }
end

return module
