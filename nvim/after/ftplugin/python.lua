vim.opt_local.shiftwidth = 4
vim.opt_local.tabstop = 4

vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
vim.treesitter.start()



