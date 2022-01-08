local present, ls = pcall(require, "luasnip")
if not present then
    return
end

ls.config.set_config {
    history = true,
    updateevents = "TextChanged,TextChangedI",
}

ls.snippets = {
    all = require("snippets.all"),
    idart = require("snippets.idart"),
}

require("luasnip.loaders.from_vscode").load()
