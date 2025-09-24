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
	"jsonc",
	"json",
	"just",
	"sql",
	"toml",
	"tsx",
	"xml",
	"yml",
})

nvim_treesitter.update()
