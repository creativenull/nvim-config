local M = {
  plugins = {
    -- telescope.nvim
    {'nvim-telescope/telescope.nvim'},

    -- snap
    -- {'camspiers/snap'},

    -- fzf
    -- {'junegunn/fzf'},
    -- {'junegunn/fzf.vim'},
  },
}

function M.before()
  -- fzf.vim Config
  -- ---
  -- require('cnull.plugins.finders.fzf').before()
end

function M.after()
  -- telescope.nvim Config
  -- ---
  require('cnull.plugins.finders.telescope')

  -- snap Config
  -- ---
  -- require('cnull.plugins.finders.snap')

  -- fzf.vim Config
  -- ---
  -- require('cnull.plugins.finders.fzf').after()
end

--[[ if _G.CNull.config.finder == 'telescope' then
  M.plugins = { {'nvim-telescope/telescope.nvim'} }
  M.after = function()
    pcall(require, 'cnull.plugins.finders.telescope')
  end
elseif _G.CNull.config.finder == 'snap' then
  M.plugins = { {'camspiers/snap'} }
  M.after = function()
    pcall(require, 'cnull.plugins.finders.snap')
  end
else
  M.plugins = {
    {'junegunn/fzf'},
    {'junegunn/fzf.vim'},
  }
  M.before = function()
    local success, fzf = pcall(require, 'cnull.plugins.finders.fzf')
    if success then
      fzf.before()
    end
  end
  M.after = function()
    local success, fzf = pcall(require, 'cnull.plugins.finders.fzf')
    if success then
      fzf.after()
    end
  end
end ]]

return M
