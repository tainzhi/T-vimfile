local map = vim.keymap.set

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

map({ "n", "v", "i" }, "<F11>", ":lua require('core.utils').neovide_fullscreen() <CR>")
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

-- close current focused buffer
map("n", "<leader>x", ":lua require('core.utils').close_buffer() <CR>")
map("n", "<C-a>", "<esc>ggVG$")              -- select all
map("n", "<C-v>", "+p")                      -- paste
map("n", "<C-c>", "+y")                      -- copy
map("n", "<S-t>", ":enew <CR>")              -- new buffer
map("n", "<C-t>b", ":tabnew <CR>")           -- new tabs
map("n", "<leader>n", ":set nu! <CR>")       -- toggle numbers
map("n", "<C-s>", ":w <CR>")                 -- ctrl + s to save file

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


-- below are all plugin related mappings

-- plugin: BufferLine
-- next buffer
map("n", "<Tab>", ":BufferLineCycleNext <CR>")
-- previous buffer
map("n", "<S-Tab>", ":BufferLineCyclePrev <CR>")

-- toggle comment (works on multiple lines)
map("n", "<leader>/", ":lua require('Comment.api').toggle.linewise.current() <CR>", {desc="Toggle comment"})
map("v", "<leader>/", ":lua require('Comment.api').toggle.linewise(vim.fn.visualmode()) <CR>", {desc="Toggle comment"})


-- file explorer/tree
map("n", "<C-n>", ":NvimTreeToggle <CR>")
map("n", "<leader>e", ":NvimTreeFocus <CR>")

-- plugin: Telescope
-- multitool for finding & picking things
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

map("n", "<leader>fp", ":Telescope media_files <CR>")

-- plugin: dap to debug
map("n", "<Leader>b", ":lua require('dap').toggle_breakpoint()<CR>")
map("n", "<Leader>p", ":lua require('dap').set_breakpoint(nil, nil, vim.fn.input('Log point message: ')) <CR>")
map("n", "<F9>", ":lua require('dap').continue()<CR>")
map("n", "<F8>", ":lua require('dap').step_over()<CR>")
map("n", "<F7>", ":lua require('dap').step_into()<CR>")
map("n", "<S-F8>", ":lua require('dap').step_out()<CR>")
-- 打开 expression console
map("n", "<S-F10>", ":lua require('dap').repl_open()<CR>")
map("n", "<F12>", ":lua require('dap.ui.widgets').hover()<CR>")
map("n", "<F5>", ":lua require('dap').run_last()<CR>")
map("n", "<S-F9>", ":lua require('osv').launch({port = 8086})<CR>")


-- plugin: hop easy-motion的替代
map('n', '<leader>s', ":lua require'hop'.hint_char1()<cr>", {})
map('n', '<leader>ss', ":lua require'hop'.hint_char2()<cr>", {})
map('n', 'f', ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = false })<cr>", {})
map('n', 'F', ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = false })<cr>", {})
map('o', 'f', ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
map('o', 'F', ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true, inclusive_jump = true })<cr>", {})
map('', 't', ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR, current_line_only = true })<cr>", {})
map('', 'T', ":lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR, current_line_only = true })<cr>", {})
