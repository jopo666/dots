vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.netrw_keepdir = 0
vim.g.netrw_liststyle = 0
vim.g.netrw_preview = 1
vim.g.netrw_use_errorwindow = 0

-- OPTIONS --
vim.opt.breakindent = true
vim.opt.clipboard = 'unnamed'
vim.opt.completeopt = 'menuone,noselect,noinsert'
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.history = 5000
vim.opt.hlsearch = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.lcs = 'trail:•,tab:>-'
vim.opt.list = true
vim.opt.mouse = 'a'
vim.opt.scrolloff = 10
vim.opt.shiftround = true
vim.opt.shiftwidth = 4
vim.opt.showmode = false
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.smarttab = true
vim.opt.swapfile = false
vim.opt.tabstop = 4
vim.opt.timeoutlen = 200
vim.opt.undofile = true
vim.opt.updatetime = 150
vim.opt.whichwrap = 'b,s,<,>,h,l,[,]'
vim.wo.number = true
vim.opt.diffopt = vim.opt.diffopt + "iwhiteall"

-- AUTOCOMMANDS --
vim.cmd [[ au FileType * set fo-=c fo-=r fo-=o ]]
vim.cmd [[ au TextYankPost * silent! lua vim.highlight.on_yank() ]]
vim.cmd [[ autocmd BufWritePre * :%s/\s\+$//e ]]
vim.cmd [[ au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif ]]

-- KEYMAPS --
vim.keymap.set('i', '<esc>', '<esc>')
vim.keymap.set('i', 'jk', '<esc>')
vim.keymap.set('i', 'kj', '<esc>')
vim.keymap.set({ 'n', 'x' }, 'q:', '<nop>')
vim.keymap.set('x', '>', '>gv')
vim.keymap.set('x', '<', '<gv')
vim.keymap.set('n', '<c-d>', '<c-d>zz')
vim.keymap.set('n', '<c-u>', '<c-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', 'p', 'p`[v`]=<esc>')
vim.keymap.set('c', '<c-p>', '<up>')
vim.keymap.set('c', '<c-n>', '<down>')
vim.keymap.set('x', 'p', [["_dP]])
-- easy movements
vim.keymap.set('n', '<c-e>', '$')
vim.keymap.set('n', '<c-a>', '^')
vim.keymap.set('i', '<c-e>', '<c-o>$')
vim.keymap.set('i', '<c-a>', '<c-o>^')
vim.keymap.set('i', '<c-k>', '<up>')
vim.keymap.set('i', '<c-j>', '<down>')
vim.keymap.set('i', '<c-h>', '<left>')
vim.keymap.set('i', '<c-l>', '<right>')
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<c-up>', '<cmd>cprev<cr>')
vim.keymap.set('n', '<c-down>', '<cmd>cnext<cr>')
vim.keymap.set('n', '<tab>', '<cmd>bn<cr>')
vim.keymap.set('n', '<s-tab>', '<cmd>bp<cr>')
-- leader keys
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { desc = 'Write buffer' })
vim.keymap.set('n', '<leader>q', '<cmd>q<cr>', { desc = 'Quit buffer' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show error' })
vim.keymap.set('n', '<leader>E', vim.diagnostic.setloclist, { desc = 'Show diagnostics' })
vim.keymap.set('n', '<leader>x', '<cmd>bdelete<CR>', { desc = 'Delete buffer' })
vim.keymap.set('n', '<leader>X', '<cmd>!chmod +x %<CR>', { desc = 'Make file executable' })
vim.keymap.set({ 'n', 'x' }, '<leader>y', '"+y', { desc = "yank to clipborad" })
vim.keymap.set({ 'n', 'x' }, '<leader>Y', '"+Y', { desc = "yank to clipborad" })
vim.keymap.set({ 'n', 'x' }, '<leader>p', '"+p', { desc = "paste from clipborad" })
vim.keymap.set({ 'n', 'x' }, '<leader>P', '"+P', { desc = "Paste from clipborad" })

-- PLUGIN MANAGER --
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system { 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath, }
end
vim.opt.rtp:prepend(lazypath)

-- PLUGINS --
require('lazy').setup({
  { 'tpope/vim-commentary' },
  { 'tpope/vim-sleuth' },
  { 'tpope/vim-vinegar' },
  { 'folke/neodev.nvim',      opts = {} },
  { 'kyleshui/nvim-surround', opts = {} },
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
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme gruvbox]])
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        theme = 'gruvbox',
        icons_enabled = false,
        component_separators = '',
        section_separators = '',
      },
    },
  },
  {
    'ggandor/leap.nvim',
    config = function()
      vim.keymap.set("n", "S", "<Plug>(leap-backward-to)")
      vim.keymap.set("n", "s", "<Plug>(leap-forward-to)")
    end
  },
  {
    'echasnovski/mini.clue',
    opts = {
    },
    config = function()
      local miniclue = require('mini.clue')
      miniclue.setup({
        triggers = {
          { mode = 'n', keys = '<leader>' },
          { mode = 'x', keys = '<leader>' },
        },
        clues = { miniclue.gen_clues.builtin_completion(), },
        window = { delay = 0, config = { width = 'auto' } },
      })
    end
  },
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
        vim.keymap.set('n', ']h', gs.next_hunk, { buffer = bufnr, desc = 'Next hunk' })
        vim.keymap.set('n', '[h', gs.prev_hunk, { buffer = bufnr, desc = 'Prev hunk' })
        vim.keymap.set('n', '<leader>d', gs.diffthis, { buffer = bufnr, desc = 'Diff this' })
        vim.keymap.set('n', '<leader>D', '<C-w>h<cmd>q<cr>', { desc = 'Close diff' })
        vim.keymap.set('n', '<leader>s', gs.stage_hunk, { buffer = bufnr, desc = 'Stage hunk' })
        vim.keymap.set('x', '<leader>s', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
          { buffer = bufnr, desc = 'Stage hunk' })
        vim.keymap.set('n', '<leader>S', gs.reset_hunk, { buffer = bufnr, desc = 'Restore hunk' })
        vim.keymap.set('x', '<leader>S', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end,
          { buffer = bufnr, desc = 'Restore hunk' })
        vim.keymap.set('n', '<leader>B', gs.toggle_current_line_blame, { buffer = bufnr, desc = 'Toggle blame' })
        vim.keymap.set('n', '<leader>b', function() gs.blame_line { full = true } end,
          { buffer = bufnr, desc = 'Toggle line blame' })
      end
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      pcall(require('telescope').load_extension, 'fzf')
      local tsb = require('telescope.builtin')
      vim.keymap.set('n', '<C-p>', tsb.git_files, { desc = 'Search git files' })
      vim.keymap.set('n', '<leader>/', tsb.current_buffer_fuzzy_find, { desc = 'Search buffer' })
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
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    dependencies = {
      -- LSP dependencies.
      'neovim/nvim-lspconfig',
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      -- Autocompletion.
      'hrsh7th/nvim-cmp',
      'hrsh7th/cmp-nvim-lsp',
      -- Sources.
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      -- Snippets.
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
        vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code action' })
        vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { buffer = bufnr, desc = 'Rename variable' })
        vim.keymap.set('n', '<leader>f', vim.lsp.buf.format, { buffer = bufnr, desc = 'Format document' })
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = 'LSP: References' })
      end)
      -- LSP servers.
      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = { 'lua_ls', 'tsserver', 'rust_analyzer' },
        handlers = {
          lsp_zero.default_setup,
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
      ensure_installed = { 'c', 'lua', 'markdown', 'markdown_inline', 'python', 'rust', 'tsx', 'javascript', 'typescript', 'vimdoc', 'vim', 'bash' },
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
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']f'] = '@function.outer',
            [']m'] = '@class.outer',
          },
          goto_next_end = {
            [']F'] = '@function.outer',
            [']M'] = '@class.outer',
          },
          goto_previous_start = {
            ['[f'] = '@function.outer',
            ['[m'] = '@class.outer',
          },
          goto_previous_end = {
            ['[F'] = '@function.outer',
            ['[M'] = '@class.outer',
          },
        },
      },
    }
  },
}, {})
