--[[
=====================================================================
==================== Neovim Config               ====================
=====================================================================
--]]



--[[
=====================================================================
==================== Options                      ===================
=====================================================================
--]]

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.autowrite = true          -- Enable auto write
vim.opt.clipboard = "unnamedplus" -- Sync with system clipboard
vim.opt.cmdheight = 1
vim.opt.completeopt = "menu,menuone,noselect,preview"
vim.opt.conceallevel = 3           -- Hide * markup for bold and italic
vim.opt.confirm = true             -- Confirm to save changes before exiting modified buffer
vim.opt.cursorline = true          -- Enable highlighting of the current line
vim.opt.expandtab = true           -- Use spaces instead of tabs
vim.opt.formatoptions = "jcroqlnt" -- tcqj
vim.opt.grepformat = "%f:%l:%c:%m"
vim.opt.grepprg = "rg --vimgrep"
vim.opt.ignorecase = true      -- Ignore case
vim.opt.inccommand = "nosplit" -- preview incremental substitute
vim.opt.laststatus = 3         -- when to display a status line
vim.opt.list = true            -- Show some invisible characters (tabs...
vim.opt.mouse = "a"            -- Enable mouse mode
vim.opt.number = true          -- Print line number
vim.opt.pumblend = 20          -- Popup blend
vim.opt.pumheight = 15         -- Maximum number of entries in a popup
vim.opt.relativenumber = false -- Relative line numbers
vim.opt.scrolloff = 4          -- Lines of context
vim.opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize" }
vim.opt.shiftround = true      -- Round indent
vim.opt.shiftwidth = 0         -- Size of an indent
vim.opt.shortmess:append({ W = true, I = true, c = true })
vim.opt.showmode = false       -- Dont show mode since we have a statusline
vim.opt.sidescrolloff = 8      -- Columns of context
vim.opt.signcolumn = "yes"     -- Always show the signcolumn, otherwise it would shift the text each time
vim.opt.smartcase = true       -- Don't ignore case with capitals
vim.opt.smartindent = true     -- Insert indents automatically
-- vim.opt.spelllang = { "en" }
vim.opt.splitbelow = true      -- Put new windows below current
vim.opt.splitright = true      -- Put new windows right of current
vim.opt.tabstop = 2            -- Number of spaces tabs count for
vim.opt.termguicolors = true   -- True color support
vim.opt.timeoutlen = 500
vim.opt.undofile = true
vim.opt.undolevels = 10000
vim.opt.updatetime = 5000              -- Save swap file and trigger CursorHold
vim.opt.wildmode = "longest:full,full" -- Command-line completion mode
vim.opt.winminwidth = 1                -- Minimum window width
vim.opt.wrap = false                   -- Disable line wrap
vim.opt.colorcolumn = "80,100"





-- -- using powershell as interteral
-- vim.opt.shell = "pwsh"
-- vim.opt.shellcmdflag = "-nologo -noprofile -ExecutionPolicy RemoteSigned -command"
-- vim.opt.shellxquote = ""
--
if vim.fn.has("nvim-0.9.0") == 1 then
  vim.opt.splitkeep = "screen"
  vim.opt.shortmess:append({ C = true })
end
--
-- -- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
vim.lsp.inlay_hint = true
--
vim.opt.foldmethod = "indent"
vim.opt.foldlevel = 99
--
-- -- Enable break indent
vim.o.breakindent = true

vim.opt.showcmd = false

--[[
=====================================================================
==================== Setup Lazy                  ====================
=====================================================================
--]]

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

--[[
=====================================================================
==================== Helper Functions            ====================
=====================================================================
--]]

local function show_macro_recording()
  local recording_register = vim.fn.reg_recording()
  if recording_register == "" then
    return ""
  else
    return "Recording @" .. recording_register
  end
end

--[[
=====================================================================
==================== Plugins                     ====================
=====================================================================
--]]

local P = {

  -- Git related plugins
  'tpope/vim-fugitive',
  'tpope/vim-rhubarb',

  -- Detect tabstop and shiftwidth automatically
  'tpope/vim-sleuth',

  {
    -- Witch-Key
    'folke/which-key.nvim',
    opts = {}
  },

  {
    -- Theme inspired by Atom
    "olimorris/onedarkpro.nvim",
    -- 'navarasu/onedark.nvim',
    -- opts = {
    --   options = {
    --     cursorline = true,
    --     transparency = true,
    --   },
    -- },
    priority = 1000,
    config = function()
      require("onedarkpro").setup({
        options = {
          cursorline = true,
          transparency = true,
        }
      })
      vim.cmd.colorscheme 'onedark'
    end,
  },

  {
    "folke/tokyonight.nvim",
  },


  {
    -- Telescope
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      "debugloop/telescope-undo.nvim",
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        'nvim-telescope/telescope-fzf-native.nvim',
        -- If you are having trouble with this installation,
        --   refer to the README for telescope-fzf-native for more instructions.
        build = 'make',
        cond = function()
          return vim.fn.executable 'make' == 1
        end,
      },
    },
  },

  {
    -- Treesitter Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
  },

  {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',


      -- Additional lua configuration, makes nvim stuff amazing!
      'folke/neodev.nvim',
    },

  },

  --Useful status updates for LSP
  --  `opts = {}` is the same as calling `require('fidget').setup({})`

  {
    'j-hui/fidget.nvim', --[[ tag = 'legacy' ,]]
    opts = {},
    init = function()
      vim.notify = require(
        "fidget.notification").notify
    end,
  },


  {
    -- Autocompletion
    'hrsh7th/nvim-cmp',
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',

      -- Adds LSP completion capabilities
      'hrsh7th/cmp-nvim-lsp',

      -- Adds a number of user-friendly snippets
      'rafamadriz/friendly-snippets',
    },
  },


  {
    -- Gitsigns Adds git related signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
    opts = {
      -- See `:help gitsigns.txt`
      signs = {
        add = { text = '┼' }, -- add = { text = '+' },
        change = { text = '┆' }, -- change = { text = '~' },
        delete = { text = '─' }, -- delete = { text = '_' },
        topdelete = { text = '┯' }, --  topdelete = { text = '‾' },
        changedelete = { text = '╪' }, -- ~ changedelete = { text = '~' },
        untracked = { text = "" },
        -- ┼ ├ ┬ ╤ ┯ ╪ ╂ ─
        -- ╪ ┼ ├ ┤   󰍵   □ ○
      },
      on_attach = function(bufnr)
        vim.keymap.set('n', '<leader>gp', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })
        vim.keymap.set('n', '<leader>lg', require('gitsigns').setloclist, { buffer = bufnr, desc = 'Gitsigns list' })
        vim.keymap.set('n', '<leader>gv', require('gitsigns').show, { buffer = bufnr, desc = 'show Git Verion' })
        vim.keymap.set('n', '<leader>gd', require('gitsigns').diffthis, { buffer = bufnr, desc = 'Diff This' })
        vim.keymap.set('n', '<leader>gb', require('gitsigns').blame_line, { buffer = bufnr, desc = 'Blame Line' })
        vim.keymap.set('n', '<leader>gh', require('gitsigns').select_hunk, { buffer = bufnr, desc = 'Hunk Select' })
        vim.keymap.set('n', '<leader>gk', require('gitsigns').prev_hunk, { buffer = bufnr, desc = 'Previous Hunk' })
        vim.keymap.set('n', '<leader>gj', require('gitsigns').next_hunk, { buffer = bufnr, desc = 'Next Hunk' })

        vim.keymap.set('n', '<leader>gs', require('gitsigns').stage_hunk, { buffer = bufnr, desc = 'Stage Hunk' })
        vim.keymap.set('n', '<leader>gr', require('gitsigns').reset_hunk, { buffer = bufnr, desc = 'Reset Stage Hunk' })
        vim.keymap.set('n', '<leader>gu', require('gitsigns').undo_stage_hunk,
          { buffer = bufnr, desc = 'Undo lasst Stage Hunk' })

        vim.keymap.set('n', '<leader>gS', require('gitsigns').stage_buffer,
          { buffer = bufnr, desc = 'Stage complete Buffer' })
        vim.keymap.set('n', '<leader>gR', require('gitsigns').reset_buffer,
          { buffer = bufnr, desc = 'Reset complete Buffer' })

        vim.keymap.set('n', '<leader>gtd', require('gitsigns').toggle_deleted,
          { buffer = bufnr, desc = 'Toggle Deleted' })
        vim.keymap.set('n', '<leader>gtb', require('gitsigns').toggle_current_line_blame,
          { buffer = bufnr, desc = 'Toggle Line Blame' })
        vim.keymap.set('n', '<leader>gtw', require('gitsigns').toggle_word_diff,
          { buffer = bufnr, desc = 'Toggle Word Diff' })
        vim.keymap.set('n', '<leader>gts', require('gitsigns').toggle_signs, { buffer = bufnr, desc = 'Toggle Signs' })


        -- don't override the built-in and fugitive keymaps
        local gs = package.loaded.gitsigns
        vim.keymap.set({ 'n', 'v' }, ']c', function()
          if vim.wo.diff then
            return ']c'
          end
          vim.schedule(function()
            gs.next_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to next hunk' })
        vim.keymap.set({ 'n', 'v' }, '[c', function()
          if vim.wo.diff then
            return '[c'
          end
          vim.schedule(function()
            gs.prev_hunk()
          end)
          return '<Ignore>'
        end, { expr = true, buffer = bufnr, desc = 'Jump to previous hunk' })
      end,
    },
  },

  {
    -- Lualine as statusline
    'nvim-lualine/lualine.nvim',
    -- See `:help lualine.txt`
    opts = {
      options = {
        icons_enabled = true,
        theme = 'auto',
        -- section_separators = { left = '', right = ''},
        -- component_separators = { left = '', right = ''},
        -- section_separators = { left = '', right = '' },
        -- component_separators = { left = '', right = '' }
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
        -- section_separators = { left = '▙', right = '▟'},
        -- component_separators = { left = '▚', right = '▞'},
        -- ░ ▒ ▓ ╲ ╱                      ▙ ▚ ▞ ▟
      },
      sections = {
        lualine_a = { { 'mode', icons_enabled = true } },
        lualine_b = {
          { 'macro_recording', fmt = show_macro_recording, },

          'branch',
          'diff',
          {
            'diagnostics',
            symbols = {
              error = " ",
              warn = " ",
              info = " ",
              hint = " ",
            },
          },
        },
        lualine_c = {
          'selectioncount',
          'searchcount',
          {
            'buffers',
            mode = 2,
            use_mode_colors = true,
            buffers_color = {
              active = { gui = 'bold,italic', fg = 'black', bg = 'grey' },
            },


          }
          --[['selectioncount','searchcount','filetype',--]]
        },
        lualine_x = { --[[ 'encoding', 'fileformat','buffers','tabs','filename', 'filesize'--]] },
        lualine_y = { 'encoding', 'fileformat', 'filesize' --[[ 'progress', 'location', ]] },
        lualine_z = { 'progress', 'location', --[[ function() return " " .. os.date("%R") end, ]] }
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'buffers' },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {}
      },
    },
  },


  {
    -- Add indentation guides even on blank lines
    'lukas-reineke/indent-blankline.nvim',
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = 'ibl',
    opts = {},
  },

  -- "gc" to comment visual regions/lines
  { 'numToStr/Comment.nvim', opts = {} },

  { --nvim autopairs
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

  { -- nvim scrollbar
    "petertriho/nvim-scrollbar",
    opts = {
      handle = {
        text = "   ",
      },
      marks = {
        Cursor = {
          text = "<--",
        },
        Search = {
          text = { " - ", " = " }
        },
        Hint = {
          text = { "- ", "= " }
          --
        },
        Error = {
          text = { "- ", "= " }
          --
        },
        Warn = {
          text = { "- ", "= " }
          -- 
        },
        Info = {
          text = { "- ", "= " }
          -- 
        },
        Misc = {
          text = { "- ", "= " }
          --
        },
        GitAdd = {
          text = { "- ", "= " }
        },
        GitChange = {
          text = { "- ", "= " }
        },
        GitDelete = {
          text = { "-󰍵 ", "=󰍵 " }
        },
        -- ╪┼├ ┤󰍵
      },
    },
    -- handlers = {
    --   gitsigns = true, -- Requires gitsigns
    --   -- search = true, -- requires hlslens
    -- },
    config = function(_, opts)
      require("scrollbar").setup(opts)
    end
  },

  {                -- nvim-surround
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup()
    end
  },

  { -- zen mode
    "folke/zen-mode.nvim",
    -- event = "VeryLazy",
    opts = {
      window = {
        backdrop = 0.8, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        -- * a function that returns the width or the height
        width = 110,  -- width of the Zen window
        height = 1.0, -- height of the Zen window
        -- by default, no options are changed for the Zen window
        -- uncomment any of the options below, or add other vim.wo options you want to apply
        options = {
          -- signcolumn = "no", -- disable signcolumn
          -- number = true, -- disable number column
          -- relativenumber = false, -- disable relative numbers
          -- cursorline = false, -- disable cursorline
          -- cursorcolumn = false, -- disable cursor column
          -- foldcolumn = "0", -- disable fold column
          -- list = false, -- disable whitespace characters
          -- callback where you can add custom code when the Zen window opens
          -- or leave it empty to use the default settings
          -- refer to the configuration section below
        }
      },
      -- plugins = {
      --   -- disable some global vim options (vim.o...)
      --   -- comment the lines to not apply the options
      --   options = {
      --     enabled = true,
      --     -- ruler = true, -- disables the ruler text in the cmd line area
      --     -- showcmd = true, -- disables the command in the last line of the screen
      --   },
      -- },
    },
  },


  { -- nvterm
    "NvChad/nvterm",
    config = function()
      require("nvterm").setup({
        terminals = {
          shell = vim.o.shell,
          list = {},
          type_opts = {
            float = {
              relative = "editor",
              row = 0.25,
              col = 0.25,
              width = 0.5,
              height = 0.4,
              border = "single",
            },
            horizontal = { location = "rightbelow", split_ratio = 0.3, },
            vertical = { location = "rightbelow", split_ratio = 0.5 },
          }
        },
        behavior = {
          autoclose_on_quit = {
            enabled = false,
            confirm = true,
          },
          close_on_exit = true,
          auto_insert = true,
        },
      })
    end,
  },

  { -- vim repeat (better dot operator)
    "tpope/vim-repeat",
    event = "VeryLazy"
  },

  { -- vim iluminate ( highlight current word)
    "RRethy/vim-illuminate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      delay = 200,
      large_file_cutoff = 2000,
      large_file_overrides = {
        providers = {
          "lsp",
          "treesitter",
          "regex"
        },
      },
    },
    config = function(_, opts)
      require("illuminate").configure(opts)
    end,
  },


  { -- todo comments
    "folke/todo-comments.nvim",
    opts = {
      highlight = {
        keyword = "bg",
      },
    },
    -- dependencies = { "nvim-lua/plenary.nvim" },
    -- event = { "BufReadPost", "BufNewFile" },
  },
  {
    'folke/trouble.nvim',
    opts = {},

  },





  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      prompt = {
        enabled = true,
        win_config = {
          -- relative = "editor",
          width = 1,
          height = 1,
          row = -3,
          col = 0,
        }
      }
    },
  },

  {
    "simrat39/symbols-outline.nvim",
    opts = {},
  },

  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      { "MunifTanjim/nui.nvim",  lazy = true },
      { "nvim-lua/plenary.nvim", lazy = true },
    },
    opts = {
      window = {
        mappings = {
          ["<space>"] = {
            "toggle_node",
            nowait = true,
          },
        },
      },
    },

  },

  -- {
  --   "folke/noice.nvim",
  --   event = "VeryLazy",
  --   opts = {
  --     cmdline = {
  --       enabled = false,
  --       view = "cmdline",
  --     },
  --     messages = {
  --       enabled = false,
  --     },
  --     popupmenu = {
  --       enabled = false,
  --     },
  --     dependencies = {
  --       "munifTanjim/nui.nvim",
  --     }
  --   }
  -- },
}

