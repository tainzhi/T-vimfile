local history = require "rgflow.history"
local source = {}

function source.new()
  return setmetatable({}, { __index = source })
end

-- 补全内容是从默认搜索pattern和历史搜索pattern中获取
function source:complete(request, callback)
  local default_patterns = history.get_search_patterns()
  local items = {}
  for i = 1, #default_patterns do
    items[#items + 1] = { label = default_patterns[i], dup = 0 }
  end
  callback({ items = items , isInComplete = true })
end

return source
