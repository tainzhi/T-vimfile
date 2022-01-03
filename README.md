## install && sync

[参考:NvChad](https://nvchad.netlify.app/getting-started/setup)

- windows powershell

```shell
# 依赖程序
scoop install ripgrep
choco install mingw

# install packer.nvim to $HOME\AppData\Local\nvim-data\site\pack\packer\start\packer.nvim
git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"

# clone config to $HOME\AppData\Local\nvim
git clone https://github.com/tainzhi/Q-vimfile "$env:LOCALAPPDATA\nvim"

# launch nvim
$ nvim +'hi NormalFloat guibg=#1e222a' +PackerSync
```

#### plugin manager: [packer.nvim](https://github.com/wbthomason/packer.nvim#notices)

linux

```shell
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

sudo apt install nodejs ripgrep
```

windows powershell

```powershell
git clone https://github.com/wbthomason/packer.nvim "$env:LOCALAPPDATA\nvim-data\site\pack\packer\start\packer.nvim"

```
## Packer.nvim用法
>-- You must run this or `PackerSync` whenever you make changes to your plugin configuration
-- Regenerate compiled loader file
:PackerCompile
-- Remove any disabled or unused plugins
:PackerClean
-- Clean, then install missing plugins
:PackerInstall
-- Clean, then update and install plugins
:PackerUpdate
-- Perform `PackerUpdate` and then `PackerCompile`
:PackerSync
-- Loads opt plugin immediately
:PackerLoad completion-nvim ale

## 启动速度优化相关
安装插件[vim-startuptime](https://github.com/dstein64/vim-startuptime)后 `:StartupTime`

或者使用 hyperfine
```sh
hyperfine "nvim --headless +qa" --warmup 5
```
初步检测启动时间是400ms

## nvim-qt的替代gui
[neovide](https://github.com/neovide/neovide)： 

## lua相关

`:h lua` 查看lua example
`:lua <yourLuaCode>` 执行lua代码
`:h lua-require` 查看lua配置
`:h vim-difference` 查看Neovim和vim的区别

Neovim会查看 `runtimepath`目录下的lua文件，也会查看 `runtimepath/lua/?.lua`和 `runtimepth/lua/?/init.lua`

## snippets

- 插件 [LuaSnip](https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua) 可以识别 [vscode style snippets](https://code.visualstudio.com/docs/editor/userdefinedsnippets); 也集成了通用的[friendly snippets](https://github.com/rafamadriz/friendly-snippets/blob/main/README.md)
- snippets可以处理 copyboard 中的数据
- `nvim/snippets`定义了通用的`all.json.code-snippets`，也定义了针对idar的特定snippet
- 插件`LuaSnip` load 自定义snippet需要指定绝对路径， 在windows下是这样的 `require("luasnip.loaders.from_vscode").load { paths = "C:\\Users\\qiufq1\\AppData\\Local\\nvim\\snippets"}`. 虽然LuaSnip的官网中介绍`load()`不指定path，那么将会从`:echo &rtp`目录下查找目录 `snippets`，但是没有查找成功，故需要指定绝对路径（相对路径也无法加载）

## 插件
- https://github.com/blackCauldron7/surround.nvim

## file explorer
from nvimtree to chadtree. 因为nvimtree在打开长目录文件时后自动split屏幕，这个提了issue还没有解决。

暂时用chadtree替代
参考：
- [install chadtree](https://github.com/ms-jpq/chadtree)
- [chadtree configure](https://github.com/ms-jpq/chadtree/blob/chad/docs/CONFIGURATION.md)
- [chadtree keymap](https://github.com/ms-jpq/chadtree/blob/chad/docs/KEYBIND.md)
> +/- change window width
> c/C change directory, b back to working directory

## Surfingkeys neovim on Edge/Chrome
在server.lua中添加如下代码，设定打开的buffer为idar， 然后可以使用针对idart文件类型的snippt
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
Language Server Protocol (LSP) 是微软为开发工具提出的一个协议， 它将编程工具解耦成了Language Server 与 Language Client 两部分

Client 专注于页面样式实现， Server 负责提供语言支持，包括常见的自动补全，跳转到定义，查找引用，悬停文档提示等功能。


### for vscode
vscode安装插件[lua-language-server](https://github.com/sumneko/lua-language-server)后，在lua项目（即nvim目录）添加`.vscode/settings.json`, 其中内容拷贝自[lua-lsp-wiki-settings](https://github.com/sumneko/vscode-lua/blob/master/setting/setting.json.)，最后就可以使用跳转等操作了。
### for neovim
[参考](https://github.com/nshen/learn-neovim-lua/blob/main/docs/lsp.md)

而我们所说的 Neovim 内置 LSP 就是 client 端的实现，这样我们就可以链接到和 VSCode 相同的 language servers ，实现高质量的语法补全

`:h lsp` 查看帮助文档。

Neovim是客户端，默认不包含 [language-server](https://microsoft.github.io/language-server-protocol/implementors/servers/), 需要自己安装. 通过插件 [nvim-lsp-installer](https://github.com/williamboman/nvim-lsp-installer#available-lsps)可以自动安装。

已经在 `lua/lsp` 目录下安装了lua server(`lua/lsp/lua.lua`)和bash server(`lua/lsp/bash.lua`)， 如果需要安装其他的server，[查询](https://github.com/williamboman/nvim-lsp-installer#available-lsps)

自动安装完成后 `:LspInstallInfo`查看安装的server


## 参考

[菜鸟：lua教程](https://www.runoob.com/lua/lua-coroutine.html)
[viml和lua相互引用示例](https://teukka.tech/luanvim.html)
[Libuv在Neovim中异步调用案例](https://teukka.tech/luanvim.html)

[should i use vim or neovim](https://www.reddit.com/r/vim/comments/opvv66/should_i_use_vim_or_neovim/): Neovim比vim有默认的配置

## [vim-surround](https://github.com/tpope/vim-surround)

基本操作

```
ds"     删除“
cs")    替换“为)
ysw)   把当前word添加()
其中， “ds"删除，”cs"替换，“ys"添加
```

**注意**: 右括号不会再多添加空格，左括号会添加空格

特殊表示

```
",',(,{,[,<代表本来的意思。
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

它的visual mode，用S操作。
比如把

Hello world!
转换成

<p class="important">
  <em>Hello</em> world!
</p>
按如下命令，把光标置于Hello之前，ysw<em>，然后V选择该行，完整命令如下VS<p class="important">
```

## learning vim

https://neovim.io/doc/user/quickref.html

:h tutor
:h autocmd

## todo
- [conceal filename and line number in quickfix](https://vi.stackexchange.com/questions/18353/how-to-conceal-filename-and-line-number-in-quickfix-window)
- treesitter for bash, vim; indent, fold
- [vim-im-select](https://github.com/brglng/vim-im-select)