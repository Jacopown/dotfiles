local telescope_status_ok, telescope = pcall(require, 'telescope')
if not telescope_status_ok then
    vim.notify('There was a problem while loading telescope plugin')
    return
end

local actions = require 'telescope.actions'

telescope.setup{
    defaults = {
        -- Default configuration for telescope goes here:
        prompt_prefix = ' ',
        selection_caret = ' ',
        entry_prefix = ' ', -- TODO choose an icon for each entry excluded the selected one
        path_display = { 'smart' },
        dynamic_preview_title = true, -- TODO test look of preview window title with and without
        mappings = {
            i = {
                ['<C-n>'] = 'cycle_history_next',
                ['<C-p>'] = 'cycle_history_prev',

                ['<C-j>'] = 'move_selection_next',
                ['<C-k>'] = 'move_selection_previous',

                ['<C-c>'] = 'close',

                ['<Down>'] = 'move_selection_next',
                ['<Up>'] = 'move_selection_previous',

                ['<CR>'] = 'select_default',
                ['<C-x>'] = 'select_horizontal',
                ['<C-v>'] = 'select_vertical',
                ['<C-t>'] = 'select_tab',

                ['<C-u>'] = 'preview_scrolling_up',
                ['<C-d>'] = 'preview_scrolling_down',

                ['<PageUp>'] = 'results_scrolling_up',
                ['<PageDown>'] = 'results_scrolling_down',

                ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
                ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
                ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
                ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,
                ['<C-l>'] = 'complete_tag',
                ['<C-_>'] = 'which_key', -- keys from pressing <C-/>
            },
            n = {
                ['<esc>'] = 'close',
                ['<CR>'] = 'select_default',
                ['<C-x>'] = 'select_horizontal',
                ['<C-v>'] = 'select_vertical',
                ['<C-t>'] = 'select_tab',

                ['<Tab>'] = actions.toggle_selection + actions.move_selection_worse,
                ['<S-Tab>'] = actions.toggle_selection + actions.move_selection_better,
                ['<C-q>'] = actions.send_to_qflist + actions.open_qflist,
                ['<M-q>'] = actions.send_selected_to_qflist + actions.open_qflist,

                ['j'] = 'move_selection_next',
                ['k'] = 'move_selection_previous',
                ['H'] = 'move_to_top',
                ['M'] = 'move_to_middle',
                ['L'] = 'move_to_bottom',

                ['<Down>'] = 'move_selection_next',
                ['<Up>'] = 'move_selection_previous',
                ['gg'] = 'move_to_top',
                ['G'] = 'move_to_bottom',

                ['<C-u>'] = 'preview_scrolling_up',
                ['<C-d>'] = 'preview_scrolling_down',

                ['<PageUp>'] = 'results_scrolling_up',
                ['<PageDown>'] = 'results_scrolling_down',

                ['?'] = 'which_key',
            }
        } },
    pickers = {
        -- Default configuration for builtin pickers goes here:
        -- picker_name = {
        --   picker_config_key = value,
        --   ...
        -- }
        -- Now the picker_config_key will be applied every time you call this
        -- builtin picker
    },
    extensions = {
        fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = 'smart_case',        -- or 'ignore_case' or 'respect_case'
        }
    }
}
telescope.load_extension('fzf')
telescope.load_extension('file_browser')
