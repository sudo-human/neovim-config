vim.g.adwaita_mode = "dark"
vim.g.gruvbox_underline = false

vim.cmd [[
try
  colorscheme gruvbox
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]

