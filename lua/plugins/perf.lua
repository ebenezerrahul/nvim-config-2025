return {
	"t-troebst/perfanno.nvim",
	config = function()
		require("perfanno").setup({
			-- List of highlights that will be used to highlight hot lines (or nil to disable).
			line_highlights = require("perfanno.util").make_bg_highlights(nil, "#FF0000", 10),
			-- Highlight used for virtual text annotations (or nil to disable virtual text).
			vt_highlight = require("perfanno.util").make_fg_highlight("#FF0000"),

			-- Annotation formats that can be cycled between via :PerfCycleFormat
			--   "percent" controls whether percentages or absolute counts should be displayed
			--   "format" is the format string that will be used to display counts / percentages
			--   "minimum" is the minimum value below which lines will not be annotated
			-- Note: this also controls what shows up in the telescope finders
			formats = {
				{ percent = true, format = "%.2f%%", minimum = 0.5 },
				{ percent = false, format = "%d", minimum = 1 },
			},

			-- Automatically annotate files after :PerfLoadFlat and :PerfLoadCallGraph
			annotate_after_load = true,
			-- Automatically annotate newly opened buffers if information is available
			annotate_on_open = true,

			-- Options for telescope-based hottest line finders
			telescope = {
				-- Enable if possible, otherwise the plugin will fall back to fzf-lua or vim.ui.select
				enabled = pcall(require, "telescope"),
				-- Annotate inside of the preview window
				annotate = true,
			},

			-- Options for fzf-lua hottest line finders
			fzf_lua = {
				-- Enable if possible, otherwise the plugin will fall back to vim.ui.select
				enabled = pcall(require, "fzf-lua"),
				-- Annotate inside of the preview window
				annotate = true,
			},

			-- Node type patterns used to find the function that surrounds the cursor
			ts_function_patterns = {
				-- These should work for most languages (at least those used with perf)
				default = {
					"function",
					"method",
				},
				-- Otherwise you can add patterns for specific languages like:
				-- weirdlang = {
				--     "weirdfunc",
				-- }
			},

			-- Overwrite the default behaviour of prompting for the path to the perf.data with a custom function that returns
			-- the path to a perf file as string.
			get_path_callback = nil,

			-- Enable per-thread profiling support for multi-threaded applications
			-- When enabled, you can select which thread(s) to profile when loading perf.data
			thread_support = true,
		})

		local telescope = require("telescope")
		local actions = telescope.extensions.perfanno.actions
		telescope.setup({
			extensions = {
				perfanno = {
					-- Special mappings in the telescope finders
					mappings = {
						["i"] = {
							-- Find hottest callers of selected entry
							["<C-h>"] = actions.hottest_callers,
							-- Find hottest callees of selected entry
							["<C-l>"] = actions.hottest_callees,
						},

						["n"] = {
							["gu"] = actions.hottest_callers,
							["gd"] = actions.hottest_callees,
						},
					},
				},
			},
		})
	end,
}
