local M = {
  plugins = {
    {'SirVer/ultisnips', opt = true},
    {'honza/vim-snippets', opt = true},
    {'mattn/emmet-vim', opt = true},
  },
}

function M.before()
  -- ultisnips Config
  vim.g.UltiSnipsExpandTrigger = '<C-q>.'
  vim.g.UltiSnipsJumpForwardTrigger = '<C-j>'
  vim.g.UltiSnipsJumpBackwardTrigger = '<C-k>'

  -- emmet-vim Config
  vim.g.user_emmet_leader_key = '<C-q>'
  vim.g.user_emmet_install_global = 0
end

return M
