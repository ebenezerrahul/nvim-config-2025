return {
	"dmtrKovalenko/fff.nvim",
	build = function()
		-- downloads a prebuilt binary or falls back to cargo build
		require("fff.download").download_or_build_binary()
	end,
	-- for nixos:
	-- build = "nix run .#release",
	opts = {
		-- debug = {
		-- 	enabled = true,
		-- 	show_scores = true,
		-- },
		layout = {
			prompt_position = "top",
			anchor = "bottom",
			width = 1,
			height = 0.5,
		},
		prompt = ">",
	},
	lazy = false, -- the plugin lazy-initialises itself
	keys = {
		{
			"<leader><leader>",
			function()
				require("fff").find_files()
			end,
			desc = "FFFind files",
		},
		{
			"<C-t>",
			function()
				require("fff").find_files()
			end,
			desc = "FFFind files",
		},
		{
			"<leader>sg",
			function()
				require("fff").live_grep()
			end,
			desc = "LiFFFe grep",
		},
		{
			"<leader>sG",
			function()
				require("fff").live_grep({ grep = { modes = { "fuzzy", "plain" } } })
			end,
			desc = "Live fffuzy grep",
		},
		{
			"<leader>sw",
			function()
				require("fff").live_grep({ query = vim.fn.expand("<cword>") })
			end,
			desc = "Search current word",
		},
		{
			"<leader>sn",
			function()
				require("fff").find_files_in_dir(vim.fn.stdpath("config"))
			end,
		},
	},
}
