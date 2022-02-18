local M = {
  plugins = {
    -- Deps
    { 'nvim-lua/plenary.nvim' },
    { 'vim-denops/denops.vim' },

    -- Core
    { 'creativenull/projectlocal-vim' },
    { 'editorconfig/editorconfig-vim' },
    { 'windwp/nvim-autopairs' },
    { 'kevinhwang91/nvim-bqf' },
    { 'tpope/vim-abolish', opt = true },
    { 'tpope/vim-surround', opt = true },
    { 'tpope/vim-repeat', opt = true },
  },
}

function M.after()
  -- nvim-autopairs Config
  -- ---
  require('nvim-autopairs').setup({})
end

return M
