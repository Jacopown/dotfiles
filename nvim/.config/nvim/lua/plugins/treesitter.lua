local treesitter_ok, configs = pcall(require, "nvim-treesitter.configs")
if not treesitter_ok then
	vim.notify("There was a problem while requiring treesitter plugin")
end

configs.setup({
	ensure_installed = "all", -- one of "all" or a list of languages
	ignore_install = { "" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "css" }, -- list of language that will be disabled
	},
	indent = { enable = true, disable = { "python", "css" } },
	context_commentstring = { enable = true, enable_autocmd = false },
})
