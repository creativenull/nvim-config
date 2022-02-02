local M = {
  plugins = {
    { 'bluz71/vim-moonfly-colors' },
    { 'norcalli/nvim-colorizer.lua' },
    { 'bluz71/vim-nightfly-guicolors' },
    { 'marko-cerovac/material.nvim' },
    { 'EdenEast/nightfox.nvim' },
    { 'catppuccin/nvim' },
    { 'eddyekofo94/gruvbox-flat.nvim' },
    { 'rebelot/kanagawa.nvim' },
    { 'ray-x/starry.nvim' },
  },
}

function M.after()
  local augroup = require('cnull.core.event').augroup

  -- nvim-colorizer.lua Config
  -- ---
  augroup('user_colorizer_events', {
    {
      event = 'ColorScheme',
      exec = function()
        require('colorizer').setup({ 'html', 'css', 'javascriptreact', 'typescriptreact', 'lua' })
      end,
    },
  })

  -- catppuccin Config
  -- ---
  -- require('catppuccin').setup()
end

return M
