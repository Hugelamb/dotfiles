-- Neovim config (single file)
-- Author: HugeLamb
-- Last change: 29/10/2024
-- install lazy plugin manager 
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({"git", "clone", "--filter=blob:none", lazyrepo, "--branch=stable", lazypath})
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({{"Failed to clone lazy.nvim:\n", "ErrorMsg"}, {out, "WarningMsg"},
                           {"\nPress any key to exit..."}}, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

---------------
--- plugins ---
---------------
require("lazy").setup({ -- colorscheme plugin here
{
    "rebelot/kanagawa.nvim",
},

{
    "rktjmp/lush.nvim",
},
-- lsp-config
{
    "neovim/nvim-lspconfig",
    config = function()
        util = require "lspconfig/util"

        local capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
        capabilities.textDocument.completion.completionItem.snippetSupport = true

        require("lspconfig").gopls.setup({
            capabilities = capabilities,
            flags = {
                debounce_text_changes = 200
            },
            settings = {
                gopls = {
                    usePlaceholders = true,
                    gofumpt = true,
                    analyses = {
                        nilness = true,
                        unusedparams = true,
                        unusedwrite = true,
                        useany = true
                    },
                    codelenses = {
                        gc_details = false,
                        generate = true,
                        regenerate_cgo = true,
                        run_govulncheck = true,
                        test = true,
                        tidy = true,
                        upgrade_dependency = true,
                        vendor = true
                    },
                    experimentalPostfixCompletions = true,
                    completeUnimported = true,
                    staticcheck = true,
                    directoryFilters = {"-.git", "-node_modules"},
                    semanticTokens = true,
                    hints = {
                        assignVariableTypes = true,
                        compositeLiteralFields = true,
                        compositeLiteralTypes = true,
                        constantValues = true,
                        functionTypeParameters = true,
                        parameterNames = true,
                        rangeVariableTypes = true
                    }
                }
            }
        })
    end
},

-- Highlight, edit, and navigate code
{
    'nvim-treesitter/nvim-treesitter',
    dependencies = {'nvim-treesitter/nvim-treesitter-textobjects'},
    build = ":TSUpdate",
    config = function()
        require('nvim-treesitter.configs').setup({
            ensure_installed = {'vim', 'lua', 'python','c','cpp','yaml', 'vimdoc', 'bash', 'devicetree', 'json', 'markdown', 'markdown_inline','comment'},
            indent = {
                enable = true
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<space>", -- maps in normal mode to init the node/scope selection with space
                    node_incremental = "<space>", -- increment to the upper named parent
                    node_decremental = "<bs>", -- decrement to the previous node
                    scope_incremental = "<tab>" -- increment to the upper scope (as defined in locals.scm)
                }
            },
            autopairs = {
                enable = true
            },
            highlight = {
                enable = true,

                -- Disable slow treesitter highlight for large files
                disable = function(lang, buf)
                    local max_filesize = 100 * 1024 -- 100 KB
                    local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stats and stats.size > max_filesize then
                        return true
                    end
                end,

                -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                -- Using this option may slow down your editor, and you may see some duplicate highlights.
                -- Instead of true it can also be a list of languages
                additional_vim_regex_highlighting = false
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
                        ["iB"] = "@block.inner",
                        ["aB"] = "@block.outer"
                    }
                },
                move = {
                    enable = true,
                    set_jumps = true, -- whether to set jumps in the jumplist
                    goto_next_start = {
                        [']]'] = '@function.outer'
                    },
                    goto_next_end = {
                        [']['] = '@function.outer'
                    },
                    goto_previous_start = {
                        ['[['] = '@function.outer'
                    },
                    goto_previous_end = {
                        ['[]'] = '@function.outer'
                    }
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ['<leader>sn'] = '@parameter.inner'
                    },
                    swap_previous = {
                        ['<leader>sp'] = '@parameter.inner'
                    }
                }
            }
        })
    end
},

{
    "windwp/nvim-autopairs",
    config = function()
        require("nvim-autopairs").setup {
            check_ts = true
        }
    end
},

