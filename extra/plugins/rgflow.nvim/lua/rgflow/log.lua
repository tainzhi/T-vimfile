-- for linux, the log file is located at ~/.cache/nvim/rgflow.log and ~/.cache/nvim/rgflow/history_record.txt
-- for windows, the log file is located at %USERPROFILE%\AppData\Local\temp\nvim\rgflow.log and %USERPROFILE%\AppData\Local\temp\nvim\rgflow\history_record.txt
local log = require "plenary.log".new{
plugin = "rgflow",
level = "debug",
use_console = "false",
}

return log
