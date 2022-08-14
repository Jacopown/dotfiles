local colorizer_ok, colorizer = pcall(require, "colorizer")
if not colorizer_ok then
	vim.notify("There was a problem while requiring colorizer plugin")
end

colorizer.setup()
