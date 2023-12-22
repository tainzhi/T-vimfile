local opt = vim.opt
local g = vim.g

opt.termguicolors = true
opt.guifont = "Cascadia Code:h11"
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
g.mapleader = " "

-- -- set default theme
-- -- storm, night, day
-- g.tokyonight_style = "night"
-- g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
-- -- Change the "hint" color to the "orange" color, and make the "error" color bright red
-- -- vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
-- -- Load the colorscheme
-- vim.cmd[[colorscheme tokyonight]]

g.neovide_remember_window_size = true
g.neovide_cursor_vfx_mode = "railgun"
g.neovide_underline_automatic_scaling = true

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
