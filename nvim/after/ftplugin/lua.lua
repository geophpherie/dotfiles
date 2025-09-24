vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2

vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
vim.treesitter.start()
