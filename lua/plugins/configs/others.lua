local M = {}
local utils = require "core.utils"

M.autopairs = function()
   local present1, autopairs = pcall(require, "nvim-autopairs")
   local present2, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")

   if not (present1 or present2) then
      return
   end

   autopairs.setup()

   -- not needed if you disable cmp, the above var related to cmp tooo! override default config for autopairs
   local cmp = require "cmp"
   cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
end

M.better_escape = function()
   require("better_escape").setup {
      -- todo
      mapping = "jk",
      timeout = 300,
   }
end

M.im_select = function()
   local present, im_select = pcall(require, "im_select")
   if present then
      im_select.setup {
         -- IM will be set to `default_im_select` in `normal` mode(`EnterVim` or `InsertLeave`)
         -- For Windows/WSL, default: "1033", aka: English US Keyboard
         -- For macOS, default: "com.apple.keylayout.ABC", aka: US
         -- You can use `im-select` in cli to get the IM's name you preferred
         default_im_select    = "1033",

         -- Set to 1 if you don't want restore IM status when `InsertEnter`
         disable_auto_restore = 0,

         -- Can be binary's name or binary's full path,
         -- e.g. 'im-select' or '/usr/local/bin/im-select'
         -- For Windows/WSL, default: "im-select.exe"
         -- For macOS, default: "im-select"
         default_command      = 'C:\\Progra~1\\im-select.exe'
      }
   end
end

return M
