vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

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

-- AUTOCOMMANDS --
vim.cmd [[ au FileType * set fo-=c fo-=r fo-=o ]]
vim.cmd [[ au TextYankPost * silent! lua vim.highlight.on_yank() ]]
vim.cmd [[
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
]]

-- KEYMAPS --
vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('x', '>', '>gv')
vim.keymap.set('x', '<', '<gv')
vim.keymap.set('n', '<cr>', 'o<esc>')
vim.keymap.set('n', '<tab>', '<cmd>bn<cr>')
vim.keymap.set('n', '<s-tab>', '<cmd>bp<cr>')
-- move visual lines.
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- always center view
vim.keymap.set('n', '<c-d>', '<c-d>zz')
vim.keymap.set('n', '<c-u>', '<c-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'N', 'Nzzzv')
vim.keymap.set('n', 'J', 'mzJ`z')
-- easy movements
vim.keymap.set('n', '<c-h>', '^')
vim.keymap.set('n', '<c-j>', '(')
vim.keymap.set('n', '<c-k>', ')')
vim.keymap.set('n', '<c-l>', '$')
vim.keymap.set('i', '<c-k>', '<up>')
vim.keymap.set('i', '<c-j>', '<down>')
vim.keymap.set('i', '<c-h>', '<left>')
vim.keymap.set('i', '<c-l>', '<right>')
vim.keymap.set('i', '<c-e>', '<c-o>$')
vim.keymap.set('i', '<c-a>', '<c-o>^')
-- don't copy on paste
vim.keymap.set('x', 'p', [["_dP]])
-- autoformat
vim.keymap.set('n', 'p', 'p`[v`]=<esc>')
vim.keymap.set('i', 'jk', '<esc>')
-- smart cmd completion
vim.keymap.set('c', '<c-p>', '<up>')
vim.keymap.set('c', '<c-n>', '<down>')
-- movement
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Prev diagnostic' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Next diagnostic' })
-- leader keys
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show error' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Show diagnostics' })
vim.keymap.set('n', '<leader>x', '<cmd>!chmod +x %<CR>', { desc = 'Make file executable' })
vim.keymap.set({ 'n', 'x'}, '<leader>y', '"*y', { desc = "Yank to clipborad" })
vim.keymap.set({ 'n', 'x'}, '<leader>Y', '"*y', { desc = "Yank to clipborad" })
vim.keymap.set({ 'n', 'x'}, '<leader>p', '"*p', { desc = "Paste from clipborad" })
vim.keymap.set({ 'n', 'x'}, '<leader>p', '"*p', { desc = "Paste from clipborad" })

-- PLUGIN MANAGER --
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

