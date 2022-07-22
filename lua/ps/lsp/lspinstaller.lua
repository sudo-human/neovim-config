local lsp_installer_status, lsp_installer = pcall(require, "nvim-lsp-installer")
if not lsp_installer_status then
	return
end

local nlspsettings_status, nlspsettings = pcall(require, "nlspsettings")
if not nlspsettings_status then
	return
end

local lspconfig_status, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status then
	return
end

nlspsettings.setup({
	config_home = vim.fn.stdpath("config") .. "/nlsp-settings",
	local_settings_root_markers = { ".git" },
	jsonls_append_default_schemas = true,
})

-- Register a handler that will be called for all installed servers.
-- Alternatively, you may also register handlers on specific server instances instead (see example below).
-- lsp_installer.on_server_ready(function(server)
--   local opts = {
--     on_attach = require("ps.lsp.handlers").on_attach,
--     capabilities = require("ps.lsp.handlers").capabilities,
--   }
--   -- (optional) Customize the options passed to the server
--   -- if server.name == "tsserver" then
--   --     opts.root_dir = function() ... end
--   -- end
--   if server.name then
--     local settings_exists, server_opts = pcall(require, "ps.lsp.settings." .. server.name)
--     if settings_exists then opts = vim.tbl_deep_extend("force", server_opts, opts) end
--   end
--
--   -- This setup() function is exactly the same as lspconfig's setup function.
--   -- Refer to https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
--   server:setup(opts)
-- end)

lsp_installer.setup({})

lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
	on_attach = require("ps.lsp.handlers").on_attach,
	capabilities = require("ps.lsp.handlers").capabilities,
})

lspconfig.sumneko_lua.setup({
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			workspace = {
				library = {
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
					[vim.fn.stdpath("config") .. "/lua"] = true,
				},
			},
		},
	},
})

lspconfig.pyright.setup({})
lspconfig.tsserver.setup({})
lspconfig.clangd.setup({})
lspconfig.jsonls.setup({})
lspconfig.rust_analyzer.setup({})
