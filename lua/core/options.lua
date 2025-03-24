local opt = vim.opt
local g = vim.g
local o = vim.o

opt.termguicolors = true
-- 必须要系统安装而 NerdFonts 字体，否则会显示乱码
if jit.os == "Windows" then
   opt.guifont = "Cascadia Code:h10"
-- ubuntu默认的 DejaVu Sans Mono 不是 NerdFonts 字体，需要重新下载安装
-- 从 https://www.nerdfonts.com/font-downloads 选择 DejaVuSansM Nerd Font下载安装
elseif jit.os == "Linux" then
   opt.guifont = "DejaVu Sans Mono:h14"
elseif jit.os == "OSX" then
   opt.guifont = "Helvetia:h10"
end
opt.title = true
-- vimscript: set clipboard += unnamedplus
opt.clipboard:append { "unnamedplus" }
opt.cmdheight = 1
opt.cul = true -- cursor line

-- Indentline
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true

-- disable tilde on end of buffer: https://github.com/neovim/neovim/pull/8546#issuecomment-643643758
opt.fillchars = { eob = " " }

opt.hidden = true
opt.ignorecase = true
opt.smartcase = true
-- wrapscan default option is on
-- means, when "search next" reaches end of file, it wraps around to the beginning
-- so :set nowrapscan
opt.wrapscan = false
opt.mouse = "a"

-- Numbers
opt.number = true
-- relative numbers in normal mode tool at the bottom of options.lua
opt.numberwidth = 2
opt.relativenumber = true
opt.ruler = false

-- disable nvim intro
opt.shortmess:append "sI"

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
-- Number of spaces that a <Tab> in the file counts for
opt.tabstop = 8
opt.termguicolors = true
opt.timeoutlen = 400
-- keep a permanent undo (across restarts)
opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"
-- space 
-- references: https://github.com/vscode-neovim/vscode-neovim/issues/1137
-- vscode nvim mapleader not working
-- The default mapping for <Space> need to be deleted for this to work. Since vim.keymap.del is not working so mapping it to <Nop> should do the trick.
vim.keymap.set("", "<Space>", "<Nop>")
g.mapleader = " "

g.neovide_remember_window_size = true
g.neovide_cursor_vfx_mode = "railgun"
g.neovide_underline_automatic_scaling = true

o.syntax = "on"
o.filetype = "plugin"
o.filetype="indent"

-- disable some builtin vim plugins
local disabled_built_ins = {
   "2html_plugin",
   "getscript",
   "getscriptPlugin",
   "gzip",
   "logipat",
   "netrw",
   "netrwPlugin",
   "netrwSettings",
   "netrwFileHandlers",
   "matchit",
   "tar",
   "tarPlugin",
   "rrhelper",
   "spellfile_plugin",
   "vimball",
   "vimballPlugin",
   "zip",
   "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
   g["loaded_" .. plugin] = 1
end
