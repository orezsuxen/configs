return { -- zen mode
	"folke/zen-mode.nvim",
	-- event = "VeryLazy",
	opts = {
		window = {
			backdrop = 0.8, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
			-- height and width can be:
			-- * an absolute number of cells when > 1
			-- * a percentage of the width / height of the editor when <= 1
			-- * a function that returns the width or the height
			width = 110, -- width of the Zen window
			height = 1.0, -- height of the Zen window
			-- by default, no options are changed for the Zen window
			-- uncomment any of the options below, or add other vim.wo options you want to apply
			options = {
				-- signcolumn = "no", -- disable signcolumn
				-- number = true, -- disable number column
				-- relativenumber = false, -- disable relative numbers
				-- cursorline = false, -- disable cursorline
				-- cursorcolumn = false, -- disable cursor column
				-- foldcolumn = "0", -- disable fold column
				-- list = false, -- disable whitespace characters
				-- callback where you can add custom code when the Zen window opens
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			},
		},
		-- plugins = {
		--   -- disable some global vim options (vim.o...)
		--   -- comment the lines to not apply the options
		--   options = {
		--     enabled = true,
		--     -- ruler = true, -- disables the ruler text in the cmd line area
		--     -- showcmd = true, -- disables the command in the last line of the screen
		--   },
		-- },
	},
	config = function(_, opts)
		require("zen-mode").setup(opts)
		vim.keymap.set("n", "<leader>z", "<cmd>ZenMode<cr>", { desc = "[Z]en Mone" })
	end,
}
