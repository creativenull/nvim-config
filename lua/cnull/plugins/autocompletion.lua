local M = {
  plugins = {
    -- nvim-compe
    -- {'hrsh7th/nvim-compe'},

    -- nvim-cmp
    -- {'hrsh7th/nvim-cmp'},
    -- {'hrsh7th/cmp-buffer'},
    -- {'hrsh7th/cmp-nvim-lsp'},
    -- {'quangnguyen30192/cmp-nvim-ultisnips'},

    -- coq_nvim
    -- {'ms-jpq/coq_nvim', opt = true, branch = 'coq'},
    -- {'ms-jpq/coq.artifacts', opt = true, branch = 'artifacts'},

    -- ddc.vim
    {'Shougo/ddc.vim'},
    {'Shougo/ddc-sorter_rank'},
    {'matsui54/ddc-matcher_fuzzy'},
    {'Shougo/ddc-around'},
    {'Shougo/ddc-nvim-lsp'},
    {'matsui54/ddc-ultisnips'},
    {'matsui54/ddc-nvim-lsp-doc'},
  },
}

function M.after()
  -- ddc.vim Config
  -- ---
  require('cnull.plugins.autocompletions.ddc')

  -- compe.nvim Config
  -- ---
  -- require('cnull.plugins.autocompletions.compe')

  -- nvim-cmp Config
  -- ---
  -- require('cnull.plugins.autocompletions.cmp')

  local function get_termcode(str)
    return vim.api.nvim_replace_termcodes(str, true, true, true)
  end

  function _G.tab_completion(default_key)
    if vim.fn.pumvisible() == 1 then
      if vim.call('UltiSnips#CanExpandSnippet') == 1 then
        return get_termcode('<C-r>=UltiSnips#ExpandSnippet()<CR>')
      else
        return get_termcode('<C-y>')
      end
    else
      return get_termcode(default_key)
    end
  end

  local imap = require('cnull.core.keymap').imap
  imap('<Tab>', [[v:lua.tab_completion('<Tab>')]], { expr = true })
end

return M
