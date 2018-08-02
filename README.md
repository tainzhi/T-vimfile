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
        <td>打开tagbar</td>
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


