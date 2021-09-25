local M = {
  plugins = {},
}

if _G.CNull.config.statusline == 'galaxyline' then
  M.plugins = { {'glepnir/galaxyline.nvim'} }
  M.after = function()
    require('cnull.plugins.statuslines.galaxyline')
  end
elseif _G.CNull.config.statusline == 'feline' then
  M.plugins = { {'famiu/feline.nvim', tag = 'v0.2'} }
  M.after = function()
    require('cnull.plugins.statuslines.feline')
  end
else
  M.plugins = { {'hoob3rt/lualine.nvim'} }
  M.after = function()
    require('cnull.plugins.statuslines.lualine')
  end
end

return M
