"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  Created  : 2012-09-22 14:30:00
"  Modified : 2018-03-30 17:47:54
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("win32")
    let g:HomeVimRuntime = $HOME.'\vimfiles\'
elseif has('mac')
    echo "Todo: set my vim runpath"
else
    let g:HomeVimRuntime = $HOME.'/.vim/'
endif

set nocompatible               " be iMproved
" 中文编码支持，同时支持GBK和UTF-8编码
set termencoding=utf-8
set encoding=utf-8 " the default encoding of vim 
" detect the current filetype whether is in following list one by one, if the answer is yes, then set fileencoding to the filetype
set fileencodings=utf-8,gb18030,utf-16,big5,cp936,ucs-bom,ucs-bom,unicode
" 解决console输出乱码
language messages zh_CN.utf-8

set whichwrap+=<,>,h,l   " 允许backspace和光标键跨越行边界(不建议)    
set colorcolumn=80     " max line length to 80
set history=256        " Number of things to remember in history.
set timeoutlen=250     " Time to wait after ESC (default causes an annoying delay)
set clipboard+=unnamed " Yanks go on clipboard instead.
set shiftround         " round indent to multiple of 'shiftwidth'
set cm=blowfish2
set modeline
set modelines=5                " default numbers of lines to read for modeline instructions
" 当文件在外部被修改，自动更新该文件
set autoread 
set autowrite
" 失去焦点后自动保存文件
au FocusLost * :up
" 避免在操作中频繁出现“请按Enter或其他命令继续”
" 以及出现“更多”的提示而需要按空格键继续
set nomore
autocmd BufLeave,FocusLost silent! wall


set hlsearch                   " highlight search
set ignorecase                 " be case insensitive when searching
set smartcase                  " be case sensitive when input has a capital letter
set incsearch                  " show matches while typing


" Formatting 
set formatoptions+=o           " Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
set fo-=r                      " Do not automatically insert a comment leader after an enter
set fo-=t                      " Do no auto-wrap text using textwidth (does not apply to comments)

set nowrap
set textwidth=0                " Don't wrap lines by default
" set linebreak off

set tabstop=4                  " tab size eql 2 spaces
set softtabstop=4
set shiftwidth=4               " default shift width for indents
set expandtab                  " replace tabs with ${tabstop} spaces
set smarttab                   

set backspace=indent
set backspace+=eol
set backspace+=start

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


syntax on                      " enable syntax
set synmaxcol=250              " limit syntax highlighting to 128 columns

set mouse=a "enable mouse in GUI mode
set mousehide                 " Hide mouse after chars typed

set number                  " line numbers on
set showmatch                 " Show matching brackets.
set matchtime=5               " Bracket blinking.

set wildmode=longest,list     " At command line, complete longest common string, then list alternatives.

set completeopt+=preview

set novisualbell              " No blinking
set noerrorbells              " No noise.
set vb t_vb=                  " disable any beeps or flashes on error

" set laststatus=2              " always show status line.
" set shortmess=atI             " shortens messages
set showcmd                   " display an incomplete command in statusline
" set statusline=%<%f\          " custom statusline
" set stl+=[%{&ff}]             " show fileformat
" set stl+=%y%m%r%=
" set stl+=%-14.(%l,%c%V%)\ %P,%L


"set foldenable                " Turn on folding
set foldmethod=marker         " Fold on the marker
set foldlevel=80             " Don't autofold anything (but I can still fold manually)

set foldopen=block,hor,tag    " what movements open folds
set foldopen+=percent,mark
set foldopen+=quickfix

set virtualedit=block

set splitbelow
set splitright

set list                      " display unprintable characters f12 - switches
set listchars=tab:\ ·,eol:¬
set listchars+=trail:·
set listchars+=extends:»,precedes:«
set invlist
map <silent> <F12> :set invlist<CR>

" 使注释倾斜斜体
hi Comment cterm=italic



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"keyboard map command 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader = "\<Space>"
"let maplocalleader = '	'      " Tab as a local leader

" resize the window
nmap w= :resize +3<CR>
nmap w- :resize -3<CR>
nmap w, :vertical resize +3<CR>
nmap w. :vertical resize -3<CR>

" 映射全选+复制 ctrl+a 
map <C-A> ggVG$
map! <C-A> <Esc>ggvG$
map <C-X> "+x

" 选中状态下 Ctrl+c 复制 
map <C-c> "+y

