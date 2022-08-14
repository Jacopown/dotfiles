local project_ok, project = pcall(require, "project_nvim")
if not project_ok then
	vim.notify("There was a problem while requiring project plugin")
end
project.setup({

	-- detection_methods = { "lsp", "pattern" }, -- NOTE: lsp detection will get annoying with multiple langs in one project
	detection_methods = { "pattern" },

	-- patterns used to detect root dir, when **"pattern"** is in detection_methods
	patterns = { ".git", "Makefile" },
})
