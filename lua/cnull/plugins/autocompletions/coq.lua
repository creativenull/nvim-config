local M = {}

local config = {
  ['auto_start'] = 'shut-up',
  ['keymap.recommended'] = false,
  ['keymap.jump_to_mark'] = '<C-j>',
  ['keymap.manual_complete'] = '<C-Space>',
  ['display.pum.fast_close'] = false,
  ['display.preview.border'] = 'single',
  ['clients.tmux.enabled'] = false,
  ['clients.tree_sitter.enabled'] = false,
  ['clients.tags.enabled'] = false,
  ['display.preview.positions'] = {
    east = 1,
    north = 3,
    south = 4,
    west = 2,
  },
}

function M.before()
  vim.g.coq_settings = config
end

function M.after()
  local imap = require('cnull.core.keymap').imap

  imap(
    '<C-y>',
    [[pumvisible() ? (complete_info().selected == -1 ? "\<C-e><C-y>" : "\<C-y>") : "\<C-y>"]],
    { expr = true }
  )
end

return M
