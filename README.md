# Catetory
---
- [Configure initial](#configure-initial)
- [Thanks](#thanks)
- [vim help](#vim-help)
- [vim plugin](#vim-plugin)
---

## Configure initial

```
# clone recursively with vundle
git clone --recursive https://github.com/tainzhi/Q-vimfile.git ~/.vim
# run vim and install plugins
vim .vim/vimrc +PluginInstall +qall                     
```

## Thanks
- 1  learn git submodule and vundle from [gmarik/vimfiles](https://github.com/gmarik/vimfiles)
- 2 get some useful plugins from [wklken/k-vim](https://github.com/wklken/k-vim)

-------------------------------------------------------------------------------

## vim_help
###查找

    /xxx(?xxx)      / 向上查找，？ 向下查找， xxx 为正则表达式, 默认区分大小
    *(#)    当光标停留在某个单词上时, 查找与该单词匹配的, n(*)查找下一处，N(#)查找上一处
    g*(g#)  匹配包含该单词的所有字符串.
    gd      本命令查找与光标所在单词相匹配的单词, 并将光标停留在文档的非注释段中第一次出现这个单词的地方.
    %       本命令查找与光标所在处相匹配的反括号, 包括 () [] {}
	f(F)x   本命令表示在光标所在行进行查找, 查找光标右(左)方第一个x字符.
    /xxx\c  忽略大小写查找

###跳转

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

###删除进入Normal模式

	D				从光标当前位置到改行末尾
	dd				修改从光标当前行起始位到改行末尾
	3D				从光标当前位置到3行末尾范围内的内容
    ndw     删除指定数目的单词
    d^      删至行首
    d$      删至行尾
    x或X    删除一个字符

###插入
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

###复制
	y		把内容复制到“粘贴板里
    ynw     复制n个单词
    ynl     复制n个字符
    y$      复制当前光标至行尾



###粘贴，寄存器
	:reg        查看12个粘贴版板里的内容
    "?nyy       将当前行即其下n行的内容保存到寄存器？中
    "?nyw       将n个字保存到寄存器？中
    "nyl        将n个字符保存到寄存器？中
    "?p         取出寄存器？中的内容并放在光标未位置处
	p			用p粘贴”粘贴板里的内容

	“Ny			把内容粘贴到N粘贴板里
	”Np			粘贴N粘贴板里的内容

	+			系统粘贴板
	+p			粘贴系统全局粘贴板里的内容

###移动
	>			输入此命令则光标所在行向右移动一个 tab.
	5>>			输入此命令则光标后 5 行向右移动一个 tab.
	:<<<		move current line 3 indents to the left
	:>> 5		move 5 lines 2 indents to the right

	:5>>		move line 5 2 indents to the right
	:12,24>			将12行到14行的数据都向右移动一个 tab.
	:12,24>>		将12行到14行的数据都向右移动两个 tab.

    Vjj4>		move three lines 4 indents to the right

###代码折叠
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

###翻屏
	ctrl-f ctrl-b		正页翻屏，f就是forword b就是backward
	ctrl-d ctlr-u		翻半页，d=down u=窗口up
	ctrl-e ctrl-y		滚一行
	zz 			让光标所在的行居屏幕中央
	zt			让光标所在的行居屏幕最上一行 t=top
	zb 			让光标所在的行居屏幕最下一行 b=bottom
    nz          将第n行滚至屏幕顶部，不指定n时将当前行滚至屏幕顶部


###文件

	：tabnew ~/Desktop/note			在新标签中打开note文件
 ~/a.txt		编辑新文件
    :qa(:wa)(:wpa)		quit all the file(write al the files)
    :e file     在当天标签下打开file
    :x          保存并退出

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

###vimdiff

####launch
```
vim -d 1file 2file
vimdiff 1file file
```
or

```
vim 1file
:vertical diffsplit 2file
```

####mouse move

```
:set noscrollbind
:set scrollbind
```
]c      jump to next difference
[count][c      jump to previews difference


####file merge

df (diff "put")     copy the difference to the other file
do (diff "get")     copy the difference to the current file

####update

```
:diffupdate         after the merge and update
```
####folder

```
:set diffopt=context:3          缺省的上下文行数
```
zo      (folding open)
zc      (folding close)

###窗格
    打开窗口
    ctrl + w + v		vertical split
    ctrl + w + s		horizontal sqlit
    ctrl + w + q		close current window
    在窗格(窗口焦点)间切换的方法
    Ctrl+w+方向键——切换到前／下／上／后一个窗格
    Ctrl+w+h/j/k/l ——同上
    Ctrl+ww	依次向后切换到下一个窗格中
    ctrl+w+t		jump to the top window
    ctrl+w+b		jump to the bottom window
    窗口布局切换
    ctrl+w+K		move the current window to the top
    ctrl+w+L
    ctrl+w+J
    ctrl+w+L
    窗格大小调整
    纵向调整
    :ctrl+w + 纵向扩大（行数增加）
    :ctrl+w - 纵向缩小 （行数减少）
    :res(ize) num  例如：:res 5，显示行数调整为5行
    :res(ize)+num 把当前窗口高度增加num行
    :res(ize)-num 把当前窗口高度减少num行
    横向调整
    :vertical res(ize) num 指定当前窗口为num列
    :vertical res(ize)+num 把当前窗口增加num列
    :vertical res(ize)-num 把当前窗口减少num列

###tab标签
    :tab split filename	这个就用tab的方式来显示多个文件 (use tab to display buffers)
    gt	到下一个tab (go to next tab)
    gT	到上一个tab (go to previous tab)
    0gt	跳到第一个tab (switch to 1st tab)
    5gt	跳到第五个tab (switch to 5th tab)

    :tabdo  command         在所有的tab文件中运行command, eg. `:tabdo %s/abc/def/g`把所有的tab文件中的abc替换位def

set tags and jump to tags

    mx          set tags x, x is in a-z
    `x          jump to tag x



###vim和shell

    :!command   执行shell命令
    :r!command  将command的输出结果放到当前行
    :shell 可以在不关闭vi的情况下切换到shell命令行
    :sh
    :exit 从shell回到vi

###宏

	qa				（Normal模式）开始录制宏a
	q				（Normal模式）结束宏的录制
	@a			 	使用宏

###帮助
	:help keycodes		解释符号
	:helptags /usr/share/vim/vim/73/doc  : 重建 /doc 中所有的 *.txt 帮助文件
    :help add-local-help

###搜索即替换命令
    /pattern        从光标开始处向文件尾匹配
    ?pattern        从光标开始处向文件首匹配搜索
    n       在同一方向上重复上一次命令，比如？pattern向上查找，n耶向上查找
    N       在反方向上重复上一次命令
    :s/p1/p2/g      将当前行中所有的p1用p2代替
    :n1,n2s/p1/p2/g     将能n1至n2行中所有的p1用p2代替
    :%s/p1/p2/g         将文件中所有的p1用p2替代
    :.,$s/p1/p2/g       替换当前行到最后一行的p1

###setting

    :set ignorecase     不区分大小写
    :sy clear			取消语法高亮
    :set guifont=Monospace\ 12      字体设置
    :set guifont=*	
	

>####set colorscheme

    :colorscheme tesla

change tesla search syntax: change the `hi search guibg=#006400`, then `:colorscheme tesla`

>####RGB Color table

http://gucky.uni-muenster.de/cgi-bin/rgbtab-en

    set syntax

add my key world syntax, eg:void, function
go the `$vim/syntax/c.vim`, add `hi void guifg=#2f4f4f`

>####/ftplugin

`filetype plugin on`是打开文件类型检测,载入该目录下的vim脚本,而/plugin是自动载入,适用用所有文件类型,该目录下的文件python_fn.vim,python为文件类型,而"_"后的为任意字符,以vim作为后缀




-------------------------------------------------------------------------------



## vim plugin

###[Vundle](https://github.com/gmarik/Vundle.vim):vim plugin manager
**Brief help**
just `:PluginInstall`,Vundle will install or unpdate all plugins
```
:PluginList       - lists configured plugins
:PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
:PluginSearch foo - searches for foo; append `!` to refresh local cache
:PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal``
```

###[ultisnips](https://github.com/SirVer/ultisnips):code competion
**Brief help**
just enter the tab key, it will complete the code

###[NERD_commenter](https://github.com/scrooloose/nerdcommenter):comment

```
Plugin 'scrooloose/nerdcommenter'
```

**Brief help**
the default <leader> is `\`
:helptags ~/vim/doc
```
[count]<leader>cc       #comment out the current line or text selected in visual mode,对c语言来说是每行之前加//
[count]<leader>cs       #对c语言来说，是/*.....*/
[count]<leader>cu       #取消注释
<leader>c$              #comment the current line from the cursor to the end of line
<leader>cA              #对c语言来说是在行尾加上//,并进入insert模式
```
###[ctags](http://ctags.sourceforge.net/):generates tag indexs


    tar zxvf ctags.tar.gz
    ./configure
    sudo make install
ctags被安装在`/usr/local/bin`下。

在vimrc中添加Ctags安装路径

    let Tlist_Ctags_Cmd='/usr/local/bin/ctags'

>**help:**

[Reference](http://www.360doc.com/content/07/0918/15/15540_753675.shtml)

每次修改后,要重新建立,ctags不自动简历

```
$ctags -R
:set tags = ~/vim/project_name/tags
<C-]>   跳到定义的地方
<C-o>   跳回之前的位置
<C-i>   跳到下一个位置
```


###[taglist](https://github.com/vim-scripts/taglist.vim):tag browser

```
    Plugin 'vim-scripts/taglist.vim'
```

>**help**

```
:TlistToggle
F1      toggle help
<Enter> jump to difinition
p       jump but not enter the difinition
-       close the tags
*       open the tags
```

###[nerdtree](https://github.com/scrooloose/nerdtree):explore filesystem,open files and directories

```
Plugin 'scrooloose/nerdtree'

```
>**help**

```
:NERDTree       toggle NERDTree
?       toggle/close help
o/O     open
x/X     close
K       move to first child
J       move to last child
A       Zoom the window
U       move tree root up a dir 
```
###[zoomwin](https://github.com/vim-scripts/ZoomWin):zoomwin

```
Plugin 'ZoomWin'
```
>**help**

```
<C-w>o
```

###[add solarized.vim](http://ethanschoonover.com/solarized/vim-colors-solarized)
假定已安装vundle
在vimrc中添加
```
" Colorscheme
Plugin 'altercation/vim-colors-solarized'
if has("gui_running")
  set background=light
  colorscheme solarized
else
  set background=dark
endif
```


###python_fn.vim
$VIM/ftplugin/python_fn.vim
" Shortcuts:                                                                                                                                    
"   ]t      -- Jump to beginning of block
"   ]e      -- Jump to end of block
"   ]v      -- Select (Visual Line Mode) block
"   ]<      -- Shift block to left
"   ]>      -- Shift block to right
"   ]#      -- Comment selection
"   ]u      -- Uncomment selection
"   ]c      -- Select current/previous class
"   ]d      -- Select current/previous function
"   ]<up>   -- Jump to previous line with the same/lower indentation
"   ]<down> -- Jump to next line with the same/lower indentation


7.supertab.vmb)


quickfix
cscope


赋值符号对齐
Tabular

winmanager

c/h文件间相互切换,插件A


在工程中查找--插件grep
http://www.vim.org/scripts/script.php?script_id=311

自动补全
supertab
http://blog.csdn.net/wooin/article/details/1858917


indent guides


python补全
pydiction和pythoncomplete


-------------------------------------------------------------------------------


##vim_regular_expression

##magic

```
:set magic             " 设置magic,除$.*^之外其他字符都要加反斜杠
:set nomagic           " 取消magic
:h magic               " 查看帮助
```

##元字符

**元字符**  具有特殊意义的字符，使用特殊字符可以表达任意字符、行首、行尾


>####元字符一览
```
元字符	说明
.	匹配任意一个字符
[abc]	匹配方括号中的任意一个字符。可以使用-表示字符范围，如[a-z0-9]匹 配小写字母和阿拉伯数字。
[^abc]	在方括号内开头使用^符号，表示匹配除方括号中字符之外的任意字符。
\d	匹配阿拉伯数字，等同于[0-9]。
\D	匹配阿拉伯数字之外的任意字符，等同于[^0-9]。
\x	匹配十六进制数字，等同于[0-9A-Fa-f]。
\X	匹配十六进制数字之外的任意字符，等同于[^0-9A-Fa-f]。
\w	匹配单词字母，等同于[0-9A-Za-z_]。
\W	匹配单词字母之外的任意字符，等同于[^0-9A-Za-z_]。
\t	匹配<TAB>字符。
\s	匹配空白字符，等同于[ \t]。
\S	匹配非空白字符，等同于[^ \t]。
```

**空格**就匹配空格

如果要查找字符 *、.、/等，则需要在前面用 \ 符号，表示这不是元字符，而只是普通字符而已。
```
元字符	说明
\*	匹配 * 字符。
\.	匹配 . 字符。
\/	匹配 / 字符。
\\	匹配 \ 字符。
\[	匹配 [ 字符。
```

>####表示数量的元字符

```
元字符	说明
*	匹配0-任意个
\+	匹配1-任意个
\?	匹配0-1个
\{n,m}	匹配n-m个
\{n}	匹配n个
\{n,}	匹配n-任意个
\{,m}	匹配0-m个
```
>####表示位置的符号
```
元字符	说明
$	匹配行尾
^	匹配行首
\<	匹配单词词首
\>	匹配单词词尾
```


##表达式规则

    :[range]s/pattern/string/[c,e,g,i]

**range**	指的是範圍，1,7 指從第一行至第七行，1,$ 指從第一行至最後一行，也就是整篇文章，也可以 % 代表。% 是目前編輯的文章，# 是前一次編輯的文章。

**pattern**     就是要被替換掉的字串，可以用 regexp 來表示。

**string      將 pattern 由 string 所取代。
```
c	confirm，每次替換前會詢問。
e	不顯示 error。
i	ignore 不分大小寫。
g 大概都是要加的，否則只會替換每一行的第一個符合字串。可以合起來用，如 cgi，表示不分大小寫，整行替換，替換前要詢問是否替換
```

##other tips

- **\#**也可以用作为分隔符，此时中间出现的/不会当作分隔符

- ([^"]*)         pattern中该符号，表示非引号的字符N个；外面 () 表示后面替换要用（用 1,…,9等引用）

#example

```
:%s/abc//gn         显示匹配个数,关键之后面的n,不进行实质的替换:
:g/^$/d
:%s/\<four\>/five/g     替换word four to five,“%” 范围前缀表示在所有行中执行替换。"g"标记表示替换行中的所有匹配点。如果仅仅对当前行进行操作，那么只要去掉%即可
:g/^/exec "s/^/".strpart(line(".")." ", 0, 4)    在行首插入行号
:%s/^\d\+//g        删除行首行号
查找LastModified的行,并在改行查找LastModified,把它换last_modified
查找替换格式为
:g/{pattern}/s/{pattern}/new
\s为空白符,\"为双引号,[]为大写字母表示
:g/^\s*\"\s*[L]ast[M]odified:.*$/s/^\s*\"\s*[L]ast[M]odified:.*$/last_modified/char\s\+[A-Za-z_]\w*;                 " 查找所有以char开头，之后是一个以上的空白,最后是一个标识符和分号
/\d\d:\d\d:\d\d                        " 查找如 17:37:01 格式的时间字符串
:g/^\s*$/d                             " 删除只有空白的行
:s/\<four\>/4/g                        " 将所有的four替换成4，但是fourteen中的four不替换
:%s/^>/- \gn                           "查找全文以>开头的行，把>换为- (这个时空格），并显示匹配的行
:%s/ */ /g                              "把一个或者多个空格替换为一个空格
:%s/ *$//                               "去掉行尾所有的空格
:%s/t([aou])g/h1t/g                     "将所有的tag,tog和tug分别改为hat,hot,hut

```


## 美化插件 ##
###[solarized.vim](http://ethanschoonover.com/solarized/vim-colors-solarized)
```
" Colorscheme
Plugin 'altercation/vim-colors- '
if has("gui_running")
  set background=light
  colorscheme solarized
else
  set background=dark
endif
```

###[rainbow_parentheses](https://github.com/kien/rainbow_parentheses.vim)
hight the parentheses

## 普通插件　##
###NERDTree###
**Usage**:
```
?       toggle help
m       Show the menu, then rename or create a file

:NERDTree 
:NERDTreeToggle
```
If a NERD tree already exists for this tab, it is reopened and rendered again.  If no NERD tree exists for this tab then this command acts the same as the :NERDTree command. 


###[tagbar](https://github.com/majutsushi/tagbar)
tagbar按作用域归类不同的标签。按名字空间 n_foo、类 Foo 进行归类,在内部有声明、有定义;
显示标签类型。名字空间、类、函数等等;
显示完整函数原型;
图形化显示共有成员(+)、私有成员(-)、保护成员(#);
**Usage**
```
s       Toggle sort order between name and file order
```

###[vim-surround](https://github.com/tpope/vim-surround)
快速加环绕符号
```
ds"             删除"，此处"可以为任何符号,从光标所在处到单词末尾
cs"<p>          替换"为<p>
ysw(            添加()
```

###[godlygeek/tabular](https://github.com/godlygeek/tabular)
对齐
```
<leader>be      以等号对齐
<leader>bu      自定义符号
```
以空格号对齐
```
:Tabularize / /l0c5r0<CR>       以空格对齐，居中，插入5个空格
```

###[TaskList.vim](https://github.com/vim-scripts/TaskList.vim/blob/master/plugin/tasklist.vim)
todolist
```
<leader>t
```


###[vim-easymotion](https://github.com/Lokaltog/vim-easymotion/)
当前页面内快速跳转
```
<leader>s       查找一个字母，并跳转
<leader>f       查找两个字母，并跳转
```

###[DirDiff](https://github.com/vim-scripts/DirDiff.vim)
file or directory compare
```
:DirDiff directory1 directory2
```

###[Syntastic](https://github.com/scrooloose/syntastic#installation)###
**与YouCompleteMe有冲突**
syntax checking 
```
:h Syntastic            # show the help
:SyntasticInfo          # Show current information
:SyntasticCheck         # to manually check right now
:Errors                 # open the location-list
:lclose                 # close the window
:lnext
:lpreviews              # jump to the different errors
```

###[vim-git](https://github.com/tpope/vim-git)###
Included are syntax, indent, and filetype plugin files for git, gitcommit, gitconfig, gitrebase, and gitsendemail. 

###[tpope/vim-fugitive](https://github.com/tpope/vim-fugitive)
```
:Gstatus            
:Gdiff              # diff current file
```
###[vim-session](https://github.com/xolox/vim-session)
[vim-misc](https://github.com/xolox/vim-misc)
**vim-session plug-in requires my vim-misc plug-in**
recover vim session, where is the key and the tab statues
before, must install [vim-misc](https://github.com/xolox/vim-misc)
```
:SaveSession
:OpenSession
```
###[mru.vim](https://github.com/yegappan/mru)###
provides an easy access to a list of recently opened/edited files in Vim.
```
:MRU
```
If you are using GUI Vim, then the names of the recently edited files are 
added to the "File->Recent Files" menu

###vim-auto-save###
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

###[vim-expand-region](https://github.com/terryma/vim-expand-region)
```
K   expand select block
J   shrink select block
```

###[vim-ariline](https://github.com/vim-airline/vim-airline)
```
<leader>d N                 delete buffer N
<leader>d 1 2 3             delete buffer 1 2 3
<leader>1, 2, ..., 9        jump to buffer 1, 2, ..., 9
```

- the small number is buffer likes tab number, use with `<leader>1, 2, ..., 9`
- the large number is real buffer number, use with `:bdelete 1`, delete buffer
- `:tabnew`产生新的窗口, 有3个数字了, 直接`:q`退出, 但是会保留一个2个数字的buffer


###[vimim中文输入法](https://github.com/tainzhi/vimim)
查找文本中的`项目`这一词组, 先查找`/xiangmu`, 然后输入回车, 此时没有匹配结果, 然后输入`n`查找下一个

###[snippet](https://github.com/honza/vim-snippets)

##有依赖包的插件
###[tagbar](https://github.com/majutsushi/tagbar)
**依赖包：ctags**


###[ag.vim](https://github.com/rking/ag.vim)
[vim-action-ag](https://github.com/Chun-Yang/vim-action-ag): 使得普通模式的搜索(按*键)即可全工程搜索
```
:Ag str
:LAg str        search in quickfix
```
**依赖包: [ag](https://github.com/ggreer/the_silver_searcher)**

###[YouCompleteMe](https://github.com/Valloric/YouCompleteMe)
**依赖包：clang**
- 自动补全名称和目录路径， 支持c/c++,python,node.js,JavaScript,go
- 实时检测并显示c/c++语法错误
[Support Node.js and JavaScript](https://github.com/Valloric/YouCompleteMe#ubuntu-linux-x64)

**usage**
>tab键选中，Ctrl+P/N选择
<leaer>jd   跳转到定义处
Ctrl+O      jump backword
Ctrl+I      jump forward

####auto install(recommend)
```
cd ~/.vim/bundle/YouCompleteMe
./install.py --all
```

####manual install
#####install clang
######install clang pre-buildt binaries(recommend)
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
######install clang by source
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
#####编译YouCompleteMe插件

```
cd ~
mkdir ycm_build
cd ycm_build
cmake -G "Unix Makefiles" -DPATH_TO_LLVM_ROOT=/home/muqing/Downloads/clang+llvm-3.9.0-x86_64-linux-gnu-ubuntu-16.04 . ~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp
cmake --build . --target ycm_core --config Release
```

注意：　`-DPATH_TO_LLVM_ROOT=`为自定义clang+llvm位置

####使用配置
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

###[syntastic](https://github.com/vim-syntastic/syntastic)
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
###vim-scripts/taglist.vim

###[FuzzyFinder](http://www.vim.org/scripts/script.php?script_id=1984): 查找文件，路劲，buffer等
```
:FufHelp            打开帮助
:FufFile            打开文件
```


###Reference
[vimrc function载入cscope.out](http://www.cnblogs.com/IceKernel/archive/2012/08/30/2663237.html)
