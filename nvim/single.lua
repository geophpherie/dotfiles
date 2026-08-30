-- =============================================================================
-- Leader
-- =============================================================================

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- =============================================================================
-- Options
-- =============================================================================

vim.g.have_nerd_font = true

vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartindent = true
vim.opt.winborder = "rounded"
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.completeopt = { "menu", "menuone", "noselect", "noinsert", "fuzzy", "popup" }
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true
vim.opt.softtabstop = 2
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.cursorline = true
vim.opt.scrolloff = 10
vim.opt.list = false
vim.opt.confirm = true
vim.opt.statusline =
	"%y %<%f %h%w%m%r %=%{% &showcmdloc == 'statusline' ? '%-10.S ' : '' %}%{% exists('b:keymap_name') ? '<'..b:keymap_name..'> ' : '' %}%{% &busy > 0 ? '◐ ' : '' %}%(%{luaeval('(package.loaded[''vim.diagnostic''] and vim.diagnostic.status()) or '''' ')} %)%{% &ruler ? ( &rulerformat == '' ? '%-14.(%l,%c%V%) %P' : &rulerformat ) : '' %}"

-- Defer clipboard sync until after startup (see :help 'clipboard')
vim.api.nvim_create_autocmd("UIEnter", {
	callback = function()
		vim.opt.clipboard = "unnamedplus"
	end,
})

-- =============================================================================
-- Keymaps (general)
-- =============================================================================

-- Scrolling / search
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result" })
vim.keymap.set("n", "<Esc>", vim.cmd.nohlsearch, { desc = "Clear search highlight" })

-- Windows
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Focus left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Focus lower window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Focus upper window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Focus right window" })

-- LSP
-- Built into Neovim 0.12 (no config needed):
--   gra       code action (normal + visual)
--   grn       rename symbol
--   grr       find references
--   gri       go to implementation
--   grt       go to type definition
--   grx       run codelens
--   gO        document symbols
--   <C-S>     signature help (insert mode)
--   K         hover docs (mapped per-buffer when LSP attaches)
--   [d / ]d   previous / next diagnostic
--   <C-W>d    diagnostic float under cursor
-- Custom maps below (classic bindings Neovim does not set by default):
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })

-- Diagnostics ([d / ]d / <C-W>d are built-in; these are extras)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic under cursor" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics → location list" })
vim.keymap.set("n", "<leader>l", vim.diagnostic.setqflist, { desc = "Diagnostics → quickfix list" })

-- =============================================================================
-- Autocmds
-- =============================================================================

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight yanked text",
	callback = function()
		vim.hl.on_yank()
	end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.env.*",
	callback = function()
		vim.bo.filetype = "sh"
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local buf = args.buf
		local ft = args.match

		pcall(vim.treesitter.start, buf)
		vim.bo[buf].indentexpr = "v:lua.require('nvim-treesitter').indentexpr()"

		if ft == "python" or ft == "go" then
			vim.bo[buf].shiftwidth = 4
			vim.bo[buf].tabstop = 4
			vim.bo[buf].softtabstop = 4
		elseif ft == "visual3d" then
			vim.bo[buf].commentstring = "! %s"
			local opts = { buf = buf }
			vim.api.nvim_set_option_value("foldmethod", "expr", opts)
			vim.api.nvim_set_option_value("foldexpr", "v:lua.vim.lsp.foldexpr()", opts)
			vim.api.nvim_set_option_value("foldlevel", 99, opts)
		end
	end,
})

-- =============================================================================
-- Plugins
-- =============================================================================

vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	{ src = "https://github.com/ibhagwan/fzf-lua" },
	{ src = "https://github.com/neovim/nvim-lspconfig" },
	{
		src = "https://github.com/nvim-neo-tree/neo-tree.nvim",
		version = vim.version.range("3"),
	},
	{ src = "https://github.com/stevearc/conform.nvim.git" },
	{ src = "https://github.com/Saghen/blink.cmp", version = vim.version.range("1.*") },
	{ src = "https://github.com/nvim-tree/nvim-web-devicons" },
	{ src = "https://github.com/nvim-lua/plenary.nvim" },
	{ src = "https://github.com/MunifTanjim/nui.nvim" },
	{ src = "https://github.com/folke/tokyonight.nvim" },
})

-- =============================================================================
-- Plugin setup
-- =============================================================================

-- treesitter ------------------------------------------------------------------

local nvim_treesitter = require("nvim-treesitter")
nvim_treesitter.install({
	"python",
	"go",
	"lua",
	"javascript",
	"typescript",
	"html",
	"markdown",
	"vim",
	"vimdoc",
	"bash",
	"markdown_inline",
	"diff",
	"c",
	"css",
	"gitignore",
	"gomod",
	"gosum",
	"json",
	"just",
	"sql",
	"toml",
	"tsx",
	"jsx",
	"xml",
	"yaml",
})
nvim_treesitter.update()

