local M = {
  plugins = {
    -- Deps
    {'nvim-lua/plenary.nvim'},
    {'vim-denops/denops.vim'},

    -- Core
    {'windwp/nvim-autopairs'},
    {'creativenull/projectlocal-vim'},
    {'editorconfig/editorconfig-vim'},
    {'kevinhwang91/nvim-bqf'},
    {'kyazdani42/nvim-tree.lua'},
    {'tpope/vim-abolish', opt = true},
    {'tpope/vim-surround', opt = true},
    {'tpope/vim-repeat', opt = true},
  },
}

function M.before()
  vim.g.projectlocal = { projectConfig = '.vim/init.lua' }

  -- nvim-tree.lua Config
  -- ---
  vim.g.nvim_tree_show_icons = {
    git = 0,
    folders = 1,
    files = 1,
  }
end

function M.after()
  local nmap = require('cnull.core.keymap').nmap

  -- nvim-tree.lua Config
  -- ---
  require('nvim-tree').setup({
    view = {
      side = 'right',
    },
  })

  nmap('<Leader>ff', '<Cmd>NvimTreeToggle<CR>')

  -- nvim-autopairs Config
  -- ---
  require('nvim-autopairs').setup({})
end

return M
