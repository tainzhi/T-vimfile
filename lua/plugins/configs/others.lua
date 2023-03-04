local M = {}

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

M.blankline = function()
   require("indent_blankline").setup {
      indentLine_enabled = 1,
      char = "▏",
      filetype_exclude = {
         "help",
         "terminal",
         "dashboard",
         "packer",
         "lspinfo",
         "TelescopePrompt",
         "TelescopeResults",
      },
      buftype_exclude = { "terminal" },
      show_trailing_blankline_indent = false,
      show_first_indent_level = false,
   }
end

M.colorizer = function()
   local present, colorizer = pcall(require, "colorizer")
   if present then
      colorizer.setup({ "*" }, {
         RGB = true, -- #RGB hex codes
         RRGGBB = true, -- #RRGGBB hex codes
         names = false, -- "Name" codes like Blue
         RRGGBBAA = false, -- #RRGGBBAA hex codes
         rgb_fn = false, -- CSS rgb() and rgba() functions
         hsl_fn = false, -- CSS hsl() and hsla() functions
         css = false, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
         css_fn = false, -- Enable all CSS *functions*: rgb_fn, hsl_fn

         -- Available modes: foreground, background
         mode = "background", -- Set the display mode.
      })
      vim.cmd "ColorizerReloadAllBuffers"
   end
end

M.comment = function()
   local present, nvim_comment = pcall(require, "nvim_comment")
   if present then
      nvim_comment.setup()
   end
end

M.signature = function()
   local present, lspsignature = pcall(require, "lsp_signature")
   if present then
      lspsignature.setup {
         bind = true,
         doc_lines = 0,
         floating_window = true,
         fix_pos = true,
         hint_enable = true,
         hint_prefix = " ",
         hint_scheme = "String",
         hi_parameter = "Search",
         max_height = 22,
         max_width = 120, -- max_width of signature floating_window, line will be wrapped if exceed max_width
         handler_opts = {
            border = "single", -- double, single, shadow, none
         },
         zindex = 200, -- by default it will be on top of all floating windows, set to 50 send it to bottom
         padding = "", -- character to pad on left and right of signature can be ' ', or '|'  etc
      }
   end
end

M.dap_lua = function()
   local dap = require"dap"
   dap.configurations.lua = { 
   { 
      type = 'nlua', 
      request = 'attach',
      name = "Attach to running Neovim instance",
      host = function()
         local value = vim.fn.input('Host [127.0.0.1]: ')
         if value ~= "" then
         return value
         end
         return '127.0.0.1'
      end,
      port = function()
         local val = tonumber(vim.fn.input('Port: '))
         assert(val, "Please provide a port number")
         return val
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