--[[
=====================================================================
==================== Load Plugins                 ===================
=====================================================================
--]]

require('lazy').setup(P, {})


--[[
=====================================================================
==================== Basic Keymaps                ===================
=====================================================================
--]]

-- Keymaps for better default experience
-- See `:help vim.keymap.set()`
vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
-- vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
-- ist jetzt shift j !
vim.keymap.set('n', '<leader>ld', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })




-- resize window with arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- move lines with alt
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- bufferline ? together to bufferline keys ?
-- vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
-- vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
-- vim.keymap.set("n", "[b", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
-- vim.keymap.set("n", "]b", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })

--no bufferline
vim.keymap.set("n", "<leader>bn", "<cmd>enew<cr>", { desc = "New buffer" })
vim.keymap.set("n", "<leader>bh", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<leader>bl", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bc", "<cmd>bdelete<cr>", { desc = "Close buffer" })

vim.keymap.set("n", "<leader>b1", "<cmd>LualineBuffersJump! 1<cr>", { desc = "Jump to Buffer 1" })
vim.keymap.set("n", "<leader>b2", "<cmd>LualineBuffersJump! 2<cr>", { desc = "Jump to Buffer 2" })
vim.keymap.set("n", "<leader>b3", "<cmd>LualineBuffersJump! 3<cr>", { desc = "Jump to Buffer 3" })
vim.keymap.set("n", "<leader>b4", "<cmd>LualineBuffersJump! 4<cr>", { desc = "Jump to Buffer 4" })
vim.keymap.set("n", "<leader>b5", "<cmd>LualineBuffersJump! 5<cr>", { desc = "Jump to Buffer 5" })
vim.keymap.set("n", "<leader>b6", "<cmd>LualineBuffersJump! 6<cr>", { desc = "Jump to Buffer 6" })
vim.keymap.set("n", "<leader>b7", "<cmd>LualineBuffersJump! 7<cr>", { desc = "Jump to Buffer 7" })
vim.keymap.set("n", "<leader>b8", "<cmd>LualineBuffersJump! 8<cr>", { desc = "Jump to Buffer 8" })
vim.keymap.set("n", "<leader>b9", "<cmd>LualineBuffersJump! 9<cr>", { desc = "Jump to Buffer 9" })

