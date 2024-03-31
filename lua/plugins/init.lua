-- All plugins have lazy=true by default,to load a plugin on startup just lazy=false
-- List of all default plugins & their definitions
local default_plugins = {
   { "nvim-lua/plenary.nvim" },

   {
      -- statusline
      'nvim-lualine/lualine.nvim',
      dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true },
      conifg = require("plugins.configs.lualine")
   },

   {
      "akinsho/bufferline.nvim",
      lazy = false,
      version = "*",
      dependencies = "kyazdani42/nvim-web-devicons",
      config = require("plugins.configs.bufferline")
   },

   {
      "lukas-reineke/indent-blankline.nvim",
      main = "ibl",
      init = function()
         require("core.utils").lazy_load "indent-blankline.nvim"
      end,
      config = function()
         local highlight = {
            "RainbowRed",
            "RainbowYellow",
            "RainbowBlue",
            "RainbowOrange",
            "RainbowGreen",
            "RainbowViolet",
            "RainbowCyan",
         }

         local hooks = require "ibl.hooks"
         -- create the highlight groups in the highlight setup hook, so they are reset
         -- every time the colorscheme changes
         hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
            vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
            vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
            vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
            vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
            vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
            vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
            vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
         end)

         require("ibl").setup { indent = { highlight = highlight } }
      end
   },

   {
      "nvim-treesitter/nvim-treesitter",
      event = "BufRead",
      ft = { "c", "c++", "lua", "sh", "java" },
      config = require("plugins.configs.treesitter"),
   },

   {
      "nvim-telescope/telescope.nvim",
      event = "VimEnter",
      cond = function()
         return vim.g.vscode == nil
      end,
      dependencies = {
         {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            cond = function()
               return vim.fn.executable 'make' == 1
            end
         },
         {
            "nvim-telescope/telescope-media-files.nvim",
         },
         { 'nvim-telescope/telescope-ui-select.nvim' },
      },
      config = require("plugins.configs.telescope")
   },

   -- git stuff
   {
      "lewis6991/gitsigns.nvim",
      ft = { "gitcommit", "diff" },
      init = function()
         -- load gitsigns only when a git file is opened
         vim.api.nvim_create_autocmd({ "BufRead" }, {
            group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
            callback = function()
               vim.fn.jobstart({ "git", "-C", vim.loop.cwd(), "rev-parse" },
                  {
                     on_exit = function(_, return_code)
                        if return_code == 0 then
                           vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
                           vim.schedule(function()
                              require("lazy").load { plugins = { "gitsigns.nvim" } }
                           end)
                        end
                     end
                  }
               )
            end,
         })
      end,
   },

   -- references 1: https://github.com/AstroNvim/AstroNvim
   -- references 2: https://github.com/nvim-lua/kickstart.nvim/blob/master/lua/kickstart/plugins/debug.lua
   -- {
   --    "mfussenegger/nvim-dap",
   --    -- enabled = vim.fn.has "win32" == 0,
   --    -- lazy = false,
   --    ft = { "lua", "cpp", "h", "python", "bash" },
   --    dependencies = {
   --       {
   --          "folke/neodev.nvim",
   --       },
   --       {
   --          'jbyuki/one-small-step-for-vimkind',
   --       },
   --       {
   --          "jay-babu/mason-nvim-dap.nvim",
   --          dependencies = { "nvim-dap" },
   --          cmd = { "DapInstall", "DapUninstall" },
   --          opts = { handlers = {} },
   --       },
   --       {
   --          "rcarriga/nvim-dap-ui",
   --          dependencies = { "nvim-neotest/nvim-nio" },
   --          opts = { floating = { border = "rounded" } },
   --       },
   --       {
   --          "rcarriga/cmp-dap",
   --          dependencies = { "nvim-cmp" },
   --       },
   --    },
   --    config = function()
   --       require("plugins.configs.others").dap_lua()
   --    end,
   -- },
   {
      'mfussenegger/nvim-dap',
      ft = { "lua", "cpp", "h", "python", "bash" },
      dependencies = {

         'jbyuki/one-small-step-for-vimkind',

         -- Creates a beautiful debugger UI
         'rcarriga/nvim-dap-ui',

         -- Required dependency for nvim-dap-ui
         'nvim-neotest/nvim-nio',

         -- Installs the debug adapters for you
         'williamboman/mason.nvim',
         'jay-babu/mason-nvim-dap.nvim',

         -- Add your own debuggers here
         'leoluz/nvim-dap-go',
      },
      config = function()
         local dap = require 'dap'
         local dapui = require 'dapui'

         require('mason-nvim-dap').setup {
            -- Makes a best effort to setup the various debuggers with
            -- reasonable debug configurations
            automatic_setup = true,

            -- You can provide additional configuration to the handlers,
            -- see mason-nvim-dap README for more information
            handlers = {},

            -- You'll need to check that you have the required things installed
            -- online, please don't ask me how to install them :)
            ensure_installed = {
               -- Update this to ensure that you have the debuggers for the langs you want
               'delve',
            },
         }

         -- Basic debugging keymaps, feel free to change to your liking!
         vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
         vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
         vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
         vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
         vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
         vim.keymap.set('n', '<leader>B', function()
            dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
         end, { desc = 'Debug: Set Breakpoint' })

         -- Dap UI setup
         -- For more information, see |:help nvim-dap-ui|
         dapui.setup {
            -- Set icons to characters that are more likely to work in every terminal.
            --    Feel free to remove or use ones that you like more! :)
            --    Don't feel like these are good choices.
            icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
            controls = {
               icons = {
                  pause = '⏸',
                  play = '▶',
                  step_into = '⏎',
                  step_over = '⏭',
                  step_out = '⏮',
                  step_back = 'b',
                  run_last = '▶▶',
                  terminate = '⏹',
                  disconnect = '⏏',
               },
            },
         }

         dap.configurations.lua = {
            {
               type = 'nlua',
               request = 'attach',
               name = "Attach to running Neovim instance",
               autoReload = {
                  enable = true,
               },
               host = function()
                  -- local value = vim.fn.input('Host [127.0.0.1]: ')
                  -- if value ~= "" then
                  --    return value
                  -- end
                  return '127.0.0.1'
               end,
               port = function()
                  -- local value = vim.fn.input('Port [8086]: ')
                  -- if value ~= "" then
                  --    return value
                  -- end
                  return "8086"
               end,
            }
         }

         dap.adapters.nlua = function(callback, config)
            callback({ type = 'server', host = config.host, port = config.port })
         end

         -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
         vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

         dap.listeners.after.event_initialized['dapui_config'] = dapui.open
         dap.listeners.before.event_terminated['dapui_config'] = dapui.close
         dap.listeners.before.event_exited['dapui_config'] = dapui.close
      end,
   },

   {
      'neovim/nvim-lspconfig',
      ft = { "lua", "cpp", "h", "python", "bash" },
      dependencies = {
         'williamboman/mason.nvim',
         'williamboman/mason-lspconfig.nvim',
         'WhoIsSethDaniel/mason-tool-installer.nvim',

         -- Useful status updates for LSP.
         -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
         { 'j-hui/fidget.nvim', opts = {} },

         -- `neodev` configures Lua LSP for your Neovim config, runtime and plugins
         -- used for completion, annotations and signatures of Neovim apis
         { 'folke/neodev.nvim', opts = {} },
      },
      config = function()
         vim.api.nvim_create_autocmd('LspAttach', {
            group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
            callback = function(event)
               -- See `:help vim.diagnostic.*` for documentation on any of the below functions
               vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
               vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
               vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
               vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

               -- Enable completion triggered by <c-x><c-o>
               vim.bo[event.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'
               local map = function(keys, func, desc)
                  vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
               end

               -- Jump to the definition of the word under your cursor.
               --  This is where a variable was first declared, or where a function is defined, etc.
               --  To jump back, press <C-t>.
               map('<C-]>', vim.lsp.buf.declaration, 'Lsp: Go to declaration')
               map('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

               -- Find references for the word under your cursor.
               map('gr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

               -- Jump to the implementation of the word under your cursor.
               --  Useful when your language has ways of declaring types without an actual implementation.
               map('gI', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

               -- Jump to the type of the word under your cursor.
               --  Useful when you're not sure what type a variable is and you want to see
               --  the definition of its *type*, not where it was *defined*.
               map('<leader>D', require('telescope.builtin').lsp_type_definitions, 'Type [D]efinition')

               -- Fuzzy find all the symbols in your current document.
               --  Symbols are things like variables, functions, types, etc.
               map('<leader>ds', require('telescope.builtin').lsp_document_symbols, '[D]ocument [S]ymbols')

               -- Fuzzy find all the symbols in your current workspace.
               --  Similar to document symbols, except searches over your entire project.
               map('<leader>ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, '[W]orkspace [S]ymbols')

               -- Rename the variable under your cursor.
               --  Most Language Servers support renaming across files, etc.
               map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

               -- Execute a code action, usually your cursor needs to be on top of an error
               -- or a suggestion from your LSP for this to activate.
               map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')

               -- Opens a popup that displays documentation about the word under your cursor
               --  See `:help K` for why this keymap.
               map('K', vim.lsp.buf.hover, 'Hover Documentation')

               -- WARN: This is not Goto Definition, this is Goto Declaration.
               --  For example, in C this would take you to the header.
               map('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

               -- The following two autocommands are used to highlight references of the
               -- word under your cursor when your cursor rests there for a little while.
               --    See `:help CursorHold` for information about when this is executed
               --
               -- When you move your cursor, the highlights will be cleared (the second autocommand).
               local client = vim.lsp.get_client_by_id(event.data.client_id)
               if client and client.server_capabilities.documentHighlightProvider then
                  vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
                     buffer = event.buf,
                     callback = vim.lsp.buf.document_highlight,
                  })

                  vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
                     buffer = event.buf,
                     callback = vim.lsp.buf.clear_references,
                  })
               end
            end,
         })

         -- LSP servers and clients are able to communicate to each other what features they support.
         --  By default, Neovim doesn't support everything that is in the LSP specification.
         --  When you add nvim-cmp, luasnip, etc. Neovim now has *more* capabilities.
         --  So, we create new capabilities with nvim cmp, and then broadcast that to the servers.
         local capabilities = vim.lsp.protocol.make_client_capabilities()
         capabilities = vim.tbl_deep_extend('force', capabilities, require('cmp_nvim_lsp').default_capabilities())

         -- Enable the following language servers
         --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
         --
         --  Add any additional override configuration in the following tables. Available keys are:
         --  - cmd (table): Override the default command used to start the server
         --  - filetypes (table): Override the default list of associated filetypes for the server
         --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
         --  - settings (table): Override the default settings passed when initializing the server.
         --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/
         local servers = {
            -- clangd = {},
            -- gopls = {},
            -- pyright = {},
            -- rust_analyzer = {},
            -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
            --
            -- Some languages (like typescript) have entire language plugins that can be useful:
            --    https://github.com/pmizio/typescript-tools.nvim
            --
            -- But for many setups, the LSP (`tsserver`) will work just fine
            -- tsserver = {},
            --

            lua_ls = {
               -- cmd = {...},
               -- filetypes = { ...},
               -- capabilities = {},
               settings = {
                  Lua = {
                     completion = {
                        callSnippet = 'Replace',
                     },
                     -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
                     -- diagnostics = { disable = { 'missing-fields' } },
                  },
               },
            },
         }

         -- Ensure the servers and tools above are installed
         --  To check the current status of installed tools and/or manually install
         --  other tools, you can run
         --    :Mason
         --
         --  You can press `g?` for help in this menu.
         require('mason').setup()

         -- You can add other tools here that you want Mason to install
         -- for you, so that they are available from within Neovim.
         local ensure_installed = vim.tbl_keys(servers or {})
         vim.list_extend(ensure_installed, {
            'stylua', -- Used to format Lua code
         })
         require('mason-tool-installer').setup { ensure_installed = ensure_installed }

         require('mason-lspconfig').setup {
            handlers = {
               function(server_name)
                  local server = servers[server_name] or {}
                  -- This handles overriding only values explicitly passed
                  -- by the server configuration above. Useful when disabling
                  -- certain features of an LSP (for example, turning off formatting for tsserver)
                  server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
                  require('lspconfig')[server_name].setup(server)
               end,
            },
         }
      end,
   },

   {
      "andymass/vim-matchup",
      lazy = true,
      init = function()
         require("core.utils").lazy_load "vim-matchup"
      end,
      cond = function()
         -- 当前buffer类型不是help
         return vim.api.nvim_buf_get_option(0, 'filetype') ~= 'help'
      end,
   },

   {
      "max397574/better-escape.nvim",
      event = "InsertEnter",
      config = function()
         require("plugins.configs.others").better_escape()
      end
   },

   -- load luasnips + cmp related in insert mode only
   {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      dependencies = {
         {
            -- snippet plugin
            "L3MON4D3/LuaSnip",
            dependencies = "rafamadriz/friendly-snippets",
            config = require("plugins.configs.luasnip")
         },

         -- autopairing of (){}[] etc
         {
            "windwp/nvim-autopairs",
            config = function()
               require("nvim-autopairs").setup({
                  fast_wrap = {},
                  disable_filetype = { "TelescopePrompt", "vim" },
               })

               -- setup cmp for autopairs
               local cmp_autopairs = require "nvim-autopairs.completion.cmp"
               require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
            end,
         },

         -- cmp sources plugins
         {
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            -- 对于超大文件，自动全局遍历文件后补全命令行会非常的慢，故禁用
            -- "hrsh7th/cmp-cmdline",
            "dmitmel/cmp-cmdline-history",
         },
      },
      config = require "plugins.configs.cmp",
   },

   {
      "numToStr/Comment.nvim",
      ft = { "lua", "cpp", "h", "python", "bash" },
      config = function()
         require('Comment').setup()
      end
   },

   -- file managing , picker etc
   {
      "kyazdani42/nvim-tree.lua",
      cmd = { "NvimTreeToggle", "NvimTreeFocus" },
      config = require("plugins.configs.nvimtree"),
      cond = function()
         return vim.g.vscode == nil or vim.fn.file ~= 'help'
      end,
   },

   {
      "kylechui/nvim-surround",
      event = "VeryLazy",
      version = "*", -- Use for stability; omit to use `main` branch for the latest features
      config = function()
         require("nvim-surround").setup { mappings_style = "surround" }
      end
   },

   {
      -- easy-motion的替代
      'phaazon/hop.nvim',
      branch = 'v2', -- optional but strongly recommended
      config = function()
         require "hop".setup {
            keys = 'etovxqpdygfblzhckisuran'
         }
      end,
   },

   -- 格式化文本文件, 比如半角字符转换为全角字符,
   -- 英文和数字如果在中文之间使用前后插入空格
   {
      "hotoo/pangu.vim",
      ft = { "markdown", "md", "text" },
   },

   {
      'glacambre/firenvim',
      -- -- lazy load, if g:started_by_firenvim == v:true
      -- cond = function()
      --    return vim.fn.exists('g:started_by_firenvim') == 1
      -- end
      lazy = not vim.g.started_by_firenvim,
      config = function()
         require("plugins.configs.firenvim")
      end,
      build = function()
         vim.fn['firenvim#install'](0)
      end,
   },

   -- 中英文切换，normal模式自动切换到英文
   -- {
   --    'keaising/im-select.nvim',
   --    config = function()
   --       require("plugins.configs.others").im_select()
   --    end,
   -- },

   -- colorscheme
   {
      "folke/tokyonight.nvim",
      lazy = false,    -- make sure we load this during startup if it is your main colorscheme
      priority = 1000, -- make sure to load this before all the other start plugins
      config = function()
         -- set default theme
         -- storm, night, day
         vim.g.tokyonight_style = "night"
         vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal" }
         -- Change the "hint" color to the "orange" color, and make the "error" color bright red
         vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
         -- Load the colorscheme
         vim.cmd [[colorscheme tokyonight]]
      end,
   },
   -- https://github.com/shaunsingh/solarized.nvim
   { 'shaunsingh/solarized.nvim', lazy = true, cmd = { "Colorscheme" } },
   -- https://github.com/ellisonleao/gruvbox.nvim
   { 'ellisonleao/gruvbox.nvim',  lazy = true, cmd = { "Colorscheme" } },

   -- https://github.com/EdenEast/nightfox.nvim
   { 'EdenEast/nightfox.nvim',    lazy = true, cmd = { "Colorscheme" } },

   {
      -- "~/AppData/Local/nvim/extra/plugins/rgflow.nvim",
      dir = vim.fn.stdpath "config" .. "/extra/plugins/rgflow.nvim",
      lazy = false,
    
      cond = function()
         return vim.g.vscode == nil
      end,
      dependencies = { "nvim-lua/plenary.nvim",  "nvim-cmp" }
   },

   {
      dir = vim.fn.stdpath "config" .. "/extra/plugins/syntaxs.nvim",
      cond = function()
         return vim.g.vscode == nil
      end,
      ft = { "log", "txt", "markdown", "md", "qf", "text" }
   },

   {
      dir = vim.fn.stdpath "config" .. "/extra/plugins/log.nvim",
      cond = function()
         return vim.g.vscode == nil
      end,
      event = "VeryLazy",
   },
}

local lazy_config = require "plugins.configs.lazy_nvim"

require("lazy").setup(default_plugins, lazy_config)
