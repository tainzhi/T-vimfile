-- CHADTree configuration for lazy.nvim
-- See https://github.com/ms-jpq/chadtree#setup for more options
return function()

    vim.g.chadtree_settings = {
      view = {
        width = 35,
        window_options = {
            number = true,
            relativenumber = true,
            signcolumn = 'no',
        }
      },
      theme = {
        text_colour_set = 'nerdtree_syntax_dark',
      },
    }

    -- Example keymap: open CHADTree with <leader>e
    vim.keymap.set('n', '<leader>e', ':CHADopen<CR>', { desc = 'Open CHADTree' })
end