-- better escape
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- clear serch and stuff
vim.keymap.set("n", "<leader>ur", "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / clear hlsearch / diff update" })

-- search word
vim.keymap.set({ "n", "x" }, "gw", "*N", { desc = "Search word under cursor" })

-- better n function at search
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- undo breackpoints
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- save file
-- vim.keymap.set({ "i", "v", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
vim.keymap.set({ 'n', }, "<leader>uf", "<cmd>w<cr><esc>", { desc = "Save file" })

-- better indent
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

vim.keymap.set("n", "<S-z>",
  function()
    if vim.opt.scrolloff:get() ~= 4
    then
      vim.opt.scrolloff = 4
    else
      vim.fn.feedkeys('M')
      vim.opt.scrolloff = 99
    end
  end, { desc = "Toogle scrolloff" }
)

-- terminal
vim.keymap.set("t", "<esc><esc>", "<C-\\><C-N>", { desc = "escape terminal" })


-- windows
vim.keymap.set("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
vim.keymap.set("n", "<leader>wc", "<C-W>c", { desc = "Close window", remap = true })
vim.keymap.set("n", "<leader>ws", "<C-W>s", { desc = "Split window below", remap = true })
vim.keymap.set("n", "<leader>wv", "<C-W>v", { desc = "Split window right", remap = true })
vim.keymap.set("n", "<leader>wo", "<C-W>o", { desc = "Close other windows", remap = true })
-- select window
vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Go to right window", remap = true })

-- tab handling
vim.keymap.set("n", "<leader><tab>j", "<cmd>tablast<cr>", { desc = "Last Tab" })
vim.keymap.set("n", "<leader><tab>k", "<cmd>tabfirst<cr>", { desc = "First Tab" })
vim.keymap.set("n", "<leader><tab>n", "<cmd>tabnew<cr>", { desc = "New Tab" })
vim.keymap.set("n", "<leader><tab>h", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "<leader><tab>c", "<cmd>tabclose<cr>", { desc = "Close Tab" })
vim.keymap.set("n", "<leader><tab>l", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

--[[
=====================================================================
==================== Plugin Configs              ====================
=====================================================================
--]]
--


-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native, if installed
pcall(require('telescope').load_extension, 'fzf')

-- Telescope live_grep in git root
-- Function to find the git root directory based on the current buffer's path
local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == "" then
    current_dir = cwd
  else
    -- Extract the directory from the current file's path
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

  -- Find the Git root directory from the current file's path
  -- NOTE: hab das or ""  bei current_dir eingefügt !
  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir or "", " ") .. " rev-parse --show-toplevel")
      [1]
  if vim.v.shell_error ~= 0 then
    print("Not a git repository. Searching on current working directory")
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require('telescope.builtin').live_grep({
      search_dirs = { git_root },
    })
  end
end

vim.api.nvim_create_user_command('LiveGrepGitRoot', live_grep_git_root, {})

-- See `:help telescope.builtin`
vim.keymap.set('n', '<leader>?', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader><space>', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = true,
    width = 1,
    height = 1,


  })
end, { desc = '[/] Fuzzily search in current buffer' })
--new
vim.keymap.set('n', '<leader>:', require('telescope.builtin').command_history, { desc = '[:] Find Command History' })


