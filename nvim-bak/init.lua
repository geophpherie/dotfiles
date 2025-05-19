--:source % (this current file)
-- :lua ... (selection, :lua (run) - runs selection

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)

-- bugfix https://github.com/neovim/neovim/issues/31675
vim.hl = vim.highlight

-- global table
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true
vim.g.netrw_liststyle = 3
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- options table
vim.opt.breakindent = true
vim.opt.cursorline = true
vim.opt.expandtab = true
vim.opt.hlsearch = true
vim.opt.inccommand = "split"
vim.opt.ignorecase = true
vim.opt.list = false
vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "_" }
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.scrolloff = 10
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.termguicolors = true
vim.opt.timeoutlen = 300
vim.opt.undofile = true
vim.opt.updatetime = 250

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<space>%", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the Left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the Right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the Lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the Upper window" })

vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the Upper window" })

vim.keymap.set("n", "<C-Up>", "<C-W><C-+>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<C-W><C-->", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<C-W><C-<>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<C-W><C->>", { desc = "Increase window width" })

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})
-- dots are folder paths
-- folders need to be top level lua on runtime path
require("config.lazy")

vim.cmd.colorscheme("tokyonight")
