local present, nvimtree = pcall(require, "nvim-tree")

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
   hijack_cursor = true,
   sync_root_with_cwd = true,
   update_focused_file = {
      enable = true,
      update_cwd = false,
   },
   tab = {
      sync = {
         
      }
   },
   view = {
      number = true,
      relativenumber = true,
      side = "left",
      width = 30,
   },
   renderer = {
      -- append a trailing slash to folder names
      add_trailing = false,
      highlight_opened_files = "all",
      root_folder_modifier = table.concat { ":t:gs?$?/..", string.rep(" ", 1000), "?:gs?^??" }
   },
}
