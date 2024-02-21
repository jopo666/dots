---@diagnostic disable: missing-fields

--- OPTIONS ---
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.netrw_banner = 0          -- disable netrw banner
vim.g.netrw_preview = 1         -- vertical split preview
vim.g.netrw_use_errorwindow = 0 -- ignore errors
vim.opt.breakindent = true      -- indent wrapped lines
vim.opt.colorcolumn = "80"      -- show 80 char column
vim.opt.completeopt = { "menuone", "noinsert", "noselect" }
vim.opt.cursorline = true       -- show current line
vim.opt.expandtab = true        -- use spaces instead of tabs
vim.opt.ignorecase = true       -- ignore case
vim.opt.mouse = "a"             -- disable temporarily with shift
vim.opt.number = true           -- show line numbers
vim.opt.path = { ".,**" }       -- find recursively
vim.opt.pumheight = 10          -- max completion items
vim.opt.relativenumber = true   -- and relative line numbers
vim.opt.scrolloff = 8           -- always show some context
vim.opt.shortmess:append("c")   -- don't show completion messages
vim.opt.signcolumn = "yes"      -- always show sign column
vim.opt.smartcase = true        -- don't ignore case with capitals
vim.opt.swapfile = false        -- no swapfiles
vim.opt.tabstop = 4             -- tab width
vim.opt.shiftwidth = 4          -- indent width
vim.opt.softtabstop = 4         -- tab width
vim.opt.termguicolors = true    -- 24-bit RGB colors
vim.opt.undofile = true         -- persistent undo
vim.cmd([[ colorscheme habamax ]])

