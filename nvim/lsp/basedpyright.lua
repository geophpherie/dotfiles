return {
	cmd = { vim.fn.stdpath('data') .. "/mason/bin/basedpyright-langserver", "--stdio" },
	filetypes = { "python" }
}
