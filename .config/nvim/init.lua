
local opts = { noremap = true, silent = true }

--//////////////////////////////////////////////////////////////////////// 
-- Bootstrap lazy.nvim
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not (vim.uv or vim.loop).fs_stat(lazypath) then
		local lazyrepo = "https://github.com/folke/lazy.nvim.git"
		local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
		if vim.v.shell_error ~= 0 then
			vim.api.nvim_echo({
				{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
				{ out, "WarningMsg" },
				{ "\nPress any key to exit..." },
			}, true, {})
			vim.fn.getchar()
			os.exit(1)
		end
	end
	vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Lazy
require("lazy").setup({
  spec = {

    -- Colorscheme
		{
			"ellisonleao/gruvbox.nvim"
		},

    -- Telescope
    {
      "nvim-telescope/telescope.nvim",
      version = "*",
      dependencies = { "nvim-lua/plenary.nvim" },
			keys = {
				{ "<leader><leader>", "<cmd>Telescope find_files<CR>", opts },
				{ "<leader>g", "<cmd>Telescope live_grep<CR>", opts },
				{ "<leader>fo", "<cmd>Telescope oldfiles<CR>", opts },
			},
    },

		-- Treesitter
		{
			"nvim-treesitter/nvim-treesitter",
			version = "*",
			lazy = false,
			build = ":TSUpdate",
			config = function()
				require("nvim-treesitter.configs").setup {
					ensure_installed = { "c", "cpp", "lua" },
					highlight = { enable = true },
				}
			end,
		},

		-- Completion
		{
			"hrsh7th/nvim-cmp",
			dependencies = {
				"hrsh7th/cmp-nvim-lsp",
				"hrsh7th/cmp-buffer",
				"hrsh7th/cmp-path",
				"L3MON4D3/LuaSnip", -- optional, for snippets
			},
			config = function()
				local cmp = require("cmp")
				cmp.setup({
					mapping = cmp.mapping.preset.insert({
						["<C-Space>"] = cmp.mapping.complete(),
						["<CR>"] = cmp.mapping.confirm({ select = true }),
						["<Tab>"] = cmp.mapping.confirm({ select = true }),
					}),
					sources = cmp.config.sources({
						{ name = "nvim_lsp" },
						{ name = "buffer" },
						{ name = "path" },
					}),
				})
			end,
		},

    -- FileTree
    {
      "nvim-tree/nvim-tree.lua",
      version = "*",
      dependencies = { "nvim-tree/nvim-web-devicons", },
			keys = {
				{ "<A-e>", ":NvimTreeToggle<CR>", opts },
				{ "<A-d>", ":NvimTreeFocus<CR>", opts },
			},
			config = function()
				require("nvim-tree").setup {
					update_cwd = true,
				}
			end,
    },

		--Autopairs
		{
			"windwp/nvim-autopairs",
      version = "*",
			event = "InsertEnter",
			config = true
		},

		--BufferLine
		{
			"akinsho/bufferline.nvim",
			version = "*",
			dependencies = "nvim-tree/nvim-web-devicons",
			lazy = false,
			keys = {
				{ "<C-1>", ":BufferLineGoToBuffer 1<CR>", opts },
				{ "<C-2>", ":BufferLineGoToBuffer 2<CR>", opts },
				{ "<C-3>", ":BufferLineGoToBuffer 3<CR>", opts },
				{ "<C-4>", ":BufferLineGoToBuffer 4<CR>", opts },
				{ "<C-5>", ":BufferLineGoToBuffer 5<CR>", opts },
				{ "<C-6>", ":BufferLineGoToBuffer 6<CR>", opts },
				{ "<C-7>", ":BufferLineGoToBuffer 7<CR>", opts },
				{ "<C-8>", ":BufferLineGoToBuffer 8<CR>", opts },
				{ "<C-9>", ":BufferLineGoToBuffer -1<CR>", opts },
				{ "<C-PageUp>", ":BufferLineCyclePrev<CR>", opts },
				{ "<C-PageDown>", ":BufferLineCycleNext<CR>", opts },
				{ "<A-,>", ":BufferLineMovePrev<CR>", opts },
				{ "<A-.>", ":BufferLineMoveNext<CR>", opts },
				{ "<A-n>", ":BufferLineCloseLeft<CR>", opts },
				{ "<A-m>", ":BufferLineCloseRight<CR>", opts },
				{ "<leader>co", ":BufferLineCloseOthers<CR>", opts },
			},
			config = function()
				require("bufferline").setup {
					options = {
						tab_size = 10,
						--mode = "tabs",
						offsets = {
							{
								filetype = "NvimTree",
								text = "File Explorer",
								highlight = "Directory",
								separator = true,
							},
						},
					},
				}
			end
		},

		-- Status bar
		{
			"nvim-lualine/lualine.nvim",
			version = "*",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			config = function()
				require('lualine').setup({
					sections = {
						lualine_a = { 'mode' },
						lualine_b = { 'branch', 'diff', 'diagnostics' },
						lualine_c = {
							'filename',
						},
						lualine_x = { 'encoding', 'fileformat', 'filetype' },
						lualine_y = { 'progress' },
						lualine_z = { 'location', 'showcmd' },
					},
				})
			end,
		},

		-- open terminal
		{
			'akinsho/toggleterm.nvim',
			version = "*",
			config = true,
			keys = {
				{ "<A-3>", ":ToggleTerm<CR>", opts },
			}
		},
  },
})

vim.opt.cursorline = false

--////////////////////////////////////////////////////////////////////////
--Configuration
	vim.opt.clipboard:append("unnamedplus") --make to use system clipboard
	vim.cmd.colorscheme("gruvbox")	 	--scheme
	vim.opt.guifont = "Cascadia Code" 	--font

-- color number line 
	vim.opt.nu = true												--do use numbers
	vim.opt.relativenumber = true						--do use relative numbers
	vim.api.nvim_set_hl(0, "LineNrAbove", { fg="#616161", bold=true })
	vim.api.nvim_set_hl(0, "LineNr", { fg="#de9f1d", bold=true })
	vim.api.nvim_set_hl(0, "LineNrBelow", { fg="#616161", bold=true })

-- visual
	vim.opt.tabstop = 2						--how spaces \t takes
	vim.opt.shiftwidth = 2				--how many spaces you move by << and >>
	vim.opt.expandtab = false			--tab inserts \t
	vim.opt.showmode = false			--don't show mode
	vim.opt.showtabline = 2				--always show window tabs
	vim.opt.signcolumn = "no" 		-- maybe TODO: "number"
	vim.opt.termguicolors = true	--24bit color instead of 16bit
	vim.opt.cmdheight = 1       	--height of status bar
	vim.opt.scrolloff = 4     		--how many lines to edges to start scrolling window
	vim.opt.hlsearch = true  			-- highlight last searched word

-- editor behavior
	vim.opt.incsearch = true
	vim.opt.inccommand = "split"
	vim.opt.ignorecase = true
	vim.opt.smartcase = true

-- nvim behavior
	vim.opt.wrap = false
	vim.swapfile = false
	vim.backup = false

--////////////////////////////////////////////////////////////////////////
--Hotkeys

-- scrollign
	vim.keymap.set({"n","v"}, "<A-j>", "20<C-e>", opts)
	vim.keymap.set({"n","v"}, "<A-k>", "20<C-y>", opts)
	vim.keymap.set({"i"}, 		"<A-j>", "<Esc>20<C-e>a", opts)
	vim.keymap.set({"i"}, 		"<A-k>", "<Esc>20<C-y>a", opts)

-- remap vimkeys
	vim.keymap.set("n", "<C-d>", "<C-d>zz", opts) -- move down with centered cursor
	vim.keymap.set("n", "<C-u>", "<C-u>zz", opts) -- move up with centered cursor
	vim.keymap.set("n", "x", '"_x', opts) 				-- delete character without coping into clipboard
	vim.keymap.set("n", "Y", "yy", opts) 					-- makes it better

-- helpers
	vim.keymap.set("n", "<C-c>", ":nohl<CR>", opts) -- turn off searched highlight
	vim.keymap.set("n", "<leader>:pv<CR>", vim.cmd.Ex)

	--vim.keymap.set("n", "<leader>q", ":q<CR>", opts)  -- close window
	vim.keymap.set("n", "<leader>q", ":bd<CR>", opts)  -- close window
	vim.keymap.set("i", "<C-BS>", "<C-W>", opts)			-- Insert-mode Ctrl+Backspace → delete previous word
	vim.keymap.set("i", "<C-Del>", "<Esc>ldei", opts) -- Insert-mode Ctrl+Delete → delete next word

-- jump to empty lines
	vim.keymap.set({"n","v"}, "<A-l>", "}", opts)
	vim.keymap.set({"n","v"}, "<A-;>", "{", opts)
	vim.keymap.set("i", "<A-l>", "<Esc>}", opts)
	vim.keymap.set("i", "<A-;>", "<Esc>{", opts)

-- move lines
	vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", opts)
	vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", opts)

--////////////////////////////////////////////////////////////////////////
-- Move Between Windows
	vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
	vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
	vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
	vim.keymap.set("n", "<C-l>", "<C-w>l", opts)

	-- nvim :Ex
	vim.api.nvim_create_autocmd("FileType", {
		pattern = "netrw",
		callback = function()
			local opts = { noremap = true, silent = true }
			vim.keymap.set("n", "<C-h>", "<C-w>h", opts)
			vim.keymap.set("n", "<C-j>", "<C-w>j", opts)
			vim.keymap.set("n", "<C-k>", "<C-w>k", opts)
			vim.keymap.set("n", "<C-l>", "<C-w>l", opts)
		end,
	})

	-- move windows
	vim.keymap.set("n", "<leader>H", "<C-w>H", opts)
	vim.keymap.set("n", "<leader>J", "<C-w>J", opts)
	vim.keymap.set("n", "<leader>K", "<C-w>K", opts)
	vim.keymap.set("n", "<leader>L", "<C-w>L", opts)

	-- split window
	vim.keymap.set("n", "<leader>h", ":vsp<CR>", opts)
	vim.keymap.set("n", "<leader>l", ":vsp<CR><C-w>l", opts)
	vim.keymap.set("n", "<leader>k", ":sp<CR>", opts)
	vim.keymap.set("n", "<leader>j", ":sp<CR><C-w>j", opts)

