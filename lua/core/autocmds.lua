-- -- uncomment this if you want to open nvim with a dir
-- vim.cmd [[ autocmd BufEnter * if &buftype != "terminal" | lcd %:p:h | endif ]]

-- Use relative & absolute line numbers in 'n' & 'i' modes respectively
vim.cmd[[ au InsertEnter * set norelativenumber ]]

-- Don't show any numbers inside terminals
vim.cmd [[ au TermOpen term://* setlocal nonumber norelativenumber | setfiletype terminal ]]

-- -- Don't show status line on certain windows
-- vim.cmd [[ autocmd BufEnter,BufWinEnter,FileType,WinEnter * lua require("core.utils").hide_statusline() ]]

-- Open a file from its last left off position
vim.cmd [[ au BufReadPost * if expand('%:p') !~# '\m/\.git/' && line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]

-- File extension specific tabbing
vim.cmd [[ autocmd Filetype python setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4 ]]

-- open help in vertical split
vim.cmd [[ autocmd BufWinEnter *.txt if &ft == 'help' | wincmd L | vertical resize 100 | nmap q :q<CR> | endif ]]

vim.cmd [[ autocmd BufWritePre *.md if &ft == 'markdown' | PanguAll]]
vim.cmd [[ autocmd BufWinEnter *.md if &ft == 'markdown' | set shada="NONE"]]

-- for chrome plugin firenvim
-- https://github.com/glacambre/firenvim/issues/800
-- 暂时不会把vim script转为 lua, 先这样实现
vim.cmd [[ au BufEnter idart.mot.com_*.txt set filetype=idart lines=30 ]]
vim.cmd [[ au BufEnter github.com_*.txt set filetype=markdown lines=30 ]]