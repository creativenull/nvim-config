-- Choose one: telescope, snap, fzf (default)
local finder = 'telescope'

local M = {
  plugins = {},
}

if finder == 'telescope' then
  M.plugins = { {'nvim-telescope/telescope.nvim'} }
elseif finder == 'snap' then
  M.plugins = { {'camspiers/snap'} }
else
  finder = 'fzf'
  M.plugins = {
    {'junegunn/fzf'},
    {'junegunn/fzf.vim'},
  }
end

function M.before()
  -- fzf.vim Config
  -- ---
  if finder == 'fzf' then
    require('cnull.plugins.finders.fzf').before()
  end
end

function M.after()
  -- fzf.vim Config
  -- ---
  if finder == 'fzf' then
    require('cnull.plugins.finders.fzf').after()
  end

  -- telescope.nvim Config
  -- ---
  if finder == 'telescope' then
    require('cnull.plugins.finders.telescope')
  end

  -- snap Config
  -- ---
  if finder == 'snap' then
    require('cnull.plugins.finders.snap')
  end
end

return M
