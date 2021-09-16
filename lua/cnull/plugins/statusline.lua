local M = {
  plugins = {},
}

if _G.CNull.config.statusline == 'galaxyline' then
  M.plugins = { {'glepnir/galaxyline.nvim'} }
  M.after = function()
    require('cnull.plugins.ui.galaxyline')
  end
else
  M.plugins = { {'hoob3rt/lualine.nvim'} }
  M.after = function()
    require('cnull.plugins.ui.lualine')
  end
end

return M
