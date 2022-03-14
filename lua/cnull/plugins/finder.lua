local M = {
  plugins = {
    -- telescope.nvim
    { 'nvim-telescope/telescope.nvim' },

    -- snap
    -- {'camspiers/snap'},

    -- fzf
    -- {'junegunn/fzf'},
    -- {'junegunn/fzf.vim'},
  },
}

function M.before()
  -- fzf.vim Config
  -- ---
  -- require('cnull.plugins.finders.fzf').before()
end

function M.after()
  -- telescope.nvim Config
  -- ---
  require('cnull.plugins.finders.telescope')

  -- snap Config
  -- ---
  -- require('cnull.plugins.finders.snap')

  -- fzf.vim Config
  -- ---
  -- require('cnull.plugins.finders.fzf').after()
end

return M
