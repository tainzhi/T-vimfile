Information about my vim notes, configures and plugins

## Configure initial

### for linux
```
# clone recursively with vundle
git clone https://github.com/tainzhi/Q-vimfile.git ~/.vim
# run vim and install plugins
vim .vim/vimrc +PlugUpdate +qall                     
```

### for windows
```
# clone recursively with vundle
git clone https://github.com/tainzhi/Q-vimfile.git %userprofile%\vimfiles
vim %userprofile%\vimfiles\vimrc +PlugUpdate +qall                     
```

### 其他
为了特定插件的使用，最好安转以下软件或做好配置
#### 安转python
为了使得vim能正常使用python，最好通过查询一下vim所支持的python版本
在vim中使用命令`:version`，找到`-DDYNAMIC_PTTHON`相关的字段，找到python版本的库，就是该vim编译所用的python库。
并在`~/.vimrc`中修改python路径
```
let g:ycm_server_python_interpreter = 'python'
let g:ycm_python_binary_path = 'c:\Python35\python'
```

#### ctags配置，通过插件tagbar显示markdown文件预览
无论在windows还是linux下都需要添加`~/.ctags`, 内容如下
```
--langdef=markdown
--langmap=markdown:.md
--regex-markdown=/^#{1}[ \t]*([^#]+.*)/. \1/h,headings/
--regex-markdown=/^#{2}[ \t]*([^#]+.*)/.   \1/h,headings/
--regex-markdown=/^#{3}[ \t]*([^#]+.*)/.     \1/h,headings/
--regex-markdown=/^#{4}[ \t]*([^#]+.*)/.       \1/h,headings/
--regex-markdown=/^#{5}[ \t]*([^#]+.*)/.         \1/h,headings/
--regex-markdown=/^#{6}[ \t]*([^#]+.*)/.           \1/h,headings/
```

#### YouCompleteMe的安转

[参考](https://github.com/Valloric/YouCompleteMe#windows)

linux下很方便，此处省略。windows下安转略麻烦, 步骤如下
 
- 1 安装python, 默认使用python3
- 2 安装[Cmake](https://cmake.org/download/), 添加进系统变量
- 3 安装VisualStudio Community. 安装时选择使用C++的桌面开发即可. 同时把msbuild路径添加到path系统环境变量中. 如下`C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\MSBuild\15.0\Bin`
- 4 编译并安装youcompleteme
```
cd %USERPROFILE%/vimfiles/plugged/YouCompleteMe
python install.py --clang-completer
```
- 5 修改`%USERPROFILE%/vimfiles/vimrc`相关行如下
```
let g:ycm_server_python_interpreter = 'python'
let g:ycm_python_binary_path = 'c:\Python35\python'
```

#### cscope&&ctags
Todo:[集成2者，同时跨平台](https://github.com/ruben2020/codequery)
那么我就要修改得cscope相关配置了

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

nmap <silent> wk <C-W><C-k>
nmap <silent> wj <C-W><C-j>
nmap <silent> wh <C-W><C-h>
nmap <silent> wl <C-W><C-l>

<C-A>       select all
<C-C>       copy
<C-V>       paste


<leader>ct :cs find t  找到这个string
<leader>cf :cs find f  找到一个文件

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
        <td>ubuntu show help</td>
        <td></td>
    </tr>
    <tr>
        <td>F2</td>
        <td></td>
        <td>toggle NERDTree</td>
        <td>nmap <silent> <F2> :NERDTreeToggle<CR></td>
    </tr>
    <tr>
        <td>F3</td>
        <td></td>
        <td>打开tagbar</td>
        <td>nmap <silent> <F3> :Tagbar<CR></td>
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
        <td rowspan="5">F10</td>
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
        <td>markdown</td>
        <td>用chrome打开markdown文件, 因为chrome安装了预览markdown的插件</td>
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
        <td>在全屏和正常屏幕之间切换</td>
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
新语言设置缩进样式
```
autocmd  BufRead,BufNewFile {*.toml}                                    setl ft=toml tabstop=2 softtabstop=2 shiftwidth=2 expandtab smarttab



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
[vimim](https://github.com/vim-scripts/VimIM)
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

依赖包: cscope. zhe

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
<leader>jd   跳转到定义处
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
**编译clang3.5**
[参考1](http://www.cnblogs.com/zhongcq/p/3630047.html)
[参考2](http://hahaya.github.io/build-YouCompleteMe/)
[参考3官网指导](http://clang.llvm.org/get_started.html)
从[llvm官网](http://llvm.org/releases/download.html#3.3)下载
要提前安装cmake和python-dev
```
sudo apt-get install g++4.8 cmake python-dev
```
**the directory structure**
```
~/
        | ----.vim
--------|----------------|
        |                | ----vundle
        |                | ----YouComplteMe
        | -----Downloads
        | ----clang
        |                | ----llvm-3.5.0.src
        |                | ----llvm-build
        | ----ycm_build

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