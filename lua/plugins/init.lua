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
      config = function()
         require("plugins.configs.treesitter")
      end
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

   -- references: https://github.com/AstroNvim/AstroNvim
   -- {
   --    "williamboman/mason.nvim",
   --    cmd = {
   --       "Mason",
   --       "MasonInstall",
   --       "MasonUninstall",
   --       "MasonUninstallAll",
   --       "MasonLog",
   --       "MasonUpdate",
   --       "MasonUpdateAll",
   --    },
   --    opts = {
   --       ui = {
   --          icons = {
   --             package_installed = "✓",
   --             package_uninstalled = "✗",
   --             package_pending = "⟳",
   --          },
   --       },
   --    },
   --    build = ":MasonUpdate",
   --    -- config = require "plugins.configs.mason",
   -- },
   -- {
   --    "neovim/nvim-lspconfig",
   --    lazy = false,
   --    dependencies = {
   --       {
   --          "williamboman/mason-lspconfig.nvim",
   --          cmd = { "LspInstall", "LspUninstall" },
   --          opts = {
   --             ensure_installed = { "lua_ls" }
   --          },
   --          config = function(_, opts)
   --             require("mason-lspconfig").setup(opts)
   --          end,
   --       },
   --    },
   --    config =  require "plugins.configs.lspconfig",
   -- },
   -- {
   --    "jose-elias-alvarez/null-ls.nvim",
   --    dependencies = {
   --       {
   --          "jay-babu/mason-null-ls.nvim",
   --          cmd = { "NullLsInstall", "NullLsUninstall" },
   --          opts = { handlers = {} },
   --       },
   --    },
   -- },
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
      "andymass/vim-matchup",
      lazy = true,
      init = function()
         require("core.utils").lazy_load "vim-matchup"
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
         },
      },
      config = require "plugins.configs.cmp",
   },

   -- misc plugins
   {
      "windwp/nvim-autopairs",
      dependencies = { "nvim-cmp" },
      config = function()
         require("plugins.configs.others").autopairs()
      end
   },

   {
      "terrortylor/nvim-comment",
      cmd = "CommentToggle",
      config = function()
         require("plugins.configs.others").comment()
      end,
   },

   -- file managing , picker etc
   {
      "kyazdani42/nvim-tree.lua",
      cmd = { "NvimTreeToggle", "NvimTreeFocus" },
      config = require("plugins.configs.nvimtree"),
      cond = function()
         return vim.g.vscode == nil
      end,
   },

   {
      "nvim-telescope/telescope.nvim",
      module = "telescope",
      cmd = "Telescope",
      cond = function()
         return vim.g.vscode == nil
      end,
      -- requires = {
      --    {
      --       "nvim-telescope/telescope-fzf-native.nvim",
      --       run = "make",
      --    },
      --    {
      --       "nvim-telescope/telescope-media-files.nvim",
      --    },
      -- },
      config = function()
         require("plugins.configs.telescope")
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
      config = function() require("plugins.configs.hop") end
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
      dir = vim.fn.stdpath "config" .. "/extra/plugins/rgflow.nvim",
      lazy = false,
      -- "~/AppData/Local/nvim/extra/plugins/rgflow.nvim",
      cond = function()
         return vim.g.vscode == nil
      end,
      dependencies = { "MunifTanjim/nui.nvim", }
   },

   {
      dir = vim.fn.stdpath "config" .. "/extra/plugins/syntaxs.nvim",
      -- "~/AppData/Local/nvim/extra/plugins/syntaxs.nvim",
      cond = function()
         return vim.g.vscode == nil
      end,
      ft = { "log", "txt", "markdown", "md", "qf", "text" }
   },

   {
      dir = vim.fn.stdpath "config" .. "/extra/plugins/log.nvim",
      -- "~/AppData/Local/nvim/extra/plugins/log.vim",
      cond = function()
         return vim.g.vscode == nil
      end,
      ft = { "log", "txt", "markdown", "md", "qf", "text" }
   },
}

local lazy_config = require "plugins.configs.lazy_nvim"

require("lazy").setup(default_plugins, lazy_config)
