local M = {
  plugins = {
    -- nvim-cmp
    { 'hrsh7th/nvim-cmp' },
    { 'hrsh7th/cmp-nvim-lsp' },
    { 'saadparwaiz1/cmp_luasnip' },

    -- completion-nvim
    -- {'nvim-lua/completion-nvim'},

    -- coq_nvim
    -- {'ms-jpq/coq_nvim', opt = true, branch = 'coq'},
    -- {'ms-jpq/coq.artifacts', opt = true, branch = 'artifacts'},

    -- ddc.vim
    -- {'Shougo/ddc.vim'},
    -- {'Shougo/ddc-sorter_rank'},
    -- {'matsui54/ddc-matcher_fuzzy'},
    -- {'Shougo/ddc-around'},
    -- {'Shougo/ddc-nvim-lsp'},
    -- {'matsui54/ddc-ultisnips'},
    -- {'matsui54/ddc-nvim-lsp-doc'},
  },
}

function M.before()
  -- completion-nvim Config
  -- ---
  -- require('cnull.plugins.autocompletions.completion').before()
end

function M.after()
  -- nvim-cmp Config
  -- ---
  require('cnull.plugins.autocompletions.cmp')

  -- completion-nvim Config
  -- ---
  -- require('cnull.plugins.autocompletions.completion').after()

  -- coq_nvim Config
  -- ---
  -- require('cnull.plugins.autocompletions.coq')

  -- ddc.vim Config
  -- ---
  -- require('cnull.plugins.autocompletions.ddc')
end

return M
