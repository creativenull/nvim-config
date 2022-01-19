-- Name: Arnold Chand
-- Github: https://github.com/creativenull
-- My vimrc, tested on Linux and Windows
-- + python3
-- + ripgrep
-- + bat
-- =============================================================================

-- Initialize
local core = require('cnull.core')
core.setup({
  config = {
    -- Leader key
    leader = ' ',

    -- Colorscheme config
    theme = {
      name = 'kanagawa',
      enable_transparent_features = true,
      enable_custom_visual_hl = true,
      on_before = function()
        -- moonfly
        vim.g.moonflyNormalFloat = true

        -- gruvbox
        vim.g.gruvbox_flat_style = 'hard'
        vim.g.gruvbox_transparent = true

        -- kanagawa
        require('kanagawa').setup({
          transparent = true,
          commentStyle = 'NONE',
        })
      end,
    },

    -- Adjust packer config
    plugins = {
      init = {
        compile_path = vim.fn.stdpath('data') .. '/packer_compiled.lua',
      },
    },
  },

  -- Events
  on_before = function()
    local autocmd = require('cnull.core.event').autocmd

    -- Highlight text yank
    autocmd({
      clear = true,
      event = 'TextYankPost',
      exec = function()
        vim.highlight.on_yank({ higroup = 'Search', timeout = 500 })
      end,
    })
  end,

  on_after = function()
    require('cnull.user.keymaps')
    require('cnull.user.options')
    require('cnull.user.abbreviations')

    -- Custom user commands
    require('cnull.user.conceal')
    require('cnull.user.codeshot')
  end,
})
