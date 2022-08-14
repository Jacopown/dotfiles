local lspconfig_ok, _ = pcall(require, "lspconfig")
if not lspconfig_ok then
  vim.notify("There was a problem while requiring lspconfig plugin")
end

require "lsp.lsp-installer"
require("lsp.handlers").setup()
require "lsp.null-ls"