vim.keymap.set('n', '<leader>Gf', require('telescope.builtin').git_files, { desc = 'Search Git Files' })
vim.keymap.set('n', '<leader>Gs', require('telescope.builtin').git_status, { desc = 'Search Git Status' })
vim.keymap.set('n', '<leader>Gc', require('telescope.builtin').git_commits, { desc = 'Search Git Commits' })
vim.keymap.set('n', '<leader>Gb', require('telescope.builtin').git_branches, { desc = 'Search Git Branches' })
vim.keymap.set('n', '<leader>Gz', require('telescope.builtin').git_stash, { desc = 'Search Git Stash' })
vim.keymap.set('n', '<leader>Gl', require('telescope.builtin').git_bcommits, { desc = 'Search Git branch Commits' })
vim.keymap.set('n', '<leader>GG', '<cmd>Git<CR>', { desc = 'Git Fugitive' })


vim.keymap.set('n', '<leader>sf', require('telescope.builtin').find_files, { desc = 'Search Files' })
vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = 'Search Help' })
vim.keymap.set('n', '<leader>sw', require('telescope.builtin').grep_string, { desc = 'Search current Word' })
vim.keymap.set('n', '<leader>sg', require('telescope.builtin').live_grep, { desc = 'Search by Grep' })
vim.keymap.set('n', '<leader>sG', ':LiveGrepGitRoot<cr>', { desc = 'Search by Grep on Git Root' })
vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = 'Search Diagnostics' })
vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = 'Search Resume' })