"选中模式 Ctrl+c 复制选中的文本
"vnoremap <c-c> "+y
"普通模式下 Ctrl+c 复制文件路径
"nnoremap <c-c> :let @+ = expand('%:p')<cr>

"普通模式下,Ctrl+c,插入系统剪切板中的内容到光标之后
noremap <C-V> "+p
"选中模式下,Ctrl+c,插入系统剪切板中的内容到光标之前
vnoremap <C-V> "+P
"插入模式下,Ctrl+c,插入系统剪切板中的内容到光标之后
inoremap <C-V> <esc>"+pa

" Operations to vimrc
nnoremap <leader>rs :exec 'source '.g:HomeVimRuntime.'vimrc'<CR>
nnoremap <leader>rt :exec 'tabnew '.g:HomeVimRuntime.'vimrc'<CR>
nnoremap <leader>rc :silent ! cd ~/.vim/ && git commit ~/.vim/vimrc -v <CR>

" Tabs
"nnoremap <leader>tn :tabnew 
nnoremap tn :tabnew 
map td :tabclose
nnoremap <M-h> :tabprev<CR>     "work equals <Alt-h>:tabprew
nnoremap <M-l> :tabnext<CR>

" Buffers
nnoremap <localleader>- :bd<CR>
nnoremap <localleader>-- :bd!<CR>
" Split line(opposite to S-J joining line)
nnoremap <C-J> gEa<CR><ESC>ew

" map <silent> <C-W>v :vnew<CR>
" map <silent> <C-W>s :snew<CR>

" copy filename
map <silent> <leader>. :let @+=expand('%:p').':'.line('.')<CR>
map <silent> <leader>/ :let @+=expand('%:p:h')<CR>
" copy path


map <S-CR> A<CR><ESC>

map <leader>E :Explore<CR>
map <leader>EE :Vexplore!<CR><C-W>=

" Make Control-direction switch between windows (like C-W h, etc)
nmap <silent> <C-k> <C-W><C-k>
nmap <silent> <C-j> <C-W><C-j>
nmap <silent> <C-h> <C-W><C-h>
nmap <silent> <C-l> <C-W><C-l>

  " vertical paragraph-movement
nmap <C-K> {
nmap <C-J> }

" vertical split with CommandT
nnoremap <leader>v :exec ':vnew \| CommandT'<CR>
" and without
nnoremap <leader>V :vnew<CR>

" when pasting copy pasted text back to 
" buffer instead replacing with owerride
xnoremap p pgvy

" map(range(1,9), 'exec "imap <D-".v:val."> <C-o>".v:val."gt"')
" map(range(1,9), 'exec " map <D-".v:val."> ".v:val."gt"')

" Copy whole line
nnoremap <silent> <D-c> yy

" close/delete buffer when closing window
map <silent> <D-w> :bdelete<CR>

" Control+S and Control+Q are flow-control characters: disable them in your terminal settings.
" $ stty -ixon -ixoff
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>
"
" generate HTML version current buffer using current color scheme
map <leader>2h :runtime! syntax/2html.vim<CR>

" open help in vertical split
au BufWinEnter *.txt if &ft == 'help' | wincmd H | vertical resize 85 | nmap q :q<CR> | endif
noremap <leader>h :help <C-R>=expand("<cword>")<CR><CR>

" for input method
set iminsert=0
set imsearch=0
se imd
au InsertEnter * se noimd
au InsertLeave * se imd
au FocusGained * se imd



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" invalite the default left, right, up, down key 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" noremap <Up> <NOP>
" noremap <Down> <NOP>
" noremap <Left> <NOP>
" noremap <Right> <NOP>
" noremap h <NOP>
" noremap j <NOP>
" noremap k <NOP>
" noremap l <NOP>



" vim自带目录浏览器netrw, 功能没有NERDTree强大, 但是支持ssh和http
" use the previous window to open file
let g:netrw_browse_split = 4
let g:netrw_altv = 1
" absolute width of netrw window
let g:netrw_winsize = 20
" do not display info on the top of window
let g:netrw_banner = 0
" tree-view
let g:netrw_liststyle = 3
" sort is affecting only: directories on the top, files below
let g:netrw_sort_sequence = '[\/]$,*'



