local M = {
  plugins = {},
}

if _G.CNull.config.autocompletion == 'ddc' then
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
    pcall(require, 'cnull.plugins.autocompletions.ddc')
  end
elseif _G.CNull.config.autocompletion == 'coq' then
  M.plugins = {
    {'ms-jpq/coq_nvim', opt = true, branch = 'coq'},
    {'ms-jpq/coq.artifacts', opt = true, branch = 'artifacts'},
  }
  M.after = function()
    pcall(require, 'cnull.plugins.autocompletions.coq')
  end
elseif _G.CNull.config.autocompletion == 'completion' then
  M.plugins = {
    {'nvim-lua/completion-nvim'},
  }
  M.before = function()
    local success, completion = pcall(require, 'cnull.plugins.autocompletions.completion')
    if success then
      completion.before()
    end
  end
  M.after = function()
    local success, completion = pcall(require, 'cnull.plugins.autocompletions.completion')
    if success then
      completion.after()
    end
  end
else
  M.plugins = {
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-nvim-lsp'},
  }

  if _G.CNull.config.snippets == 'ultisnips' then
    table.insert(M.plugins, {'quangnguyen30192/cmp-nvim-ultisnips'})
  elseif _G.CNull.config.snippets == 'vsnip' then
    table.insert(M.plugins, {'hrsh7th/cmp-vsnip'})
  elseif _G.CNull.config.snippets == 'luasnip' then
    table.insert(M.plugins, {'saadparwaiz1/cmp_luasnip'})
  end

  M.after = function()
    pcall(require, 'cnull.plugins.autocompletions.cmp')
  end
end

return M
