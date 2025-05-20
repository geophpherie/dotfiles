return {
	cmd = { vim.fn.stdpath('data') .. "/mason/bin/typescript-language-server", '--stdio' },
	filetypes = { "javascript", "typescript" },
	root_markers = { "tsconfig.json", "jsconfig.json", "package.json", ".git" }
}
