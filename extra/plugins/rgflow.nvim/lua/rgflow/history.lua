-- log文件是  ~/user/Temp/nvim/rgflow.log
--
-- history_record.txt是  ~/user/Temp/nvim/rgflow/history_record.txt
-- history_record.txt格式：[[hash(path和pattern拼接) pattern pattern_match_cnt]]
-- 每次搜索成功都会把 文件标识和pattern拼接后的[[hash(path和pattern拼接) pattern pattern_match_cnt]] 添加到 history_record.txt末尾
--
-- 每次搜索结果单独存储一个文件，文件名是 hash(path和pattern拼接)，该文件在 ~/user/Temp/nvim/rgflow/中
-- todo:
-- 1. 定期清理历史记录，只保留最近10条记录

local Path = require "plenary.path"
local log = require "rgflow.log"
local default_search_pattern =  require("rgflow.default_search_pattern")
local history_record_limit = 5
local records_cache = {}

local history = {
  record_file = Path:new({ vim.fn.stdpath("cache"), "rgflow", "history_record.txt" }),
}

-- 对 url 进行base64编码
-- 参考：https://github.com/glacambre/firenvim
local function base64_enc(data)
  -- local b =
  -- 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/' -- You will need this for encoding/decoding
  -- local result = ((data:gsub('.', function(x)
  --   local r, b = '', x:byte()
  --   for i = 8, 1, -1 do r = r .. (b % 2 ^ i - b % 2 ^ (i - 1) > 0 and '1' or '0') end
  --   return r;
  -- end) .. '0000'):gsub('%d%d%d?%d?%d?%d?', function(x)
  --   if (#x < 6) then return '' end
  --   local c = 0
  --   for i = 1, 6 do c = c + (x:sub(i, i) == '1' and 2 ^ (6 - i) or 0) end
  --   return b:sub(c + 1, c + 1)
  -- end) .. ({ '', '==', '=' })[#data % 3 + 1])
  -- return string.sub(result, 1, math.min(#result, 64))
  return vim.fn.sha256(data)
end


-- 从history_record.txt中获取搜索pattern
-- 并且合并默认搜索pattern
-- 在合并过程中要去重
-- 最终返回一个数组
function history.get_search_patterns()
  local items = {}
  -- 用于去重
  local seen_items = {}
  if history.record_file:exists() then
    -- 添加历史搜索pattern
    -- 读取最后10行的记录，
    -- 因为读取的是字符串，所以需要用换行符分割成数组
    local lines = history.record_file:tail(history_record_limit)
    lines = vim.split(lines, '\n')
    -- 每一条记录组成是 '文件标识和pattern拼接后的hash pattern'，用\t分割
    -- 所以，需要拆分
    for i = 1, #lines do
      local line = lines[i]
      local fields = vim.split(line, '\t')
      if (#fields) == 3 then
        -- local hash_of_path_pattern = fields[1]
        local pattern = fields[2]
        -- local pattern_match_cnt = fields[3]
        pattern = string.gsub(pattern, '\r', '')
        pattern = string.gsub(pattern, '\n', '')
        if not seen_items[pattern] then
          seen_items[pattern] = true
          items[#items + 1] = pattern
        end
      end
    end
    log.debug("add " .. #lines .. " history patterns")
  else
    log.info("no history patterns")
  end

  -- 添加默认搜索pattern
  for _, v in ipairs(default_search_pattern) do
    if not seen_items[v] then
      seen_items[v] = true
      table.insert(items, v)
    end
  end
  log.debug("finally add " .. #items .. " patterns")
  return items
end

-- 把搜索pattern添加到history_record.txt文件末尾
-- 每一行存储一个搜索记录，其形式为
--
-- key pattern pattern_match_cnt
--
-- 其中key是path和pattern的拼接字符串hash
function history.write_search_pattern(key, pattern, pattern_match_cnt)
  if not history.record_file:exists() then
    history.record_file:touch { parents = true }
    log.info("create " .. history.record_file:absolute())
  end
  -- 把 path和pattern的拼接字符串hash作为key，存入每行第一个，pattern作为每行的第2个
  pattern = string.gsub(pattern, '\r', '')
  pattern = string.gsub(pattern, '\n', '')
  local record = key .. '\t' .. pattern .. '\t' .. pattern_match_cnt .. '\n'
  -- 把 record 添加在文件末尾
  history.record_file:write(record, 'a')
end

function history.store_search_result(path, pattern, match_cnt, results)
  local key = base64_enc(path .. pattern)
  records_cache[key] = { key, pattern, match_cnt }
  -- 先存储单挑搜索pattern记录
  history.write_search_pattern(key, pattern, match_cnt)
  -- 再存储该搜索记录的结果到单独文件中
  log.info("key: " .. key .. ", store search results for " .. path .. " and pattern:" .. pattern)
  local results_path = Path:new({ vim.fn.stdpath("cache"), "rgflow", key })
  results_path:touch { parents = true }
  results_path:write(results, 'w')
end

function history.restore_search_result(path, pattern)
  local key = base64_enc(path .. pattern)
  if rawget(records_cache, key) then
    local record = records_cache[key]
    log.info("get saved search results for " .. path .. " and pattern:" .. pattern)
    local results_path = Path:new({ vim.fn.stdpath("cache"), "rgflow", key })
    if results_path:exists() then
      return {
        pattern = record[2],
        match_cnt = record[3],
        results = results_path:read(),
      }
    else
      log.error("but saved search results for " .. path .. " and pattern:" .. pattern .. " missing")
      return nil
    end
  else
    log.info("not saved search results for " .. path .. " and pattern:" .. pattern)
    return nil
  end
end

function history.write_search_result(key, result)
  local path = Path:new({ vim.fn.stdpath("cache"), "rgflow", key })
  if not path:exists() then
    path:touch { parents = true }
  end
  history.record_file:write(result, 'w')
end

function history:get_search_result(key)
  local path = Path:new({ vim.fn.stdpath("cache"), "rgflow", key })
  if path:exists() then
    return path:read()
  end
  return nil
end

function history.test()
  local record_file = Path:new({ vim.fn.stdpath("cache"), "rgflow", "history_record.txt" })
  if not record_file:exists() then
    record_file:touch { parents = true }
  end
  log.debug("write text to:", record_file:absolute())
  log.info "test end, write text end"

  -- 用路径来标记
  -- 把路径中的分隔符和冒号替换成下划线
  local path    = vim.fn.getcwd()
  path          = string.gsub(path, Path.path.sep, '_')
  path          = string.gsub(path, ':', '_')

  local pattern = "hello|wolrd\\| dkfd * ? dfkd"
  local record  = path .. '\t' .. vim.fn.sha256(pattern) .. '\t' .. pattern .. '\n'
  record_file:write(record, 'a')
  record_file:write(record, 'a')
  record_file:write(record, 'a')
  record_file:write(record, 'a')

  -- 读取最后10行的记录，
  -- 因为读取的是字符串，所以需要用换行符分割成数组
  local lines = record_file:tail(10)
  lines = vim.split(lines, '\n')
  print(#lines)
  -- 每一条记录组成是 '文件标识 记录的hash 记录'，用\t分割
  -- 所以，需要拆分
  local record = nil
  if (#lines) == 10 then
    last_record = vim.split(lines[10], '\t')
    print(lines[10])
    print(last_record[1], last_record[2], last_record[3])
  else
    last_record = vim.split(lines[1], '\t')
    print(lines[1])
    print(last_record[1], last_record[2], last_record[3])
  end


  local current_record_file = Path:new({ vim.fn.stdpath("cache"), "rgflow", last_record[2] })
  if not current_record_file:exists() then
    print("create new record file")
    -- current_record_file:touch()
    local result = "hello\r\nworld\r\nnew file\r\n"
    current_record_file:write(result, 'w')
  else
    local data = current_record_file:read()
    print(data)
    print("record file exists, read it")
  end



  -- return record_file:absolute()
  return path
end

return history
