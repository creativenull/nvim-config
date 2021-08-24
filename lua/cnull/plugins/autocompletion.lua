local M = {
  plugins = {
    -- {'hrsh7th/nvim-compe'},
    {'ms-jpq/coq_nvim', branch = 'coq'},
    {'ms-jpq/coq.artifacts', branch = 'artifacts'},
  },
}

function M.before()
  -- coq_nvim Config
  -- ---
  vim.g.coq_settings = {
    ['auto_start'] = false,
    ['keymap.recommended'] = false,
    ['keymap.jump_to_mark'] = '<C-j>',
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
end

--[[ function M.after()
  local imap = require('cnull.core.keymap').imap

  -- compe.nvim Config
  -- ---
  require('compe').setup({
    source = {
      nvim_lsp  = true,
      ultisnips = true,
    },
  })

  vim.opt.pumheight = 10

  imap('<C-Space>', [=[compe#complete()]=], { expr = true, noremap = false })
  imap('<Tab>', [=[compe#confirm('<Tab>')]=], { expr = true, noremap = false })
end ]]

return M
