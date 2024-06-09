local wezterm = require 'wezterm'

local module = {}

function module.apply_to_config(config)
  config.font = wezterm.font_with_fallback {
    { family = 'Monaspace Radon', weight = 'Medium' },
  }
  config.font_size = 14
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
    foreground = '#d1ded3',
    -- The default background color
    background = '#273136',

    -- Overrides the cell background color when the current cell is occupied by the
    -- cursor and the cursor style is set to Block
    cursor_bg = '#7eb08a',
    -- Overrides the text color when the current cell is occupied by the cursor
    cursor_fg = '#d1ded3',
    -- Specifies the border color of the cursor when the cursor style is set to Block,
    -- or the color of the vertical or horizontal bar when the cursor style is set to
    -- Bar or Underline.
    cursor_border = '#7eb08a',

    -- the foreground color of selected text
    selection_fg = '#d2b48c',
    -- the background color of selected text
    selection_bg = '#484a46',

    ansi = {
      "#697f84",
      "#ff819f",
      "#7eb08a",
      "#d2b48c",
      "#7ea4b0",
      "#ba8eaf",
      "#82beb0",
      "#d1ded3"
    },
    brights = {
      "#a5c8d0",
      "#ff818e",
      "#b4fcc5",
      "#ffdaaa",
      "#b4ebfc",
      "#ffc2ef",
      "#aeffec",
      "#f0fff4"
    },

    -- Arbitrary colors of the palette in the range from 16 to 255
    indexed = { [136] = "#7eb08a" },

    -- Since: 20220319-142410-0fcdea07
    -- When the IME, a dead key or a leader key are being processed and are effectively
    -- holding input pending the result of input composition, change the cursor
    -- to this color to give a visual cue about the compose state.
    compose_cursor = "#ffdaaa"
  }
end

return module
