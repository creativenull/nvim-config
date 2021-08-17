local imap = require('cnull.core.keymap').imap

vim.g.coq_settings = {
  ['keymap.recommended'] = false,
  ['keymap.jump_to_mark'] = '<C-j>',
  ['clients.tmux.enabled'] = false,
  ['clients.tree_sitter.enabled'] = false,
  ['clients.tags.enabled'] = false,
  ['display.preview.positions'] = {
    east = 1,
    north = 2,
    south = 3,
    west = 4,
  },
}

-- imap('<Tab>', [[pumvisible() ? "\<C-y>" : "\<Tab>"]], { expr = true, silent = true })
imap('<Tab>', [=[pumvisible() ? (complete_info().selected == -1 ? "\<C-e><Tab>" : "\<C-y>") : "\<Tab>"]=], { expr = true, silent = true})

vim.cmd([[COQnow --shut-up]])
