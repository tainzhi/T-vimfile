## install && sync

[参考：NvChad](https://nvchad.netlify.app/getting-started/setup)

- windows powershell

```shell
# 依赖程序
scoop install ripgrep
scoop install mingw


# clone config to $HOME\AppData\Local\nvim
git clone https://github.com/tainzhi/Q-vimfile "$env:LOCALAPPDATA\nvim"

# 插件管理： lazy.nvim
# launch nvim and use
$ nvim
```

## nvim-qt 的替代 gui
[neovide](https://github.com/neovide/neovide)：

[config 参考](https://neovide.dev/configuration.html): 通过命令行配置，而不是文件配置
## lua 相关

`:h lua` 查看 lua example
`:lua <yourLuaCode>` 执行 lua 代码
`:h lua-require` 查看 lua 配置
`:h vim-difference` 查看 Neovim 和 vim 的区别

Neovim 会查看 `runtimepath`目录下的 lua 文件，也会查看 `runtimepath/lua/?.lua`和 `runtimepth/lua/?/init.lua`

## snippets

- 插件 [LuaSnip](https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua) 可以识别 [vscode style snippets](https://code.visualstudio.com/docs/editor/userdefinedsnippets); 也集成了通用的[friendly snippets](https://github.com/rafamadriz/friendly-snippets/blob/main/README.md)
- [luasnip example](https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua) 给常用的操作提供了案例

我自定义的 luasnip 的在目录 `lua/snippets`下，分别定义了通用的 all.lua 和 针对 idart 的 idart.lua.

对于 idart.lua ，有一个功能是对拷贝自 quickfix 的 text 替换掉文件名和行号生成 snippet

## 自定义插件
extra/plugins/rgflow.vnim 为自定义插件。自定义插件目录下 `plugin/rgflow.vim`为全局配置，而`ftplugin/{idart.vim,qf.vim,rgflow.vim}`为特定 filetype 的 buf 有效。对于一个新的文件，可以指定 filetype `:set ft=idart`, 查看 ft `:echo &ft`

那么 surfingkeys 打开的 buffer，通过 autocmd 指定 ft=idart，然后就可以使用 idart.lua snippet.

针对 idart，有 ftplugin/idart.vim 重定义了 p 快捷键，copy 自 quickfix 的 text 删除掉行号和文件名


## 插件
- https://github.com/blackCauldron7/surround.nvim

## file explorer
from nvimtree to chadtree. 因为 nvimtree 在打开长目录文件时后自动 split 屏幕，这个提了 issue 还没有解决。

暂时用 chadtree 替代
参考：
- [install chadtree](https://github.com/ms-jpq/chadtree)
- [chadtree configure](https://github.com/ms-jpq/chadtree/blob/chad/docs/CONFIGURATION.md)
- [chadtree keymap](https://github.com/ms-jpq/chadtree/blob/chad/docs/KEYBIND.md)
> +/- change window width
> c/C change directory, b back to working directory

## Surfingkeys neovim on Edge/Chrome
[参考：server config](https://github.com/brookhong/Surfingkeys/blob/master/src/nvim/server/Readme.md)

在 server.lua 中添加如下代码，设定打开的 buffer 为 idar， 然后可以使用针对 idart 文件类型的 snippt
```vim
function! ResizeSurfingkeysWindow()
    setlocal filetype=idart
    setlocal guifont=Consolas:h16
    setlocal lines=40 columns=120
endfunction
au BufEnter surfingkeys://* call ResizeSurfingkeysWindow()
```
**缺陷**：暂时无法更改编写框的大小

## LSP
Language Server Protocol (LSP) 是微软为开发工具提出的一个协议， 它将编程工具解耦成了 Language Server 与 Language Client 两部分

Client 专注于页面样式实现， Server 负责提供语言支持，包括常见的自动补全，跳转到定义，查找引用，悬停文档提示等功能。


### for vscode
vscode 安装插件[lua-language-server](https://github.com/sumneko/lua-language-server)后，在 lua 项目（即 nvim 目录）添加`.vscode/settings.json`, 其中内容拷贝自[lua-lsp-wiki-settings](https://github.com/sumneko/vscode-lua/blob/master/setting/setting.json.)，最后就可以使用跳转等操作了。
### for neovim
[参考](https://github.com/nshen/learn-neovim-lua/blob/main/docs/lsp.md)

而我们所说的 Neovim 内置 LSP 就是 client 端的实现，这样我们就可以链接到和 VSCode 相同的 language servers ，实现高质量的语法补全

`:h lsp` 查看帮助文档。

Neovim 是客户端，默认不包含 [language-server](https://microsoft.github.io/language-server-protocol/implementors/servers/), 需要自己安装。通过插件 [nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer#available-lsps)可以自动安装。

已经在 `lua/lsp` 目录下安装了 lua server(`lua/lsp/lua.lua`)和 bash server(`lua/lsp/bash.lua`)， 如果需要安装其他的 server，[查询](https://github.com/williamboman/nvim-lsp-installer#available-lsps)

自动安装完成后 `:LspInstallInfo`查看安装的 server


## [vim-surround](https://github.com/tpope/vim-surround)

基本操作

```
ds"     删除“
cs")    替换“为）
ysw)   把当前 word 添加()
其中， “ds"删除，”cs"替换，“ys"添加
```

**注意**: 右括号不会再多添加空格，左括号会添加空格

特殊表示

```
",',(,{,[,《代表本来的意思。
同时，
b---(
B--{
r--[
a--<
t--</tag>

w--word
W--WORD
t--html tag
s--sentence
p--paragraph

它的 visual mode，用 S 操作。
比如把

Hello world!
转换成

<p class="important">
  <em>Hello</em> world!
</p>
按如下命令，把光标置于 Hello 之前，ysw<em>，然后 V 选择该行，完整命令如下 VS<p class="important">
```

## learning vim

https://neovim.io/doc/user/quickref.html

:h tutor
:h autocmd

## other references
https://github.com/tainzhi/autoload_cscope.vim
https://zhuanlan.zhihu.com/p/366496399
https://github.com/nanotee/nvim-lua-guide
https://github.com/skywind3000/vim-terminal-help
https://github.com/ranger/ranger
https://github.com/mjlbach/starter.nvim/blob/master/init.lua
https://github.com/kevinhwang91/nvim-bqf
https://zhuanlan.zhihu.com/p/36279445
https://www.reddit.com/r/neovim/comments/nfm8ub/javakotlin_developers_that_use_neovim_as_their/
https://zhuanlan.zhihu.com/p/349271041
https://github.com/skywind3000/awesome-cheatsheets/blob/master/editors/vim.txt
https://github.com/ojroques/vim-oscyank

## todo
- [conceal filename and line number in quickfix](https://vi.stackexchange.com/questions/18353/how-to-conceal-filename-and-line-number-in-quickfix-window)
- treesitter 替换 logger
- treesitter for bash, vim; indent, fold
- [vim-im-select](https://github.com/brglng/vim-im-select)
- gui
>- neovide: rust 写的；缺点是打开 500M 的文件会很卡
>- goneovim: 速度很快，ui 酷炫；缺点是打开 rgflow 输入框看不到，有时会莫名其妙的自动关闭
- synatx: 参考当前目录下 extra/plugins/syntaxs.nvim, 参考[github kmonad-vim](https://github.com/kmonad/kmonad-vim/blob/master/syntax/kbd.vim)
- [which-key](https://github.com/folke/which-key.nvim)
- [plugin renamer](https://github.com/filipdutescu/renamer.nvim)
- [plugin harpoon 用于快速跳转到特定的 buffer，terminal](https://github.com/ThePrimeagen/harpoon)
- [plugin auto-session](https://github.com/rmagatti/auto-session)


## 参考

[菜鸟：lua 教程](https://www.runoob.com/lua/lua-coroutine.html)
[viml 和 lua 相互引用示例](https://teukka.tech/luanvim.html)
[Libuv 在 Neovim 中异步调用案例](https://teukka.tech/luanvim.html)

[should i use vim or neovim](https://www.reddit.com/r/vim/comments/opvv66/should_i_use_vim_or_neovim/): Neovim 比 vim 有默认的配置
