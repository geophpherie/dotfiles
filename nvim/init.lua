-- global table
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.g.have_nerd_font = true

-- options table
-- `:help vim.o` or `:help option-list`
vim.o.mouse = "a"
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 10
vim.o.showmode = false
vim.o.signcolumn = "yes"
vim.o.smartindent = true
vim.o.winborder = "rounded"

vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })
vim.keymap.set("n", "<leader>of", vim.diagnostic.open_float, { desc = "[O]pen diagnostic [f]loat window" })


vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move focus to the Left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move focus to the Right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move focus to the Lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move focus to the Upper window" })
vim.keymap.set("n", "<space>%", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")
vim.keymap.set("n", "<C-Up>", "<C-W><C-+>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<C-W><C-->", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<C-W><C-<>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<C-W><C->>", { desc = "Increase window width" })


vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

require('config.lazy')

vim.lsp.enable('luals')
vim.lsp.enable('gopls')

vim.cmd.colorscheme("tokyonight")

vim.diagnostic.config({
  severity_sort = true,
  float = { border = 'rounded', source = 'if_many' },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  },
  virtual_text = {
    source = 'if_many',
    spacing = 2,
  },
  -- virtual_lines = true,
  update_in_insert=true

})
