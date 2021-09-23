local augroup = require('cnull.core.event').augroup
local imap = require('cnull.core.keymap').imap

local config = {
  ['auto_start'] = false,
  ['keymap.recommended'] = false,
  ['keymap.jump_to_mark'] = '<C-j>',
  ['keymap.manual_complete'] = '<C-Space>',
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

imap('<Tab>', 'pumvisible() ? (complete_info().selected == -1 ? "\\<C-e><Tab>" : "\\<C-y>") : "\\<Tab>"', { expr = true})

augroup('coq_user_events', {
  {
    event = 'FileType',
    exec = function()
      vim.g.coq_settings = config
      vim.cmd('packadd coq_nvim')
      vim.cmd('packadd coq.artifacts')
      pcall(vim.cmd, 'COQnow')
    end,
  },
})

