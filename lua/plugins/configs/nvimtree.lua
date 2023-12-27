local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '?',     api.tree.toggle_help,                  opts('nvimtree Help'))
end

local options = {
   on_attach = my_on_attach,
   filters = {
      dotfiles = false,
      -- not show file.gz
      custom = { '.DS_Store', '*.gz', '*.zip', ".git", "node_modules", ".cache" }
   },
   disable_netrw = true,
   hijack_netrw = true,
   hijack_cursor = true,
   hijack_unnamed_buffer_when_opening = false,
   sync_root_with_cwd = true,
   update_focused_file = {
      enable = true,
      update_root = false,
   },
   view = {
      number = true,
      relativenumber = true,
      adaptive_size = false,
      side = "left",
      width = 45,
      preserve_window_proportions = true,
   },
   git = {
      enable = false,
      ignore = true,
   },
   filesystem_watchers = {
      enable = true,
   },
   actions = {
      open_file = {
         resize_window = false,
      },
   },
   renderer = {
      root_folder_label = false,
      highlight_git = false,
      highlight_opened_files = "none",
      root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" },

      indent_markers = {
         enable = false,
      },

      icons = {
         show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = false,
         },

         glyphs = {
            default = "󰈚",
            symlink = "",
            folder = {
               default = "",
               empty = "",
               empty_open = "",
               open = "",
               symlink = "",
               symlink_open = "",
               arrow_open = "",
               arrow_closed = "",
            },
            git = {
               unstaged = "✗",
               staged = "✓",
               unmerged = "",
               renamed = "➜",
               untracked = "★",
               deleted = "",
               ignored = "◌",
            },
         },
      },
   },
}

return options
