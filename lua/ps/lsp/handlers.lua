local M = {}

M.setup = function()
  local signs = {
    { name = "DiagnosticSignError", text = "" },
    { name = "DiagnosticSignWarn", text = "" },
    { name = "DiagnosticSignHint", text = "" },
    { name = "DiagnosticSignInfo", text = "" },
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
  end
  vim.diagnostic.config{
    virtual_text = false,
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    signs = {
      active = signs,
    },
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
    },
  }
end

local function lsp_highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.server_capabilities.documentHighlightProvider then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

local function lsp_keymaps(bufnr)
  local opts = { noremap = true, silent = true , buffer = bufnr}
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
  vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
  vim.keymap.set("n", "<leader>lR", vim.lsp.buf.rename, opts)
  -- vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, opts)
  vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, opts)
  -- vim.keymap.set("n", "<leader>f", vim.diagnostic.open_float, opts)
  vim.keymap.set("n", "[d", function() vim.diagnostic.goto_prev({ border = "rounded" }) end, opts)
  vim.keymap.set("n", "gl", function () vim.diagnostic.open_float(0, {scope="line", border = "rounded" }) end, opts)
  vim.keymap.set("n", "]d", function () vim.diagnostic.goto_next({ border = "rounded" }) end, opts)
  vim.keymap.set("n", "<leader>lq", vim.diagnostic.setloclist, opts)
  vim.keymap.set("n", "<leader>lf", vim.lsp.buf.formatting, opts)
  vim.keymap.set("n", "<leader>li", "<cmd>LspInfo<CR>", opts)
  vim.keymap.set("n", "<leader>lI", "<cmd>LspInstallInfo<CR>", opts)
  -- vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

M.on_attach = function(client, bufnr)
  lsp_keymaps(bufnr)
  lsp_highlight_document(client)
  require("aerial").on_attach(client, bufnr)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
