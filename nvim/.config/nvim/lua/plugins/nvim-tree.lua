local nvimtree_ok, nvim_tree = pcall(require, "nvim-tree")
if not nvimtree_ok then
	vim.notify("There was a problem while requiring nvim-tree plugin")
end

nvim_tree.setup({
	update_focused_file = {
		enable = true,
		update_cwd = true,
	},
	view = {
		width = 30,
		height = 30,
		side = "left",
		mappings = {
			custom_only = false,
			list = {
				{ key = "l", action = "edit", action_cb = edit_or_open },
				{ key = "h", action = "close_node" },
				{ key = "v", action = "vsplit_preview", action_cb = vsplit_preview },
			},
		},
	},
	actions = {
		open_file = {
			quit_on_open = false,
		},
	},
	diagnostics = {
		enable = true,
	},
})
