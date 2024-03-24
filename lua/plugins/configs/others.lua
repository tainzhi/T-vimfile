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

M.comment = function()
   local present, nvim_comment = pcall(require, "nvim_comment")
   if present then
      nvim_comment.setup()
   end
end

M.dap_lua = function()
   local dap = require "dap"
   dap.configurations.lua = {
      {
         type = 'nlua',
         request = 'attach',
         name = "Attach to running Neovim instance",
         autoReload = {
            enable = true,
         },
         host = function()
            -- local value = vim.fn.input('Host [127.0.0.1]: ')
            -- if value ~= "" then
            --    return value
            -- end
            return '127.0.0.1'
         end,
         port = function()
            -- local value = vim.fn.input('Port [8086]: ')
            -- if value ~= "" then
            --    return value
            -- end
            return "8086"
         end,
      }
   }

   dap.adapters.nlua = function(callback, config)
      callback({ type = 'server', host = config.host, port = config.port })
   end
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
