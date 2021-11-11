local pyright_exec = 'pyright-langserver'
if vim.fn.executable(pyright_exec) == 0 then
  vim.api.nvim_err_writeln(string.format('lsp: %q is not installed', pyright_exec))
  return
end

require('cnull.core.lsp').setup('pyright')
