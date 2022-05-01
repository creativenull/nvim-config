local M = {
  plugins = {
    -- { 'tamago324/lir.nvim' },

    { 'MunifTanjim/nui.nvim' },
    { 'nvim-neo-tree/neo-tree.nvim', branch = 'v2.x' },
  },
}

function M.after()
  -- lir Config
  -- ---
  -- require('cnull.plugins.explorers.lir')

  -- neo-tree Config
  -- ---
  require('cnull.plugins.explorers.neotree')
end

return M
