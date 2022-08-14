local bufferline_ok, bufferline = pcall(require, "bufferline")
if not bufferline_ok then
	vim.notify("There was a problem while requiring bufferline plugin")
end

bufferline.setup({
	options = {
		mode = "buffers",
		close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
		right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
		offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "center", padding = 1 } },
		separator_style = "thin", -- | "thick" | "thin" | { 'any', 'any' },
		diagnostics = "nvim_lsp",
	},
})
