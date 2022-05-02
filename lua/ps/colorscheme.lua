vim.g.adwaita_mode = "dark"
vim.g.gruvbox_underline = false
vim.g.gruvbox_italic = true
-- vim.g.gruvbox_transparent_bg = true
vim.g.gruvbox_sign_column = "bg0"
-- vim.g.gruvbox_improved_strings = true

vim.cmd [[
try
  colorscheme gruvbox
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]

