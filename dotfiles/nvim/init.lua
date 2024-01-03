---@diagnostic disable: missing-fields

-- LEADER --
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- OPTIONS --
vim.opt.breakindent = true -- soft wrap keeps indent
vim.opt.cursorline = true -- show current line
vim.opt.lcs = 'trail:•,tab:>-' -- visualise whitespace
vim.opt.list = true -- visualise whitespace
vim.opt.ignorecase = true -- ignore case on search.
vim.opt.smartcase = true -- ignore case unless upper
vim.opt.scrolloff = 10 -- always show some context
vim.opt.showmode = false -- shown in statusline
vim.opt.smartindent = true -- start with corrent indenting
vim.opt.swapfile = false -- no swapfiles
vim.opt.timeoutlen = 200 -- faster timeout
vim.opt.undofile = true -- persistent undo!
vim.opt.colorcolumn = '80' -- show 80 char column
vim.wo.number = true -- show line numbers

-- KEYMAPS --
vim.keymap.set('i', 'jk', '<esc>')
vim.keymap.set('i', '<esc>', '<esc>')
vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { desc = 'Write buffer' })
vim.keymap.set('n', '<leader>q', '<cmd>bdelete<cr>', { desc = 'Delete buffer' })
vim.keymap.set('n', '<leader>X', '<cmd>!chmod +x %<cr>', { desc = 'Make file executable' })
-- keep selection when indenting
vim.keymap.set('x', '>', '>gv')
vim.keymap.set('x', '<', '<gv')
-- center view
vim.keymap.set('n', '<c-d>', '<c-d>zz')
vim.keymap.set('n', '<c-u>', '<c-u>zz')
vim.keymap.set('n', 'n', 'nzzzv')
vim.keymap.set('n', 'n', 'nzzzv')
-- don't copy in visual mode
vim.keymap.set('x', 'p', [["_dp]])
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
vim.keymap.set('n', '<leader>y', '"+Y', { desc = 'Yank to clipboard' })
vim.keymap.set('x', '<leader>y', '"+y', { desc = 'Yank to clipboard' })
vim.keymap.set({ 'n', 'x' }, '<leader>p', '"+p', { desc = 'paste from clipborad' })
vim.keymap.set({ 'n', 'x' }, '<leader>P', '"+P', { desc = 'Paste from clipborad' })
-- Quickfix window.
vim.keymap.set('n', '<c-up>', '<cmd>cprev<cr>')
vim.keymap.set('n', '<c-down>', '<cmd>cnext<cr>')
vim.keymap.set('n', '<leader>x', function()
  for _, win in pairs(vim.fn.getwininfo()) do
    if win['quickfix'] == 1 then
      vim.cmd 'cclose'
      return
    end
  end
  vim.cmd 'copen'
end, { desc = 'Toggle quickfix' })

-- NETRW --
vim.g.netrw_altv = 1
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 0
vim.g.netrw_keepdir = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_preview = 1
vim.g.netrw_use_errorwindow = 0
vim.g.netrw_winsize = 20
vim.keymap.set('n', '<c-n>', function()
  local netrw_found = false
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_get_option(buf, 'filetype') == 'netrw' then
      vim.api.nvim_buf_delete(buf, { force = true })
      netrw_found = true
    end
  end
  if not netrw_found then
    vim.cmd('Vexplore')
  end
end, { desc = 'Toggle file tree' })

-- AUTOCOMMANDS --
-- Remove trailing whitespace
vim.cmd [[ au BufWritePre * :%s/\s\+$//e ]]
-- Highlight yanks
vim.cmd [[ au TextYankPost * silent! lua vim.highlight.on_yank() ]]
-- Return to last position
vim.cmd [[ autocmd BufReadPost *  if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]]
-- Close netrw buffer on leave
vim.cmd [[ autocmd FileType netrw autocmd BufLeave <buffer> if &filetype == 'netrw' | :bd | endif ]]


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
  -- Surround
  { 'kylechui/nvim-surround', opts = {} },
  -- Autopairs
  { 'windwp/nvim-autopairs',  opts = {} },
  -- Hints
  { 'folke/which-key.nvim',   opts = { triggers = { '<leader>', 'g' } } },
  -- Lazgit
  {
    'kdheepak/lazygit.nvim',
    opts = {},
    config = function()
      vim.keymap.set('n', '<leader>g', '<cmd>LazyGit<cr>', { desc = 'Open lazygit' })
    end,
  },
  -- Toggleterm
  {
    'akinsho/toggleterm.nvim',
    config = function()
      require('toggleterm').setup()
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
  -- Colorscheme
  {
    'projekt0n/github-nvim-theme',
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme github_dark_default]])
    end,
  },
  -- Markdown preview
  {
    'ellisonleao/glow.nvim',
    config = function()
      require('glow').setup()
      vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
        pattern = '*.md',
        callback = function()
          vim.keymap.set('n', '<leader>p', '<cmd>Glow<cr>', { desc = 'Preview markdown' })
        end
      })
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
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch' },
        lualine_c = { 'buffers' },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'diff', 'diagnostics' },
        lualine_z = { 'location' }
      },
    },
  },
  -- Copilot.
  {
    'zbirenbaum/copilot.lua',
    opts = {
      suggestion = {
        auto_trigger = true,
        keymap = {
          accept = '<C-Space>',
          next = '<C-]>',
          prev = '<C-[>',
          dismiss = '<C-x>',
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
        vim.keymap.set('n', '<leader>d', gs.diffthis, { buffer = bufnr, desc = 'Open diff' })
        vim.keymap.set('n', '<leader>s', gs.stage_hunk, { buffer = bufnr, desc = 'Stage hunk' })
        vim.keymap.set('x', '<leader>s', stageHunk, { buffer = bufnr, desc = 'Stage hunk' })
        vim.keymap.set('n', '<leader>r', gs.reset_hunk, { buffer = bufnr, desc = 'Restore hunk' })
        vim.keymap.set('x', '<leader>r', resetHunk, { buffer = bufnr, desc = 'Restore hunk' })
        vim.keymap.set('n', '<leader>G', showBlame, { buffer = bufnr, desc = 'Show full line blame' })
        vim.keymap.set('n', '<leader>B', gs.toggle_current_line_blame, { buffer = bufnr, desc = 'Toggle line blame' })
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
      'simrat39/rust-tools.nvim',
      'Saecki/crates.nvim',
      -- Debugging python and rust
      'mfussenegger/nvim-dap',
      'theHamsta/nvim-dap-virtual-text',
      -- Formatting
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
      -- LSP CONFIGURATION --
      ---@diagnostic disable-next-line: unused-local
      lsp_zero.on_attach(function(client, bufnr)
        lsp_zero.default_keymaps({ buffer = bufnr })
        vim.keymap.set('n', 'ge', vim.diagnostic.open_float, { desc = 'Show error' })
        vim.keymap.set('n', 'gE', vim.diagnostic.setqflist, { desc = 'Show diagnostics' })
        vim.keymap.set('n', 'ga', vim.lsp.buf.code_action, { buffer = bufnr, desc = 'LSP: Code action' })
        vim.keymap.set('n', 'gR', vim.lsp.buf.rename, { buffer = bufnr, desc = 'LSP: Rename' })
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, { buffer = bufnr, desc = 'LSP: References' })
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { buffer = bufnr, desc = 'LSP: Definition' })
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { buffer = bufnr, desc = 'LSP: Declaration' })
        vim.keymap.set('n', 'gI', vim.lsp.buf.implementation, { buffer = bufnr, desc = 'LSP: implementation' })
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
      end)
      -- LSP SERVERS ---
      require('neodev').setup({})
      require('mason').setup({})
      require('mason-lspconfig').setup({
        ensure_installed = {
          'bashls',
          'dockerls',
          'eslint',
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
          'yamlls',
        },
        handlers = {
          lsp_zero.default_setup,
          rust_analyzer = function()
            -- Setup codelldb
            MASON_PATH = os.getenv('HOME') .. '/' .. '.local/share/nvim/mason/packages/'
            local codelldb_path = MASON_PATH .. 'codelldb/extension/adapter/codelldb'
            local liblldb_path = MASON_PATH .. 'codelldb/extension/lldb/lib/liblldb.so'
            -- Setup rust-tools
            require('rust-tools').setup({
              tools = {
                executor = require('rust-tools.executors').toggleterm,
              },
              inlay_hints = {
                only_current_line = true,
                parameter_hints_prefix = '',
                other_hints_prefix = '=> ',
                max_len_align = true,
              },
              dap = {
                adapter = require('rust-tools.dap').get_codelldb_adapter(codelldb_path, liblldb_path),
              }
            })
            -- Setup keymaps
            vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWinEnter' }, {
              pattern = { '*.rs', 'Cargo.toml' },
              callback = function()
                vim.keymap.set('n', '<leader>R', '<cmd>RustRunnables<cr>', { desc = 'Runnables' })
                vim.keymap.set('n', '<leader>D', '<cmd>RustDebuggables<cr>', { desc = 'Debuggables' })
              end
            })
          end
        },
      })
      -- DEBUGGING --
      require('nvim-dap-virtual-text').setup { highlight_new_as_changed = true }
      local dap = require('dap')
      vim.keymap.set('n', '<leader>c', dap.continue, { desc = 'DBG: Continue' })
      vim.keymap.set('n', '<leader>n', dap.step_over, { desc = 'DBG: Step over' })
      vim.keymap.set('n', '<leader>i', dap.step_into, { desc = 'DBG: Step into' })
      vim.keymap.set('n', '<leader>o', dap.step_out, { desc = 'DBG: Step out' })
      vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Toggle breakpoint' })
      -- FORMATTING --
      require('conform').setup({
        formatters_by_ft = {
          javascript = { 'prettierd' },
          json = { 'prettierd' },
          markdown = { 'prettierd' },
          python = { 'ruff' },
          shell = { 'shftm' },
          typescript = { 'prettierd' },
          yaml = { 'prettierd' },
        },
        format_on_save = function()
          if vim.g.disable_autoformat then
            return
          end
          return { timeout_ms = 500, lsp_fallback = true }
        end,
      })
      -- Make format on save optional.
      vim.g.disable_autoformat = false
      vim.api.nvim_create_user_command('ToggleFormatOnSave', function()
        if vim.g.disable_autoformat then
          vim.g.disable_autoformat = false
        else
          vim.g.disable_autoformat = true
        end
      end, {})
      vim.keymap.set('n', '<leader>F', '<cmd>ToggleFormatOnSave<cr>', { desc = 'Toggle format on save', })
      -- AUTOCOMPLETE --
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
  -- TREE-SITTER --
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      'RRethy/nvim-treesitter-textsubjects',
    },
    build = ':TSUpdate',
  },
}, {})


-- Treesitter configuration must be after plugins are loaded.
require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'bash',
    'lua',
    'markdown',
    'python',
    'rust',
    'zig'
  },
  sync_install = true,
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<CR>',
      node_incremental = '<C-h>',
      node_decremental = '<C-l>',
    },
  },
  textsubjects = {
    enable = true,
    keymaps = {
      ['<cr>'] = 'textsubjects-smart',
      ['i<cr>'] = 'textsubjects-container-inner',
      ['a<cr>'] = 'textsubjects-container-outer',
    },
  },
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
