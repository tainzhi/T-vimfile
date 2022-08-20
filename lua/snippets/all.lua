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

local date_input = function(args, state, fmt)
	local fmt = fmt or "%Y-%m-%d"
	return sn(nil, i(1, os.date(fmt)))
end

local M = {
    s("date",{
        t("It was a dark and stormy night on "),
        d(1, date_input, {}, "%A, %B %d of %Y"),
        t(" and the clocks were striking thirteen."),
    }),
}
return M