-- PLUGINS --
require('lazy').setup({
  { 'tpope/vim-commentary' },
  { 'tpope/vim-sleuth' },
  { 'tpope/vim-vinegar' },
  { 'folke/neodev.nvim', opts = {} },
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'gruvbox'
    end,
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        icons_enabled = false,
        component_separators = '',
        section_separators = '',
      },
    },
  },
  {
    'ggandor/leap.nvim',
    config = function ()
      require('leap').add_default_mappings()
      require('leap').add_repeat_mappings(';', ',', {
        relative_directions = true,
        modes = {'n', 'x', 'o'},
      })
    end
  },
  {
    'echasnovski/mini.clue',
    opts = {
    },
    config = function ()
      local miniclue = require('mini.clue')
      miniclue.setup({
        triggers = {
          { mode = 'n', keys = '<leader>' },
          { mode = 'x', keys = '<leader>' },
        },
        clues = {
          miniclue.gen_clues.builtin_completion(),
        },
        window = {
          delay = 0,
          config = {
            width = 'auto',
          },
        },
      })
    end
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
      on_attach = function(bufnr)
        local gs = package.loaded.gitsigns
        vim.keymap.set('n', ']h', gs.next_hunk, { buffer = bufnr, desc = 'Next hunk' })
        vim.keymap.set('n', '[h', gs.prev_hunk, { buffer = bufnr, desc = 'Prev hunk' })
        vim.keymap.set('n', '<leader>gs', gs.stage_hunk, { buffer = bufnr, desc = 'Stage hunk' })
        vim.keymap.set('x', '<leader>gs', function() gs.stage_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { buffer = bufnr, desc = 'Stage hunk' })
        vim.keymap.set('n', '<leader>gr', gs.reset_hunk, { buffer = bufnr, desc = 'Restore hunk' })
        vim.keymap.set('x', '<leader>gr', function() gs.reset_hunk {vim.fn.line('.'), vim.fn.line('v')} end, { buffer = bufnr, desc = 'Restore hunk' })
        vim.keymap.set('n', '<leader>gR', gs.reset_buffer, { buffer = bufnr, desc = 'Restore buffer' })
        vim.keymap.set('n', '<leader>gp', gs.prev_hunk, { buffer = bufnr, desc = 'Preview hunk' })
        vim.keymap.set('n', '<leader>gb', gs.blame_line, { buffer = bufnr, desc = 'Toggle blame' })
        vim.keymap.set('n', '<leader>gd', gs.diffthis, { buffer = bufnr, desc = 'Toggle blame' })
      end
    },
  },
  -- Fuzzy finder.
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = function()
      pcall(require('telescope').load_extension, 'fzf')
      local tsb = require('telescope.builtin')
      local ivy = require('telescope.themes').get_ivy()
      vim.keymap.set('n', '<C-p>', function () tsb.git_files(ivy) end, { desc = 'Search git files' })
      vim.keymap.set('n', '<leader>/', function () tsb.current_buffer_fuzzy_find(ivy) end, { desc = 'Search buffer' })
      vim.keymap.set('n', '<leader>sb', function () tsb.buffers(ivy) end, { desc = 'Search buffers' })
      vim.keymap.set('n', '<leader>sd', function () tsb.diagnostics(ivy) end, { desc = 'Search diagnostics' })
      vim.keymap.set('n', '<leader>sf', function () tsb.find_files(ivy) end, { desc = 'Search files' })
      vim.keymap.set('n', '<leader>sg', function () tsb.live_grep(ivy) end, { desc = 'Search by grep' })
      vim.keymap.set('n', '<leader>ss', function () tsb.spell_suggest(ivy) end, { desc = 'Search spell suggestions' })
      vim.keymap.set('n', '<leader>sc', function () tsb.colorscheme(ivy) end, { desc = 'Search colorscheme' })
      vim.keymap.set('n', '<leader>sh', function () tsb.help_tags(ivy) end, { desc = 'Search help' })
      vim.keymap.set('n', '<leader>so', function () tsb.vim_options(ivy) end, { desc = 'Search vim options' })
    end
  },
  -- LSP configuration.
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      { 'williamboman/mason.nvim', opts = {} },
      { 'williamboman/mason-lspconfig.nvim', opts = {} },
    },
    config = function ()
      local on_attach = function(_, bufnr)
        local tsb = require('telescope.builtin')
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, { buffer = bufnr })
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help,{ buffer = bufnr })
        vim.keymap.set('n', '<leader>a', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'Code action' })
        vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, { buffer = bufnr, desc = 'Rename variable' })
        vim.keymap.set('n', 'gr', tsb.lsp_references, { buffer = bufnr, desc = 'LSP: References' })
        vim.keymap.set('n', 'gd', tsb.lsp_definitions, { buffer = bufnr, desc = 'LSP: Definition' })
        vim.keymap.set('n', 'gI', tsb.lsp_implementations, { buffer = bufnr, desc = 'LSP: Implementations' })
      end
      -- Define lsp servers
      local servers = {
        rust_analyzer = {},
        lua_ls = {},
      }
      -- Setup neovim lua configuration
      require('neodev').setup()
      -- Ensure the servers above are installed
      local mlsp = require('mason-lspconfig')
      mlsp.setup {
        ensure_installed = vim.tbl_keys(servers),
      }
      -- Add nvim-cmp capabilities
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
      mlsp.setup_handlers {
        function(server_name)
          require('lspconfig')[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
          }
        end,
      }
    end
  },
  -- Autocompletion & snippets.
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
      'rafamadriz/friendly-snippets',
    },
    config = function ()
      local cmp = require 'cmp'
      local lsnip = require 'luasnip'
      require('luasnip.loaders.from_vscode').lazy_load()
      lsnip.config.setup {}
      ---@diagnostic disable-next-line: missing-fields
      cmp.setup {
        snippet = {
          expand = function(args)
            lsnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert {
          ['<C-d>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif lsnip.expand_or_locally_jumpable() then
              lsnip.expand_or_jump()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif lsnip.locally_jumpable(-1) then
              lsnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        sources = {
          { name = 'nvim_lsp' },
          { name = 'luasnip' },
        },
      }
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
          },
        },
        move = {
          enable = true,
          set_jumps = true,
          goto_next_start = {
            [']m'] = '@function.outer',
            [']]'] = '@class.outer',
          },
          goto_next_end = {
            [']M'] = '@function.outer',
            [']['] = '@class.outer',
          },
          goto_previous_start = {
            ['[m'] = '@function.outer',
            ['[['] = '@class.outer',
          },
          goto_previous_end = {
            ['[M'] = '@function.outer',
            ['[]'] = '@class.outer',
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ['<leader>a'] = '@parameter.inner',
          },
          swap_previous = {
            ['<leader>A'] = '@parameter.inner',
          },
        },
      },
    }
  },
}, {})

