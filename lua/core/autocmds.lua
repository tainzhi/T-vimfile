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

if vim.g.vscode then
   -- for vscode noevim
   local default_im_select
   local default_im_select_zh
   local default_command
   -- Can be binary's name or binary's full path,
   -- e.g. 'im-select' or '/usr/local/bin/im-select'
   -- For Windows/WSL, default: "C:\\Progra~1\\im-select.exe" 即在 C:\\program files目录下
   -- For macOS, default: "im-select"
   if jit.os == "Windows" then
      default_command = 'D:\\Applications\\im-select.exe'
      default_im_select = '1033'
      default_im_select_zh = '2052'
   elseif jit.os == "Linux" then
      default_command = "/bin/ibus"
      default_im_select = "engine xkb:us::eng"
   elseif jit.os == "OSX" then
      default_command = 'im-select'
      default_im_select = 'com.apple.keylayout.ABC'
   end
   -- normal mode, switch to english
   vim.api.nvim_create_autocmd({ "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" }, {
      pattern = "*",
      callback = function()
         -- vim.fn.jobstart({"c:\\im-select.exe", "1033"})
         vim.fn.jobstart(default_command .. " " .. default_im_select)
      end,
   })
   -- insert mode, switch to chinese
   vim.api.nvim_create_autocmd({"InsertEnter"}, {
      pattern = "*",
      callback = function()
         -- vim.fn.jobstart({"c:\\im-select.exe", "2052"})
         vim.fn.jobstart(default_command .. " " .. default_im_select_zh)
      end,
   })
end

-- 不启用，因为某些情况下会导致打开nvim时卡住，不响应任何按键
-- -- 关闭一些选项，加快打开大文件
-- -- https://vim.fandom.com/wiki/Faster_loading_of_large_files
-- local maxSize = 20 * 1024 * 1024
-- vim.cmd [[
--     let g:LargeFile = 1024 * 1024 * 10
--     function! LargeFile()
--         set nobackup noswapfile noundofile
--         " no syntax highlighting etc
--         " set eventignore+=FileType
--         " save memory when other file is viewed
--         setlocal bufhidden=unload
--         " no undo possible
--         setlocal undolevels=-1
--         " display message
--         autocmd VimEnter *  echo "The file is larger than " . (g:LargeFile / 1024 / 1024) .  "MB, so some options are changed (see .vimrc for details)."
--     endfunction
-- ]]
-- vim.cmd[[augroup LargeFile]]
-- vim.cmd[[  autocmd!]]
-- vim.cmd[[  autocmd BufReadPre * if (getfsize(expand("<afile>:p")) > g:LargeFile) | call LargeFile() | endif ]]
-- vim.cmd[[augroup END]]