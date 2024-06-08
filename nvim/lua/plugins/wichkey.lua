return { -- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	opts = {
		window = {
			border = "single",
			margin = { 0, 0, 0, 0 }, -- top, right , bottom, left
			padding = { 0, 0, 1, 0 },
		},
	},
	config = function(_, opts) -- This is the function that runs, AFTER loading
		require("which-key").setup(opts)

		-- Document existing key chains
		require("which-key").register({
			["<leader>c"] = { name = "[c]ode", _ = "which_key_ignore" },
			["<leader>G"] = { name = "[G]it Repository", _ = "which_key_ignore" },
			["<leader>g"] = { name = "[g]it basics", _ = "which_key_ignore" },
			["<leader><tab>"] = { name = "[Tab]Tabs", _ = "which_key_ignore" },
			["<leader>s"] = { name = "[s]earch", _ = "which_key_ignore" },
			["<leader>W"] = { name = "[W]orkspace", _ = "which_key_ignore" },
			["<leader>w"] = { name = "[w]indow", _ = "which_key_ignore" },
			["<leader>t"] = { name = "[t]erminal", _ = "which_key_ignore" },
			["<leader>b"] = { name = "[b]uffers", _ = "which_key_ignore" },
			["<leader>l"] = { name = "[l]ists", _ = "which_key_ignore" },
			["<leader>u"] = { name = "[u]ser interface", _ = "which_key_ignore" },
			["<leader>x"] = { name = "[x]-Trouble", _ = "which_key_ignore" },
		})
		-- visual mode
		-- require("which-key").register({
		-- 	["<leader>h"] = { "Git [H]unk" },
		-- }, { mode = "v" })
	end,
}
