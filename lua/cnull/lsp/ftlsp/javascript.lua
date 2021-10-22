local tsserver_exec = 'typescript-language-server'
if vim.fn.executable(tsserver_exec) == 0 then
  vim.api.nvim_err_writeln(string.format('lsp: %q is not installed', tsserver_exec))
  return
end

local deno_exec = 'deno'
if vim.fn.executable(deno_exec) == 0 then
  vim.api.nvim_err_writeln(string.format('lsp: %q is not installed`', deno_exec))
  return
end

local root_pattern = require('lspconfig').util.root_pattern
local filetypes = { 'javascript', 'javascriptreact', 'javascript.jsx' }
local node_root = vim.fn.getcwd() .. '/package.json'
local deno_root = vim.fn.getcwd() .. '/import_map.json'

local is_node = vim.fn.filereadable(node_root) == 1
local is_deno = vim.fn.filereadable(deno_root) == 1

if is_node then
  -- Run tsserver only on Nodejs projects
  require('cnull.core.lsp').setup('tsserver', {
    filetypes = filetypes,
    root_dir = root_pattern('package.json', 'jsconfig.json'),
    flags = {
      debounce_text_changes = 500,
    },
  })
elseif is_deno then
  -- Run denols only on Deno projects
  require('cnull.core.lsp').setup('denols', {
    filetypes = filetypes,
    root_dir = root_pattern('deno.json', 'deno.jsonc'),
    init_options = {
      enable = true,
      lint = true,
      unstable = true,
      importMap = deno_root,
    },
    flags = { debounce_text_changes = 500 },
  })
end
