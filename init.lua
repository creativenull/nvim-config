-- Name: Arnold Chand
-- Github: https://github.com/creativenull
-- My vimrc, pre-requisites:
-- + python3
-- + nnn
-- + ripgrep
-- + bat
-- + Environment variables:
--   + $PYTHON3_HOST_PROG
--
-- Currently, tested on a Linux machine (maybe macOS, Windows is a bit of a stretch)
-- =============================================================================

-- Load packages on the filetype event in `after/ftplugin`
function _G.LoadCommonPackages()
  vim.cmd('packadd vim-abolish')
  vim.cmd('packadd vim-surround')
  vim.cmd('packadd kommentary')
  vim.cmd('packadd ultisnips')
  vim.cmd('packadd vim-snippets')

  vim.cmd('packadd indent-blankline.nvim')
  require('cnull.plugins.ui.indent_blankline')

  vim.cmd('packadd todo-comments.nvim')
  require('todo-comments').setup()

  require('cnull.plugins.autocompletion.coq')
end

-- Initialize
local core = require('cnull.core')
core.setup({
  config = {
    leader = ' ',

    theme = {
      name = 'moonfly',
      transparent = false,

      -- Events
      on_before = function()
        vim.g.nightfox_italic_comments = true
      end,
    },

    plugins_config = {
      init = {
        compile_path = string.format('%s/packer_compiled.lua', vim.fn.stdpath('data')),
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

    -- coq_nvim Config
    -- ---
    vim.g.coq_settings = {
      ['auto_start'] = false,
      ['keymap.recommended'] = false,
      ['keymap.jump_to_mark'] = '<C-j>',
      ['clients.tmux.enabled'] = false,
      ['clients.tree_sitter.enabled'] = false,
      ['clients.tags.enabled'] = false,
      ['display.preview.positions'] = {
        east = 1,
        north = 3,
        south = 4,
        west = 2,
      },
    }
  end,

  on_after = function()
    require('cnull.user.keymaps')
    require('cnull.user.conceal')
    require('cnull.user.codeshot')
    require('cnull.user.options')
    require('cnull.user.commands')
  end,
})
