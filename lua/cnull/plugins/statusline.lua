-- Choose one: galaxyline, lualine (default)
local statusline = 'lualine'

local M = {
  plugins = {},
}

if statusline == 'galaxyline' then
  M.plugins = { {'glepnir/galaxyline.nvim'} }
else
  statusline = 'lualine'
  M.plugins = { {'hoob3rt/lualine.nvim'} }
end

function M.after()
  if statusline == 'galaxyline' then
    require('cnull.plugins.ui.galaxyline')
  end

  if statusline == 'lualine' then
    require('cnull.plugins.ui.lualine')
  end
end

return M
