local get_hex = require('cokeline/utils').get_hex
local mappings = require('cokeline/mappings')

local comments_fg = get_hex('Comment', 'fg')
local errors_fg = get_hex('DiagnosticError', 'fg')
local warnings_fg = get_hex('DiagnosticWarn', 'fg')

local red = vim.g.terminal_color_1
local yellow = vim.g.terminal_color_3

local catppuccin, cat_colors = pcall(require,"catppuccin.api.colors")
if not catppuccin then
  return
end

local clrs = cat_colors.get_colors()

-- settings
local sett = {
	bkg = clrs.black3,
	diffs = clrs.mauve,
	extras = clrs.gray1,
	curr_file = clrs.maroon,
	curr_dir = clrs.flamingo,
}

local components = {
  space = {
    text = ' ',
    truncation = { priority = 1 }
  },

  two_spaces = {
    text = '  ',
    truncation = { priority = 1 },
  },

  separator = {
    text = function(buffer)
      return buffer.index ~= 1 and '▏' or ''
    end,
    truncation = { priority = 1 }
  },

  devicon = {
    text = function(buffer)
      return
        (mappings.is_picking_focus() or mappings.is_picking_close())
          and buffer.pick_letter .. ' '
           or buffer.devicon.icon
    end,
    hl = {
      fg = function(buffer)
        return
          (mappings.is_picking_focus() and clrs.yellow)
          or (mappings.is_picking_close() and clrs.red)
          or buffer.devicon.color
      end,
      style = function(_)
        return
          (mappings.is_picking_focus() or mappings.is_picking_close())
          and 'italic,bold'
           or nil
      end,
    },
    truncation = { priority = 1 }
  },

  index = {
    text = function(buffer)
      return buffer.index .. ': '
    end,
    truncation = { priority = 1 }
  },

  unique_prefix = {
    text = function(buffer)
      return buffer.unique_prefix
    end,
    hl = {
      fg = comments_fg,
      style = 'italic',
    },
    truncation = {
      priority = 3,
      direction = 'left',
    },
  },

  filename = {
    text = function(buffer)
      return buffer.filename
    end,
    hl = {
      style = function(buffer)
        return
          ((buffer.is_focused and buffer.diagnostics.errors ~= 0)
            and 'bold,underline')
          or (buffer.is_focused and 'bold')
          or (buffer.diagnostics.errors ~= 0 and 'underline')
          or nil
      end
    },
    truncation = {
      priority = 2,
      direction = 'left',
    },
  },

  diagnostics = {
    text = function(buffer)
      return
        (buffer.diagnostics.errors ~= 0 and '  ' .. buffer.diagnostics.errors)
        or (buffer.diagnostics.warnings ~= 0 and '  ' .. buffer.diagnostics.warnings)
        or ''
    end,
    hl = {
      fg = function(buffer)
        return
          (buffer.diagnostics.errors ~= 0 and errors_fg)
          or (buffer.diagnostics.warnings ~= 0 and warnings_fg)
          or nil
      end,
    },
    truncation = { priority = 1 },
  },

  close_or_unsaved = {
    text = function(buffer)
      return buffer.is_modified and '●' or ''
    end,
    hl = {
      fg = function(buffer)
        return buffer.is_modified and clrs.green or nil
      end
    },
    delete_buffer_on_left_click = true,
    truncation = { priority = 1 },
  },
}

require('cokeline').setup({
  buffers = {
    -- filter_valid = function(buffer) return buffer.type ~= 'terminal' end,
    -- filter_visible = function(buffer) return buffer.type ~= 'terminal' end,
    new_buffers_position = 'next',
  },

  rendering = {
    max_buffer_width = 30,
  },

  default_hl = {
    focused = {
      fg = clrs.rosewater,
      bg = sett.bkg,
    },
    unfocused = {
      fg = sett.extras,
      bg = sett.bkg,
    },
  },

  components = {
    components.space,
    components.separator,
    components.space,
    components.devicon,
    components.space,
    components.index,
    components.unique_prefix,
    components.filename,
    components.diagnostics,
    components.two_spaces,
    components.close_or_unsaved,
    components.space,
  },
})
