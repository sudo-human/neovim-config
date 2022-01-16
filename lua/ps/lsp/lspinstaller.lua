local lsp_installer_status, lsp_installer = pcall(require, "nvim-lsp-installer")
if not lsp_installer_status then return end

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = require("ps.lsp.handlers").on_attach,
    capabilities = require("ps.lsp.handlers").capabilities,
  }
  -- (optional) Customize the options passed to the server
  -- if server.name == "tsserver" then
  --     opts.root_dir = function() ... end
  -- end
  if server.name then
    local settings_exists, server_opts = pcall(require, "ps.lsp.settings." .. server.name)
    if settings_exists then opts = vim.tbl_deep_extend("force", server_opts, opts) end
  end

  -- This setup() function is exactly the same as lspconfig's setup function.
  -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
  server:setup(opts)
end)
