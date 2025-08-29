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
