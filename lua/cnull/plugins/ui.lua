local M = {
  plugins = {
    -- UI Deps
    { 'kyazdani42/nvim-web-devicons' },

    -- UI Plugins
    { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
    { 'nvim-treesitter/nvim-treesitter-refactor' },
    { 'code-biscuits/nvim-biscuits' },
    { 'lukas-reineke/indent-blankline.nvim', opt = true },
    { 'akinsho/bufferline.nvim' },
    { 'folke/todo-comments.nvim', opt = true },
    { 'plasticboy/vim-markdown', opt = true },
  },
}

function M.after()
  require('cnull.plugins.ui.treesitter')
  require('cnull.plugins.ui.biscuits')
  require('cnull.plugins.ui.bufferline')
end

return M
