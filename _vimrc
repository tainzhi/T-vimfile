"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  FileName:     _vimrc/_gvimrc for linux
"  Author:        muqing
"  CreateTime:   2012-09-22 14:30:00
"  LastModified: 2014-11-16 23:26:19
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set runtimepath=~/vim,$VIMRUNTIME,$VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General "{{{
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible               " be iMproved

"" 中文编码支持，同时支持GBK和UTF-8编码
set termencoding=utf-8
set encoding=utf-8
set fileencodings=utf-8,gb18030,utf-16,big5,cp936,ucs-bom,unicode

"" 解决菜单乱码
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

"" 解决console输出乱码
language messages zh_CN.utf-8
let g:is_posix = 1             " vim's default is archaic bourne shell, bring it up to the 90s

set whichwrap+=<,>,h,l   " 允许backspace和光标键跨越行边界(不建议)    

set cc=80
set history=256                " Number of things to remember in history.
set timeoutlen=250             " Time to wait after ESC (default causes an annoying delay)
set clipboard+=unnamed         " Yanks go on clipboard instead.
set pastetoggle=<F10>          " toggle between paste and normal: for 'safer' pasting from keyboard
set shiftround                 " round indent to multiple of 'shiftwidth'

set modeline
set modelines=5                " default numbers of lines to read for modeline instructions

set autowrite                  " Writes on make/shell commands
set autoread

set nobackup
set nowritebackup
set directory=/tmp//           " prepend(^=) $HOME/.tmp/ to default path; use full path as backup filename(//)
set noswapfile                 "

set hidden                     " The current buffer can be put to the background without writing to disk

set hlsearch                   " highlight search
set ignorecase                 " be case insensitive when searching
set smartcase                  " be case sensitive when input has a capital letter
set incsearch                  " show matches while typing


let mapleader = ","
"let maplocalleader = '	'      " Tab as a local leader
let g:netrw_banner = 0         " do not show Netrw help banner
" "}}}

" Formatting "{{{
set fo+=o                      " Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
set fo-=r                      " Do not automatically insert a comment leader after an enter
set fo-=t                      " Do no auto-wrap text using textwidth (does not apply to comments)

set nowrap
set textwidth=0                " Don't wrap lines by default

set tabstop=4                  " tab size eql 2 spaces
set softtabstop=4
set shiftwidth=4               " default shift width for indents
set expandtab                  " replace tabs with ${tabstop} spaces
set smarttab                   "

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
" "}}}

" Visual "{{{
syntax on                      " enable syntax

" set synmaxcol=250              " limit syntax highlighting to 128 columns

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

set laststatus=2              " always show status line.
set shortmess=atI             " shortens messages
set showcmd                   " display an incomplete command in statusline

set statusline=%<%f\          " custom statusline
set stl+=[%{&ff}]             " show fileformat
set stl+=%y%m%r%=
set stl+=%-14.(%l,%c%V%)\ %P,%L


set foldenable                " Turn on folding
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
map <silent> <F12> :set invlist<CR>


if has('gui_running')
    "winpos 5 5          " 设定窗口位置    
    "set lines=999 columns=999
    "win 2560 1700
    "gvim -geometry 2560*1700
    "an GUIEnter * simalt ~x     #full screen
    "set guioptions=cMg " console dialogs, do not show menu and toolbar
    set guioptions=m
endif

if has('mac')
    set guifont=Andale\ Mono:h13
elseif has('win32')
    set guifont=Consolas:h14:cANSI
else
    set guifont=Monospace\ 11
end

if has('mac')
    set noantialias
    set fuoptions=maxvert,maxhorz ",background:#00AAaaaa
endif
" "}}}


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"keyboard map command 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 映射全选+复制 ctrl+a 
map <C-A> ggVG$
map! <C-A> <Esc>ggvG$
map <C-X> "+x

map <C-v> "+gP
map <C-V> <Esc>"+pa
map <C-V> "+pa<Esc>

" 选中状态下 Ctrl+c 复制 
map <C-c> "+y

"选中模式 Ctrl+c 复制选中的文本
"vnoremap <c-c> "+y
"普通模式下 Ctrl+c 复制文件路径
"nnoremap <c-c> :let @+ = expand('%:p')<cr>

"普通模式下,Ctrl+c,插入系统剪切板中的内容
noremap <C-V> "+p
noremap <C-V> <esc>"+pa
"选中模式下,Ctrl+c,插入系统剪切板中的内容
vnoremap <C-V> d"+P
"插入模式下,Ctrl+c,插入系统剪切板中的内容
inoremap <C-V> "+p
inoremap <C-V> <esc> "+pa



" Key mappings " {{{
" Duplication
cnoremap <leader>c mz"dyy"dp`z
vnoremap <leader>c "dymz"dP`z

nnoremap <leader>rs :source $VIM\_vimrc<CR>
nnoremap <leader>rt :tabnew $Vim\_vimrc<CR>

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

if has('mac')

  if has('gui_running')
    set macmeta
  end

" map(range(1,9), 'exec "imap <D-".v:val."> <C-o>".v:val."gt"')
" map(range(1,9), 'exec " map <D-".v:val."> ".v:val."gt"')

" Copy whole line
nnoremap <silent> <D-c> yy

" close/delete buffer when closing window
map <silent> <D-w> :bdelete<CR>
endif

" Control+S and Control+Q are flow-control characters: disable them in your terminal settings.
" $ stty -ixon -ixoff
noremap <C-S> :update<CR>
vnoremap <C-S> <C-C>:update<CR>
inoremap <C-S> <C-O>:update<CR>
"
" generate HTML version current buffer using current color scheme
map <leader>2h :runtime! syntax/2html.vim<CR>

" " }}}

" AutoCommands " {{{
au BufRead,BufNewFile {*.go}                                          setl ft=go tabstop=2 softtabstop=2 noexpandtab smarttab
" autocmd FileType go compiler go
au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,*.rake,config.ru}     setl ft=ruby tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab
au BufRead,BufNewFile {*.local}                                       setl ft=sh
au BufRead,BufNewFile {*.md,*.mkd,*.markdown}                         setl ft=markdown
au BufRead,BufNewFile {*.scala}                                       setl ft=scala
au! BufReadPost       {COMMIT_EDITMSG,*/COMMIT_EDITMSG}               setl ft=gitcommit noml list| norm 1G
au! BufWritePost      {*.snippet,*.snippets}                          call ReloadAllSnippets()

" open help in vertical split
au BufWinEnter *.txt if &ft == 'help' | wincmd H | nmap q :q<CR> | endif



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"加入文件修改时间
"原理:找到前10行出现的LastModified所在行,替换为当前的时间
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"匹配任意文件
"ks     保存当前位置到's'标记
"'s     光标回到旧位置
"autocmd BufWritePre,FileWritePre * ks|call LastModified()|'s
"func LastModified()
    ""文件的行数如果大于10
    "if line("$") > 10
        "let l=10
    "else
        "let l=line("$")
    "endif
    ""先用g查找行1到行l,查找到存在LastModified的行,替换LastModified到之后的为保存
    ""时间
    "exe "1,".l. "g/LastModified/s/LastModified.*$/LastModified: ".strftime("%F %T")
    ""exe "1,".l. "g/^\s*\"\s*[L]ast[M]odified:.*$/s/^\s*\"\s*[L]ast[M]odified:.*$/\"    LastModified: ".strftime("%Y-%m-%d %H:%M:%S")
"endfunc

