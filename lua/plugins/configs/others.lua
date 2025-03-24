local M = {}
local utils = require "core.utils"

M.better_escape = function()
   require("better_escape").setup {
      -- todo
      mapping = "jk",
      timeout = 300,
   }
end

M.im_select = function()
   local present, im_select = pcall(require, "im_select")
   local default_im_select
   local default_command
   -- Can be binary's name or binary's full path,
   -- e.g. 'im-select' or '/usr/local/bin/im-select'
   -- For Windows/WSL, default: "C:\\Progra~1\\im-select.exe" 即在 C:\\program files目录下
   -- For macOS, default: "im-select"
   if jit.os == "Windows" then
      default_command = 'C:\\im-select.exe'
      default_im_select = '1033'
   elseif jit.os == "Linux" then
      default_command = "/bin/ibus"
      default_im_select = "engine xkb:us::eng"
   elseif jit.os == "OSX" then
      default_command = 'im-select'
      default_im_select = 'com.apple.keylayout.ABC'
   end
   if present then
      im_select.setup {
         -- IM will be set to `default_im_select` in `normal` mode
         -- For Windows/WSL, default: "1033", aka: English US Keyboard
         -- For macOS, default: "com.apple.keylayout.ABC", aka: US
         -- For Linux, default:
         --               "keyboard-us" for Fcitx5
         --               "1" for Fcitx
         --               "xkb:us::eng" for ibus
         -- You can use `im-select` or `fcitx5-remote -n` to get the IM's name
         default_im_select       = default_im_select,

         -- Can be binary's name, binary's full path, or a table, e.g. 'im-select',
         -- '/usr/local/bin/im-select' for binary without extra arguments,
         -- or { "AIMSwitcher.exe", "--imm" } for binary need extra arguments to work.
         -- For Windows/WSL, default: "im-select.exe"
         -- For macOS, default: "macism"
         -- For Linux, default: "fcitx5-remote" or "fcitx-remote" or "ibus"
         default_command         =  default_command,

         -- Restore the default input method state when the following events are triggered
         set_default_events      = { "VimEnter", "FocusGained", "InsertLeave", "CmdlineLeave" },

         -- Restore the previous used input method state when the following events
         -- are triggered, if you don't want to restore previous used im in Insert mode,
         -- e.g. deprecated `disable_auto_restore = 1`, just let it empty
         -- as `set_previous_events = {}`
         set_previous_events     = { "InsertEnter", "CmdlineEnter" },
         
         -- Show notification about how to install executable binary when binary missed
         keep_quiet_on_no_binary = false,

         -- Async run `default_command` to switch IM or not
         async_switch_im         = true
      }
   end
end

return M
