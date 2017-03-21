Table of Contents
=================

   * [Catetory](#catetory)
      * [Configure initial](#configure-initial)
      * [Thanks](#thanks)
      * [vim_help](#vim_help)
         * [快捷键](#快捷键)
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
git clone --recursive https://github.com/tainzhi/Q-vimfile.git ~/.vim
# run vim and install plugins
vim .vim/vimrc +PluginInstall +qall                     
```

## Thanks
- 1  learn git submodule and vundle from [gmarik/vimfiles](https://github.com/gmarik/vimfiles)
- 2 get some useful plugins from [wklken/k-vim](https://github.com/wklken/k-vim)


## vim_help
### my &lt;leader&gt; is ,
### 快捷键
```
.           重复上次操作命令
,       	repeat f or F
0	        jump to the begin of line
''          jump to preview position
```
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
#### launch
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
#### mouse move
```
:set noscrollbind
:set scrollbind
]c      jump to next difference
[count][c      jump to previews difference
```
#### file merge
```
dp (diff "put")     copy the difference to the other file
do (diff "get")     copy the difference to the current file
```
#### update

```
:diffupdate         after the merge and update
```
#### folder

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

#### show search result
```
:g/example
# the same as
:g/exampel/p
# it's longer form
:global/regular-expression/print
```
#### show search result with quickfix buffer
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


