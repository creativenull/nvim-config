-- Choose one: galaxyline, lualine (default)
local statusline = 'lualine'

local M = {
  plugins = {},
}

if statusline == 'galaxyline' then
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