function! Do_Map()
    if (&filetype == 'c')
        set sp=2>
        set makeprg=gcc\ -Wall\ \ %
        nmap <silent> <F4> :call Do_CsTag(&filetype)<CR><CR><CR><CR>
        " map <silent> <F9> <ESC>:exec ":w"<bar> :exec ":copen" <bar> :exec ":wincmd p"<bar>:exec ":make"<CR><CR>
        map <silent> <F9> <ESC>:exec "w"<bar> :exec "copen" <bar> :exec "wincmd J" <bar> :exec "wincmd p"<bar>:exec "make"<CR><CR>
        map <silent> <F10> <ESC>:exec '!./a.out < a.in'<CR>
    elseif (&filetype == 'cpp')
        set sp=2>
        set makeprg=g++\ -Wall\ \ %
        " :set makeprg=[[\ -f\ Makefile\ ]]\ &&\ make\ \\\|\\\|\ make\ -C\ .. 
        nmap <silent> <F4> :call Do_CsTag(&filetype)<CR><CR><CR><CR>
        map <silent> <F9> <ESC>:exec "w"<bar> :exec "copen" <bar> :exec "wincmd J" <bar> :exec "wincmd p"<bar>:exec "make"<CR><CR>
        map <silent> <F10> <ESC>:exec '!./a.out < a.in'<CR>
    elseif (&filetype == 'tex')
        " 因为vim-latex-suite只对pdflatex良好支持, 对xelatex支持性太差
        " 而xelatex对中文宏包xeCJK支持良好, pdflatex不支持,
        " 故不使用其自带的编译运行快捷键
        " nmap <silent> <F9> <leader>ll
        " nmap <silent> <F10> <leader>lv
        map <silent> <F9> <ESC>:exec ":w"<CR> <bar> :exec '!xelatex '."%"<CR><CR>
        map <silent> <F10> <ESC>:exec '!evince '.expand('%:r').'.pdf'<CR><CR>
    elseif (&filetype == 'python')
        set sp=2> 
        "the last line: \%-G%.%# is meant to suppress some
        "late error messages that I found could occur e.g.
        "with wxPython and that prevent one from using :clast
        "to go to the relevant file and line of the traceback
        set efm=%A\ \ File\ \"%f\"\\\,\ line\ %l\\\,%m,
            \%+C\ \ \ \ %.%#,
            \%+Z%.%#Error\:\ %.%#,
            \%A\ \ File\ \"%f\"\\\,\ line\ %l,
            \%+C\ \ %.%#,
            \%-C%p^,
            \%Z%m,
            \%-G%.%#
        set makeprg=python3\ \ %
        nmap <silent> <F4> :call Do_CsTag(&filetype)<CR><CR><CR><CR>
        map <silent> <F8> :call Do_FormatePythonSrc()<CR>
        " map <silent> <F9> <ESC>:exec ":w"<CR> <bar> :exec 'AsyncRun! python3'"%"<CR>
        map <silent> <F9> <ESC>:exec "w"<bar> :exec "copen" <bar> :exec "wincmd J" <bar> :exec "wincmd p"<bar> :exec "make %" <bar>:exec "clast" <CR><CR>
        " map <silent> <F9> <ESC>:exec "w"<bar> :exec "copen" <bar> :exec "wincmd p"<bar> :exec "AsyncRun -program=make @%" <bar> :exec "clast" <CR><CR>
        map <silent> <F10> <ESC>:exec 'AsyncStop'<CR> <bar> :exec ":cclose"<CR>
    elseif (&filetype == 'markdown')
        if has("win32")
			" 要把chrome的安装路径添加到系统环境变量Path
            map <buffer> <silent> <F10> <ESC>:exec ":w"<CR> <bar> :exec '!start chrome '"%"<CR><CR>
        else
            map <buffer> <silent> <F10> <ESC>:exec ":w"<CR> <bar> :exec '!google-chrome '"%"<CR><CR>
        endif
    elseif (&filetype == 'dot')
        map <silent> <F9> <ESC>:exec ":w"<CR> <bar> :exec '!dot -Tjpg 'expand('%').' -o 'expand('%:r').'.jpg'<CR><CR>
        map <silent> <F10> <ESC>:exec ":w"<CR> <bar> :exec '!xdg-open 'expand('%:r').'.jpg'<CR><CR>
    else 
        nmap <silent> <F9> :echo "tex compile"
        nmap <silent> <F10> :echo "tex run"
    endif
endfunction


