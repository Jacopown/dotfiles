local telescope_ok, telescope = pcall(require, "telescope")
if not telescope_ok then
	vim.notify("There was a problem while requiring telescope plugin")
end

local telescope_actions_ok, actions = pcall(require, "telescope.actions")
if not telescope_actions_ok then
	vim.notify("There was a problem while requiring telescope.actions plugin")
end

telescope.setup({
	defaults = {
		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },
		file_ignore_patterns = { ".git/", "node_modules" },

		mappings = {
			i = {
				["<Down>"] = actions.cycle_history_next,
				["<Up>"] = actions.cycle_history_prev,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
})

telescope.load_extension("fzf")
telescope.load_extension("projects")
