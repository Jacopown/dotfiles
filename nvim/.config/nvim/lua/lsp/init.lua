local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
    vim.notify('There was a problem while loading lspconfig plugin')
	return
end

require("lsp.lsp-installer")
require("lsp.handlers").setup()