--- AUTOCOMMANDS ---
-- remove trailing whitespace
vim.cmd([[ au BufWritePre * :%s/\s\+$//e ]])
-- highlight yanks
vim.cmd([[ au TextYankPost * silent! lua vim.highlight.on_yank() ]])
-- return to last position when opening buffer
vim.cmd([[ autocmd BufReadPost *  if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif ]])
-- delete hidden netrw buffers
vim.cmd([[ autocmd Filetype netrw setl bufhidden=delete ]])
-- don't continue comments
vim.cmd([[ autocmd FileType * set formatoptions-=ro ]])
-- toggle spelling in markdown and gitcommit
vim.cmd([[ autocmd FileType markdown,gitcommit setlocal spell ]])
-- colorcolumns for filetypes
vim.cmd([[ autocmd FileType python setlocal colorcolumn=88 ]])
vim.cmd([[ autocmd FileType gitcommit setlocal colorcolumn=50,70 ]])

--- FUNCTIONS ---
local grep_current_word = function()
    local current_word = vim.fn.expand("<cword>")
    if vim.fn.system("git rev-parse --is-inside-work-tree 2> /dev/null") ~= 0 then
        vim.fn.execute("vimgrep /\\<" .. current_word .. "\\>/g `git ls-files`")
    else
        vim.fn.execute("vimgrep /\\<" .. current_word .. "\\>/g **/*")
    end
    vim.fn.execute("copen")
end
local grep_user_input = function()
    local user_input = vim.fn.input("Grep for: ")
    if user_input == "" then
        return
    end
    vim.fn.execute("vimgrep /" .. user_input .. "/g **/*")
    vim.fn.execute("copen")
end

--- KEYMAPS ---
-- esc is too far
vim.keymap.set("i", "jk", "<esc>")
-- too close to arrows
vim.keymap.set({ "i", "n", "v" }, "<pageup>", "<nop>")
vim.keymap.set({ "i", "n", "v" }, "<pagedown>", "<nop>")
-- don't jump to next
vim.keymap.set("n", "*", "m`:keepjumps normal! *``<cr>")
vim.keymap.set("n", "#", "m`:keepjumps normal! #``<cr>")
-- center view
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "n", "nzz")
vim.keymap.set("n", "<c-d>", "<c-d>zz")
vim.keymap.set("n", "<c-u>", "<c-u>zz")
-- resize
vim.keymap.set("n", "<c-up>", "<cmd>resize -2<cr>")
vim.keymap.set("n", "<c-down>", "<cmd>resize +2<cr>")
vim.keymap.set("n", "<c-left>", "<cmd>vertical resize -2<cr>")
vim.keymap.set("n", "<c-right>", "<cmd>vertical resize +2<cr>")
-- movement by shown lines
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- vinegar
vim.keymap.set("n", "-", "<cmd>Explore<cr>")
-- unimpaired
vim.keymap.set("n", "]q", ":cnext<cr>", { silent = true })
vim.keymap.set("n", "[q", ":cprev<cr>", { silent = true })
vim.keymap.set("n", "]l", ":lnext<cr>", { silent = true })
vim.keymap.set("n", "[l", ":lprev<cr>", { silent = true })
vim.keymap.set("n", "[b", ":bprevious<cr>", { silent = true })
vim.keymap.set("n", "]b", ":bnext<cr>", { silent = true })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
-- sort
vim.keymap.set("x", "gs", ":sort<cr>")
-- keep selection on indent
vim.keymap.set("x", ">", ">gv")
vim.keymap.set("x", "<", "<gv")
-- don't copy on visual mode
vim.keymap.set("x", "p", [["_dp]])
vim.keymap.set("x", "P", [["_dP]])
-- smart search
vim.keymap.set("c", "<c-p>", "<up>")
vim.keymap.set("c", "<c-n>", "<down>")
-- replace
vim.keymap.set("x", "<c-s>", '"sy/<c-r>s')
-- find files / buffers
vim.keymap.set("n", "<c-p>", ":find ")
vim.keymap.set("n", "<c-n>", ":b ")
-- leader
vim.keymap.set("n", "<space><space>", "<c-^>", { desc = "Switch buffers" })
vim.keymap.set("n", "<leader>q", "<cmd>copen<cr>", { desc = "Open quickfix" })
vim.keymap.set("n", "<leader>l", "<cmd>lopen<cr>", { desc = "Open locallist" })
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<cr>", { desc = "Make file executable" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show error" })
vim.keymap.set("n", "<leader>w", vim.diagnostic.setqflist, { desc = "Quickfix errors" })
vim.keymap.set("n", "<leader>%", 'ggVG"+y', { desc = "Yank file to clipboard" })
vim.keymap.set("n", "<leader>s", grep_current_word, { desc = "Grep cword" })
vim.keymap.set("n", "<leader>/", grep_user_input, { desc = "Grep input" })
vim.keymap.set("x", "<leader>y", '"+y', { desc = "Yank to clipboard" })

--- PLUGINS ---
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    -- Comments
    { "tpope/vim-commentary" },
    -- Change/add/remove surroundings
    { "tpope/vim-surround" },
    -- Repeat plugin commands
    { "tpope/vim-repeat" },
    -- Better netrw
    { "tpope/vim-vinegar" },
    -- Additional text objects
    { "wellle/targets.vim" },
    -- Replace motion with register
    { "vim-scripts/ReplaceWithRegister" },
    -- Visualize undo tree
    {
        "mbbill/undotree",
        keys = { { "<leader>u", "<cmd>UndotreeToggle<cr>" } },
    },
    -- Zen mode
    {
        "folke/zen-mode.nvim",
        opts = {
            window = { width = 125 },
            on_open = function()
                vim.cmd("cabbrev <buffer> q let b:quitting = 1 <bar> q")
                vim.cmd("cabbrev <buffer> wq let b:quitting = 1 <bar> wq")
            end,
            on_close = function()
                if vim.b.quitting == 1 then
                    ---@diagnostic disable-next-line: inject-field
                    vim.b.quitting = 0
                    vim.cmd("q")
                end
            end,
        },
        keys = { { "<leader>z", "<cmd>ZenMode<cr>" } },
    },
    -- Gruvbox
    {
        "sainnhe/gruvbox-material",
        priority = 1000,
        config = function()
            vim.cmd([[
            let g:gruvbox_material_better_performance = 1
            let g:gruvbox_material_disable_italic_comment = 1
            colorscheme gruvbox-material
        ]])
        end,
    },
    -- Copilot
    {
        "github/copilot.vim",
        config = function()
            vim.g.copilot_no_tab_map = true
            vim.keymap.set("i", "<C-space>", 'copilot#Accept("\\<CR>")', {
                expr = true,
                replace_keycodes = false,
            })
        end,
    },
    -- Fuzzy searching
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        keys = {
            { "<c-p>",     "<cmd>Telescope find_files theme=dropdown previewer=false<cr>", desc = "Find files" },
            { "<c-n>",     "<cmd>Telescope buffers theme=dropdown previewer=false<cr>",    desc = "Find buffers" },
            { "<leader>/", "<cmd>Telescope live_grep<cr>",                                 desc = "Live grep" },
            { "<leader>o", "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",             desc = "LSP symbols" },
            { "<leader>?", "<cmd>Telescope keymaps<cr>",                                   desc = "Keymaps" },
        },
    },
    -- Git integration
    {
        "tpope/vim-fugitive",
        keys = {
            { "<leader>ga", "<cmd>Git add %<cr>", desc = "Git add file" },
            { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git blame" },
            { "<leader>gl", "<cmd>0GlLog --<cr>", desc = "Git log buffer" },
            { "<leader>gm", ":GMove <c-r>%",      desc = "Git move" },
        },
    },
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
                untracked = { text = "┆" },
            },
            on_attach = function(bufnr)
                local gs = package.loaded.gitsigns
                vim.keymap.set("n", "]h", gs.next_hunk, { buffer = bufnr, desc = "Next hunk" })
                vim.keymap.set("n", "[h", gs.prev_hunk, { buffer = bufnr, desc = "Previous hunk" })
                vim.keymap.set("n", "<leader>gs", gs.stage_hunk, { buffer = bufnr, desc = "Stage hunk" })
                vim.keymap.set("n", "<leader>gr", gs.reset_hunk, { buffer = bufnr, desc = "Reset hunk" })
                vim.keymap.set("n", "<leader>gp", gs.preview_hunk, { buffer = bufnr, desc = "Preview hunk" })
                vim.keymap.set("n", "<leader>gd", gs.diffthis, { buffer = bufnr, desc = "Diff buffer" })
            end,
        },
    },
    -- Lualine
    {
        "nvim-lualine/lualine.nvim",
        opts = {
            options = {
                icons_enabled = false,
                section_separators = "",
                component_separators = "",
            },
            sections = {
                lualine_a = {},
                lualine_b = {},
                lualine_c = { { "filename", path = 1 }, "diagnostics" },
                lualine_x = { "branch", "diff", "filetype", "location" },
                lualine_y = {},
                lualine_z = {},
            },
        },
    },
    -- Autocomplete
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-cmdline",
            "hrsh7th/cmp-path",
            "rcarriga/cmp-dap",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            local cmp = require("cmp")
            cmp.setup({
                enabled = function()
                    return vim.api.nvim_buf_get_option(0, "buftype") ~= "prompt" or require("cmp_dap").is_dap_buffer()
                end,
                snippet = {
                    expand = function(args)
                        require("luasnip").lsp_expand(args.body)
                    end,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<tab>"] = {
                        i = cmp.config.disable,
                        c = cmp.config.disable,
                    },
                    ["<cr>"] = cmp.mapping.confirm({ select = false }),
                    ["<c-u>"] = cmp.mapping.scroll_docs(-4),
                    ["<c-d>"] = cmp.mapping.scroll_docs(4),
                    ["<c-e>"] = cmp.mapping.abort(),
                }),
                sources = cmp.config.sources({
                    { name = "nvim_lsp", index = 1 },
                    { name = "buffer",   index = 2 },
                    { name = "path",     index = 2 },
                }),
            })
            cmp.setup.cmdline({ "/", "?" }, {
                mapping = cmp.mapping.preset.cmdline(),
                sources = { name = "buffer" },
            })
            cmp.setup.cmdline(":", {
                mapping = cmp.mapping.preset.cmdline({
                    ["<c-n>"] = cmp.config.disable,
                    ["<c-p>"] = cmp.config.disable,
                }),
                sources = cmp.config.sources({
                    { name = "path",    index = 1 },
                    { name = "cmdline", index = 2 },
                }),
            })
            cmp.setup.filetype({ "dap-repl", "dapui_watches", "dapui_hover" }, { sources = { { name = "dap" } } })
        end,
    },
    -- Treesitter
    {
        "nvim-treesitter/nvim-treesitter",
        dependencies = { "nvim-treesitter/nvim-treesitter-textobjects" },
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = { "bash", "html", "lua", "markdown", "vim", "vimdoc", "python", "rust" },
                highlight = { enable = true },
                textobjects = {
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["aa"] = "@parameter.outer",
                            ["ia"] = "@parameter.inner",
                            ["af"] = "@function.outer",
                            ["if"] = "@function.inner",
                            ["ac"] = "@class.outer",
                            ["ic"] = "@class.inner",
                            ["as"] = "@struct.outer",
                            ["is"] = "@struct.inner",
                            ["at"] = "@type.outer",
                            ["it"] = "@type.inner",
                        },
                    },
                },
            })
        end,
    },
    -- Language servers, formatting, linting, debugging.
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "Saecki/crates.nvim" },
            { "simrat39/rust-tools.nvim" },
            { "folke/neodev.nvim",                opts = {} },
            { "williamboman/mason.nvim",          opts = {} },
            { "williamboman/mason-lspconfig.nvim" },
        },
        config = function()
            -- Setup LSP attach autocmd
            vim.api.nvim_create_autocmd("LspAttach", {
                group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
                callback = function(event)
                    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = event.buf })
                    vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = event.buf })
                    vim.keymap.set("n", "gR", vim.lsp.buf.references, { buffer = event.buf })
                    vim.keymap.set("n", "gI", vim.lsp.buf.implementation, { buffer = event.buf })
                    vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, { buffer = event.buf })
                    vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = event.buf })
                    vim.keymap.set("n", "<leader>r", vim.lsp.buf.rename, { buffer = event.buf })
                    vim.keymap.set("n", "<leader>a", vim.lsp.buf.code_action, { buffer = event.buf })
                    vim.keymap.set({ "i", "n" }, "<c-k>", vim.lsp.buf.signature_help, { buffer = event.buf })
                end,
            })
            -- Advertise nvim-cmp and luasnip capabilities
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())

            -- Define LSP server configurations
            local lsp_servers = {
                ["docker-compose-language-service"] = { ["name"] = "docker_compose_language_service", ["config"] = {} },
                ["dockerfile-language-server"] = { ["name"] = "dockerls", ["config"] = {} },
                ["html-lsp"] = { ["name"] = "html", ["config"] = {} },
                ["lua-language-server"] = { ["name"] = "lua_ls", ["config"] = {} },
                ["ruff-lsp"] = {
                    ["name"] = "ruff_lsp",
                    ["config"] = {
                        on_attach = function(client, buffer)
                            client.server_capabilities.hoverProvider = false
                        end,
                    },
                },
                ["rust-analyzer"] = {
                    ["name"] = "rust_analyzer",
                    ["config"] = {
                        inlay_hints = {
                            only_current_line = true,
                            parameter_hints_prefix = "",
                            other_hints_prefix = "=> ",
                            max_len_align = true,
                        },
                    },
                },
                ["pyright"] = { ["name"] = "pyright", ["config"] = {} },
                ["taplo"] = { ["name"] = "taplo", ["config"] = {} },
                ["typescript-language-server"] = { ["name"] = "tsserver", ["config"] = {} },
                ["yaml-language-server"] = { ["name"] = "yamlls", ["config"] = {} },
            }

            -- Setup LSP servers
            local lspconfig = require("lspconfig")
            for _, info in pairs(lsp_servers) do
                lspconfig[info.name].setup({ info.config })
            end

            -- Install formatters, linters and debuggers, servers...
            vim.api.nvim_create_user_command("MasonInstallTools", function()
                vim.cmd("MasonInstall " .. table.concat({
                    "buf",
                    "debugpy",
                    "delve",
                    "stylua",
                    "eslint_d",
                    "gofumpt",
                    "goimports",
                    "markdownlint",
                    "prettierd",
                    "shellcheck",
                    "shfmt",
                }, " "))
                vim.cmd("MasonInstall " .. table.concat(vim.tbl_keys(lsp_servers), " "))
            end, {})
        end,
    },
    -- Formatting
    {
        "stevearc/conform.nvim",
        opts = {
            notify_on_error = false,
            formatters_by_ft = {
                bash = { "shfmt" },
                go = { "goimports", "gofumpt" },
                javascript = { "prettierd" },
                javascriptreact = { "prettierd" },
                json = { "prettierd" },
                lua = { "stylua" },
                markdown = { "prettierd" },
                proto = { "buf" },
                protobuf = { "buf" },
                sh = { "shfmt" },
                typescript = { "prettierd" },
                typescriptreact = { "prettierd" },
                yaml = { "prettierd" },
            },
        },
        config = function()
            vim.g.autoformatting = true
            vim.api.nvim_create_user_command("ToggleAutoFormat", function(args)
                vim.g.autoformatting = not vim.g.autoformatting
                print("Setting autoformatting to: " .. tostring(vim.g.disable_autoformat))
            end, {})
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = "*",
                callback = function(args)
                    if not vim.g.autoformatting then
                        return
                    end
                    -- If python file try to call organizeImports
                    if vim.bo.filetype == "python" then
                        vim.lsp.buf.code_action({
                            context = { only = { "source.organizeImports" } },
                            apply = true,
                        })
                    end
                    require("conform").format({ bufnr = args.buf, lsp_fallback = true })
                end,
            })
            vim.keymap.set(
                "n",
                "<leader>f",
                "<cmd>lua require('conform').format { lsp_fallback=true }<cr>",
                { desc = "Format file" }
            )
        end,
    },
    -- Linting
    {
        "mfussenegger/nvim-lint",
        config = function()
            require("lint").linters_by_ft = {
                markdown = { "markdownlint" },
                sh = { "shellcheck" },
                bash = { "shellcheck" },
                typescript = { "eslint_d" },
            }
            vim.api.nvim_create_autocmd({ "BufWritePost" }, {
                callback = function()
                    require("lint").try_lint()
                end,
            })
        end,
    },
    -- Debugging
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            { "rcarriga/nvim-dap-ui" },
            { "theHamsta/nvim-dap-virtual-text", opts = {} },
            {
                "mfussenegger/nvim-dap-python",
                ft = "python",
                config = function()
                    require("dap-python").setup("~/.local/share/nvim/mason/packages/debugpy/venv/bin/python")
                    require("dap-python").test_runner = "pytest"
                    vim.keymap.set("n", "<leader>dt", require("dap-python").test_method)
                end,
            },
        },
        config = function()
            local dap = require("dap")
            vim.fn.sign_define("DapStopped", { text = ">>", texthl = "", linehl = "", numhl = "" })
            dap.defaults.fallback.exception_breakpoints = { "raised" }

            vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: Start/Continue" })
            vim.keymap.set("n", "<leader>dn", dap.step_over, { desc = "Debug: Step Over" })
            vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
            vim.keymap.set("n", "<leader>do", dap.step_out, { desc = "Debug: Step Out" })
            vim.keymap.set("n", "<leader>db", dap.step_back, { desc = "Debug: Step Back" })
            vim.keymap.set("n", "<leader>dr", dap.run_to_cursor, { desc = "Debug: Run to cursor" })
            vim.keymap.set("n", "<leader>dR", dap.restart, { desc = "Debug: Restart" })
            vim.keymap.set("n", "<leader>dk", dap.close, { desc = "Debug: Kill" })
            vim.keymap.set("n", "<leader>dd", dap.repl.toggle, { desc = "Debug: Toggle REPL" })
            vim.keymap.set("n", "<leader>b", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
            vim.keymap.set("n", "<leader>B", function()
                dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
            end, { desc = "Debug: Set Breakpoint" })

            local dapui = require("dapui")
            dapui.setup({})
            vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI." })
            vim.keymap.set("n", "<leader>dw", function()
                dapui.float_element("watches")
            end, { desc = "Debug: Watches" })
            vim.keymap.set("n", "<leader>ds", function()
                dapui.float_element("scopes")
            end, { desc = "Debug: Scope" })
            -- dap.listeners.before.event_initialized["dapui_config"] = dapui.open
            dap.listeners.before.event_terminated["dapui_config"] = dapui.close
            dap.listeners.before.event_exited["dapui_config"] = dapui.close
        end,
    },
}, {})
