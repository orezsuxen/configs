return {
	"folke/trouble.nvim",
	-- branch = "dev", -- IMPORTANT!
	-- keys = {
	-- 	{
	-- 		"<leader>xx",
	-- 		"<cmd>Trouble diagnostics toggle<cr>",
	-- 		desc = "Diagnostics (Trouble)",
	-- 	},
	-- 	{
	-- 		"<leader>xX",
	-- 		"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
	-- 		desc = "Buffer Diagnostics (Trouble)",
	-- 	},
	-- 	{
	-- 		"<leader>xs",
	-- 		"<cmd>Trouble symbols toggle focus=false<cr>",
	-- 		desc = "Symbols (Trouble)",
	-- 	},
	-- 	{
	-- 		"<leader>xl",
	-- 		"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	-- 		desc = "LSP Definitions / references / ... (Trouble)",
	-- 	},
	-- 	{
	-- 		"<leader>xL",
	-- 		"<cmd>Trouble loclist toggle<cr>",
	-- 		desc = "Location List (Trouble)",
	-- 	},
	-- 	{
	-- 		"<leader>xQ",
	-- 		"<cmd>Trouble qflist toggle<cr>",
	-- 		desc = "Quickfix List (Trouble)",
	-- 	},
	-- },
	opts = {}, -- for default options, refer to the configuration section for custom setup.
	config = function(_, opts)
		require("trouble").setup(opts)

		vim.keymap.set("n", "<leader>xx", function()
			require("trouble").toggle()
		end, { desc = "toggle trouble" })

		vim.keymap.set("n", "<leader>xw", function()
			require("trouble").toggle("workspace_diagnostics")
		end, { desc = "workspace diagnostics" })

		vim.keymap.set("n", "<leader>xd", function()
			require("trouble").toggle("document_diagnostics")
		end, { desc = "document diagnostics" })

		vim.keymap.set("n", "<leader>xq", function()
			require("trouble").toggle("quickfix")
		end, { desc = "quickfix" })

		vim.keymap.set("n", "<leader>xl", function()
			require("trouble").toggle("loclist")
		end, { desc = "loclist" })

		vim.keymap.set("n", "<leader>xR", function()
			require("trouble").toggle("lsp_references")
		end, { desc = "lsp reference" })

		vim.keymap.set("n", "<leader>xR", function()
			require("trouble").toggle("symbols")
		end, { desc = "lsp reference" })
	end,
}
