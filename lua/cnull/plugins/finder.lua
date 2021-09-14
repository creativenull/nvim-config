-- Choose one: telescope, snap, fzf (default)
local finder = 'telescope'

local M = {
  plugins = {},
}

if finder == 'telescope' then
  M.plugins = { {'nvim-telescope/telescope.nvim'} }
  M.after = function()
    require('cnull.plugins.finders.telescope')
  end
elseif finder == 'snap' then
  M.plugins = { {'camspiers/snap'} }
  M.after = function()
    require('cnull.plugins.finders.snap')
  end
else
  finder = 'fzf'
  M.plugins = {
    {'junegunn/fzf'},
    {'junegunn/fzf.vim'},
  }
  M.before = function()
    require('cnull.plugins.finders.fzf').before()
  end
  M.after = function()
    require('cnull.plugins.finders.fzf').after()
  end
end

return M
