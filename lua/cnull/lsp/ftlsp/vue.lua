local vls_exec = 'vls'
if vim.fn.executable(vls_exec) == 0 then
  vim.api.nvim_err_writeln(string.format('lsp: %q is not installed', vls_exec))
  return
end

local volar_exec = 'volar-server'
if vim.fn.executable(volar_exec) == 0 then
  vim.api.nvim_err_writeln(string.format('lsp: %q is not installed', volar_exec))
  return
end

local root_pattern = require('lspconfig').util.root_pattern

-- Vue 2 Project
local vue = {}
vue.root = vim.fn.getcwd() .. '/vue.config.js'
vue.is_project = vim.fn.filereadable(vue.root) == 1
vue.root_patterns = root_pattern('vue.config.js')

-- Vue 3 Project
local vue_next = {}
vue_next.root = vim.fn.getcwd() .. '/vite.config.js'
vue_next.is_project = vim.fn.filereadable(vue_next.root) == 1
vue_next.root_patterns = root_pattern('vite.config.js')

if vue.is_project then
  require('cnull.core.lsp').setup('vuels', {
    root_dir = vue.root_patterns,
    init_options = {
      config = {
        css = {},
        emmet = {},
        html = {
          suggest = {},
        },
        javascript = {
          format = {},
        },
        stylusSupremacy = {},
        typescript = {
          format = {},
        },
        vetur = {
          completion = {
            autoImport = false,
            tagCasing = 'kebab',
            useScaffoldSnippets = false,
          },
          format = {
            defaultFormatter = {
              js = 'none',
              ts = 'none',
            },
            defaultFormatterOptions = {},
            scriptInitialIndent = false,
            styleInitialIndent = false,
          },
          useWorkspaceDependencies = false,
          validation = {
            script = true,
            style = true,
            template = true,
          },
        },
      },
    },
  })
elseif vue_next.is_project then
  require('cnull.core.lsp').setup('volar', {
    root_dir = vue_next.root_patterns,
  })
end
