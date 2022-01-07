local function file_exists(name)
    local f = io.open(name, "r")
    return f ~= nil and io.close(f)
end

local function read_lines(f)
   local ll = {} 
   for line in f:lines() do
       table.insert(ll, line)
   end
   return ll
end
local function tableToString(t)
  return table.concat(t, "\n")
end

local function read_history() 
    local file_name = require("packer.util").join(vim.fn.stdpath("data"), "rgflow_history.txt")
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

local function write_history()
    if file_exists(file_name) then
        f = io.open(file_name, "r") 
    else
        f = io.open(file_name, "w+") 
    end
end