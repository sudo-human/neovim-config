require("ps.lsp.handlers").setup()
require("ps.lsp.null-ls")
require("ps.lsp.mason_lspconfig")


local nlspsettings_status, nlspsettings = pcall(require, "nlspsettings")
if not nlspsettings_status then
	return
end

nlspsettings.setup({
	config_home = vim.fn.stdpath("config") .. "/nlsp-settings",
	local_settings_root_markers = { ".git" },
	jsonls_append_default_schemas = true,
})
