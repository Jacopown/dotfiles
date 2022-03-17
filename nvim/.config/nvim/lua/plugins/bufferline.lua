local bufferline_status_ok, bufferline = pcall(require, 'bufferline')
if not bufferline_status_ok then
    vim.notify('There was a problem while loading bufferline plugin')
    return
end

bufferline.setup{
    options = {
        numbers = function(opts)
            return string.format('%s', opts.id)
        end,
        separator_style = 'slant',
        offsets = {
            {
                filetype = 'NvimTree',
                text = 'File Explorer',
                highlight = 'Directory',
                text_align = 'left'
            },
        }
    }
}
