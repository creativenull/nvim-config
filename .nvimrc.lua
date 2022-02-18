-- Powered by projectlocal-vim
-- https://github.com/creativenull/projectlocal-vim
require('cnull.lsp').setup({ 'lua' })
local ok, dlsconfig = pcall(require, 'diagnosticls-configs')
if ok then
  dlsconfig.setup({
    lua = {
      linter = require('diagnosticls-configs.linters.luacheck'),
      formatter = require('diagnosticls-configs.formatters.stylua'),
    },
  })
end
