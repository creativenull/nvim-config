-- Name: Arnold Chand
-- Github: https://github.com/creativenull
-- My vimrc, tested on Linux and Windows
-- + python3
-- + ripgrep
-- + bat
-- + curl
-- + deno
-- =============================================================================

-- Initialize
local core = require('cnull.core')
core.setup({
  config = {
    -- Leader key
    leader = ' ',

    -- Colorscheme config
    theme = {
      name = 'nightfly',
      enable_transparent_features = false,
      enable_custom_visual_hl = false,
      on_before = function()
        -- moonfly
        vim.g.moonflyNormalFloat = true
        vim.g.moonflyTransparent = true

        -- nightfly
        vim.g.nightflyNormalFloat = true
        vim.g.nightflyTransparent = true

        -- gruvbox
        vim.g.gruvbox_flat_style = 'hard'
        vim.g.gruvbox_transparent = true

        -- starry
        vim.g.starry_disable_background = true

        -- material
        vim.g.material_style = 'deep ocean'

        -- kanagawa
        -- require('kanagawa').setup({
        --   transparent = true,
        --   commentStyle = 'NONE',
        -- })

        -- catppuccin
        -- require('catppuccin').setup({
        --   transparent_background = true,
        --   styles = {
        --     comments = 'NONE',
        --   },
        -- })
      end,
    },

    -- Adjust packer config
    plugins = {
      init = {
        compile_path = vim.fn.stdpath('data') .. '/site/plugin/packer_compiled.lua',
      },
    },
  },

  -- Events
  on_before = function()
    local autocmd = require('cnull.core.event').autocmd

    -- Highlight text yank
    autocmd({
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
