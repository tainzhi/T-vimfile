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

## lua相关
`:h lua` 查看lua example
`:lua <yourLuaCode>` 执行lua代码
`:h lua-require` 查看lua配置
`:h vim-difference` 查看Neovim和vim的区别

Neovim会查看`runtimepath`目录下的lua文件，也会查看`runtimepath/lua/?.lua`和`runtimepth/lua/?/init.lua`

## snippets
插件 [LuaSnip](https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua) 可以识别 [vscode style snippets](https://code.visualstudio.com/docs/editor/userdefinedsnippets); 也集成了通用的[friendly snippets](https://github.com/rafamadriz/friendly-snippets/blob/main/README.md)

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
