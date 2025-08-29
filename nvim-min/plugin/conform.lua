require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua", lsp_format = "fallback" },

		-- Conform will run multiple formatters sequentially
		python = { "ruff", lsp_format = "prefer" },

		-- Conform will run the first available formatter
		javascript = { "prettierd", lsp_format = "fallback" },

		typescript = { "prettierd", lsp_format = "fallback" },

		go = { lsp_format = "prefer" },

		cpp = { "clang-format", lsp_format = "never" },
	},

	format_on_save = false,
})

vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

vim.keymap.set("n", "<leader>f", require("conform").format, { desc = "Format buffer [lsp]" })
