-- Deprecated: https://github.com/nvim-lua/completion-nvim/commit/87b0f86da3dffef63b42845049c648b5d90f1c4d
local M = {}

M.before = function()
  vim.g.completion_confirm_key = '\\<C-y>'
  vim.g.completion_trigger_on_delete = true
  vim.g.completion_matching_strategy_list = {'fuzzy', 'substring'}
  vim.g.completion_matching_ignore_case = true
end

M.after = function()
  local imap = require('cnull.core.keymap').imap
  local augroup = require('cnull.core.event').augroup

  augroup('completion_nvim_user_events', {
    {
      event = {'BufEnter', 'BufNew'},
      exec = function()
        imap('<Tab>', 'pumvisible() ? "\\<C-y>" : "\\<Tab>"', { expr = true })
        imap('<C-Space>', '<Cmd>lua require"completion".triggerCompletion()<CR>')
      end,
    },
  })
end

return M
