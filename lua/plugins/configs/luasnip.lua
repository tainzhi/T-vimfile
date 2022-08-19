local present, ls = pcall(require, "luasnip")
if not present then
    return
end

ls.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
}

require("luasnip.loaders.from_lua").lazy_load( { paths =  "./lua/snippets" })
require("luasnip.loaders.from_vscode").lazy_load()
