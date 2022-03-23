local alpha_status_ok, alpha = pcall(require, "alpha")
if not alpha_status_ok then
    vim.notify('There was a problem while loading alpha plugin')
    return
end

local plugins_number = #vim.tbl_keys(packer_plugins)
local datetime = os.date(" %A %d %B %Y")
local plugins_string = ' ' .. plugins_number .. ' Plugins Loaded'

local header = {
    type = "text",
    val = {
            "   ⣴⣶⣤⡤⠦⣤⣀⣤⠆     ⣈⣭⣿⣶⣿⣦⣼⣆          ",
            "    ⠉⠻⢿⣿⠿⣿⣿⣶⣦⠤⠄⡠⢾⣿⣿⡿⠋⠉⠉⠻⣿⣿⡛⣦       ",
            "          ⠈⢿⣿⣟⠦ ⣾⣿⣿⣷    ⠻⠿⢿⣿⣧⣄     ",
            "           ⣸⣿⣿⢧ ⢻⠻⣿⣿⣷⣄⣀⠄⠢⣀⡀⠈⠙⠿⠄    ",
            "          ⢠⣿⣿⣿⠈    ⣻⣿⣿⣿⣿⣿⣿⣿⣛⣳⣤⣀⣀   ",
            "   ⢠⣧⣶⣥⡤⢄ ⣸⣿⣿⠘  ⢀⣴⣿⣿⡿⠛⣿⣿⣧⠈⢿⠿⠟⠛⠻⠿⠄  ",
            "  ⣰⣿⣿⠛⠻⣿⣿⡦⢹⣿⣷   ⢊⣿⣿⡏  ⢸⣿⣿⡇ ⢀⣠⣄⣾⠄   ",
            " ⣠⣿⠿⠛ ⢀⣿⣿⣷⠘⢿⣿⣦⡀ ⢸⢿⣿⣿⣄ ⣸⣿⣿⡇⣪⣿⡿⠿⣿⣷⡄  ",
            " ⠙⠃   ⣼⣿⡟  ⠈⠻⣿⣿⣦⣌⡇⠻⣿⣿⣷⣿⣿⣿ ⣿⣿⡇ ⠛⠻⢷⣄ ",
            "      ⢻⣿⣿⣄   ⠈⠻⣿⣿⣿⣷⣿⣿⣿⣿⣿⡟ ⠫⢿⣿⡆     ",
            "       ⠻⣿⣿⣿⣿⣶⣶⣾⣿⣿⣿⣿⣿⣿⣿⣿⡟⢀⣀⣤⣾⡿⠃     ",
    },
    opts = {
        position = "center",
        hl = "Type",
    },
}

local date_time = {
    type = "text",
    val = {datetime},
    opts = {
        position = 'center',
        hl = 'Number',
    },
}

local plugins = {
    type = "text",
    val = {plugins_string},
    opts = {
        position = 'center',
        hl = 'Number',
    },
}

local function button(sc, txt, keybind)
    local sc_ = sc:gsub("%s", ""):gsub("SPC", "<leader>")

    local opts = {
        position = "center",
        text = txt,
        shortcut = sc,
        cursor = 5,
        width = 70,
        align_shortcut = "right",
        hl_shortcut = "Keyword",
    }

    if keybind then
        opts.keymap = { "n", sc_, keybind, { noremap = true, silent = true } }
    end

   return {
      type = "button",
      val = txt,
      on_press = function()
         local key = vim.api.nvim_replace_termcodes(sc_, true, false, true)
         vim.api.nvim_feedkeys(key, "normal", false)
      end,
      opts = opts,
   }
end

local buttons = {
    type = "group",
    val = {
        button("fh", "  Recently opened files", ":Telescope oldfiles<CR>"),
        button("ff", "  Find file", ":Telescope file_browser<CR>"),
        button("N", "  New file", "<cmd>ene <CR>"),
        button("fg", "  Find text", ":Telescope live_grep<CR>"),
        button("fm", "  Jump to bookmarks", ":Telescope marks<CR>"),
        button( "U", "ﲗ Update plugins" , ":PackerSync<CR>"),
        button("Q", "  Quit", ":qa<CR>"),
    },
    opts = {
        spacing = 1,
    },
}

local footer = {
    type = "text",
    val = require'alpha.fortune'(),
    opts = {
        position = "center",
        hl = "Number",
    },
}

local section = {
    header = header,
    buttons = buttons,
    footer = footer,
    datetime = date_time,
    plugins = plugins,
}

alpha.setup {
    layout = {
        { type = "padding", val = 5 },
        section.header,
        { type = "padding", val = 2 },
        section.datetime,
        section.plugins,
        { type = "padding", val = 2 },
        section.buttons,
        section.footer,
    },
    opts = {},
}
