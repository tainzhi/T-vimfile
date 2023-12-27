-- All plugins have lazy=true by default,to load a plugin on startup just lazy=false
-- List of all default plugins & their definitions
local default_plugins = {
   { "nvim-lua/plenary.nvim" },


   {
      -- statusline
      'nvim-lualine/lualine.nvim',
      dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true },
      opts = function()
         return require("plugins.configs.lualine")
      end,
      config = function(_, opts)
         require("lualine").setup(opts)
      end
   },

   {
      "akinsho/bufferline.nvim",
      lazy = false,
      version = "*",
      dependencies = "kyazdani42/nvim-web-devicons",
      opts = function()
         return require("plugins.configs.bufferline")
      end,
      config = function(_, opts)
         require("bufferline").setup(opts)
      end,
      init = function()
         require("core.mappings").bufferline()
      end,
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

   -- {
   --    "NvChad/nvim-colorizer.lua",
   --    -- 使用了vscode-neovim作为vscode的插件，那么neovim作为其后端的时候，不加载一些插件
   --    cond = function()
   --       return vim.g.vscode == nil
   --    end,
   --    init = function()
   --       require("core.utils").lazy_load "nvim-colorizer.lua"
   --    end,
   --    config = function(_, opts)
   --       require("colorizer").setup(opts)

   --       -- execute colorizer as soon as possible
   --       vim.defer_fn(function()
   --          require("colorizer").attach_to_buffer(0)
   --       end, 0)
   --    end,
   -- },

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
      opts = function()
         return require("plugins.configs.others").gitsigns
      end,
      config = function(_, opts)
         require("gitsigns").setup(opts)
      end,
   },

   -- 参考：https://github.com/NvChad/NvChad/blob/c8777040fbda6a656f149877b796d120085cd918/lua/plugins/configs/lspconfig.lua
   -- -- lsp stuff
   -- {
   --    "neovim/nvim-lspconfig",
   --    ft = { "c", "c++", "lua", "sh", "java" },
   --    lazy = true,
   --    init = function()
   --       require("core.utils").lazy_load "nvim-lspconfig"
   --       -- reload the current file so lsp actually starts for it
   --       vim.defer_fn(function()
   --          vim.cmd 'if &ft ==  echo "" | else | silent! e %'
   --       end, 0)
   --    end,
   --    config = function()
   --       require("plugins.configs.lspconfig")
   --    end
   -- },

   {
      "williamboman/nvim-lsp-installer",
      ft = { "c", "c++", "lua", "sh", "java" },
   },
   {
      "ray-x/lsp_signature.nvim",
      dependencies = { "nvim-lspconfig" },
      config = function()
         require("plugins.configs.others").signature()
      end
   },

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
            opts = { history = true, updateevents = "TextChanged,TextChangedI" },
            config = function(_, opts)
               require("plugins.configs.luasnip").luasnip(opts)
            end,
         },

         -- autopairing of (){}[] etc
         {
            "windwp/nvim-autopairs",
            opts = {
               fast_wrap = {},
               disable_filetype = { "TelescopePrompt", "vim" },
            },
            config = function(_, opts)
               require("nvim-autopairs").setup(opts)

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
      opts = function()
         return require "plugins.configs.cmp"
      end,
      config = function(_, opts)
         require("cmp").setup(opts)
      end,
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
      init = function()
         require("core.mappings").comment()
      end,
   },

   -- file managing , picker etc
   {
      "kyazdani42/nvim-tree.lua",
      cmd = { "NvimTreeToggle", "NvimTreeFocus" },
      init = function()
         require("core.mappings").nvimtree()
      end,
      opts = function()
         return require("plugins.configs.nvimtree")
      end,
      config = function(_, opts)
         require("nvim-tree").setup(opts)
      end,
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
      --       setup = function()
      --          require("core.mappings").telescope_media()
      --       end,
      --    },
      -- },
      config = function()
         require("plugins.configs.telescope")
      end,
      init = function()
         require("core.mappings").telescope()
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
      "ms-jpq/chadtree",
      branch = "chad",
      cond = function()
         return vim.g.vscode == nil
      end,
      build = "python -m chadtree deps",
      cmd = { "CHADopen", "CHADdeps" },
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

   {
      'keaising/im-select.nvim',
      config = function()
         require("plugins.configs.others").im_select()
      end,
   },

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
   -- -- https://github.com/shaunsingh/solarized.nvim
   -- { 'shaunsingh/solarized.nvim' , lazy=true},
   -- -- https://github.com/ellisonleao/gruvbox.nvim
   -- { 'ellisonleao/gruvbox.nvim', lazy=true},
   -- -- https://github.com/EdenEast/nightfox.nvim
   -- { 'EdenEast/nightfox.nvim' ,lazy=true},

   {
      "dstein64/vim-startuptime",
      cmd = { "StartupTime" }
   },

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
      lazy = false,
      -- "~/AppData/Local/nvim/extra/plugins/log.vim",
      cond = function()
         return vim.g.vscode == nil
      end,
      ft = { "log", "txt", "text" }
   },
}

local lazy_config = require "plugins.configs.lazy_nvim"

require("lazy").setup(default_plugins, lazy_config)
