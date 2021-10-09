local M = {
  plugins = {
    {'mattn/emmet-vim', opt = true},
  },
}

if _G.CNull.config.snippets == 'ultisnips' then
  table.insert(M.plugins, {'SirVer/ultisnips'})
  table.insert(M.plugins, {'honza/vim-snippets'})
elseif _G.CNull.config.snippets == 'vsnip' then
  table.insert(M.plugins, {'hrsh7th/vim-vsnip'})
  table.insert(M.plugins, {'rafamadriz/friendly-snippets'})
elseif _G.CNull.config.snippets == 'luasnip' then
  table.insert(M.plugins, {'L3MON4D3/LuaSnip'})
  table.insert(M.plugins, {'rafamadriz/friendly-snippets'})
end

function M.before()
  -- UltiSnips Config
  vim.g.UltiSnipsExpandTrigger = '<C-q>.'
  vim.g.UltiSnipsJumpForwardTrigger = '<C-j>'
  vim.g.UltiSnipsJumpBackwardTrigger = '<C-k>'

  -- emmet-vim Config
  vim.g.user_emmet_leader_key = '<C-q>'
  vim.g.user_emmet_install_global = 0
end

return M