au BufRead,BufNewFile {*.go}                                            setl ft=go tabstop=2 softtabstop=2 noexpandtab smarttab
au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,*.rake,config.ru}       setl ft=ruby tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab
au BufRead,BufNewFile {*.local,*.sh}                                         setl ft=sh
au BufRead,BufNewFile {*.md,*.mkd,*.markdown}                           setl ft=markdown
au BufRead,BufNewFile {*.c,*.h}                                          setl ft=c
au BufRead,BufNewFile {*.c++,*.cc,*.cpp}                                setl ft=cpp
au BufRead,BufNewFile {*.tex}                                           setl ft=tex
au BufRead,BufNewFile {*.py}                                            setl ft=python
au BufRead,BufNewFile {*.dot}                                           setl ft=dot

autocmd BufWritePre,FileWritePost,BufReadPost,FileReadPost {*.*}        call Do_Map()

au! BufReadPost       {COMMIT_EDITMSG,*/COMMIT_EDITMSG}                 setl ft=gitcommit noml list| norm 1G
au! BufWritePost      {*.snippet,*.snippets}                          call ReloadAllSnippets()

" autocmd BufWritePre,FileWritePost,BufReadPost,FileReadPost *.cc,*.c,*.cpp,*.h,*.tex,*py,*dot call Do_Map()
" autocmd BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} call Do_Map()
" autocmd BufRead,BufNewFile *.{md,mdown,mkd,mkdn,markdown,mdwn} map <Leader>p :!start "C:\Program Files\Google\Chrome\Application\chrome.exe" "%:p"<CR>


function! Do_Update_Modified()
    " let line_number = search('Modified','nw')
    " echo line_number
    " if line_number < 10
    " 因为search()从当前cursor所在行查找, 所以在此处用法不对. 更改为判断文件第
    " 3行是否有时间戳Modified
    let line_number = 3
    if match(getline(line_number), 'Modified')
        let line_content = substitute(getline(line_number),"[0-9][0-9][0-9][0-9]-[0-9][0-9]-[0-9][0-9] [0-9][0-9]:[0-9][0-9]:[0-9][0-9]",strftime("%Y-%m-%d %X"),"g") 
        "  Modified : 2017-05-17 18:53:36
        let minute_str = matchstr(getline(line_number),":[0-9][0-9]:") "get :53:
        let minute = strpart(minute_str,1,2) " get minute 53, vim script has no string to int, thus string is a number
        let current_minute = strftime("%M")
        " update date modified time stamp every 5 minutes
        if current_minute - minute >= 5 || current_minute - minute < 0
            call setline(line_number, line_content)
        endif
    endif
endfunction
autocmd BufWritePre,FileWritePre * call Do_Update_Modified()

