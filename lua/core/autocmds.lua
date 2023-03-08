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

-- 关闭一些选项，加快打开大文件
-- https://vim.fandom.com/wiki/Faster_loading_of_large_files
local maxSize = 20 * 1024 * 1024
vim.cmd [[
    let g:LargeFile = 1024 * 1024 * 10
    function! LargeFile()
        set nobackup noswapfile noundofile
        " no syntax highlighting etc
        " set eventignore+=FileType
        " save memory when other file is viewed
        setlocal bufhidden=unload
        " no undo possible
        setlocal undolevels=-1
        " display message
        autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / 1024 / 1024) .  "MB, so some options are changed (see .vimrc for details)."
    endfunction
]]
vim.cmd[[augroup LargeFile]]
vim.cmd[[  autocmd!]]
vim.cmd[[  autocmd BufReadPre * if (getfsize(expand("<afile>:p")) > g:LargeFile) | call LargeFile() | endif ]]
vim.cmd[[augroup END]]