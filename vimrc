"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"  FileName:     _vimrc/_gvimrc for linux
"  Author:        muqing
"  CreateTime:   2012-09-22 14:30:00
"  LastModified: 2014-11-16 23:26:19
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set runtimepath=~/vim,$VIMRUNTIME,$VIM
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible               " be iMproved

"" 中文编码支持，同时支持GBK和UTF-8编码
set termencoding=utf-8
set encoding=utf-8 " the default encoding of vim 
" detect the current filetype whether is in following list one by one, if the 
" answer is yes, then set fileencoding to the filetype
set fileencodings=utf-8,gb18030,utf-16,big5,cp936,ucs-bom,unicode

"" 解决菜单乱码
"source $VIMRUNTIME/delmenu.vim
"source $VIMRUNTIME/menu.vim

"" 解决console输出乱码
"language messages zh_CN.utf-8
"let g:is_posix = 1             " vim's default is archaic bourne shell, bring it up to the 90s

set whichwrap+=<,>,h,l   " 允许backspace和光标键跨越行边界(不建议)    

set colorcolumn=80
set history=256                " Number of things to remember in history.
set timeoutlen=250             " Time to wait after ESC (default causes an annoying delay)
set clipboard+=unnamed         " Yanks go on clipboard instead.
" set pastetoggle=<F10>          " toggle between paste and normal: for 'safer' pasting from keyboard
set shiftround                 " round indent to multiple of 'shiftwidth'

set modeline
set modelines=5                " default numbers of lines to read for modeline instructions

set autowrite                  " Writes on make/shell commands
set autoread

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

set hlsearch                   " highlight search
set ignorecase                 " be case insensitive when searching
set smartcase                  " be case sensitive when input has a capital letter
set incsearch                  " show matches while typing


" Formatting 
set formatoptions+=o                      " Automatically insert the current comment leader after hitting 'o' or 'O' in Normal mode.
set fo-=r                      " Do not automatically insert a comment leader after an enter
set fo-=t                      " Do no auto-wrap text using textwidth (does not apply to comments)

set nowrap
set textwidth=0                " Don't wrap lines by default
" set linebreak off

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



if has('mac')
    if has('gui_running')
        set macmeta
    end
    set guifont=Andale\ Mono:h13
    set noantialias
    set fuoptions=maxvert,maxhorz ",background:#00AAaaaa
"elseif has('win32')
"    set guifont=Consolas:h14:cANSI
else
    if has('gui_running')
        "winpos 5 5          " 设定窗口位置    
        "set lines=999 columns=999
        "win 2560 1700
        "gvim -geometry 2560*1700
        "an GUIEnter * simalt ~x     #full screen
        set guioptions=m
        set guifont=Monospace\ 14
    else
        set guifont=Monospace\ 11
    endif
endif



"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"keyboard map command 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader = ","
"let maplocalleader = '	'      " Tab as a local leader
let g:netrw_banner = 0         " do not show Netrw help banner

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

" Operatations to vimrc
nnoremap <leader>rs :source ~/.vim/vimrc<CR>
nnoremap <leader>rt :tabnew ~/.vim/vimrc<CR>
"nnoremap <leader>re :c ~/.vim/vimrc<CR>
"nnoremap <leader>rd :e ~/.vim/ <CR>
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

" " }}}

