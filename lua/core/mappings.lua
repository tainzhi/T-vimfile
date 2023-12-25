local utils = require "core.utils"

local map = utils.map

local cmd = vim.cmd

local M = {}

-- these mappings will only be called during initialization
M.misc = function()
   local function non_config_mappings()
      -- Don't copy the replaced text after pasting in visual mode
      -- map("v", "p", '"_dP')

      -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
      -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
      -- empty mode is same as using :map
      -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
      map("", "j", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
      map("", "k", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })
      map("", "<Down>", 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', { expr = true })
      map("", "<Up>", 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', { expr = true })

      -- use ESC to turn off search highlighting
      map("n", "<Esc>", ":noh <CR>")

      -- open help for word under cursor
      map("n", "<leader>h", ':help <C-R>=expand("<cword>")<CR><CR>')

      map({ "n", "v" , "i"}, "<F11>", ":lua require('core.utils').neovide_fullscreen() <CR>")
   end

   local function optional_mappings()
      -- don't yank text on cut ( x )
      map({ "n", "v" }, "x", '"_x')

      -- -- don't yank text on delete ( dd )
      -- map({ "n", "v" }, "d", '"_d')

      -- navigation within insert mode
      map("i", "<C-h>", "<Left>")
      map("i", "<C-e>", "<End>")
      map("i", "<C-l>", "<Right>")
      map("i", "<C-k>", "<Up>")
      map("i", "<C-j>", "<Down>")
      map("i", "<C-a>", "<ESC>^i")

      -- easier navigation between windows
      map("n", "<C-h>", "<C-w>h")
      map("n", "<C-l>", "<C-w>l")
      map("n", "<C-k>", "<C-w>k")
      map("n", "<C-j>", "<C-w>j")
   end

   local function required_mappings()
      -- close current focused buffer
      map("n", "<leader>x", ":lua require('core.utils').close_buffer() <CR>")
      map("n", "<C-a>", "<esc>ggVG$") -- select all
      map("n", "<C-v>", "+p") -- paste
      map("n", "<C-c>", "+y") -- copy
      map("n", "<S-t>", ":enew <CR>") -- new buffer
      map("n", "<C-t>b", ":tabnew <CR>") -- new tabs
      map("n", "<leader>n", ":set nu! <CR>") -- toggle numbers
      map("n", "<C-s>", ":w <CR>") -- ctrl + s to save file

      -- terminal mappings --
      -- multiple mappings can be given for esc_termmode and esc_hide_termmode
      -- get out of terminal mode
      map("t", "jk", "<C-\\><C-n>")
      -- hide a term from within terminal mode
      map("t", "JK", "<C-\\><C-n> :lua require('core.utils').close_buffer() <CR>")
      -- show & recover hidden terminal buffers in a telescope picker
      map("n", "<leader>W", ":Telescope terms <CR>")
      -- Open terminals
      -- TODO this opens on top of an existing vert/hori term, fixme
      map("n", "<leader>h", ":execute 15 .. 'new +terminal' | let b:term_type = 'hori' | startinsert <CR>")
      map("n", "<leader>v", ":execute 'vnew +terminal' | let b:term_type = 'vert' | startinsert <CR>")
      map("n", "<leader>w", ":execute 'terminal' | let b:term_type = 'wind' | startinsert <CR>")
      -- terminal mappings end --

   end

   non_config_mappings()
   optional_mappings()
   required_mappings()
end

-- below are all plugin related mappings

M.bufferline = function()
   -- next buffer
   map("n", "<Tab>", ":BufferLineCycleNext <CR>")
   -- previous buffer
   map("n", "<S-Tab>", ":BufferLineCyclePrev <CR>")
end

M.comment = function()
   -- toggle comment (works on multiple lines)
   map("n", "<leader>/", ":CommentToggle <CR>")
   map("v", "<leader>/", ":CommentToggle <CR>")
end

-- -- NeoVim 'home screen' on open
-- M.dashboard = function()
--    map("n", "<leader>bm", ":DashboardJumpMarks <CR>")
--    -- basically create a new buffer
--    map("n", "<leader>fn", ":DashboardNewFile <CR>")
--    -- open dashboard
--    map("n", "<leader>db", ":Dashboard <CR>")
--    -- load a saved session
--    map("n", "<leader>l", ":SessionLoad <CR>")
--    -- save a session
--    map("n", "<leader>s", ":SessionSave <CR>")
-- end

-- file explorer/tree
M.nvimtree = function()
   local api = require "nvim-tree.api"
   vim.keymap.set('n', '?',     api.tree.toggle_help, { desc = "nvim-tree: " .. "Help", noremap = true, silent = true, nowait = true })
   map("n", "<C-n>", ":NvimTreeToggle <CR>")
   map("n", "<leader>e", ":NvimTreeFocus <CR>")
end

-- multitool for finding & picking things
M.telescope = function()
   map("n", "<leader>fb", ":Telescope buffers <CR>")
   map("n", "<leader>ff", ":Telescope find_files <CR>")
   map("n", "<leader>fa", ":Telescope find_files hidden=true <CR>")
   map("n", "<leader>fgc", ":Telescope git_commits <CR>")
   map("n", "<leader>fgt", ":Telescope git_status <CR>")
   map("n", "<leader>fh", ":Telescope help_tags <CR>")
   map("n", "<leader>fw", ":Telescope live_grep <CR>")
   map("n", "<leader>fo", ":Telescope oldfiles <CR>")
   map("n", "<leader>fth", ":Telescope colorscheme <CR>")
   map("n", "<leader>fm", ":Telescope keymaps <CR>")
end

M.telescope_media = function()
   map("n", "<leader>fp", ":Telescope media_files <CR>")
end

return M
