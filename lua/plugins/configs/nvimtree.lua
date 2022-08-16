local present, nvimtree = pcall(require, "nvim-tree")
local git_status = require("core.config").plugins.options.nvimtree.enable_git

if not present then
   return
end

nvimtree.setup {
   diagnostics = {
      enable = false,
      icons = {
         hint = "",
         info = "",
         warning = "",
         error = "",
      },
   },
   filters = {
      dotfiles = false,
      -- not show file.gz 
      custom = { '.DS_Store', '*.gz' , '*.zip', ".git", "node_modules", ".cache" }
   },
   disable_netrw = true,
   hijack_netrw = true,
   ignore_ft_on_setup = { "dashboard" },
   open_on_tab = true,
   hijack_cursor = true,
   update_cwd = true,
   update_focused_file = {
      enable = true,
      update_cwd = false,
   },
   view = {
      number = true,
      relativenumber = true,
      side = "left",
      width = "25%"
   },
   renderer = {
      -- append a trailing slash to folder names
      add_trailing = false,
      highlight_opened_files = "all",
      root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" }
   },
}
