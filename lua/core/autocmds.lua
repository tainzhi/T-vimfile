-- -- uncomment this if you want to open nvim with a dir
-- vim.cmd [[ autocmd BufEnter * if &buftype != "terminal" | lcd %:p:h | endif ]]

-- Use relative & absolute line numbers in 'n' & 'i' modes respectively
vim.cmd[[ au InsertEnter * set norelativenumber ]]

-- Don't show any numbers inside terminals
vim.cmd [[ au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal ]]

-- Don't show status line on certain windows
vim.cmd [[ autocmd BufEnter,BufWinEnter,FileType,WinEnter * lua require("core.utils").hide_statusline() ]]

-- Open a file from its last left off position
vim.cmd [[ au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]

-- File extension specific tabbing
vim.cmd [[ autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 ]]

vim.api.nvim_exec([[
    function! ResizeSurfingkeysWindow()
        setlocal filetype=idart
        setlocal guifont=Consolas:h16
        setlocal lines=40 columns=120
    endfunction
    au BufEnter surfingkeys://* call ResizeSurfingkeysWindow()
]], false)


-- open help in vertical split
vim.cmd [[ autocmd BufWinEnter *.txt if &ft == 'help' | wincmd L | vertical resize 90 | nmap q :q<CR> | endif ]]