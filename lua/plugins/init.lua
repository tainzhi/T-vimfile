local present, packer = pcall(require, "plugins.packerInit")

if not present then
   return false
end

local use = packer.use

return packer.startup(function()
   -- this is arranged on the basis of when a plugin starts
   use "nvim-lua/plenary.nvim"

   use {
      "wbthomason/packer.nvim",
      event = "VimEnter",
   }

   use {
      "kyazdani42/nvim-web-devicons",
      module = "nvim-web-devicons",
   }

   use {
      'nvim-lualine/lualine.nvim',
      after = "nvim-web-devicons",
      requires = { 'kyazdani42/nvim-web-devicons', opt = true },
      config = function()
         require("plugins.configs.lualine")
      end
   }

   use {
      "akinsho/bufferline.nvim",
      after = "nvim-web-devicons",
      config =  function() 
         require("plugins.configs.bufferline")
      end,
      setup = function()
         require("core.mappings").bufferline()
      end,
   }

   use {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufRead",
      config = function ()
         require("plugins.configs.others").blankline()
      end
   }

   use {
      "norcalli/nvim-colorizer.lua",
      event = "BufRead",
      config = function()
         require("plugins.configs.others").colorizer()
      end
   }

   use {
      "nvim-treesitter/nvim-treesitter",
      event = "BufRead",
      config = function()
         require("plugins.configs.treesitter")
      end
   }

   -- git stuff
   use {
      "lewis6991/gitsigns.nvim",
      opt = true,
      config = function()
         require("plugins.configs.gitsigns")
      end,
      setup = function()
         require("core.utils").packer_lazy_load "gitsigns.nvim"
      end,
   }

   -- lsp stuff
   use {
      "neovim/nvim-lspconfig",
      opt = true,
      setup = function()
         require("core.utils").packer_lazy_load "nvim-lspconfig"
         -- reload the current file so lsp actually starts for it
         vim.defer_fn(function()
            vim.cmd 'if &ft == "packer" | echo "" | else | silent! e %'
         end, 0)
      end,
      config = function()
         require("plugins.configs.lspconfig")
      end
   }

   use {
      "williamboman/nvim-lsp-installer"
   }
   use {
      "ray-x/lsp_signature.nvim",
      after = "nvim-lspconfig",
      config = function()
         require("plugins.configs.others").signature()
      end
   }

   use {
      "andymass/vim-matchup",
      opt = true,
      setup = function()
         require("core.utils").packer_lazy_load "vim-matchup"
      end,
   }

   use {
      "max397574/better-escape.nvim",
      event = "InsertEnter",
      config = function()
         require("plugins.configs.others").better_escape()
      end
   }

   -- load luasnips + cmp related in insert mode only
   use {
      "rafamadriz/friendly-snippets",
      event = "InsertEnter",
   }

   use {
      "hrsh7th/nvim-cmp",
      after = "friendly-snippets",
      config = function()
         require("plugins.configs.cmp")
      end
   }

   use {
      "L3MON4D3/LuaSnip",
      wants = "friendly-snippets",
      after = "nvim-cmp",
      config = function()
         require("plugins.configs.luasnip")
      end
   }

   use {
      "saadparwaiz1/cmp_luasnip",
      after = "LuaSnip",
   }

   use {
      "hrsh7th/cmp-nvim-lua",
      after = "cmp_luasnip",
   }

   use {
      "hrsh7th/cmp-nvim-lsp",
      after = "cmp-nvim-lua",
   }

   use {
      "hrsh7th/cmp-buffer",
      after = "cmp-nvim-lsp",
   }

   use {
      "hrsh7th/cmp-path",
      after = "cmp-buffer",
   }

   use {
      "dmitmel/cmp-cmdline-history",
      after = "cmp-buffer",
   }

   -- misc plugins
   use {
      "windwp/nvim-autopairs",
      after = "nvim-cmp",
      config = function()
         require("plugins.configs.others").autopairs()
      end
   }

   use {
      "terrortylor/nvim-comment",
      cmd = "CommentToggle",
      config = function()
         require("plugins.configs.others").comment()
      end,
      setup = function()
         require("core.mappings").comment()
      end,
   }

   -- file managing , picker etc
   use {
      "kyazdani42/nvim-tree.lua",
      cmd = { "NvimTreeToggle", "NvimTreeFocus" },
      config = function()
         require("plugins.configs.nvimtree")
      end,
      setup = function()
         require("core.mappings").nvimtree()
      end,
   }

   use {
      "nvim-telescope/telescope.nvim",
      module = "telescope",
      cmd = "Telescope",
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
      setup = function()
         require("core.mappings").telescope()
      end,
   }

   use {
      "kylechui/nvim-surround",
      event = "InsertEnter",
      config = function()
         require"nvim-surround".setup {mappings_style = "surround"}
      end
   }

   use {
      "ms-jpq/chadtree",
      branch = "chad",
      run = "python -m chadtree deps",
      cmd = { "CHADopen", "CHADdeps" },
   }

   use {
      'phaazon/hop.nvim',
      branch = 'v1', -- optional but strongly recommended
      config = function()
         require("plugins.configs.hop")
      end
   }

   use {
      "dstein64/vim-startuptime",
      cmd = { "StartupTime"}
   }

   use {
      "hotoo/pangu.vim",
      ft = {"markdown", "md", "text"},
   }

   use {
      "~/AppData/Local/nvim/extra/plugins/rgflow.nvim",
      ft = {"log", "txt"},
      requires = {
         {
            "MunifTanjim/nui.nvim",
         }
      }
   }
   use "~/AppData/Local/nvim/extra/plugins/syntaxs.nvim"
   use {
      "~/AppData/Local/nvim/extra/plugins/log.vim",
      ft = {"log", "txt"}
   }

   -- colorscheme
   use 'folke/tokyonight.nvim'
   -- https://github.com/shaunsingh/solarized.nvim
   use 'shaunsingh/solarized.nvim'
   -- https://github.com/ellisonleao/gruvbox.nvim
   use 'ellisonleao/gruvbox.nvim'
   -- https://github.com/EdenEast/nightfox.nvim
   use 'EdenEast/nightfox.nvim'
end)