" 定义函数Do_Set_Title，自动插入文件头 
function! Do_Set_Title() 
    "如果文件类型为.sh文件 
    if &filetype == 'sh' 
        call setline(1,"\################################################################################") 
        call append(line("."), "\# File     : ".expand("%")) 
        call append(line(".")+1, "\# Author   : tainzhi") 
        call append(line(".")+2, "\# Mail     : qfq61@qq.com") 
        call append(line(".")+3, "\# Created  : ".strftime("%Y-%m-%d %X")) 
        call append(line(".")+4, "\# Modified : ".strftime("%Y-%m-%d %X")) 
        call append(line(".")+5, "\################################################################################") 
        call append(line(".")+6, "\#!/bin/bash") 
        call append(line(".")+7, "") 
    elseif &filetype == 'text'
        call setline(1,"********************************************************************************") 
        call append(line("."), " > File     : ".expand("%")) 
        call append(line(".")+1, " > Author   : tainzhi") 
        call append(line(".")+2, " > Mail     : qfq61@qq.com") 
        call append(line(".")+3, " > Created  : ".strftime("%Y-%m-%d %X")) 
        call append(line(".")+4, " > Modified : ".strftime("%Y-%m-%d %X")) 
        call append(line(".")+5, "********************************************************************************") 
        call append(line(".")+6, "") 
    elseif &filetype == 'c'
        call setline(1,"/*******************************************************************************") 
        call append(line("."), "* File     : ".expand("%")) 
        call append(line(".")+1, "* Author   : tainzhi") 
        call append(line(".")+2, "* Mail     : qfq61@qq.com") 
        call append(line(".")+3, "* Created  : ".strftime("%Y-%m-%d %X")) 
        call append(line(".")+4, "* Modified : ".strftime("%Y-%m-%d %X")) 
        call append(line(".")+5, "*******************************************************************************/") 
        call append(line(".")+6, "") 
        call append(line(".")+7, "#include <stdio.h>") 
        call append(line(".")+8, "#include <string.h>") 
        call append(line(".")+9, "#include <stdlib.h>") 
        call append(line(".")+10, "") 
        call append(line(".")+11, "") 
    elseif &filetype == 'cpp' || &filetype == 'h' || &filetype == 'cc'
        call setline(1,"/*******************************************************************************") 
        call append(line("."), "* File     : ".expand("%")) 
        call append(line(".")+1, "* Author   : tainzhi") 
        call append(line(".")+2, "* Mail     : qfq61@qq.com") 
        call append(line(".")+3, "* Created  : ".strftime("%Y-%m-%d %X")) 
        call append(line(".")+4, "* Modified : ".strftime("%Y-%m-%d %X")) 
        call append(line(".")+5, "*******************************************************************************/") 
        call append(line(".")+6, "") 
        call append(line(".")+7, "#include <stdio.h>") 
        call append(line(".")+8, "#include <string.h>") 
        call append(line(".")+9, "#include <stdlib.h>") 
        call append(line(".")+10, "#include <iostream>") 
        call append(line(".")+11, "") 
        call append(line(".")+12, "using namespace std;") 
        call append(line(".")+13, "") 
        call append(line(".")+14, "") 
    elseif &filetype == 'python'
        call setline(1,"#!/usr/bin/env python3#########################################################")
        call setline(2,"# -*- coding: utf-8 -*-########################################################")
        call append(line(".")+1, "# File        : ".expand("%")) 
        call append(line(".")+2, "# Author      : tainzhi") 
        call append(line(".")+3, "# Mail        : qfq61@qq.com") 
        call append(line(".")+4, "# Created     : ".strftime("%Y-%m-%d %X")) 
        call append(line(".")+5, "# Modified    : ".strftime("%Y-%m-%d %X")) 
        call append(line(".")+6, "# Description :") 
        call append(line(".")+7, "# #############################################################################/") 
        call append(line(".")+8, "") 
        call append(line(".")+9, "") 
    endif
    "新建文件后，自动定位到文件末尾
    autocmd BufNewFile * normal G
endfunc 
" 匹配任意文件
" ma     保存当前位置到'a'标记
" 'a     光标回到旧位置
" autocmd BufWritePre,FileWritePre * ma|call Do_File()|'a
autocmd BufNewFile *.sh,*.txt,*.[ch],*.cpp,*.cc,*.python,*.py exec ":call Do_Set_Title()" 


function! Do_BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !python3 ./install.py --clang-completer --gocode-completer --tern-completer --racer-completer
  endif
endfunction


function! Do_FormatePythonSrc()
    execute "!find . -type f -name '*.py' | xargs autopep8 --in-place --aggressive --aggressive"
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" install plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#begin(g:HomeVimRuntime.'/plugged')



" for getting help for vim-plug itself
Plug 'junegunn/vim-plug'


" Colorscheme
Plug 'altercation/vim-colors-solarized'
Plug 'junegunn/seoul256.vim'
Plug 'liuchengxu/space-vim-dark'



"comment the code
Plug 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims=1



"nerdtree
Plug 'scrooloose/nerdtree'
let g:NERDTreeWinPos = 'left'
nmap <silent> <F3> :NERDTreeToggle<CR>
let g:NERDTreeWinSize=40
let NERDTreeAutoDeleteBuffer=1
let NERDTreeIgnore=['cscope.files$[[file]]', 'cscope.out$[[file]]', 'cscope.in.out$[[file]]', 'cscope.out$[[file]]]', 'cscope.po.out$[[file]]', 'tags$[[file]]']
" open a NERDTree automatically when vim starts up if no files were specified, but this will conflict with vim-sessions
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif



" vim-nerdtree-tabs
Plug 'jistr/vim-nerdtree-tabs'
let g:nerdtree_tabs_open_on_gui_startup = 0
let g:nerdtree_tabs_open_on_console_startup = 0
let g:nerdtree_tabs_smart_startup_focus = 2
let g:nerdtree_tabs_synchronize_view = 1



" Plugin tagbar
Plug 'majutsushi/tagbar'
nmap <silent> <F2> :Tagbar<CR>
set updatetime=100
let g:tagbar_autofocus = 1
let g:tagbar_width = 40
let g:tagbar_left = 0
let g:tagbar_type_markdown = {
        \ 'ctagstype' : 'markdown',
        \ 'kinds' : [
                \ 'h:headings',
        \ ],
    \ 'sort' : 0
\ }