-- new
vim.keymap.set('n', '<leader>so', require('telescope.builtin').oldfiles, { desc = "Oldfiles" })
vim.keymap.set('n', '<leader>s"', require('telescope.builtin').registers, { desc = "Registers" })
vim.keymap.set('n', '<leader>sA', require('telescope.builtin').autocommands, { desc = "Autocommands" })
vim.keymap.set('n', '<leader>sH', require('telescope.builtin').highlights, { desc = "Highlights" })
vim.keymap.set('n', '<leader>sK', require('telescope.builtin').keymaps, { desc = "Keymaps" })
vim.keymap.set('n', '<leader>sm', require('telescope.builtin').marks, { desc = "Marks" })
vim.keymap.set('n', '<leader>sO', require('telescope.builtin').vim_options, { desc = "Vim Options" })
vim.keymap.set('n', '<leader>sC', function() require('telescope.builtin').colorscheme({ enable_preview = true }) end,
  { desc = 'Colorschemes' })
vim.keymap.set('n', '<leader>su', function() require('telescope').extensions.undo.undo({ side_by_side = true }) end,
  { desc = 'Undo History' })

vim.keymap.set('n', '<leader>st', '<cmd>TodoTelescope<CR>', { desc = "Search TodoList" })

vim.keymap.set('n', '<leader>lt', '<cmd>TodoLocList<CR>', { desc = "Todo Location List" })







