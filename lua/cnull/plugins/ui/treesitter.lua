require('nvim-treesitter.configs').setup({
  ensure_installed = {
    'css',
    'graphql',
    'html',
    'javascript',
    'php',
    'typescript',
    'vue',
    -- 'lua',
  },
  highlight = { enable = true },
  indent = { enable = false },
  refactor = {
    highlight_definitions = { enable = true },
  },
})
