local present, ls = pcall(require, "luasnip")
if not present then
    return
end

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

local copy_from_reg = function(_, _, _)
    local res = {}
    local textlines = vim.fn.getreg('+', 1, true)
    for _, line in ipairs(textlines) do
        -- 替换掉从quicxfix拷贝的内容的文件名和行号
        -- anr_2021-12-31-15-38-32-806.20211231_1538.txt|4 col 24| Cmd line: com.android.camera
        -- 删除第二个竖线前面的所有内容
        -- 使用的 lua 匹配规则，而不是 vim 匹配规则
        local removed_fc = string.gsub(line,".-|.-| ","")
        -- 删除插件 rgflow生成的quickfix行中的换号符号 \30
        local removed_delimiter = string.gsub(removed_fc, "\30", "")
        table.insert(res, removed_delimiter)
    end
    return res
end

local M = {
    s("eng",{
        -- "" is newline
        t({"Please engine further analyze it.", ""}),
        i(0),
    }),
    s("mcf", {
        t({"Please MCF further analyze it.", ""}),
        i(0),
    }),
    s("iq",{
        -- "" is newline
        t({"Please engine further analyze it.", ""}),
        i(0),
    }),
    s("code", {
        t({[[{noformat}]], ""}),
        -- put content in + register
        f(copy_from_reg, {}, ""),
        -- t({vim.fn.getreg('+'), ""}),
        t({"", [[{noformat}]], ""}),
        i(0),
    }),

    s("fix", {
        t({"It has been fixed by "}),
        -- put content in + register
        f(copy_from_reg, {}, ""),
        -- t({vim.fn.getreg('+'), ""}),
        t({" and waiting to be merged."}),
        i(0),
    }),

    s("report",{
        t({"It's user version which printed logs is restricted and has no detailed logs about camera app running", ""}),
        t({"Would you help to ask the reporter to reupload a recording video and picture to describe that taken scene?", ""}),
        t({"BR"}),
    }),
}
return M