-- [[ Configure Treesitter ]]
-- See `:help nvim-treesitter`
-- Defer Treesitter setup after first render to improve startup time of 'nvim {filename}'
vim.defer_fn(function()
  require('nvim-treesitter.configs').setup {
    -- Add languages to be installed here that you want installed for treesitter
    -- NOTE: hab die felder modules, sync_install, ignore_install hinzugefügt !!
    modules = {},
    sync_install = true,
    ignore_install = {},
    ensure_installed = { 'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash' },

    -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
    auto_install = false,

    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = '<c-s>',
        node_incremental = '<c-a>',
        scope_incremental = '<c-s>',
        node_decremental = '<m-a>',
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['ac'] = '@class.outer',
          ['ic'] = '@class.inner',
        },
      },
      --NOTE: changed [] to öä
      move = {
        enable = true,
        set_jumps = true, -- whether to set jumps in the jumplist
        goto_next_start = {
          ['äm'] = '@function.outer',
          ['ää'] = '@class.outer',
        },
        goto_next_end = {
          ['äM'] = '@function.outer',
          ['äö'] = '@class.outer',
        },
        goto_previous_start = {
          ['öm'] = '@function.outer',
          ['öö'] = '@class.outer',
        },
        goto_previous_end = {
          ['öM'] = '@function.outer',
          ['öä'] = '@class.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<leader>cs'] = '@parameter.inner',
        },
        swap_previous = {
          ['<leader>cS'] = '@parameter.inner',
        },
      },
    },
  }
end, 0)

