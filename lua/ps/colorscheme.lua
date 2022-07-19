-- vim.g.adwaita_mode = "dark"
-- vim.g.gruvbox_underline = false
-- vim.g.gruvbox_italic = true
-- vim.g.gruvbox_transparent_bg = true
-- vim.g.gruvbox_sign_column = "bg0"
-- vim.g.gruvbox_improved_strings = true
-- vim.g.gruvbox_contrast_dark = "hard"
vim.g.tokyonight_style = "night"
local colors = require("tokyonight.colors").setup({})

vim.cmd [[
try
  colorscheme tokyonight
catch /^vim\%((\a\+)\)\=:e185/
  colorscheme default
  set background=dark
endtry
]]

vim.cmd("hi cursorline guibg=" .. colors.bg_dark .. " guifg=none")