"ctags install path
let Tlist_Ctags_Cmd='/usr/bin/ctags'
"set tags=/home/muqing/android-20/tags,./tags
"set autochdir
set tags=tags;**/.svn,tags;**/.git         " consider the tags first, then
                               " walk directory tree upto $HOME looking for tags
                               " note `;` sets the stop folder. :h file-search



"autoload_cscope.vim
Plug 'tainzhi/autoload_cscope.vim'
" if has("cscope")
    " set csprg=/usr/bin/cscope
    set cst
    " set cscopequickfix=s+,c+,d+,i+,t+,e+
    set nocsverb
" endif
function! Do_CsTag(file_type)
    let has_cscope_out = filereadable("cscope.out")
    execute "!find `pwd` -iname '*.java' -o -name '*.xml' -o -name '*.h'  -o -name '*.c' -o -name '*.cpp' -o -name '*.cc' -o -name '*.py'| grep -v .plus > ./cscope.files"
    execute "!ctags --fields=+i -n -R -L ./cscope.files"
    echo a:file_type
    if a:file_type == 'python'
        execute "!pycscope -i ./cscope.files"
    else
        execute "!cscope -bkq -i ./cscope.files"
    endif
    if (has_cscope_out)
        execute "cs reset"
    else
        execute "cs add cscope.out"
    endif
endfunction
nnoremap <leader>ct :cs find t 
nnoremap <leader>cf :cs find f 
    



