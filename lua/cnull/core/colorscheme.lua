local augroup = require('cnull.core.event').augroup
local M = {}

---Set transparent colors when on
---@param theme table
---@return nil
local function register_transparent_event(theme)
  if theme.enable_transparent_features then
    augroup('transparent_feature_user_events', {
      { event = 'ColorScheme', exec = 'highlight! SignColumn guibg=NONE' },
      { event = 'ColorScheme', exec = 'highlight! LineNr gui=NONE guibg=NONE' },
      { event = 'ColorScheme', exec = 'highlight! CursorLineNr guibg=NONE' },
      { event = 'ColorScheme', exec = 'highlight! Terminal guibg=NONE' },
      { event = 'ColorScheme', exec = 'highlight! EndOfBuffer guibg=NONE' },
      { event = 'ColorScheme', exec = 'highlight! FoldColumn guibg=NONE' },
      { event = 'ColorScheme', exec = 'highlight! Folded guibg=NONE' },
      { event = 'ColorScheme', exec = 'highlight! ToolbarLine guibg=NONE' },
      { event = 'ColorScheme', exec = 'highlight! FloatBorder guifg=#eeeeee guibg=NONE' },
      { event = 'ColorScheme', exec = 'highlight! NormalFloat guibg=NONE' },
    })
  end

  if theme.enable_custom_visual_hl then
    augroup('visual_hl_user_events', {
      { event = 'ColorScheme', exec = 'highlight! Visual guibg=#dddddd guifg=#333333' },
    })
  end
end

---Set the colorscheme of vim
---@param theme table
---@return nil
local function set_colorscheme(theme)
  -- Before colorshceme is set
  if theme.on_before then
    theme.on_before()
  end

  vim.opt.number = true
  vim.opt.termguicolors = true
  vim.api.nvim_command(string.format('colorscheme %s', theme.name))

  if vim.g.colors_name ~= theme.name then
    vim.g.colors_name = theme.name
  end

  -- After colorshceme is set
  if theme.on_after then
    theme.on_after()
  end
end

---Colorscheme setup for transparency and theme
---@param cfg table
---@return nil
function M.setup(cfg)
  local theme = cfg.theme

  register_transparent_event(theme)
  set_colorscheme(theme)
end

return M