-- Lua Snippets
{
    "L3MON4D3/LuaSnip",
    dependencies = {"rafamadriz/friendly-snippets"},
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
    end
}, -- autocompletion
{
    "hrsh7th/nvim-cmp",
    dependencies = {"hrsh7th/cmp-nvim-lsp", "hrsh7th/cmp-buffer", "L3MON4D3/LuaSnip", "saadparwaiz1/cmp_luasnip",
                    "onsails/lspkind-nvim"},
    config = function()
        local cmp = require("cmp")
        local luasnip = require("luasnip")
        local lspkind = require("lspkind")
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")

        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

        luasnip.config.setup {}

        local has_words_before = function()
            unpack = unpack or table.unpack
            local line, col = unpack(vim.api.nvim_win_get_cursor(0))
            return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
        end

        require('cmp').setup({
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end
            },
            formatting = {
                format = lspkind.cmp_format {
                    with_text = true,
                    menu = {
                        buffer = "[Buffer]",
                        nvim_lsp = "[LSP]",
                        nvim_lua = "[Lua]"
                    }
                }
            },
            mapping = cmp.mapping.preset.insert {
                ['<C-n>'] = cmp.mapping.select_next_item(),
                ['<C-p>'] = cmp.mapping.select_prev_item(),
                ['<C-d>'] = cmp.mapping.scroll_docs(-4),
                ['<C-f>'] = cmp.mapping.scroll_docs(4),
                ['<CR>'] = cmp.mapping.confirm {
                    select = true
                },
                ['<Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_next_item()
                    elseif luasnip.expand_or_locally_jumpable() then
                        luasnip.expand_or_jump()
                    elseif has_words_before() then
                        cmp.complete()
                    else
                        fallback()
                    end
                end, {'i', 's'}),
                ['<S-Tab>'] = cmp.mapping(function(fallback)
                    if cmp.visible() then
                        cmp.select_prev_item()
                    elseif luasnip.jumpable(-1) then
                        luasnip.jump(-1)
                    else
                        fallback()
                    end
                end, {'i', 's'})
            },
            -- don't auto select item
            preselect = cmp.PreselectMode.None,
            window = {
                documentation = cmp.config.window.bordered()
            },
            view = {
                entries = {
                    name = "custom",
                    selection_order = "near_cursor"
                }
            },
            confirm_opts = {
                behavior = cmp.ConfirmBehavior.Insert
            },
            sources = {{
                name = 'nvim_lsp'
            }, {
                name = "luasnip",
                keyword_length = 2
            }, {
                name = "buffer",
                keyword_length = 5
            }}
        })
    end
},
-- VimTeX
{
	"lervag/vimtex",
	lazy = false,
	init = function()
		-- VimTeX config goes here
            -- vim.g.vimtex_view_method = "zathura"
            if vim.fn.has('win32') or (vim.fn.has('unix') and vin.fn.exists('$WSLENV')) then
                vim.g.vimtex_view_method = 'mupdf'
                vim.g.vimtex_view_mupdf_exe = 'mupdf-gl.exe'
                vim.g.vimtex_view_general_viewer = 'mupdf-gl.exe'
            end
	end,
	config = function()
		vim.g.vimtex_quickfix_method = vim.fn.executable("pplatex") == 1 and "pplatex" or "latexlog"
	end,
},

})

----------------
--- SETTINGS ---
----------------


-- disable netrw at the very start of our init.lua, because nvim-tree is being used?
-- clipboard settings
-- vim.g.clipboard = "unnamedplus"

in_wsl = os.getenv('WSL_DISTRO_NAME') ~= nil

if in_wsl then
    vim.g.clipboard = {
        name = 'wsl clipboard',
        copy =  { ["+"] = { "clip.exe" },   ["*"] = { "clip.exe" } },
        paste = { ["+"] = { "nvim_paste" }, ["*"] = { "nvim_paste" } },
        cache_enabled = true
    }
end
-- errors flash screen rather than emitting beep
vim.opt.visualbell = true

-- set default tabwidth at 4 spaces
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.tabstop = 4 
vim.opt.softtabstop = 0

