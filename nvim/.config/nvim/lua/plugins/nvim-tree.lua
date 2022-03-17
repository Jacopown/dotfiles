local nvimtree_status_ok, nvimtree = pcall(require, 'nvim-tree')
if not nvimtree_status_ok then
    vim.notify('There was a problem while loading nvimtree plugin')
    return
end

local g = vim.g

g.nvim_tree_auto_ignore_ft = { "dashboard" } -- Don't open tree on specific filetypes.
g.nvim_tree_indent_markers = 1 -- This option shows indent markers when folders are open.
g.nvim_tree_git_hl = 1 -- Will enable file highlight for git attributes (can be used without the icons).
g.nvim_tree_highlight_opened_files = 1 -- Will enable folder and file icon highlight for opened files/directories.

nvimtree.setup{
    disable_netrw        = false,
    hijack_netrw         = true,
    open_on_setup        = false,
    ignore_buffer_on_setup = false,
    ignore_ft_on_setup   = {},
    auto_close           = false,
    auto_reload_on_write = true,
    open_on_tab          = false,
    hijack_cursor        = false,
    update_cwd           = false,
    hijack_unnamed_buffer_when_opening = false,
    hijack_directories   = {
        enable = true,
        auto_open = true,
    },
    diagnostics = {
        enable = false,
        icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
        }
    },
    update_focused_file = {
        enable      = false,
        update_cwd  = false,
        ignore_list = {}
    },
    system_open = {
        cmd  = nil,
        args = {}
    },
    filters = {
        dotfiles = false,
        custom = {}
    },
    git = {
        enable = true,
        ignore = true,
        timeout = 500,
    },
    view = {
        width = 30,
        height = 30,
        hide_root_folder = false,
        side = 'right',
        preserve_window_proportions = false,
        mappings = {
        custom_only = false,
        list = {}
        },
        number = false,
        relativenumber = false,
        signcolumn = "yes"
    },
    trash = {
        cmd = "trash",
        require_confirm = true
    },
    actions = {
        change_dir = {
        enable = true,
        global = false,
        },
        open_file = {
        quit_on_open = false,
        resize_window = false,
        window_picker = {
            enable = true,
            chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
            exclude = {
            filetype = { "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame", },
            buftype  = { "nofile", "terminal", "help", },
            }
        }
        }
    },
    log = {
        enable = false,
        types = {
        all = false,
        config = false,
        git = false,
        },
    },
} 
