local status_ok, npairs = pcall(require, "nvim-autopairs")
if not status_ok then
  return
end

local rule_status_ok, Rule = pcall(require, "nvim-autopairs.rule")
if not rule_status_ok then
  return
end


npairs.setup {
  check_ts = true, -- treesitter integration
  disable_filetype = { "TelescopePrompt" },
  fast_wrap = {
    map = '<C-e>',
  },
}

npairs.add_rules {
  Rule(' ', ' ')
    :with_pair(function (opts)
      local pair = opts.line:sub(opts.col - 1, opts.col)
      return vim.tbl_contains({ '()', '[]', '{}', '""',"''" }, pair)
    end),
}
