return { -- Useful plugin to show you pending keybinds.
	"folke/which-key.nvim",
	event = "VimEnter", -- Sets the loading event to 'VimEnter'
	config = function() -- This is the function that runs, AFTER loading
		require("which-key").setup()

		-- Document existing key chains
		require("which-key").register({
			-- form kickstart
			-- ["<leader>c"] = { name = "[C]ode", _ = "which_key_ignore" },
			-- ["<leader>d"] = { name = "[D]ocument", _ = "which_key_ignore" },
			-- ["<leader>r"] = { name = "[R]ename", _ = "which_key_ignore" },
			-- ["<leader>s"] = { name = "[S]earch", _ = "which_key_ignore" },
			-- ["<leader>w"] = { name = "[W]orkspace", _ = "which_key_ignore" },
			-- ["<leader>t"] = { name = "[T]oggle", _ = "which_key_ignore" },
			-- ["<leader>h"] = { name = "Git [H]unk", _ = "which_key_ignore" },
			-- from me
			["<leader>c"] = { name = "[c]ode", _ = "which_key_ignore" },
			["<leader>d"] = { name = "[d]ocument", _ = "which_key_ignore" },
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
