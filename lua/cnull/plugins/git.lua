local M = {
  plugins = {
    { 'lewis6991/gitsigns.nvim' },
    { 'TimUntersberger/neogit' },
    { 'tpope/vim-fugitive' },
  },
}

function M.after()
  -- gitsigns.nvim Config
  -- ---
  require('gitsigns').setup()

  -- neogit Config
  -- ---
  require('neogit').setup({})
end

return M
