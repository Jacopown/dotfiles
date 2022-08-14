local colorscheme = "nord"

local colorscheme_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not colorscheme_ok then
	vim.notify("There was a problem while requiring colorscheme")
end