-- indent new line at same level as previous
vim.opt.autoindent = false 

-- use 24-bit colours instead of 256
vim.opt.termguicolors = true
-- source custom colortheme 
vim.cmd.source("$HOME/.config/nvim/colors/custom_dark.vim")
vim.cmd.source("$HOME/.config/nvim/colors/solarized.vim")
local subneon = require "subneon"
vim.cmd("colorscheme kanagawa")

-- activate custom colortheme
vim.cmd.colorscheme("custom_dark")

vim.opt.number = true 		-- Show line numbers
vim.opt.showmatch = true 	-- Highlight matching parenthesis

vim.opt.clipboard = "unnamedplus" 	-- Copy/paste to system clipboard
vim.opt.swapfile = false 		-- Don't use swapfiles
vim.opt.ignorecase = true 		-- Search case insensitive ...
vim.opt.smartcase = true 		-- ... unless it begins with upper case

-------------------
--- Keymappings ---
-------------------

-- Set mapleader to allow for extra mappings and combinations
vim.g.mapleader = ';'
-- Set localleader to decrease risk of clashing keybinds
vim.g.maplocalleader = ' '

-- Fast saving
vim.keymap.set('n','<Leader>w', ':write!<CR>')
vim.keymap.set('n','<Leader>q',':wq<CR>',{ silent = true})
vim.keymap.set('n','<Leader>qq', ':q!<CR>', { silent = true })
-- change background between light and dark
function bg_switch()
    local bg = vim.o.background 
    local style_bg = "light" and "dark"
    print(bg)
    if bg ~= "light" then
        vim.o.background = "light"
    else 
        vim.o.background = "dark"
    end
        
end
-- Map background inversion 
vim.keymap.set('n','<Leader>b',bg_switch)

-- Create secondary mapping for accessing VISUAL-BLOCK mode, as ctrl+v 
-- is system paste from clipboard on windows.
vim.keymap.set('n','<Leader>v','<C-v><CR>')
-- Code folding options
-- shortcuts: zR = open all folds,zM = close all, za=toggle at cursor
vim.opt.foldmethod = 'indent'     -- using expr() fold type https://neovim.io/doc/user/fold.html#_expr for details
-- vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"    -- use treesitter for fold truth sourcing
-- vim.opt.foldcolumn = "0"     -- when set to 0, will not display a column with fold information
vim.opt.foldtext = ""           -- First line of fold will be syntax highlighted
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 1      -- Only top level folds are open when file is initially loaded
vim.opt.foldnestmax = 4         -- Maximum number of nested folds that can be created
           ---------------------
--- Window Manipulation Macros ---
           ---------------------
vim.opt.splitright = true       -- enforce that windows split right by default
--- Opening/Splitting Macros
vim.keymap.set('n','<Localleader>b',':browse vsplit  . <CR>')     -- vert split and open current directory tree
vim.keymap.set('n','<Localleader>vv',':vs<CR>',{ silent = true})     -- vertical split command
vim.keymap.set('n','<Localleader>hv',':sp<CR>',{silent = true})      -- horizontal split command
--- Closing and Hiding Macros
vim.keymap.set('n','<Localleader>q','<C-w><C-q>')           -- close current window, as long as there are no unsaved buffer changes/is not last window for buffer
vim.keymap.set('n','<Localleader>h','<:hide<CR>',{ silent = true})  -- hide current window
vim.keymap.set('n','<Localleader>ho','<:hide only<CR>')              -- hide all except current window 

           ---------------------
--- Window Navigation Macros ---
           ---------------------
vim.keymap.set('n','<Localleader><A-j>','<C-w>h')               -- move to window on left
vim.keymap.set('n','<Localleader><A-k>','<C-w>j')               -- move to window below
vim.keymap.set('n','<Localleader><A-i>','<C-w>k')               -- move to window above
vim.keymap.set('n','<Localleader><A-l>','<C-w>l')               -- move to window on right
           ----------
--- VimTeX Macros ---
           ----------
-- Compile Continously (mapping to call :VimtexCompile)
vim.keymap.set('n','<LocalLeader>vc',':VimtexCompile')

