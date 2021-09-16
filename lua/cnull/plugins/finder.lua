local M = {
  plugins = {},
}

if _G.CNull.config.finder == 'telescope' then
  M.plugins = { {'nvim-telescope/telescope.nvim'} }
  M.after = function()
    require('cnull.plugins.finders.telescope')
  end
elseif _G.CNull.config.finder == 'snap' then
  M.plugins = { {'camspiers/snap'} }
  M.after = function()
    require('cnull.plugins.finders.snap')
  end
else
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
