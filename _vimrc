"""
" vimrc for vim8.0 on windows10
" Usage: 为了有read权限，用管理员打开cmd，然后使用以下命令编辑$VIM/_vimrc
" 在这里，$VIM为“C:\Program Files (x64)\Vim”
"""

source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      if empty(&shellxquote)
        let l:shxq_sav = ''
        set shellxquote&
      endif
      let cmd = '"' . $VIMRUNTIME . '\diff"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3
  if exists('l:shxq_sav')
    let &shellxquote=l:shxq_sav
  endif
endfunction

"" 中文编码支持，同时支持GBK和UTF-8编码
set encoding=utf-8
"" 依次使用以下格式解析, 当解析成功, 设置fileencoding为当前游标所在的编码格式
set fileencodings=utf-8,cp936,euc-cn,big5,euc-tw,ucs-bom,gb18030,unicode,utf-16
" set termencoding=utf-8
"" 解决菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim
"" 解决console输出乱码
language messages zh_CN.utf-8


let mapleader = "\<Space>"

" open help in vertical split
au BufWinEnter *.txt if &ft == 'help' | wincmd H | vertical resize 85 | nmap q :q<CR> | endif
noremap <leader>h :help <C-R>=expand("<cword>")<CR><CR>

" 高亮当前行
set cursorline
set cursorcolumn
set autoindent
set cindent
set indentkeys-=0#            " do not break indent on #
set cinkeys-=0#
set cinoptions=:s,ps,ts,cs
set cinwords=if,else,while,do
set cinwords+=for,switch,case

if has('win32')
	set guifont=Consolas:h14:cANSI
end

" Tabs
"nnoremap <leader>tn :tabnew 
nnoremap tn :tabnew 
map td :tabclose
nnoremap <M-h> :tabprev<CR>     "work equals <Alt-h>:tabprew
nnoremap <M-l> :tabnext<CR>

set tabstop=4                  " tab size eql 2 spaces
set softtabstop=4
set shiftwidth=4               " default shift width for indents
set expandtab                  " replace tabs with ${tabstop} spaces
set smarttab    
