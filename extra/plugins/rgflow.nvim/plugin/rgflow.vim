" nvim-rgflow.lua Plugin
" TODO check :h <f-args> maybe usefull for command history
"
" Testing variable ensures the module and settings are reloaded when ever
" the affected files are sourced.
let testing = 0

" When not testing, dont use cached setup
if exists('g:loaded_rgflow') && !testing
    finish
endif

" HILIGHTING GROUPS
if !hlexists('RgFlowQfPattern') || testing
    " Recommend not setting a BG so it uses the current lines BG:
    hi RgFlowQfPattern    guifg=#A0FFA0 guibg=none gui=bold ctermfg=15 ctermbg=none cterm=bold
endif
if !hlexists('RgFlowHead') || testing
    hi RgFlowHead         guifg=white   guibg=black gui=bold ctermfg=15 ctermbg=0, cterm=bold
endif
if !hlexists('RgFlowHeadLine') || testing
    hi RgFlowHeadLine     guifg=#00CC00 guibg=black gui=bold ctermfg=15 ctermbg=0, cterm=bold
endif
if !hlexists('RgFlowInputBg') || testing
    " Even though just a background, add the foreground or else when
    " appending cant see the insert cursor
    hi RgFlowInputBg      guifg=black   guibg=#e0e0e0 ctermfg=0 ctermbg=254
endif
if !hlexists('RgFlowInputFlags') || testing
    hi RgFlowInputFlags   guifg=gray    guibg=#e0e0e0 ctermfg=8 ctermbg=254
endif
if !hlexists('RgFlowInputPattern') || testing
    hi RgFlowInputPattern guifg=green   guibg=#e0e0e0 gui=bold ctermfg=2 ctermbg=254 cterm=bold
endif
if !hlexists('RgFlowInputPath') || testing
    hi RgFlowInputPath    guifg=black   guibg=#e0e0e0 ctermfg=0 ctermbg=254
endif

" DEFAULT SETTINGS
if testing
    " When testing, wish to reload lua files, and reset global values
    let g:rgflow_search_keymaps = 1
    let g:rgflow_qf_keymaps = 1
    let g:rgflow_flags = "--smart-case -g !*{min.js,pyc,spike/*} --no-fixed-strings --no-ignore"
    let g:rgflow_set_incsearch = 0
    let g:rgflow_mark_str = "▌"
    let g:rgflow_open_qf_list = 1
else
    " Applied only if not already set

    " Use default keymap to start rgflow search
    let g:rgflow_search_keymaps = get(g:, 'rgflow_search_keymaps', 1)

    " Use default keymaps with the quickfix window (used in ftplugin/qf.vim)
    let g:rgflow_qf_keymaps = get(g:, 'rgflow_qf_keymaps', 1)

    " For some reason --no-messages makes it stop working
    " No need to escape globs, e.g. '*.py' as the plugin will escape each item
    " seprated by a space
    let g:rgflow_flags = get(g:, 'rgflow_flags', "--smart-case -g !*{min.js,pyc,spike/*} --no-fixed-strings --no-ignore")

    " After a search, whether to set incsearch to be the pattern searched for
    let g:rgflow_set_incsearch = get(g:, 'rgflow_set_incsearch', 1)

    " String to prepend when marking an entry in the quick fix
    let g:rgflow_mark_str = get(g:, 'rgflow_mark_str', '▌')

    " Open the quickfix window automatically after a serach
    let g:rgflow_open_qf_list = get(g:, 'rgflow_open_qf_list', 1)

    " The QF window is set to the height of the number of matches, but bounded
    " to be between a min of 3 and a max of this variable:
    let g:rgflow_qf_max_height = get(g:, 'rgflow_qf_max_height', 42)
endif

" SOURCE MODULE
if testing
    lua rgflow = dofile('/home/tainzhi/.config/nvim/extra/plugins/rgflow.nvim/lua/rgflow/init.lua')
else
    lua rgflow = require('rgflow')
endif

" PLUG COMMANDS
" Map functions to commands, for easy mapping to hot keys
nnoremap <Plug>RgflowDeleteQuickfix       :<C-U>set  opfunc=v:lua.rgflow.qf_del_operator<CR>g@
nnoremap <Plug>RgflowDeleteQuickfixLine   :<C-U>call v:lua.rgflow.qf_del_operator('line')<CR>
vnoremap <Plug>RgflowDeleteQuickfixVisual :<C-U>call v:lua.rgflow.qf_del_operator(visualmode())<CR>
nnoremap <Plug>RgflowMarkQuickfixLine     :<C-U>call v:lua.rgflow.qf_mark_operator(v:true, 'line')<CR>
vnoremap <Plug>RgflowMarkQuickfixVisual   :<C-U>call v:lua.rgflow.qf_mark_operator(v:true, visualmode())<CR>
nnoremap <Plug>RgflowUnmarkQuickfixLine   :<C-U>call v:lua.rgflow.qf_mark_operator(v:false, 'line')<CR>
vnoremap <Plug>RgflowUnmarkQuickfixVisual :<C-U>call v:lua.rgflow.qf_mark_operator(v:false, visualmode())<CR>
nnoremap <Plug>RgflowChangeConceallevel   :<C-U>call v:lua.rgflow.change_conceallevel()<CR>
nnoremap <Plug>RgflowPasteFixdClipboard   :<C-U>call v:lua.rgflow.paste_fixed_clipboard()<CR>
vnoremap <Plug>RgflowPasteFixdClipboardVisual   :<C-U>call v:lua.rgflow.paste_fixed_clipboard()<CR>


if g:rgflow_search_keymaps
    " KEY MAPPINGS
    " Rip grep in files witout timestamp order, use <cword> under the cursor as starting point
    nnoremap <leader>rg :<C-U>lua rgflow.start_via_hotkey_root('n', 0)<CR>
    " Rip grep in files with timestamp order, use <cword> under the cursor as starting point
    nnoremap <leader>rgo :<C-U>lua rgflow.start_via_hotkey_root('n', 1)<CR>
    " " Start and paste contents of search register
    " nnoremap <leader>rr :<C-U>lua rgflow.start_via_hotkey_root('n')<CR>0D"/p
    " Rip grep in files, use visual selection as starting point
    xnoremap <leader>rg :<C-U>call v:lua.rgflow.start_via_hotkey_root(visualmode())<Cr>
    " Rip grep in current file, use <cword> under the cursor as starting point
    nnoremap <leader>rc :<C-U>call v:lua.rgflow.start_via_hotkey_current_file('n')<CR>
    nnoremap <leader>rr :<C-U>call v:lua.rgflow.clear()<CR>
endif

function! ResizeSurfingkeysWindow()
    setlocal filetype=idart
    setlocal guifont=Consolas:h16
    setlocal lines=40 columns=120
endfunction
au BufEnter surfingkeys://* call ResizeSurfingkeysWindow()

set completeopt-=preview " 可选，移除预览窗口
" 禁止默认的omnifunc补全
autocmd InsertLeave * if pumvisible() == 0 | pclose | endif
set omnifunc= ""    " 禁用内置的omnifunc

let g:loaded_rgflow = 1
