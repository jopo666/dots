-- LEADER --
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- OPTIONS --
vim.g.netrw_keepdir = 0
vim.g.netrw_preview = 1
vim.g.netrw_use_errorwindow = 0
vim.opt.breakindent = true -- Soft wrap keeps indent
vim.opt.cursorline = true -- Show current line
vim.opt.lcs = 'trail:•,tab:>-' -- Visualise whitespace
vim.opt.list = true -- Visualise whitespace
vim.opt.ignorecase = true -- Ignore case on search.
vim.opt.smartcase = true -- Ignore case unless upper
vim.opt.scrolloff = 10 -- Always show some context
vim.opt.showmode = false -- Shown in statusline
vim.opt.smartindent = true -- Start with corrent indenting
vim.opt.swapfile = false -- No swapfiles
vim.opt.timeoutlen = 200 -- Faster timeout
vim.opt.undofile = true -- Persistent undo!
vim.wo.number = true -- Show line numbers

-- KEYMAPS --
vim.keymap.set('i', 'jk', '<esc>')
vim.keymap.set('i', '<esc>', '<esc>')
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { desc = 'Write buffer' })
vim.keymap.set('n', '<leader>q', '<cmd>q<cr>', { desc = 'Quit buffer' })
vim.keymap.set('n', '<leader>X', '<cmd>!chmod +x %<CR>', { desc = 'Make file executable' })
-- Keep selection when indenting
vim.keymap.set('x', '>', '>gv')
vim.keymap.set('x', '<', '<gv')
-- Center view
vim.keymap.set('n', '<c-d>', '<c-d>zz')
vim.keymap.set('n', '<c-u>', '<c-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
-- Don't copy in visual mode
vim.keymap.set('x', 'p', [["_dP]])
-- Go through history
vim.keymap.set('c', '<c-p>', '<up>')
vim.keymap.set('c', '<c-n>', '<down>')
-- Instert mode movement
vim.keymap.set('i', '<c-e>', '<c-o>$')
vim.keymap.set('i', '<c-a>', '<c-o>^')
vim.keymap.set('i', '<c-k>', '<up>')
vim.keymap.set('i', '<c-j>', '<down>')
vim.keymap.set('i', '<c-h>', '<left>')
vim.keymap.set('i', '<c-l>', '<right>')
-- Change buffers and skip netrw.
vim.keymap.set('n', '<tab>', '<cmd>bn<cr>')
vim.keymap.set('n', '<s-tab>', '<cmd>bp<cr>')
-- Yank/paste to clipboard
vim.keymap.set('n', '<leader>y', '"+Y', { desc = "Yank to clipboard" })
vim.keymap.set('x', '<leader>y', '"+y', { desc = "Yank to clipboard" })
vim.keymap.set({ 'n', 'x' }, '<leader>p', '"+p', { desc = "paste from clipborad" })
vim.keymap.set({ 'n', 'x' }, '<leader>P', '"+P', { desc = "Paste from clipborad" })
-- Quickfix window.
vim.keymap.set('n', '<c-up>', '<cmd>cprev<cr>')
vim.keymap.set('n', '<c-down>', '<cmd>cnext<cr>')
vim.keymap.set('n', '<leader>x', function()
  for _, win in pairs(vim.fn.getwininfo()) do
    if win['quickfix'] == 1 then
      vim.cmd "cclose"
      return
    end
  end
  vim.cmd "copen"
end
)

-- AUTOCOMMANDS --
-- Remove trailing whitespace
vim.cmd [[ au BufWritePre * :%s/\s\+$//e ]]
-- Highlight yanks
vim.cmd [[ au TextYankPost * silent! lua vim.highlight.on_yank() ]]
-- Return to last position
vim.cmd [[ autocmd BufReadPost *  if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]]

-- PLUGIN MANAGER --
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system { 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath, }
end
vim.opt.rtp:prepend(lazypath)

-- PLUGINS --
require('lazy').setup({
  -- Tim Pope
  { 'tpope/vim-commentary' },
  { 'tpope/vim-sleuth' },
  { 'tpope/vim-obsession' },
  { 'tpope/vim-vinegar' },
  -- Lazgit
  {
    'kdheepak/lazygit.nvim',
    opts = {},
    config = function()
      vim.keymap.set('n', '<leader>g', '<cmd>LazyGit<cr>', { desc = 'Open lazygit' })
    end
  },
  -- Surround
  { "kylechui/nvim-surround", opts = {} },
  -- Autopairs
  { 'windwp/nvim-autopairs',  opts = {} },
  -- Toggleterm
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
      require("toggleterm").setup()
      vim.keymap.set({ 'n', 't' }, '<C-j>', '<cmd>ToggleTerm<cr>')
    end
  },
  -- Mouse
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').create_default_mappings()
    end
  },
  -- Hints
  { 'folke/which-key.nvim', opts = {} },
  -- Colorscheme
  {
    'projekt0n/github-nvim-theme',
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme github_dark_default]])
    end,
  },
  -- Statusline
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        component_separators = '|',
        section_separators = '',
      },
    },
  },
  -- Copilot.
  {
    "zbirenbaum/copilot.lua",
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = "<C-Space>",
          next = "<C-]>",
          prev = "<C-[>",
          dismiss = "<C-x>",
        }
      }
    },
  },
  -- Git stuff.
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      signs = {
        add = { text = '+' },
        change = { text = '~' },
        delete = { text = '_' },
        topdelete = { text = '‾' },
        changedelete = { text = '~' },
      },
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'right_align',
        delay = 0,
        ignore_whitespace = false,
        virt_text_priority = 100,
      },
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        local stageHunk = function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end
        local resetHunk = function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end
        local showBlame = function() gs.blame_line { full = true } end
        vim.keymap.set('n', ']h', gs.next_hunk, { buffer = bufnr, desc = 'Next hunk' })
        vim.keymap.set('n', '[h', gs.prev_hunk, { buffer = bufnr, desc = 'Prev hunk' })
        vim.keymap.set('n', '<leader>d', gs.diffthis, { buffer = bufnr, desc = 'Diff this' })
        vim.keymap.set('n', '<leader>D', '<C-w>h<cmd>q<cr>', { desc = 'Close diff' })
        vim.keymap.set('n', '<leader>s', gs.stage_hunk, { buffer = bufnr, desc = 'Stage hunk' })
        vim.keymap.set('x', '<leader>s', stageHunk, { buffer = bufnr, desc = 'Stage hunk' })
        vim.keymap.set('n', '<leader>S', gs.reset_hunk, { buffer = bufnr, desc = 'Restore hunk' })
        vim.keymap.set('x', '<leader>S', resetHunk, { buffer = bufnr, desc = 'Restore hunk' })
        vim.keymap.set('n', '<leader>b', gs.toggle_current_line_blame, { buffer = bufnr, desc = 'Toggle blame' })
        vim.keymap.set('n', '<leader>B', showBlame, { buffer = bufnr, desc = 'Toggle line blame' })
      end
    },
  },
  -- Fuzzy searching
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      -- Load fzf
      pcall(require('telescope').load_extension, 'fzf')
      -- Keymaps
      local tsb = require('telescope.builtin')
      local dd = require('telescope.themes').get_dropdown { winblend = 10, previewer = false, }
      vim.keymap.set('n', '<C-p>', tsb.git_files, { desc = 'Search git files' })
      vim.keymap.set('n', '<C-f>', function() tsb.current_buffer_fuzzy_find(dd) end, { desc = 'Grep buffer' })
      vim.keymap.set('n', '<leader><space>b', tsb.buffers, { desc = 'Search buffers' })
      vim.keymap.set('n', '<leader><space>d', tsb.diagnostics, { desc = 'Search diagnostics' })
      vim.keymap.set('n', '<leader><space>f', tsb.find_files, { desc = 'Search files' })
      vim.keymap.set('n', '<leader><space>g', tsb.live_grep, { desc = 'Search by grep' })
      vim.keymap.set('n', '<leader><space>s', tsb.spell_suggest, { desc = 'Search spell suggestions' })
      vim.keymap.set('n', '<leader><space>c', function() tsb.colorscheme({ enable_preview = true }) end,
        { desc = 'Search colorscheme' })
      vim.keymap.set('n', '<leader><space>h', tsb.help_tags, { desc = 'Search help' })
      vim.keymap.set('n', '<leader><space>r', tsb.oldfiles, { desc = 'Search recent files' })
      vim.keymap.set('n', '<leader><space>o', tsb.vim_options, { desc = 'Search vim options' })
    end
  },
  -- LSP configuration
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      -- LSP servers
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'folke/neodev.nvim',
      -- Formatting with conform
      'stevearc/conform.nvim',
      -- Autocompletion
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      -- Snippets
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
    },
    config = function()
      local lsp_zero = require('lsp-zero')
      -- LSP configuration
      ---@diagnostic disable-next-line: unused-local
      lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show error' })
        vim.keymap.set('n', '<leader>E', vim.diagnostic.setloclist, { desc = 'Show diagnostics' })
        vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code action' })
        vim.keymap.set('n', '<leader>R', vim.lsp.buf.rename, { buffer = bufnr, desc = 'Rename variable' })
        vim.keymap.set('n', '<leader>f', function()
          require("conform").format({ async = true, lsp_fallback = true })
        end, { desc = "Format buffer", })
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = 'LSP: References' })
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      end)
      -- LSP servers.
      require('neodev').setup({})
      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = {
          'bashls',
          -- 'csharp_ls',
          'dockerls',
          'eslint',
          'grammarly',
          'html',
          'htmx',
          'jsonls',
          'lua_ls',
          'marksman',
          'powershell_es',
          'pylsp',
          'pyright',
          'ruff_lsp',
          'rust_analyzer',
          'tailwindcss',
          'taplo',
          'tsserver',
          'vale_ls',
          'yamlls',
        },
        handlers = { lsp_zero.default_setup, },
      })
      -- Formatting.
      require("conform").setup({
        formatters_by_ft = {
          javascript = { 'prettierd' },
          json = { 'prettierd' },
          markdown = { 'prettierd' },
          python = { 'ruff' },
          shell = { 'shftm' },
          typescript = { 'prettierd' },
          yaml = { 'prettierd' },
        },
      })
      -- Autocomplete
      local cmp = require('cmp')
      local cmp_action = lsp_zero.cmp_action()
      cmp.setup({
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
          { name = 'buffer' },
          { name = 'path' },
        },
        mapping = cmp.mapping.preset.insert({
          ['<CR>'] = cmp.mapping.confirm({ select = false }),
          ['<Tab>'] = cmp_action.luasnip_supertab(),
          ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
          ['<C-u>'] = cmp.mapping.scroll_docs(-4),
          ['<C-d>'] = cmp.mapping.scroll_docs(4),
        })
      })
    end
  },
  -- Treesitter.
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    opt = {
      auto_install = true,
      ensure_installed = {
        'bash',
        'go',
        'javascript',
        'lua',
        'markdown',
        'markdown_inline',
        'python',
        'rust',
        'typescript',
        'vim',
        'zig'
      },
      indent = { enable = true },
      highlight = { enable = true },
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['aa'] = '@parameter.outer',
            ['ia'] = '@parameter.inner',
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
            ['as'] = '@struct.outer',
            ['is'] = '@struct.inner',
            ['at'] = '@type.outer',
            ['it'] = '@type.inner',
          },
        },
      },
    }
  },
}, {})
