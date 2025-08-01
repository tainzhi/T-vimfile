local M = {}

M.close_buffer = function(bufexpr, force)
   -- This is a modification of a NeoVim plugin from
   -- Author: ojroques - Olivier Roques
   -- Src: https://github.com/ojroques/nvim-bufdel
   -- (Author has okayed copy-paste)

   -- Options
   local opts = {
      next = "cycle", -- how to retrieve the next buffer
      quit = false, -- exit when last buffer is deleted
      --TODO make this a chadrc flag/option
   }

   -- ----------------
   -- Helper functions
   -- ----------------

   -- Switch to buffer 'buf' on each window from list 'windows'
   local function switch_buffer(windows, buf)
      local cur_win = vim.fn.winnr()
      for _, winid in ipairs(windows) do
         vim.cmd(string.format("%d wincmd w", vim.fn.win_id2win(winid)))
         vim.cmd(string.format("buffer %d", buf))
      end
      vim.cmd(string.format("%d wincmd w", cur_win)) -- return to original window
   end

   -- Select the first buffer with a number greater than given buffer
   local function get_next_buf(buf)
      local next = vim.fn.bufnr "#"
      if opts.next == "alternate" and vim.fn.buflisted(next) == 1 then
         return next
      end
      for i = 0, vim.fn.bufnr "$" - 1 do
         next = (buf + i) % vim.fn.bufnr "$" + 1 -- will loop back to 1
         if vim.fn.buflisted(next) == 1 then
            return next
         end
      end
   end

   -- ----------------
   -- End helper functions
   -- ----------------

   local buf = vim.fn.bufnr()
   if vim.fn.buflisted(buf) == 0 then -- exit if buffer number is invalid
      vim.cmd "close"
      return
   end

   if #vim.fn.getbufinfo { buflisted = 1 } < 2 then
      if opts.quit then
         -- exit when there is only one buffer left
         if force then
            vim.cmd "qall!"
         else
            vim.cmd "confirm qall"
         end
         return
      end

      local chad_term, type = pcall(function()
         return vim.api.nvim_buf_get_var(buf, "term_type")
      end)

      if chad_term then
         -- Must be a window type
         vim.cmd(string.format("setlocal nobl", buf))
         vim.cmd "enew"
         return
      end
      -- don't exit and create a new empty buffer
      vim.cmd "enew"
      vim.cmd "bp"
   end

   local next_buf = get_next_buf(buf)
   local windows = vim.fn.getbufinfo(buf)[1].windows

   -- force deletion of terminal buffers to avoid the prompt
   if force or vim.fn.getbufvar(buf, "&buftype") == "terminal" then
      local chad_term, type = pcall(function()
         return vim.api.nvim_buf_get_var(buf, "term_type")
      end)

      -- TODO this scope is error prone, make resilient
      if chad_term then
         if type == "wind" then
            -- hide from bufferline
            vim.cmd(string.format("%d bufdo setlocal nobl", buf))
            -- swtich to another buff
            -- TODO switch to next bufffer, this works too
            vim.cmd "BufferLineCycleNext"
         else
            local cur_win = vim.fn.winnr()
            -- we can close this window
            vim.cmd(string.format("%d wincmd c", cur_win))
            return
         end
      else
         switch_buffer(windows, next_buf)
         vim.cmd(string.format("bd! %d", buf))
      end
   else
      switch_buffer(windows, next_buf)
      vim.cmd(string.format("silent! confirm bd %d", buf))
   end
   -- revert buffer switches if user has canceled deletion
   if vim.fn.buflisted(buf) == 1 then
      switch_buffer(windows, buf)
   end
end

-- hide statusline
-- todo remove or fix
-- M.hide_statusline = function()
--    local hidden = require("core.config").plugins.options.statusline.hidden
--    local shown = require("core.config").plugins.options.statusline.shown
--    local api = vim.api
--    local buftype = api.nvim_buf_get_option("%", "ft")

--    -- shown table from config has the highest priority
--    if vim.tbl_contains(shown, buftype) then
--       api.nvim_set_option("laststatus", 2)
--       return
--    end

--    if vim.tbl_contains(hidden, buftype) then
--       api.nvim_set_option("laststatus", 0)
--       return
--    else
--       api.nvim_set_option("laststatus", 2)
--    end
-- end


-- load plugin after entering vim ui
M.lazy_load = function(plugin)
   vim.api.nvim_create_autocmd({ "BufRead", "BufWinEnter", "BufNewFile" }, {
     group = vim.api.nvim_create_augroup("BeLazyOnFileOpen" .. plugin, {}),
     callback = function()
       local file = vim.fn.expand "%"
       local condition = file ~= "NvimTree_1" and file ~= "[lazy]" and file ~= ""
 
       if condition then
         vim.api.nvim_del_augroup_by_name("BeLazyOnFileOpen" .. plugin)
 
         -- dont defer for treesitter as it will show slow highlighting
         -- This deferring only happens only when we do "nvim filename"
         if plugin ~= "nvim-treesitter" then
           vim.schedule(function()
             require("lazy").load { plugins = plugin }
 
             if plugin == "nvim-lspconfig" then
               vim.cmd "silent! do FileType"
             end
           end, 0)
         else
           require("lazy").load { plugins = plugin }
         end
       end
     end,
   })
end

M.neovide_fullscreen = function()
   local orginalValue = vim.g.neovide_fullscreen
   if orginalValue == 1 then
      vim.cmd[[ let g:neovide_fullscreen = 0]]
   else
      vim.cmd[[ let g:neovide_fullscreen = 1]]
   end
end

M.foldexpr = function() 
  local buf = vim.api.nvim_get_current_buf()
  if vim.b[buf].ts_folds == nil then
    -- as long as we don't have a filetype, don't bother
    -- checking if treesitter is available (it won't)
    if vim.bo[buf].filetype == "" then
      return "0"
    end
    if vim.bo[buf].filetype:find("dashboard") then
      vim.b[buf].ts_folds = false
    else
      vim.b[buf].ts_folds = pcall(vim.treesitter.get_parser, buf)
    end
  end
  return vim.b[buf].ts_folds and vim.treesitter.foldexpr() or "0"
end

return M
