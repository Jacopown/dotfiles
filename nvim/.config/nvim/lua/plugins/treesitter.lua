local treesitter_status_ok, treesitter = pcall(require, "nvim-treesitter.configs")
if not treesitter_status_ok then
    vim.notify('There was a problem while loading treesitter plugin')
  return
end

treesitter.setup {
    ensure_installed = "maintained",
    sync_install = false,
    ignore_install = { "" }, -- List of parsers to ignore installing
    highlight = {
        enable = true, -- false will disable the whole extension
        disable = { "" }, -- list of language that will be disabled
        additional_vim_regex_highlighting = false,
        autopairs = {
            enable = true,
        },
    },
    indent = { enable = true, disable = { "python" } },
    rainbow = {
        enable = true,
        disable = { "" },
        extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
        max_file_lines = nil, -- Do not enable for files with more than n lines, int
        -- colors = {}, -- table of hex strings
        -- termcolors = {} -- table of colour name strings
        context_commentstring = {
            enable = true,
            enable_autocmd = false,
        },
    }
}
