local cmd = vim.cmd

local colorscheme = 'gruvbox'

local status_ok, _ = pcall(vim.cmd, 'colorscheme ' .. colorscheme)
if not status_ok then
  vim.notify('colorscheme ' .. colorscheme .. ' not found!')
  return
end

-- gray
cmd 'highlight! CmpItemAbbrDeprecated guibg=NONE gui=strikethrough guifg=#808080'
-- blue
cmd 'highlight! CmpItemAbbrMatch guibg=NONE guifg=#569CD6'
cmd 'highlight! CmpItemAbbrMatchFuzzy guibg=NONE guifg=#569CD6'
-- light blue
cmd 'highlight! CmpItemKindVariable guibg=NONE guifg=#9CDCFE'
cmd 'highlight! CmpItemKindInterface guibg=NONE guifg=#9CDCFE'
cmd 'highlight! CmpItemKindText guibg=NONE guifg=#9CDCFE'
-- pink
cmd 'highlight! CmpItemKindFunction guibg=NONE guifg=#C586C0'
cmd 'highlight! CmpItemKindMethod guibg=NONE guifg=#C586C0'
-- front
cmd 'highlight! CmpItemKindKeyword guibg=NONE guifg=#D4D4D4'
cmd 'highlight! CmpItemKindProperty guibg=NONE guifg=#D4D4D4'
cmd 'highlight! CmpItemKindUnit guibg=NONE guifg=#D4D4D4'
