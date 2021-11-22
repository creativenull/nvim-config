local M = {
  plugins = {
    -- galaxyline.nvim
    -- { 'NTBBloodbath/galaxyline.nvim' },

    -- feline.nvim
    {'famiu/feline.nvim', tag = 'v0.3.3'},

    -- lualine
    -- { 'nvim-lualine/lualine.nvim' },
  },
}

function M.after()
  -- galaxyline.nvim Config
  -- ---
  -- require('cnull.plugins.statuslines.galaxyline')

  -- feline.nvim Config
  -- ---
  require('cnull.plugins.statuslines.feline')

  -- lualine.nvim Config
  -- ---
  -- require('cnull.plugins.statuslines.lualine')
end

return M
