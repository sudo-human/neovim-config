-- vim.g.adwaita_mode = "dark"
-- vim.g.gruvbox_underline = false
-- vim.g.gruvbox_italic = true
-- vim.g.gruvbox_transparent_bg = true
-- vim.g.gruvbox_sign_column = "bg0"
-- vim.g.gruvbox_improved_strings = true
-- vim.g.gruvbox_contrast_dark = "hard"
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_keywords = false
local colors = require("tokyonight.colors").setup({
	style = "night",
})
local util = require("tokyonight.util")

vim.cmd([[
try
  colorscheme tokyonight
catch /^vim\%((\a\+)\)\=:e185/
  colorscheme default
  set background=dark
endtry
]])

vim.api.nvim_set_hl(0, "CursorLine", { bg = util.brighten(colors.bg, 0.02) })
