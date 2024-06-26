local wezterm = require 'wezterm'

local module = {}

function module.apply_to_config(config)
  config.font = wezterm.font_with_fallback {
    { family = 'Monaspace Xenon', weight = "Regular"},
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
    foreground = '#000000',
    -- The default background color
    background = '#F2EEDE',

    -- Overrides the cell background color when the current cell is occupied by the
    -- cursor and the cursor style is set to Block
    cursor_bg = '#000000',
    -- Overrides the text color when the current cell is occupied by the cursor
    cursor_fg = '#AAAAAA',
    -- Specifies the border color of the cursor when the cursor style is set to Block,
    -- or the color of the vertical or horizontal bar when the cursor style is set to
    -- Bar or Underline.
    cursor_border = '#000000',

    -- the foreground color of selected text
    selection_fg = '#000000',
    -- the background color of selected text
    selection_bg = '#D8D5C7',

    ansi = {
      "#000000",
      "#CC3E28",
      "#216609",
      "#B58900",
      "#1E6FCC",
      "#5C21A5",
      "#158c86",
      "#AAAAAA"
    },
    brights = {
      "#555555",
      "#CC3E28",
      "#216609",
      "#B58900",
      "#1E6FCC",
      "#5C21A5",
      "#158c86",
      "#AAAAAA"
    },

    -- Arbitrary colors of the palette in the range from 16 to 255
    indexed = { [136] = "#F2EEDE" },

    -- Since: 20220319-142410-0fcdea07
    -- When the IME, a dead key or a leader key are being processed and are effectively
    -- holding input pending the result of input composition, change the cursor
    -- to this color to give a visual cue about the compose state.
    compose_cursor = "#B58900"
  }
end

return module