-- colorscheme -----------------------------------------------------------------

require("tokyonight").setup({
	style = "night",
	transparent = true,
	styles = {
		sidebars = "transparent",
		floats = "transparent",
	},
})
vim.cmd.colorscheme("tokyonight")

-- conform (formatting) --------------------------------------------------------

local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		python = { lsp_format = "prefer" },

		javascript = { "oxfmt" },
		javascriptreact = { "oxfmt" },

		typescript = { "oxfmt" },
		typescriptreact = { "oxfmt" },

		go = { lsp_format = "prefer" },

		sql = { "sql_formatter", lsp_format = "never" },

		lua = { "stylua", lsp_format = "fallback" },
	},

	format_on_save = false,
})
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
vim.keymap.set("n", "<leader>f", conform.format, { desc = "Format buffer" })

-- blink.cmp (completion) ----------------------------------------------------
-- Menu is manual-only (auto_show = false). Use <C-Space> to open completions.

require("blink.cmp").setup({
	signature = {
		enabled = true,
		window = {
			show_documentation = false,
		},
		trigger = {
			enabled = false,
		},
	},
	completion = {
		menu = {
			auto_show = false,
			draw = {
				columns = {
					{ "kind_icon", "kind", gap = 2 },
					{ "label", "label_description", gap = 1 },
					{ "source_name" },
				},
			},
		},
	},
})

-- fzf-lua (fuzzy finder) ------------------------------------------------------

local fzf_lua = require("fzf-lua")
fzf_lua.setup()

vim.keymap.set("n", "<leader><leader>", fzf_lua.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>sf", fzf_lua.files, { desc = "Files" })
vim.keymap.set("n", "<leader>sg", fzf_lua.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>sw", fzf_lua.grep_cword, { desc = "Grep word under cursor" })
vim.keymap.set("n", "<leader>s.", fzf_lua.oldfiles, { desc = "Recent files" })
vim.keymap.set("n", "<leader>sr", fzf_lua.resume, { desc = "Resume last search" })
vim.keymap.set("n", "<leader>sh", fzf_lua.helptags, { desc = "Help tags" })
vim.keymap.set("n", "<leader>sk", fzf_lua.keymaps, { desc = "Keymaps" })
vim.keymap.set("n", "<leader>ss", fzf_lua.builtin, { desc = "Fzf-lua builtins" })
vim.keymap.set("n", "<leader>sn", function()
	fzf_lua.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Neovim config files" })

-- fzf + LSP (fuzzy picker when there are multiple results)
vim.keymap.set("n", "<leader>sD", fzf_lua.lsp_definitions, { desc = "LSP definitions" })
vim.keymap.set("n", "<leader>sR", fzf_lua.lsp_references, { desc = "LSP references" })
vim.keymap.set("n", "<leader>sI", fzf_lua.lsp_implementations, { desc = "LSP implementations" })
vim.keymap.set("n", "<leader>sC", fzf_lua.lsp_code_actions, { desc = "LSP code actions" })
vim.keymap.set("n", "<leader>sdd", fzf_lua.lsp_document_diagnostics, { desc = "Document diagnostics" })
vim.keymap.set("n", "<leader>swd", fzf_lua.lsp_workspace_diagnostics, { desc = "Workspace diagnostics" })

-- neo-tree (file explorer) ----------------------------------------------------

require("neo-tree").setup({
	close_if_last_window = true,
	window = { position = "float" },
})
vim.keymap.set("n", "<leader>tt", ":Neotree toggle<CR>", { silent = true, desc = "Toggle file tree" })

-- =============================================================================
-- LSP
-- =============================================================================

vim.lsp.enable({
	"lua_ls",
	"gopls",
	"ruff",
	"ts_ls",
	"ty",
	"v3d_ls",
	"tailwindcss",
	"oxfmt",
	"oxlint",
})

vim.lsp.config("lua_ls", {
	settings = {
		Lua = {
			runtime = { version = "LuaJIT" },
			workspace = {
				checkThirdParty = false,
				library = { vim.env.VIMRUNTIME },
			},
		},
	},
})

-- =============================================================================
-- Diagnostics
-- =============================================================================

vim.diagnostic.config({
	severity_sort = true,
	float = { border = "rounded", source = "if_many" },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	},
	virtual_text = {
		source = true,
		spacing = 2,
	},
	virtual_lines = false,
	update_in_insert = true,
})

-- =============================================================================
-- Filetypes
-- =============================================================================

vim.filetype.add({
	extension = {
		v3s = "visual3d",
		v3m = "visual3d",
		mdh = "visual3d",
	},
})
