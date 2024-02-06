--[[
 THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT
 `lvim` is the global options object
]]

-- NOTE: I use lunarvim main branch, which also requires neovim nightly.
--    This config probably will not work with lunarvim stable.

-- vim options
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.expandtab = true          -- convert tabs to spaces
vim.opt.relativenumber = true
vim.opt.clipboard = "unnamedplus" -- allows neovim to access the system clipboard
vim.opt.conceallevel = 0          -- so that `` is visible in markdown files
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.colorcolumn = "99999"     -- fixes indentline for now
vim.opt.ignorecase = true         -- ignore case in search patterns
vim.opt.termguicolors = true      -- set term gui colors (most terminals support this)
vim.opt.wrap = true               -- wrap lines
vim.opt.spell = false
vim.opt.spelllang = "en"
vim.opt.background = "light"

-- general
lvim.log.level = "info"
lvim.format_on_save = {
  enabled = true,
}

-- formatters
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
  { name = "shfmt" },
}
-- keymappings <https://www.lunarvim.org/docs/master/configuration/keybindings>
lvim.leader = "space"
-- leader mappings
lvim.builtin.which_key.mappings["R"] = {
  "<cmd>RnvimrToggle<CR>", "Ranger"
}
lvim.builtin.which_key.mappings["r"] = {
  "<cmd>lua require('telescope').extensions.recent_files.pick()<CR>", "Recent Files"
}
-- non-leader keymappings
lvim.keys.normal_mode["<tab>"] = ":BufferLineCycleNext<CR>"
lvim.keys.normal_mode["<S-tab>"] = ":BufferLineCyclePrev<CR>"
lvim.keys.normal_mode["<BS>"] = ":b#<CR>"

-- lsp remappings
lvim.lsp.buffer_mappings.normal_mode['gd'] = nil
lvim.lsp.buffer_mappings.normal_mode['gi'] = nil
lvim.keys.normal_mode["gd"] = "<cmd>lua require('goto-preview').goto_preview_definition()<CR>"
lvim.keys.normal_mode["gi"] = "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>"

lvim.builtin.which_key.mappings["t"] = {
  name = "Diagnostics",
  t = { "<cmd>TroubleToggle<cr>", "trouble" },
  w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
  d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
  q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
  l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
  r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}

-- Change theme
lvim.colorscheme = "zenbones"
-- colorscheme selection here is normally automatic, but for zenbones I like something with more contrast
lvim.builtin.lualine.options.theme = "zenburned"

-- Various options
lvim.builtin.lualine.style = "lvim"
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.dap.active = true

-- dropping down concurrency here because we get throttled by outbound load balancing
lvim.lazy.opts.concurrency = 1

-- Automatically install missing parsers when entering buffer
lvim.builtin.treesitter.auto_install = true

-- Always installed on startup, useful for parsers without a strict filetype
lvim.builtin.treesitter.ensure_installed = { "comment", "markdown_inline", "regex" }

-- LSP settings <https://www.lunarvim.org/docs/master/configuration/language-features/language-servers>
-- disable automatic installation of servers
lvim.lsp.automatic_servers_installation = false
lvim.lsp.installer.setup.automatic_installation = false

-- Autocommands <https://www.lunarvim.org/docs/master/configuration/autocommands>
lvim.autocommands = { -- :h autocmd-events
  {
    "FileType",
    {
      pattern = "zsh",
      callback = function()
        -- let treesitter use bash highlight for zsh files as well
        require("nvim-treesitter.highlight").attach(0, "bash")
      end,
    }
  },
}

-- Additional Plugins <https://www.lunarvim.org/docs/master/configuration/plugins>
lvim.plugins = require 'user.plugins'

-- requires vim-matchup plugin
lvim.builtin.treesitter.matchup.enable = true

-- Custom language tools to integrate with Vim LSP via null-ls (e.g. fish_indent for fish shell scripts)
require 'user.null-ls-custom'
