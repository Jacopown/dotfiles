local autopairs_ok, npairs = pcall(require, "nvim-autopairs")
if not autopairs_ok then
	vim.notify("There was a problem while requiring autopairs plugin")
end

local rule_ok, Rule = pcall(require, "nvim-autopairs.rule")
if not rule_ok then
  vim.notify("There was a problem while requiring autopair rules")
end

npairs.setup({
	check_ts = true, -- treesitter integration
	disable_filetype = { "TelescopePrompt" },
	fast_wrap = {
		map = "<C-e>",
	},
})

npairs.add_rules({
	Rule(" ", " "):with_pair(function(opts)
		local pair = opts.line:sub(opts.col - 1, opts.col)
		return vim.tbl_contains({ "()", "[]", "{}" }, pair)
	end),
})
