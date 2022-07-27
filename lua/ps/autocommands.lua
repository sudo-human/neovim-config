local _general_settings = vim.api.nvim_create_augroup("_general_settings")

vim.api.nvim_create_autocmd("FileType", {
  group = _general_settings,
  pattern = { "qf", "help", "man", "lspinfo" },
  callback = function ()
    vim.keymap.set("n", "q", ":close<cr>", { buffer = 0 })
  end
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = _general_settings,
  callback = function ()
    require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
  end
})

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("_git_and_markdown"),
  pattern = "gitcommit, markdown",
  callback = function ()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end
})

-- vim.cmd([[
--   augroup _general_settings
--     autocmd!
--     autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR> 
--     autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200}) 
--     autocmd BufWinEnter * :set formatoptions-=cro
--     autocmd FileType qf set nobuflisted
--   augroup end
--   augroup _git
--     autocmd!
--     autocmd FileType gitcommit setlocal wrap
--     autocmd FileType gitcommit setlocal spell
--   augroup end
--   augroup _markdown
--     autocmd!
--     autocmd FileType markdown setlocal wrap
--     autocmd FileType markdown setlocal spell
--   augroup end
--   augroup _auto_resize
--     autocmd!
--     autocmd VimResized * tabdo wincmd = 
--   augroup end
-- ]])

-- Autoformat
-- augroup _lsp
--   autocmd!
--   autocmd BufWritePre * lua vim.lsp.buf.formatting()
-- augroup end

--  Alpha
--  augroup _alpha
--    autocmd!
--    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
--  augroup end