" AutoCommands " {{{
au BufRead,BufNewFile {*.go}                                          setl ft=go tabstop=2 softtabstop=2 noexpandtab smarttab
" autocmd FileType go compiler go
au BufRead,BufNewFile {Gemfile,Rakefile,Capfile,*.rake,config.ru}     setl ft=ruby tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab
au BufRead,BufNewFile {*.local}                                       setl ft=sh
au BufRead,BufNewFile {*.md,*.mkd,*.markdown}                         setl ft=markdown
au BufRead,BufNewFile {*.scala}                                       setl ft=scala
au! BufReadPost       {COMMIT_EDITMSG,*/COMMIT_EDITMSG}               setl ft=gitcommit noml list| norm 1G
" au! BufWritePost      {*.snippet,*.snippets}                          call ReloadAllSnippets()

" open help in vertical split
au BufWinEnter *.txt if &ft == 'help' | wincmd H | vertical resize 80 | nmap q :q<CR> | endif
noremap <leader>h :help <C-R>=expand("<cword>")<CR><CR>

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




"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"install plugin
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Scripts and Plugins configure "
" filetype off
filetype plugin indent on      " Automatically detect file types.
" This plugin makes "%" command jump to match HTML tags, if/else/endif in vim
" scripts, etc
runtime macros/matchit.vim
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()



Plugin 'gmarik/vundle' " let Vundle manage Vundle



" Colorscheme
Plugin 'altercation/vim-colors-solarized'
if has("gui_running")
  set background=light
  colorscheme solarized
else
  set t_Co=256
  " set background=dark
  " colorscheme solarized
  colorscheme desert
endif



"comment the code
Plugin 'scrooloose/nerdcommenter'
let g:NERDSpaceDelims=1



"nerdtree
Plugin 'scrooloose/nerdtree'
let g:NERDTreeWinPos = 'right'
nmap <silent> <F10> :NERDTreeToggle<CR>
let g:NERDTreeWinSize=40
let NERDTreeIgnore=['cscope.files$[[file]]', 'cscope.out$[[file]]', 'cscope.in.out$[[file]]', 'cscope.out$[[file]]]', 'cscope.po.out$[[file]]', 'tags$[[file]]']
" open a NERDTree automatically when vim starts up if no files were specified, but this will conflict with vim-sessions
" autocmd StdinReadPre * let s:std_in=1
" autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif



" vim-nerdtree-tabs
Plugin 'jistr/vim-nerdtree-tabs'
let g:nerdtree_tabs_open_on_console_startup = 1
let g:nerdtree_tabs_smart_startup_focus = 2
let g:nerdtree_tabs_synchronize_view = 1



"ctags install path
let Tlist_Ctags_Cmd='/usr/bin/ctags'
"set tags=/home/muqing/vivo/b/android-20/tags,./tags
"set autochdir
set tags=tags;**/.svn,tags;**/.git         " consider the tags first, then
                               " walk directory tree upto $HOME looking for tags
                               " note `;` sets the stop folder. :h file-search



"autoload_cscope.vim
Plugin 'tainzhi/autoload_cscope.vim'
" if has("cscope")
    " set csprg=/usr/bin/cscope
    set cst
    " set cscopequickfix=s+,c+,d+,i+,t+,e+
    set nocsverb
" endif
nmap <silent> <F5> :call Do_CsTag()<CR><CR><CR><CR>
function! Do_CsTag()
    let has_cscope_out = filereadable("cscope.out")
    execute "!find `pwd` -iname '*.java' -o -name '*.xml' -o -name '*.h'  -o -name '*.c' -o -name '*.cpp' -o -name '*.cc' -o -name '*.py'| grep -v .plus > ./cscope.files"
    execute "!ctags --fields=+i -n -R -L ./cscope.files"
    execute "!cscope -bkq -i ./cscope.files"
    if (has_cscope_out)
        execute "cs reset"
    else
        execute "cs add cscope.out"
    endif
endfunction
nnoremap <leader>ct :cs find t 
nnoremap <leader>cf :cs find f 
    



" rainbow_parentheses.vim
Plugin 'kien/rainbow_parentheses.vim'
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



" Plugin tagbar
Plugin 'majutsushi/tagbar'
nmap <silent> <F9> :Tagbar<CR>
set updatetime=100
let g:tagbar_autofocus = 1
let g:tagbar_width = 40
let g:tagbar_left = 1



Plugin 'ZoomWin'
noremap <leader>o :ZoomWin<CR>
vnoremap <leader>o <C-C>:ZoomWin<CR>
inoremap <leader>o <C-O>:ZoomWin<CR>



Plugin 'tpope/vim-surround'



Plugin 'vim-scripts/TaskList.vim'
let g:tlTokenList = ['TODO','todo','Todo']



Plugin 'Lokaltog/vim-easymotion'
"let g:Easymotion_smartcase = 0
"let g:Easymotion_use_upper = 1
let g:EasyMotion_do_mapping = 0
nmap <leader>s <Plug>(easymotion-s)
nmap <leader>f <Plug>(easymotion-s2)



Plugin 'DirDiff.vim'
let g:DirDiffExcludes = "CVS,*.class,*.exe,.*.swp,.svn,cscope*,tags"



Plugin 'mileszs/ack.vim'
let g_ack_default_options = " -s -H --color --nogroup --column --smart-case --follow"
let g:ackhightlight = 1
let g:ack_autofold_results = 1
nmap <leader>af :AckFile <C-R>=expand("<cfile>")<CR><CR>
""d: 查找本当前函数调用的函数
nmap <leader>a :Ack <C-R>=expand("<cword>")<CR><CR>



Plugin 'Valloric/YouCompleteMe'
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
"nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>	"force recomile with syntastic
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
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR> " 跳转到定义处



" use to line up text
Plugin 'godlygeek/tabular'
nmap <leader>be :Tabularize /=<CR>
nnoremap <leader>buu :Tabularize /



" Plugin 'scrooloose/syntastic'
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*

" let g:syntastic_always_populate_loc_list = 0
" let g:syntastic_auto_loc_list = 0
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0



" Included are syntax, indent, and filetype file for git, gitconfig,
" gitrebase,and gitsendemail
Plugin 'tpope/vim-git'



Plugin 'tpope/vim-fugitive'
nnoremap <leader>W :Gwrite<CR>
nnoremap <leader>C :Gcommit -v<CR>
nnoremap <leader>S :Gstatus \| 7<CR>
inoremap <leader>W <Esc><leader>W
inoremap <leader>C <Esc><leader>C
inoremap <leader>S <Esc><leader>S



" List the recent files
Plugin 'yegappan/mru'



" ultimate solutions for snippets
Plugin 'Sirver/ultisnips'
Plugin 'honza/vim-snippets'
let g:UltiSnipsExpandTrigger = "<c-l>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"
" let g:UltiSnipsSnippetDirectories=["UltiSnips", "bundle/vim-snippets/UltiSnips"]
autocmd BufWritePre,FileWritePre,BufRead,BufNewFile {*.java} call UltiSnips#AddFiletypes("java")
autocmd BufWritePre,FileWritePre,BufRead,BufNewFile {*.xml} call UltiSnips#AddFiletypes("xml")
autocmd BufWritePre,FileWritePre,BufRead,BufNewFile {*.py} call UltiSnips#AddFiletypes("py")
autocmd BufWritePre,FileWritePre,BufRead,BufNewFile {*.cc,*.h,*c,*.cpp} call UltiSnips#AddFiletypes("cpp")



" " make YouCompleteMe compatible with ultisnips
" Plugin 'ervandew/supertab'
" " make YCM compatible with UltiSnips (using supertab)
" let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
" let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
" let g:SuperTabDefaultCompletionType = '<C-n>'
" " better key bindings for UltiSnipsExpandTrigger
" let g:UltiSnipsExpandTrigger = "<tab>"
" let g:UltiSnipsJumpForwardTrigger = "<tab>"
" let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"



Plugin 'xolox/vim-misc'
Plugin 'xolox/vim-session'
let g:session_autosave='yes'
let g:session_autoload='yes'
let g:session_directory='./'
let g:session_default_name='.session'
let g:session_lock_enabled=0

"'"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Todo use plugins
"'"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""



" Plugin 'SuperTab'
"Plugin 'bogado/file-line'
"Plugin 'junegunn/vim-easy-align'
"Plugin 'vim-scripts/lastpos.vim'
" Programming
" Plugin 'Blackrush/vim-gocode'
Plugin 'fatih/vim-go'
Plugin 'derekwyatt/vim-scala'
Plugin 'tpope/vim-rails'



" Dash.app
Plugin 'rizzatti/funcoo.vim'
Plugin 'rizzatti/dash.vim'


" Syntax highlight
Plugin 'gmarik/vim-markdown'
Plugin 'timcharper/textile.vim'


Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-unimpaired'

" bubble current line
nmap <M-j> ]e
nmap <M-k> [e
" bubble visual selection lines
vmap <M-j> ]egv
vmap <M-k> [egv

" Utility
Plugin 'AndrewRadev/splitjoin.vim'
nmap sj :SplitjoinJoin<cr>
nmap sk :SplitjoinSplit<cr>

Plugin 'gmarik/github-search.vim'

Plugin 'gmarik/ide-popup.vim'
Plugin 'gmarik/sudo-gui.vim'

Plugin 'sjl/gundo.vim'

Plugin 'mkitt/browser-refresh.vim'
com! ONRRB :au! BufWritePost <buffer> :RRB
com! NORRB :au! BufWritePost <buffer>




Plugin 'tomtom/tlib_vim'
Plugin 'tomtom/tcomment_vim'
nnoremap // :TComment<CR>
vnoremap // :TComment<CR>

Plugin 'gmarik/hlmatch.vim'
nnoremap # :<C-u>HlmCword<CR>
nnoremap <leader># :<C-u>HlmGrepCword<CR>
vnoremap # :<C-u>HlmVSel<CR>
vnoremap <leader># :<C-u>HlmGrepVSel<CR>

nnoremap ## :<C-u>HlmPartCword<CR>
nnoremap <leader>## :<C-u>HlmPartGrepCword<CR>
vnoremap ## :<C-u>HlmPartVSel<CR>
vnoremap <leader>## :<C-u>HlmPartGrepVSel<CR>


 
" Plugin 'int3/vim-extradite'
" Plugin 'Lokaltog/vim-powerline'
Plugin 'gregsexton/gitv'
Plugin 'rstacruz/sparkup.git', {'rtp': 'vim/'}
let g:sparkupExecuteMapping = '<c-e>'
let g:sparkupNextMapping = '<c-ee>'



Plugin 'vim-scripts/genutils'



Plugin 'bling/vim-airline'
let g:airline_section_a = airline#section#create(['%<', 'file', 'readonly'])
let g:airline_section_b = '' " airline#section#create_left(['mode', 'paste', 'iminsert'])
let g:airline_section_c = '' " airline#section#create(['hunks'])
let g:airline_section_gutter = airline#section#create(['%=%y%m%r[%{&ff}]'])
let g:airline_section_x = '' " airline#section#create_right(['filetype'])
" let g:airline_section_y = '%y%m%r%=[%{&ff}]' "airline#section#create_right(['ffenc'])
let g:airline_section_z = airline#section#create(['%(%l,%c%V%) %P'])
let g:airline_section_warning = '' "airline#section#create(['whitespace'])


autocmd BufLeave,FocusLost silent! wall






"'"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Deprecated plugins
"'"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin 'vim-scripts/lookupfile'



" taglist.vim"
" Plugin 'vim-scripts/taglist.vim'
" map <silent> <F9> :TlistToggle<CR>
" let Tlist_Use_Right_Window = 1  "右侧显示
" let Tlist_Show_One_File        = 1             " 只显示当前文件的tags
" let Tlist_Exit_OnlyWindow      = 1             " 如果Taglist窗口是最后一个窗口则退出Vim
" let Tlist_File_Fold_Auto_Close = 1             " 自动折叠
" let Tlist_Sort_Type = "name"                   " items in tags sorted by namelet Tlist_WinWidth = 26
" Plugin 'vim-scripts/taglist.vim'
" map <silent> <F9> :TlistToggle<CR>
" let Tlist_Use_Right_Window = 1  "右侧显示
" let Tlist_Show_One_File        = 1             " 只显示当前文件的tags
" let Tlist_Exit_OnlyWindow      = 1             " 如果Taglist窗口是最后一个窗口则退出Vim
" let Tlist_File_Fold_Auto_Close = 1             " 自动折叠
" let Tlist_Sort_Type = "name"                   " items in tags sorted by namelet Tlist_WinWidth = 26



" FuzzyFinder
" Plugin 'L9'
" Plugin 'FuzzyFinder'
" FuF customisations "{{{
" let g:fuf_modesDisable = []
" nnoremap <leader>h :FufHelp<CR>
" nnoremap <leader>1  :FufTagWithCursorWord<CR>
" nnoremap <leader>11 :FufTag<CR>
" nnoremap <leader>2  :FufFileWithCurrentBufferDir<CR>
" nnoremap <leader>22 :FufFile<CR>
" nnoremap <leader>3  :FufBuffer<CR>
" nnoremap <leader>4  :FufDirWithCurrentBufferDir<CR>
" nnoremap <leader>44 :FufDir<CR>
" nnoremap <leader>5  :FufBufferTag<CR>
" nnoremap <leader>55 :FufBufferTagAll<CR>
" nnoremap <leader>6  :FufMruFile<CR>
" nnoremap <leader>7  :FufLine<CR>
" nnoremap <leader>8  :FufChangeList<CR>
" nnoremap <leader>9  :FufTaggedFile<CR>
" nnoremap <leader>p :FufDir ~/src/<CR>
" nnoremap <leader>ge :FufDir ~/.rvm/gems/<CR>
" nnoremap <leader>gn :vnew \| :FufFile ~/src/notes/<CR>



" Plugin 'kien/ctrlp.vim'
" let g:ctrlp_map = '<leader>t'
" let g:ctrlp_max_height = 30
" let g:ctrlp_match_window_bottom=1
" let g:ctrlp_max_height = 20
" let g:ctrlp_match_window_reversed = 1
" let g:ctrlp_switch_buffer = 'e'
" nnoremap <leader>ev :CtrlP app/views<cr>
" nnoremap <leader>ec :CtrlP app/controllers<cr>
" nnoremap <leader>em :CtrlP app/models<cr>
" nnoremap <leader>el :CtrlP lib<cr>
" nnoremap <leader>ea :CtrlP app/assets<cr>
" nnoremap <leader>ep :CtrlP public<cr>
" nnoremap <leader>er :topleft :vsplit config/routes.rb<cr>
" nnoremap <leader>eg :topleft :vsplit Gemfile<cr>
" nnoremap <leader>es :Ctrlp src/
"

" Input method
set iminsert=0
set imsearch=0
se imd
au InsertEnter * se noimd
au InsertLeave * se imd
au FocusGained * se imd
