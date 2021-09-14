-- Choose one: ddc, coq, cmp (default)
local autocompletion = 'cmp'

local M = {
  plugins = {},
}

if autocompletion == 'ddc' then
  M.plugins = {
    {'Shougo/ddc.vim'},
    {'Shougo/ddc-sorter_rank'},
    {'matsui54/ddc-matcher_fuzzy'},
    {'Shougo/ddc-around'},
    {'Shougo/ddc-nvim-lsp'},
    {'matsui54/ddc-ultisnips'},
    {'matsui54/ddc-nvim-lsp-doc'},
  }
  M.after = function()
    require('cnull.plugins.autocompletions.ddc')
  end
elseif autocompletion == 'coq' then
  M.plugins = {
    {'ms-jpq/coq_nvim', opt = true, branch = 'coq'},
    {'ms-jpq/coq.artifacts', opt = true, branch = 'artifacts'},
  }
  M.after = function()
    require('cnull.plugins.autocompletions.coq')
  end
else
  M.plugins = {
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'quangnguyen30192/cmp-nvim-ultisnips'},
  }
  M.after = function()
    require('cnull.plugins.autocompletions.cmp')
  end
end

return M
