local status, lualine = pcall(require, "lualine")
if not status then return end

local gps_status, gps = pcall(require, "nvim-gps")
local c = {}

if gps_status then
  c = {
    { gps.get_location, cond = gps.is_available }
  }
end

lualine.setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = c,
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}

vim.api.nvim_exec(
    [[
function! DisableST()
  return " "
endfunction
au BufEnter NvimTree setlocal statusline=%!DisableST()
]],
    false
)
