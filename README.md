Information about my vim notes, configures and plugins

   * [Table of Contents](#table-of-contents)
      * [Configure initial](#configure-initial)
      * [自定义map](#自定义map)
      * [美化插件](#美化插件)
         * [solarized.vim](#solarizedvim)
         * [space-vim-dark](#space-vim-dark)
         * [rainbow_parentheses](#rainbow_parentheses)
      * [普通插件](#普通插件)
         * [vim-plug](#vim-plug)
         * [NERDTree](#nerdtree)
         * [vim-surround](#vim-surround)
         * [delimitMate](#delimitmate)
         * [MatchTagAlways](#matchtagalways)
         * [tabular](#tabular)
         * [TaskkList.vim](#taskklistvim)
         * [vim-easymotion](#vim-easymotion)
         * [DirDiff](#dirdiff)
         * [vim-git](#vim-git)
         * [vim-fugitive](#vim-fugitive)
         * [vim-sessiong](#vim-sessiong)
         * [mru.vim](#mruvim)
         * [vim-auto-save](#vim-auto-save)
         * [vim-expand-region](#vim-expand-region)
         * [vim-airline](#vim-airline)
         * [vimim中文输入法](#vimim中文输入法)
         * [Snippet](#snippet)
         * [fcitx.vim](#fcitxvim)
         * [asyncrun.vim](#asyncrunvim)
      * [依赖包的插件](#依赖包的插件)
         * [tagbar](#tagbar)
         * [vim-latex-suite](#vim-latex-suite)
         * [ag.vim](#agvim)
         * [cscope](#cscope)
         * [YouCompleteMe](#youcompleteme)
            * [auto install(recommend)](#auto-installrecommend)
            * [manual install](#manual-install)
            * [使用配置](#使用配置)
      * [Deprecated plugins](#deprecated-plugins)
         * [taglist.vim](#taglistvim)
         * [FuzzyFinder](#fuzzyfinder)
      * [Plugin for java and android](#plugin-for-java-and-android)
      * [vim help](#vim-help)
         * [跳转移动光标](#跳转移动光标)
         * [插入](#插入)
         * [删除进入Normal模式](#删除进入normal模式)
         * [复制与寄存器](#复制与寄存器)
         * [粘贴与寄存器](#粘贴与寄存器)
         * [visual模式](#visual模式)
         * [移动多行](#移动多行)
         * [代码折叠](#代码折叠)
         * [翻屏](#翻屏)
         * [文件](#文件)
         * [窗口操作](#窗口操作)
         * [vimdiff](#vimdiff)
         * [tab标签](#tab标签)
         * [set autochdir](#set-autochdir)
         * [recent old files](#recent-old-files)
         * [mark](#mark)
         * [vim和shell](#vim和shell)
         * [宏](#宏)
         * [帮助](#帮助)
         * [setting](#setting)
         * [替换](#替换)
         * [查找](#查找)
         * [vim EX mode](#vim-ex-mode)
         * [vim tags](#vim-tags)
         * [设置保存编码格式](#设置保存编码格式)
         * [vim打开16进制](#vim打开16进制)
         * [vim buffer](#vim-buffer)
         * [加密/解密文件](#加密解密文件)
         * [长行断行/整行](#长行断行整行)

## Configure initial

```
# clone recursively with vundle
git clone https://github.com/tainzhi/Q-vimfile.git ~/.vim
# run vim and install plugins
vim .vim/vimrc +PlugUpdate +qall                     
```
## Support multi languages
- YouCompleteMe
    - [x] c/cpp
    - [x] python
- Snippets
    - [x] python
- ale
    - [x] c/cpp
    - [x] python
- codequery: get tag and cscope database 
    - [x] c/cpp
    - [x] python
- shorts cuts **F9** and **F10**
    - [x] c/cpp
    - [x] python
    - [x] latex
    - [x] dot
- auto add file head containing author's information
    - [x] shell script
    - [x] text
    - [x] c/cpp
    - [x] python
    - [x] java


## 自定义map
```
my <leader> is ,
<leader>h       打开光标所在的单词的help

" resize the window
nmap w= :resize +3<CR>
nmap w- :resize -3<CR>
nmap w, :vertical resize +3<CR>
nmap w. :vertical resize -3<CR>

<C-A>       select all
<C-C>       copy
<C-V>       paste


<leader>ct :cs find t  找到这个string
<leader>cf :cs find f  找到一个文件

<ctrl-w>o :ZoomWin<CR>  缩放当前窗口

<leader>s       Easymotion一个字符
<leader>f       Easymotions二个字符

<leader>af      :AckFile查找当前光标所在的文件
<leader>a       :Ack查找当前字符

nnoremap // :TComment<CR>   注释
```

<table>
    <tr>
        <td>key</td>
        <td>language</td>
        <td>usge</td>
        <td>map</td>
    </tr>
    <tr>
        <td>F1</td>
        <td></td>
        <td>buntu show help</td>
        <td></td>
    </tr>
    <tr>
        <td>F2</td>
        <td></td>
        <td></td>
        <td>nmap <silent> <F2> :Tagbar<CR></td>
    </tr>
    <tr>
        <td>F3</td>
        <td></td>
        <td>toggle NERDTree</td>
        <td>nmap <silent> <F3> :NERDTreeToggle<CR></td>
    </tr>
    <tr>
        <td>F4</td>
        <td></td>
        <td>reload cscope database and recreate tags</td>
        <td>for python use pycscope, for c/cpp use clang</td>
    </tr>
    <tr>
        <td>F8</td>
        <td>python</td>
        <td>format python source code with autopep8</td>
        <td></td>
    </tr>
    <tr>
        <td rowspan="4">F9</td>
        <td>c/cpp</td>
        <td>compile the file</td>
        <td>g++ %</td>
    </tr>
    <tr>
        <td>tex</td>
        <td>compile the tex</td>
        <td>xelatex</td>
    </tr>
    <tr>
        <td>python</td>
        <td>python</td>
        <td>AsyncRun</td>
    </tr>
    <tr>
        <td>dot</td>
        <td>compile th dot file, then get a jpg picture</td>
        <td></td>
    </tr>
    <tr>
        <td rowspan="4">F10</td>
        <td>c/cpp</td>
        <td>run the a.out compiled from souce code</td>
        <td>./a.out &lt; a.in</td>
    </tr>
    <tr>
        <td>tex</td>
        <td>open the pdf file generaged by xelatex</td>
        <td></td>
    </tr>
    <tr>
        <td>python</td>
        <td>stop runing the file and close quickfix</td>
        <td>:AsyncStop</td>
    </tr>
    <tr>
        <td>dot</td>
        <td>open the file generaged by graphviz</td>
        <td></td>
    </tr>
    <tr>
        <td>F11</td>
        <td></td>
        <td>ubuntu maxium window</td>
        <ted></td>
    </tr>
    <tr>
        <td>F12</td>
        <td></td>
        <td>显示结尾符号</td>
        <td>map &lt;silent&gt; &lt;F12&gt; :set invlist&lt;CR&gt;</td>
    </tr>
</table>


快捷键与需要注意的地方
```
.           重复上次操作命令
,       	repeat latest f, t, F or T [count] times
;           repeat lates f, t, F or T in opposite direction [count] times
0	        jump to the begin of line
''          jump to preview position
```
- 1 因为fs影射了cscope的快捷操作, 所以使用f查找s, 不能连续快速按fs, 要再f和s之间停顿一下
- 2 我的&lt;leader&gt;修改为空格键

添加新语言的快捷键F9支持, 即添加新的语言autocmd识别
```
autocmd BufWritePre,FileWritePost,BufReadPost,FileReadPost *.cc,*.c,*.cpp,*.h,*.tex,*py call Do_Map()
autocmd BufNewFile *.sh,*.txt,*.[ch],*.cpp,*.cc,*.python,*.java,*.py exec ":call Do_Set_Title()" 
```



## 美化插件
### solarized.vim
[solarized.vim](http://ethanschoonover.com/solarized/vim-colors-solarized)
```
" Colorscheme
Plug 'altercation/vim-colors- '
if has("gui_running")
  set background=light
  colorscheme solarized
else
  set background=dark
endif
```

### space-vim-dark

[space-vim-dark](https://github.com/liuchengxu/space-vim-dark)

a theme for terminal

### rainbow_parentheses
[rainbow_parentheses](https://github.com/kien/rainbow_parentheses.vim)
hight the parentheses

## 普通插件

### vim-plug
[vim-plug](https://github.com/junegunn/vim-plug) is a faster plugin manager than [vundle](https://github.com/VundleVim/Vundle.vim). And it supports parallel installation/update.

- Some settings
```
post update hooks"
Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }
```
 
- Usage
```
:PlugInstall    update the new add plug, and not upgrade exsiting plugs.But your should reload the vimrc first
:PlugUpdate     install and update 
:PlugClean[!]   remove unused directories
:PlugStatus     check the status of plugins
```


### NERDTree
**Usage**:
```
?       toggle help
m       Show the menu, then rename or create a file

:NERDTree 
:NERDTreeToggle
```
If a NERD tree already exists for this tab, it is reopened and rendered again.  If no NERD tree exists for this tab then this command acts the same as the :NERDTree command. 


### vim-surround

[vim-surround](https://github.com/tpope/vim-surround)
快速加环绕符号

```
ds"             删除"，此处"可以为任何符号,从光标所在处到单词末尾
cs"<p>          替换"为<p>
ysw(            添加()
```

### delimitMate
[delimitMate](https://github.com/Raimondi/delimitMate)
This plug-in provides automatic closing of quotes, parenthesis, brackets, etc., besides some other related features that should make your time in insert mode a little bit easier, like syntax awareness (will not insert the closing delimiter in comments and other configurable regions), and expansions (off by default), and some more.


### MatchTagAlways
[MatchTagAlways](https://github.com/Valloric/MatchTagAlways)
This plugin makes "%" command jump to match HTML tags, if/else/endif in vim scripts, etc

### tabular
[godlygeek/tabular](https://github.com/godlygeek/tabular)
对齐
```
<leader>be      以等号对齐
<leader>bu      自定义符号
```
以空格号对齐
```
:Tabularize / /l0c5r0<CR>       以空格对齐，居中，插入5个空格
```

### TaskkList.vim
[TaskList.vim](https://github.com/vim-scripts/TaskList.vim/blob/master/plugin/tasklist.vim)
todolist
```
<leader>t
```


### vim-easymotion
[vim-easymotion](https://github.com/Lokaltog/vim-easymotion/)
当前页面内快速跳转
```
<leader>s       查找一个字母，并跳转
<leader>f       查找两个字母，并跳转
```

### DirDiff
[DirDiff](https://github.com/vim-scripts/DirDiff.vim)
file or directory compare
```
:DirDiff directory1 directory2
```

### vim-git
[vim-git](https://github.com/tpope/vim-git)###
Included are syntax, indent, and filetype plugin files for git, gitcommit, gitconfig, gitrebase, and gitsendemail. 

### vim-fugitive
[tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)
```
:Gstatus            
:Gdiff              # diff current file
```
### vim-sessiong
[vim-session](https://github.com/xolox/vim-session)
[vim-misc](https://github.com/xolox/vim-misc)
**vim-session plug-in requires my vim-misc plug-in**
recover vim session, where is the key and the tab statues
before, must install [vim-misc](https://github.com/xolox/vim-misc)
```
:SaveSession
:OpenSession
```
### mru.vim
[mru.vim](https://github.com/yegappan/mru)###
provides an easy access to a list of recently opened/edited files in Vim.
```
:MRU
```
If you are using GUI Vim, then the names of the recently edited files are 
added to the "File->Recent Files" menu

### vim-auto-save
使用plugin, 这种方法, 都会自动保存到文件中, 没有swp文件冲突提示
```
Plugin 'vim-scripts/vim-auto-save'
let g:auto_save = 1     " enable AudoSave on Vim startup
let g:auto_save_no_updatetime = 1
let g:auto_save_in_insert_mode = 0
" let g:auto_save_silent = 1
" let g:auto_save_postsave_hook = 'TagsGenerate'
```

不使用plugin, [References: vim wikia](http://vim.wikia.com/wiki/Auto_save_files_when_focus_is_lost)
```
:set autowrite
or
:au FocusLost * silent! wa
:autocmd CursorHold,CursorHoldI * update
```

### vim-expand-region
[vim-expand-region](https://github.com/terryma/vim-expand-region)
```
K   expand select block
J   shrink select block
```

### vim-airline
[vim-ariline](https://github.com/vim-airline/vim-airline)
```
<leader>d N                 delete buffer N
<leader>d 1 2 3             delete buffer 1 2 3
<leader>1, 2, ..., 9        jump to buffer 1, 2, ..., 9
```

- the small number is buffer likes tab number, use with `<leader>1, 2, ..., 9`
- the large number is real buffer number, use with `:bdelete 1`, delete buffer
- `:tabnew`产生新的窗口, 有3个数字了, 直接`:q`退出, 但是会保留一个2个数字的buffer


### vimim中文输入法
[vimim](https://github.com/tainzhi/vimim)
查找文本中的`项目`这一词组, 先查找`/xiangmu`, 然后输入回车, 此时没有匹配结果, 然后输入查找下一个

### Snippet
[snippet](https://github.com/honza/vim-snippets)

usage: the default trigger
```
   g:UltiSnipsExpandTrigger               <tab>
   g:UltiSnipsListSnippets                <c-tab>
   g:UltiSnipsJumpForwardTrigger          <c-j>
   g:UltiSnipsJumpBackwardTrigger         <c-k>
```

- `snippets/*`: snippets using snipMate format
- `UltiSnips/*`: snippets using UltiSnips format

### fcitx.vim
[fcitx.vim](https://github.com/lilydjwg/fcitx.vim)

方便在vim中使用中文输入法. 如果在输入模式, 输入中文, 然后Esc返回normal模式, 不用切换输入法, 也能使用各种vim命令, 然后再次返回输入模式, 直接输入中文, 不用切换输入法

### asyncrun.vim
[asyncrun.vim](https://github.com/skywind3000/asyncrun.vim)

This plugin takes the advantage of new apis in Vim 8 (and NeoVim) to enable you to run shell commands in background and read output in the quickfix window in realtime:

but with use of it, you should open quickfix window, `:copen`

You also can open quickfix window after you trigger the command. [Reference](https://github.com/skywind3000/asyncrun.vim/wiki/FAQ#automate-opening-quickfix-window)

```
:AsyncRun gcc % -o %<
:AsyncRun! grep -R word
:Asynctop       # stop async jobs
```

### undotree
[undotree](https://github.com/mbbill/undotree) show the undolist in a tree structure
```
:UndotreeToggle
nnoremap <leader>un :UndotreeToggle<CR>   #open or hide
u
<ctrl+r>
g+
g-  browese the undo item in the list

?   open help panel
```

### vim-python-pep8-indent
[vim-python-pep8-indent](https://github.com/Vimjas/vim-python-pep8-indent)


### indentLine

[indentLine](https://github.com/Yggdroot/indentLine)


## 依赖包的插件
### tagbar
[tagbar](https://github.com/majutsushi/tagbar)
**依赖包：ctags**

tagbar按作用域归类不同的标签。按名字空间 n_foo、类 Foo 进行归类,在内部有声明、有定义;
显示标签类型。名字空间、类、函数等等;
显示完整函数原型;
图形化显示共有成员(+)、私有成员(-)、保护成员(#);
**Usage**
```
s       Toggle sort order between name and file order
```

### vim-latex-suite
[vim-latex-suite](https://github.com/gerw/vim-latex-suite)


### ag.vim
[ag.vim](https://github.com/rking/ag.vim)

[vim-action-ag](https://github.com/Chun-Yang/vim-action-ag): 使得普通模式的搜索(按*键)即可全工程搜索
```
:Ag str
:LAg str        search in quickfix
```
**依赖包: [ag](https://github.com/ggreer/the_silver_searcher)**

### cscope
[autoload_cscope](https://github.com/tainzhi/autoload_cscope.vim)

依赖包: cscope

**usage**:
```
set nocst    "在cscope数据库添加成功的时候不在命令栏现实提示信息.
set cspc=6 "cscope的查找结果在格式上最多显示6层目录.
let g:autocscope_menus=0 "关闭autocscope插件的快捷健映射.防止和我们定义的快捷键冲突.
"个人cscope的快捷键映射
""cscope相关的快捷键映射
"s:查找即查找C语言符号出现的地方
nmap fs :cs find s <C-R>=expand("<cword>")<CR><CR>
"g:查找函数、宏、枚举等定义的位置
nmap fg :cs find g <C-R>=expand("<cword>")<CR><CR>
"c:查找光标下的函数被调用的地方
nmap fc :cs find c <C-R>=expand("<cword>")<CR><CR>
""t: 查找指定的字符串出现的地方
nmap ft :cs find t <C-R>=expand("<cword>")<CR><CR>
"e:egrep模式查找,相当于egrep功能
nmap fe :cs find e <C-R>=expand("<cword>")<CR><CR>
""f: 查找文件名,相当于lookupfile
nmap fn :cs find f <C-R>=expand("<cfile>")<CR><CR>
""f: 查找文件名,相当于lookupfile
nmap ff :cs find f <C-R>=expand("<cword>")<CR><CR>
"i: 查找当前文件名出现过的地方
nmap fi :cs find i <C-R>=expand("<cfile>")<CR><CR>
""d: 查找本当前函数调用的函数
nmap fd :cs find d <C-R>=expand("<cword>")<CR><CR>
```
### ale

[ale](https://github.com/w0rp/ale), a asynchonous syntax checker

```
# moving between warnings and errors quickly.
nmap <silent> <C-p> <Plug>(ale_previous_wrap)
nmap <silent> <C-n> <Plug>(ale_next_wrap)
```

### YouCompleteMe
[YouCompleteMe](https://github.com/Valloric/YouCompleteMe)
**依赖包：clang**
- 自动补全名称和目录路径， 支持c/c++,python,node.js,JavaScript,go
- 实时检测并显示c/c++语法错误
[Support Node.js and JavaScript](https://github.com/Valloric/YouCompleteMe#ubuntu-linux-x64)

**usage**
>tab键选中，Ctrl+P/N选择
<leaer>jd   跳转到定义处
Ctrl+O      jump backword
Ctrl+I      jump forward

#### auto install(recommend)
```
cd ~/.vim/bundle/YouCompleteMe
python3 ./install.py --clang-completer --gocode-completer --tern-completer --racer-completer
```

#### manual install
install clang pre-buildt binaries(recommend)
一种是直接拷贝
```
tar xf clang*
cd clang*
sudo cp -R * /usr/local/
```
另一种是， 把bin添加到path文件中
```
export PATH=~/clang+llvm-3.2-x86_64-linux-ubuntu-12.04/bin/:$PATH
```
install clang by binary source
***编译clang3.5**
[参考1](http://www.cnblogs.com/zhongcq/p/3630047.html)
[参考2](http://hahaya.github.io/build-YouCompleteMe/)
[参考2官网指导](http://clang.llvm.org/get_started.html)
从[llvm官网](http://llvm.org/releases/download.html#3.3)下载
要提前安装cmake和python-dev
```
sudo apt-get install g++4.8 cmake python-dev
```
**the directory structure**
```
~/
|----.vim
|        |----bundle
|                |----vundle
|                |----YouComplteMe
|-----Downloads
        |----clang
        |       |----llvm-3.5.0.src
        |       |----llvm-build
        |----ycm_build

```
> in `llvm-build`, clang is maked and installed, in `ycm_build`, the .so files which is needed by YouComplteMe is created by clang 

用`tar Jxvf`解压后
```
tar xJvf cfe-3.5.0.src.tar.xz
tar xJvf clang-tools-extra-3.5.0.src.tar.xz
tar xJvf compiler-rt-3.5.0.src.tar.xz
tar xJvf llvm-3.5.0.src.tar.xz
```
编译和安装
```
mv cfe-3.5.0.src llvm-3.5.0.src/tools/clang
mv clang-tools-extra-3.5.0.src/ llvm-3.5.0.src/tools/clang/extra/
mkdir llvm-build
cd llvm-build
../llvm-3.5.0.src/configure --enable-optimized  #要编译很久，大约最终有1个G的文件；默认编译目录为/usr/local/
可执行文件放在/usr/local/bin/，库文件放在/usr/local/lib
make -j 9
sudo make install

# 非必须
make uninstall
clang -v
```
最后一步 编译YouCompleteMe插件

```
cd ~
mkdir ycm_build
cd ycm_build
cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=/home/muqing/Downloads/clang+llvm-3.9.0-x86_64-linux-gnu-ubuntu-16.04 . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
cmake --build . --target ycm_core --config Release
```

注意：　`-DPATH_TO_LLVM_ROOT=`为自定义clang+llvm位置

#### 使用配置
在`vimrc`中设置
```
let g:ycm_confirm_extra_conf = 0            #自动载入.ycm_extra_conf.py,
let g:ycm_server_python_interpreter = '/usr/bin/python2.7'      #选择python2.7,prevent YouComplteMe from not working
```

然后**在所要编辑的父目录拷贝一份.ycm_extra_conf.py, 并根据c/c++修改flags和路径
c/c++的头文件在`/usr/include`目录下**
```
cp ~/linux_config/vimfile/bundle/YouCompleteMe/third_party/ycmd/examples/.ycm_extra_conf.py ~/Program/
```
并修改`flags`
```
flags = [
    '-isystem', '/home/sehe/custom/boost',
    '-isystem', '/usr/lib/gcc/x86_64-linux-gnu/4.8/include',
]
```
现在在`~/Program`目录下就可以自动补全`stdlib.h`

### Syntastic
[syntastic](https://github.com/vim-syntastic/syntastic)
实时检测语法错误, 支持c/c++, python, java, html, javascript...
但是需要第三方检测工具支持, 具体使用以下命令
```
:help syntastic-checker
```
一经保存,就会显示错误窗口quickfix
```
nnoremap <Leader>an :lnext<cr>
nnoremap <Leader>ap :lprevious<cr>
```
因为要保存之后才能显示检测结果, 所以对于c/c++使用YouComplteMe的检测功能,不用保存就可以显示语法错误. (打开YouCompleteMe的检测功能, 默认不显示syntastic的检测功能)
```
let g:ycm_show_diagnostics_ui = 1
```

## Deprecated plugins ##
### taglist.vim
[vim-scripts/taglist.vim](https://github.com/vim-scripts/taglist.vim)

### FuzzyFinder
[FuzzyFinder](http://www.vim.org/scripts/script.php?script_id=1984): 查找文件，路劲，buffer等

### Syntastic
[syntastic](https://github.com/vim-syntastic/syntastic)
实时检测语法错误, 支持c/c++, python, java, html, javascript...
但是需要第三方检测工具支持, 具体使用以下命令
```
:help syntastic-checker
```
一经保存,就会显示错误窗口quickfix
```
nnoremap <Leader>an :lnext<cr>
nnoremap <Leader>ap :lprevious<cr>
```
因为要保存之后才能显示检测结果, 所以对于c/c++使用YouComplteMe的检测功能,不用保存就可以显示语法错误. (打开YouCompleteMe的检测功能, 默认不显示syntastic的检测功能)
```
let g:ycm_show_diagnostics_ui = 1
```

## Plugin for java and android
[eclim](http://eclim.org/)

[download](http://sourceforge.net/projects/eclim/files/eclim/2.4.0/eclim_2.4.0.jar/download)

Install && Configure, 在.vimrc中设置
```
set nocompatible
filetype plugin indent on
```

启动eclim server
```
运行`$EclipseHome/eclimd`
在vim中`PingEclim`
```

## vim help


### 跳转移动光标
```
zz              当前行居于屏幕正中
zt              当前行居于屏幕下方
zb              当前行居于屏幕上方

H           move cursor to top screen, only the cursor, not the screen
M           move cursor to middle of screen
L           move cursor to bottom of screen

Ctrl + i                后退
Ctrl + o                前进
Ctrl + ]                jump to declaration
Ctrl + t                back to the impletention

Ctrl+]  jump to the definiton(hyperlink) in vim help scripts

0				跳转到一行的开始（最右端）
$				跳转到一行的末尾
^				跳转到一行的开始（有输入的地方）

w				跳转到下一个单词的第一个字符
e				跳转到下一个单词的最后一个字符
b				跳转到前一个单词的第一个字符

W				跳转到下一个长词的第一个字符
E				跳转到下一个长单词的最后一个字符
B				跳转到前一个长单词的第一个字符

(				跳转到前一句的开始处
)				跳转到后一句的开始处

{       光标移动到段落开头
}       光标移动到段落结尾
    
gD		跳转到局部变量的定义处
''      跳转到局部变量的定义处标上次停靠的地方
[[,]]   跳转到代码块的开头去(代码中{单独占一行)

Space           光标右移一个字符
Backspace       光标左移一个字符

nG      光标移动到第n行首

n+      光标下移n行
n-      光标上移n行
4j      向下移动4行
```

### 插入
```
i   在光标前插入
a   在光标后
I   在行首插入
A   在行尾插入
o   在当前行之下新开一行
O   在当前行之上新开一行
r   替换当前字符
R   替换当前字符及其后的字符，直至按ESC键
ncw     删除指定数目的词，并进入Insert模式

C		从光标当前位置到改行末尾
cc		修改从光标当前行起始位到改行末尾
3C		从光标当前位置到3行末尾范围内的内容

s		用随后书输入的文本替换当前光标所在的字符
S		用新输入的正文替换当前行（整行)
cw  	替换光标所在的那个字，并输入
```

### 删除进入Normal模式
```
D				从光标当前位置到改行末尾
dd				修改从光标当前行起始位到改行末尾
3D				从光标当前位置到3行末尾范围内的内容
ndw     删除指定数目的单词
d^      删至行首
d$      删至行尾
x或X    删除一个字符
```


### 复制与寄存器
```
y		把内容复制到“粘贴板里
ynw     复制n个单词
ynl     复制n个字符
y$      复制当前光标至行尾

yy          # 默认拷贝当前行到x寄存器
[count]yy   # 拷贝count行到x寄存器
["a]y      # 拷贝到a寄存器
```

### 粘贴与寄存器
```
:reg        查看12个粘贴版板里的内容
"?nyy       将当前行即其下n行的内容保存到寄存器？中
"?nyw       将n个字保存到寄存器？中
"nyl        将n个字符保存到寄存器？中
"?p         取出寄存器？中的内容并放在光标未位置处
p			用p粘贴”粘贴板里的内容

p                       put the yanked text after the cursor
P(upper case)           put the text before the cursor
:pu                     put the text before the current line
:pu!                    put the text below the current line

“Ny			把内容粘贴到N粘贴板里
”Np			粘贴N粘贴板里的内容

+			系统粘贴板
+p			粘贴系统全局粘贴板里的内容
```
### visual模式
```
v               单词visual模式
V               行visual模式
viw             选中innner word
vit             选中标签内所有单词，多用于xml
r|              替换选中的char为|
o/e             在选中部分前后跳转
```

### 移动多行
```
>			输入此命令则光标所在行向右移动一个 tab.
5>>			输入此命令则光标后 5 行向右移动一个 tab.
:<<<		move current line 3 indents to the left
:>> 5		move 5 lines 2 indents to the right

:5>>		move line 5 2 indents to the right
:12,24>			将12行到14行的数据都向右移动一个 tab.
:12,24>>		将12行到14行的数据都向右移动两个 tab.

Vjj4>		move three lines 4 indents to the right
```

### 代码折叠
```
(1)折叠方式：set fdm=××××。每种折叠方式不兼容

    indent		更多的缩进表示更高级别的折叠		
    expr		用表达式来定义折叠
    syntax		用语法高亮来定义折叠
    diff		对没有更改的文本进行折叠
    marker		对文中的标志折叠

(2)使用indent方式，vim会自动的对大括号的中间部分进行折叠

    在可折叠处（大括号中间）
    zc		折叠
    zC		对所在的范围内所有的嵌套的折叠点进行折叠
    zo		展开折叠
    zO		对所在范围内所有的嵌套的折叠点展开
    [z		到当前打开的折叠的开始处
    z]      到当前打开的折叠的末尾处
    zj		向下移动。到达下一个折叠的开始处
    zk		向上移动到前一折叠的结束处

(3)marker方式，需要用标识代码的折叠，系统默认的是{{{和}}}，最好不要改动之

    zf      	创建折叠，比如在marker方式下：
    zf56G，		创建从当前行起到56行的代码折叠；
    10zf或10zf+或zf10↓创建从当前行起到后10行的代码折叠。
    10zf-或zf10↑	创建从当前行起到之前10行的代码折叠。
    zf%		创建从当前行起到对应的匹配的括号上去（（），{}，[]，<>等）
    zd      	删除 (delete) 在光标下的折叠。仅当 'foldmethod' 设为 
            "manual" 或 "marker" 时有效。
    zD     		循环删除 (Delete) 光标下的折叠，即嵌套删除折叠。仅当 
            'foldmethod' 设为 "manual" 或 "marker" 时有效。
    zE     		除去 (Eliminate) 窗口里“所有”的折叠。仅当'foldmethod'
            设为 "manual" 或 "marker" 时有效。
```

### 翻屏
```
ctrl-f ctrl-b		正页翻屏，f就是forword b就是backward
ctrl-d ctlr-u		翻半页，d=down u=窗口up
ctrl-e ctrl-y		滚一行
zz 			让光标所在的行居屏幕中央
zt			让光标所在的行居屏幕最上一行 t=top
zb 			让光标所在的行居屏幕最下一行 b=bottom
nz          将第n行滚至屏幕顶部，不指定n时将当前行滚至屏幕顶部
```


### 文件
```
：tabnew ~/Desktop/note			在新标签中打开note文件
~/a.txt		编辑新文件
:qa(:wa)(:wpa)		quit all the file(write al the files)
:e file     在当天标签下打开file
:edit       文件重载
:x          保存并退出

set modifiable                 编辑状态更改

文件间切换
Ctrl+6—下一个文件
:bn—下一个文件
:bp—上一个文件
:b num	标号为num的文件
:b#	上一个buffer所在的文件
对于用(v)split在多个窗格中打开的文件，这种方法只会在当前窗格中切换不同的文件。

文件浏览
:Ex 开启目录浏览器，可以浏览当前目录下的所有文件，并可以选择
:Sex 水平分割当前窗口，并在一个窗口中开启目录浏览器
:ls 显示当前buffer情况

:sp(:vsp) a.txt		分割窗口，并打开a.txt
:set diff			比较
:split otherfile    水平分割显示文件
:vsplit     垂直分割显示文件


:vertical diffsplit file_name		"the new file is on the left
]c([c)				move among all the difference
2]c					jump to the 2rd difference
```

### 窗口操作
```
# my key map
w=          # increase current window height by 3
w-          # decrease current window height by 3
w,          # increate current window height vertically by 3
w.          # increase current window height vertically by 3

:h window

:split      # horizontally split the window
:vsplit     # vertically split the window
:vsp        # same to :vsplit

:Ctrl+W+h/j/k/l     # move cursor to the window(left, top, botton, right)
:Ctrl+W+t   # move cursor to top-left window
:Ctrl+W+b   # move cursor to bottom-right window
:Ctrl+W+p   # move cursor to previews window
:Ctrl+W Ctrl+W  # move cursor without count

:res[ize] -N
:vert[ical] res[ize] -N
CTRL-W -    # Decrease current window height by N. 

:res[ize] +N
:vert[ical] res[ize] +N
CTRL-W +    # Increase current window hegith by N.
```

### vimdiff
launch
```
vim -d 1file 2file
vimdiff 1file file
```
or
```
vim 1file
:vertical diffsplit 2file
:vert diffsplit anthother.file
```
mouse move
```
:set noscrollbind
:set scrollbind
]c      jump to next difference
[count][c      jump to previews difference
```
file merge
```
dp (diff "put")     copy the difference to the other file
do (diff "get")     copy the difference to the current file
```
update

```
:diffupdate         after the merge and update
```
folder

```
:set diffopt=context:3          缺省的上下文行数
zo      (folding open)
zc      (folding close)
```

### tab标签
```
:tab split filename	这个就用tab的方式来显示多个文件 (use tab to display buffers)
gt	到下一个tab (go to next tab)
gT	到上一个tab (go to previous tab)
0gt	跳到第一个tab (switch to 1st tab)
5gt	跳到第五个tab (switch to 5th tab)
:tabdo command       在所有的tab文件中运行command, eg. `:tabdo %s/abc/def/g`把所有的tab文件中的abc替换位def

set tags and jump to tags
```


### set autochdir
设置当前路路径，方便删除，新建文件
```
set autochdir               #设置路径随当前编辑的文件的路径
:cd                         # vim
:lcd
:pwd                        #查看路径
```

### recent old files
```
:browse old
:browse oldfiles
```
### mark
m后加26个字符，大写global, 小写local buffer
```
`m          跳转到标记位置
'm          跳转到标记位置所在行
''          跳转到jump的last位置
`.          跳转到last change
```
### vim和shell
```
:!command   执行shell命令
:r!command  将command的输出结果放到当前行
:shell 可以在不关闭vi的情况下切换到shell命令行
:sh
:exit 从shell回到vi
```

### 宏
```
qa				（Normal模式）开始录制宏a
q				（Normal模式）结束宏的录制
@a			 	使用宏
10@a        in visual mode, enter escape key, normal @a
```

### 帮助
```
:help keycodes		解释符号
:helptags /usr/share/vim/vim/73/doc  : 重建 /doc 中所有的 *.txt 帮助文件
```

### setting
```
:set ignorecase     不区分大小写
:sy clear			取消语法高亮
:set guifont=Monospace\ 12      字体设置
:set guifont=*	
	
:colorscheme tesla  修改主题为tesla
```


### 替换
```
:s/p1/p2/g              #replace all p1 with p2 in current line
:%s/p1/p2/g             #replace all p1 with p2 in the file
:1,10s/p1/p2/g          #replcae all p1 with p2 between 1-10 line, inlucding
:.,$s/foo/bar/g         #replace each 'foo' to 'bar' for all lines from the current line (.) to the last line ($) inclusive.
:,+3s/Video/video/g     #replace Video with video in the following 3 lines

:g/pattern/d            # delete the lines which has pattern, then delete it
:g/error\|warn/d        # delete the lines which has error or warn
:v/pattern/d            # v likes g!, delete the lines which doesnot has pattern, then delete it
:7, 150g!/pattern/d     # g! is same as v

:%s/xxx//gn     #统计xxx个数，n表示只报告匹配的个数而不进行实际的替换。
:help :v
:help :g
```
### 查找
```
/xxx(?xxx)      / 向上查找，？ 向下查找， xxx 为正则表达式, 默认区分大小
*(#)            当光标停留在某个单词上时, 查找与该单词匹配的, n(*)查找下一处，N(#)查找上一处
g*(g#)          匹配包含该单词的所有字符串.
gd              本命令查找与光标所在单词相匹配的单词, 并将光标停留在文档的非注释段中第一次出现这个单词的地方.
%               本命令查找与光标所在处相匹配的反括号, 包括 () [] {}
f(F)x           本命令表示在光标所在行进行查找, 查找光标右(左)方第一个x字符.
/xxx\c          忽略大小写查找
:%s/apple//gn   查找次数统计
:.,$s/action//  查找当前行到最后一行的action
/\<\d\>         查找单个数字, \<表示单词开头, \d表示一个数字, \>表示单词结尾 
```

show search result
```
:g/example
# the same as
:g/exampel/p
# it's longer form
:global/regular-expression/print
```
show search result with quickfix buffer

[References](http://stackoverflow.com/questions/509690/how-can-you-list-the-matches-of-vims-search)

```
:vimgrep example %
:grep example % 
:copen # list the result all in the quickfix buffer
:cclose
:cn         # go back or forth in current window     
:cp
Enter key   # press enter on a particular line to jump to that match
```

### vim EX mode
```
Q       # enter to Ex mode, like : command, but not leave it, until you type :visual
:visual # leave Ex mode
```
### vim tags
```
:tag indent                    # Jump to the definition of {indent}
g<LeftMouse>
<C-LeftMouse
Ctrl-]                      # Jump to the definition of the keyword under the cursor
g<RightMouse>
<Ctrl-RightMouse>
Ctrl-[                      # 往回跳转stack

:tags                       # show the contents of the tag stack

:tpreviouse
:tnext                      # Jump to the next tag
:[count]tag                 # Jump to the count tag
```

### 设置保存编码格式
```
:set fenc=utf-18            # 设置保存编码格式
```

### vim打开16进制
```
:%!xxd
:%!xxd -r   #16进制到二进制
```

### vim buffer
buffer是类似与tab一样的存在, 但是又有区别. tab是layout, buffer是缓冲区. **如果关闭当前buffer, 则会退出vim**
```
:bdelete N      close buffer, N is number
:bnext          jump to next buffer
:bprevious      jump to previous buffer
:ls             show all buffers
:ls!            show all buffers, included hidden buffers
```

- NERDTree在buffer中打开
- buffer number是不同于tab number的
- vim-airline会显示buffer状态, 包括buffer number

### 加密/解密文件
创建文件时加密, 输入密码
```
vim -x test.txt
```
创建文件时没有加密, 可以在保存之前
```
:X          #然后输入密码
:w          #保存, 然后退出
```
取消加密
```
set key=    #直接回车, 然后保存退出
```

### 长行断行/整行
```
:set wrap   #断行, 很长的一行, 分成几行完全显示
:set nowrap #默认设置; 无论多长, 单行显示, 只显示屏幕可以显示的部分
```

