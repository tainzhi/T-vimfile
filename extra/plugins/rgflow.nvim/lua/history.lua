rgflow_history = {}

local Path = require "plenary.path"

function rgflow_history.file_exists(name)
    local f = io.open(name, "r")
    return f ~= nil and io.close(f)
end

function rgflow_history.read_lines(f)
   local ll = {} 
   for line in f:lines() do
       table.insert(ll, line)
   end
   return ll
end

function rgflow_history.tableToString(t)
  return table.concat(t, "\n")
end

function rgflow_history.read_history() 
    local file_name = require("plenary.path").join(vim.fn.stdpath("data"), "rgflow_history.txt")
    local f
    if file_exists(file_name) then
        f = io.open(file_name, "r") 
    else
        f = io.open(file_name, "w+") 
    end
    local lines = read_lines(f)
    f.close()
    return lines
end

function rgflow_history.write_history()
    if file_exists(file_name) then
        f = io.open(file_name, "r") 
    else
        f = io.open(file_name, "w+") 
    end
end

function rgflow_history.test()
  local _a = Path::new(vim.fn.stdpath("data"))
  local a = Path(vim.fn.stdpath("data")):joinpath('lua', 'plugin')
  local aa = a.parent;
  local ab = a.stem;
  local b = Path:joinpath(a, 'test.txt')
  local c = Path:joinpath(vim.fn.stdpath("data"), 'lua', 'lsp', 'bash.lua')
  return hello
end

return rgflow_history
