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
    -- { 'Shougo/ddc-sorter_rank' },
    -- { 'matsui54/ddc-matcher_fuzzy' },
    -- { 'Shougo/ddc-around' },
    -- { 'Shougo/ddc-nvim-lsp' },
    -- { 'matsui54/ddc-ultisnips' },
    -- { 'matsui54/ddc-nvim-lsp-doc' },
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