" rainbow_parentheses.vim
Plug 'kien/rainbow_parentheses.vim'
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['gray',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces



Plug 'Raimondi/delimitMate'



Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 2 " splits and tab number
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
nmap <leader>d :bd 
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab
" let g:airline_section_a = airline#section#create_left(['mode', 'crypt', 'paste', 'spell','iminsert'])
" let g:airline_section_b = airline#section#create(['hunks', 'branch'])
" let g:airline_section_c = airline#section#create(['file'])
" let g:airline_section_gutter = airline#section#create(['readonly', 'tagbar'])
" let g:airline_section_x = '' "airline#section#create_right(['ffenc', 'filetype'])
" let g:airline_section_z = '%-14 %y%m%r%=[%{&ff}] %= %(%l,%c%V%) %P' "airline#section#create_right(['ffenc'])
" let g:airline_section_y = '' "airline#section#create_right(['%(%l,%c%V%) %P'])
" let g:airline_section_error = '' " airline#section#create(['ycm_error_count', 'syntastic', 'eclim'])
" let g:airline_section_warning = '' " airline#section#create(['ycm_warning_count', 'whitespace'])
" let g:airline#extensions#default#layout = [
"     \ ['a', 'b', 'c'],
"     \ ['gutter'],
"     \ ['x', 'y', 'z', 'error', 'warning' ]
"     \ ]
" let g:airline#extensions#branch#displayed_head_limit = 10



Plug 'vim-scripts/ZoomWin'



Plug 'tpope/vim-surround'



Plug 'Valloric/MatchTagAlways'
nnoremap <leader>% :MtaJumpToOtherTag<CR>



Plug 'vim-scripts/TaskList.vim'
let g:tlTokenList = ['fixme', 'todo']



Plug 'Lokaltog/vim-easymotion'
"let g:Easymotion_smartcase = 0
"let g:Easymotion_use_upper = 1
let g:EasyMotion_do_mapping = 0
nmap <leader>s <Plug>(easymotion-s)
nmap <leader>ss <Plug>(easymotion-s2)



Plug 'vim-scripts/DirDiff.vim'
let g:DirDiffExcludes = "CVS,*.class,*.exe,.*.swp,.svn,cscope*,tags"



Plug 'rking/ag.vim'
Plug 'Chun-Yang/vim-action-ag'
nmap <leader>a <Plug>AgActionWord
vmap <leader>a AgActionVisual
let g:ag_highlight=1



" use to line up text
Plug 'godlygeek/tabular'
nmap <leader>be :Tabularize /=<CR>
nnoremap <leader>bu :Tabularize /



Plug 'Valloric/YouCompleteMe', { 'do': function('Do_BuildYCM') }
" 自动补全配置
set completeopt=longest,menu	"让Vim的补全菜单行为与一般IDE一致(参考VimTip1228)
autocmd InsertLeave * if pumvisible() == 0|pclose|endif	"离开插入模式后自动关闭预览窗口
inoremap <expr> <CR>       pumvisible() ? "\<C-y>" : "\<CR>"	"回车即选中当前项
"上下左右键的行为 会显示其他信息
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"
"youcompleteme  默认tab  s-tab 和自动补全冲突
"let g:ycm_key_list_select_completion=['<c-n>']
"let g:ycm_key_list_select_completion = ['<Down>']
"let g:ycm_key_list_previous_completion=['<c-p>']
"let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_collect_identifiers_from_tags_files=1	" 开启 YCM 基于标签引擎
let g:ycm_min_num_of_chars_for_completion=2	" 从第2个键入字符就开始罗列匹配项
let g:ycm_cache_omnifunc=0	" 禁止缓存匹配项,每次都重新生成匹配项
let g:ycm_seed_identifiers_with_syntax=1	" 语法关键字补全
"nnoremap <leader>lo :lopen<CR>	"open locationlist
"nnoremap <leader>lc :lclose<CR>	"close locationlist
inoremap <leader><leader> <C-x><C-o>
"在注释输入中也能补全
let g:ycm_complete_in_comments = 1
"在字符串输入中也能补全
let g:ycm_complete_in_strings = 1
"注释和字符串中的文字也会被收入补全
let g:ycm_collect_identifiers_from_comments_and_strings = 1
" 关闭加载.ycm_extra_conf.py提示
let g:ycm_confirm_extra_conf = 0
if has('win32')
    let g:ycm_server_python_interpreter = 'python'
    let g:ycm_python_binary_path = 'c:\Python35\python'
else
    let g:ycm_server_python_interpreter = 'python3.5'
    let g:ycm_python_binary_path = '/usr/bin/python3.5'
endif
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR> " 跳转到定义处
"显示对c/c++的实时检测结果,比如语法错误; 不显示, 值为0, 那么此时使用syntastic检测语法
"为了不使用syntastic插件检测功能,而适用YouCompleteMe检测功能
let g:ycm_show_diagnostics_ui = 1


" faster checkter than syntastic
Plug 'w0rp/ale'
let g:ale_linters = {
            \ 'python': ['flake8'],
            \}
let g:ale_python_flake8_options = '--max-length=100'
nmap <silent> <C-p> <Plug>(ale_previous_wrap)
nmap <silent> <C-n> <Plug>(ale_next_wrap)




" make YouCompleteMe compatible with ultisnips
Plug 'ervandew/supertab'
" make YCM compatible with UltiSnips (using supertab)
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:SuperTabDefaultCompletionType = '<C-n>'
" better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<tab>"
let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"



" Included are syntax, indent, and filetype file for git, gitconfig,
" gitrebase,and gitsendemail
Plug 'tpope/vim-git'



Plug 'tpope/vim-fugitive'
nnoremap <leader>W :Gwrite<CR>
nnoremap <leader>C :Gcommit -v<CR>
nnoremap <leader>S :Gstatus \| 7<CR>
inoremap <leader>W <Esc><leader>W
inoremap <leader>C <Esc><leader>C
inoremap <leader>S <Esc><leader>S



" List the recent files
Plug 'yegappan/mru'



" ultimate solutions for snippets
Plug 'Sirver/ultisnips'
Plug 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger = "<c-l>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
" let g:UltiSnipsSnippetDirectories=["UltiSnips", "plugged/vim/vim-snippets/UltiSnips"]
autocmd BufWritePre,FileWritePre,BufRead,BufNewFile {*.java} call UltiSnips#AddFiletypes("java")
autocmd BufWritePre,FileWritePre,BufRead,BufNewFile {*.xml} call UltiSnips#AddFiletypes("xml")
autocmd BufWritePre,FileWritePre,BufRead,BufNewFile {*.py} call UltiSnips#AddFiletypes("py")
autocmd BufWritePre,FileWritePre,BufRead,BufNewFile {*.cc,*.h,*c,*.cpp} call UltiSnips#AddFiletypes("cpp")



Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
let g:session_directory=g:HomeVimRuntime
let g:session_default_name='.session'
let g:session_lock_enabled=0
if has("gui_running")
    let g:session_autoload='no'
    let g:session_autosave='no'
else
    let g:session_autoload='yes'
    let g:session_autosave='yes'
endif



" Syntax highlight
Plug 'gmarik/vim-markdown', { 'for': 'markdown'}



Plug 'tpope/vim-repeat'



Plug 'gmarik/ide-popup.vim'



Plug 'tomtom/tlib_vim'
Plug 'tomtom/tcomment_vim'
nnoremap // :TComment<CR>
vnoremap // :TComment<CR>




Plug 'tainzhi/vimim'
let g:vimim_cloud = 'google,sogou,baidu,qq'   
let g:vimim_map = 'tab_as_gi'   
" :let g:vimim_mode = 'dynamic'   
" :let g:vimim_mycloud = 0   
" :let g:vimim_plugin = 'C:/var/mobile/vim/vimfiles/plugin'   
" :let g:vimim_punctuation = 2   
" :let g:vimim_shuangpin = 0   
" :let g:vimim_toggle = 'pinyin,google,sogou' 



Plug 'gerw/vim-latex-suite', {'for': 'tex'}
" OPTIONAL: Starting with Vim 7, the filetype of empty .tex files defaults to
" 'plaintex' instead of 'tex', which results in vim-latex not being loaded.
" The following changes the default filetype back to 'tex':
" let g:tex_flavor='latex'
" let g:Tex_CompileRule_dvi = 'xelatex --src-specials -interaction=nonstopmode $*'
" let g:Tex_FormatDependency_dvi = 'dvi,ps,pdf'
" let g:Tex_IgnoredWarnings = 
"     \"Underfull\n".
"     \"Overfull\n".
"     \"specifier changed to\n".
"     \"You have requested\n".
"     \"Missing number, treated as zero.\n".
"     \"There were undefined references\n"
"     \"Citation %.%# undefined\n"
"     \"LaTex Font Warning:"
" let g:Tex_IgnoreLevel = 8



Plug 'lilydjwg/fcitx.vim'



Plug 'skywind3000/asyncrun.vim'
" Use autocmd AsyncRunStart with asyncrun#quickfix_toggle in your vimrc:
autocmd User AsyncRunStart call asyncrun#quickfix_toggle(15, 1)



Plug 'mbbill/undotree'
nnoremap <leader>un :UndotreeToggle<CR>
nnoremap <leader>unq :UndotreeToggle<CR>
" backup current file into /tmp, deleted afterwards
set nobackup
set nowritebackup
set backupdir=/tmp/
set noswapfile
set directory=/tmp/           " prepend(^=) $HOME/.tmp/ to default path; use full path as backup filename(//)
" backup undo history into /tmp
set undofile
set undodir=/tmp/
set hidden                     " The current buffer can be put to the background without writing to disk



Plug 'Vimjas/vim-python-pep8-indent'



Plug 'Yggdroot/indentLine'



Plug 'terryma/vim-multiple-cursors'
" Default mapping
let g:multi_cursor_next_key='<C-n>'
let g:multi_cursor_prev_key='<C-p>'
let g:multi_cursor_skip_key='<C-j>'
let g:multi_cursor_quit_key='<Esc>'



Plug 'dyng/ctrlsf.vim'
nmap     <leader>f <Plug>CtrlSFPrompt<CR>
call plug#end()



" 系统相关的配置
if has('mac')
    if has('gui_running')
        set macmeta
        set guifont=Andale\ Mono:h13
    endif
    set noantialias
    set fuoptions=maxvert,maxhorz ",background:#00AAaaaa
elseif has('win32')
    if has ('gui_running')
        if has('libcall')
            map <F11> <ESC>:call libcallnr(g:HomeVimRuntime.'\gvimfullscreen.dll', "ToggleFullScreen", 0)<CR><CR>
        endif
        " 解决菜单乱码
        source $VIMRUNTIME/delmenu.vim
        source $VIMRUNTIME/menu.vim
        " 设置字体
        set guifont=Consolas:h14:cANSI
        "winpos 5 5          " 设定窗口位置    
        "set lines=999 columns=999
        "win 2560 1700
        "gvim -geometry 2560*1700
        " an GUIEnter * simalt ~x           " 进入窗口后对所有文件类型(型号*匹配所有文件)全屏. 
                                            " simalt ~x模拟Alt Spacebar X. 
                                            " simalt ~n最小化窗口
        " 隐藏菜单栏和工具栏
        set guioptions-=m
        set guioptions-=T
        colorscheme solarized
        set background=dark
    else
        colorscheme desert
    endif
else
    set guifont=Monospace\ 14
    if has('gui_running')
        colorscheme solarized
        set background=dark
    else
        colorscheme desert
        set t_Co=256
    endif
endif
