local M = {
  plugins = {
    -- nvim-cmp
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'hrsh7th/cmp-vsnip' },
    { 'hrsh7th/cmp-buffer' },

    -- coq_nvim
    -- { 'ms-jpq/coq_nvim', branch = 'coq' },
    -- { 'ms-jpq/coq.artifacts', branch = 'artifacts' },

    -- ddc.vim
    -- { 'Shougo/ddc.vim' },
    -- { 'tani/ddc-fuzzy' },
    -- { 'matsui54/denops-popup-preview.vim' },
    -- { 'Shougo/ddc-nvim-lsp' },
    -- { 'Shougo/ddc-around' },
    -- { 'matsui54/ddc-buffer' },
    -- { 'hrsh7th/vim-vsnip-integ' },
  },
}

function M.before()
  -- coq_nvim Config
  -- ---
  -- require('cnull.plugins.autocompletions.coq').before()
end

function M.after()
  -- nvim-cmp Config
  -- ---
  require('cnull.plugins.autocompletions.cmp')

  -- coq_nvim Config
  -- ---
  -- require('cnull.plugins.autocompletions.coq').after()

  -- ddc.vim Config
  -- ---
  -- require('cnull.plugins.autocompletions.ddc')
end

return M