-- [[ Configure LSP ]]
--  This function gets run when an LSP connects to a particular buffer.
local on_attach = function(_, bufnr)
  -- NOTE: Remember that lua is a real programming language, and as such it is possible
  -- to define small helper and utility functions so you don't have to repeat yourself
  -- many times.
  --
  -- In this case, we create a function that lets us more easily define mappings specific
  -- for LSP related items. It sets the mode, buffer and description for us each time.
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end

    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>cr', vim.lsp.buf.rename, 'rename item')
  nmap('<leader>ca', vim.lsp.buf.code_action, 'code actions')
  nmap('<leader>cf', vim.lsp.buf.format, 'format code')

  nmap('gd', require('telescope.builtin').lsp_definitions, 'Goto Definition')
  nmap('gr', require('telescope.builtin').lsp_references, 'Goto References')
  nmap('gI', require('telescope.builtin').lsp_implementations, 'Goto Implementation')
  nmap('<leader>dd', require('telescope.builtin').lsp_type_definitions, 'Type Definition')
  nmap('<leader>ds', require('telescope.builtin').lsp_document_symbols, 'Document Symbols')
  nmap('<leader>Ws', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Workspace Symbols')

  -- See `:help K` for why this keymap
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')
  nmap('J', vim.diagnostic.open_float, 'Line Diagnostic')

  -- Lesser used LSP functionality
  nmap('gD', vim.lsp.buf.declaration, 'Goto Declaration')
  nmap('<leader>Wa', vim.lsp.buf.add_workspace_folder, 'add Folder')
  nmap('<leader>Wr', vim.lsp.buf.remove_workspace_folder, 'remove Folder')
  nmap('<leader>Wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, 'Workspace List Folders')


  -- Create a command `:Format` local to the LSP buffer
  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    vim.lsp.buf.format()
  end, { desc = 'Format current buffer with LSP' })
end


-- document existing key chains
require('which-key').register {
  ['<leader>c'] = { name = '[c]ode', _ = 'which_key_ignore' },
  ['<leader>d'] = { name = '[d]ocument', _ = 'which_key_ignore' },
  ['<leader>G'] = { name = '[G]it Repository', _ = 'which_key_ignore' },
  ['<leader>g'] = { name = '[g]it basics', _ = 'which_key_ignore' },
  ['<leader><tab>'] = { name = '[Tab]Tabs', _ = 'which_key_ignore' },
  -- ['<leader>gt'] = { name = 'Toggle', _ = 'which_key_ignore' },
  -- ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
  ['<leader>s'] = { name = '[s]earch', _ = 'which_key_ignore' },
  ['<leader>W'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
  ['<leader>w'] = { name = '[w]indow', _ = 'which_key_ignore' },
  ['<leader>t'] = { name = '[t]erminal', _ = 'which_key_ignore' },
  ['<leader>b'] = { name = '[b]uffers', _ = 'which_key_ignore' },
  ['<leader>l'] = { name = '[l]ists', _ = 'which_key_ignore' },
  ['<leader>u'] = { name = '[u]ser interface', _ = 'which_key_ignore' },
  ['<leader>x'] = { name = '[x]-Trouble', _ = 'which_key_ignore' },
}

-- mason-lspconfig requires that these setup functions are called in this order
-- before setting up the servers.
require('mason').setup()
require('mason-lspconfig').setup()

-- Enable the following language servers
--  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
--
--  Add any additional override configuration in the following tables. They will be passed to
--  the `settings` field of the server config. You must look up that documentation yourself.
--
--  If you want to override the default filetypes that your language server will attach to you can
--  define the property 'filetypes' to the map in question.
local servers = {
  -- clangd = {},
  -- gopls = {},
  -- pyright = {},
  -- rust_analyzer = {},
  -- tsserver = {},
  -- html = { filetypes = { 'html', 'twig', 'hbs'} },

  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

-- Setup neovim lua configuration
require('neodev').setup()

-- nvim-cmp supports additional completion capabilities, so broadcast that to servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Ensure the servers above are installed
local mason_lspconfig = require 'mason-lspconfig'

mason_lspconfig.setup {
  ensure_installed = vim.tbl_keys(servers),
}

mason_lspconfig.setup_handlers {
  function(server_name)
    require('lspconfig')[server_name].setup {
      capabilities = capabilities,
      on_attach = on_attach,
      settings = servers[server_name],
      filetypes = (servers[server_name] or {}).filetypes,
    }
  end,
}

-- set fidget for default messages
--
-- vim.notify = require("fidget.notifications").notify

-- LSP / Diagnostic setup
vim.fn.sign_define('DiagnosticSignInfo', { text = ' ', texthl = 'DiagnosticSignInfo', numhl = '' })
vim.fn.sign_define('DiagnosticSignWarn', { text = ' ', texthl = 'DiagnosticSignWarn', numhl = '' })
vim.fn.sign_define('DiagnosticSignError', { text = ' ', texthl = 'DiagnosticSignError', numhl = '' })
vim.fn.sign_define('DiagnosticSignHint', { text = ' ', texthl = 'DiagnosticSignHint', numhl = '' })
vim.fn.sign_define('DiagnosticSignOk', { text = ' ', texthl = 'DiagnosticSignOk', numhl = '' })

-- ZenMode
vim.keymap.set('n', '<C-z>', '<cmd>ZenMode<cr>', { desc = '[Z]en Mone' })

vim.keymap.set('n', "<leader>tf", function() require("nvterm.terminal").toggle("float") end,
  { desc = "Toogle Floating Terminal" })
vim.keymap.set('n', "<leader>th", function() require("nvterm.terminal").toggle("horizontal") end,
  { desc = "Toogle Horizontal Terminal" })
vim.keymap.set('n', "<leader>tv", function() require("nvterm.terminal").toggle("vertical") end,
  { desc = "Toogle Vertical Terminal" })
vim.keymap.set('n', "<leader>tH", function() require("nvterm.terminal").new("horizontal") end,
  { desc = "New Horizontal Terminal" })
vim.keymap.set('n', "<leader>tV", function() require("nvterm.terminal").new("vertical") end,
  { desc = "New Vertical Terminal" })



--flash
vim.keymap.set('n', "s", function() require('flash').jump() end,
  { desc = "Flash" })
vim.keymap.set('n', "S", function() require('flash').treesitter() end,
  { desc = "Flash Treesitter Select" })
vim.keymap.set('n', "<leader>cv", function() require('flash').treesitter_search() end,
  { desc = "Treesitter Search and Select" })
vim.keymap.set('n', "<leader>us", function() require('flash').toggle() end,
  { desc = "Toggle Search with Flash" })


-- symbols outline
vim.keymap.set('n', '<leader>o', '<CMD>SymbolsOutline<CR>', { desc = "Toggle Symbols Outline" })


--neotree
--#region neotree

-- vim.keymap.set('n', '<leader>e', '<cmd>Neotree reveal <cr>',{desc = 'Open Neotree'} )
vim.keymap.set('n', '<leader>e',
  function()
    require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
  end,
  { desc = 'Open Neotree' }
)
vim.keymap.set('n', '<leader>E', '<cmd>Neotree toggle current reveal_force_cwd<cr>', { desc = 'Open Neotree' })
vim.keymap.set('n', '<leader>be', '<cmd>Neotree toggle show buffers right<cr>', { desc = 'Display Buffers' })
vim.keymap.set('n', '<leader>ge', '<cmd>Neotree float git_status<cr>', { desc = 'Display Git Status' })


--#endregion


-- trouble
vim.keymap.set("n", "<leader>xx", function() require("trouble").toggle() end, { desc = 'toggle trouble' })
vim.keymap.set("n", "<leader>xw", function() require("trouble").toggle("workspace_diagnostics") end,
  { desc = 'workspace diagnostics' })
vim.keymap.set("n", "<leader>xd", function() require("trouble").toggle("document_diagnostics") end,
  { desc = 'document diagnostics' })
vim.keymap.set("n", "<leader>xq", function() require("trouble").toggle("quickfix") end, { desc = 'quickfix' })
vim.keymap.set("n", "<leader>xl", function() require("trouble").toggle("loclist") end, { desc = 'loclist' })
vim.keymap.set("n", "<leader>xR", function() require("trouble").toggle("lsp_references") end, { desc = 'lsp reference' })

-- [[ Configure nvim-cmp ]]
-- See `:help cmp`
local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

cmp.setup {

  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert {
    ['<C-j>'] = cmp.mapping.select_next_item(),
    ['<C-k>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<S-CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },

  formatting = {
    format = function(_, item)
      local icons = {
        Array = " ",
        Boolean = " ",
        Class = " ",
        Color = " ",
        Constant = " ",
        Constructor = " ",
        Copilot = " ",
        Enum = " ",
        EnumMember = " ",
        Event = " ",
        Field = " ",
        File = " ",
        Folder = " ",
        Function = " ",
        Interface = " ",
        Key = " ",
        Keyword = " ",
        Method = " ",
        Module = " ",
        Namespace = " ",
        Null = " ",
        Number = " ",
        Object = " ",
        Operator = " ",
        Package = " ",
        Property = " ",
        Reference = " ",
        Snippet = " ",
        String = " ",
        Struct = " ",
        Text = " ",
        TypeParameter = " ",
        Unit = " ",
        Value = " ",
        Variable = " ",
      }
      if icons[item.kind] then
        item.kind = icons[item.kind] .. item.kind
      end
      return item
    end,
  },
}

-- lualine callbacks
vim.api.nvim_create_autocmd("RecordingEnter", {
  callback = function()
    require("lualine").refresh({
      place = { "statusline" },
    })
  end,
})

vim.api.nvim_create_autocmd("RecordingLeave", {
  callback = function()
    local timer = vim.loop.new_timer()
    timer:start(
      50,
      0,
      vim.schedule_wrap(function()
        require("lualine").refresh({
          place = { "statusline" },
        })
      end)
    )
  end,
})


-- vim.api.nvim_create_autocmd("CmdlineEnter", {
--   callback = function()
--     vim.opt.cmdheight = 1
--   end
-- })
--
-- vim.api.nvim_create_autocmd("CmdlineLeave", {
--   callback = function()
--     vim.opt.cmdheight = 0
--   end
-- })




-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
