vim.api.nvim_exec(
[[
    let g:firenvim_config = { 
        \ 'globalSettings': {
            \ 'alt': 'all',
            \ '<C-w>': 'noop',
            \ '<C-n>': 'default',
        \  },
        \ 'localSettings': {
            \ '.*': {
                \ 'cmdline': 'nvim',
                \ 'content': 'text',
                \ 'priority': 0,
                \ 'selector': 'textarea',
                \ 'takeover': 'always',
            \ },
        \ }
    \ }
   let fc = g:firenvim_config['localSettings']
   let fc['https://idart.mot.com/'] = {'filename': '{hostname%32}_{pathname%32}.idart', 'selector': 'textarea[id="comment"]'}

    " Increase the font size to solve the `text too small` issue
    function! s:IsFirenvimActive(event) abort
        if !exists('*nvim_get_chan_info')
            return 0
        endif
        let l:ui = nvim_get_chan_info(a:event.chan)
        return has_key(l:ui, 'client') && has_key(l:ui.client, 'name') &&
        \ l:ui.client.name =~? 'Firenvim'
    endfunction


    function! OnUIEnter(event) abort
        if s:IsFirenvimActive(a:event)
            set relativenumber

            let s:fontsize = 10
            execute "set guifont=Consolas:h" . s:fontsize

            function! AdjustFontSizeF(amount)
                let s:fontsize = s:fontsize+a:amount
                execute "set guifont=Consolas:h" . s:fontsize
                set relativenumber
                call rpcnotify(0, 'Gui', 'WindowMaximized', 1)
            endfunction

            noremap  <C-=> :call AdjustFontSizeF(1)<CR>
            noremap  <C--> :call AdjustFontSizeF(-1)<CR>
            inoremap <C-=> :call AdjustFontSizeF(1)<CR>
            inoremap <C--> :call AdjustFontSizeF(-1)<CR>
            noremap  <C-S> :wq<CR>
            " 放大窗口, 放大字体
            nnoremap <space> :set lines=50 columns=210<CR>:set guifont=Consolas:h14<CR>
        endif
    endfunction

    autocmd UIEnter * call OnUIEnter(deepcopy(v:event))
    autocmd BufEnter idart.mot.com_* set filetype=idart
    autocmd BufEnter github.com_*.txt set filetype=markdown
]], true)

-- let g:firenvim_config = { "globalSettings": { "alt": "all", }, "localSettings": { ".*": { "cmdline": "neovim", "content": "text", "priority": 0, "selector": "textarea", "takeover": "always", }, } }'

-- -- for chrome plugin firenvim
-- -- https://github.com/glacambre/firenvim/issues/800
-- -- 暂时不会把vim script转为 lua, 先这样实现
-- vim.cmd [[ au BufEnter idart.mot.com_*.txt set filetype=idart lines=30 ]]
-- vim.cmd [[ au BufEnter github.com_*.txt set filetype=markdown lines=30 ]]
