local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local entry_display = require "telescope.pickers.entry_display"
local conf = require("telescope.config").values -- our picker function: colors
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local history = require "rgflow.history"
local strings = require "plenary.strings"

local records = history.get_search_records()

local widths = {
  path = 0,
  pattern = 0,
  match_cnt = 0,
}

for _, v in ipairs(records) do
  if v.path then
    widths.path = math.max(#(v.path), widths.path)
  end
  if v.pattern  then
    widths.pattern = math.max(#(v.pattern), widths.pattern)
  end
  if v.match_cnt then
    widths.match_cnt = math.max(#(tostring((v.match_cnt))), widths.match_cnt)
  end
end
print(vim.inspect(widths))

local displayer = entry_display.create {
  separator = " ",
  items = {
    -- { width = widths.pattern },
    -- { width = widths.pattern },
    -- { width = widths.match_cnt },}
    { width = 800 },
    { width = 800 },
    { width = 800 },}
}

local make_display = function(records)
  return displayer {
    { records.pattern, "Comment" },
    { records.pattern, "Identifier" },
    { records.match_cnt, "Number" },
  }
end

local colors = function(opts)
  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "rgflow recent search patterns",
    finder = finders.new_table {
      results = records,
      entry_maker = function(record)
        record.value = record.pattern
        record.ordinal = record.pattern
        record.display = make_display
        return record
      end,
    },
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local selection = action_state.get_selected_entry()
        -- vim.api.nvim_put({ selection[1]}, "", false, true)
        vim.api.nvim_put({vim.inspect(selection)}, "", false, true)
        -- print(vim.inspect(selection))
      end)
      return true
    end,
  }):find()
end

-- to execute the function
colors(require("telescope.themes").get_dropdown {})
